Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABFCA2F80
	for <mptcp@lists.linux.dev>; Wed, 28 Apr 2021 07:01:18 +0000 (UTC)
Received: by mail-pl1-f180.google.com with SMTP id a11so1384391plh.3
        for <mptcp@lists.linux.dev>; Wed, 28 Apr 2021 00:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=J8df/LBBYyn7CulWHlpue0S9ZhzCoMx4SFZUSwlIuTI=;
        b=gmV3YURae3sJInowcdHtuLYSMhhbDMzA9cmCCJ6E4qWyVr2oxnq5oIrvaJ/8JLFQd2
         l5rP4FNpiD++Sqm5kCrmPoqMaQEwqZ2j4tTQhjUSZqRP+tc50Wk2jH8Sem5NDFq8cSha
         iQ1xRL4oHoM/+O/NepMC5l3ZNiLLI76IYEbkmMYCKIYai07TJf/E81DTKOgbZ/R4kvYL
         eDEqlOsPkAznSQlRpaKcmWat2yQEyzAHRaZMvcNNpo1XzQWllmxCNfntEfWI++aR8YJj
         ep/tj/yjeF/nyehrgVMDEqjgIoKLtDrPKYuQo7ak857N1MtNsJKn1nVibVpHwNjaiK2j
         /vug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=J8df/LBBYyn7CulWHlpue0S9ZhzCoMx4SFZUSwlIuTI=;
        b=tDiovBtABKDteNpMt7Z6+YdasbkVNUdTCsuxB4nuhuFJe+t/enLoAi2zS41CgWqZgW
         JI+uIiP9DHOD0DkYh5XNMHRTvOta/9WzFkdYFmc0QMci6Ki3/wgkzUDegqI3+ZwzkVG8
         PLGAPIcuz6Wpz6gT7ezFVtDDl0wPas7Z2k0Bq0J0FhNwIoKRuK1y8LB1D+4/zfB6mtL9
         jcavQZ63akq8sXY01k8vYyqM24FPiv75ZXmtkbkgOtmGcn5p4fjUcevHi4OWT/eU1+fW
         7bbPKRZXg64YInw5y+owVh8B+r/CaNa1x6tcHxwbtbesXbk9nR3iLakKou1AiF3+TNaV
         BHxw==
X-Gm-Message-State: AOAM531DgjRIWwlbtgjtMesuIpYJEE7WWTRPCBKSv0CICv5G0JGn82G2
	iqFnh6jpI0rNGIrsR2gBwItCFHP2FD0=
X-Google-Smtp-Source: ABdhPJyZyADg7l1WKmAixQkq6tb9Pn9L64uSrqmZ8HUuALzLMBj8qxJxU4fcKMCl26g4bx3kf8NLDw==
X-Received: by 2002:a17:90b:19ca:: with SMTP id nm10mr31897334pjb.175.1619593278102;
        Wed, 28 Apr 2021 00:01:18 -0700 (PDT)
Received: from localhost ([209.9.72.212])
        by smtp.gmail.com with ESMTPSA id 33sm1568451pgq.21.2021.04.28.00.01.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Apr 2021 00:01:17 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>
Subject: [MPTCP][PATCH v2 mptcp-next 3/4] mptcp: add deny_join_id0 in mptcp_options_received
Date: Wed, 28 Apr 2021 15:01:05 +0800
Message-Id: <c166cd5a8d0a2357650f0bb83f987deb4140ed23.1619592361.git.geliangtang@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <65d1e4e729dfbeb5d0e51760affe2745e211cb50.1619592361.git.geliangtang@gmail.com>
References: <cover.1619592361.git.geliangtang@gmail.com> <51758a7f629764dc91186acbf09665992e5b8e69.1619592361.git.geliangtang@gmail.com> <65d1e4e729dfbeb5d0e51760affe2745e211cb50.1619592361.git.geliangtang@gmail.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch added a new flag named deny_join_id0 in struct
mptcp_options_received. Set it when MP_CAPABLE with the flag
MPTCP_CAP_DENYJOIN_ID0 is received.

Also add a new flag deny_join_id0 in struct mptcp_pm_data. When the flag
mp_opt.deny_join_id0 is set, invoke mptcp_pm_deny_join_id0_received to
set the pm->deny_join_id0 flag.

In mptcp_pm_create_subflow_or_signal_addr, if the pm->deny_join_id0 flag
is set, and the remote address id is zero, stop this connection.

