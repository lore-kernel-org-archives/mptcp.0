Received: from sender4-of-o54.zoho.com (sender4-of-o54.zoho.com [136.143.188.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2B533E866B
	for <mptcp@lists.linux.dev>; Wed, 10 Jun 2026 10:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781086303; cv=pass; b=P5C4XWaUBb9m+XZjOZOMk1d9MFwPSuMP7MMD5D0o1IHP1ir6tw8mX0bzCO70iAoF+AcrY3NKNi46Ap09q8FV/vZhqvWe6f11uCAp0An9O/exBOc4Qe6irT01Jv516QW49FxR0ugyATmKBKKtpokR+/5i5NKjI1bzAtinwoFE6O8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781086303; c=relaxed/simple;
	bh=JPtIwqSb368w8V7Z8pgXj133Mcnx8Gc8s0rVvWhZH1E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PqVH2VUkVMPzAVNgw6VSq4N9ESfMqcy3R62V6dye0Xd07HexbIT+8br1Ehh/mLYQxYWZ6lZcdTKFOwzaNLs7TI88gLRfyx87b7cfPryx8WJLTpRhakxogpODW5nrCn6Llpqq8Z2dn6zXldfWGr6fb4NX1WGaWIhnBddznTMmKQ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com; spf=pass smtp.mailfrom=mpiricsoftware.com; dkim=fail (0-bit key) header.d=mpiricsoftware.com header.i=kalpan.jani@mpiricsoftware.com header.b=KR0zux2x reason="key not found in DNS"; arc=pass smtp.client-ip=136.143.188.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mpiricsoftware.com header.i=kalpan.jani@mpiricsoftware.com header.b="KR0zux2x"
ARC-Seal: i=1; a=rsa-sha256; t=1781086296; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=cIttSW5dgHB8OMoGz8aKgTqj8Rdw7nz6mLvs9o5mf9slWYUlJfLn2BrQNmzV126YEfL/OvjT3INSzijMESf7qM40tRzGt3iO49D1vrrY9nH8gcGn+4gw2EF3Q+HUGRBSEWqYbhCSTTru8r6zzu7wj/7y/O/y3kl9syVEV2M5Fpo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1781086296; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=FddC0Y4jLLiJpbKtocbd1CBeCWgO+Yyjig/4QcI+OIo=; 
	b=X0bT4L4KrwUsThFaBVIFzSzQRFDPXHTpuKM90JhDimzAImaYz5uQgM0fI06W7XRhnZDz4FfzSUIAE44TlA4ckGtGA9AH3pxgpAmorcDC6f24eiAxtrrohPkCn5h4JM2MlEOfo8Nwy++pGPYj66i7ivPmTrJCIeuCKKOBdKktfq4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=mpiricsoftware.com;
	spf=pass  smtp.mailfrom=kalpan.jani@mpiricsoftware.com;
	dmarc=pass header.from=<kalpan.jani@mpiricsoftware.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1781086296;
	s=mpiric; d=mpiricsoftware.com; i=kalpan.jani@mpiricsoftware.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=FddC0Y4jLLiJpbKtocbd1CBeCWgO+Yyjig/4QcI+OIo=;
	b=KR0zux2xwTE3d1GdxKGOkMreQH5/77xpJ8d8JjOItJtFyXWAo4V/R4MzjKYCG1nf
	HGrOXWIM1xP5TzMKfKaegtqy90eFuVp0ZF3UdJqrWmjG7h6VqsJxSlFRY1ddMEI7G1A
	PdWSjgCMqHH/5HChItSSNPL0yGmFmMXXWCuJ4/UA=
Received: by mx.zohomail.com with SMTPS id 1781086293485802.9252304335502;
	Wed, 10 Jun 2026 03:11:33 -0700 (PDT)
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
Subject: [PATCH mptcp-next] mptcp: use configured TCP RTO min/max values
Date: Wed, 10 Jun 2026 15:41:23 +0530
Message-ID: <20260610101123.765958-1-kalpan.jani@mpiricsoftware.com>
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
    using them, then set the initial timer_ival via tcp_rto_min().

The remaining uses of TCP_RTO_MAX in net/mptcp/ctrl.c (ADD_ADDR
default add_addr_timeout) and net/mptcp/subflow.c (mptcp_subflow_fail()
MP_FAIL timeout) are intentionally left unchanged: they use the
constant as a default duration, not as an RTO bound on a retransmit
timer.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/618
Signed-off-by: Kalpan Jani <kalpan.jani@mpiricsoftware.com>
---
 net/mptcp/protocol.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index a4f7e99b30db..7e5eff25735d 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -563,12 +563,14 @@ static bool mptcp_pending_data_fin(struct sock *sk, u64 *seq)
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
+	msk->timer_ival = tcp_rto_min(sk);
 	msk->scaling_ratio = TCP_DEFAULT_SCALING_RATIO;
 	msk->backlog_len = 0;
 	mptcp_init_rtt_est(msk);
-- 
2.43.0

