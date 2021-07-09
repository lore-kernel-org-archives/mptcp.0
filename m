Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42E3C72
	for <mptcp@lists.linux.dev>; Fri,  9 Jul 2021 11:04:43 +0000 (UTC)
Received: by mail-pg1-f172.google.com with SMTP id d12so9578283pgd.9
        for <mptcp@lists.linux.dev>; Fri, 09 Jul 2021 04:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9+qR2PuwDeoiS6iebpIQC0v04vY3AGuQINu8LhcQNNU=;
        b=uGNcCOvbdZ7znb8tRKV3u0w9ekTI/+hmUaLZgJaZeKvrdbmj6wLfH6Se3Q62o81jtD
         jysOuF5oFO1JpeU+752aK6r4CvJBBxgxh4bD1g1v3qor31fx3ZTJ1G00xnx6wMWhcbSB
         088gSBo8+ji7aLpZoTWYRCTDZL7S9ye81OIU0eT7AMa1da6KQTZnhkMBu6AZzU+f0jut
         7xcYmffovzy1Mv1pvk6i8Z3a8q68+E5QsTwVoYKY96l7AsMDYALTAMXv9xBU4s+6n/tN
         NXJF42H2PEuYkBXFnoVlAQCuC1IKcqQqEv2JUGouMoaLsUzbise5HJAlnYDcqtjL83+f
         5tSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9+qR2PuwDeoiS6iebpIQC0v04vY3AGuQINu8LhcQNNU=;
        b=FAasTC92Yr2WN5RU7sW4rms+DPgdJzKolfs9bX/Na4niFFsl6QjGt0T+kVhX4VnVA2
         N6eX1iaa3RD2NQbpog7MzeEKzsISjWBxC4HDfd9PknOlQVda+dMwBs9TtTcjFlKqT1R0
         pERG3maplxnEufg6lqgKg2gPCXuxllh4Ho6AB2hbHaAAXPdRPzt/rpKdXaPppITJHrZZ
         AsfssuOVHtxJfdnuqjsCjbQQVQNhDBJkK1I2qQyz5FsXO20Az6LLY0WNOb9441t62BPS
         SFiSmQxGYQpZrB2HjXDcycMM3x7bFwk2RwGJCoujGGP7ZFXVODrPgtCw76ptFkzCLAtG
         Y4ug==
X-Gm-Message-State: AOAM531DDW7gVxU7m+6dkFNILw7bKTzQV8VhM8hSxlQnjVj0lm4UFypt
	2QzeVKAFsJsqyIu4f3AcRK1mx4+caqWOWg==
X-Google-Smtp-Source: ABdhPJxSqWZRU6WRJfvYvYhlGUCo5uY8Q4ZevDLIFOmuDc6xqN79udtX9W4P9QBkYH/VIU2JwUyzxA==
X-Received: by 2002:a63:5802:: with SMTP id m2mr23178348pgb.171.1625828682728;
        Fri, 09 Jul 2021 04:04:42 -0700 (PDT)
Received: from MiBook.. ([43.224.245.180])
        by smtp.gmail.com with ESMTPSA id s15sm6247902pfu.97.2021.07.09.04.04.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jul 2021 04:04:42 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>
Subject: [MPTCP][PATCH mptcp-next 1/9] mptcp: add a new sysctl path_manager
Date: Fri,  9 Jul 2021 19:04:28 +0800
Message-Id: <974215e2c4ec6e953bd28882820507b0638c3a8a.1625825505.git.geliangtang@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1625825505.git.geliangtang@gmail.com>
References: <cover.1625825505.git.geliangtang@gmail.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch added a new sysctl, named path_manager, to support for
selection of different Path-Managers.

Signed-off-by: Geliang Tang <geliangtang@gmail.com>
---
 Documentation/networking/mptcp-sysctl.rst |  8 ++++++++
 net/mptcp/ctrl.c                          | 16 ++++++++++++++++
 net/mptcp/pm.c                            |  6 +++++-
 net/mptcp/protocol.c                      |  9 +++++++--
 net/mptcp/protocol.h                      |  1 +
 5 files changed, 37 insertions(+), 3 deletions(-)

diff --git a/Documentation/networking/mptcp-sysctl.rst b/Documentation/networking/mptcp-sysctl.rst
index 76d939e688b8..08e2a50bd8e3 100644
--- a/Documentation/networking/mptcp-sysctl.rst
+++ b/Documentation/networking/mptcp-sysctl.rst
@@ -45,3 +45,11 @@ allow_join_initial_addr_port - BOOLEAN
 	This is a per-namespace sysctl.
 
 	Default: 1
+
+path_manager - STRING
+	Select the Path-Manager of your choice.
+
+	Support for selection of different Path-Managers. This is a
+	per-namespace sysctl.
+
+	Default: "netlink"
diff --git a/net/mptcp/ctrl.c b/net/mptcp/ctrl.c
index 7d738bd06f2c..8208d07c2d69 100644
--- a/net/mptcp/ctrl.c
+++ b/net/mptcp/ctrl.c
@@ -15,6 +15,8 @@
 
 #define MPTCP_SYSCTL_PATH "net/mptcp"
 
