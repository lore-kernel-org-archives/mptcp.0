Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F2902FB0
	for <mptcp@lists.linux.dev>; Tue, 25 May 2021 09:17:12 +0000 (UTC)
Received: by mail-pl1-f181.google.com with SMTP id q16so255333pls.6
        for <mptcp@lists.linux.dev>; Tue, 25 May 2021 02:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gMCKa3I+OdVG15KKyUTExe9FHj8cubNYgH9GkLPxXkQ=;
        b=ISqG2MCH8NPmfIjKXwnJjy6JcT2cDLQdLJMKmPTOuuG+RB4TskPquRZ60H3PRj1+LU
         PTozpSs/eYwvHmKXKDPT4TCrbMtMzyTiXE87Fc7dFVwVoH7vGT8CQf5DUVyitUs7u5hc
         umLfuYBqvZIyuiYgOY+xLkcOU7v/LOqcqnVPl/z9lg6Pj1zaQX0rNOvyzN7F4vmRV23E
         7vx6MEiQiOIpz98+1IkA/JZZFP867ypCngq6fBeTrl4IgTjStyfl9IgGh0RfieOqVdZj
         xK5mtEwuean4HYZtGeNxlA1NZuXKPMfrQK72HBOY5lm5lPw3xK0DL/K26AdBeeGKGUBE
         MnXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gMCKa3I+OdVG15KKyUTExe9FHj8cubNYgH9GkLPxXkQ=;
        b=t3W3w5vwhnKnAoQ/TIh0MzS/CH1tkbR7O0eoPsexZcVrhHV6KyTbMPdrXdGoIW8G2i
         SkYqnFuTCUBmm4IFXNrxQ69fHacgRW8s9oclsvFmKZy0EQwzgbMu4tkMUjKOyxpvEmeK
         KLea5Ew+LGImp5gshloEadnNTuLfnA6n6caToGRUpZlOsnKwaeuiUHFjwF2D0MTu5G2h
         TxWVEJ7xPrwdBpEVPFLg/aRNQZuOMdmQJ0WbxKZRpK9O0jMaxj+zzvvSgKS4Btybhkf+
         W/k8HgwUzkeMuhuLu2XCx7AsgoLDD/Pjk6CEejMNwaDr8ukvqYoJmvm3rVvJJW0WLuCe
         C85g==
X-Gm-Message-State: AOAM533JkIE1blA+DVhYd8lA17/Q72dpTErtNxvjpojmL8s8jOxueXgk
	FAXov3/21Gbr8rnrEfYvbjc8QiGXkaFxOA==
X-Google-Smtp-Source: ABdhPJwDn815X+myLl+hxbeHXwKtADm6RRRtJvq0d9FrmwMaJbSf5sX2tJXUR8tL5XkvJAlwDKNxHg==
X-Received: by 2002:a17:90a:6644:: with SMTP id f4mr30014508pjm.154.1621934231953;
        Tue, 25 May 2021 02:17:11 -0700 (PDT)
Received: from localhost ([43.224.245.180])
        by smtp.gmail.com with ESMTPSA id h24sm13440024pfn.180.2021.05.25.02.17.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 May 2021 02:17:11 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>,
	Florian Westphal <fw@strlen.de>
Subject: [MPTCP][PATCH v8 mptcp-next 1/4] mptcp: add sysctl allow_join_initial_addr_port
Date: Tue, 25 May 2021 17:17:03 +0800
Message-Id: <b7f8df04d7b08026ee10cf2a784afda85e8cf6df.1621933974.git.geliangtang@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1621933974.git.geliangtang@gmail.com>
References: <cover.1621933974.git.geliangtang@gmail.com>
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

