Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9C3071
	for <mptcp@lists.linux.dev>; Thu,  6 May 2021 04:48:21 +0000 (UTC)
Received: by mail-pg1-f177.google.com with SMTP id m37so3866895pgb.8
        for <mptcp@lists.linux.dev>; Wed, 05 May 2021 21:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IqeTve6QriXWWc4oolxh8Ndb3Ly54ts6owA0Tft+dJU=;
        b=U0PvZc8lIHqpXlHvJNCtcXRi+woy35+bwMrodXf4Sly3wlOkMwSYji7Uc4utwIRbZk
         LQTdY5bOMz3vsPCv68q3ZE1rwUquvywpWUWoAS+LTP7j3oLNLJG5rzbb7ZbsxVfH91MA
         SlEEs5Ueo7CeDHQ8tegufggVzNBUHgVhVWtwyXD57bkMVD9l0Uis59O34Rr+6nmwiTFa
         6vKYf+dWLfhvIfvfFBqV98WyvBP9U3Az0oCaNtpKG+D9a2xqxJDGdRghMXLoZp0qt8ZP
         spY5lLxBXBkg39LGbja3yv0X/nNv4u9tLr/p8M8fCgEc1UowgliCsMKBm7i0owLfRl53
         4gFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IqeTve6QriXWWc4oolxh8Ndb3Ly54ts6owA0Tft+dJU=;
        b=lbIMD3z/+CCxBkrdE5G8Tk3DMMxCvA4lNBbHPNWSk6t7iMfpLCzKJfScHxUiFdBvbc
         cXrariZ83NEQJDCPBtUTyLT54oFgAdCByv4gUHZgfpWKaOIUqVudNjo1MocamboVmZ0s
         U0mxUJ9BVxa82V5/f3N6l/vOqPzgEbi/YlJipOUK9XtGRsU9OeDGNs38WFYAA2PLDv/n
         DZZv7aZu5+yS7dLue9HR4eZlKdZsL7ZXvqCDGb78GltyAF/uWDEiBJl236inY7vHem7u
         xUPPdB/FleSKOtLNc2TQaoaPToi66uL+PZsItErSmgMx9OdX7bHsOxSxuA+GrBuuO742
         cdsA==
X-Gm-Message-State: AOAM531wCmty0qr9vWfjYSQWqGLNPR9LNhKJrSQdZTP2kd+QmhAJb6nu
	c0UvRLhl9+p9pwIxHLQFNMmqSmrKU/M=
X-Google-Smtp-Source: ABdhPJy3RS1/4FC0hexQsd+kXFSc/DMv5Ho0PbyP956vCUwzb8wdOlKhfUV9d9q28picRuc29RanbA==
X-Received: by 2002:a63:b10:: with SMTP id 16mr2497546pgl.90.1620276501265;
        Wed, 05 May 2021 21:48:21 -0700 (PDT)
Received: from localhost ([209.9.72.213])
        by smtp.gmail.com with ESMTPSA id j21sm8843822pjl.27.2021.05.05.21.48.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 May 2021 21:48:21 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>,
	Florian Westphal <fw@strlen.de>
Subject: [MPTCP][PATCH v4 mptcp-next 3/4] mptcp: add deny_join_id0 in mptcp_options_received
Date: Thu,  6 May 2021 12:48:07 +0800
Message-Id: <2b2c8a35b85111f472e735f29166e1f88ecc3909.1620275759.git.geliangtang@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <75cdf44b996264eeacf424f60fecd873ebc47d39.1620275759.git.geliangtang@gmail.com>
References: <cover.1620275759.git.geliangtang@gmail.com> <025c3e92286c1c425b6ce65b4feac7e416947e54.1620275759.git.geliangtang@gmail.com> <75cdf44b996264eeacf424f60fecd873ebc47d39.1620275759.git.geliangtang@gmail.com>
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
 net/mptcp/pm_netlink.c | 4 +++-
 net/mptcp/protocol.h   | 4 +++-
 net/mptcp/subflow.c    | 2 ++
 5 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 630c87c62a87..4179287bd647 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -87,6 +87,9 @@ static void mptcp_parse_option(const struct sock *sk,
 		if (flags & MPTCP_CAP_CHECKSUM_REQD)
 			mp_opt->csum_reqd = 1;
 
+		if (flags & MPTCP_CAP_DENY_JOIN_ID0)
+			mp_opt->deny_join_id0 = 1;
+
 		mp_opt->mp_capable = 1;
 		if (opsize >= TCPOLEN_MPTCP_MPC_SYNACK) {
 			mp_opt->sndr_key = get_unaligned_be64(ptr);
@@ -363,6 +366,7 @@ void mptcp_get_options(const struct sock *sk,
 	mp_opt->mp_prio = 0;
 	mp_opt->reset = 0;
 	mp_opt->csum_reqd = 0;
+	mp_opt->deny_join_id0 = 0;
 
 	length = (th->doff * 4) - sizeof(struct tcphdr);
 	ptr = (const unsigned char *)(th + 1);
@@ -1055,6 +1059,8 @@ void mptcp_incoming_options(struct sock *sk, struct sk_buff *skb)
 	}
 
 	mptcp_get_options(sk, skb, &mp_opt);
+	if (mp_opt.deny_join_id0)
+		WRITE_ONCE(msk->pm.remote_deny_join_id0, true);
 	if (!check_fully_established(msk, sk, subflow, skb, &mp_opt))
 		return;
 
diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 9d00fa6d22e9..639271e09604 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -320,6 +320,7 @@ void mptcp_pm_data_init(struct mptcp_sock *msk)
 	WRITE_ONCE(msk->pm.addr_signal, 0);
 	WRITE_ONCE(msk->pm.accept_addr, false);
 	WRITE_ONCE(msk->pm.accept_subflow, false);
+	WRITE_ONCE(msk->pm.remote_deny_join_id0, false);
 	msk->pm.status = 0;
 
 	spin_lock_init(&msk->pm.lock);
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index d094588afad8..58161510feef 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -456,10 +456,12 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 		if (local) {
 			struct mptcp_addr_info remote = { 0 };
 
+			remote_address((struct sock_common *)sk, &remote);
+			if (!remote.id && READ_ONCE(msk->pm.remote_deny_join_id0))
+				return;
 			msk->pm.local_addr_used++;
 			msk->pm.subflows++;
 			check_work_pending(msk);
-			remote_address((struct sock_common *)sk, &remote);
 			spin_unlock_bh(&msk->pm.lock);
 			__mptcp_subflow_connect(sk, &local->addr, &remote,
 						local->flags, local->ifindex);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index fd6fe3176e08..41baa2ffc9a9 100644
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
@@ -193,6 +194,7 @@ struct mptcp_pm_data {
 	bool		work_pending;
 	bool		accept_addr;
 	bool		accept_subflow;
+	bool		remote_deny_join_id0;
 	u8		add_addr_signaled;
 	u8		add_addr_accepted;
 	u8		local_addr_used;
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 324aff0b2f16..659b8842ae3b 100644
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

