Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2CA170
	for <mptcp@lists.linux.dev>; Wed, 21 Jul 2021 14:31:43 +0000 (UTC)
Received: by mail-pj1-f50.google.com with SMTP id d9-20020a17090ae289b0290172f971883bso4134793pjz.1
        for <mptcp@lists.linux.dev>; Wed, 21 Jul 2021 07:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=k05XkUBMq6W1EqYEAhmAHeOQZkUBkiyBeoSCVYI+b34=;
        b=UigNYPBXZRCWQrq1f8lpMk5VzgCZGnd6usG7483/n9iNCxYsPflPiURD+QbkHPLqjF
         y1rhUfKonpxuhBn4iLXJBLe049cnYXou8GhFSPGZfdYF9QdydxkpM4WYD6JpC5YUD0i4
         Ck4mbJsKWH3sTemR2ai2SdTC1RJjADF/Wg7DrO5zLfYDfgu4pGuwxBNHfZVq0bFZdJhT
         l6iGEMo8RAJyHKBUSs1lrRVmH30UNm+27CGQKxt/AagaCiedTXA0pL3jV7SgcdsP0tJk
         BMbANjuvo/Pg0docAhoklUTFOBwxu5OCw+RUMVQCUZWhnUVbWnhTMSNqni+WlYp/fQ0A
         8Scw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=k05XkUBMq6W1EqYEAhmAHeOQZkUBkiyBeoSCVYI+b34=;
        b=JI6SaGX46NyOy320KqXHblQ3bNkrRNp72WUgK/BvGf6L+KvC4Zn/0aDQZEqx7qOSDK
         qNK7LZ6P4ZFrdhOOjEfHVtiOgI/4jI8yIEXVH6dpGnXiakN08eRq8WIPUKY0Nbiy9iA8
         /WczJ0IjDnnMvEkgvAwaKS1r2gwUYhqq6+dUXbBWgU1urecqEmsXkrNWz5qm1/3nNm1y
         32F2tIxMLstDhGm/QRf0SbkfeOlSuGHhZg8jNJC6SrVM7+I3uyKtd6Vq3F7bc3fmDhoL
         jwaJW0dIBqewJL8umKhMz1WSqN3rwI9/y+c4KBiBSfdCcOXr+7nvZuKXbODn97PXqbYt
         mA4A==
X-Gm-Message-State: AOAM530N7ePspykyBrzxwqaApfNkWv9+8V7YUALXS2Ji+38ovnRyZVgn
	zHmXA5bKOLYehoR1ZjqEzvVJ7nN1RmX7LQ==
X-Google-Smtp-Source: ABdhPJzQ/los2imihqVRD2OMlTgLoiNiTu0K/22wySUFbbD+1GF7mlwDgg0FjCZrbPMRr6N5mnkT8w==
X-Received: by 2002:a17:90a:d58f:: with SMTP id v15mr4045717pju.117.1626877903194;
        Wed, 21 Jul 2021 07:31:43 -0700 (PDT)
Received: from MiBook.. ([43.224.245.180])
        by smtp.gmail.com with ESMTPSA id i6sm21723147pfa.44.2021.07.21.07.31.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jul 2021 07:31:42 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>
Subject: [MPTCP][PATCH v2 mptcp-next 01/10] mptcp: add a new sysctl fullmesh_enabled
Date: Wed, 21 Jul 2021 22:31:25 +0800
Message-Id: <b5f63eb4ad680a99fc806d2406968a6a5f272f01.1626877655.git.geliangtang@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1626877655.git.geliangtang@gmail.com>
References: <cover.1626877655.git.geliangtang@gmail.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch added a new sysctl, named fullmesh_enabled, to control whether
the fullmesh path manager mode can be enabled.

Signed-off-by: Geliang Tang <geliangtang@gmail.com>
---
 Documentation/networking/mptcp-sysctl.rst |  8 ++++++++
 net/mptcp/ctrl.c                          | 16 ++++++++++++++++
 net/mptcp/protocol.h                      |  1 +
 3 files changed, 25 insertions(+)

