Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 027E73FC8
	for <mptcp@lists.linux.dev>; Fri, 24 Sep 2021 21:12:49 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10117"; a="246639641"
X-IronPort-AV: E=Sophos;i="5.85,321,1624345200"; 
   d="scan'208";a="246639641"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2021 14:12:47 -0700
X-IronPort-AV: E=Sophos;i="5.85,321,1624345200"; 
   d="scan'208";a="704320293"
Received: from mjmartin-desk2.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.209.52.210])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2021 14:12:46 -0700
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Florian Westphal <fw@strlen.de>,
	davem@davemloft.net,
	kuba@kernel.org,
	matthieu.baerts@tessares.net,
	mptcp@lists.linux.dev,
	pabeni@redhat.com,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH net-next 5/5] mptcp: re-arm retransmit timer if data is pending
Date: Fri, 24 Sep 2021 14:12:38 -0700
Message-Id: <20210924211238.162509-6-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210924211238.162509-1-mathew.j.martineau@linux.intel.com>
References: <20210924211238.162509-1-mathew.j.martineau@linux.intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Florian Westphal <fw@strlen.de>

The retransmit head will be NULL in case there is no in-flight data
(meaning all data injected into network has been acked).

In that case the retransmit timer is stopped.

This is only correct if there is no more pending, not-yet-sent data.

If there is, the retransmit timer needs to set the PENDING bit again so
that mptcp tries to send the remaining (new) data once a subflow can accept
more data.

Also, mptcp_subflow_get_retrans() has to be called unconditionally.

This function checks for subflows that have become unresponsive and marks
them as stale, so in the case where the rtx queue is empty, subflows
will never be marked stale which prevents available backup subflows from
becoming eligible for transmit.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/226
Acked-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---
 net/mptcp/protocol.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 5b0ed64c5cd2..8029bbbe1c9e 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1105,7 +1105,8 @@ static void __mptcp_clean_una(struct sock *sk)
 	if (cleaned && tcp_under_memory_pressure(sk))
 		__mptcp_mem_reclaim_partial(sk);
 
-	if (snd_una == READ_ONCE(msk->snd_nxt) && !msk->recovery) {
+	if (snd_una == READ_ONCE(msk->snd_nxt) &&
+	    snd_una == READ_ONCE(msk->write_seq)) {
 		if (mptcp_timer_pending(sk) && !mptcp_data_fin_enabled(msk))
 			mptcp_stop_timer(sk);
 	} else {
@@ -1547,6 +1548,13 @@ static void mptcp_update_post_push(struct mptcp_sock *msk,
 		msk->snd_nxt = snd_nxt_new;
 }
 
+static void mptcp_check_and_set_pending(struct sock *sk)
+{
+	if (mptcp_send_head(sk) &&
+	    !test_bit(MPTCP_PUSH_PENDING, &mptcp_sk(sk)->flags))
+		set_bit(MPTCP_PUSH_PENDING, &mptcp_sk(sk)->flags);
+}
+
 void __mptcp_push_pending(struct sock *sk, unsigned int flags)
 {
 	struct sock *prev_ssk = NULL, *ssk = NULL;
@@ -2414,6 +2422,9 @@ static void __mptcp_retrans(struct sock *sk)
 	int ret;
 
 	mptcp_clean_una_wakeup(sk);
+
+	/* first check ssk: need to kick "stale" logic */
+	ssk = mptcp_subflow_get_retrans(msk);
 	dfrag = mptcp_rtx_head(sk);
 	if (!dfrag) {
 		if (mptcp_data_fin_enabled(msk)) {
@@ -2426,10 +2437,12 @@ static void __mptcp_retrans(struct sock *sk)
 			goto reset_timer;
 		}
 
-		return;
+		if (!mptcp_send_head(sk))
+			return;
+
+		goto reset_timer;
 	}
 
-	ssk = mptcp_subflow_get_retrans(msk);
 	if (!ssk)
 		goto reset_timer;
 
@@ -2456,6 +2469,8 @@ static void __mptcp_retrans(struct sock *sk)
 	release_sock(ssk);
 
 reset_timer:
+	mptcp_check_and_set_pending(sk);
+
 	if (!mptcp_timer_pending(sk))
 		mptcp_reset_timer(sk);
 }
-- 
2.33.0

