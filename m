Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B07CC71
	for <mptcp@lists.linux.dev>; Fri, 14 May 2021 14:32:25 +0000 (UTC)
Received: by mail-pj1-f50.google.com with SMTP id pi6-20020a17090b1e46b029015cec51d7cdso1721870pjb.5
        for <mptcp@lists.linux.dev>; Fri, 14 May 2021 07:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VJjBYpYoSd9fcpkY6wdrXT5dYkJikOPUmbJyJiITcXY=;
        b=IlWw/oOQNNwmihXzRuS8ZIG1/LjBlMx1Whg0g/7CtVKjoJeaO548fE98YizijL2831
         grTM+JOENDnnzak9JCmOVDqMHwQ6ztDdAHlra80wyytDQqAhOhSain+2QuF9zUL5A+bt
         v0zRTu399dQtkjKlWhpA1LSgdIYZjR2YTw8QwOltInyzbO0nYh4YIqF08HACLfaAh3BL
         EFR1Gl3wXIH5nlAN5RHbPOLHKYY4XLn0y02qLVeabfWLb93PZ6btrKhN1Vw3a+wuXYqE
         cbBPbARGoFIhln0I2L2dey1Ovc5Azo0MSmmn/jLvX15NEc9WJmjkJlljW4QxW2HGbxVu
         HDDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VJjBYpYoSd9fcpkY6wdrXT5dYkJikOPUmbJyJiITcXY=;
        b=CZWvzg5eHr2w13S/kZBrxrHLvfMKe6BB6SNS/D/58PF52gmUC8eNvwVtcQTOODkXM5
         gCsmnqZt7Men+P+LvjqGxBuQ45EJjFuJvcqVVZMhyT5QHPUb/x+2dGr7q2k628OeNtz2
         gQg20g6yEwJkiH8o9+Hr+RhLvRCayEhK38uT+5OWnnt6xCijipA5K5lux38M3XPq1mWT
         B2z3u4DQBbWyILBVS2LYTobiBjXm6U3FrVmB1qQOEmuciffFLnMbFZdcksbf0VWeNaYR
         p2TtKu0Ux4cDAGHwq6PNFxpWYz8t/G4PsR9BNjFR88o04dVwz+UrbYpBi5EQMnB4pLio
         VY1A==
X-Gm-Message-State: AOAM532NkTAhckQRaJa9bsH9wW88eYlZkHn1ns2pnQ61xFwt6slFAv0D
	k6JaPabhSc7zSt+s5DonelBuDWOqypc=
X-Google-Smtp-Source: ABdhPJz3Lj8cRCd4CW55mBscLpiJ2/O22zDXeFAjXFht+zbJGzPL5MfvPckss3m646ZZcP87WgFFjA==
X-Received: by 2002:a17:90a:ba01:: with SMTP id s1mr11596770pjr.74.1621002745165;
        Fri, 14 May 2021 07:32:25 -0700 (PDT)
Received: from localhost ([43.224.245.180])
        by smtp.gmail.com with ESMTPSA id n9sm4573293pgt.35.2021.05.14.07.32.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 May 2021 07:32:24 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>,
	Florian Westphal <fw@strlen.de>
Subject: [MPTCP][PATCH v6 mptcp-next 1/6] mptcp: add sysctl allow_join_initial_addr_port
Date: Fri, 14 May 2021 22:32:14 +0800
Message-Id: <d051657e9c51ccb27b32d443777896c6ae519444.1621002341.git.geliangtang@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1621002341.git.geliangtang@gmail.com>
References: <cover.1621002341.git.geliangtang@gmail.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch added a new sysctl, named allow_join_initial_addr_port, to
control whether allow peers to send join requests to the IP address and
port number used by the initial subflow.

Suggested-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Geliang Tang <geliangtang@gmail.com>
---
 Documentation/networking/mptcp-sysctl.rst | 13 +++++++++++++
 net/mptcp/ctrl.c                          | 16 ++++++++++++++++
 net/mptcp/protocol.h                      |  1 +
 3 files changed, 30 insertions(+)

