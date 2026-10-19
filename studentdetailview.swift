import SwiftUI

struct StudentDetailView: View {
    // Store the student whose details will be displayed
    let student: Student

    // Observe the StudentManager to receive updates when data changes
    @ObservedObject var manager: StudentManager

    // Define the user interface for the student detail screen
    var body: some View {
        // Display the content in a scrollable list
        List {
            // Section showing the student's basic information
            Section("Student Information") {
                // Display the student's ID
                LabeledContent("ID", value: student.id)

                // Display the student's name
                LabeledContent("Name", value: student.name)

                // Display the student's age as a String
                LabeledContent("Age", value: "\(student.age)")
            }

            // Section showing the student's grades for each subject
            Section("Academic Results") {
                // Loop through all grade records belonging to this student
                ForEach(manager.records(for: student)) { record in

                    // Arrange each subject's information vertically
                    VStack(alignment: .leading, spacing: 10) {
                        // Display the subject name and mark horizontally
                        HStack {
                            // Show the subject name in headline font
                            Text(record.subject.name)
                                .font(.headline)

                            // Push the mark to the right side
                            Spacer()

                            // Display the mark with one decimal place
                            // Green indicates a pass; red indicates a fail
                            Text("\(record.mark, specifier: "%.1f")")
                                .foregroundStyle(
                                    record.isPassed() ? .green : .red
                                )
                        }

                        // Allow the user to increase or decrease the mark
                        Stepper(
                            // Display the current mark with one decimal place
                            "Mark: \(record.mark, specifier: "%.1f")",

                            // Create a Binding to read and update the mark
                            value: Binding(
                                // Get the current mark from the record
                                get: { record.mark },

                                // Update the mark when the Stepper changes
                                set: {
                                    manager.updateMark(
                                        for: record,
                                        to: $0
                                    )
                                }
                            ),

                            // Restrict the mark to a range from 0 to 10
                            in: 0...10,

                            // Increase or decrease the mark by 0.5 each time
                            step: 0.5
                        )

                        // Display whether the student passed or failed
                        Text(record.isPassed() ? "Passed" : "Failed")
                            // Use green for passed and red for failed
                            .foregroundStyle(
                                record.isPassed() ? .green : .red
                            )
                    }
                    // Add vertical padding around each subject's information
                    .padding(.vertical, 5)
                }
            }

            // Section summarizing the student's academic performance
            Section("Summary") {
                // Display the student's weighted average to two decimal places
                LabeledContent(
                    "Weighted Average",
                    value: String(
                        format: "%.2f",
                        manager.average(for: student)
                    )
                )

                // Display the student's academic ranking
                LabeledContent(
                    "Academic Ranking",
                    value: manager.ranking(for: student)
                )
            }
        }
        // Set the navigation bar title to the student's name
        .navigationTitle(student.name)
    }
}


