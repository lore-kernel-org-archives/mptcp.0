Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 978B8468C22;
	Wed, 12 Aug 2026 14:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786546578; cv=none; b=UNZQJzdTDWaPTz1sPhdkf9vI1yX9EYdNNtNxwX+d2zHBJZdEndqikq+HKikboq1xwKMcee5sG2IsRwNN9H39IquHHY3SadXx4iREPR7y+HroTuGoHrQdVqRZ3xFX4iVtV71u4uB0/2rN9yl/wPYD9Q2YzdJKpHRmYGeQ7i6iGIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786546578; c=relaxed/simple;
	bh=1isvdAJraf3vPmJlBFNMJRSfcEoMPYoKAsSef2MxevY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=k8k8BVgtDZLf+OWkpcdBtx7rwyGkaA5hmUpw2HtlqH90lrgbWumNyo7u22g/THeDXQ1ev55M+pdsmN/SY8k847OBx1PkCBtfsTzt0QIgCyjfwxbJh8zbApsVR3gY4cg+ryKLS/dSPUN9TlGV+WD3baPAJV9zSMNOwME1zRtTBCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T07DeVzL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T07DeVzL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71A1F1F00AC4;
	Wed, 12 Aug 2026 14:56:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786546567;
	bh=N7N7M4T1qNAFQiNc7NOoy3Cg9WmfPmpVq/vTG0+7lE8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=T07DeVzL1cudML35F08jZuENeALvsrjldXyh1qWWMT7QsdYMduI0rdvPVOWNi3pTH
	 6PDRo0z5Pd0zNGbCavFWnjFM0358nJ0663poFFEH9h6s5Hy5ISW9jLGERizriAjhxh
	 e5PVJVeI1Pj4U1X/qzkGjlcDJp76kqm2grJyiAHFvIjK/ZbssTO9d1/jKDDE9jXaF8
	 Bhap5xa2FCrQA6XUPCkKGN/B9O3KLs2PCtz2wNbWvi8cwUcUZOzJj1dXx18wudaaRJ
	 vPp+Y3Wsbud7dNigmrCRdD/Yg25mYe3JZv7cT6zd0x8u0DZmXKo/GKdr0i+qgd3siL
	 1lj5EfmBP14QQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 12 Aug 2026 16:55:39 +0200
Subject: [PATCH net-next 04/11] mptcp: honour configured min/max RTO in
 retransmit paths
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260812-net-next-mptcp-misc-feat-7-3-v1-4-1905a818f6cb@kernel.org>
References: <20260812-net-next-mptcp-misc-feat-7-3-v1-0-1905a818f6cb@kernel.org>
In-Reply-To: <20260812-net-next-mptcp-misc-feat-7-3-v1-0-1905a818f6cb@kernel.org>
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Kalpan Jani <kalpan.jani@mpiricsoftware.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3975; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=b0s9mRuMHSIrzFAad1zYGyC0Q9A3Qoyr3eB8zA1JMwc=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLJqOkv/7ElwWeV+1Klx596s9Jq7pc2Li97YS/JMMvm2/
 8A6XuHijlIWBjEuBlkxRRbptsj8mc+reEu8/Cxg5rAygQxh4OIUgIlMOcrIcPzEd49p3KKVc/if
 aTEmTEm5l5UquvjxtR/JRfsV1z01CGf4K8txyeGE/FPDrc0VT2//2H7hhVYmU4yVhc28208v+E5
 R4wUA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Kalpan Jani <kalpan.jani@mpiricsoftware.com>

The MPTCP-level retransmit timers (DATA_FIN retransmissions and the
fallback timeout) used the hard-coded TCP_RTO_MIN / TCP_RTO_MAX
constants, ignoring the tcp_rto_min_us and tcp_rto_max_ms sysctls.

Make them follow the sysctls instead: seed icsk_rto_min / icsk_rto_max
on the MPTCP socket from the per-netns sysctls in __mptcp_init_sock()
-- the msk does not go through tcp_init_sock(), so these fields would
otherwise stay zero -- and read them directly where the constants were
used:

