Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [216.205.24.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 121982F9B
	for <mptcp@lists.linux.dev>; Wed, 21 Apr 2021 20:21:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1619036493;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/nv8z+k/S7zemMjINSlBONBISMOTraIzo+YtONyR1AY=;
	b=PuwmHtBtptuxAykYQftstOc2EZb4vKsAGSYIXXX5Pk7CzLBns2RWGBV8H42dmlybJmlD6r
	4Kyb3jx6iOxO0Vqc8ej/oKAcAcsmbFbWa2l4WJOG0jo/xKQmRAYH2Vlj8dM/6/bjC8aei6
	QcDftZurF0QEn/mzScRv6uJqq32wvzc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-487-IArbdhxtPluaWgP4Aeymvg-1; Wed, 21 Apr 2021 16:21:03 -0400
X-MC-Unique: IArbdhxtPluaWgP4Aeymvg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1D7581898296;
	Wed, 21 Apr 2021 20:21:02 +0000 (UTC)
Received: from gerbillo.redhat.com (ovpn-112-15.ams2.redhat.com [10.36.112.15])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 2BFF06085A;
	Wed, 21 Apr 2021 20:21:00 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>
Subject: [PATCH v3 mptcp-next 19/21] mptcp: add a new sysctl checksum_enabled
Date: Wed, 21 Apr 2021 22:18:08 +0200
Message-Id: <f7ab8e6d992561abcbaccdabe4f7ac95cdbfb3ff.1619035356.git.pabeni@redhat.com>
In-Reply-To: <cover.1619035356.git.pabeni@redhat.com>
References: <cover.1619035356.git.pabeni@redhat.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
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
index 766412e50e73..ca52dd14f95f 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -540,7 +540,7 @@ static inline void mptcp_subflow_delegated_done(struct mptcp_subflow_context *su
 
 int mptcp_is_enabled(struct net *net);
 unsigned int mptcp_get_add_addr_timeout(struct net *net);
-static inline int mptcp_is_checksum_enabled(struct net *net) { return false; }
+int mptcp_is_checksum_enabled(struct net *net);
 void mptcp_subflow_fully_established(struct mptcp_subflow_context *subflow,
 				     struct mptcp_options_received *mp_opt);
 bool mptcp_subflow_data_available(struct sock *sk);
-- 
2.26.2

