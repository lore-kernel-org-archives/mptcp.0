Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84CD96F
	for <mptcp@lists.linux.dev>; Mon, 29 Mar 2021 10:41:33 +0000 (UTC)
Received: by mail-pl1-f169.google.com with SMTP id w11so4199613ply.6
        for <mptcp@lists.linux.dev>; Mon, 29 Mar 2021 03:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hj05vtLT/99hGM6mM52jYfwvQD4qU3M3FewKdCgXVUA=;
        b=otQEomKeKsAVppi49jGImj9eiJCuUmh7XkIqWUbvqtKZTjWR/Xan52bP7zhQgnwcA0
         WgK4dUwWFBp33W6whvqsaM4cElu2xNVw1eZTfT+0HXszornM9sX1+/iapodIU9CRbPwk
         Aw8yRTlPWIhVK4U2N14ab3YYVm2OEr6xf0jT7OvMDS2rkiIyTXB/mq2B2wNFI/Zrm7Tl
         DwlO8yRd3MtDcfXPWnNePGBzQdShyw2MDInC7hVpDv+FA/cUEgLAZocsPU/WkRQZ9duX
         rpXBx0y7R94XN5Px311D3tbL51uI+1A2tl+ncIah//Xc18jq1l1PzXJ2aELBglub4f2g
         wgKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hj05vtLT/99hGM6mM52jYfwvQD4qU3M3FewKdCgXVUA=;
        b=n02UB+A91bWAca/vA8rvCZK5kfk91t2PSHkQjAtLhsCH7KOSFaNwc2hbVENWePoH6a
         2GIH5jYU4n7qLnmnaXwaWbvqYsq9mUWcsdT4dP0h3bZ5VawzFH2KAKi1fjO91DvzYupK
         +yhOiseZ/cwJfCvYpHM/kuU7xkE2IVhwLVTCauqx8YmfXhBq10RoTDd5/Rz8kxEavIOJ
         yRIM5EPyL4xYVSHl87vS0LD7HMc1gHPceD66+4ltzDTrgOJMM+tqrYOrgziY7PmXcUw2
         ZIcKmIEz3nSgMgkNCBrw11NzFGgZmxxEy5csRZ6Ew/7t8dLGTut1Jf9NcuTi+SacMUMU
         +Iww==
X-Gm-Message-State: AOAM5327QOpB4XyCfujy8KabCzZLdN5qKW80bQBjDnw60AkYH+tRG3uN
	6LxOswAU41pcBQIN97P7ezZCWgF4l5+OTw==
X-Google-Smtp-Source: ABdhPJzQCGmsQ1Oewg/JixvInKpyGWH8opWXP89w+2esHaPFUx3yct2NwUBAmHEN8uH7mYA+FPsS8Q==
X-Received: by 2002:a17:90b:4b08:: with SMTP id lx8mr25467553pjb.135.1617014492840;
        Mon, 29 Mar 2021 03:41:32 -0700 (PDT)
Received: from localhost ([43.224.245.180])
        by smtp.gmail.com with ESMTPSA id i1sm874854pfu.96.2021.03.29.03.41.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Mar 2021 03:41:32 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>
Subject: [MPTCP][PATCH v2 mptcp-next 12/16] mptcp: add a new sysctl checksum_enabled
Date: Mon, 29 Mar 2021 18:40:43 +0800
Message-Id: <44262de5d6a76c02e585ba148117af9b81355d0d.1617014019.git.geliangtang@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <95dff6615e84496cab649de3d74917790f6a571f.1617014019.git.geliangtang@gmail.com>
References: <cover.1617014019.git.geliangtang@gmail.com> <ee1d26bf90397d9cbec5e4a165fc369ffab60d3e.1617014019.git.geliangtang@gmail.com> <26ccf630ac9be0aee87f4ccfcefc46515c9d61e8.1617014019.git.geliangtang@gmail.com> <a138746729a11cf08e8236d2c8cdf91226936690.1617014019.git.geliangtang@gmail.com> <14b6923c9fd052b140d5af261dfd2575d94b3e05.1617014019.git.geliangtang@gmail.com> <08ab4ce9f13e954b45d24c9e7842f7a6a9798d54.1617014019.git.geliangtang@gmail.com> <d8a242cfe08b2ab0ccb4752a15c8ea8ef0226ac1.1617014019.git.geliangtang@gmail.com> <1c0a240472edcc1afbcb822bd9af3cf03800759e.1617014019.git.geliangtang@gmail.com> <4c7e346e9d1005e8838dd8cf742d8324ef7553c0.1617014019.git.geliangtang@gmail.com> <4a289b981d90fcfda872ade12ec94d27d47bc01f.1617014019.git.geliangtang@gmail.com> <07856073b42a0343f81e6b6e468d6965b693fc5d.1617014019.git.geliangtang@gmail.com> <95dff6615e84496cab649de3d74917790f6a571f.1617014019.git.geliangtang@gmail.com>
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
 net/mptcp/protocol.h                      |  2 +-
 3 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/Documentation/networking/mptcp-sysctl.rst b/Documentation/networking/mptcp-sysctl.rst
index 6af0196c4297..566ec0e4a3da 100644
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
+	Default: 0
diff --git a/net/mptcp/ctrl.c b/net/mptcp/ctrl.c
index 96ba616f59bf..857e371c108c 100644
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
+	pernet->checksum_enabled = 0;
 }
 
 static int mptcp_pernet_new_table(struct net *net, struct mptcp_pernet *pernet)
@@ -75,6 +88,7 @@ static int mptcp_pernet_new_table(struct net *net, struct mptcp_pernet *pernet)
 
 	table[0].data = &pernet->mptcp_enabled;
 	table[1].data = &pernet->add_addr_timeout;
+	table[2].data = &pernet->checksum_enabled;
 
 	hdr = register_net_sysctl(net, MPTCP_SYSCTL_PATH, table);
 	if (!hdr)
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index d4bf264d16cc..a7b60710dc8e 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -533,7 +533,7 @@ static inline void mptcp_subflow_delegated_done(struct mptcp_subflow_context *su
 
 int mptcp_is_enabled(struct net *net);
 unsigned int mptcp_get_add_addr_timeout(struct net *net);
-static inline int mptcp_is_checksum_enabled(struct net *net) { return false; }
+int mptcp_is_checksum_enabled(struct net *net);
 void mptcp_subflow_fully_established(struct mptcp_subflow_context *subflow,
 				     struct mptcp_options_received *mp_opt);
 bool mptcp_subflow_data_available(struct sock *sk);
-- 
2.30.2

