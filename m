Received: from sender4-of-o54.zoho.com (sender4-of-o54.zoho.com [136.143.188.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BF5D3DAAAF
	for <mptcp@lists.linux.dev>; Wed,  5 Aug 2026 06:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785912013; cv=pass; b=LqYiT+SF6s8p47CNE0+krBCmsqJnZ+4//hQzFYfaoeFaIEjCSvDQ3l6aCqrwptPUZ9N+NSBUyjRf1EzBedefSyklcRGt0Od9xoQHtYKSY1TT/sGL0xQlN6NiIQzrADkERjsnmAw4RdF8Szc4Cjy+tydBPGwFAF/0l2k01ijPScc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785912013; c=relaxed/simple;
	bh=ouEEarbjxRD6l1Cv+TJ/0thIcsxDH3Ex23uVoGnq/4A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ASLz4BYsJUlhFgqO+aoWHUzSukz4YCh0EBYcZdewL0bMTK9eCPYrxOWVDRhdRWYYFfaTtYdr3ksgY51QgSQ/kswbsgVZXYjxTbNDRJYXf9W2n267V3Fl2vqyuc9tiP1IbPd20iG51OdDt45IzGlrWSZxyhKnXXup4RkFFeEVKN4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com; spf=pass smtp.mailfrom=mpiricsoftware.com; dkim=fail (0-bit key) header.d=mpiricsoftware.com header.i=kalpan.jani@mpiricsoftware.com header.b=h/TtVCC6 reason="key not found in DNS"; arc=pass smtp.client-ip=136.143.188.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mpiricsoftware.com header.i=kalpan.jani@mpiricsoftware.com header.b="h/TtVCC6"
ARC-Seal: i=1; a=rsa-sha256; t=1785912006; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=HE86I51xdIEGRrE5us1DOOcyb/NwHl3jfQxjvR/HQN2AcmbiO9LPDlK88b94ZRR3aO9YOg5t43MPohDk5IfPm59hSCvsZSFSMZ12F78NYLABLE6qOWLQdd2dLmi6fV+8xWp23h3wKUA41oGpEtayZErEiBbLYmBYSi/njAwJYmU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1785912006; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=cgu4dn5yFvLNFRx7nWp0crcWCQ5t7TSKSsuxUBLRtLk=; 
	b=PXi8EhcJ2M0bux+0KhBJSzF2oRkXtuN7JHKAzlCJcx2zoWixB8S52DuMArDhfKVSv/A9y1EGs4HXxMX56qEfUeTPbLVjOfw6Hg8fZXzBsQUv1zdyq5WtWBagkonJD5PEgnpW6qHSUOaou7qFi/U1f2jevqw7D5smyJ+8u1B73GA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=mpiricsoftware.com;
	spf=pass  smtp.mailfrom=kalpan.jani@mpiricsoftware.com;
	dmarc=pass header.from=<kalpan.jani@mpiricsoftware.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1785912006;
	s=mpiric; d=mpiricsoftware.com; i=kalpan.jani@mpiricsoftware.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=cgu4dn5yFvLNFRx7nWp0crcWCQ5t7TSKSsuxUBLRtLk=;
	b=h/TtVCC6hi+5nQqFrFMhxtQPVn2Zz9sB9s3/xWVJEwsJnq2GUFYrXWkceuqWXkxQ
	hrp6aAm8A1txSZ8/qyU1pFqrJDlr2CY5SL/URsMwoxM5oDcMdD8XYzXcU53QtWYuoOv
	JnfIG1aweXbEJKyIVwZMDn1AB4LpPLlN0iLYNgtk=
Received: by mx.zohomail.com with SMTPS id 1785912004534448.668404074642;
	Tue, 4 Aug 2026 23:40:04 -0700 (PDT)
From: Kalpan Jani <kalpan.jani@mpiricsoftware.com>
To: mptcp@lists.linux.dev
Cc: matttbe@kernel.org,
	martineau@kernel.org,
	pabeni@redhat.com,
	shardul.b@mpiricsoftware.com,
	janak@mpiric.us,
	kalpanjani009@gmail.com,
	Kalpan Jani <kalpan.jani@mpiricsoftware.com>,
	Li Xiasong <lixiasong1@huawei.com>
Subject: [PATCH mptcp-next v4] mptcp: honour configured min/max RTO in retransmit paths
Date: Wed,  5 Aug 2026 12:09:56 +0530
Message-ID: <20260805063956.3052563-1-kalpan.jani@mpiricsoftware.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

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
Reported-by: Li Xiasong <lixiasong1@huawei.com>
Closes: https://lore.kernel.org/all/95552642-7b60-410b-9953-70e0b31a90e1@huawei.com/
Signed-off-by: Kalpan Jani <kalpan.jani@mpiricsoftware.com>
---
Link to v1: https://lore.kernel.org/mptcp/20260610101123.765958-1-kalpan.jani@mpiricsoftware.com/
Link to v2: https://lore.kernel.org/mptcp/20260611064937.422416-1-kalpan.jani@mpiricsoftware.com/
Link to v3: https://lore.kernel.org/mptcp/20260617114508.253716-1-kalpan.jani@mpiricsoftware.com/

Changes since v3:
- read icsk_rto_min / icsk_rto_max directly instead of using the
  tcp_rto_min() / tcp_rto_max() helpers: the route metric checked by
  the helpers cannot apply on the msk (no routing lookup in these
  paths). This also removes the v2/v3 special case in
  __mptcp_init_sock() that avoided the dst lookup.
- drop the rto_min == 0 floor: without the route metric, rto_min
  comes from tcp_rto_min_us which has a floor of 1us, and
  usecs_to_jiffies() rounds up.
- rewrite the commit message: only the sysctls are honoured; the
  route metric and the TCP_RTO_MIN_US / TCP_RTO_MAX_MS socket
  options are explicitly out of scope.
- a Packetdrill patch extending mptcp/dss/dss_fin_retrans_*
  will be sent separately to validate mptcp_set_datafin_timeout().

Changes since v2:
- mptcp_set_datafin_timeout(): guard the division against a zero
  rto_min. Thanks to Li Xiasong for spotting it.
- __mptcp_init_sock(): order the local declarations longest-first
  (reverse christmas tree).

Changes since v1:
- __mptcp_init_sock(): seed icsk_rto_min / icsk_rto_max from the
  per-netns sysctls so the fields hold meaningful values on the msk
  (MPTCP does not call tcp_init_sock() on the msk).
- __mptcp_init_sock(): use icsk->icsk_rto_min directly for the initial
  timer_ival instead of tcp_rto_min(sk), to avoid a
  lockdep_rcu_suspicious() splat from __sk_dst_get() at socket init
  time. Reported by the mptcp CI on v1.
- mptcp_set_datafin_timeout(): add an ilog2(0) shift-safety guard for
  the rto_min >= rto_max corner case.

 net/mptcp/protocol.c | 24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 373406cff72e..aab78daa8bdf 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -570,17 +570,23 @@ static bool mptcp_pending_data_fin(struct sock *sk, u64 *seq)
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
@@ -3196,7 +3202,9 @@ static void mptcp_worker(struct work_struct *work)
 
 static void __mptcp_init_sock(struct sock *sk)
 {
+	struct inet_connection_sock *icsk = inet_csk(sk);
 	struct mptcp_sock *msk = mptcp_sk(sk);
+	struct net *net = sock_net(sk);
 
 	INIT_LIST_HEAD(&msk->conn_list);
 	INIT_LIST_HEAD(&msk->join_list);
@@ -3205,7 +3213,13 @@ static void __mptcp_init_sock(struct sock *sk)
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
2.43.0

