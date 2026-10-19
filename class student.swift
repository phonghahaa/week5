// Define a Student class that conforms to the Identifiable protocol
class Student: Identifiable {

    // Unique identifier for each student
    var id: String

    // Store the student's name
    var name: String

    // Store the student's age
    var age: Int

    // Initialize a new Student object with id, name, and age
    init(id: String, name: String, age: Int) {
        // Assign the provided id to the student's id property
        self.id = id

        // Assign the provided name to the student's name property
        self.name = name

        // Assign the provided age to the student's age property
        self.age = age
    }

    // Return the student's information as a formatted string
    func displayInfo() -> String {
        // Combine id, name, and age into one readable string
        "\(id) - \(name), Age: \(age)"
    }
}

