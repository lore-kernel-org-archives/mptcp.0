Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5150F2F9D
	for <mptcp@lists.linux.dev>; Wed, 28 Apr 2021 15:34:28 +0000 (UTC)
Received: by mail-pf1-f182.google.com with SMTP id j6so4600828pfh.5
        for <mptcp@lists.linux.dev>; Wed, 28 Apr 2021 08:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+1a6jFZo8iDfbje+GbyyV+v7QwR0y3IK/YcAzSZiIJ4=;
        b=Pz0MELVsKc055udes9484bN2g1ObNu2GYHorXAN6Z9Gctt6U10U0NCMo9/iuJFO0nU
         yxIRyl3Sv2hmKrHYTObtaVxX+fCregoDuwpkHM4lziW3TnQ51yz8uaoXO+RmSXLy5sYD
         MRCuSQTKcd2DWF6QQbfhQycv0XYXpxOCmMTc8GsWVbpuVVSTFqokKce/E23PW7ajy7Tl
         V1DdxdmW9HG8w/fvwZ/k4PTKGBYVBD2QjfAr70YToWK5DtMHjCK7DxRZC1py/L6l4bNV
         trDwpUeTM/yAgAWjKPFu2/Cmd57q8/sj+6mTvZ62veEsKyzQyvism1E4pi6os/Udp6Cz
         cz9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+1a6jFZo8iDfbje+GbyyV+v7QwR0y3IK/YcAzSZiIJ4=;
        b=joM12y3q1MsheLX0iO4UvOinFIIwokfkeypUHpBHXRKJnR2w9aZg3g4sDhItSC5xWz
         CIX5TGJAjSanK/VIVDN+kine06laM+SGVGRG2pdrW3upJ0A8AQ0FXyP4RB4JIHDazIbH
         /dkaiMseRwY+oMna62EWYUgbXO/5XXVbu2AXg1MBJHkTHnxoSGoUe3ZAz+RmVC4Mlf26
         gGzrTzUrd3TbH/+9vgaxxOlDul9FQwqvBVAKscAlvUyR1G94xCSS61CigQz5hfCcf/b8
         99pxck38R5yRUDKg7aqxCN9tCOQsbRyHFi+E2OOLaLUY3CsafSnUfhhK265QTtSyq1/J
         LQSA==
X-Gm-Message-State: AOAM5334dNUGAYm+2RUfBj/ymN0cOET1h837skjkpJPHYvi/2hhowXh3
	gbvi5KrfP/yvcP2ReKzztmoIhcQy5kg=
X-Google-Smtp-Source: ABdhPJwwJK9vdm/6tqdv1XWIcQepee99Et/onZdUWy3Zf1whqGLwOwalEKbD9hFWRqmuASgbuHh5Bg==
X-Received: by 2002:a63:5c19:: with SMTP id q25mr28220736pgb.402.1619624067781;
        Wed, 28 Apr 2021 08:34:27 -0700 (PDT)
Received: from localhost ([209.9.72.213])
        by smtp.gmail.com with ESMTPSA id 128sm99879pfy.194.2021.04.28.08.34.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Apr 2021 08:34:27 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>
Subject: [MPTCP][PATCH v3 mptcp-next 3/4] mptcp: add deny_join_id0 in mptcp_options_received
Date: Wed, 28 Apr 2021 23:34:16 +0800
Message-Id: <45fac7966d2bfeae3027a9105ba9a6a2f35d6029.1619623735.git.geliangtang@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <972a77ea8b999cd2e0f8e32912156d5ac4b9a17e.1619623735.git.geliangtang@gmail.com>
References: <cover.1619623735.git.geliangtang@gmail.com> <952b920c38ab98adfdb77a0e941ff43c05461a0d.1619623735.git.geliangtang@gmail.com> <972a77ea8b999cd2e0f8e32912156d5ac4b9a17e.1619623735.git.geliangtang@gmail.com>
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
mp_opt.deny_join_id0 is set, set this pm->deny_join_id0 flag.

In mptcp_pm_create_subflow_or_signal_addr, if the pm->deny_join_id0 flag
is set, and the remote address id is zero, stop this connection.

Signed-off-by: Geliang Tang <geliangtang@gmail.com>
---
 net/mptcp/options.c    | 6 ++++++
 net/mptcp/pm.c         | 1 +
 net/mptcp/pm_netlink.c | 4 +++-
 net/mptcp/protocol.h   | 4 +++-
 net/mptcp/subflow.c    | 2 ++
 5 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 58ea22bf3d3d..4b6c58a13864 100644
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
+		WRITE_ONCE(msk->pm.deny_join_id0, true);
 	if (!check_fully_established(msk, sk, subflow, skb, &mp_opt))
 		return;
 
diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 9d00fa6d22e9..d79f015af525 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -320,6 +320,7 @@ void mptcp_pm_data_init(struct mptcp_sock *msk)
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
index fcbaf47ce3bc..baf21c53fb42 100644
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
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index fb5b6eb5bec9..2de3b91d1626 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -405,6 +405,8 @@ static void subflow_finish_connect(struct sock *sk, const struct sk_buff *skb)
 			goto fallback;
 		}
 
+		if (mp_opt.deny_join_id0)
+			WRITE_ONCE(mptcp_sk(parent)->pm.deny_join_id0, true);
 		subflow->mp_capable = 1;
 		subflow->can_ack = 1;
 		subflow->remote_key = mp_opt.sndr_key;
-- 
2.30.2

