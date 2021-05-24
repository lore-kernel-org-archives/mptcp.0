Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2813D2FB2
	for <mptcp@lists.linux.dev>; Mon, 24 May 2021 07:07:27 +0000 (UTC)
Received: by mail-pl1-f173.google.com with SMTP id h12so2001834plf.11
        for <mptcp@lists.linux.dev>; Mon, 24 May 2021 00:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gMCKa3I+OdVG15KKyUTExe9FHj8cubNYgH9GkLPxXkQ=;
        b=BxV7oXU/hsozjH2LPL8XNhMF/EVfBDhFySr/ezxHAGz4phIMDyu8r2nZtQwuNUh2xy
         mQ5OP56Ewjtn/plWkdVBytrJWIIzIDpqchKTX7/mEWQZuOAJD1MNWKP9jkPWnIx7kSse
         +La8I7EH5U/dtGXlkqZQXp2Qdh1mhfYsJ1hQI5Z1CGjoh5tQcI1SQCctzkVTmUVd+9bE
         83OFNE/jTcJfBKkvOBMjpH8ZLp7XhE+g41cwW/VfONLqBl+tdmoPKJARitaNF3xysgTn
         C9HnOSR+rs3H+CtaNjgFKSBUHxnDvH6ogKpbvgdUY5i/JRJV1cKYfRRhSBS5rhU8XoEh
         NMDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gMCKa3I+OdVG15KKyUTExe9FHj8cubNYgH9GkLPxXkQ=;
        b=mlKzjsoEVEK0++mGOsOWPjS9wTBOzWz8SwIm9+3fLJLdJoZuLTBn2+meKvBsl/7ZPr
         rAmSQr9xPFpW9woEX1fq7MlePR/BTCkB7KA38Lg9kWO4WExK8ypdfAhCoYKeQ2zmwouG
         HUN0Vb9VpTd3RwQ/kYiPP5DzXalCImJFFABAXcVZYD6Bn+VlMRGrBW1s/FozBF+Dg1hq
         VQrEbFJx5G0/UkWW7+gLoRVVXXsklFQzt56xHrtSYTCISgE506mPJjZti0ePPdZoOurl
         KQn6KZrn/oeo8KFxVq8ZFWkc0BHMkYsnOYlOyXOTrKtenAfIjB5JeCFdA2Cm2QpAzMEj
         m7TA==
X-Gm-Message-State: AOAM532gZzUrxPHYq9GRGW/iK6Tk6DbIHLYdMAsrHwLp2U3UdiuyDF8d
	4gcaImnOqQMlR+UsILC2N8x7KIKQ1zLDgg==
X-Google-Smtp-Source: ABdhPJyGHQzbu4rNpcagOO68cgbVKfRd7jWUeueEU0XIJzzb2sHuNAJw2hDCKjsnLtbe9zTWUPmOJw==
X-Received: by 2002:a17:90b:94b:: with SMTP id dw11mr24244872pjb.86.1621840046641;
        Mon, 24 May 2021 00:07:26 -0700 (PDT)
Received: from localhost ([209.9.72.213])
        by smtp.gmail.com with ESMTPSA id k21sm10320274pgb.56.2021.05.24.00.07.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 May 2021 00:07:26 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>,
	Florian Westphal <fw@strlen.de>
Subject: [MPTCP][PATCH v7 mptcp-next 1/5] mptcp: add sysctl allow_join_initial_addr_port
Date: Mon, 24 May 2021 15:07:15 +0800
Message-Id: <7df5c99cf5336e3c1b0225903c75d01bbcde8daf.1621839764.git.geliangtang@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1621839764.git.geliangtang@gmail.com>
References: <cover.1621839764.git.geliangtang@gmail.com>
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
index 16e50caf200e..c07db980b5da 100644
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

