Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF6EA71
	for <mptcp@lists.linux.dev>; Tue, 18 May 2021 07:06:20 +0000 (UTC)
Received: by mail-pl1-f171.google.com with SMTP id s4so3002889plg.12
        for <mptcp@lists.linux.dev>; Tue, 18 May 2021 00:06:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=22sN4HArss2xzmdoGTyv0ggYCLq3HrIYnI8r0HF7LL8=;
        b=N6XrVTCekk5Q7QXonbi4syKYA6Kah3y66/8cyBl5aeoPJLWjUIu40y+zmX0LFavqno
         448GOrl4W53534J4uk/Z3cAIKeaPPBMj57ycQpaf0pYFQz2cmAj8nIqwQplRTCZhqWTh
         cwHQyrSkFKOFMIeeDFEgpLrKdh/ti+WDPIyh1xI4Jf+fliZWlFv0D0x4T8z76WvQTvWx
         E7cvEGifc4mPx3q9fG+6XHdysFu5pCtNBlbZsXMT3mVNO5NZmx2Azp+EvVuNBmJJIGPa
         UMxP4nL2b1eyiKyCG82q1bXLQsN9Pbh64HaxTAB1wo7uTC4xPqtc/bcXt55EJY0YyR7L
         xfoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=22sN4HArss2xzmdoGTyv0ggYCLq3HrIYnI8r0HF7LL8=;
        b=Ic1VMFTDVqfSa5x5WNbbXWjamsZKTbVsvv16KWWDqBdE+YiilTcIwZruPEqU5B/bVM
         L6/1zhoDpTcx/zGUJPKWGUkrr96s06K0FZANKCjGKHqvCuHYBJIKsxGOmZZuNZXkmGFw
         qWYz1gnlonJ0Zd5HIiebgLqr+Gqg6WM485aU7+gVYTpqUl6o0geVAfL72PKlhVKB5zW7
         cClqjxA30ZIrrP5dmF+xERnjDOKmX8rEL04QcnlU0h4xjLwIkGN4H0mWQ5SayKnvMDNO
         sEFxCWVmadPOCWUbnTAC5igOCOq08hCBAEhVUm8XHwANwQkh8GRXGETSZ/5b3xnleY5R
         RGoQ==
X-Gm-Message-State: AOAM533PrRVLR5wJCnqQGaH7WkgjlqJ1eMNP1hOonn5HBJj+mLvCHmaU
	qJA9dPzwMVYUv6nAA86s8vDJEEsgzqg=
X-Google-Smtp-Source: ABdhPJygsvGMFlAs9mBFnSdHdrhboiWA5HvCOFd/nV5API6drRb7IztudjjsWTUqbcgGXa3SyhbH8Q==
X-Received: by 2002:a17:903:30c4:b029:ef:82f1:cb28 with SMTP id s4-20020a17090330c4b02900ef82f1cb28mr3023549plc.19.1621321580009;
        Tue, 18 May 2021 00:06:20 -0700 (PDT)
Received: from localhost ([209.9.72.213])
        by smtp.gmail.com with ESMTPSA id q28sm2018172pfs.197.2021.05.18.00.06.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 May 2021 00:06:19 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>
Subject: [MPTCP][PATCH mptcp-next] Squash to "mptcp: generate the data checksum"
Date: Tue, 18 May 2021 15:06:17 +0800
Message-Id: <ae2099811b8395f7718855c5c7d412b26d960c95.1621321549.git.geliangtang@gmail.com>
X-Mailer: git-send-email 2.31.1
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move this line "__wsum csum = ~csum_unfold(mpext->csum);" from "mptcp:
validate the data checksum" to "mptcp: generate the data checksum".

Signed-off-by: Geliang Tang <geliangtang@gmail.com>
---
 net/mptcp/protocol.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 38ce8d50e665..58253bd09f93 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1311,7 +1311,7 @@ static bool mptcp_alloc_tx_skb(struct sock *sk, struct sock *ssk)
 static void mptcp_update_data_checksum(struct sk_buff *skb, int added)
 {
 	struct mptcp_ext *mpext = mptcp_get_ext(skb);
-	__wsum csum = csum_unfold(mpext->csum);
+	__wsum csum = ~csum_unfold(mpext->csum);
 	int offset = skb->len - added;
 
 	mpext->csum = csum_fold(csum_block_add(csum, skb_checksum(skb, offset, added, 0), offset));
-- 
2.31.1

