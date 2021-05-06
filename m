Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9950D71
	for <mptcp@lists.linux.dev>; Thu,  6 May 2021 04:32:17 +0000 (UTC)
Received: by mail-pj1-f54.google.com with SMTP id gq14-20020a17090b104eb029015be008ab0fso2762908pjb.1
        for <mptcp@lists.linux.dev>; Wed, 05 May 2021 21:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Pcy0MtDCE2v2WQhbuvgCLMkbkh2dXgGrD3744j14V+g=;
        b=smV4BbD0bExeEH+1How8+QuIpWLngZB9SEedpZ00tKuXXpHJqzNuDm0egqDH9wOJYx
         /hsyQYxVbXgvfFRy1lCxZKaDKTVr9AZAWOI/MHhH6K1QK42yCoydKo5y4IsEQjzV++Xm
         aT8qngAv4hChVu2qi2ydRM2OQPgGbcNEfgHbczI/HD1AHw+z6RdthZTYNdMiLJrJyFjZ
         21T0lZ/u507jVuuloIwGGF5LBTfoilL/CygxrMp54rkmWpQ680sKs8qHpWaFGEPHW0iQ
         QFBBbUeizAAGzK8CLFhQliU4mtRMRa3MyioOod1bwrfIwgZc5/t4cl/sSmO6xsxEbwKr
         Lq2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Pcy0MtDCE2v2WQhbuvgCLMkbkh2dXgGrD3744j14V+g=;
        b=eVqihCjC1XfPziFMR2KvtyI9YDcIBbhSXox+db4IpAyC0xUHAvakjpntdDbUQANQYU
         ay/U60s8DS5wiAqvJ0I9nsXgBSUz2GmvhIed8Pcg6yiaBghrjVBU+yUblQvoRXDKQkTW
         eK0giJroFSJo5ERfkH2oiUur7n6/LXEBJRNNmcn8H56KEML2T15B1QK9pQI46hBuUDAc
         sjvVljMmPUqZayoWKquA/uzB54+m4o0+V5KZhkXSyzGHZi9F8ShLFETpJu/OqGZQNfa7
         x3DDbgovIxnurSWoYX7fW1u7Bsy9Qno99sVfzwE+gGGDY3J2UCXKYSFiyRueCY5vXAHZ
         CKMw==
X-Gm-Message-State: AOAM530aQH4/ciBjOWnNW5N7YpXrfe3NjdVwrcgjKvgFgw7tIxgxZHrd
	NWf0L05gOh6t7f7HJXtTpqec1jtyVm0=
X-Google-Smtp-Source: ABdhPJy0dlvNpoWM7mCU4YRAZfZlZAStRuB4xGZq2G/pvb75gjTe1f7RXRpibIN2PlgszegG554K3Q==
X-Received: by 2002:a17:90a:a604:: with SMTP id c4mr15834357pjq.81.1620275537146;
        Wed, 05 May 2021 21:32:17 -0700 (PDT)
Received: from localhost ([209.9.72.213])
        by smtp.gmail.com with ESMTPSA id w125sm719235pfw.214.2021.05.05.21.32.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 May 2021 21:32:16 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>
Subject: [MPTCP][PATCH mptcp-next 1/3] Squash to "mptcp: add csum_reqd in mptcp_out_options"
Date: Thu,  6 May 2021 12:32:09 +0800
Message-Id: <49d4717df8568a70b4bb6d3827046cd5a771b14e.1620275257.git.geliangtang@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1620275257.git.geliangtang@gmail.com>
References: <cover.1620275257.git.geliangtang@gmail.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update this patch as Mat suggested in the "MP_CAPABLE C flag" series.

Signed-off-by: Geliang Tang <geliangtang@gmail.com>
---
 include/net/mptcp.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index bd272c34b53c..d61bbbf11979 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -65,8 +65,8 @@ struct mptcp_out_options {
 	struct mptcp_rm_list rm_list;
 	u8 join_id;
 	u8 backup;
-	u8 reset_reason:4;
-	u8 reset_transient:1,
+	u8 reset_reason:4,
+	   reset_transient:1,
 	   csum_reqd:1;
 	u32 nonce;
 	u64 thmac;
-- 
2.31.1

