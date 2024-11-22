import tkinter as tk
from tkinter import ttk
from tkinter import messagebox
from tkcalendar import DateEntry
from datetime import datetime


def manage_inmates_window(conn):
    c = conn.cursor()

    # Add inmate data to the database
    def add_inmate():
        first_name = entry_first_name.get()
        last_name = entry_last_name.get()
        try:
            age = int(entry_age.get())
        except ValueError:
            messagebox.showwarning("Input Error", "Please enter a valid age!")
            return
        gender = entry_gender.get()
        city = entry_city.get()
        state = entry_state.get()

        admission = entry_admission.get_date()

        try:
            facility_id = int(entry_facility_id.get())
        except ValueError:
            messagebox.showwarning(
                "Input Error", "Please enter a valid Facility ID!")
            return

        ethnicity = entry_ethnicity.get()

        if first_name and last_name and age and gender and city and state and admission and facility_id and ethnicity:
            c.execute('EXEC InmateManagement.InsertInmate @FirstName = ?, @LastName = ?, @Age = ?, @Gender = ?, @City = ?, @State = ?, @AdmissionDate = ?, @FacilityID = ?, @Ethnicity = ?;',
                      (first_name, last_name, age, gender, city, state, admission, facility_id, ethnicity))
            conn.commit()
            messagebox.showinfo("Success", "Inmate added successfully!")
            clear_entries()
        else:
            messagebox.showwarning("Input Error", "Please fill all fields!")

    # Fetch data from the database and display it
    def fetch_data():
        for i in tree.get_children():
            tree.delete(i)
        c.execute('SELECT * FROM InmateManagement.Inmates;')
        rows = c.fetchall()
        for row in rows:
            tree.insert('', 'end', values=row)

    # Clear input fields
    def clear_entries():
        entry_first_name.delete(0, tk.END)
        entry_last_name.delete(0, tk.END)
        entry_age.delete(0, tk.END)
        entry_gender.delete(0, tk.END)
        entry_city.delete(0, tk.END)
        entry_state.delete(0, tk.END)
        entry_admission.set_date('')  # Reset admission date
        entry_facility_id.delete(0, tk.END)
        entry_ethnicity.delete(0, tk.END)

    # Create the main window
    root = tk.Tk()
    root.title("Inmates Management")
    root.geometry("900x700")
    root.config(bg="#F4F4E2")

    # Main Frame
    frame = tk.Frame(root, bg="#F4F4E2")
    frame.pack(pady=10)

    # Title Label
    label_title = tk.Label(frame, text="INMATES MANAGEMENT",
                           font=("Helvetica", 16, "bold"), bg="#F4F4E2")
    label_title.grid(row=0, column=0, columnspan=2, padx=10, pady=10)

    # First Name
    label_first_name = tk.Label(frame, text="First Name", bg="#F4F4E2")
    label_first_name.grid(row=1, column=0, padx=10, pady=5, sticky="w")
    entry_first_name = tk.Entry(frame, width=30)
    entry_first_name.grid(row=1, column=1, padx=10, pady=5)

    # Last Name
    label_last_name = tk.Label(frame, text="Last Name", bg="#F4F4E2")
    label_last_name.grid(row=2, column=0, padx=10, pady=5, sticky="w")
    entry_last_name = tk.Entry(frame, width=30)
    entry_last_name.grid(row=2, column=1, padx=10, pady=5)

    # Age
    label_age = tk.Label(frame, text="Age", bg="#F4F4E2")
    label_age.grid(row=3, column=0, padx=10, pady=5, sticky="w")
    entry_age = tk.Entry(frame, width=30)
    entry_age.grid(row=3, column=1, padx=10, pady=5)

    # Gender
    label_gender = tk.Label(frame, text="Gender", bg="#F4F4E2")
    label_gender.grid(row=4, column=0, padx=10, pady=5, sticky="w")
    entry_gender = tk.Entry(frame, width=30)
    entry_gender.grid(row=4, column=1, padx=10, pady=5)

    # City
    label_city = tk.Label(frame, text="City", bg="#F4F4E2")
    label_city.grid(row=5, column=0, padx=10, pady=5, sticky="w")
    entry_city = tk.Entry(frame, width=30)
    entry_city.grid(row=5, column=1, padx=10, pady=5)

    # State
    label_state = tk.Label(frame, text="State", bg="#F4F4E2")
    label_state.grid(row=6, column=0, padx=10, pady=5, sticky="w")
    entry_state = tk.Entry(frame, width=30)
    entry_state.grid(row=6, column=1, padx=10, pady=5)

    # Admission Date
    label_admission = tk.Label(frame, text="Admission Date", bg="#F4F4E2")
    label_admission.grid(row=7, column=0, padx=10, pady=5, sticky="w")
    entry_admission = DateEntry(
        frame, width=17, background="darkblue", foreground="white", borderwidth=2, year=2024)
    entry_admission.grid(row=7, column=1, padx=10, pady=5)

    # Facility ID
    label_facility_id = tk.Label(frame, text="Facility ID", bg="#F4F4E2")
    label_facility_id.grid(row=8, column=0, padx=10, pady=5, sticky="w")
    entry_facility_id = tk.Entry(frame, width=30)
    entry_facility_id.grid(row=8, column=1, padx=10, pady=5)

    # Ethnicity
    label_ethnicity = tk.Label(frame, text="Ethnicity", bg="#F4F4E2")
    label_ethnicity.grid(row=9, column=0, padx=10, pady=5, sticky="w")
    entry_ethnicity = tk.Entry(frame, width=30)
    entry_ethnicity.grid(row=9, column=1, padx=10, pady=5)

    # Buttons
    button_add = tk.Button(frame, text="Add", command=add_inmate,
                           bg="#E77B71", fg="white", width=10)
    button_add.grid(row=10, column=0, padx=10, pady=10)

    button_fetch = tk.Button(
        frame, text="Fetch", command=fetch_data, bg="#6D84A1", fg="white", width=10)
    button_fetch.grid(row=10, column=1, padx=10, pady=10)

    # Table for displaying inmates data
    tree_frame = tk.Frame(root, bg="#F4F4E2")
    tree_frame.pack(pady=10)

    tree_scroll = tk.Scrollbar(tree_frame)
    tree_scroll.pack(side=tk.RIGHT, fill=tk.Y)

    tree = ttk.Treeview(tree_frame, columns=("ID", "First Name", "Last Name", "Age", "Gender", "City",
                        "State", "Admission Date", "Facility ID", "Ethnicity"), show="headings", yscrollcommand=tree_scroll.set, height=10)
    tree.pack()

    tree_scroll.config(command=tree.yview)

    tree.heading("ID", text="ID")
    tree.heading("First Name", text="First Name")
    tree.heading("Last Name", text="Last Name")
    tree.heading("Age", text="Age")
    tree.heading("Gender", text="Gender")
    tree.heading("City", text="City")
    tree.heading("State", text="State")
    tree.heading("Admission Date", text="Admission Date")
    tree.heading("Facility ID", text="Facility ID")
    tree.heading("Ethnicity", text="Ethnicity")

    tree.column("ID", width=40)
    tree.column("First Name", width=100)
    tree.column("Last Name", width=100)
    tree.column("Age", width=50)
    tree.column("Gender", width=50)
    tree.column("City", width=80)
    tree.column("State", width=80)
    tree.column("Admission Date", width=100)
    tree.column("Facility ID", width=100)
    tree.column("Ethnicity", width=100)

    root.mainloop()

    # Close the database connection on exit
    conn.close()
