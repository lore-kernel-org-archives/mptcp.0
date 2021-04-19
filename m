Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FAF42F81
	for <mptcp@lists.linux.dev>; Mon, 19 Apr 2021 21:38:44 +0000 (UTC)
IronPort-SDR: fkv9ilYJiZ0EiY6WCqGdRUBaGhGwlKISECQpSPyPEYi1h2hP7t8drDxPYnAJNLP7pSsLpCfqaL
 4WiL9oXfR5Hg==
X-IronPort-AV: E=McAfee;i="6200,9189,9959"; a="192215879"
X-IronPort-AV: E=Sophos;i="5.82,235,1613462400"; 
   d="scan'208";a="192215879"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2021 14:38:42 -0700
IronPort-SDR: O8No1zt7lF1KiEeCZRUlwDUiTRciItOdDc4DxMkcAEX7eLrkc/PHSrhBlkOtwv1nfXaOQQYJje
 4Lt2NiuKKSgQ==
X-IronPort-AV: E=Sophos;i="5.82,235,1613462400"; 
   d="scan'208";a="426660514"
Received: from mjmartin-desk2.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.251.26.176])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2021 14:38:40 -0700
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: mptcp@lists.linux.dev
Cc: Mat Martineau <mathew.j.martineau@linux.intel.com>,
	pabeni@redhat.com
Subject: [PATCH mptcp-next] mptcp: Retransmit DATA_FIN
Date: Mon, 19 Apr 2021 14:38:36 -0700
Message-Id: <20210419213836.59887-1-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.31.1
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With this change, the MPTCP-level retransmission timer is used to resend
DATA_FIN. The retranmit timer is not stopped while waiting for a
MPTCP-level ACK of DATA_FIN, and retransmitted DATA_FINs are sent on all
subflows. The retry interval starts with a couple of attempts at
TCP_RTO_MIN and then doubles on each attempt, up to TCP_RTO_MAX.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/146
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---
 net/mptcp/protocol.c | 26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index a8180a917649..1fddaeeb8051 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -11,6 +11,7 @@
 #include <linux/netdevice.h>
 #include <linux/sched/signal.h>
 #include <linux/atomic.h>
+#include <linux/log2.h>
 #include <net/sock.h>
 #include <net/inet_common.h>
 #include <net/inet_hashtables.h>
@@ -402,6 +403,15 @@ static void mptcp_set_timeout(const struct sock *sk, const struct sock *ssk)
 	mptcp_sk(sk)->timer_ival = tout > 0 ? tout : TCP_RTO_MIN;
 }
 
+static void mptcp_set_datafin_timeout(const struct sock *sk)
+{
+	struct inet_connection_sock *icsk = inet_csk(sk);
+	int retransmits = clamp_val(icsk->icsk_retransmits, 1,
+				    ilog2(TCP_RTO_MAX / TCP_RTO_MIN));
+
+	mptcp_sk(sk)->timer_ival = TCP_RTO_MIN << retransmits;
+}
+
 static bool tcp_can_send_ack(const struct sock *ssk)
 {
 	return !((1 << inet_sk_state_load(ssk)) &
@@ -1061,7 +1071,8 @@ static void __mptcp_clean_una(struct sock *sk)
 		}
 	}
 
-	if (snd_una == READ_ONCE(msk->snd_nxt)) {
+	if (snd_una == READ_ONCE(msk->snd_nxt) &&
+	    !mptcp_data_fin_enabled(msk)) {
 		if (msk->timer_ival)
 			mptcp_stop_timer(sk);
 	} else {
@@ -2287,8 +2298,19 @@ static void __mptcp_retrans(struct sock *sk)
 
 	__mptcp_clean_una_wakeup(sk);
 	dfrag = mptcp_rtx_head(sk);
-	if (!dfrag)
+	if (!dfrag) {
+		if (mptcp_data_fin_enabled(msk)) {
+			struct inet_connection_sock *icsk = inet_csk(sk);
+
+			icsk->icsk_retransmits++;
+			mptcp_set_datafin_timeout(sk);
+			mptcp_send_ack(msk);
+
+			goto reset_timer;
+		}
+
 		return;
+	}
 
 	ssk = mptcp_subflow_get_retrans(msk);
 	if (!ssk)
-- 
2.31.1

