Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04BDC3161A6
	for <mptcp@lists.linux.dev>; Fri, 12 Dec 2025 09:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765533562; cv=none; b=C1G69b227NAZ8l+rytM+1v4y2Iuf9s+GUaFirOpq+GW0o/EuYe4csU5UtyfTFAxhRMjq4OZ3N+3PW7DdpAoFUy4ZjKDZRkKGGaDbeC+khHIvQzssPD50iToafp/a8gyCcqrxCvVNUfioTLKxVEDqr4fU/4uHl4PJACSQY7mx/NQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765533562; c=relaxed/simple;
	bh=rcWaxzsy/BhKrpMBzTexaQPucukDOlfhcS9RbDkSI0w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=svMN+iYkbQbmQQnR+BB+bAKEZWgXDtfdfjrSl71aLAlIZzAH/IkHv+F9Vs+Jc8vLn7DmnXmdblCAkyrMtfRu3jQpB2VKWnPUvC3rcOpt6eT7D0loUdx/akOoGRDVTkK+35tsYpgWCTccg2Eour7fPJMYPtlucQF3GG4yoK6pW8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=UuiTApOi; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="UuiTApOi"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1765533557; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=g9p1PKRiJ+IqF8WgLeqdKGX/8PMrBBoE7jD+fozUtWI=;
	b=UuiTApOiUfTD8knDl1UusJtcTdpJfKBbE2Q4wc3IoHy79V9cQH3Zm3Dxv0wGYBufNdt9FR2V3cu17y6mUNrxcvip0LQkQ44bLXcih2ylaDhAx7ZMlNsT0hdOa1uOIrchdV8sYOKhh4I0qzMPTLbKq3XlUVyy849OjtAjtg9CR0g=
Received: from localhost(mailfrom:evan.li@linux.alibaba.com fp:SMTPD_---0WududpR_1765533555 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 12 Dec 2025 17:59:16 +0800
From: evan.li@linux.alibaba.com
To: matttbe@kernel.org,
	martineau@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	mptcp@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Evan Li <evan.li@linux.alibaba.com>,
	kitta <kitta@linux.alibaba.com>
Subject: [PATCH] subflow: relax WARN in subflow_data_ready() on teardown races
Date: Fri, 12 Dec 2025 17:59:09 +0800
Message-ID: <20251212095909.2480475-1-evan.li@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Evan Li <evan.li@linux.alibaba.com>

A WARN splat in subflow_data_ready() can be triggered when a subflow
enters an unexpected state during connection teardown or cleanup:

WARNING: net/mptcp/subflow.c:1527 at subflow_data_ready+0x38a/0x670

This comes from the following check:

WARN_ON_ONCE(!__mptcp_check_fallback(msk) &&
!subflow->mp_capable &&
!subflow->mp_join &&
!(state & TCPF_CLOSE));

Under fuzzing and other stress scenarios, there are legitimate windows
where this condition can become true without indicating a real bug, for
example:

during connection teardown / fastclose handling
races with subflow destruction
packets arriving after subflow cleanup
when the parent MPTCP socket is being destroyed
After commit ae155060247b ("mptcp: fix duplicate reset on fastclose"),
these edge cases became easier to trigger and the WARN started firing
spuriously, causing noisy reports but no functional issues.

Refine the state check in subflow_data_ready() so that:

if the socket is in a known teardown/cleanup situation
(SOCK_DEAD, zero parent refcnt, or repair/recv-queue handling),
the function simply returns without emitting a warning; and

for other unexpected states, we emit a ratelimited pr_debug() to
aid debugging, instead of a WARN_ON_ONCE() that can panic
fuzzing/CI kernels or flood logs in production.

This suppresses the bogus warning while preserving diagnostics for any
real state machine bugs.

Fixes: ae155060247b ("mptcp: fix duplicate reset on fastclose")
Reported-by: kitta <kitta@linux.alibaba.com>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=220856
Co-developed-by: kitta <kitta@linux.alibaba.com>
Signed-off-by: Evan Li <evan.li@linux.alibaba.com>
---
 net/mptcp/subflow.c | 24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 86ce58ae5..01d30679c 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1524,9 +1524,27 @@ static void subflow_data_ready(struct sock *sk)
 		return;
 	}
 
-	WARN_ON_ONCE(!__mptcp_check_fallback(msk) && !subflow->mp_capable &&
-		     !subflow->mp_join && !(state & TCPF_CLOSE));
-
+	/* Check if subflow is in a valid state. Skip warning for legitimate edge cases
+	 * such as connection teardown, race conditions, or when parent is being destroyed.
+	 */
+	if (!__mptcp_check_fallback(msk) && !subflow->mp_capable &&
+	    !subflow->mp_join && !(state & TCPF_CLOSE)) {
+	/* Legitimate cases where this can happen:
+	 * 1. During connection teardown
+	 * 2. Race conditions with subflow destruction
+	 * 3. Packets arriving after subflow cleanup
+	 * Log debug info but don't warn loudly in production.
+	 */
+	if (unlikely(tcp_sk(sk)->repair_queue == TCP_RECV_QUEUE ||
+	    sock_flag(sk, SOCK_DEAD) || !refcount_read(&parent->sk_refcnt))) {
+			/* Expected during cleanup, silently return */
+			return;
+	}
+	/* For other cases, still log for debugging but don't WARN */
+	if (net_ratelimit())
+		pr_debug("MPTCP: subflow in unexpected state sk=%p parent=%p state=%u\n",
+			 sk, parent, state);
+	}
 	if (mptcp_subflow_data_available(sk)) {
 		mptcp_data_ready(parent, sk);
 
-- 
2.43.7