Signed-off-by: Geliang Tang <geliangtang@gmail.com>
---
 net/mptcp/options.c    |  6 ++++++
 net/mptcp/pm.c         | 10 ++++++++++
 net/mptcp/pm_netlink.c |  4 +++-
 net/mptcp/protocol.h   |  5 ++++-
 net/mptcp/subflow.c    |  2 ++
 5 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 58ea22bf3d3d..0618c2fd9887 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -77,6 +77,9 @@ static void mptcp_parse_option(const struct sk_buff *skb,
 		if (flags & MPTCP_CAP_CHECKSUM_REQD)
 			break;
 
+		if (flags & MPTCP_CAP_DENY_JOIN_ID0)
+			mp_opt->deny_join_id0 = 1;
+
 		mp_opt->mp_capable = 1;
 		if (opsize >= TCPOLEN_MPTCP_MPC_SYNACK) {
 			mp_opt->sndr_key = get_unaligned_be64(ptr);
@@ -342,6 +345,7 @@ void mptcp_get_options(const struct sk_buff *skb,
 	mp_opt->dss = 0;
 	mp_opt->mp_prio = 0;
 	mp_opt->reset = 0;
+	mp_opt->deny_join_id0 = 0;
 
 	length = (th->doff * 4) - sizeof(struct tcphdr);
 	ptr = (const unsigned char *)(th + 1);
@@ -1012,6 +1016,8 @@ void mptcp_incoming_options(struct sock *sk, struct sk_buff *skb)
 	}
 
 	mptcp_get_options(skb, &mp_opt);
+	if (mp_opt.deny_join_id0)
+		mptcp_pm_deny_join_id0_received(msk);
 	if (!check_fully_established(msk, sk, subflow, skb, &mp_opt))
 		return;
 
diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 9d00fa6d22e9..e3489766caf3 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -247,6 +247,15 @@ void mptcp_pm_mp_prio_received(struct sock *sk, u8 bkup)
 	mptcp_event(MPTCP_EVENT_SUB_PRIORITY, mptcp_sk(subflow->conn), sk, GFP_ATOMIC);
 }
 
+void mptcp_pm_deny_join_id0_received(struct mptcp_sock *msk)
+{
+	struct mptcp_pm_data *pm = &msk->pm;
+
+	spin_lock_bh(&pm->lock);
+	WRITE_ONCE(pm->deny_join_id0, true);
+	spin_unlock_bh(&pm->lock);
+}
+
 /* path manager helpers */
 
 bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, unsigned int remaining,
@@ -320,6 +329,7 @@ void mptcp_pm_data_init(struct mptcp_sock *msk)
 	WRITE_ONCE(msk->pm.addr_signal, 0);
 	WRITE_ONCE(msk->pm.accept_addr, false);
 	WRITE_ONCE(msk->pm.accept_subflow, false);
+	WRITE_ONCE(msk->pm.deny_join_id0, false);
 	msk->pm.status = 0;
 
 	spin_lock_init(&msk->pm.lock);
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index d094588afad8..1491a759a04a 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -456,10 +456,12 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 		if (local) {
 			struct mptcp_addr_info remote = { 0 };
 
+			remote_address((struct sock_common *)sk, &remote);
+			if (!remote.id && READ_ONCE(msk->pm.deny_join_id0))
+				return;
 			msk->pm.local_addr_used++;
 			msk->pm.subflows++;
 			check_work_pending(msk);
-			remote_address((struct sock_common *)sk, &remote);
 			spin_unlock_bh(&msk->pm.lock);
 			__mptcp_subflow_connect(sk, &local->addr, &remote,
 						local->flags, local->ifindex);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index fcbaf47ce3bc..270feb0a1cd8 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -134,7 +134,8 @@ struct mptcp_options_received {
 		rm_addr : 1,
 		mp_prio : 1,
 		echo : 1,
-		backup : 1;
+		backup : 1,
+		deny_join_id0 : 1;
 	u32	token;
 	u32	nonce;
 	u64	thmac;
@@ -189,6 +190,7 @@ struct mptcp_pm_data {
 	bool		work_pending;
 	bool		accept_addr;
 	bool		accept_subflow;
+	bool		deny_join_id0;
 	u8		add_addr_signaled;
 	u8		add_addr_accepted;
 	u8		local_addr_used;
@@ -669,6 +671,7 @@ void mptcp_pm_nl_addr_send_ack(struct mptcp_sock *msk);
 void mptcp_pm_rm_addr_received(struct mptcp_sock *msk,
 			       const struct mptcp_rm_list *rm_list);
 void mptcp_pm_mp_prio_received(struct sock *sk, u8 bkup);
+void mptcp_pm_deny_join_id0_received(struct mptcp_sock *msk);
 int mptcp_pm_nl_mp_prio_send_ack(struct mptcp_sock *msk,
 				 struct mptcp_addr_info *addr,
 				 u8 bkup);
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index fb5b6eb5bec9..72d4a1520ba5 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -405,6 +405,8 @@ static void subflow_finish_connect(struct sock *sk, const struct sk_buff *skb)
 			goto fallback;
 		}
 
+		if (mp_opt.deny_join_id0)
+			mptcp_pm_deny_join_id0_received(mptcp_sk(parent));
 		subflow->mp_capable = 1;
 		subflow->can_ack = 1;
 		subflow->remote_key = mp_opt.sndr_key;
-- 
2.30.2

