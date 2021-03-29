Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 479CF5F
	for <mptcp@lists.linux.dev>; Mon, 29 Mar 2021 10:40:56 +0000 (UTC)
Received: by mail-pj1-f48.google.com with SMTP id q6-20020a17090a4306b02900c42a012202so5705575pjg.5
        for <mptcp@lists.linux.dev>; Mon, 29 Mar 2021 03:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gr19O/KR3TgER2zbnwZ3lflTbpA6uf1N1OMR65tI024=;
        b=dOAzciQlXypNpUUsREzDjCBuFSUkRUxAr98K2+6WFKXEsVLRx66eJskqIG6PcFhNoQ
         Z41DudMpgqZK9qhFUDr0KSYi/MKNtvCR0Ukit6vdyhTS8uVPs8Vrfcr+/TEyU9kF4N7H
         yGtv1W9QSjZQt42bhMIYg30J1IQP4dsFvrE0RAS2IVyK9nax4iQrxzwa7TzrRMQWKmoc
         HQcMaNVgMhxcimBkKDJAt7PIwYFL2u6cj+VwusBFkQr6V55eqNB32sKy4aWpbM8HzUXZ
         Bp5bE6n2jrCdNvycWtm/DjPiZ9ZzR1pZ1cBENzQWm5H7KxqhogzGbgpkUYGy0LYzyW+q
         Gh9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gr19O/KR3TgER2zbnwZ3lflTbpA6uf1N1OMR65tI024=;
        b=dKR5UlIuLg/8J1yrMv4M0Ma+150G7quwStslryuBEKGxg1x6zvXVnzqIGT0ailvVv1
         IMiP2jL8JCOU/3WaOAG0c/PgeCjP3p0rUm64KvgRHy/HrR2X6EGck6mQaWm55Pse+12R
         63ZgTJ6TGkDep4sp60KuJzzdmgGcr6vPDZVaAnOnCPpay0jBRKdTIRtox6N3S7TeMDgX
         pN1bZwLm0JiQ9Ik4gb+7tjJTmwom/GR+CsugBLv6oe4Y5dpTbqTWhGKLp4kxlMH4SILa
         AQpzgLRVTvQCOAIg4Hxby3WXS06SXHkuRiK/EMRIWy3UKlISPNaN1B6mEL/Hu7BVnytd
         XG6Q==
X-Gm-Message-State: AOAM531Racjq/PqVD6sJEl94ff4hH+Zc5g1Z3jKr0ACqfErvZu9QhD83
	oZBXajmjd8tqU6mOH/dNfwR0RzW5cd7vgg==
X-Google-Smtp-Source: ABdhPJyll3F6TDjyS+cWw58wARZDgiwfWT5zApaRdOzrN6aP0yMkV6kBmvh2/Kq0Yxb2ugzATwOmqQ==
X-Received: by 2002:a17:90a:8908:: with SMTP id u8mr25080337pjn.135.1617014455577;
        Mon, 29 Mar 2021 03:40:55 -0700 (PDT)
Received: from localhost ([43.224.245.180])
        by smtp.gmail.com with ESMTPSA id f23sm16322861pfa.85.2021.03.29.03.40.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Mar 2021 03:40:55 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>
Subject: [MPTCP][PATCH v2 mptcp-next 01/16] mptcp: add csum_enabled in mptcp_sock
Date: Mon, 29 Mar 2021 18:40:32 +0800
Message-Id: <ee1d26bf90397d9cbec5e4a165fc369ffab60d3e.1617014019.git.geliangtang@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1617014019.git.geliangtang@gmail.com>
References: <cover.1617014019.git.geliangtang@gmail.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch added a new member named csum_enabled in struct mptcp_sock,
used a dummy mptcp_is_checksum_enabled() helper to initialize it.

Signed-off-by: Geliang Tang <geliangtang@gmail.com>
---
 net/mptcp/protocol.c | 1 +
 net/mptcp/protocol.h | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 0265b8be0f84..56103814afed 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2368,6 +2368,7 @@ static int __mptcp_init_sock(struct sock *sk)
 	msk->ack_hint = NULL;
 	msk->first = NULL;
 	inet_csk(sk)->icsk_sync_mss = mptcp_sync_mss;
+	WRITE_ONCE(msk->csum_enabled, mptcp_is_checksum_enabled(sock_net(sk)));
 
 	mptcp_pm_data_init(msk);
 
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 20770fe39ea5..826019bb2093 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -233,6 +233,7 @@ struct mptcp_sock {
 	bool		snd_data_fin_enable;
 	bool		rcv_fastclose;
 	bool		use_64bit_ack; /* Set when we received a 64-bit DSN */
+	bool		csum_enabled;
 	spinlock_t	join_list_lock;
 	struct sock	*ack_hint;
 	struct work_struct work;
@@ -519,6 +520,7 @@ static inline void mptcp_subflow_delegated_done(struct mptcp_subflow_context *su
 
 int mptcp_is_enabled(struct net *net);
 unsigned int mptcp_get_add_addr_timeout(struct net *net);
+static inline int mptcp_is_checksum_enabled(struct net *net) { return false; }
 void mptcp_subflow_fully_established(struct mptcp_subflow_context *subflow,
 				     struct mptcp_options_received *mp_opt);
 bool mptcp_subflow_data_available(struct sock *sk);
-- 
2.30.2

