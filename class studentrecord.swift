class StudentRecord: Identifiable {
    // Generate a unique ID using the student's ID and subject's ID
    var id: String {
        "\(student.id)-\(subject.id)"
    }

    // Store the student associated with this grade record
    var student: Student

    // Store the subject associated with this grade record
    var subject: Subject

    // Store the mark privately to control how it can be changed
    private var storedMark: Double

    // Provide access to the mark with validation
    var mark: Double {
        // Return the current stored mark
        get { storedMark }

        // Set a new mark only if it is between 0 and 10
        set {
            if (0...10).contains(newValue) {
                storedMark = newValue
            }
        }
    }

    // Initialize a grade record with a student, subject, and mark
    init(student: Student, subject: Subject, mark: Double) {
        // Assign the student to this record
        self.student = student

        // Assign the subject to this record
        self.subject = subject

        // Limit the initial mark to the range from 0 to 10
        self.storedMark = min(10, max(0, mark))
    }

    // Check whether the student has passed the subject
    func isPassed() -> Bool {
        // Return true if the mark is at least 5.0; otherwise, return false
        mark >= 5.0
    }
}

