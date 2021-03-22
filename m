Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57A5B6E
	for <mptcp@lists.linux.dev>; Mon, 22 Mar 2021 11:37:45 +0000 (UTC)
Received: by mail-pl1-f180.google.com with SMTP id k4so6405796plk.5
        for <mptcp@lists.linux.dev>; Mon, 22 Mar 2021 04:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4mw0GHeP9VY2PD6cQhVbhChoxpLXLvooWtUPMRqTjDM=;
        b=tSKEeMBJRoroeykw06SwajGo7kzkxyLhB6UnPR2g+WTNyvjBro8dSt94/zedyBuUfN
         vWHO4DaBHpStEmaI+6yemS0HTQj171zufX3bBhbmrB6Ba9ThzDF+/9ZsDCUI+130HVGX
         LV8Ge8dFHISdhYBrEWENGadRX1qojd2rfpbgc22Bu/HLLaZU42zJ+J7jPFgeGClzMsp9
         pwv4kUVb6CM/bUiyDO1zlNoA2nCG7s27ljQJDoPiGrztbPYcms54CkDX/xb00vryI89j
         B5xrKUkY6+C3M56RuC9eDdmCvVsnYuDVIPYdYAgmImrQTkTxazcvvmUOL0prI4EruQVd
         xvbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4mw0GHeP9VY2PD6cQhVbhChoxpLXLvooWtUPMRqTjDM=;
        b=qANxYRaCs+uu7SVIEhs6DtiFb6mW5Fq8ROu2GgQm6bczeX/hnbECx86FqgFp9m14xb
         q1I+9By7SO1LiC68VCc9PXAQGT0XaPQH9XFJ+Eycyjsrx9KgaPjceXeSHS7iHd48BItC
         2h67D1HWyH8BNIKWxmr32C9alUMsFAycgmLc3r9RtFURhjXTBXQUxqtsLnyo5owznlyG
         jGqsZUeWyifM/4PHij3BeZx5fe3f6Lvv2wPOPWrYmFnl7bFMzEz0RmTMVI/31iy10R3W
         s2q3JL60QaBFeEUNQxLAFFeRLqOM94h2QJmo4XuT06igXRvZx2AgLYqRRBK5VrsOTzfD
         1pEg==
X-Gm-Message-State: AOAM533vRH9RjaoibIrgjf9dYNdMJEUjpZRziczqkzdDrDHb5vnbjqqt
	I7W5CqFxEX87wLWPcyEfVbhgsp/aC3dARw==
X-Google-Smtp-Source: ABdhPJycTVSJ/y8sQZIztYstfoaHLMCGevbJnt3SUWcSbh2cGPedQ/T0m0lZ1eX3d/RC/ATHBnXrxA==
X-Received: by 2002:a17:902:ed0c:b029:e5:d0a4:9793 with SMTP id b12-20020a170902ed0cb02900e5d0a49793mr27123671pld.10.1616413064969;
        Mon, 22 Mar 2021 04:37:44 -0700 (PDT)
Received: from localhost ([43.224.245.180])
        by smtp.gmail.com with ESMTPSA id s1sm13609279pjo.36.2021.03.22.04.37.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 04:37:44 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.01.org,
	mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>
Subject: [MPTCP][PATCH mptcp-next 3/6] mptcp: add the csum_reqd fields
Date: Mon, 22 Mar 2021 19:37:27 +0800
Message-Id: <33da8b854a7397e7ecc807b335a0c7e69e023ca6.1616412490.git.geliangtang@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <7ad133370d4bb939ba69e35203797494181873b0.1616412490.git.geliangtang@gmail.com>
References: <cover.1616412490.git.geliangtang@gmail.com> <e56c579836e40e330bfd24a191fd0c313a9e4634.1616412490.git.geliangtang@gmail.com> <7ad133370d4bb939ba69e35203797494181873b0.1616412490.git.geliangtang@gmail.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch added a new flag csum_reqd in struct mptcp_options_received, if
the flag MPTCP_CAP_CHECKSUM_REQD is set in the receiving MP_CAPABLE
suboption, set this csum_reqd flag.

It also added another new csum_reqd member in struct mptcp_sock too, if the
csum_reqd flag in mptcp_options_received is set, set this member to true.

