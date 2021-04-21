Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C441F2F9B
	for <mptcp@lists.linux.dev>; Wed, 21 Apr 2021 15:38:10 +0000 (UTC)
IronPort-SDR: tJWdAIdCThDUJaX7hJbhs+iCEE4Z2QkdIjs8grsIKchCqYFrAwEYJu0THc/iXfmZxh+CXokErg
 B82bHW7G6peA==
X-IronPort-AV: E=McAfee;i="6200,9189,9961"; a="259672714"
X-IronPort-AV: E=Sophos;i="5.82,240,1613462400"; 
   d="scan'208";a="259672714"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2021 08:38:09 -0700
IronPort-SDR: XK0ks5qqnnxotdHY50P7RnYCt2kVjOH1mqZPTgz5fN2dJhTKZjRIJF0v20HqfS4X2oSF3HJ7E/
 kKg45At/yaAQ==
X-IronPort-AV: E=Sophos;i="5.82,240,1613462400"; 
   d="scan'208";a="463621278"
Received: from mjmartin-desk2.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.212.162.177])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2021 08:38:09 -0700
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: mptcp@lists.linux.dev
Cc: Mat Martineau <mathew.j.martineau@linux.intel.com>,
	pabeni@redhat.com
Subject: [PATCH mptcp-next v2] mptcp: Retransmit DATA_FIN
Date: Wed, 21 Apr 2021 08:38:05 -0700
Message-Id: <20210421153805.210668-1-mathew.j.martineau@linux.intel.com>
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
subflows. The retry interval starts at TCP_RTO_MIN and then doubles on
each attempt, up to TCP_RTO_MAX.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/146
Fixes: 43b54c6ee382 ("mptcp: Use full MPTCP-level disconnect state machine")
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---

v2: Simplify timeout limits, move function to avoid -net conflict

v1: Add backoff

Paolo and Matthieu mentioned sending to -net instead of net-next on IRC,
I will test out on that branch too.

 net/mptcp/protocol.c | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index a8180a917649..661873b373e3 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -392,6 +392,14 @@ static bool mptcp_pending_data_fin(struct sock *sk, u64 *seq)
 	return false;
 }
 
+static void mptcp_set_datafin_timeout(const struct sock *sk)
+{
+	struct inet_connection_sock *icsk = inet_csk(sk);
+
+	mptcp_sk(sk)->timer_ival = min(TCP_RTO_MAX,
+				       TCP_RTO_MIN << icsk->icsk_retransmits);
+}
+
 static void mptcp_set_timeout(const struct sock *sk, const struct sock *ssk)
 {
 	long tout = ssk && inet_csk(ssk)->icsk_pending ?
@@ -1061,7 +1069,8 @@ static void __mptcp_clean_una(struct sock *sk)
 		}
 	}
 
-	if (snd_una == READ_ONCE(msk->snd_nxt)) {
+	if (snd_una == READ_ONCE(msk->snd_nxt) &&
+	    !mptcp_data_fin_enabled(msk)) {
 		if (msk->timer_ival)
 			mptcp_stop_timer(sk);
 	} else {
@@ -2287,8 +2296,19 @@ static void __mptcp_retrans(struct sock *sk)
 
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

