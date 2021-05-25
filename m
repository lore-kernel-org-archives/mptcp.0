Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AEB170
	for <mptcp@lists.linux.dev>; Tue, 25 May 2021 09:17:18 +0000 (UTC)
Received: by mail-pf1-f174.google.com with SMTP id e17so12516465pfl.5
        for <mptcp@lists.linux.dev>; Tue, 25 May 2021 02:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Bivm2+CXlf+9WWCoscq7mDjfUNQM6qwfEvoAS8hWdHs=;
        b=UGIK2opBe+c2J27TgLUEfPJHKEzXyvn6TZtCBV17vFwxHDqvcl6Ewzn+ePMxITyQTf
         4JZ3JDRTQI2PqqLc3knCJiZHUoIxJDvYnNd/cSw/gMJcjoJ2zbOUYlybU9lxD/1IIK1I
         pCt3Ml4RqGDDq7uODopB7QuWvYZiOsI6tYcnxbcqVlf5C4PSwn9+S40LmpvpCUWJ9bwG
         hdrZWSlFGS3FAjfI9oNYvGd2l0cmOgW7ln7DM8M59f0jYOW5LFRlcQO+aLYl27lyG6SJ
         wIH5MiH+ya9nJ3lx8IjBkHCrj7KwwoifS4WXYkfz1UBndlXgHHdIjlbf0yPG7SCEepbR
         I+BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Bivm2+CXlf+9WWCoscq7mDjfUNQM6qwfEvoAS8hWdHs=;
        b=D7DYf9R6yBr5vHRPjaAwqHVSEQLq4YWjaacuRq1zg+C2xQMTx474J3KlAzU9hWoFBG
         lyd6dauAgBgfImrnx4M5xzNsTw/gubHXg1eA7bKoT5Q9j0wZr6kbFeyjWf7yrmlwm9gP
         vqhy5CnTcso0DfU9QcrceiZlipok28j5yIW5Yzlp/P11cuVLLASnokeRrw/+wxSrsTUC
         sIcpfWECsUkZTMxBxtTKxYLtk35rg5s2rNbc4KSS6uVIlGlB9djI0HKIWZekEKZ3n2YF
         SoZOKQ2Z/Z0I8JSWIIx60Yo3UnwwkZNFe79hFXkp6t5cBjbud2RzTnr5TJ7vWE9BVlLu
         M/1Q==
X-Gm-Message-State: AOAM530pgshpg1NfNDEdLbKAj10dNn9B/KHyfnVKLt5cK5mTNLUCs1Ep
	nyS/uDMOYF0cR3HQcfK1iN/eAmaQZooT0A==
X-Google-Smtp-Source: ABdhPJycR7Qn22zrrbPW0GyEoijGf5LPM4dFQ2ucC8hszQJRtpZpAg1MyR5EhrL5ALmfq9OP7UdVmg==
X-Received: by 2002:aa7:8a18:0:b029:2dd:42f3:d42f with SMTP id m24-20020aa78a180000b02902dd42f3d42fmr29134045pfa.70.1621934237765;
        Tue, 25 May 2021 02:17:17 -0700 (PDT)
Received: from localhost ([43.224.245.180])
        by smtp.gmail.com with ESMTPSA id z1sm8777801pff.194.2021.05.25.02.17.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 May 2021 02:17:17 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>,
	Florian Westphal <fw@strlen.de>
Subject: [MPTCP][PATCH v8 mptcp-next 3/4] mptcp: add deny_join_id0 in mptcp_options_received
Date: Tue, 25 May 2021 17:17:05 +0800
Message-Id: <5111dfce361c87c83e5355e78e55b6f593bac55b.1621933974.git.geliangtang@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <57e35b700b797c875966ae26252ae07316853837.1621933974.git.geliangtang@gmail.com>
References: <cover.1621933974.git.geliangtang@gmail.com> <b7f8df04d7b08026ee10cf2a784afda85e8cf6df.1621933974.git.geliangtang@gmail.com> <57e35b700b797c875966ae26252ae07316853837.1621933974.git.geliangtang@gmail.com>
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
 net/mptcp/pm_netlink.c | 3 ++-
 net/mptcp/protocol.h   | 4 +++-
 net/mptcp/subflow.c    | 2 ++
 5 files changed, 14 insertions(+), 2 deletions(-)

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
index 09722598994d..e6a3f0a550bf 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -451,7 +451,8 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 
 	/* check if should create a new subflow */
 	if (msk->pm.local_addr_used < local_addr_max &&
-	    msk->pm.subflows < subflows_max) {
+	    msk->pm.subflows < subflows_max &&
+	    !READ_ONCE(msk->pm.remote_deny_join_id0)) {
 		local = select_local_address(pernet, msk);
 		if (local) {
 			struct mptcp_addr_info remote = { 0 };
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 1201ab04bcdf..bdf4a832975d 100644
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

