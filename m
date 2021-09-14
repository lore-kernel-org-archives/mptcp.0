Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 797913FC5
	for <mptcp@lists.linux.dev>; Tue, 14 Sep 2021 09:19:19 +0000 (UTC)
Received: by mail-pj1-f41.google.com with SMTP id nn5-20020a17090b38c500b0019af1c4b31fso1462432pjb.3
        for <mptcp@lists.linux.dev>; Tue, 14 Sep 2021 02:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JydFJBGFsgTdO0iMCcoiOxHfJVWque9piH4bx6V0zWQ=;
        b=QPxnmffh1qV4lTpFswvQzUg3i6ImydpyYhubQUU0n2lbXjsrIZvTkoUtm7ZYP7aAkt
         imUneeRHM47Dtp4z1Kedvli48yxTWiNHn3QEiwMK5ruQfjZjsEsA1+9Y8Ck3U8BbD2DX
         blHo0zwcmn9+qVfLT6L7L5pwYmjZQ2k2z9zPOnO6IzWOXBLWOl9t6E8RiF8ktGEiGptO
         rAB8NCRgdLZgvHoxVAF9k9J76n+Q5S8Vn2X2DGfRt0Si1m8Oa6rzOX/peDnZAyzFSUp2
         hsT2dUjyBlipudJI7mpaK0twAg/EC3UWQknOLyyUSPai7hIA+tdLnfXiHVwl6FZz6ReH
         dcLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JydFJBGFsgTdO0iMCcoiOxHfJVWque9piH4bx6V0zWQ=;
        b=qTpocRFZOuOhxESs8OaoqtI7SrDWeJli8qXC7P+XXx4msZqKXJbNLaXqpIfVKvICRB
         /zirOIOXlAL5j0cUcYAJbReLW05YaKMFC0HCHmX4X/7h/Mo1sdjkRnKDeeLvP/8xZsDh
         DpiY5lO/EM+d1lKRn9Lrn4QTROfBwZ6vaU84p8D/S2V0tyV2dQl916y+6C6nZulPmYUf
         UpMQtCjJyllqCekhiwSj6QzkPO3ki9dca+XXUUtGuK92JgZ9YXY0iWEowjq25Ea/YukB
         P2izZSFBh4/YoAQqJjcj49Tye3R0pFuQUOmokgLav9EfFiCBNWmTrM+lR1BVKTzVTbkW
         OQsQ==
X-Gm-Message-State: AOAM530ZI6GYxPWSKIWSiBjgkiFs/1nKNhYmHz0sS7PVcxVNJjvuZv2N
	1y2Ea9Rn8k+3ddzJRSl7fiyWdAg7yeM=
X-Google-Smtp-Source: ABdhPJydLchVYUkVEYWZVxeZhBKPJpvLcvGPl8KzBT8uswCl691/+uxwd9cyxGrXLeuGVPnB2rIKIQ==
X-Received: by 2002:a17:90b:194c:: with SMTP id nk12mr1018736pjb.50.1631611158933;
        Tue, 14 Sep 2021 02:19:18 -0700 (PDT)
Received: from MiBook.. ([209.9.72.213])
        by smtp.gmail.com with ESMTPSA id i21sm10851317pgn.93.2021.09.14.02.19.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Sep 2021 02:19:18 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>
Subject: [PATCH mptcp-next v3 2/8] mptcp: add start_seq in the msk
Date: Tue, 14 Sep 2021 17:19:01 +0800
Message-Id: <7b4984f87a23369f9e4896d959945d01289a721d.1631610729.git.geliangtang@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1631610729.git.geliangtang@gmail.com>
References: <cover.1631610729.git.geliangtang@gmail.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch added a new member named start_seq to the msk to keep track of
the beginning of the last fully-acked data segment. This would be updated
in __mptcp_clean_una.

Signed-off-by: Geliang Tang <geliangtang@gmail.com>
---
 net/mptcp/protocol.c | 3 +++
 net/mptcp/protocol.h | 1 +
 2 files changed, 4 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 71a5427609a9..e804ca0ac9e1 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1071,6 +1071,7 @@ static void __mptcp_clean_una(struct sock *sk)
 			WRITE_ONCE(msk->first_pending, mptcp_send_next(sk));
 		}
 
+		msk->start_seq = dfrag->data_seq;
 		dfrag_clear(sk, dfrag);
 		cleaned = true;
 	}
@@ -2891,6 +2892,7 @@ struct sock *mptcp_sk_clone(const struct sock *sk,
 	msk->wnd_end = msk->snd_nxt + req->rsk_rcv_wnd;
 	msk->setsockopt_seq = mptcp_sk(sk)->setsockopt_seq;
 	msk->last_retrans_seq = subflow_req->idsn - 1;
+	msk->start_seq = 0;
 
 	if (mp_opt->suboptions & OPTIONS_MPTCP_MPC) {
 		msk->can_ack = true;
@@ -3148,6 +3150,7 @@ void mptcp_finish_connect(struct sock *ssk)
 	WRITE_ONCE(msk->can_ack, 1);
 	WRITE_ONCE(msk->snd_una, msk->write_seq);
 	WRITE_ONCE(msk->last_retrans_seq, subflow->idsn - 1);
+	WRITE_ONCE(msk->start_seq, 0);
 
 	mptcp_pm_new_connection(msk, ssk, 0);
 
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index eb3473d128d4..5e07264ba62b 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -224,6 +224,7 @@ struct mptcp_sock {
 	u64		remote_key;
 	u64		write_seq;
 	u64		snd_nxt;
+	u64		start_seq;
 	u64		ack_seq;
 	u64		rcv_wnd_sent;
 	u64		rcv_data_fin_seq;
-- 
2.31.1

