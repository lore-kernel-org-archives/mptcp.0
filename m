Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [216.205.24.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB6970
	for <mptcp@lists.linux.dev>; Wed, 14 Jul 2021 08:55:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1626252912;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=T3RGyb+zajT5aErovwEcfuUzRg3qeu75zZIzghP+OUo=;
	b=S/dvhh0HciN03388p9hj5EHzkfTDdtGw3vN+GZxEZZXw9434VSaLwMv3u4njzBeeEA7jIX
	33h6kPFud0pzpYCll3Vw+VwO2pGaA6vI9fHggQHg9DTBbS6Jw9kzR00bQD3LxzU8N/3v4E
	2xLATb2AYu+YGvFExjK2fNt6S24V9oU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-181-HPhL2DTCPtOYOubjEeoogg-1; Wed, 14 Jul 2021 04:55:11 -0400
X-MC-Unique: HPhL2DTCPtOYOubjEeoogg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 99E5B9126D
	for <mptcp@lists.linux.dev>; Wed, 14 Jul 2021 08:55:10 +0000 (UTC)
Received: from gerbillo.redhat.com (ovpn-114-31.ams2.redhat.com [10.36.114.31])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 0FF2B5D6D1
	for <mptcp@lists.linux.dev>; Wed, 14 Jul 2021 08:55:09 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next] Squash-to: "mptcp: faster active backup recovery"
Date: Wed, 14 Jul 2021 10:55:06 +0200
Message-Id: <1d91265cca09bb69516907f44b5e4b72c4efabe1.1626252886.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"

kbuildbot rightfully complainted about non initialized variable
We can drop that variable altogether, and always try to push
the pending data: after the stale even we can possibly use
backup subflow to flush out tx queue.

Additionally fix doc a bit.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 Documentation/networking/mptcp-sysctl.rst | 12 ++++++------
 net/mptcp/pm_netlink.c                    | 12 +++++++-----
 2 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/Documentation/networking/mptcp-sysctl.rst b/Documentation/networking/mptcp-sysctl.rst
index 45fa8b2aefa8..b0d4da71e68e 100644
--- a/Documentation/networking/mptcp-sysctl.rst
+++ b/Documentation/networking/mptcp-sysctl.rst
@@ -47,12 +47,12 @@ allow_join_initial_addr_port - BOOLEAN
 	Default: 1
 
 stale_loss_cnt - INTEGER
-        The number of MPTCP-level retransmission intervals with no traffic and
-        pending outstanding data on a given subflow required to declare it stale.
-        The packet scheduler ignores stale subflows.
-        A low stale_loss_cnt  value allows for fast active-backup switch-over,
-        an high value maximixe links utilization on edge scenarios e.g. lossy
-        link with high BER or peer pausing the data processing.
+	The number of MPTCP-level retransmission intervals with no traffic and
+	pending outstanding data on a given subflow required to declare it stale.
+	The packet scheduler ignores stale subflows.
+	A low stale_loss_cnt  value allows for fast active-backup switch-over,
+	an high value maximize links utilization on edge scenarios e.g. lossy
+	link with high BER or peer pausing the data processing.
 
 	This is a per-namespace sysctl.
 
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 3d4fa2dd2cea..05a2da20ab31 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -908,7 +908,7 @@ void mptcp_pm_nl_subflow_chk_stale(const struct mptcp_sock *msk, struct sock *ss
 	unsigned int active_max_loss_cnt;
 	struct net *net = sock_net(sk);
 	unsigned int stale_loss_cnt;
-	bool slow, push;
+	bool slow;
 
 	stale_loss_cnt = mptcp_stale_loss_cnt(net);
 	if (subflow->stale || !stale_loss_cnt || subflow->stale_count <= stale_loss_cnt)
@@ -923,14 +923,16 @@ void mptcp_pm_nl_subflow_chk_stale(const struct mptcp_sock *msk, struct sock *ss
 			slow = lock_sock_fast(ssk);
 			if (!tcp_rtx_and_write_queues_empty(ssk)) {
 				subflow->stale = 1;
-				push = __mptcp_retransmit_pending_data(sk);
+				__mptcp_retransmit_pending_data(sk);
 				MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_SUBFLOWSTALE);
 			}
 			unlock_sock_fast(ssk, slow);
 
-			/* pending data on the idle subflow: retransmit */
-			if (push)
-				__mptcp_push_pending(sk, 0);
+			/* always try to push the pending data regarless of re-injections:
+			 * we can possibly use backup subflows now, and subflow selection
+			 * is cheap under the msk socket lock
+			 */
+			__mptcp_push_pending(sk, 0);
 			return;
 		}
 	}
-- 
2.26.3

