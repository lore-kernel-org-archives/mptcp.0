Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 586216E
	for <mptcp@lists.linux.dev>; Mon, 22 Mar 2021 11:37:39 +0000 (UTC)
Received: by mail-pl1-f170.google.com with SMTP id v8so6407392plz.10
        for <mptcp@lists.linux.dev>; Mon, 22 Mar 2021 04:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4iFHrAoE8R4QD6voDOO5H+bjbttaBjxYMhhHvW4Rnaw=;
        b=ovm9yASM5r+TAEiqt5g6ICg6aZXAqfFQImGa15g8q1vtRK1D8Ed9s9nOC6exYCP7V1
         mCKiVTRl56f2qATH1PuBPgPgVjzK7i/4XTNBOvzZ80ZYyLSXfIqRjE3v477FZpxRsrp5
         nu2YKIWsgrjIpPuic0Z1L6KEi6qUiEGCVlVVcjrcX2xrYND43Wvfs7fl3LGgWvhDQibq
         W1vaoeBfi3Qh+0XjcBP/IUviOX/y7P74dEq4EB7BbseGdmAE5je1JaO2w2SwL0DEc/cP
         ojRHg7FevtgpZIQE/G5t2QRF7M1k4KbqqGImjMgv9nyCaUJUO57nDxauBeRqJSWHri/K
         +4Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4iFHrAoE8R4QD6voDOO5H+bjbttaBjxYMhhHvW4Rnaw=;
        b=H2A5sUtODg/8AL0lAKEBi7mcOdhklLHPliPJVnZQ+WUE6U1Rlb8meu3Ci4eyC8dGBq
         SFMrXEgtyNearQ9XXiZlEcaawkQd6Ge7NLRByjZsW7bcWADGqFQiasV7MC7oZasKDJfd
         p+DG8nDMB0o9v34ErtxERC6P05vEd+wZKaq1eD3AD9zyFlU8o3WR3CdLHx1itOPc7yvp
         c1VUE33wS1sTTlZ/pDPS8FCtVY70XCDpMJKl8H1gMsPU+5DOQX3HLr/6uwFab5cnbHrl
         xgXvJEDJ6q48bHyUu9LR1zLi1b1w3iD6die+HIx88wdR6pnm5v97udjYKQQXf2xa8Ruk
         CxDA==
X-Gm-Message-State: AOAM531SUCf8goLWtlIB2Gsm+goeYZc6rgl/UBe49ep4kor/SL00irMa
	3q+ftyyHJSZ4y8bQWy6T+ys=
X-Google-Smtp-Source: ABdhPJyXOyoeIbBTiRgkIM4Or5I01REK9bskbuB8tObBMbypb4Bvqx3JiOiTIOMrak/6QR6aWr2szw==
X-Received: by 2002:a17:902:9795:b029:e4:888f:7390 with SMTP id q21-20020a1709029795b02900e4888f7390mr26694677plp.26.1616413058895;
        Mon, 22 Mar 2021 04:37:38 -0700 (PDT)
Received: from localhost ([43.224.245.180])
        by smtp.gmail.com with ESMTPSA id e190sm13161613pfe.3.2021.03.22.04.37.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 04:37:38 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.01.org,
	mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>
Subject: [MPTCP][PATCH mptcp-next 1/6] mptcp: add a new sysctl checksum_enabled
Date: Mon, 22 Mar 2021 19:37:25 +0800
Message-Id: <e56c579836e40e330bfd24a191fd0c313a9e4634.1616412490.git.geliangtang@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1616412490.git.geliangtang@gmail.com>
References: <cover.1616412490.git.geliangtang@gmail.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch added a new sysctl, named checksum_enabled, to control
whether DSS checksum can be enabled.

Signed-off-by: Geliang Tang <geliangtang@gmail.com>
---
 Documentation/networking/mptcp-sysctl.rst |  8 ++++++++
 net/mptcp/ctrl.c                          | 14 ++++++++++++++
 net/mptcp/protocol.h                      |  1 +
 3 files changed, 23 insertions(+)

diff --git a/Documentation/networking/mptcp-sysctl.rst b/Documentation/networking/mptcp-sysctl.rst
index 6af0196c4297..1128e09d6c4d 100644
--- a/Documentation/networking/mptcp-sysctl.rst
+++ b/Documentation/networking/mptcp-sysctl.rst
@@ -24,3 +24,11 @@ add_addr_timeout - INTEGER (seconds)
 	sysctl.
 
 	Default: 120
+
+checksum_enabled - INTEGER
+	Control whether DSS checksum can be enabled.
+
+	DSS checksum can be enabled if the value is nonzero. This is a
+	per-namespace sysctl.
+
+	Default: 1
diff --git a/net/mptcp/ctrl.c b/net/mptcp/ctrl.c
index 96ba616f59bf..115cebc8c02a 100644
--- a/net/mptcp/ctrl.c
+++ b/net/mptcp/ctrl.c
@@ -19,6 +19,7 @@ struct mptcp_pernet {
 
 	int mptcp_enabled;
 	unsigned int add_addr_timeout;
+	int checksum_enabled;
 };
 
 static struct mptcp_pernet *mptcp_get_pernet(struct net *net)
@@ -36,6 +37,11 @@ unsigned int mptcp_get_add_addr_timeout(struct net *net)
 	return mptcp_get_pernet(net)->add_addr_timeout;
 }
 
+int mptcp_is_checksum_enabled(struct net *net)
+{
+	return mptcp_get_pernet(net)->checksum_enabled;
+}
+
 static struct ctl_table mptcp_sysctl_table[] = {
 	{
 		.procname = "enabled",
@@ -52,6 +58,12 @@ static struct ctl_table mptcp_sysctl_table[] = {
 		.mode = 0644,
 		.proc_handler = proc_dointvec_jiffies,
 	},
+	{
+		.procname = "checksum_enabled",
+		.maxlen = sizeof(int),
+		.mode = 0644,
+		.proc_handler = proc_dointvec,
+	},
 	{}
 };
 
@@ -59,6 +71,7 @@ static void mptcp_pernet_set_defaults(struct mptcp_pernet *pernet)
 {
 	pernet->mptcp_enabled = 1;
 	pernet->add_addr_timeout = TCP_RTO_MAX;
+	pernet->checksum_enabled = 1;
 }
 
 static int mptcp_pernet_new_table(struct net *net, struct mptcp_pernet *pernet)
@@ -75,6 +88,7 @@ static int mptcp_pernet_new_table(struct net *net, struct mptcp_pernet *pernet)
 
 	table[0].data = &pernet->mptcp_enabled;
 	table[1].data = &pernet->add_addr_timeout;
+	table[2].data = &pernet->checksum_enabled;
 
 	hdr = register_net_sysctl(net, MPTCP_SYSCTL_PATH, table);
 	if (!hdr)
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 14f0114be17a..fd36239d8905 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -519,6 +519,7 @@ static inline void mptcp_subflow_delegated_done(struct mptcp_subflow_context *su
 
 int mptcp_is_enabled(struct net *net);
 unsigned int mptcp_get_add_addr_timeout(struct net *net);
+int mptcp_is_checksum_enabled(struct net *net);
 void mptcp_subflow_fully_established(struct mptcp_subflow_context *subflow,
 				     struct mptcp_options_received *mp_opt);
 bool mptcp_subflow_data_available(struct sock *sk);
-- 
2.30.2