diff --git a/Documentation/networking/mptcp-sysctl.rst b/Documentation/networking/mptcp-sysctl.rst
index ee06fd782465..76d939e688b8 100644
--- a/Documentation/networking/mptcp-sysctl.rst
+++ b/Documentation/networking/mptcp-sysctl.rst
@@ -32,3 +32,16 @@ checksum_enabled - BOOLEAN
 	per-namespace sysctl.
 
 	Default: 0
+
+allow_join_initial_addr_port - BOOLEAN
+	Allow peers to send join requests to the IP address and port number used
+	by the initial subflow if the value is 1. This controls a flag that is
+	sent to the peer at connection time, and whether such join requests are
+	accepted or denied.
+
+	Joins to addresses advertised with ADD_ADDR are not affected by this
+	value.
+
+	This is a per-namespace sysctl.
+
+	Default: 1
diff --git a/net/mptcp/ctrl.c b/net/mptcp/ctrl.c
index 6c2639bb9c19..7d738bd06f2c 100644
--- a/net/mptcp/ctrl.c
+++ b/net/mptcp/ctrl.c
@@ -24,6 +24,7 @@ struct mptcp_pernet {
 	u8 mptcp_enabled;
 	unsigned int add_addr_timeout;
 	u8 checksum_enabled;
+	u8 allow_join_initial_addr_port;
 };
 
 static struct mptcp_pernet *mptcp_get_pernet(struct net *net)
@@ -46,11 +47,17 @@ int mptcp_is_checksum_enabled(struct net *net)
 	return mptcp_get_pernet(net)->checksum_enabled;
 }
 
+int mptcp_allow_join_id0(struct net *net)
+{
+	return mptcp_get_pernet(net)->allow_join_initial_addr_port;
+}
+
 static void mptcp_pernet_set_defaults(struct mptcp_pernet *pernet)
 {
 	pernet->mptcp_enabled = 1;
 	pernet->add_addr_timeout = TCP_RTO_MAX;
 	pernet->checksum_enabled = 0;
+	pernet->allow_join_initial_addr_port = 1;
 }
 
 #ifdef CONFIG_SYSCTL
@@ -80,6 +87,14 @@ static struct ctl_table mptcp_sysctl_table[] = {
 		.extra1       = SYSCTL_ZERO,
 		.extra2       = SYSCTL_ONE
 	},
+	{
+		.procname = "allow_join_initial_addr_port",
+		.maxlen = sizeof(u8),
+		.mode = 0644,
+		.proc_handler = proc_dou8vec_minmax,
+		.extra1       = SYSCTL_ZERO,
+		.extra2       = SYSCTL_ONE
+	},
 	{}
 };
 
@@ -98,6 +113,7 @@ static int mptcp_pernet_new_table(struct net *net, struct mptcp_pernet *pernet)
 	table[0].data = &pernet->mptcp_enabled;
 	table[1].data = &pernet->add_addr_timeout;
 	table[2].data = &pernet->checksum_enabled;
+	table[3].data = &pernet->allow_join_initial_addr_port;
 
 	hdr = register_net_sysctl(net, MPTCP_SYSCTL_PATH, table);
 	if (!hdr)
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 868e878af526..3d6bbdf00bfb 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -543,6 +543,7 @@ static inline void mptcp_subflow_delegated_done(struct mptcp_subflow_context *su
 int mptcp_is_enabled(struct net *net);
 unsigned int mptcp_get_add_addr_timeout(struct net *net);
 int mptcp_is_checksum_enabled(struct net *net);
+int mptcp_allow_join_id0(struct net *net);
 void mptcp_subflow_fully_established(struct mptcp_subflow_context *subflow,
 				     struct mptcp_options_received *mp_opt);
 bool mptcp_subflow_data_available(struct sock *sk);
-- 
2.31.1

