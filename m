Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFC6872
	for <mptcp@lists.linux.dev>; Sat,  8 May 2021 10:34:14 +0000 (UTC)
Received: by mail-pf1-f181.google.com with SMTP id i190so9627001pfc.12
        for <mptcp@lists.linux.dev>; Sat, 08 May 2021 03:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Bw0ftZvCnf68WU5l2lN70/KzKBWTxsRpFaY6nF/k0v8=;
        b=DqttpYgi5/pIS9VCX5yIOCLwa5N+MWtcG+lNCcgLC5GyR+4cB+hxuZ/qRcYI1eu7p6
         OzH15JSBBYSYJTLOwnDN5tn1vHzjWHTVVqbhAbxrBUdCh+7VtNICE+oSPu0Gotl+DF/v
         HraUDxB4viGh5QYF0JJT8JzZAjZEu2NnL4xgVzTssz4ZlIq+TLPKTR6kDn9OpWrV3gWB
         0Wbn65ALTZogOnlobRNCaaxftmP0nk4QaYoHzWVvlV9I5HRtawijDW19mG19qqt0Jc0p
         nRQB6DwU00HhW2JGt67HWw9XCcNuQiFQA7wePmJQlp6vjW5LhnzfmQvNqaAWrHGpzsI+
         dLcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Bw0ftZvCnf68WU5l2lN70/KzKBWTxsRpFaY6nF/k0v8=;
        b=awSZQ/9EcyRjjdWX1rCiL7plYYkmVJt4Xi27KQ3yayx5qZ2OqBnrcB0zA9jg3uNWNY
         eOZ/S55C9qxnWBGZLgBSEl8BOQIM2RpEVEks4i2eYxqwzkry7PDYHhGpGcS2Y3X0vU1K
         GHa+4qVx5qrYGAJmrBGVCcf73gYwZZlLvlBegpZLFTyglote77W9TF+dloJlB9gcUrRL
         LaTeMPp+h+PpRXg4I4f7V/ni/XC6oo/IAaluLcYLX4AL/Nz7bd0cXjrmdNUR4pdvI6lv
         4DOONZRpJGMLTmQPrHhnM8tQPm0TU6wqT6wXNNzv/Y8ucOV9qMF1eIyF6Y0S2mrTmZr9
         mlqw==
X-Gm-Message-State: AOAM5330mG0OqZspfDrl1hRKrxoOyf5J629Pze7jYNLZKbDdJVo9mGGx
	rwb5b58kI0WhQFAQN8f4yg7K1fuKVcw=
X-Google-Smtp-Source: ABdhPJwwYWx6vuuRkVxBzYB1O8et3gvQVig2zLmFUS889wFVdRpS1k/7GfBUTFQ3Y49KA8ux3YLSnw==
X-Received: by 2002:a62:18d7:0:b029:28c:fdfa:f95b with SMTP id 206-20020a6218d70000b029028cfdfaf95bmr15090297pfy.57.1620470054187;
        Sat, 08 May 2021 03:34:14 -0700 (PDT)
Received: from localhost ([209.9.72.213])
        by smtp.gmail.com with ESMTPSA id d129sm112364pfa.6.2021.05.08.03.34.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 May 2021 03:34:13 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>,
	Florian Westphal <fw@strlen.de>
Subject: [MPTCP][PATCH v5 mptcp-next 4/5] mptcp: add deny_join_id0 in mptcp_options_received
Date: Sat,  8 May 2021 18:33:27 +0800
Message-Id: <c9966a080be92cc508bfdeece2085cfaca7dbe2a.1620469774.git.geliangtang@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <b2a2ef7d225e72395055f34445968d25939b6b0f.1620469774.git.geliangtang@gmail.com>
References: <cover.1620469774.git.geliangtang@gmail.com> <0edd6a3ad45c1f67a350356298ed4333fc42dac3.1620469774.git.geliangtang@gmail.com> <04612972cea357bc84aa01e145ac689a8397f466.1620469774.git.geliangtang@gmail.com> <b2a2ef7d225e72395055f34445968d25939b6b0f.1620469774.git.geliangtang@gmail.com>
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
is set, use the first received ADD_ADDR address as the remote address to
connect.

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
index 441ec25e117d..b9188c53e58f 100644
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
index 47a515af2b0a..dddd7c5613fa 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -456,10 +456,20 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
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
index d19deee01896..5b2e72cf8e06 100644
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
index 249a66ad54dc..bb4bf31e73cf 100644
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