diff --git a/Documentation/networking/mptcp-sysctl.rst b/Documentation/networking/mptcp-sysctl.rst
index b0d4da71e68e..7e8350cbb042 100644
--- a/Documentation/networking/mptcp-sysctl.rst
+++ b/Documentation/networking/mptcp-sysctl.rst
@@ -57,3 +57,11 @@ stale_loss_cnt - INTEGER
 	This is a per-namespace sysctl.
 
 	Default: 4
+
+fullmesh_enabled - BOOLEAN
+	Control whether the fullmesh path manager mode can be enabled.
+
+	The fullmesh path manager mode can be enabled if the value it nonzero.
+	This is a per-namespace sysctl.
+
+	Default: 0
diff --git a/net/mptcp/ctrl.c b/net/mptcp/ctrl.c
index 8b235468c88f..432a859e9153 100644
--- a/net/mptcp/ctrl.c
+++ b/net/mptcp/ctrl.c
@@ -26,6 +26,7 @@ struct mptcp_pernet {
 	u8 mptcp_enabled;
 	u8 checksum_enabled;
 	u8 allow_join_initial_addr_port;
+	u8 fullmesh_enabled;
 };
 
 static struct mptcp_pernet *mptcp_get_pernet(const struct net *net)
@@ -58,6 +59,11 @@ unsigned int mptcp_stale_loss_cnt(const struct net *net)
 	return mptcp_get_pernet(net)->stale_loss_cnt;
 }
 
+int mptcp_is_fullmesh_enabled(struct net *net)
+{
+	return mptcp_get_pernet(net)->fullmesh_enabled;
+}
+
 static void mptcp_pernet_set_defaults(struct mptcp_pernet *pernet)
 {
 	pernet->mptcp_enabled = 1;
@@ -65,6 +71,7 @@ static void mptcp_pernet_set_defaults(struct mptcp_pernet *pernet)
 	pernet->checksum_enabled = 0;
 	pernet->allow_join_initial_addr_port = 1;
 	pernet->stale_loss_cnt = 4;
+	pernet->fullmesh_enabled = 0;
 }
 
 #ifdef CONFIG_SYSCTL
@@ -108,6 +115,14 @@ static struct ctl_table mptcp_sysctl_table[] = {
 		.mode = 0644,
 		.proc_handler = proc_douintvec_minmax,
 	},
+	{
+		.procname	= "fullmesh_enabled",
+		.maxlen		= sizeof(u8),
+		.mode		= 0644,
+		.proc_handler	= proc_dou8vec_minmax,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_ONE
+	},
 	{}
 };
 
@@ -128,6 +143,7 @@ static int mptcp_pernet_new_table(struct net *net, struct mptcp_pernet *pernet)
 	table[2].data = &pernet->checksum_enabled;
 	table[3].data = &pernet->allow_join_initial_addr_port;
 	table[4].data = &pernet->stale_loss_cnt;
+	table[5].data = &pernet->fullmesh_enabled;
 
 	hdr = register_net_sysctl(net, MPTCP_SYSCTL_PATH, table);
 	if (!hdr)
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 8bdd038def38..ce972edc7bbe 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -562,6 +562,7 @@ unsigned int mptcp_get_add_addr_timeout(const struct net *net);
 int mptcp_is_checksum_enabled(const struct net *net);
 int mptcp_allow_join_id0(const struct net *net);
 unsigned int mptcp_stale_loss_cnt(const struct net *net);
+int mptcp_is_fullmesh_enabled(struct net *net);
 void mptcp_subflow_fully_established(struct mptcp_subflow_context *subflow,
 				     struct mptcp_options_received *mp_opt);
 bool __mptcp_retransmit_pending_data(struct sock *sk);
-- 
2.31.1

