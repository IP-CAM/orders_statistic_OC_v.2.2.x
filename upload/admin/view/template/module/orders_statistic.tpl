<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
    <div class="page-header">
        <div class="container-fluid">

            <h1><?php echo $heading_title; ?></h1>
            <ul class="breadcrumb">
                <?php foreach ($breadcrumbs as $breadcrumb) { ?>
                <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
                <?php } ?>
            </ul>
        </div>
    </div>
    <div class="container-fluid"> 

        <?php if ($is_fail) { ?>
        <div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $text_fail; ?>
            <button type="button" class="close" data-dismiss="alert">&times;</button>
        </div>
        <?php } ?>
        <?php if ($is_success) { ?>
        <div class="alert alert-success"><i class="fa fa-exclamation-circle"></i> <?php echo $text_success; ?>
            <button type="button" class="close" data-dismiss="alert">&times;</button>
        </div>
        <?php } ?>

        <div class="panel panel-default">
            <div class="panel-heading">
                <h3 class="panel-title"><i class="fa fa-pencil"></i> <?php echo $heading_title;?></h3>
            </div>
            <div class="panel-body">
                <form action="<?php echo $start; ?>" method="post" onsubmit="return confirm('<?php echo $text_warning;?>');"  class="form-horizontal">

                    <div class="form-group">
                        <label class="col-sm-2 control-label" for="categories">
                            <?php echo $text_categories_from;?>
                        </label>
                        <div class="col-sm-10">
                            <div class="well well-sm" id="categories">                                
                                <?php foreach ($categories as $category) { ?>
                                <div class="checkbox">
                                    <label>
                                        <input type="checkbox" name="categories[]" value="<?php echo $category['category_id']; ?>" />
                                        <?php echo $category['name']; ?> </label>
                                </div>
                                <?php } ?>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label" for="input-to-category">
                            <?php echo $text_category_to;?>
                        </label>

                        <div class="col-sm-10">
                            <input type="text" name="path" value="" placeholder="<?php echo $text_category_to;?>" id="input-to-category" class="form-control" />
                            <input type="hidden" name="to_category_id" value="0" />
                        </div>
                    </div>

                    <div class="form-group">


                        <div class="col-sm-6">
                            <label>
                                <input type="checkbox" class="edit" name="replace_to" value="1" ><span data-toggle="tooltip" title="" data-original-title="<?php echo $text_replace_to_desc;?>"><?php echo $text_replace_to;?></span>
                            </label>
                        </div>
                        <div class="col-sm-6">
                            <label>
                                <input type="checkbox" class="edit" name="replace_from" value="1" ><span data-toggle="tooltip" title="" data-original-title="<?php echo $text_replace_from_desc;?>"><?php echo $text_replace_from;?></span>
                            </label>
                        </div>
                    </div>
                    <input type="submit" class="btn btn-primary" value="<?php echo $text_start; ?>">
                </form>




                <script type="text/javascript"><!--
                $('input[name=\'path\']').autocomplete({
                        'source': function (request, response) {
                            $.ajax({
                                url: 'index.php?route=catalog/category/autocomplete&token=<?php echo $token;?>&filter_name=' + encodeURIComponent(request),
                                dataType: 'json',
                                success: function (json) {
                                    json.unshift({
                                        category_id: 0,
                                        name: ' --- Empty --- '
                                    });

                                    response($.map(json, function (item) {
                                        return {
                                            label: item['name'],
                                            value: item['category_id']
                                        }
                                    }));
                                }
                            });
                        },
                        'select': function (item) {
                            $('input[name=\'path\']').val(item['label']);
                            $('input[name=\'to_category_id\']').val(item['value']);
                        }
                    });
                    //--></script>

            </div>
            </form>
        </div>
    </div>
</div>
<?php echo $footer; ?>
