namespace WA_BG
{
    partial class MainForm
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(MainForm));
            this.uiRunButton = new System.Windows.Forms.Button();
            this.listBox1 = new System.Windows.Forms.ListBox();
            this.uiStopButton = new System.Windows.Forms.Button();
            this.uiShortcuts = new System.Windows.Forms.ListView();
            this.columnHeaderShortcut = ((System.Windows.Forms.ColumnHeader)(new System.Windows.Forms.ColumnHeader()));
            this.columnHeaderTimeout = ((System.Windows.Forms.ColumnHeader)(new System.Windows.Forms.ColumnHeader()));
            this.columnHeaderColor = ((System.Windows.Forms.ColumnHeader)(new System.Windows.Forms.ColumnHeader()));
            this.columnHeaderComment = ((System.Windows.Forms.ColumnHeader)(new System.Windows.Forms.ColumnHeader()));
            this.label1 = new System.Windows.Forms.Label();
            this.label2 = new System.Windows.Forms.Label();
            this.uiRemoveShortcutButton = new System.Windows.Forms.Button();
            this.uiAddShortcutButton = new System.Windows.Forms.Button();
            this.uiSaveButton = new System.Windows.Forms.Button();
            this.uiLoadButton = new System.Windows.Forms.Button();
            this.uiEditShortcutButton = new System.Windows.Forms.Button();
            this.uiOpenProfileDialog = new System.Windows.Forms.OpenFileDialog();
            this.uiSaveProfileDialog = new System.Windows.Forms.SaveFileDialog();
            this.uiSaveAsButton = new System.Windows.Forms.Button();
            this.uiDuplicateButton = new System.Windows.Forms.Button();
            this.uiCheckInterval = new System.Windows.Forms.NumericUpDown();
            this.label3 = new System.Windows.Forms.Label();
            this.menuStrip1 = new System.Windows.Forms.MenuStrip();
            this.fileToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.newToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.openToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.toolStripSeparator = new System.Windows.Forms.ToolStripSeparator();
            this.saveToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.saveAsToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.toolStripSeparator1 = new System.Windows.Forms.ToolStripSeparator();
            this.exitToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.editToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.undoToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.redoToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.toolStripSeparator3 = new System.Windows.Forms.ToolStripSeparator();
            this.cutToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.copyToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.pasteToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.toolStripSeparator4 = new System.Windows.Forms.ToolStripSeparator();
            this.selectAllToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.addShortcutToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.removeShortcutToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.editShortcutToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.duplicateToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.toolsToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.runToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.stopToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.optionsToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.helpToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.contentsToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.indexToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.searchToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.toolStripSeparator5 = new System.Windows.Forms.ToolStripSeparator();
            this.aboutToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            ((System.ComponentModel.ISupportInitialize)(this.uiCheckInterval)).BeginInit();
            this.menuStrip1.SuspendLayout();
            this.SuspendLayout();
            // 
            // uiRunButton
            // 
            this.uiRunButton.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.uiRunButton.Location = new System.Drawing.Point(706, 27);
            this.uiRunButton.Name = "uiRunButton";
            this.uiRunButton.Size = new System.Drawing.Size(60, 23);
            this.uiRunButton.TabIndex = 0;
            this.uiRunButton.Text = "&Run";
            this.uiRunButton.UseVisualStyleBackColor = true;
            this.uiRunButton.Click += new System.EventHandler(this.uiRunButton_Click);
            // 
            // listBox1
            // 
            this.listBox1.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this.listBox1.FormattingEnabled = true;
            this.listBox1.Location = new System.Drawing.Point(579, 77);
            this.listBox1.Name = "listBox1";
            this.listBox1.Size = new System.Drawing.Size(253, 576);
            this.listBox1.TabIndex = 1;
            // 
            // uiStopButton
            // 
            this.uiStopButton.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.uiStopButton.Enabled = false;
            this.uiStopButton.Location = new System.Drawing.Point(772, 27);
            this.uiStopButton.Name = "uiStopButton";
            this.uiStopButton.Size = new System.Drawing.Size(60, 23);
            this.uiStopButton.TabIndex = 2;
            this.uiStopButton.Text = "&Stop";
            this.uiStopButton.UseVisualStyleBackColor = true;
            this.uiStopButton.Click += new System.EventHandler(this.uiStopButton_Click);
            // 
            // uiShortcuts
            // 
            this.uiShortcuts.Anchor = ((System.Windows.Forms.AnchorStyles)((((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom) 
            | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this.uiShortcuts.Columns.AddRange(new System.Windows.Forms.ColumnHeader[] {
            this.columnHeaderShortcut,
            this.columnHeaderTimeout,
            this.columnHeaderColor,
            this.columnHeaderComment});
            this.uiShortcuts.FullRowSelect = true;
            this.uiShortcuts.GridLines = true;
            this.uiShortcuts.Location = new System.Drawing.Point(12, 77);
            this.uiShortcuts.Name = "uiShortcuts";
            this.uiShortcuts.Size = new System.Drawing.Size(561, 577);
            this.uiShortcuts.TabIndex = 4;
            this.uiShortcuts.UseCompatibleStateImageBehavior = false;
            this.uiShortcuts.View = System.Windows.Forms.View.Details;
            this.uiShortcuts.ItemSelectionChanged += new System.Windows.Forms.ListViewItemSelectionChangedEventHandler(this.uiShortcuts_ItemSelectionChanged);
            this.uiShortcuts.DoubleClick += new System.EventHandler(this.uiEditShortcutButton_Click);
            // 
            // columnHeaderShortcut
            // 
            this.columnHeaderShortcut.Text = "Shortcut";
            this.columnHeaderShortcut.Width = 110;
            // 
            // columnHeaderTimeout
            // 
            this.columnHeaderTimeout.Text = "Timeout";
            this.columnHeaderTimeout.TextAlign = System.Windows.Forms.HorizontalAlignment.Center;
            // 
            // columnHeaderColor
            // 
            this.columnHeaderColor.Text = "Color";
            this.columnHeaderColor.TextAlign = System.Windows.Forms.HorizontalAlignment.Center;
            this.columnHeaderColor.Width = 200;
            // 
            // columnHeaderComment
            // 
            this.columnHeaderComment.Text = "Comment";
            this.columnHeaderComment.TextAlign = System.Windows.Forms.HorizontalAlignment.Right;
            this.columnHeaderComment.Width = 170;
            // 
            // label1
            // 
            this.label1.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point(576, 58);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(70, 13);
            this.label1.TabIndex = 5;
            this.label1.Text = "Keypress log:";
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Location = new System.Drawing.Point(12, 58);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(55, 13);
            this.label2.TabIndex = 6;
            this.label2.Text = "Shortcuts:";
            // 
            // uiRemoveShortcutButton
            // 
            this.uiRemoveShortcutButton.Enabled = false;
            this.uiRemoveShortcutButton.Location = new System.Drawing.Point(78, 27);
            this.uiRemoveShortcutButton.Name = "uiRemoveShortcutButton";
            this.uiRemoveShortcutButton.Size = new System.Drawing.Size(60, 23);
            this.uiRemoveShortcutButton.TabIndex = 7;
            this.uiRemoveShortcutButton.Text = "&Remove";
            this.uiRemoveShortcutButton.UseVisualStyleBackColor = true;
            this.uiRemoveShortcutButton.Click += new System.EventHandler(this.uiRemoveShortcutButton_Click);
            // 
            // uiAddShortcutButton
            // 
            this.uiAddShortcutButton.Location = new System.Drawing.Point(12, 27);
            this.uiAddShortcutButton.Name = "uiAddShortcutButton";
            this.uiAddShortcutButton.Size = new System.Drawing.Size(60, 23);
            this.uiAddShortcutButton.TabIndex = 8;
            this.uiAddShortcutButton.Text = "&Add";
            this.uiAddShortcutButton.UseVisualStyleBackColor = true;
            this.uiAddShortcutButton.Click += new System.EventHandler(this.uiAddShortcutButton_Click);
            // 
            // uiSaveButton
            // 
            this.uiSaveButton.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.uiSaveButton.Location = new System.Drawing.Point(442, 27);
            this.uiSaveButton.Name = "uiSaveButton";
            this.uiSaveButton.Size = new System.Drawing.Size(60, 23);
            this.uiSaveButton.TabIndex = 9;
            this.uiSaveButton.Text = "Save";
            this.uiSaveButton.UseVisualStyleBackColor = true;
            this.uiSaveButton.Click += new System.EventHandler(this.uiSaveButton_Click);
            // 
            // uiLoadButton
            // 
            this.uiLoadButton.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.uiLoadButton.Location = new System.Drawing.Point(376, 27);
            this.uiLoadButton.Name = "uiLoadButton";
            this.uiLoadButton.Size = new System.Drawing.Size(60, 23);
            this.uiLoadButton.TabIndex = 10;
            this.uiLoadButton.Text = "Load";
            this.uiLoadButton.UseVisualStyleBackColor = true;
            this.uiLoadButton.Click += new System.EventHandler(this.uiLoadButton_Click);
            // 
            // uiEditShortcutButton
            // 
            this.uiEditShortcutButton.Enabled = false;
            this.uiEditShortcutButton.Location = new System.Drawing.Point(144, 27);
            this.uiEditShortcutButton.Name = "uiEditShortcutButton";
            this.uiEditShortcutButton.Size = new System.Drawing.Size(60, 23);
            this.uiEditShortcutButton.TabIndex = 11;
            this.uiEditShortcutButton.Text = "&Edit";
            this.uiEditShortcutButton.UseVisualStyleBackColor = true;
            this.uiEditShortcutButton.Click += new System.EventHandler(this.uiEditShortcutButton_Click);
            // 
            // uiOpenProfileDialog
            // 
            this.uiOpenProfileDialog.Filter = "WA BG Profile|*.profile";
            this.uiOpenProfileDialog.Title = "Open profile";
            // 
            // uiSaveProfileDialog
            // 
            this.uiSaveProfileDialog.DefaultExt = "profile";
            this.uiSaveProfileDialog.FileName = "Profile1";
            this.uiSaveProfileDialog.Filter = "WA BG Profile|*.profile";
            this.uiSaveProfileDialog.RestoreDirectory = true;
            this.uiSaveProfileDialog.Title = "Save profile";
            // 
            // uiSaveAsButton
            // 
            this.uiSaveAsButton.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.uiSaveAsButton.Location = new System.Drawing.Point(508, 27);
            this.uiSaveAsButton.Name = "uiSaveAsButton";
            this.uiSaveAsButton.Size = new System.Drawing.Size(65, 23);
            this.uiSaveAsButton.TabIndex = 12;
            this.uiSaveAsButton.Text = "Save As...";
            this.uiSaveAsButton.UseVisualStyleBackColor = true;
            this.uiSaveAsButton.Click += new System.EventHandler(this.uiSaveAsButton_Click);
            // 
            // uiDuplicateButton
            // 
            this.uiDuplicateButton.Enabled = false;
            this.uiDuplicateButton.Location = new System.Drawing.Point(210, 27);
            this.uiDuplicateButton.Name = "uiDuplicateButton";
            this.uiDuplicateButton.Size = new System.Drawing.Size(60, 23);
            this.uiDuplicateButton.TabIndex = 13;
            this.uiDuplicateButton.Text = "&Duplicate";
            this.uiDuplicateButton.UseVisualStyleBackColor = true;
            this.uiDuplicateButton.Click += new System.EventHandler(this.uiDuplicateButton_Click);
            // 
            // uiCheckInterval
            // 
            this.uiCheckInterval.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.uiCheckInterval.DecimalPlaces = 1;
            this.uiCheckInterval.Increment = new decimal(new int[] {
            1,
            0,
            0,
            65536});
            this.uiCheckInterval.Location = new System.Drawing.Point(508, 56);
            this.uiCheckInterval.Maximum = new decimal(new int[] {
            1,
            0,
            0,
            0});
            this.uiCheckInterval.Minimum = new decimal(new int[] {
            1,
            0,
            0,
            65536});
            this.uiCheckInterval.Name = "uiCheckInterval";
            this.uiCheckInterval.Size = new System.Drawing.Size(62, 20);
            this.uiCheckInterval.TabIndex = 14;
            this.uiCheckInterval.Value = new decimal(new int[] {
            3,
            0,
            0,
            65536});
            // 
            // label3
            // 
            this.label3.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.label3.AutoSize = true;
            this.label3.Location = new System.Drawing.Point(398, 58);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(104, 13);
            this.label3.TabIndex = 15;
            this.label3.Text = "Check interval (sec):";
            // 
            // menuStrip1
            // 
            this.menuStrip1.Items.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.fileToolStripMenuItem,
            this.editToolStripMenuItem,
            this.toolsToolStripMenuItem,
            this.helpToolStripMenuItem});
            this.menuStrip1.Location = new System.Drawing.Point(0, 0);
            this.menuStrip1.Name = "menuStrip1";
            this.menuStrip1.Size = new System.Drawing.Size(844, 24);
            this.menuStrip1.TabIndex = 16;
            this.menuStrip1.Text = "menuStrip1";
            // 
            // fileToolStripMenuItem
            // 
            this.fileToolStripMenuItem.DropDownItems.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.newToolStripMenuItem,
            this.openToolStripMenuItem,
            this.toolStripSeparator,
            this.saveToolStripMenuItem,
            this.saveAsToolStripMenuItem,
            this.toolStripSeparator1,
            this.exitToolStripMenuItem});
            this.fileToolStripMenuItem.Name = "fileToolStripMenuItem";
            this.fileToolStripMenuItem.Size = new System.Drawing.Size(37, 20);
            this.fileToolStripMenuItem.Text = "&File";
            // 
            // newToolStripMenuItem
            // 
            this.newToolStripMenuItem.Enabled = false;
            this.newToolStripMenuItem.Image = ((System.Drawing.Image)(resources.GetObject("newToolStripMenuItem.Image")));
            this.newToolStripMenuItem.ImageTransparentColor = System.Drawing.Color.Magenta;
            this.newToolStripMenuItem.Name = "newToolStripMenuItem";
            this.newToolStripMenuItem.ShortcutKeys = ((System.Windows.Forms.Keys)((System.Windows.Forms.Keys.Control | System.Windows.Forms.Keys.N)));
            this.newToolStripMenuItem.Size = new System.Drawing.Size(146, 22);
            this.newToolStripMenuItem.Text = "&New";
            // 
            // openToolStripMenuItem
            // 
            this.openToolStripMenuItem.Image = ((System.Drawing.Image)(resources.GetObject("openToolStripMenuItem.Image")));
            this.openToolStripMenuItem.ImageTransparentColor = System.Drawing.Color.Magenta;
            this.openToolStripMenuItem.Name = "openToolStripMenuItem";
            this.openToolStripMenuItem.ShortcutKeys = ((System.Windows.Forms.Keys)((System.Windows.Forms.Keys.Control | System.Windows.Forms.Keys.O)));
            this.openToolStripMenuItem.Size = new System.Drawing.Size(146, 22);
            this.openToolStripMenuItem.Text = "&Open";
            this.openToolStripMenuItem.Click += new System.EventHandler(this.uiLoadButton_Click);
            // 
            // toolStripSeparator
            // 
            this.toolStripSeparator.Name = "toolStripSeparator";
            this.toolStripSeparator.Size = new System.Drawing.Size(143, 6);
            // 
            // saveToolStripMenuItem
            // 
            this.saveToolStripMenuItem.Image = ((System.Drawing.Image)(resources.GetObject("saveToolStripMenuItem.Image")));
            this.saveToolStripMenuItem.ImageTransparentColor = System.Drawing.Color.Magenta;
            this.saveToolStripMenuItem.Name = "saveToolStripMenuItem";
            this.saveToolStripMenuItem.ShortcutKeys = ((System.Windows.Forms.Keys)((System.Windows.Forms.Keys.Control | System.Windows.Forms.Keys.S)));
            this.saveToolStripMenuItem.Size = new System.Drawing.Size(146, 22);
            this.saveToolStripMenuItem.Text = "&Save";
            this.saveToolStripMenuItem.Click += new System.EventHandler(this.uiSaveButton_Click);
            // 
            // saveAsToolStripMenuItem
            // 
            this.saveAsToolStripMenuItem.Name = "saveAsToolStripMenuItem";
            this.saveAsToolStripMenuItem.Size = new System.Drawing.Size(146, 22);
            this.saveAsToolStripMenuItem.Text = "Save &As";
            this.saveAsToolStripMenuItem.Click += new System.EventHandler(this.uiSaveAsButton_Click);
            // 
            // toolStripSeparator1
            // 
            this.toolStripSeparator1.Name = "toolStripSeparator1";
            this.toolStripSeparator1.Size = new System.Drawing.Size(143, 6);
            // 
            // exitToolStripMenuItem
            // 
            this.exitToolStripMenuItem.Name = "exitToolStripMenuItem";
            this.exitToolStripMenuItem.Size = new System.Drawing.Size(146, 22);
            this.exitToolStripMenuItem.Text = "E&xit";
            // 
            // editToolStripMenuItem
            // 
            this.editToolStripMenuItem.DropDownItems.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.undoToolStripMenuItem,
            this.redoToolStripMenuItem,
            this.toolStripSeparator3,
            this.cutToolStripMenuItem,
            this.copyToolStripMenuItem,
            this.pasteToolStripMenuItem,
            this.toolStripSeparator4,
            this.selectAllToolStripMenuItem,
            this.addShortcutToolStripMenuItem,
            this.removeShortcutToolStripMenuItem,
            this.editShortcutToolStripMenuItem,
            this.duplicateToolStripMenuItem});
            this.editToolStripMenuItem.Name = "editToolStripMenuItem";
            this.editToolStripMenuItem.Size = new System.Drawing.Size(39, 20);
            this.editToolStripMenuItem.Text = "&Edit";
            // 
            // undoToolStripMenuItem
            // 
            this.undoToolStripMenuItem.Enabled = false;
            this.undoToolStripMenuItem.Name = "undoToolStripMenuItem";
            this.undoToolStripMenuItem.ShortcutKeys = ((System.Windows.Forms.Keys)((System.Windows.Forms.Keys.Control | System.Windows.Forms.Keys.Z)));
            this.undoToolStripMenuItem.Size = new System.Drawing.Size(212, 22);
            this.undoToolStripMenuItem.Text = "&Undo";
            this.undoToolStripMenuItem.Visible = false;
            // 
            // redoToolStripMenuItem
            // 
            this.redoToolStripMenuItem.Enabled = false;
            this.redoToolStripMenuItem.Name = "redoToolStripMenuItem";
            this.redoToolStripMenuItem.ShortcutKeys = ((System.Windows.Forms.Keys)((System.Windows.Forms.Keys.Control | System.Windows.Forms.Keys.Y)));
            this.redoToolStripMenuItem.Size = new System.Drawing.Size(212, 22);
            this.redoToolStripMenuItem.Text = "&Redo";
            this.redoToolStripMenuItem.Visible = false;
            // 
            // toolStripSeparator3
            // 
            this.toolStripSeparator3.Name = "toolStripSeparator3";
            this.toolStripSeparator3.Size = new System.Drawing.Size(209, 6);
            this.toolStripSeparator3.Visible = false;
            // 
            // cutToolStripMenuItem
            // 
            this.cutToolStripMenuItem.Enabled = false;
            this.cutToolStripMenuItem.Image = ((System.Drawing.Image)(resources.GetObject("cutToolStripMenuItem.Image")));
            this.cutToolStripMenuItem.ImageTransparentColor = System.Drawing.Color.Magenta;
            this.cutToolStripMenuItem.Name = "cutToolStripMenuItem";
            this.cutToolStripMenuItem.ShortcutKeys = ((System.Windows.Forms.Keys)((System.Windows.Forms.Keys.Control | System.Windows.Forms.Keys.X)));
            this.cutToolStripMenuItem.Size = new System.Drawing.Size(212, 22);
            this.cutToolStripMenuItem.Text = "Cu&t";
            this.cutToolStripMenuItem.Visible = false;
            // 
            // copyToolStripMenuItem
            // 
            this.copyToolStripMenuItem.Enabled = false;
            this.copyToolStripMenuItem.Image = ((System.Drawing.Image)(resources.GetObject("copyToolStripMenuItem.Image")));
            this.copyToolStripMenuItem.ImageTransparentColor = System.Drawing.Color.Magenta;
            this.copyToolStripMenuItem.Name = "copyToolStripMenuItem";
            this.copyToolStripMenuItem.ShortcutKeys = ((System.Windows.Forms.Keys)((System.Windows.Forms.Keys.Control | System.Windows.Forms.Keys.C)));
            this.copyToolStripMenuItem.Size = new System.Drawing.Size(212, 22);
            this.copyToolStripMenuItem.Text = "&Copy";
            this.copyToolStripMenuItem.Visible = false;
            // 
            // pasteToolStripMenuItem
            // 
            this.pasteToolStripMenuItem.Enabled = false;
            this.pasteToolStripMenuItem.Image = ((System.Drawing.Image)(resources.GetObject("pasteToolStripMenuItem.Image")));
            this.pasteToolStripMenuItem.ImageTransparentColor = System.Drawing.Color.Magenta;
            this.pasteToolStripMenuItem.Name = "pasteToolStripMenuItem";
            this.pasteToolStripMenuItem.ShortcutKeys = ((System.Windows.Forms.Keys)((System.Windows.Forms.Keys.Control | System.Windows.Forms.Keys.V)));
            this.pasteToolStripMenuItem.Size = new System.Drawing.Size(212, 22);
            this.pasteToolStripMenuItem.Text = "&Paste";
            this.pasteToolStripMenuItem.Visible = false;
            // 
            // toolStripSeparator4
            // 
            this.toolStripSeparator4.Name = "toolStripSeparator4";
            this.toolStripSeparator4.Size = new System.Drawing.Size(209, 6);
            this.toolStripSeparator4.Visible = false;
            // 
            // selectAllToolStripMenuItem
            // 
            this.selectAllToolStripMenuItem.Name = "selectAllToolStripMenuItem";
            this.selectAllToolStripMenuItem.ShortcutKeys = ((System.Windows.Forms.Keys)((System.Windows.Forms.Keys.Control | System.Windows.Forms.Keys.A)));
            this.selectAllToolStripMenuItem.Size = new System.Drawing.Size(212, 22);
            this.selectAllToolStripMenuItem.Text = "Select &All";
            this.selectAllToolStripMenuItem.Click += new System.EventHandler(this.selectAllToolStripMenuItem_Click);
            // 
            // addShortcutToolStripMenuItem
            // 
            this.addShortcutToolStripMenuItem.Name = "addShortcutToolStripMenuItem";
            this.addShortcutToolStripMenuItem.Size = new System.Drawing.Size(212, 22);
            this.addShortcutToolStripMenuItem.Text = "&Add shortcut";
            this.addShortcutToolStripMenuItem.Click += new System.EventHandler(this.uiAddShortcutButton_Click);
            // 
            // removeShortcutToolStripMenuItem
            // 
            this.removeShortcutToolStripMenuItem.Name = "removeShortcutToolStripMenuItem";
            this.removeShortcutToolStripMenuItem.Size = new System.Drawing.Size(212, 22);
            this.removeShortcutToolStripMenuItem.Text = "&Remove shortcut";
            this.removeShortcutToolStripMenuItem.Click += new System.EventHandler(this.uiRemoveShortcutButton_Click);
            // 
            // editShortcutToolStripMenuItem
            // 
            this.editShortcutToolStripMenuItem.Name = "editShortcutToolStripMenuItem";
            this.editShortcutToolStripMenuItem.Size = new System.Drawing.Size(212, 22);
            this.editShortcutToolStripMenuItem.Text = "&Edit shortcut";
            this.editShortcutToolStripMenuItem.Click += new System.EventHandler(this.uiEditShortcutButton_Click);
            // 
            // duplicateToolStripMenuItem
            // 
            this.duplicateToolStripMenuItem.Name = "duplicateToolStripMenuItem";
            this.duplicateToolStripMenuItem.ShortcutKeys = ((System.Windows.Forms.Keys)((System.Windows.Forms.Keys.Control | System.Windows.Forms.Keys.D)));
            this.duplicateToolStripMenuItem.Size = new System.Drawing.Size(212, 22);
            this.duplicateToolStripMenuItem.Text = "&Duplicate selected";
            // 
            // toolsToolStripMenuItem
            // 
            this.toolsToolStripMenuItem.DropDownItems.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.runToolStripMenuItem,
            this.stopToolStripMenuItem,
            this.optionsToolStripMenuItem});
            this.toolsToolStripMenuItem.Name = "toolsToolStripMenuItem";
            this.toolsToolStripMenuItem.Size = new System.Drawing.Size(48, 20);
            this.toolsToolStripMenuItem.Text = "&Tools";
            // 
            // runToolStripMenuItem
            // 
            this.runToolStripMenuItem.Name = "runToolStripMenuItem";
            this.runToolStripMenuItem.ShortcutKeys = System.Windows.Forms.Keys.F5;
            this.runToolStripMenuItem.Size = new System.Drawing.Size(152, 22);
            this.runToolStripMenuItem.Text = "&Run";
            this.runToolStripMenuItem.Click += new System.EventHandler(this.uiRunButton_Click);
            // 
            // stopToolStripMenuItem
            // 
            this.stopToolStripMenuItem.Name = "stopToolStripMenuItem";
            this.stopToolStripMenuItem.ShortcutKeys = ((System.Windows.Forms.Keys)((System.Windows.Forms.Keys.Shift | System.Windows.Forms.Keys.F5)));
            this.stopToolStripMenuItem.Size = new System.Drawing.Size(152, 22);
            this.stopToolStripMenuItem.Text = "&Stop";
            this.stopToolStripMenuItem.Click += new System.EventHandler(this.uiStopButton_Click);
            // 
            // optionsToolStripMenuItem
            // 
            this.optionsToolStripMenuItem.Enabled = false;
            this.optionsToolStripMenuItem.Name = "optionsToolStripMenuItem";
            this.optionsToolStripMenuItem.Size = new System.Drawing.Size(152, 22);
            this.optionsToolStripMenuItem.Text = "&Options";
            // 
            // helpToolStripMenuItem
            // 
            this.helpToolStripMenuItem.DropDownItems.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.contentsToolStripMenuItem,
            this.indexToolStripMenuItem,
            this.searchToolStripMenuItem,
            this.toolStripSeparator5,
            this.aboutToolStripMenuItem});
            this.helpToolStripMenuItem.Name = "helpToolStripMenuItem";
            this.helpToolStripMenuItem.Size = new System.Drawing.Size(44, 20);
            this.helpToolStripMenuItem.Text = "&Help";
            // 
            // contentsToolStripMenuItem
            // 
            this.contentsToolStripMenuItem.Name = "contentsToolStripMenuItem";
            this.contentsToolStripMenuItem.Size = new System.Drawing.Size(122, 22);
            this.contentsToolStripMenuItem.Text = "&Contents";
            // 
            // indexToolStripMenuItem
            // 
            this.indexToolStripMenuItem.Name = "indexToolStripMenuItem";
            this.indexToolStripMenuItem.Size = new System.Drawing.Size(122, 22);
            this.indexToolStripMenuItem.Text = "&Index";
            // 
            // searchToolStripMenuItem
            // 
            this.searchToolStripMenuItem.Name = "searchToolStripMenuItem";
            this.searchToolStripMenuItem.Size = new System.Drawing.Size(122, 22);
            this.searchToolStripMenuItem.Text = "&Search";
            // 
            // toolStripSeparator5
            // 
            this.toolStripSeparator5.Name = "toolStripSeparator5";
            this.toolStripSeparator5.Size = new System.Drawing.Size(119, 6);
            // 
            // aboutToolStripMenuItem
            // 
            this.aboutToolStripMenuItem.Name = "aboutToolStripMenuItem";
            this.aboutToolStripMenuItem.Size = new System.Drawing.Size(122, 22);
            this.aboutToolStripMenuItem.Text = "&About...";
            // 
            // MainForm
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(844, 666);
            this.Controls.Add(this.label3);
            this.Controls.Add(this.uiCheckInterval);
            this.Controls.Add(this.uiDuplicateButton);
            this.Controls.Add(this.uiSaveAsButton);
            this.Controls.Add(this.uiEditShortcutButton);
            this.Controls.Add(this.uiLoadButton);
            this.Controls.Add(this.uiSaveButton);
            this.Controls.Add(this.uiAddShortcutButton);
            this.Controls.Add(this.uiRemoveShortcutButton);
            this.Controls.Add(this.label2);
            this.Controls.Add(this.label1);
            this.Controls.Add(this.uiShortcuts);
            this.Controls.Add(this.uiStopButton);
            this.Controls.Add(this.listBox1);
            this.Controls.Add(this.uiRunButton);
            this.Controls.Add(this.menuStrip1);
            this.Icon = ((System.Drawing.Icon)(resources.GetObject("$this.Icon")));
            this.MainMenuStrip = this.menuStrip1;
            this.MinimumSize = new System.Drawing.Size(860, 650);
            this.Name = "MainForm";
            this.Text = "WA - BG";
            this.FormClosing += new System.Windows.Forms.FormClosingEventHandler(this.MainForm_FormClosing);
            ((System.ComponentModel.ISupportInitialize)(this.uiCheckInterval)).EndInit();
            this.menuStrip1.ResumeLayout(false);
            this.menuStrip1.PerformLayout();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Button uiRunButton;
        private System.Windows.Forms.ListBox listBox1;
        private System.Windows.Forms.Button uiStopButton;
        private System.Windows.Forms.ListView uiShortcuts;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.Button uiRemoveShortcutButton;
        private System.Windows.Forms.Button uiAddShortcutButton;
        private System.Windows.Forms.ColumnHeader columnHeaderShortcut;
        private System.Windows.Forms.ColumnHeader columnHeaderTimeout;
        private System.Windows.Forms.Button uiSaveButton;
        private System.Windows.Forms.Button uiLoadButton;
        private System.Windows.Forms.Button uiEditShortcutButton;
        private System.Windows.Forms.ColumnHeader columnHeaderComment;
        private System.Windows.Forms.ColumnHeader columnHeaderColor;
        private System.Windows.Forms.OpenFileDialog uiOpenProfileDialog;
        private System.Windows.Forms.SaveFileDialog uiSaveProfileDialog;
        private System.Windows.Forms.Button uiSaveAsButton;
        private System.Windows.Forms.Button uiDuplicateButton;
        private System.Windows.Forms.NumericUpDown uiCheckInterval;
        private System.Windows.Forms.Label label3;
        private System.Windows.Forms.MenuStrip menuStrip1;
        private System.Windows.Forms.ToolStripMenuItem fileToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem newToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem openToolStripMenuItem;
        private System.Windows.Forms.ToolStripSeparator toolStripSeparator;
        private System.Windows.Forms.ToolStripMenuItem saveToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem saveAsToolStripMenuItem;
        private System.Windows.Forms.ToolStripSeparator toolStripSeparator1;
        private System.Windows.Forms.ToolStripMenuItem exitToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem editToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem undoToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem redoToolStripMenuItem;
        private System.Windows.Forms.ToolStripSeparator toolStripSeparator3;
        private System.Windows.Forms.ToolStripMenuItem cutToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem copyToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem pasteToolStripMenuItem;
        private System.Windows.Forms.ToolStripSeparator toolStripSeparator4;
        private System.Windows.Forms.ToolStripMenuItem selectAllToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem toolsToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem optionsToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem helpToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem contentsToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem indexToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem searchToolStripMenuItem;
        private System.Windows.Forms.ToolStripSeparator toolStripSeparator5;
        private System.Windows.Forms.ToolStripMenuItem aboutToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem duplicateToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem runToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem stopToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem addShortcutToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem removeShortcutToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem editShortcutToolStripMenuItem;
    }
}

