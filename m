Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B481E2FB1
	for <mptcp@lists.linux.dev>; Mon, 24 May 2021 07:07:35 +0000 (UTC)
Received: by mail-pj1-f43.google.com with SMTP id q6so14300812pjj.2
        for <mptcp@lists.linux.dev>; Mon, 24 May 2021 00:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mkGpVsD+u+ZfjtXc3EL4gJRgI5tONntnk7TSqOq+LB0=;
        b=i5umm5toy/1dcDZF7lZ3Eo4DulAf/ZKjBod23tGz2FnZcvDd8Faa8GmCcLygxwY8rJ
         lqjDbKoddTgN7vDfPUt0LWo3lsGmZY8bxBUdAu9tOjMmIKEvYpC88uxOpCkVy6fBCwfs
         6Tx29bDI2uhQQMGmWRqC85IMmGxW8n4OYF+CtghmZDjyHLAgUU1fF2E2a13TUb5/S4Yl
         /bX7fUesHJSt/wPHEzjYfsggh0mKePE2T6wXaeye/Lc5JsbCF3fd9jys/xRXLuZl6Jji
         AmDiwdHvDtK+I5X1utyv7Bnfyb7XQ7dRz74PuFzZ3AlXG4YNes21Yvn1KPmP2eWy4rNq
         CDeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mkGpVsD+u+ZfjtXc3EL4gJRgI5tONntnk7TSqOq+LB0=;
        b=mzEsO+FdCwJAdqf+vz8h1RCWy2q7vOW7lRB362BPOPshbS7Z5OpqsW76zlST3lUQSl
         /rSjGEbD4oVeTYB6EHbt/1oh+dSZBaggg2pIyPmom4nJBc6ZPt66yvTrRvngM2u5RPUP
         5g4nQXXUClkgqW4JF2EXIgatxOcRmXJVx2UXIp5kPThJfm9DWP2Xbcom6xpkvi2X8QDN
         C6SqgLwsxPPS3ME44S80RY4yF8slWuYCtbro/cIH/70IbAt96Pb7CwIPEpNdyTSU2LKc
         zAauYWL6tgzuz9ENYGTiYWDkea1G+WcR50XJSKN1s64pKj8AesaxzdJW2xmpv1F4FDIk
         2zhg==
X-Gm-Message-State: AOAM532dg0vkSYyrUvIfR/bocwe9eNzYmspwKuohSb3XadwOpA1dQrEh
	BRP8YvDjEZDKO8/OsMqgRiIBFiVH3nk04w==
X-Google-Smtp-Source: ABdhPJx5poQlTv3jun2D8SswyznNtYPwzm6+B/Q5juC7o/6LarjlKAzHbAVuljcIXtOTNyXzKJxE/g==
X-Received: by 2002:a17:903:4115:b029:f8:c1c4:2a2d with SMTP id r21-20020a1709034115b02900f8c1c42a2dmr8657746pld.83.1621840055169;
        Mon, 24 May 2021 00:07:35 -0700 (PDT)
Received: from localhost ([209.9.72.213])
        by smtp.gmail.com with ESMTPSA id f2sm10570064pgl.67.2021.05.24.00.07.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 May 2021 00:07:34 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>,
	Florian Westphal <fw@strlen.de>
Subject: [MPTCP][PATCH v7 mptcp-next 4/5] mptcp: add deny_join_id0 in mptcp_options_received
Date: Mon, 24 May 2021 15:07:18 +0800
Message-Id: <bf509b3a9206c58444fcb9efa7d7d8b0ba8568dc.1621839764.git.geliangtang@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <c27772875a9bf14dd336526f48676f368758be97.1621839764.git.geliangtang@gmail.com>
References: <cover.1621839764.git.geliangtang@gmail.com> <7df5c99cf5336e3c1b0225903c75d01bbcde8daf.1621839764.git.geliangtang@gmail.com> <372e8fb0d481dfed41cf7e01c60b18c55a852f7e.1621839764.git.geliangtang@gmail.com> <c27772875a9bf14dd336526f48676f368758be97.1621839764.git.geliangtang@gmail.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch added a new flag named deny_join_id0 in struct
mptcp_options_received. Set it when MP_CAPABLE with the flag
MPTCP_CAP_DENYJOIN_ID0 is received.

Also add a new flag remote_deny_join_id0 in struct mptcp_pm_data. When the
flag deny_join_id0 is set, set this remote_deny_join_id0 flag.

In mptcp_pm_create_subflow_or_signal_addr, if the remote_deny_join_id0 flag
is set, and the remote address id is zero, stop this connection.

