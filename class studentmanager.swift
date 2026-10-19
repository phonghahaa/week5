import Combine
import SwiftUI

class StudentManager: ObservableObject {
    // Store the list of students and publish changes to SwiftUI
    @Published var students: [Student]

    // Store the list of subjects and publish changes to SwiftUI
    @Published var subjects: [Subject]

    // Store student grade records, initially an empty array
    @Published var records: [StudentRecord] = []

    // Initialize the student manager with sample data
    init() {
        // Create the list of students
        students = [
            Student(id: "SESEIU24021", name: "Phong", age: 20),
            Student(id: "SESEIU24023", name: "Tâm", age: 20),
            Student(id: "SESEIU24013", name: "Khôi", age: 20),
            Student(id: "SESEIU24020", name: "Nguyên", age: 20)
        ]

        // Create the list of subjects with their IDs, names, and credits
        subjects = [
            Subject(id: "MA01", name: "Mathematics", credits: 4),
            Subject(id: "EE01", name: "Programming", credits: 4),
            Subject(id: "SE01", name: "Physics", credits: 2),
            Subject(id: "LE01", name: "English", credits: 2)
        ]

        // Create sample grade records for students and subjects
        records = [
            StudentRecord(student: students[0], subject: subjects[0], mark: 9.0),
            StudentRecord(student: students[0], subject: subjects[1], mark: 9.5),
            StudentRecord(student: students[0], subject: subjects[2], mark: 10.0),
            StudentRecord(student: students[1], subject: subjects[0], mark: 8.0),
            StudentRecord(student: students[1], subject: subjects[2], mark: 9.5),
            StudentRecord(student: students[2], subject: subjects[1], mark: 9.5),
            StudentRecord(student: students[2], subject: subjects[3], mark: 8.5),
            StudentRecord(student: students[3], subject: subjects[2], mark: 4.0),
            StudentRecord(student: students[3], subject: subjects[3], mark: 5.5)
        ]
    }

    // Get all grade records belonging to a specific student
    func records(for student: Student) -> [StudentRecord] {
        // Filter records by matching the student's ID
        records.filter { $0.student.id == student.id }
    }

    // Calculate the student's weighted average mark
    func average(for student: Student) -> Double {
        // Get all records for the selected student
        let list = records(for: student)

        // Calculate the total credits of the student's subjects
        let totalCredits = list.reduce(0) {
            $0 + $1.subject.credits
        }

        // Return 0 if the student has no credits
        guard totalCredits > 0 else { return 0 }

        // Calculate the total of marks multiplied by subject credits
        let total = list.reduce(0.0) {
            $0 + $1.mark * Double($1.subject.credits)
        }

        // Divide the weighted total by the total credits
        return total / Double(totalCredits)
    }

    // Determine the student's academic ranking
    func ranking(for student: Student) -> String {
        // Calculate the student's average mark
        let avg = average(for: student)

        // Return the ranking based on the average mark
        if avg >= 8.5 {
            return "Excellent"
        } else if avg >= 7.0 {
            return "Good"
        } else if avg >= 5.0 {
            return "Average"
        } else {
            return "Fail"
        }
    }

    // Update the mark of an existing grade record
    func updateMark(for record: StudentRecord, to mark: Double) {
        // Accept only marks between 0 and 10
        guard (0...10).contains(mark) else { return }

        // Assign the new mark to the record
        record.mark = mark

        // Notify SwiftUI that the data is about to change
        objectWillChange.send()
    }

    // Add a new grade record for a student and a subject
    func addRecord(student: Student, subject: Subject, mark: Double) {
        // Check whether the mark is within the valid range
        guard (0...10).contains(mark) else { return }

        // Check if the student already has a record for this subject
        let exists = records.contains {
            $0.student.id == student.id &&
            $0.subject.id == subject.id
        }

        // Stop if a record for this student and subject already exists
        guard !exists else { return }

        // Create a new grade record and add it to the array
        records.append(
            StudentRecord(student: student, subject: subject, mark: mark)
        )
    }
}

