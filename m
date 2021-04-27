Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 515C571
	for <mptcp@lists.linux.dev>; Tue, 27 Apr 2021 10:08:12 +0000 (UTC)
Received: by mail-pl1-f173.google.com with SMTP id s15so2180068plg.6
        for <mptcp@lists.linux.dev>; Tue, 27 Apr 2021 03:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hl2ltIkQVBv2JoR5C6O9868Ojlyn4iT6rsKzTQoTm7g=;
        b=EKr6dvLasz4gOpuyJqCZ0lAzwybkjqrHKgayRIGvROqJCmv+HFPFpH6qhgVjUMrXV1
         OrfCprGZjV8sUK5t/tmMPzOt7yyKE7Yob48imuy0S/4zWmPE0NeONYDkLcwXjIWQscb/
         0SP5nBWjTp+U7A06Xrsx95bvdfVjvBUA52+piRzVPBhtoMb93SnmARJYUMmnZPfR6Xo9
         KNEE0PV2La5XXeDkleIbYtADR6+fG857GVwuLBq9AAm/KnQ/0qhhE5pCxHu9wOx1xNOd
         Oc1qw1QJ+kizAldl5zXd2PcLLj4qiUfA2HKqSvEsMoF7dKlyvbK85QTb/Dpx2u+TcLAA
         o40g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hl2ltIkQVBv2JoR5C6O9868Ojlyn4iT6rsKzTQoTm7g=;
        b=l3W22iY8ozWc0vv8eBVVXn49i6l/rHHuwHo7tIyQKTO033Ffr87nNGjxWX/r7i6jiu
         vS7ArbhkTW/M+OVQ6nHrBIo3Ku7vdK5gFa0jZTwjF2Yio3og4fmGNVM+YuGhFVGPSq7d
         4HlwiV2nRRC0wVLoABEukqes2ou/I5fQ66YrYEv7cdvJ57HqKH50KA4uSrcwEp3TLMl4
         VfklmnaTaP7qtGc3DoTNfeEJSOGUy5ITqIh9F6LmEXnbQTtSHlQ7DfNOZL6detSWzOs1
         eNLiib8vcpZHjQfeGpw3Bi4zcJc8ABsEnrQbwQ8SmYvnyoAVF8bBFUYxIkBXX2xtkrgm
         gZgw==
X-Gm-Message-State: AOAM5316GrUJF0q4fqvH/DWQKspeQpjER2Qdf5zjfxnKZbPleuVRXoNl
	PXaXBLYcAdCTV9OYt8F/n7HQbbfIwYw=
X-Google-Smtp-Source: ABdhPJwuuPeAdfv4DiXG510NlIjsqb2kjHpMUXY4NOxtJeQnB9hHgqmtO5CJbi4bE1SsFGQwT16uxQ==
X-Received: by 2002:a17:902:d48c:b029:ec:f7ad:4b28 with SMTP id c12-20020a170902d48cb02900ecf7ad4b28mr16852866plg.60.1619518091801;
        Tue, 27 Apr 2021 03:08:11 -0700 (PDT)
Received: from localhost ([209.9.72.213])
        by smtp.gmail.com with ESMTPSA id lb2sm1777654pjb.53.2021.04.27.03.08.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Apr 2021 03:08:11 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>
Subject: [MPTCP][PATCH mptcp-next 4/5] mptcp: add join_denied in mptcp_sock
Date: Tue, 27 Apr 2021 18:07:56 +0800
Message-Id: <3afc2c7d715a21cf73d2573909be1e24fc89883e.1619517696.git.geliangtang@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <945e6d874461b595c1a08916d87cb4fed219ac40.1619517696.git.geliangtang@gmail.com>
References: <cover.1619517696.git.geliangtang@gmail.com> <b1aefbc214bea1e5cef3dcf3c1c0b5caf502734e.1619517696.git.geliangtang@gmail.com> <073e1b2e4f7d03b0302e8eacb235a728774b3104.1619517696.git.geliangtang@gmail.com> <945e6d874461b595c1a08916d87cb4fed219ac40.1619517696.git.geliangtang@gmail.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch added a new flag join_denied in struct mptcp_sock,
initialized as false in __mptcp_init_sock.

When MP_CAPABLE with the flag MPTCP_CAP_JOIN_DENIED is received, set the
join_denied to true.

In mptcp_syn_options, if the join_denied flag is set, and the remote
address id is zero, stop sending the join.

Signed-off-by: Geliang Tang <geliangtang@gmail.com>
---
 net/mptcp/options.c  | 8 ++++++++
 net/mptcp/protocol.c | 1 +
 net/mptcp/protocol.h | 1 +
 3 files changed, 10 insertions(+)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 7b354125f33b..068b104d8ca9 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -25,6 +25,8 @@ static void mptcp_parse_option(const struct sock *sk,
 			       const unsigned char *ptr, int opsize,
 			       struct mptcp_options_received *mp_opt)
 {
+	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(sk);
+	struct mptcp_sock *msk = mptcp_sk(subflow->conn);
 	u8 subtype = *ptr >> 4;
 	int expected_opsize;
 	u8 version;
@@ -78,6 +80,9 @@ static void mptcp_parse_option(const struct sock *sk,
 		if (flags & MPTCP_CAP_CHECKSUM_REQD)
 			break;
 
+		if (flags & MPTCP_CAP_JOIN_DENIED)
+			WRITE_ONCE(msk->join_denied, true);
+
 		mp_opt->mp_capable = 1;
 		if (opsize >= TCPOLEN_MPTCP_MPC_SYNACK) {
 			mp_opt->sndr_key = get_unaligned_be64(ptr);
@@ -376,6 +381,7 @@ bool mptcp_syn_options(struct sock *sk, const struct sk_buff *skb,
 		       unsigned int *size, struct mptcp_out_options *opts)
 {
 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(sk);
+	struct mptcp_sock *msk = mptcp_sk(subflow->conn);
 
 	/* we will use snd_isn to detect first pkt [re]transmission
 	 * in mptcp_established_options_mp()
@@ -389,6 +395,8 @@ bool mptcp_syn_options(struct sock *sk, const struct sk_buff *skb,
 	} else if (subflow->request_join) {
 		pr_debug("remote_token=%u, nonce=%u", subflow->remote_token,
 			 subflow->local_nonce);
+		if (!subflow->remote_id && READ_ONCE(msk->join_denied))
+			return false;
 		opts->suboptions = OPTION_MPTCP_MPJ_SYN;
 		opts->join_id = subflow->local_id;
 		opts->token = subflow->remote_token;
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index aec8e77b18e4..219455616f61 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2411,6 +2411,7 @@ static int __mptcp_init_sock(struct sock *sk)
 	msk->ack_hint = NULL;
 	msk->first = NULL;
 	inet_csk(sk)->icsk_sync_mss = mptcp_sync_mss;
+	WRITE_ONCE(msk->join_denied, false);
 
 	mptcp_pm_data_init(msk);
 
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 1d828668b15a..dc20b4d956ea 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -235,6 +235,7 @@ struct mptcp_sock {
 	bool		snd_data_fin_enable;
 	bool		rcv_fastclose;
 	bool		use_64bit_ack; /* Set when we received a 64-bit DSN */
+	bool		join_denied;
 	spinlock_t	join_list_lock;
 	struct sock	*ack_hint;
 	struct work_struct work;
-- 
2.30.2

