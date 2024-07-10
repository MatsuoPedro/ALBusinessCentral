pageextension 50000 "ReleasedProductionOrder" extends "Released Production Order"
{
    layout
    {
        addbefore("Schedule")
        {
            part("LabelPicture"; "LabelPicture")
            {
                ApplicationArea = All;
                SubPageLink = "No." = field("No.");
            }
        }

    }
}
