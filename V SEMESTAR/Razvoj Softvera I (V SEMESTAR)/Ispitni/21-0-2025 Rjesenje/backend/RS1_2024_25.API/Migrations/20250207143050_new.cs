using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace RS1_2024_25.API.Migrations
{
    /// <inheritdoc />
    public partial class @new : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Semesters_AcademicYears_akademskaGodinaID",
                table: "Semesters");

            migrationBuilder.DropColumn(
                name: "akademskaGodnaId",
                table: "Semesters");

            migrationBuilder.RenameColumn(
                name: "akademskaGodinaID",
                table: "Semesters",
                newName: "akademskaGodinaId");

            migrationBuilder.RenameIndex(
                name: "IX_Semesters_akademskaGodinaID",
                table: "Semesters",
                newName: "IX_Semesters_akademskaGodinaId");

            migrationBuilder.AddForeignKey(
                name: "FK_Semesters_AcademicYears_akademskaGodinaId",
                table: "Semesters",
                column: "akademskaGodinaId",
                principalTable: "AcademicYears",
                principalColumn: "ID");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Semesters_AcademicYears_akademskaGodinaId",
                table: "Semesters");

            migrationBuilder.RenameColumn(
                name: "akademskaGodinaId",
                table: "Semesters",
                newName: "akademskaGodinaID");

            migrationBuilder.RenameIndex(
                name: "IX_Semesters_akademskaGodinaId",
                table: "Semesters",
                newName: "IX_Semesters_akademskaGodinaID");

            migrationBuilder.AddColumn<int>(
                name: "akademskaGodnaId",
                table: "Semesters",
                type: "int",
                nullable: false,
                defaultValue: 0);

            migrationBuilder.AddForeignKey(
                name: "FK_Semesters_AcademicYears_akademskaGodinaID",
                table: "Semesters",
                column: "akademskaGodinaID",
                principalTable: "AcademicYears",
                principalColumn: "ID");
        }
    }
}
