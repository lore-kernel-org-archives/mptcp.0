Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC73E71
	for <mptcp@lists.linux.dev>; Thu,  6 May 2021 04:48:16 +0000 (UTC)
Received: by mail-pf1-f172.google.com with SMTP id i13so4344730pfu.2
        for <mptcp@lists.linux.dev>; Wed, 05 May 2021 21:48:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8CTRfYcyqRjo9A5S73+wjjqhzQL/vzbt5fY3a33esBc=;
        b=YeuAjIMfOQxr7qVRpzzM2783VfWW673uvb69iKGrLhm3TFEn4WFyhEduLVqgTUWFB9
         FdCZUbmKqGU2BwKO6OJ3dmIbQNncTTEwSLDeO1cbb5t3g2bleYJX5TMHjyQTss0nSwT+
         xvoL//2gHTb5lGLZlsMwxjl73cil8uLFhPogcrCQnwoK56RkcNfStrlptgyuCVIz4p2y
         +JKCLtxR+EbVQmR+4oTeT4+2oyiqVcBn9VYcgmH0CAYyUazur+UP2GAYRVV/wcs4ocD/
         5k3e/vuYsg9q/Cqozval5mOz+w+R3owaHeDQ2m+mI8lY+sE3aTRf6Rn0mxTgJMtuuHEX
         dnZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8CTRfYcyqRjo9A5S73+wjjqhzQL/vzbt5fY3a33esBc=;
        b=j8GWDXh1IevtyLfz5a0E3AN4zuR3JhtbY38Pi7P8/KxPJ+N7S+fURQePfMZxwLVl/9
         3MQeTsmZO7ae0Slzt4xqX5DssB5XklbdOY5XwQ9jvPeJ1590bZj/3zALNhHj8STs9ahW
         3WzNyu8yf/Z0QwMVM0VxDFZoXmwejAZH1KsmWVbgi6AVnrGCSrD8p3vh0mzTMuDDDGwS
         82gb7xz0IcqcdBo6NlYRh/7QuU0COhLZBCyxWXlheC6kDyCl7fpIgxlR3D26zolAWVp+
         eAtJZ+i8YiElb1/Bw8LqIXVo9N9qByG6c4znUS7sQ1UmXtnJoD6u5GGL/FdiRtOPR5Q1
         IHyg==
X-Gm-Message-State: AOAM532oInfZWMDCCbdHxXbViNy6E8TJR7jTzv/cq28sVITf3P97dI11
	8lPzW5OLCyZMJ6pfezQPQzMcpBG+yN8=
X-Google-Smtp-Source: ABdhPJwy0OZc7+Gto9uo7mptip7X2jSIez+xB2qa32AlXws55Dl3FgdXg02rjA/PHPU3bHWhqmUXhQ==
X-Received: by 2002:a65:538d:: with SMTP id x13mr2409263pgq.108.1620276496214;
        Wed, 05 May 2021 21:48:16 -0700 (PDT)
Received: from localhost ([209.9.72.213])
        by smtp.gmail.com with ESMTPSA id t15sm711069pgh.33.2021.05.05.21.48.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 May 2021 21:48:16 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>,
	Florian Westphal <fw@strlen.de>
Subject: [MPTCP][PATCH v4 mptcp-next 1/4] mptcp: add sysctl allow_join_initial_addr_port
Date: Thu,  6 May 2021 12:48:05 +0800
Message-Id: <025c3e92286c1c425b6ce65b4feac7e416947e54.1620275759.git.geliangtang@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1620275759.git.geliangtang@gmail.com>
References: <cover.1620275759.git.geliangtang@gmail.com>
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
index b5ff77dae503..786055b0c6eb 100644
--- a/net/mptcp/ctrl.c
+++ b/net/mptcp/ctrl.c
@@ -24,6 +24,7 @@ struct mptcp_pernet {
 	u8 mptcp_enabled;
 	unsigned int add_addr_timeout;
 	u8 checksum_enabled;
+	u8 allow_join_initial_addr_port;
 };
 
 static struct mptcp_pernet *mptcp_get_pernet(struct net *net)
@@ -46,6 +47,7 @@ static void mptcp_pernet_set_defaults(struct mptcp_pernet *pernet)
 	pernet->mptcp_enabled = 1;
 	pernet->add_addr_timeout = TCP_RTO_MAX;
 	pernet->checksum_enabled = 0;
+	pernet->allow_join_initial_addr_port = 1;
 }
 
 #ifdef CONFIG_SYSCTL
@@ -54,6 +56,11 @@ int mptcp_is_checksum_enabled(struct net *net)
 	return mptcp_get_pernet(net)->checksum_enabled;
 }
 
+int mptcp_allow_join_id0(struct net *net)
+{
+	return mptcp_get_pernet(net)->allow_join_initial_addr_port;
+}
+
 static struct ctl_table mptcp_sysctl_table[] = {
 	{
 		.procname = "enabled",
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
index 98c735f237b4..17ce5639665a 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -542,6 +542,7 @@ static inline void mptcp_subflow_delegated_done(struct mptcp_subflow_context *su
 int mptcp_is_enabled(struct net *net);
 unsigned int mptcp_get_add_addr_timeout(struct net *net);
 int mptcp_is_checksum_enabled(struct net *net);
+int mptcp_allow_join_id0(struct net *net);
 void mptcp_subflow_fully_established(struct mptcp_subflow_context *subflow,
 				     struct mptcp_options_received *mp_opt);
 bool mptcp_subflow_data_available(struct sock *sk);
-- 
2.31.1

