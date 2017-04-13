<?php

class ModelSyncSync extends Model {
    const LOCAL_HOST = 'partner.seomax.biz';
    const REMOTE_HOST = 'yaltapartner.ru';

    public function sync_allowed() {
        return $_SERVER['HTTP_HOST'] == self::LOCAL_HOST;
    }
}