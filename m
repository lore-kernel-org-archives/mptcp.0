Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95F1A72
	for <mptcp@lists.linux.dev>; Thu,  6 May 2021 14:19:09 +0000 (UTC)
Received: by mail-pf1-f169.google.com with SMTP id 10so5380549pfl.1
        for <mptcp@lists.linux.dev>; Thu, 06 May 2021 07:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3NGcO8cqYvzH4l8zExgVV5YykGlfDsXMiCiBzdEQ7Cg=;
        b=JAzesp3KJ21jG4Wr6Z+DlUOPv9A37aCr/yig92FHhMw9Kq2Ez1dFZCJYUfbcGNR+X0
         H3mG4TJq5xkhsPb7g5DZddjE8OmyZT9RabW4K/v/+jNOLSvVmLHwCdJCVa2GfPkNNUnr
         iZcKzU1P5EQlU/5zaHoz75gyCCye6SuTKR65aegPDYgCZ0OPVFbiwCrftD9QH7RAO3oM
         k6XLsf3WD/caWOEiHE3ZQ59JFHdAVRc56uAxib+2e6BfmhncW1NAl89wlUVUS4sWLg5/
         KzM5zjbd68N93ORPt+P3W5g+W7Icapl25r02IrsCHY9G/C1ntcQshH6VNlvyBSCwX6CU
         soIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3NGcO8cqYvzH4l8zExgVV5YykGlfDsXMiCiBzdEQ7Cg=;
        b=epm4IJpgXoLWTcub2qw8mrUZ6ieKN/b/HZGYPUESoB/5TGAy1nLcptftMhJQ2P2AIQ
         J+/0poNGzt+KyXH380GjyAyICXLfYpOMHVglqS9I57fnpgGMy5JMyqca0tWQqBeM5XRp
         BmLlt5e9D1yODyHwI71sClhx8lCC7WyAo8/Mzc/MBemrftoZmOzC5DUm0fbNgLiaUhVk
         zV7P8hrVLG+1/YdAPDHAnLCiOIb3d/TEJ2BhiIy6o/Epyx509TEF5nA0gwWRvKHfNZaS
         aYBc4v+GUb8qJndmpuicsA5nwhkBrx3oliWTrm5ln6/MbpTbyKszgfU+zPBlKJ09mFHD
         g4/Q==
X-Gm-Message-State: AOAM530kINYakXOOP0q7zvjl0/unDUoHLW/Q+nEmGfvBW0yNZeDyNJFd
	ZTIwgBu0tp9av8Xm6IuItEltbtdBbew=
X-Google-Smtp-Source: ABdhPJy/l5pLvtt6yAU8xzy3gF8WSg7ip4OVLHJZHgPi5uFYgyaljqg/UJNq81VxiPfE2VnajVk7Lg==
X-Received: by 2002:a63:164a:: with SMTP id 10mr4740940pgw.186.1620310748917;
        Thu, 06 May 2021 07:19:08 -0700 (PDT)
Received: from localhost ([209.9.72.214])
        by smtp.gmail.com with ESMTPSA id d16sm2215027pgk.34.2021.05.06.07.19.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 May 2021 07:19:08 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>
Subject: [MPTCP][PATCH mptcp-next] Squash to "mptcp: dump csum fields in mptcp_dump_mpext"
Date: Thu,  6 May 2021 22:19:05 +0800
Message-Id: <7102b3cc726a2562a5903786de957852b9eec033.1620310714.git.geliangtang@gmail.com>
X-Mailer: git-send-email 2.31.1
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use %x for csum as Paolo suggested.

Signed-off-by: Geliang Tang <geliangtang@gmail.com>
---
 include/trace/events/mptcp.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/trace/events/mptcp.h b/include/trace/events/mptcp.h
index c853849692af..6bf43176f14c 100644
--- a/include/trace/events/mptcp.h
+++ b/include/trace/events/mptcp.h
@@ -104,7 +104,7 @@ DECLARE_EVENT_CLASS(mptcp_dump_mpext,
 		__entry->csum_reqd = mpext->csum_reqd;
 	),
 
-	TP_printk("data_ack=%llu data_seq=%llu subflow_seq=%u data_len=%u csum=%u use_map=%u dsn64=%u data_fin=%u use_ack=%u ack64=%u mpc_map=%u frozen=%u reset_transient=%u reset_reason=%u csum_reqd=%u",
+	TP_printk("data_ack=%llu data_seq=%llu subflow_seq=%u data_len=%u csum=%x use_map=%u dsn64=%u data_fin=%u use_ack=%u ack64=%u mpc_map=%u frozen=%u reset_transient=%u reset_reason=%u csum_reqd=%u",
 		  __entry->data_ack, __entry->data_seq,
 		  __entry->subflow_seq, __entry->data_len,
 		  __entry->csum, __entry->use_map,
-- 
2.31.1

