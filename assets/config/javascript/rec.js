<script src='https://shifttoiro-test.rec.edirium.co.jp/scripts/recommender.js'></script>
  params = {}
  function edi_rec_top(){
    this.params.serv = "shifttoiro";
    this.params.area = "top";
    this.params.env = "test";
    this.params.item = "";
    this.params.n = "9";
    edirium_rec.retrieve_recs(
      this.params,
      edirium_rec.write_recs,
      "rec_area"
    );
    }
  
  function test(){
    alert()
  }
