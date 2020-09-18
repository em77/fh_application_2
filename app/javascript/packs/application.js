// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()

require("jquery");

import 'bootstrap';
import "@fortawesome/fontawesome-free/js/all";
import '../stylesheets/application';

import moment from 'moment';
window.moment = moment;

// Date picker - flatpickr
import flatpickr from 'flatpickr';
require("flatpickr/dist/flatpickr.css");
import monthSelect from 'flatpickr/dist/plugins/monthSelect';
import 'flatpickr/dist/plugins/monthSelect/style.css';

// Make file input dynamic
import bsCustomFileInput from 'bs-custom-file-input';

document.addEventListener("turbolinks:load", () => {
  flatpickr("[data-behavior='flatpickr']", {
    allowInput: true, // Compensation for HTML validation otherwise not working
    altInput: true,
    altFormat: "F j, Y",
    dateFormat: "Y-m-d"
  });

  // Select all on focus of flatpickr field
  $("[data-behavior='flatpickr']").next().focus(function() {
    $(this).on("click.a keyup.a", function(e){      
      $(this).off("click.a keyup.a").select();
    });
  });

  bsCustomFileInput.init();

  // Auto-fill age field from DOB
  $("#dob-field").next().on("blur", function() {
    if ($("#dob-field").val() === "") {
      $("#age-field").val("");
    } else {
      var dob, duration, now, years, age;
      now = moment();
      dob = moment($("#dob-field").val());
      duration = moment.duration(now.diff(dob));
      years = duration.asYears();
      age = Math.round(years);
      $("#age-field").val(age);
    }
  });

  // Total income field auto-filler
  $(".income-field").change(function() {
    var total;
    total = function(selector) {
      var sum;
      sum = 0;
      $(selector).each(function() {
        sum += Number($(this).val());
      });
      return sum;
    };

    $("#total-field").val(total(".income-field"));
  });

  // Hide ACS involvement field if not residing with minors
  $("#member_application_reside_with_minors").change(function() {
    var selected;
    selected = $("#member_application_reside_with_minors option:selected").text();
    if (selected === "Yes") {
      $("#acs-select").show();
    } else {
      $("#acs-select").hide();
    }
  });

  // Hide insurance number field if insurance is "None", hide other_insurance
  // field unless "Other" is selected, and hide medicaid_comp field if it isn't
  // selected
  $("#member_application_insurance_name").change(function() {
    var selected;
    selected = $("#member_application_insurance_name option:selected").text();
    if (selected === "None") {
      $("#insurance-num").hide();
      $("#insurance-other").hide();
      $("#medicaid-managed").hide();
    } else if (selected === "Other (fill in below)") {
      $("#insurance-num").show();
      $("#insurance-other").show();
      $("#medicaid-managed").hide();
    } else if (selected === "Medicaid Managed Care (fill in name of company below)") {
      $("#insurance-num").show();
      $("#insurance-other").hide();
      $("#medicaid-managed").show();
    } else {
      $("#insurance-num").show();
      $("#insurance-other").hide();
      $("#medicaid-managed").hide();
    }
  });

  // Required field checker for old Safari versions
  $("form").submit(function(e) {
    var ref;
    if (!e.target.checkValidity()) {
      ref = $(this).find("[required]");
      $(ref).each(function() {
        if ($(this).val() === "") {
          alert("This field cannot be blank:\n" + $(this).prev("label").text());
          $(this).focus();
          e.preventDefault();
          return false;
        }
        return true;
      });
    }
  });

  // Remove all "required" attributes on fields and submit form on "Save Draft" button click
  $("#save-draft-button").on("click", function() {
    function removeRequired(element) {
      $(element).prop("required", false);
    }

    for (const element of $("form")[0].elements) {
      removeRequired(element);
    }

    $("form")[0].submit();
  });

  // If there's no navbar (submitted application on show view)
  if ($(".navbar").length === 0) {
    // Reduce body padding since there's no navbar
    $("body").css("padding-top", "5px");

    // Remove attachment file fields
    $("#psych_eval_field").remove();
    $("#psych_social_field").remove();
    $("#insurance_card_field").remove();

    // Disable all fields
    function makeDisabled(element) {
      $(element).attr("disabled", "disabled");
    }

    for (const element of $("form")[0].elements) {
      makeDisabled(element);
    }
  }

  // Attachment openers
  function openAttachmentListener(attachment_name) {
    if ($("#" + attachment_name + "_header").length > 0) {
      $("#" + attachment_name + "_field_opener").on("click", function() {
        $("#" + attachment_name + "_field").show();
      });
    } else {
      $("#" + attachment_name + "_field").show();
    }
  }

  openAttachmentListener("psych_eval");
  openAttachmentListener("psych_social");
  openAttachmentListener("insurance_card");
})

// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)