Signed-off-by: Geliang Tang <geliangtang@gmail.com>
---
 net/mptcp/options.c  | 8 +++++---
 net/mptcp/protocol.c | 1 +
 net/mptcp/protocol.h | 2 ++
 net/mptcp/subflow.c  | 4 ++++
 4 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index f45bebb923dc..bdced173edff 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -69,11 +69,9 @@ static void mptcp_parse_option(const struct sk_buff *skb,
 		 * "If a checksum is not present when its use has been
 		 * negotiated, the receiver MUST close the subflow with a RST as
 		 * it is considered broken."
-		 *
-		 * We don't implement DSS checksum - fall back to TCP.
 		 */
 		if (flags & MPTCP_CAP_CHECKSUM_REQD)
-			break;
+			mp_opt->csum_reqd = 1;
 
 		mp_opt->mp_capable = 1;
 		if (opsize >= TCPOLEN_MPTCP_MPC_SYNACK) {
@@ -340,6 +338,7 @@ void mptcp_get_options(const struct sk_buff *skb,
 	mp_opt->dss = 0;
 	mp_opt->mp_prio = 0;
 	mp_opt->reset = 0;
+	mp_opt->csum_reqd = 0;
 
 	length = (th->doff * 4) - sizeof(struct tcphdr);
 	ptr = (const unsigned char *)(th + 1);
@@ -1013,6 +1012,9 @@ void mptcp_incoming_options(struct sock *sk, struct sk_buff *skb)
 		mptcp_schedule_work((struct sock *)msk);
 	}
 
+	if (mp_opt.csum_reqd)
+		WRITE_ONCE(msk->csum_reqd, true);
+
 	if (mp_opt.add_addr && add_addr_hmac_valid(msk, &mp_opt)) {
 		if (!mp_opt.echo) {
 			mptcp_pm_add_addr_received(msk, &mp_opt.addr);
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 9d7e7e13fba8..94c3568c7a60 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2364,6 +2364,7 @@ static int __mptcp_init_sock(struct sock *sk)
 	msk->ack_hint = NULL;
 	msk->first = NULL;
 	inet_csk(sk)->icsk_sync_mss = mptcp_sync_mss;
+	WRITE_ONCE(msk->csum_reqd, mptcp_is_checksum_enabled(sock_net(sk)));
 
 	mptcp_pm_data_init(msk);
 
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 14f1e2fd3c08..4fc4871595ef 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -132,6 +132,7 @@ struct mptcp_options_received {
 		rm_addr : 1,
 		mp_prio : 1,
 		echo : 1,
+		csum_reqd : 1,
 		backup : 1;
 	u32	token;
 	u32	nonce;
@@ -233,6 +234,7 @@ struct mptcp_sock {
 	bool		snd_data_fin_enable;
 	bool		rcv_fastclose;
 	bool		use_64bit_ack; /* Set when we received a 64-bit DSN */
+	bool		csum_reqd;
 	spinlock_t	join_list_lock;
 	struct sock	*ack_hint;
 	struct work_struct work;
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index e2e9cc34713d..9fec1a273100 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -403,6 +403,8 @@ static void subflow_finish_connect(struct sock *sk, const struct sk_buff *skb)
 			goto fallback;
 		}
 
+		if (mp_opt.csum_reqd)
+			WRITE_ONCE(mptcp_sk(parent)->csum_reqd, true);
 		subflow->mp_capable = 1;
 		subflow->can_ack = 1;
 		subflow->remote_key = mp_opt.sndr_key;
@@ -643,6 +645,8 @@ static struct sock *subflow_syn_recv_sock(const struct sock *sk,
 		new_msk = mptcp_sk_clone(listener->conn, &mp_opt, req);
 		if (!new_msk)
 			fallback = true;
+		else if (mp_opt.csum_reqd)
+			WRITE_ONCE(mptcp_sk(new_msk)->csum_reqd, true);
 	} else if (subflow_req->mp_join) {
 		mptcp_get_options(skb, &mp_opt);
 		if (!mp_opt.mp_join || !subflow_hmac_valid(req, &mp_opt) ||
-- 
2.30.2

