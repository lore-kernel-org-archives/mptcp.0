Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0E191172D
	for <mptcp@lists.linux.dev>; Mon, 11 Sep 2023 10:34:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1694428498;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=86bPjSg1OU8hjUIqulyzZIcG1YigJJ7d5gRoJp+awLU=;
	b=GhQVSlKbjs/hMDokbn7FIsVzxQ+22DhSUTJM/edxNUkeqPB/rIyp6GgLWcnkMIh6fv+rWG
	5cwnN/eHW0bOeG9/mYiAJ27EAKfTUZ3cN5Lgnj19sy4Q6VS7gNeVjSuACoJ4jcrICFE5fY
	yW609r2FttBeNk/cg02iTSg1ql+G73U=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-541-2cPVceIzOcWOWRbMKj9bvQ-1; Mon, 11 Sep 2023 06:34:57 -0400
X-MC-Unique: 2cPVceIzOcWOWRbMKj9bvQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E93E3181A6E0
	for <mptcp@lists.linux.dev>; Mon, 11 Sep 2023 10:34:56 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.131])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 7775540C2064
	for <mptcp@lists.linux.dev>; Mon, 11 Sep 2023 10:34:56 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next v3] mptcp: add a new sysctl for make after break timeout
Date: Mon, 11 Sep 2023 12:34:53 +0200
Message-ID: <fe8c2c5502b7a924bdcba6621486e1e68861f9fd.1694426964.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

The MPTCP protocol allows sockets with no alive subflows to stay
in ESTABLISHED status for and user-defined timeout, to allow for
later subflows creation.

Currently such timeout is constant - TCP_TIMEWAIT_LEN. Let the
user-space configure them via a newly added sysctl, to better cope
with busy servers and simplify (make them faster) the relevant
pktdrill tests.

Note that the new know does not apply to orphaned MPTCP socket
waiting for the data_fin handshake completion: they always wait
TCP_TIMEWAIT_LEN.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
v2 -> v3:
 - fix doc intentation (Matttbe)
 - use mptcp_close_timeout() in __mptcp_close_ssk, too (Mat)

v1 -> v2:
 - add the doc for the new knob (Matttbe)
 - fix a couple of bad/strange indentation (Matttbe)
---
 Documentation/networking/mptcp-sysctl.rst | 11 +++++++++++
 net/mptcp/ctrl.c                          | 16 ++++++++++++++++
 net/mptcp/protocol.c                      |  6 +++---
 net/mptcp/protocol.h                      |  1 +
 4 files changed, 31 insertions(+), 3 deletions(-)

diff --git a/Documentation/networking/mptcp-sysctl.rst b/Documentation/networking/mptcp-sysctl.rst
index 15f1919d640c..69975ce25a02 100644
--- a/Documentation/networking/mptcp-sysctl.rst
+++ b/Documentation/networking/mptcp-sysctl.rst
@@ -25,6 +25,17 @@ add_addr_timeout - INTEGER (seconds)
 
 	Default: 120
 
+close_timeout - INTEGER (seconds)
+	Set the make-after-break timeout: in absence of any close or
+	shutdown syscall, MPTCP sockets will maintain the status
+	unchanged for such time, after the last subflow removal, before
+	moving to TCP_CLOSE.
+
+	The default value matches TCP_TIMEWAIT_LEN. This is a per-namespace
+	sysctl.
+
+	Default: 60
+
 checksum_enabled - BOOLEAN
 	Control whether DSS checksum can be enabled.
 
diff --git a/net/mptcp/ctrl.c b/net/mptcp/ctrl.c
index e72b518c5d02..13fe0748dde8 100644
--- a/net/mptcp/ctrl.c
+++ b/net/mptcp/ctrl.c
@@ -27,6 +27,7 @@ struct mptcp_pernet {
 #endif
 
 	unsigned int add_addr_timeout;
+	unsigned int close_timeout;
 	unsigned int stale_loss_cnt;
 	u8 mptcp_enabled;
 	u8 checksum_enabled;
@@ -65,6 +66,13 @@ unsigned int mptcp_stale_loss_cnt(const struct net *net)
 	return mptcp_get_pernet(net)->stale_loss_cnt;
 }
 
