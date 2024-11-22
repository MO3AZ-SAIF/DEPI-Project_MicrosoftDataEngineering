import tkinter as tk
from tkinter import messagebox


def program_management_window(conn):
    # Create a database connection
    c = conn.cursor()

    # Function to Release inmate
    def add_program():
        inmate_id = entry_inmate_id.get()
        program_id = entry_program_id.get()

        if inmate_id and program_id:
            c.execute(
                'EXEC ProgramManagement.InsertParticipation @InmateID = ?, @ProgramID = ?;', (inmate_id, program_id))
            conn.commit()
            messagebox.showinfo("Success", "program added successfully!")
            clear_entries()
        else:
            messagebox.showwarning("Input Error", "Please fill all fields!")

    # Clear input fields
    def clear_entries():
        entry_inmate_id.delete(0, tk.END)
        entry_program_id.delete("0", tk.END)

    # Create the main window
    root = tk.Tk()
    root.title("Programs Management")
    root.geometry("400x400")
    root.config(bg="#F4F4E2")

    # Main Frame
    frame = tk.Frame(root, bg="#F4F4E2")
    frame.pack(pady=20)

    # Title Label
    label_title = tk.Label(frame, text="PROGRAMS MANAGEMENT", font=(
        "Helvetica", 16, "bold"), bg="#F4F4E2")
    label_title.grid(row=0, column=0, columnspan=2, padx=10, pady=10)

    # Set a common width for all input fields
    common_width = 30

    # Inmate ID
    label_inmate_id = tk.Label(frame, text="Inmate ID", bg="#F4F4E2")
    label_inmate_id.grid(row=1, column=0, padx=10, pady=10, sticky="w")
    entry_inmate_id = tk.Entry(frame, width=common_width)
    entry_inmate_id.grid(row=1, column=1, padx=10, pady=10)

    # Program ID
    label_program_id = tk.Label(frame, text="Program ID", bg="#F4F4E2")
    label_program_id.grid(row=2, column=0, padx=10, pady=10, sticky="w")
    entry_program_id = tk.Entry(frame, width=common_width)
    entry_program_id.grid(row=2, column=1, padx=10, pady=10)

    # Add Button
    button_add = tk.Button(frame, text="Add", command=add_program,
                           bg="#E77B71", fg="white", width=common_width-2)
    button_add.grid(row=4, column=0, columnspan=2, padx=10, pady=20)

    root.mainloop()

    # Close the database connection on exit
    conn.close()
