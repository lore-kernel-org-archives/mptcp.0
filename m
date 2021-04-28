Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 711BC2F80
	for <mptcp@lists.linux.dev>; Wed, 28 Apr 2021 07:01:13 +0000 (UTC)
Received: by mail-pf1-f178.google.com with SMTP id a12so766642pfc.7
        for <mptcp@lists.linux.dev>; Wed, 28 Apr 2021 00:01:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1VBB49buCFbj8eRxH9ubGFtkBG8jzf1bc8q5+aiYp2w=;
        b=hxnJc9jh+pd5P+MeJyUEv8AoTbVN5Fn/N021jQ6fn3Ar+JgK4KiVgyR4VhPq+iPJrl
         j2o3xYmyrUjxBD3XlvE430pQGJnY0V7a6LIaDlD9f2JZGcdHjpyf5T2+coN9RUA1h6oW
         7kluGXdHg+AqwxEpicVxSx6DyqfevPivN38eYSGa5mPHwoRafUEAnqewDL211SmS9X39
         W2tjIFeaToo65zWDPHNd6SfiMuib/L8OBWQqgSgdsxARTCQ71c02F6DLektIzglTLiRy
         12rxstQ+waVwtArKzzrmBrFciEAEn33P23EBikqG85fcfPHqhWk5+FfNcN8NrZnPPFQ7
         oDVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1VBB49buCFbj8eRxH9ubGFtkBG8jzf1bc8q5+aiYp2w=;
        b=qRwxZFcuHytbzDuA14f1fZO0nAcDd0ujoilQPxkvG3XmNg4X3RNYR2nYRDbbSPvsPR
         5MuxBkMYrxoLtVYOlq8pGObktse9jRKqEbM2G5HuS4c4IcyWxu5KHHICCVUtte6x/x6v
         QB41vmmKFq+euIJn9GxO429WZzsnVbCO3Qvdo0GQgc4okpY5Vs9aCeiWtf7ZtnBGnmuO
         yg2HMecur2Vx9ZSJcJFF+gmAElWcrgjrW5ah3T5llot3j7c7F4K/+53mFfrsZRcO4bhR
         JlIDyWFfrbHNAYqTiG7niFT6qkdMDIBG5myVXsHf7y/tCTRgHTs1ktfKQm+V/L7L9kGb
         29lw==
X-Gm-Message-State: AOAM532o5BXMAa3d0OaUyKrDvcUxxAlQhAG8B0nSkMJ7AztfO+KAe0AG
	LyARFWYur82adbVrjN0CBPM6Jw/p9L0=
X-Google-Smtp-Source: ABdhPJzgkDjA+G9Bnezq1IIJtNh7Al4wtu6iIe3M6S+wLO/gApqY0KEJPvLdpReDie3dTNJ1HGE4yg==
X-Received: by 2002:aa7:8890:0:b029:27d:90da:39e1 with SMTP id z16-20020aa788900000b029027d90da39e1mr878488pfe.43.1619593272892;
        Wed, 28 Apr 2021 00:01:12 -0700 (PDT)
Received: from localhost ([209.9.72.212])
        by smtp.gmail.com with ESMTPSA id gx21sm4169275pjb.29.2021.04.28.00.01.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Apr 2021 00:01:12 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>
Subject: [MPTCP][PATCH v2 mptcp-next 1/4] mptcp: add sysctl allow_join_initial_addr_port
Date: Wed, 28 Apr 2021 15:01:03 +0800
Message-Id: <51758a7f629764dc91186acbf09665992e5b8e69.1619592361.git.geliangtang@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1619592361.git.geliangtang@gmail.com>
References: <cover.1619592361.git.geliangtang@gmail.com>
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
 net/mptcp/ctrl.c                          | 14 ++++++++++++++
 net/mptcp/protocol.h                      |  1 +
 3 files changed, 28 insertions(+)

diff --git a/Documentation/networking/mptcp-sysctl.rst b/Documentation/networking/mptcp-sysctl.rst
index 6af0196c4297..9088836ded19 100644
--- a/Documentation/networking/mptcp-sysctl.rst
+++ b/Documentation/networking/mptcp-sysctl.rst
@@ -24,3 +24,16 @@ add_addr_timeout - INTEGER (seconds)
 	sysctl.
 
 	Default: 120
+
+allow_join_initial_addr_port - INTEGER
+	Allow peers to send join requests to the IP address and port number used
+	by the initial subflow if the value is nonzero. This controls a flag that
+	is sent to the peer at connection time, and whether such join requests are
+	accepted or denied.
+
+	Joins to addresses advertised with ADD_ADDR are not affected by this
+	value.
+
+	This is a per-namespace sysctl.
+
+	Default: 1
diff --git a/net/mptcp/ctrl.c b/net/mptcp/ctrl.c
index 96ba616f59bf..3b963a25d5a8 100644
--- a/net/mptcp/ctrl.c
+++ b/net/mptcp/ctrl.c
@@ -19,6 +19,7 @@ struct mptcp_pernet {
 
 	int mptcp_enabled;
 	unsigned int add_addr_timeout;
+	int allow_join_initial_addr_port;
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
@@ -52,6 +58,12 @@ static struct ctl_table mptcp_sysctl_table[] = {
 		.mode = 0644,
 		.proc_handler = proc_dointvec_jiffies,
 	},
+	{
+		.procname = "allow_join_initial_addr_port",
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
+	pernet->allow_join_initial_addr_port = 1;
 }
 
 static int mptcp_pernet_new_table(struct net *net, struct mptcp_pernet *pernet)
@@ -75,6 +88,7 @@ static int mptcp_pernet_new_table(struct net *net, struct mptcp_pernet *pernet)
 
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

