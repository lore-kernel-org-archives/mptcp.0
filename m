Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 704A6BE48
	for <mptcp@lists.linux.dev>; Mon,  4 Sep 2023 14:08:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1693836497;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=6NPkqx8hcDJ+Gbq7p2TtUz58j+/KTd9bdgX7srEulew=;
	b=YBvuaqAzp9WN3pxvjJ3K1aZst6FZiIrMUCAH3Fjc5giJvMdNO5n8RfUrNrdi/8Rg05MDNS
	a0wQZhmPBN6EExHJU/J75ZipUbGdDzf2QmwURLRmOwK8xdynch4Ho9vr4PZgkOdkcfwiVT
	EtHwyGSpzXi3Pup2e2R1/QJiOAEgkI0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-597-EXfjNyrCNfCrRTGkT3HsQw-1; Mon, 04 Sep 2023 10:08:16 -0400
X-MC-Unique: EXfjNyrCNfCrRTGkT3HsQw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AC809939EC3
	for <mptcp@lists.linux.dev>; Mon,  4 Sep 2023 14:08:15 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.211])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 3C1FAC02996
	for <mptcp@lists.linux.dev>; Mon,  4 Sep 2023 14:08:15 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next] mptcp: add a new sysctl for make after break timeout
Date: Mon,  4 Sep 2023 16:08:01 +0200
Message-ID: <85f43bff28d6d080642a968c12f68f87ee4baf5c.1693835482.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
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
 net/mptcp/ctrl.c     | 16 ++++++++++++++++
 net/mptcp/protocol.c |  5 +++--
 net/mptcp/protocol.h |  1 +
 3 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/ctrl.c b/net/mptcp/ctrl.c
index c46c22a84d23..b22d41729076 100644
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
@@ -140,6 +149,12 @@ static struct ctl_table mptcp_sysctl_table[] = {
 		.maxlen	= MPTCP_SCHED_NAME_MAX,
 		.mode = 0644,
 		.proc_handler = proc_dostring,
+	},
+		{
+		.procname = "close_timeout",
+		.maxlen = sizeof(unsigned int),
+		.mode = 0644,
+		.proc_handler = proc_dointvec_jiffies,
 	},
 	{}
 };
@@ -163,6 +178,7 @@ static int mptcp_pernet_new_table(struct net *net, struct mptcp_pernet *pernet)
 	table[4].data = &pernet->stale_loss_cnt;
 	table[5].data = &pernet->pm_type;
 	table[6].data = &pernet->scheduler;
+	table[7].data = &pernet->close_timeout;
 
 	hdr = register_net_sysctl(net, MPTCP_SYSCTL_PATH, table);
 	if (!hdr)
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 80d06cab8bc7..8022f00190ad 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2501,7 +2501,7 @@ static bool mptcp_close_tout_expired(const struct sock *sk)
 		return false;
 
 	return time_after32(tcp_jiffies32,
-		  inet_csk(sk)->icsk_mtup.probe_timestamp + TCP_TIMEWAIT_LEN);
+	    inet_csk(sk)->icsk_mtup.probe_timestamp + mptcp_close_timeout(sk));
 }
 
 static void mptcp_check_fastclose(struct mptcp_sock *msk)
@@ -2643,7 +2643,8 @@ void mptcp_reset_tout_timer(struct mptcp_sock *msk, unsigned long fail_tout)
 	if (!fail_tout && !inet_csk(sk)->icsk_mtup.probe_timestamp)
 		return;
 
-	close_timeout = inet_csk(sk)->icsk_mtup.probe_timestamp - tcp_jiffies32 + jiffies + TCP_TIMEWAIT_LEN;
+	close_timeout = inet_csk(sk)->icsk_mtup.probe_timestamp - tcp_jiffies32 + jiffies +
+			mptcp_close_timeout(sk);
 
 	/* the close timeout takes precedence on the fail one, and here at least one of
 	 * them is active
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 392c2f247034..1cade49205bd 100644
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

