Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [216.205.24.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 985982F80
	for <mptcp@lists.linux.dev>; Tue,  4 May 2021 21:42:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1620164571;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4fxlmcHomHGaC6tlNlDvssBUEP6FimQdz0M1H6s03wM=;
	b=EHOlc8AfkPmYx4EucpE5VtrcrQP8O3iLwieEIWH/SgBJXriX40AqYBJ70O1QIlOBePzlt7
	i3ydgW5DNJBJyra0/Wol8wObFqtvysrceiy0nBCba+CMvPJzGviDkXimLjGfPi4Hq8GjHI
	OzI6DItL1gT/CZZMWfPPe3v1mcw9sfc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-377-TjglOdQlNX6HjZGBCpwuYQ-1; Tue, 04 May 2021 17:42:50 -0400
X-MC-Unique: TjglOdQlNX6HjZGBCpwuYQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 74364801817
	for <mptcp@lists.linux.dev>; Tue,  4 May 2021 21:42:49 +0000 (UTC)
Received: from gerbillo.redhat.com (ovpn-114-126.ams2.redhat.com [10.36.114.126])
	by smtp.corp.redhat.com (Postfix) with ESMTP id DB67F5C22A
	for <mptcp@lists.linux.dev>; Tue,  4 May 2021 21:42:48 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH v6 mptcp-next 20/22] mptcp: add a new sysctl checksum_enabled
Date: Tue,  4 May 2021 23:42:08 +0200
Message-Id: <271cd2abe72de34c20084390684704e27a068c22.1620163861.git.pabeni@redhat.com>
In-Reply-To: <cover.1620163861.git.pabeni@redhat.com>
References: <cover.1620163861.git.pabeni@redhat.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"

From: Geliang Tang <geliangtang@gmail.com>

This patch added a new sysctl, named checksum_enabled, to control
whether DSS checksum can be enabled.

Signed-off-by: Geliang Tang <geliangtang@gmail.com>
---
 Documentation/networking/mptcp-sysctl.rst |  8 ++++++++
 net/mptcp/ctrl.c                          | 14 ++++++++++++++
 net/mptcp/protocol.h                      |  2 +-
 3 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/Documentation/networking/mptcp-sysctl.rst b/Documentation/networking/mptcp-sysctl.rst
index 3b352e5f6300..901fa3e4650f 100644
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
index 1ec4d36a39f0..014752c481d0 100644
--- a/net/mptcp/ctrl.c
+++ b/net/mptcp/ctrl.c
@@ -23,6 +23,7 @@ struct mptcp_pernet {
 
 	u8 mptcp_enabled;
 	unsigned int add_addr_timeout;
+	int checksum_enabled;
 };
 
 static struct mptcp_pernet *mptcp_get_pernet(struct net *net)
@@ -44,9 +45,15 @@ static void mptcp_pernet_set_defaults(struct mptcp_pernet *pernet)
 {
 	pernet->mptcp_enabled = 1;
 	pernet->add_addr_timeout = TCP_RTO_MAX;
+	pernet->checksum_enabled = 0;
 }
 
 #ifdef CONFIG_SYSCTL
+int mptcp_is_checksum_enabled(struct net *net)
+{
+	return mptcp_get_pernet(net)->checksum_enabled;
+}
+
 static struct ctl_table mptcp_sysctl_table[] = {
 	{
 		.procname = "enabled",
@@ -65,6 +72,12 @@ static struct ctl_table mptcp_sysctl_table[] = {
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
 
@@ -82,6 +95,7 @@ static int mptcp_pernet_new_table(struct net *net, struct mptcp_pernet *pernet)
 
 	table[0].data = &pernet->mptcp_enabled;
 	table[1].data = &pernet->add_addr_timeout;
+	table[2].data = &pernet->checksum_enabled;
 
 	hdr = register_net_sysctl(net, MPTCP_SYSCTL_PATH, table);
 	if (!hdr)
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 39ba2efc60e9..98c735f237b4 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -541,7 +541,7 @@ static inline void mptcp_subflow_delegated_done(struct mptcp_subflow_context *su
 
 int mptcp_is_enabled(struct net *net);
 unsigned int mptcp_get_add_addr_timeout(struct net *net);
-static inline int mptcp_is_checksum_enabled(struct net *net) { return false; }
+int mptcp_is_checksum_enabled(struct net *net);
 void mptcp_subflow_fully_established(struct mptcp_subflow_context *subflow,
 				     struct mptcp_options_received *mp_opt);
 bool mptcp_subflow_data_available(struct sock *sk);
-- 
2.26.2