+#define MPTCP_PM_NAME_MAX	16
+
 static int mptcp_pernet_id;
 struct mptcp_pernet {
 #ifdef CONFIG_SYSCTL
@@ -25,6 +27,7 @@ struct mptcp_pernet {
 	unsigned int add_addr_timeout;
 	u8 checksum_enabled;
 	u8 allow_join_initial_addr_port;
+	char path_manager[MPTCP_PM_NAME_MAX];
 };
 
 static struct mptcp_pernet *mptcp_get_pernet(struct net *net)
@@ -52,12 +55,18 @@ int mptcp_allow_join_id0(struct net *net)
 	return mptcp_get_pernet(net)->allow_join_initial_addr_port;
 }
 
+char *mptcp_get_path_manager(struct net *net)
+{
+	return mptcp_get_pernet(net)->path_manager;
+}
+
 static void mptcp_pernet_set_defaults(struct mptcp_pernet *pernet)
 {
 	pernet->mptcp_enabled = 1;
 	pernet->add_addr_timeout = TCP_RTO_MAX;
 	pernet->checksum_enabled = 0;
 	pernet->allow_join_initial_addr_port = 1;
+	strcpy(pernet->path_manager, "netlink");
 }
 
 #ifdef CONFIG_SYSCTL
@@ -95,6 +104,12 @@ static struct ctl_table mptcp_sysctl_table[] = {
 		.extra1       = SYSCTL_ZERO,
 		.extra2       = SYSCTL_ONE
 	},
+	{
+		.procname	= "path_manager",
+		.maxlen		= MPTCP_PM_NAME_MAX,
+		.mode		= 0644,
+		.proc_handler	= proc_dostring,
+	},
 	{}
 };
 
@@ -114,6 +129,7 @@ static int mptcp_pernet_new_table(struct net *net, struct mptcp_pernet *pernet)
 	table[1].data = &pernet->add_addr_timeout;
 	table[2].data = &pernet->checksum_enabled;
 	table[3].data = &pernet->allow_join_initial_addr_port;
+	table[4].data = &pernet->path_manager;
 
 	hdr = register_net_sysctl(net, MPTCP_SYSCTL_PATH, table);
 	if (!hdr)
diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 639271e09604..aa003cf72b68 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -310,6 +310,9 @@ int mptcp_pm_get_local_id(struct mptcp_sock *msk, struct sock_common *skc)
 
 void mptcp_pm_data_init(struct mptcp_sock *msk)
 {
+	struct net *net = sock_net((struct sock *)msk);
+	char *pm = mptcp_get_path_manager(net);
+
 	msk->pm.add_addr_signaled = 0;
 	msk->pm.add_addr_accepted = 0;
 	msk->pm.local_addr_used = 0;
@@ -326,7 +329,8 @@ void mptcp_pm_data_init(struct mptcp_sock *msk)
 	spin_lock_init(&msk->pm.lock);
 	INIT_LIST_HEAD(&msk->pm.anno_list);
 
-	mptcp_pm_nl_data_init(msk);
+	if (!strcmp(pm, "netlink"))
+		mptcp_pm_nl_data_init(msk);
 }
 
 void __init mptcp_pm_init(void)
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 7ae80c1d7f79..938690f87b8f 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2325,7 +2325,9 @@ static void mptcp_worker(struct work_struct *work)
 {
 	struct mptcp_sock *msk = container_of(work, struct mptcp_sock, work);
 	struct sock *sk = &msk->sk.icsk_inet.sk;
+	struct net *net = sock_net(sk);
 	int state;
+	char *pm;
 
 	lock_sock(sk);
 	state = sk->sk_state;
@@ -2337,8 +2339,11 @@ static void mptcp_worker(struct work_struct *work)
 
 	mptcp_check_fastclose(msk);
 
-	if (msk->pm.status)
-		mptcp_pm_nl_work(msk);
+	if (msk->pm.status) {
+		pm = mptcp_get_path_manager(net);
+		if (!strcmp(pm, "netlink"))
+			mptcp_pm_nl_work(msk);
+	}
 
 	if (test_and_clear_bit(MPTCP_WORK_EOF, &msk->flags))
 		mptcp_check_for_eof(msk);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 0f0c026c5f8b..17f2a2894fe6 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -553,6 +553,7 @@ int mptcp_is_enabled(struct net *net);
 unsigned int mptcp_get_add_addr_timeout(struct net *net);
 int mptcp_is_checksum_enabled(struct net *net);
 int mptcp_allow_join_id0(struct net *net);
+char *mptcp_get_path_manager(struct net *net);
 void mptcp_subflow_fully_established(struct mptcp_subflow_context *subflow,
 				     struct mptcp_options_received *mp_opt);
 bool mptcp_subflow_data_available(struct sock *sk);
-- 
2.31.1