- mptcp_set_datafin_timeout(): both the backoff cap computation and
  the resulting timer_ival. The two sysctls are validated
  independently, so rto_min > rto_max is a valid configuration; keep
  a max_t() guard so ilog2() is never called with 0.

- __mptcp_set_timeout(): the fallback when no subflow timeout is
  available.

The icsk fields are read directly instead of using the
tcp_rto_min()/tcp_rto_max() helpers: the MPTCP socket does not perform
routing lookups in these paths, so the rto_min route metric checked by
tcp_rto_min() can never apply here. The TCP_RTO_MIN_US /
TCP_RTO_MAX_MS socket options are not supported by MPTCP setsockopt()
either; this can be revisited if they get supported on MPTCP sockets.

The remaining uses of TCP_RTO_MAX in net/mptcp/ctrl.c (default
add_addr_timeout) and net/mptcp/subflow.c (MP_FAIL timeout) are
intentionally left unchanged: they use the constant as a default
duration, not as an RTO bound on a retransmit timer.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/618
Signed-off-by: Kalpan Jani <kalpan.jani@mpiricsoftware.com>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/protocol.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index ec874d2ead6a..8f074d757743 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -581,17 +581,23 @@ static bool mptcp_pending_data_fin(struct sock *sk, u64 *seq)
 static void mptcp_set_datafin_timeout(struct sock *sk)
 {
 	struct inet_connection_sock *icsk = inet_csk(sk);
+	u32 rto_min = READ_ONCE(icsk->icsk_rto_min);
+	u32 rto_max = READ_ONCE(icsk->icsk_rto_max);
 	u32 retransmits;
 
+	/* The sysctls are validated independently: rto_min > rto_max is
+	 * possible, guard against ilog2(0).
+	 */
 	retransmits = min_t(u32, icsk->icsk_retransmits,
-			    ilog2(TCP_RTO_MAX / TCP_RTO_MIN));
+			    ilog2(max_t(u32, rto_max / rto_min, 1)));
 
-	mptcp_sk(sk)->timer_ival = TCP_RTO_MIN << retransmits;
+	mptcp_sk(sk)->timer_ival = rto_min << retransmits;
 }
 
 static void __mptcp_set_timeout(struct sock *sk, long tout)
 {
-	mptcp_sk(sk)->timer_ival = tout > 0 ? tout : TCP_RTO_MIN;
+	mptcp_sk(sk)->timer_ival = tout > 0 ? tout :
+				   READ_ONCE(inet_csk(sk)->icsk_rto_min);
 }
 
 static long mptcp_timeout_from_subflow(const struct mptcp_subflow_context *subflow)
@@ -3161,7 +3167,9 @@ static void mptcp_worker(struct work_struct *work)
 
 static void __mptcp_init_sock(struct sock *sk)
 {
+	struct inet_connection_sock *icsk = inet_csk(sk);
 	struct mptcp_sock *msk = mptcp_sk(sk);
+	struct net *net = sock_net(sk);
 
 	INIT_LIST_HEAD(&msk->conn_list);
 	INIT_LIST_HEAD(&msk->join_list);
@@ -3170,7 +3178,13 @@ static void __mptcp_init_sock(struct sock *sk)
 	INIT_WORK(&msk->work, mptcp_worker);
 	msk->out_of_order_queue = RB_ROOT;
 	msk->first_pending = NULL;
-	msk->timer_ival = TCP_RTO_MIN;
+
+	/* msk does not go through tcp_init_sock(); seed RTO bounds. */
+	icsk->icsk_rto_min =
+		usecs_to_jiffies(READ_ONCE(net->ipv4.sysctl_tcp_rto_min_us));
+	icsk->icsk_rto_max =
+		msecs_to_jiffies(READ_ONCE(net->ipv4.sysctl_tcp_rto_max_ms));
+	msk->timer_ival = icsk->icsk_rto_min;
 	msk->scaling_ratio = TCP_DEFAULT_SCALING_RATIO;
 	msk->backlog_len = 0;
 	mptcp_init_rtt_est(msk);

-- 
2.53.0

