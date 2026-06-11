Received: from sender4-of-o54.zoho.com (sender4-of-o54.zoho.com [136.143.188.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 977F637B021
	for <mptcp@lists.linux.dev>; Thu, 11 Jun 2026 06:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781160601; cv=pass; b=rITI0HaYS0Q1iTxYXqy5Cmcd5UcasYePlsfJjd7Lzho4dgG6EmqFVSdVuGgy+S0Fgr7jnQTZVahS0+RN7FDfxQa/GUS3tNiHyYKGXqm1iE0El7FbvgeKItNEcMo/FpfejcxLoEMZ1S4M95FxJ1uN4oIXzcBKDYA5VSIUAgUCTNc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781160601; c=relaxed/simple;
	bh=pXal4c69Dvd11yQL/vNJFMNb0yA1NM7wWH1YNONpiQM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TbVIK+d3BYJSH6A/KGY/K0kThg/0oTn4y4OB55v1SuG62xlGLLzaJm2+M65rylacAmk+5kLASH/DjAudI8MghdXicvrD6ES0QOtPHF4cU1sfjX3JWqgsLM7QpmHbB4ZAttAh+/TDeOcODCnFPRiCAgf8l6UCBVGzrk7+sXjecvk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com; spf=pass smtp.mailfrom=mpiricsoftware.com; dkim=fail (0-bit key) header.d=mpiricsoftware.com header.i=kalpan.jani@mpiricsoftware.com header.b=IembbcLw reason="key not found in DNS"; arc=pass smtp.client-ip=136.143.188.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mpiricsoftware.com header.i=kalpan.jani@mpiricsoftware.com header.b="IembbcLw"
ARC-Seal: i=1; a=rsa-sha256; t=1781160587; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=ZFQx8Pidhjm0GDH7dQ7G/dlibzRv4x3qclElXWts1dTP8P7m8ah9ZiHrY0/lwwsozM2AAt9Dl28aM47mkwDJrWMXEKqHjqgLu/uIHLggeq4tDKc2v8LZi6vn2XZ9jYL8aJHwxtPVrR6puOmH9nACpimN/9EGJ0VxPb4VpEo3S34=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1781160587; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=EhhoOZRC6JtRNSkP7uHlcFwkhHo/aNoQS5ETwHdnZSY=; 
	b=KU+KVpd+tRwbfkX+kFo9TpYNXdKL7Iq3HIJVqUBZ9dhgOcHcoe54kbi9OLigLYqwr9Omr0BXPhRhUV1UquhDOXvtXZDam+ygxMlspKzuU5okMdBhvxwp4JsRvqD3HoMe+JUUpDbeLOHjm8IWwISMjlsBJmEFh7NR/x4taDJQp4E=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=mpiricsoftware.com;
	spf=pass  smtp.mailfrom=kalpan.jani@mpiricsoftware.com;
	dmarc=pass header.from=<kalpan.jani@mpiricsoftware.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1781160587;
	s=mpiric; d=mpiricsoftware.com; i=kalpan.jani@mpiricsoftware.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=EhhoOZRC6JtRNSkP7uHlcFwkhHo/aNoQS5ETwHdnZSY=;
	b=IembbcLwBWL8Ys9nbuuxjnfxRvBTrlX6mOKuIdZTX98PN1waJk0vh1O1zzzvrWNn
	fNKMcrfnWjkVwmfgak+6QMxuqyKns6ojfGVDIzRK9yP8jo/hHV4NjfbL5EVIoTxqtM1
	IRmi68bpeCrk+iZd+YzkTzz/rHDPYc9f+JHIgFvs=
Received: by mx.zohomail.com with SMTPS id 1781160585222252.4775410542834;
	Wed, 10 Jun 2026 23:49:45 -0700 (PDT)
From: Kalpan Jani <kalpan.jani@mpiricsoftware.com>
To: mptcp@lists.linux.dev
Cc: matttbe@kernel.org,
	martineau@kernel.org,
	pabeni@redhat.com,
	shardul.b@mpiricsoftware.com,
	janak@mpiric.us,
	kalpanjani009@gmail.com,
	shardulsb08@gmail.com,
	Kalpan Jani <kalpan.jani@mpiricsoftware.com>
Subject: [PATCH mptcp-next v2] mptcp: use configured TCP RTO min/max values
Date: Thu, 11 Jun 2026 12:19:36 +0530
Message-ID: <20260611064937.422416-1-kalpan.jani@mpiricsoftware.com>
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

  - mptcp_set_datafin_timeout(): both the backoff cap computation
    and the resulting timer_ival now follow the configured values.
    Guard against a pathological rto_min >= rto_max (e.g. via BPF
    or racing sysctl writers) which would otherwise feed ilog2(0).

  - __mptcp_set_timeout(): the fallback when no subflow timeout is
    available now uses tcp_rto_min().

  - __mptcp_init_sock(): MPTCP does not invoke tcp_init_sock() on
    the msk, so inet_csk(sk)->icsk_rto_min and icsk_rto_max remain
    zero by default. Seed them from the per-netns sysctls before
    using them. The initial timer_ival reads icsk_rto_min directly
    rather than going through tcp_rto_min(sk): at socket init time
    sk_dst_cache is not yet under RCU/lock protection, and the dst
    lookup inside tcp_rto_min() would otherwise trip
    lockdep_rcu_suspicious() via __sk_dst_get() (reported by the
    mptcp CI on v1).

The remaining uses of TCP_RTO_MAX in net/mptcp/ctrl.c (ADD_ADDR
default add_addr_timeout) and net/mptcp/subflow.c (mptcp_subflow_fail()
MP_FAIL timeout) are intentionally left unchanged: they use the
constant as a default duration, not as an RTO bound on a retransmit
timer.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/618
Signed-off-by: Kalpan Jani <kalpan.jani@mpiricsoftware.com>
---
Link to v1: https://lore.kernel.org/mptcp/20260610101123.765958-1-kalpan.jani@mpiricsoftware.com/

Changes since v1:
 - __mptcp_init_sock(): seed icsk_rto_min / icsk_rto_max from the
   per-netns sysctls so that the helpers return meaningful values
   on the msk (MPTCP does not call tcp_init_sock() on the msk).
 - __mptcp_init_sock(): use icsk->icsk_rto_min directly for the
   initial timer_ival instead of tcp_rto_min(sk), to avoid a
   lockdep_rcu_suspicious() splat from __sk_dst_get() at socket
   init time. Reported by the mptcp CI on v1.
 - mptcp_set_datafin_timeout(): add an ilog2(0) shift-safety guard
   for the rto_min >= rto_max corner case.

 net/mptcp/protocol.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index a4f7e99b30db..878a0c023f90 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -563,17 +563,19 @@ static bool mptcp_pending_data_fin(struct sock *sk, u64 *seq)
 static void mptcp_set_datafin_timeout(struct sock *sk)
 {
 	struct inet_connection_sock *icsk = inet_csk(sk);
+	u32 rto_min = tcp_rto_min(sk);
+	u32 rto_max = tcp_rto_max(sk);
 	u32 retransmits;
 
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
@@ -3150,6 +3152,8 @@ static void mptcp_worker(struct work_struct *work)
 static void __mptcp_init_sock(struct sock *sk)
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
+	struct inet_connection_sock *icsk = inet_csk(sk);
+	struct net *net = sock_net(sk);
 
 	INIT_LIST_HEAD(&msk->conn_list);
 	INIT_LIST_HEAD(&msk->join_list);
@@ -3158,7 +3162,11 @@ static void __mptcp_init_sock(struct sock *sk)
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