Suggested-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Geliang Tang <geliangtang@gmail.com>
---
 net/mptcp/options.c    | 6 ++++++
 net/mptcp/pm.c         | 1 +
 net/mptcp/pm_netlink.c | 8 +++++++-
 net/mptcp/protocol.h   | 4 +++-
 net/mptcp/subflow.c    | 2 ++
 5 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 1e921b5103bf..0d30008f0313 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -83,6 +83,9 @@ static void mptcp_parse_option(const struct sk_buff *skb,
 		if (flags & MPTCP_CAP_CHECKSUM_REQD)
 			mp_opt->csum_reqd = 1;
 
+		if (flags & MPTCP_CAP_DENY_JOIN_ID0)
+			mp_opt->deny_join_id0 = 1;
+
 		mp_opt->mp_capable = 1;
 		if (opsize >= TCPOLEN_MPTCP_MPC_SYNACK) {
 			mp_opt->sndr_key = get_unaligned_be64(ptr);
@@ -360,6 +363,7 @@ void mptcp_get_options(const struct sock *sk,
 	mp_opt->mp_prio = 0;
 	mp_opt->reset = 0;
 	mp_opt->csum_reqd = READ_ONCE(msk->csum_enabled);
+	mp_opt->deny_join_id0 = 0;
 
 	length = (th->doff * 4) - sizeof(struct tcphdr);
 	ptr = (const unsigned char *)(th + 1);
@@ -1047,6 +1051,8 @@ void mptcp_incoming_options(struct sock *sk, struct sk_buff *skb)
 	}
 
 	mptcp_get_options(sk, skb, &mp_opt);
+	if (mp_opt.deny_join_id0)
+		WRITE_ONCE(msk->pm.remote_deny_join_id0, true);
 	if (!check_fully_established(msk, sk, subflow, skb, &mp_opt))
 		return;
 
diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index edc57ff4c1dd..4d26cfacb1de 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -321,6 +321,7 @@ void mptcp_pm_data_init(struct mptcp_sock *msk)
 	WRITE_ONCE(msk->pm.addr_signal, 0);
 	WRITE_ONCE(msk->pm.accept_addr, false);
 	WRITE_ONCE(msk->pm.accept_subflow, false);
+	WRITE_ONCE(msk->pm.remote_deny_join_id0, false);
 	msk->pm.status = 0;
 
 	spin_lock_init(&msk->pm.lock);
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 795f6d84bbfc..4e9943ddac50 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -456,10 +456,16 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 		if (local) {
 			struct mptcp_addr_info remote = { 0 };
 
+			remote_address((struct sock_common *)sk, &remote);
+			if (READ_ONCE(msk->pm.remote_deny_join_id0)) {
+				if (!msk->pm.add_cached.id)
+					return;
+
+				remote = msk->pm.add_cached;
+			}
 			msk->pm.local_addr_used++;
 			msk->pm.subflows++;
 			check_work_pending(msk);
-			remote_address((struct sock_common *)sk, &remote);
 			spin_unlock_bh(&msk->pm.lock);
 			__mptcp_subflow_connect(sk, &local->addr, &remote,
 						local->flags, local->ifindex);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index d28f6cdc9798..6ab29e5076aa 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -138,7 +138,8 @@ struct mptcp_options_received {
 		mp_prio : 1,
 		echo : 1,
 		csum_reqd : 1,
-		backup : 1;
+		backup : 1,
+		deny_join_id0 : 1;
 	u32	token;
 	u32	nonce;
 	u64	thmac;
@@ -194,6 +195,7 @@ struct mptcp_pm_data {
 	bool		work_pending;
 	bool		accept_addr;
 	bool		accept_subflow;
+	bool		remote_deny_join_id0;
 	u8		add_addr_signaled;
 	u8		add_addr_accepted;
 	u8		local_addr_used;
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 0f4dc708e9b2..629be94f4d75 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -408,6 +408,8 @@ static void subflow_finish_connect(struct sock *sk, const struct sk_buff *skb)
 
 		if (mp_opt.csum_reqd)
 			WRITE_ONCE(mptcp_sk(parent)->csum_enabled, true);
+		if (mp_opt.deny_join_id0)
+			WRITE_ONCE(mptcp_sk(parent)->pm.remote_deny_join_id0, true);
 		subflow->mp_capable = 1;
 		subflow->can_ack = 1;
 		subflow->remote_key = mp_opt.sndr_key;
-- 
2.31.1

