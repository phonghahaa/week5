import SwiftUI

struct ContentView: View {
    // Create and manage the StudentManager object for this view
    @StateObject private var manager = StudentManager()

    // Define the user interface
    var body: some View {
        // Create a navigation container to move between screens
        NavigationStack {
            // Display the content in a scrollable list
            List {
                // Section displaying all students
                Section("Students") {
                    // Loop through the student array
                    ForEach(manager.students) { student in

                        // Navigate to the detail screen when a student is selected
                        NavigationLink {
                            // Pass the selected student and manager to the detail view
                            StudentDetailView(
                                student: student,
                                manager: manager
                            )
                        } label: {
                            // Arrange each student's information vertically
                            VStack(alignment: .leading, spacing: 5) {
                                // Display the student's name
                                Text(student.name)
                                    .font(.headline)

                                // Display the student's ID, name, and age
                                Text(student.displayInfo())
                                    .font(.caption)
                                    .foregroundStyle(.secondary)

                                // Display the student's average mark and ranking
                                Text(
                                    "Average: \(manager.average(for: student), specifier: "%.2f") - \(manager.ranking(for: student))"
                                )
                                .font(.subheadline)
                            }
                            // Add vertical spacing around each student row
                            .padding(.vertical, 4)
                        }
                    }
                }

                // Section displaying all academic grade records
                Section("Academic Results") {
                    // Loop through every grade record
                    ForEach(manager.records) { record in

                        // Arrange the student, subject, and grade horizontally
                        HStack {
                            // Display the student's name and subject information
                            VStack(alignment: .leading) {
                                // Show the name of the student
                                Text(record.student.name)
                                    .font(.headline)

                                // Show the subject name in secondary text style
                                Text(record.subject.name)
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                            }

                            // Push the grade and result to the right
                            Spacer()

                            // Display the mark with one decimal place
                            // Green indicates a pass, while red indicates a fail
                            Text("\(record.mark, specifier: "%.1f")")
                                .foregroundStyle(
                                    record.isPassed() ? .green : .red
                                )

                            // Display Pass or Fail based on the student's mark
                            Text(record.isPassed() ? "Pass" : "Fail")
                                .font(.caption)
                        }
                    }
                }
            }
            // Set the title displayed in the navigation bar
            .navigationTitle("Student Manager")
        }
    }
}



