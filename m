Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7DC572
	for <mptcp@lists.linux.dev>; Sat,  8 May 2021 10:34:03 +0000 (UTC)
Received: by mail-pg1-f172.google.com with SMTP id j12so3128459pgh.7
        for <mptcp@lists.linux.dev>; Sat, 08 May 2021 03:34:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VJjBYpYoSd9fcpkY6wdrXT5dYkJikOPUmbJyJiITcXY=;
        b=dR+r9MizLnQ3IUzk1A9a3cpU77VuIdZHuQgZdbPjwu1dYSpLObdEk79ITaCMQHe10q
         w+ElQ9kg+PZ/GbB1OCd9O5jeiIHSS8CnOwlBjConesWLy/RxDAbOL5ahw/l3aqGlbkK8
         GGzqEOM+CVx6KyTCf0N0uiaKitY+TZVDJMYoCfW7o/TFxSuIr9KXUavKkK4J6aE1IYUT
         56x28zo69XuJbL6duCCWDnqLKRbAPEU90nV5fMoR0d/TztF7PEttAUBK4JKV3PURJOuz
         SFY25X9E9bDTIczSrUpzXyMD2PtDnsgUXfjejLBTWXKSoYZJ6ATLUPLyPwD6z34RMxLC
         2qbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VJjBYpYoSd9fcpkY6wdrXT5dYkJikOPUmbJyJiITcXY=;
        b=ouof9v3olt5xUQ8Py3OwwDVWeH/QJoTW35mCVs0xcsE8EuAzCv5Mr4q5vJ3ZPl6SK+
         F4YFswNyblneSfHbfqiXmJolMEDjNB0YPu46H4JyI7kPU4MVyqAg+ZSBen6XJkRCAk0D
         3tsduHJ7kY2khbEBITvas1Klb/trQeYoe0jBoe0h2Iul3UF1wO9/mma7Sso+syADl0Zv
         qdMxOWBI9bFz72wMPd9mt5SuU8DpaEc+7vpUO66KWHOmFSuLdmZVKFsss19H+26pUoVC
         JgghmOzC8hvnWi5b2vc8fol1EOowzdriMNl/GBcx0KOhn2z4WZjJyzsCIvwImx3InViW
         4m7w==
X-Gm-Message-State: AOAM533jsOVaeB8cl6FTHxpx8YCA4C8Hqvu4/SlaTbnrU4UUjnXeBm9J
	7ktV46kSIEHfwn6IMYxlkLZOiSkXFqY=
X-Google-Smtp-Source: ABdhPJxM3p95XI2RtoioXZTvvazcx/mCb0xR6J2nkc7/wjvNo0X59BkA3KVXAiLqs4bxg+4TOdh7sA==
X-Received: by 2002:a05:6a00:8c4:b029:2b4:8334:ed4d with SMTP id s4-20020a056a0008c4b02902b48334ed4dmr1128620pfu.36.1620470043277;
        Sat, 08 May 2021 03:34:03 -0700 (PDT)
Received: from localhost ([209.9.72.213])
        by smtp.gmail.com with ESMTPSA id h76sm7229544pfe.161.2021.05.08.03.34.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 May 2021 03:34:03 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>,
	Florian Westphal <fw@strlen.de>
Subject: [MPTCP][PATCH v5 mptcp-next 1/5] mptcp: add sysctl allow_join_initial_addr_port
Date: Sat,  8 May 2021 18:33:24 +0800
Message-Id: <0edd6a3ad45c1f67a350356298ed4333fc42dac3.1620469774.git.geliangtang@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1620469774.git.geliangtang@gmail.com>
References: <cover.1620469774.git.geliangtang@gmail.com>
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

