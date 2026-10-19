class Subject: Identifiable {
    // Unique identifier for each subject
    var id: String

    // Store the subject's name
    var name: String

    // Store the number of credits for the subject
    var credits: Int

    // Initialize a subject with its ID, name, and credits
    init(id: String, name: String, credits: Int) {
        // Assign the given ID to the subject
        self.id = id

        // Assign the given name to the subject
        self.name = name

        // Assign the given credit value to the subject
        self.credits = credits
    }

    // Return the subject's information as a formatted string
    func displayInfo() -> String {
        // Combine the subject name and credits into one string
        "\(name) (\(credits) credits)"
    }
}


