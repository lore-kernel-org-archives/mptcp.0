Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF9071
	for <mptcp@lists.linux.dev>; Fri, 14 May 2021 14:32:35 +0000 (UTC)
Received: by mail-pg1-f169.google.com with SMTP id q15so20003636pgg.12
        for <mptcp@lists.linux.dev>; Fri, 14 May 2021 07:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Q6DPdU5vqqgpdTQhmTCh06KwCubJVcwvk7HBBp+dh5Y=;
        b=bF/kd4qG0cvX8qbVa2P2ZntDxzgsTWU0zYS+jh/5S8w4bhJyM3HY/ZB3Vc/3zinVZb
         pzlUY9vZ8nr2jaPA01RuB+uuMKH/5SMMozBqxsQlgyGhi+axYHXMNbNtIdfeE2IItm01
         4X6U7iHjGRjXZctofeBsseNzvGGi5IcKRwE2pm259wc0bbPIW7koWocFgPpuFsdBXZDL
         UY1rIQTHSaiszRy10Nex+HlvoctfLOY/sGe/kU5xEXb18K0BIwzOGNb73Hcp/gHA334Q
         amakNkeiuQWyTrJP/UK26fC5jIrqz3NAz3PEo5OmpO2/NBgnXvwTBWWj4G5EPBtO7wHE
         cP2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Q6DPdU5vqqgpdTQhmTCh06KwCubJVcwvk7HBBp+dh5Y=;
        b=jq1NDzMsBdPSvoDt640O6FOApqA16kWtmjdhYbh7X+UaLyu4fAEU40fddQHSy8dKkX
         v5FxpC6V2ZWVc+NAphANwimfU5kyRvdhJYdH6X9JbejKyO/8MekbOeouufeQd6ISMBAi
         wPzJeviJArMRRX2ng6xi/+SjZyQAnL0wP3RNDnPFUtub5WwdoWvwgk+tn9GqNZUrb+i5
         9uN81PTN0MccCNOroF3MLM5E2MgLSlc7av6Zr1OmROkcfUzuewbsVz6ova98tjj4/Aer
         BR13Hg+5Etuo4bpIxgUambRerQHR3Jt1/aI8o7Qd908XxbQZmyLLzX0mr6WEStnXDIZ9
         bw0A==
X-Gm-Message-State: AOAM531ShjRgmbTjEcOPorjGkhc84DLOb3wrPVgN1Y9Ex+Ixx9MjPUdq
	1wv8kZX3Af0uCiPWp+l7JiRQ7TEGYQo=
X-Google-Smtp-Source: ABdhPJw3yNJOdzkP6IgC2wGZzd7xQaGoULXev1Xr9A2OawzK1whfRP4OqqI3JZXcHe9ev/fTiLh2Og==
X-Received: by 2002:a65:50c5:: with SMTP id s5mr47204261pgp.138.1621002755404;
        Fri, 14 May 2021 07:32:35 -0700 (PDT)
Received: from localhost ([43.224.245.180])
        by smtp.gmail.com with ESMTPSA id ha14sm4924926pjb.40.2021.05.14.07.32.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 May 2021 07:32:35 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>,
	Florian Westphal <fw@strlen.de>
Subject: [MPTCP][PATCH v6 mptcp-next 5/6] mptcp: add deny_join_id0 in mptcp_options_received
Date: Fri, 14 May 2021 22:32:18 +0800
Message-Id: <774cef61ee52ed2c84c9113205b706e24c4d7c48.1621002341.git.geliangtang@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <850406b0f49fa0a76b4825b36c55426a0d033d52.1621002341.git.geliangtang@gmail.com>
References: <cover.1621002341.git.geliangtang@gmail.com> <d051657e9c51ccb27b32d443777896c6ae519444.1621002341.git.geliangtang@gmail.com> <2a6a925510a7d79f0c2101d5d353f6b74f0e69bb.1621002341.git.geliangtang@gmail.com> <ae0d32922128771f09b230e5718774472a088207.1621002341.git.geliangtang@gmail.com> <850406b0f49fa0a76b4825b36c55426a0d033d52.1621002341.git.geliangtang@gmail.com>
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
 net/mptcp/options.c    |  6 ++++++
 net/mptcp/pm.c         |  1 +
 net/mptcp/pm_netlink.c | 12 +++++++++++-
 net/mptcp/protocol.h   |  4 +++-
 net/mptcp/subflow.c    |  2 ++
 5 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 82fc481a25f0..bb600eb29f3c 100644
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
@@ -361,6 +364,7 @@ void mptcp_get_options(const struct sock *sk,
 	mp_opt->mp_prio = 0;
 	mp_opt->reset = 0;
 	mp_opt->csum_reqd = READ_ONCE(msk->csum_enabled);
+	mp_opt->deny_join_id0 = 0;
 
 	length = (th->doff * 4) - sizeof(struct tcphdr);
 	ptr = (const unsigned char *)(th + 1);
@@ -1048,6 +1052,8 @@ void mptcp_incoming_options(struct sock *sk, struct sk_buff *skb)
 	}
 
 	mptcp_get_options(sk, skb, &mp_opt);
+	if (mp_opt.deny_join_id0)
+		WRITE_ONCE(msk->pm.remote_deny_join_id0, true);
 	if (!check_fully_established(msk, sk, subflow, skb, &mp_opt))
 		return;
 
diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 9456fe17b6a3..23a309f641aa 100644
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
index 3fcc167ea702..bdc174cdb42e 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -461,10 +461,20 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 		if (local) {
 			struct mptcp_addr_info remote = { 0 };
 
+			remote_address((struct sock_common *)sk, &remote);
+			if (READ_ONCE(msk->pm.remote_deny_join_id0)) {
+				struct mptcp_pm_add_entry *entry;
+
+				entry = list_first_entry_or_null(&msk->pm.add_list,
+								 typeof(*entry), list);
+				if (!entry)
+					return;
+
+				remote = entry->addr;
+			}
 			msk->pm.local_addr_used++;
 			msk->pm.subflows++;
 			check_work_pending(msk);
-			remote_address((struct sock_common *)sk, &remote);
 			spin_unlock_bh(&msk->pm.lock);
 			__mptcp_subflow_connect(sk, &local->addr, &remote,
 						local->flags, local->ifindex);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 1df8da3da695..136b7f9b5cd9 100644
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
index 41e1b5091e42..0e6e9c9dc976 100644
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

