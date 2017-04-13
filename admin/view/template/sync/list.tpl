<?php if (!empty($dumps)): ?>
    <ul>

        <?php foreach($dumps as $dump): ?>
            <?php $log_key = null; ?>
            <li>
                <?php echo $dump['date'].'&nbsp;|&nbsp;'; ?>
                <?php foreach($dump['files'] as $url=>$file): ?>
                    <?php if ($file == 'log.txt') {
                        $log_key = $url;
                        continue;
                    }
                    ?>
                    <a href="<?php echo $url; ?>" target="_blank"><?php echo $file; ?></a>&nbsp;
                <?php endforeach; ?>
                <?php if (!empty($log_key)): ?>
                    &nbsp;|&nbsp;<a href="<?php echo $log_key; ?>" target="_blank">смотреть лог</a>
                <?php endif ?>
                <?php if (!empty($dump['dir'])): ?>
                    &nbsp;|&nbsp;<a href="javascript:void(0)" onclick="rollback('<?php echo $dump['dir'] ?>')">сделать откат до <?php echo $dump['date'] ?></a>
                <?php endif ?>
            </li>
        <?php endforeach; ?>
    </ul>
<?php endif; ?>