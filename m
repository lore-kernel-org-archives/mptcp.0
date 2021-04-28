Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C5A29CA
	for <mptcp@lists.linux.dev>; Wed, 28 Apr 2021 15:34:23 +0000 (UTC)
Received: by mail-pl1-f179.google.com with SMTP id 20so29097615pll.7
        for <mptcp@lists.linux.dev>; Wed, 28 Apr 2021 08:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qspVrPQzXUX9SN/BofoWevIXnzroKEOVXPoElSoxAXs=;
        b=BngZUnSdnr8QFu63nEqRw0BK72Af7MTqjY+ki2DbvO0soJdqDp5Txo7dArmY5uYPOp
         IwFGzry3H9nV+Q6eY6/S26nQUqOfrckz7CYziDWbX3RAW5UZWEnKcrjBKTxYj5JvTDvN
         xFQES7kpbk1x/9zaM1H/2Mv+GvL6wMqpgNDIjXuAPBdA/hGRdusSoZZjxhvuafPv01T/
         LzewBBLfY3Ud1kxrActykJzAwb44x6tiJiv3iHwAWAQNVzFykv1aw/cSWHJVsvJMr6x9
         89p+KTwMpcElLnIL7FVyibVrrAozyX4LNOkOxCIkrpEZRmGubONhhkaWrHPkIH4A9Lfa
         MSNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qspVrPQzXUX9SN/BofoWevIXnzroKEOVXPoElSoxAXs=;
        b=CDFj1bCYBEXUfBF0tIDuJ2B+0jJETv/PsX8iqnIzvRBkIzxo4iqwHHklWFcPqIYLBf
         XpjPAg7bdOQ/50CMswLWb/xWFVX7QnJnnoBfYgLspTpwCIXkfAA8p1Kr1jQiF4Kjrb4Y
         oeG68aFFUTqJo6ghXim/ZrAv1/Bo0UaPPIkv5X5KZpXPQioIxg9zVtDCw/1dPp4Cxxjh
         3rl8h+hubqf7hwFTHWiWyr7fDeOZzW0klfqPEQ3+wYzWtKZ8AraZYJXQxLGP375RneWf
         vhhj9DCrV8s0D00yajN6tvaxCr1KkrBLzz84yoHeRR3fd+2ldOhRn2gTFvT4tp/qpD2d
         FrMw==
X-Gm-Message-State: AOAM532/mZZuyMX7fL7F2z9aOLYomBX79UjSZP03ryDt4Z63V+rGlXP8
	5/Mjp6CPNm5sF+hJ5lRXmM9zAzbTfkA=
X-Google-Smtp-Source: ABdhPJwabBUHlsJdDgR5UsGsozZ821w9byO/gkgrXWRXr2HLZX/tAbY+8ky6YYwOXySaZ7J9wFfUNg==
X-Received: by 2002:a17:903:22c9:b029:ed:7d2a:8d13 with SMTP id y9-20020a17090322c9b02900ed7d2a8d13mr1824548plg.72.1619624063244;
        Wed, 28 Apr 2021 08:34:23 -0700 (PDT)
Received: from localhost ([209.9.72.213])
        by smtp.gmail.com with ESMTPSA id a7sm5748866pjm.0.2021.04.28.08.34.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Apr 2021 08:34:23 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>
Subject: [MPTCP][PATCH v3 mptcp-next 1/4] mptcp: add sysctl allow_join_initial_addr_port
Date: Wed, 28 Apr 2021 23:34:14 +0800
Message-Id: <952b920c38ab98adfdb77a0e941ff43c05461a0d.1619623735.git.geliangtang@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1619623735.git.geliangtang@gmail.com>
References: <cover.1619623735.git.geliangtang@gmail.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch added a new sysctl, named allow_join_initial_addr_port, to
control whether allow peers to send join requests to the IP address and
port number used by the initial subflow.

Signed-off-by: Geliang Tang <geliangtang@gmail.com>
---
 Documentation/networking/mptcp-sysctl.rst | 13 +++++++++++++
 net/mptcp/ctrl.c                          | 16 ++++++++++++++++
 net/mptcp/protocol.h                      |  1 +
 3 files changed, 30 insertions(+)

diff --git a/Documentation/networking/mptcp-sysctl.rst b/Documentation/networking/mptcp-sysctl.rst
index 3b352e5f6300..6c67ea3d0b7f 100644
--- a/Documentation/networking/mptcp-sysctl.rst
+++ b/Documentation/networking/mptcp-sysctl.rst
@@ -24,3 +24,16 @@ add_addr_timeout - INTEGER (seconds)
 	sysctl.
 
 	Default: 120
+
+allow_join_initial_addr_port - INTEGER
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
index 08c152199b89..5c520fcdf93d 100644
--- a/net/mptcp/ctrl.c
+++ b/net/mptcp/ctrl.c
@@ -19,6 +19,7 @@ struct mptcp_pernet {
 
 	u8 mptcp_enabled;
 	unsigned int add_addr_timeout;
+	u8 allow_join_initial_addr_port;
 };
 
 static struct mptcp_pernet *mptcp_get_pernet(struct net *net)
@@ -36,6 +37,11 @@ unsigned int mptcp_get_add_addr_timeout(struct net *net)
 	return mptcp_get_pernet(net)->add_addr_timeout;
 }
 
+int mptcp_is_allow_join_id0(struct net *net)
+{
+	return mptcp_get_pernet(net)->allow_join_initial_addr_port;
+}
+
 static struct ctl_table mptcp_sysctl_table[] = {
 	{
 		.procname = "enabled",
@@ -54,6 +60,14 @@ static struct ctl_table mptcp_sysctl_table[] = {
 		.mode = 0644,
 		.proc_handler = proc_dointvec_jiffies,
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
 
@@ -61,6 +75,7 @@ static void mptcp_pernet_set_defaults(struct mptcp_pernet *pernet)
 {
 	pernet->mptcp_enabled = 1;
 	pernet->add_addr_timeout = TCP_RTO_MAX;
+	pernet->allow_join_initial_addr_port = 1;
 }
 
 static int mptcp_pernet_new_table(struct net *net, struct mptcp_pernet *pernet)
@@ -77,6 +92,7 @@ static int mptcp_pernet_new_table(struct net *net, struct mptcp_pernet *pernet)
 
 	table[0].data = &pernet->mptcp_enabled;
 	table[1].data = &pernet->add_addr_timeout;
+	table[2].data = &pernet->allow_join_initial_addr_port;
 
 	hdr = register_net_sysctl(net, MPTCP_SYSCTL_PATH, table);
 	if (!hdr)
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index d230a75af631..bb901435c2d4 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -524,6 +524,7 @@ static inline void mptcp_subflow_delegated_done(struct mptcp_subflow_context *su
 
 int mptcp_is_enabled(struct net *net);
 unsigned int mptcp_get_add_addr_timeout(struct net *net);
+int mptcp_is_allow_join_id0(struct net *net);
 void mptcp_subflow_fully_established(struct mptcp_subflow_context *subflow,
 				     struct mptcp_options_received *mp_opt);
 bool mptcp_subflow_data_available(struct sock *sk);
-- 
2.30.2