+unsigned int mptcp_close_timeout(const struct sock *sk)
+{
+	if (sock_flag(sk, SOCK_DEAD))
+		return TCP_TIMEWAIT_LEN;
+	return mptcp_get_pernet(sock_net(sk))->close_timeout;
+}
+
 int mptcp_get_pm_type(const struct net *net)
 {
 	return mptcp_get_pernet(net)->pm_type;
@@ -79,6 +87,7 @@ static void mptcp_pernet_set_defaults(struct mptcp_pernet *pernet)
 {
 	pernet->mptcp_enabled = 1;
 	pernet->add_addr_timeout = TCP_RTO_MAX;
+	pernet->close_timeout = TCP_TIMEWAIT_LEN;
 	pernet->checksum_enabled = 0;
 	pernet->allow_join_initial_addr_port = 1;
 	pernet->stale_loss_cnt = 4;
@@ -141,6 +150,12 @@ static struct ctl_table mptcp_sysctl_table[] = {
 		.mode = 0644,
 		.proc_handler = proc_dostring,
 	},
+	{
+		.procname = "close_timeout",
+		.maxlen = sizeof(unsigned int),
+		.mode = 0644,
+		.proc_handler = proc_dointvec_jiffies,
+	},
 	{}
 };
 
@@ -163,6 +178,7 @@ static int mptcp_pernet_new_table(struct net *net, struct mptcp_pernet *pernet)
 	table[4].data = &pernet->stale_loss_cnt;
 	table[5].data = &pernet->pm_type;
 	table[6].data = &pernet->scheduler;
+	table[7].data = &pernet->close_timeout;
 
 	hdr = register_net_sysctl_sz(net, MPTCP_SYSCTL_PATH, table,
 				     ARRAY_SIZE(mptcp_sysctl_table));
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 3facdc006adc..1a0b463f8c97 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2377,8 +2377,8 @@ static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 	if (msk->in_accept_queue && msk->first == ssk &&
 	    (sock_flag(sk, SOCK_DEAD) || sock_flag(ssk, SOCK_DEAD))) {
 		/* ensure later check in mptcp_worker() will dispose the msk */
-		mptcp_set_close_tout(sk, tcp_jiffies32 - (TCP_TIMEWAIT_LEN + 1));
 		sock_set_flag(sk, SOCK_DEAD);
+		mptcp_set_close_tout(sk, tcp_jiffies32 - (mptcp_close_timeout(sk) + 1));
 		lock_sock_nested(ssk, SINGLE_DEPTH_NESTING);
 		mptcp_subflow_drop_ctx(ssk);
 		goto out_release;
@@ -2506,7 +2506,7 @@ static bool mptcp_close_tout_expired(const struct sock *sk)
 		return false;
 
 	return time_after32(tcp_jiffies32,
-		  inet_csk(sk)->icsk_mtup.probe_timestamp + TCP_TIMEWAIT_LEN);
+		  inet_csk(sk)->icsk_mtup.probe_timestamp + mptcp_close_timeout(sk));
 }
 
 static void mptcp_check_fastclose(struct mptcp_sock *msk)
@@ -2649,7 +2649,7 @@ void mptcp_reset_tout_timer(struct mptcp_sock *msk, unsigned long fail_tout)
 		return;
 
 	close_timeout = inet_csk(sk)->icsk_mtup.probe_timestamp - tcp_jiffies32 + jiffies +
-			TCP_TIMEWAIT_LEN;
+			mptcp_close_timeout(sk);
 
 	/* the close timeout takes precedence on the fail one, and here at least one of
 	 * them is active
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index aebc0cc24dad..0147419065dc 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -624,6 +624,7 @@ unsigned int mptcp_get_add_addr_timeout(const struct net *net);
 int mptcp_is_checksum_enabled(const struct net *net);
 int mptcp_allow_join_id0(const struct net *net);
 unsigned int mptcp_stale_loss_cnt(const struct net *net);
+unsigned int mptcp_close_timeout(const struct sock *sk);
 int mptcp_get_pm_type(const struct net *net);
 const char *mptcp_get_scheduler(const struct net *net);
 void mptcp_subflow_fully_established(struct mptcp_subflow_context *subflow,
-- 
2.41.0

