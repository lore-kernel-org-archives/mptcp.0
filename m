Received: from sender4-of-o54.zoho.com (sender4-of-o54.zoho.com [136.143.188.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C3B73EBF20
	for <mptcp@lists.linux.dev>; Wed, 17 Jun 2026 11:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781696728; cv=pass; b=t72nQtNVgrZR7sWGJssgv1J34W0SkP9WXGttLH4VAYt8VjzNP5HTnMEmnqLucejbU7Bd2I/UI8404MeuLTUsjN2mOj90OmJn15QprP0v5vyV+Mo8V4MWhTLIgvxPkZsiRDTxNvuF95oTvJCyKXCJT6cadSNXMt/RFMcWTYxuwc8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781696728; c=relaxed/simple;
	bh=cf1L1MEIkoQ1r8q6qvKVpFjbTplurty8EPiHIMbFBh8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=m0ogK0crqp3265XFJeUFGHg8gwHVYCmJF2UwNyFIwZ54Nbk6ZCRs8Oky6kkNSYwaXXuFVZsEbG5usBdY+hvSNGOkU0xIIGSBOqp6H20hEBqzVucQh9MDr+HC0UzQrr74EleKS3nzDKh8v4ubVIysgRiZNUCQ8n1unoH01x8scmA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com; spf=pass smtp.mailfrom=mpiricsoftware.com; dkim=fail (0-bit key) header.d=mpiricsoftware.com header.i=kalpan.jani@mpiricsoftware.com header.b=K3RD1209 reason="key not found in DNS"; arc=pass smtp.client-ip=136.143.188.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mpiricsoftware.com header.i=kalpan.jani@mpiricsoftware.com header.b="K3RD1209"
ARC-Seal: i=1; a=rsa-sha256; t=1781696720; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=FnqiqgazhMnVOBNPB+fd8DTuIureEmNgu+WKxm1rZ9Eu8zYv+9ADk7Vsxm8jV3yuWIOgLYiWdTIVLA9DAtDiE4j29gteqdAq9a/aqC41fqPDOFnsu4EyZYcjVtRId3uciOXk7IdNOva5P/psNPtkkpHWe9hiwXMFYS0a7q/Mhk8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1781696720; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=NOO90yKKQArqRH2ne/+Fa9jKi0lRvS6/xJz+w7aeOhU=; 
	b=iNsiLePP9Ezs0mCWuqHBBHIbgvjzdWjK5M8bkkcjx5/HggFoQpr91sIWENbl9DFOA533TxAQtI8wEWwCEqiwiB61r7NGPHmc9kAbJ7HVnxt6Ye0yEzs12rjlf3/RSwzqsTLueFdXxPwWVu9Pmt3FOBzLd717Re6sCLRnh/4zkFE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=mpiricsoftware.com;
	spf=pass  smtp.mailfrom=kalpan.jani@mpiricsoftware.com;
	dmarc=pass header.from=<kalpan.jani@mpiricsoftware.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1781696720;
	s=mpiric; d=mpiricsoftware.com; i=kalpan.jani@mpiricsoftware.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=NOO90yKKQArqRH2ne/+Fa9jKi0lRvS6/xJz+w7aeOhU=;
	b=K3RD12098AT1lGGldASNvXlsGEB+EvnobSjeOqZGngEzXn7RBQ81Fegu3BdHXHVR
	0D4R4Bj4JzNzvaHXZhwW96nVCdPtaZH74N+M091n4OB6vQCEAYQP5AoAOEUQlQH/zvk
	nj9kKpiEC5KG5/voO/2mbTKTZiqQQBSHr5XxOiPA=
Received: by mx.zohomail.com with SMTPS id 1781696718639241.46250971377128;
	Wed, 17 Jun 2026 04:45:18 -0700 (PDT)
From: Kalpan Jani <kalpan.jani@mpiricsoftware.com>
To: mptcp@lists.linux.dev
Cc: matttbe@kernel.org,
	martineau@kernel.org,
	pabeni@redhat.com,
	shardul.b@mpiricsoftware.com,
	janak@mpiric.us,
	kalpanjani009@gmail.com,
	akshit@mpiricsoftware.com,
	Kalpan Jani <kalpan.jani@mpiricsoftware.com>,
	Li Xiasong <lixiasong1@huawei.com>
Subject: [PATCH mptcp-next v3] mptcp: honour configured min/max RTO in retransmit paths
Date: Wed, 17 Jun 2026 17:15:08 +0530
Message-ID: <20260617114508.253716-1-kalpan.jani@mpiricsoftware.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

On the TCP side, the min/max RTO can be configured via the route
rto_min option, the TCP_BPF_RTO_MIN and TCP_RTO_MIN_US socket options,
and the tcp_rto_min_us / tcp_rto_max_ms sysctls, in that order of
precedence. MPTCP did not honour any of these because its retransmit
logic still used the hard-coded TCP_RTO_MIN / TCP_RTO_MAX constants.

Replace the constants with the tcp_rto_min() / tcp_rto_max() helpers
in the three MPTCP-level retransmit paths:

- mptcp_set_datafin_timeout(): both the backoff cap computation and
  the resulting timer_ival now follow the configured values. rto_min
  can resolve to 0 (e.g. "ip route ... rto_min 0"), so floor it to 1
  before using it: this keeps the rto_max / rto_min division and the
  rto_min << retransmits shift well-defined. The max_t(..., 1) guard
  still covers the separate rto_min >= rto_max case that would
  otherwise feed ilog2(0).

- __mptcp_set_timeout(): the fallback when no subflow timeout is
  available now uses tcp_rto_min().

- __mptcp_init_sock(): MPTCP does not invoke tcp_init_sock() on the
  msk, so inet_csk(sk)->icsk_rto_min and icsk_rto_max remain zero by
  default. Seed them from the per-netns sysctls before using them.
  The initial timer_ival reads icsk_rto_min directly rather than
  going through tcp_rto_min(sk): at socket init time sk_dst_cache is
  not yet under RCU/lock protection, and the dst lookup inside
  tcp_rto_min() would otherwise trip lockdep_rcu_suspicious() via
  __sk_dst_get() (reported by the mptcp CI on v1).

The remaining uses of TCP_RTO_MAX in net/mptcp/ctrl.c (ADD_ADDR
default add_addr_timeout) and net/mptcp/subflow.c (mptcp_subflow_fail()
MP_FAIL timeout) are intentionally left unchanged: they use the
constant as a default duration, not as an RTO bound on a retransmit
timer.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/618
Reported-by: Li Xiasong <lixiasong1@huawei.com>
Closes: https://lore.kernel.org/all/95552642-7b60-410b-9953-70e0b31a90e1@huawei.com/
Signed-off-by: Kalpan Jani <kalpan.jani@mpiricsoftware.com>
---
Link to v1: https://lore.kernel.org/mptcp/20260610101123.765958-1-kalpan.jani@mpiricsoftware.com/
Link to v2: https://lore.kernel.org/mptcp/20260611064937.422416-1-kalpan.jani@mpiricsoftware.com/

Changes since v2:
- mptcp_set_datafin_timeout(): floor rto_min to >= 1 so that a route
  metric of rto_min 0 (tcp_rto_min() == 0) can no longer divide by
  zero before the max_t() clamp. Thanks to Li Xiasong for spotting it.
- __mptcp_init_sock(): order the local declarations longest-first
  (reverse christmas tree).

Changes since v1:
- __mptcp_init_sock(): seed icsk_rto_min / icsk_rto_max from the
  per-netns sysctls so the helpers return meaningful values on the
  msk (MPTCP does not call tcp_init_sock() on the msk).
- __mptcp_init_sock(): use icsk->icsk_rto_min directly for the initial
  timer_ival instead of tcp_rto_min(sk), to avoid a
  lockdep_rcu_suspicious() splat from __sk_dst_get() at socket init
  time. Reported by the mptcp CI on v1.
- mptcp_set_datafin_timeout(): add an ilog2(0) shift-safety guard for
  the rto_min >= rto_max corner case.

 net/mptcp/protocol.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index a4f7e99b30db..4c5a89bd4c1b 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -563,17 +563,26 @@ static bool mptcp_pending_data_fin(struct sock *sk, u64 *seq)
 static void mptcp_set_datafin_timeout(struct sock *sk)
 {
 	struct inet_connection_sock *icsk = inet_csk(sk);
+	u32 rto_min = tcp_rto_min(sk);
+	u32 rto_max = tcp_rto_max(sk);
 	u32 retransmits;
 
+	/* A route metric can set rto_min to 0 ("ip route ... rto_min 0");
+	 * floor it so the division below and the "rto_min << retransmits"
+	 * shift stay well-defined.
+	 */
+	if (!rto_min)
+		rto_min = 1;
+
 	retransmits = min_t(u32, icsk->icsk_retransmits,
-			    ilog2(TCP_RTO_MAX / TCP_RTO_MIN));
+			    ilog2(max_t(u32, rto_max / rto_min, 1)));
 
-	mptcp_sk(sk)->timer_ival = TCP_RTO_MIN << retransmits;
+	mptcp_sk(sk)->timer_ival = rto_min << retransmits;
 }
 
 static void __mptcp_set_timeout(struct sock *sk, long tout)
 {
-	mptcp_sk(sk)->timer_ival = tout > 0 ? tout : TCP_RTO_MIN;
+	mptcp_sk(sk)->timer_ival = tout > 0 ? tout : tcp_rto_min(sk);
 }
 
 static long mptcp_timeout_from_subflow(const struct mptcp_subflow_context *subflow)
@@ -3149,7 +3158,9 @@ static void mptcp_worker(struct work_struct *work)
 
 static void __mptcp_init_sock(struct sock *sk)
 {
+	struct inet_connection_sock *icsk = inet_csk(sk);
 	struct mptcp_sock *msk = mptcp_sk(sk);
+	struct net *net = sock_net(sk);
 
 	INIT_LIST_HEAD(&msk->conn_list);
 	INIT_LIST_HEAD(&msk->join_list);
@@ -3158,7 +3169,11 @@ static void __mptcp_init_sock(struct sock *sk)
 	INIT_WORK(&msk->work, mptcp_worker);
 	msk->out_of_order_queue = RB_ROOT;
 	msk->first_pending = NULL;
-	msk->timer_ival = TCP_RTO_MIN;
+
+	/* msk does not go through tcp_init_sock(); seed RTO bounds. */
+	icsk->icsk_rto_min = usecs_to_jiffies(READ_ONCE(net->ipv4.sysctl_tcp_rto_min_us));
+	icsk->icsk_rto_max = msecs_to_jiffies(READ_ONCE(net->ipv4.sysctl_tcp_rto_max_ms));
+	msk->timer_ival = icsk->icsk_rto_min;
 	msk->scaling_ratio = TCP_DEFAULT_SCALING_RATIO;
 	msk->backlog_len = 0;
 	mptcp_init_rtt_est(msk);
-- 
2.43.0

