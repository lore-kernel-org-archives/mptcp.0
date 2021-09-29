Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C33273FCB
	for <mptcp@lists.linux.dev>; Wed, 29 Sep 2021 07:35:17 +0000 (UTC)
Received: by mail-pf1-f180.google.com with SMTP id 145so1190948pfz.11
        for <mptcp@lists.linux.dev>; Wed, 29 Sep 2021 00:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FppAX8eJVMLGTaoQvmG4lm2DAOe5YwddAwcA0vAT0p4=;
        b=qVmRaOlhls52Gd52XtFm2+pyPgAkWTewY6ytufacweHl15hySVRGe7Kau5axN20j8G
         HtJQu2WAeY18jHqu+akxgVMNi3CelN48AREL1aC82H287Nv6MFqbx5lOVG0S1lE0Ip32
         nD7ftllG5YuTSjQOp0u/bZqKiGUc+bMouLa6ZRgav7oHhIEekVTWiTVg1BwXUcCwjlyv
         SEVDyiEcW4aZrBAbId6l1x+TqZPvW/HOJqYJ8IBhax1YVNJAiYLlyHls7NuHOSAZ8KSL
         XwHZdKW3sezqiSEFp97Gms4hdrbugowcjpgHtnf1/Jj3GuF07B2R+lv+eAeQAfFTP0Qo
         DKcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FppAX8eJVMLGTaoQvmG4lm2DAOe5YwddAwcA0vAT0p4=;
        b=pkooS2lOKSWh8ul8zObpT5Iv/ZVBZUom3fd5pMlDrOgWON9pwdca6gu45MgRUkRXdn
         pX8v31u42G2Ag83lWkd+ZLBThoeqduexKpo29zwX3386gSgtX5nLC0yhUFUAowI/AMp0
         qLQl5S06TdHB9W+AG7YPO3afDB/ivPbPpBe+aJf3N3ps4hIblP/D4vxvN/hAS3uRHx7f
         oB0bvi5de6q/p0JKD4XyPspQSMMSvuLNCCsl7AeYmbt60rqJbwHuQSf+HqrDE4GoA1P6
         dDNoJcuKThr37osHbmWimR9ztPjPxkZQaCBol4oVIajfCdy1EOOpciC6TUZm2r48o2pV
         CzkA==
X-Gm-Message-State: AOAM531716FHQLDpBgHUB1BohtoZsxpT7pXgYgRq47O/PGuh/kqU2Mr3
	GZU7cQk8Kc6gr/2f3oPksmvdz+KeBLjSeA==
X-Google-Smtp-Source: ABdhPJxGy5d1f2sOd/5CoHmxVhQ/DbSqy66RnXcq0a2ez4P7IeGfsti14lu1YvMHXtTiPtnCeflcGw==
X-Received: by 2002:a62:1683:0:b0:3f3:814f:4367 with SMTP id 125-20020a621683000000b003f3814f4367mr9715382pfw.68.1632900917255;
        Wed, 29 Sep 2021 00:35:17 -0700 (PDT)
Received: from MiBook.mioffice.cn ([209.9.72.212])
        by smtp.gmail.com with ESMTPSA id gn11sm937853pjb.36.2021.09.29.00.35.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Sep 2021 00:35:16 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH mptcp-next v6 3/9] mptcp: track and update contiguous data status
Date: Wed, 29 Sep 2021 15:35:01 +0800
Message-Id: <9bed3d49d6b462cebc714587fc48d14402269349.1632900306.git.geliangtang@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1632900306.git.geliangtang@gmail.com>
References: <cover.1632900306.git.geliangtang@gmail.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch added a new member allow_infinite_fallback in mptcp_sock,
which gets initialized to 'true' when the connection begins and is set
to 'false' on any retransmit or successful MP_JOIN.

Rename the helper function mptcp_is_data_contiguous() to
mptcp_allow_infinite_fallback(). In it, only do infinite mapping fallback
if there is a single subflow AND there have been no retransmissions AND
there have never been any MP_JOINs.

Suggested-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Geliang Tang <geliangtang@gmail.com>
---
 net/mptcp/protocol.c |  2 ++
 net/mptcp/protocol.h | 10 +++++++---
 net/mptcp/subflow.c  |  2 +-
 3 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index f8ad049d6941..48979cb82126 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2464,6 +2464,7 @@ static void __mptcp_retrans(struct sock *sk)
 		dfrag->already_sent = max(dfrag->already_sent, info.sent);
 		tcp_push(ssk, 0, info.mss_now, tcp_sk(ssk)->nonagle,
 			 info.size_goal);
+		WRITE_ONCE(msk->allow_infinite_fallback, false);
 	}
 
 	release_sock(ssk);
@@ -2542,6 +2543,7 @@ static int __mptcp_init_sock(struct sock *sk)
 	msk->first = NULL;
 	inet_csk(sk)->icsk_sync_mss = mptcp_sync_mss;
 	WRITE_ONCE(msk->csum_enabled, mptcp_is_checksum_enabled(sock_net(sk)));
+	WRITE_ONCE(msk->allow_infinite_fallback, true);
 	msk->recovery = false;
 
 	mptcp_pm_data_init(msk);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 7379ab580a7e..4807e486e762 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -249,6 +249,7 @@ struct mptcp_sock {
 	bool		rcv_fastclose;
 	bool		use_64bit_ack; /* Set when we received a 64-bit DSN */
 	bool		csum_enabled;
+	bool		allow_infinite_fallback;
 	spinlock_t	join_list_lock;
 	struct work_struct work;
 	struct sk_buff  *ooo_last_skb;
@@ -612,17 +613,20 @@ static inline void mptcp_subflow_tcp_fallback(struct sock *sk,
 	inet_csk(sk)->icsk_af_ops = ctx->icsk_af_ops;
 }
 
-static inline bool mptcp_has_another_subflow(struct sock *ssk)
+static inline bool mptcp_allow_infinite_fallback(struct sock *ssk)
 {
 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk), *tmp;
 	struct mptcp_sock *msk = mptcp_sk(subflow->conn);
 
 	mptcp_for_each_subflow(msk, tmp) {
+		if (tmp->mp_join)
+			return false;
+
 		if (tmp != subflow)
-			return true;
+			return false;
 	}
 
-	return false;
+	return READ_ONCE(msk->allow_infinite_fallback);
 }
 
 void __init mptcp_proto_init(void);
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 87a9ffebcc42..28ed7dc6e170 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1167,7 +1167,7 @@ static bool subflow_check_data_avail(struct sock *ssk)
 	if (!__mptcp_check_fallback(msk)) {
 		/* RFC 8684 section 3.7. */
 		if (subflow->send_mp_fail) {
-			if (mptcp_has_another_subflow(ssk)) {
+			if (!mptcp_allow_infinite_fallback(ssk)) {
 				ssk->sk_err = EBADMSG;
 				tcp_set_state(ssk, TCP_CLOSE);
 				subflow->reset_transient = 0;
-- 
2.31.1

