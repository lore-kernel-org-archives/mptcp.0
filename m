Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793316133;
	b=jgfJhs276NmC41vvhtTTscbSm1mbupRF0WthQwUmml7ltf7KJRzwFaAZTAAbpn19KTMU
	 uGMmNbAGF2QU2kr97rUWKCGtIw8jREHP2D90rE+nAOo/bybZ3Z5Vrhp3Vlh5cTZeYjyR2
	 s6VH7Z2cwLIjJ63dFgrJhIKMrKRriVJR0VBMBkUwbN1uydVWb10cC60LunJLx3w4VRLzk
	 aTlXmsTfQ11JlpSMXpmWXjVn1Wlb5Xk8X3kpxbeOTubOXmixMZz2Nvco47wM91hRmUaLv
	 KqU8kl6imvHRrq0hmkS0irYaBUjFy8ciuihdLH9rUxuFQ8CCkyM+rZEO80H0T2/82xg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793316133;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=0mwfzXjgJR769+bZp2OdJ/gIcyw6eV9uDbrZYfYqy94=;
	b=FHsJLPJhP7lTI/7ylkcWHgth/uK3PclehL6wF2Xtmcu9iP9iHgS2qKka5Ps6H00DwF/Z
	 mBteiIaPR2UP4Ldnla2teqn/yJaiFiQHqLkw5lke52yZoehjI3aWgi/BUQaPrR9ehmHKy
	 Fgt4CzsZ5cskqFJirv2kEKVVlXMcAh5ApQVbsLoooSXFmJ4j9AkxSo37DrupFVpl/xGyL
	 B/aloPqfThORbOdTkLpfd/q7YFXZtv5eCkbG0L1V62jkiQPOEhcsQamMwrvJ0BcXhgQVG
	 +sQTd2uVM/9EOwJ1S+H08JcniWciytqxkL9NFlY9BA20BxumG3HSeag7bVRdOxsr8Iw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S1IGMcT0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C51E4606A31A
	for <mptcp@lists.linux.dev>; Thu, 29 Oct 2026 23:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S1IGMcT0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DDBA1F01829;
	Thu, 29 Oct 2026 23:22:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793316132;
	bh=0mwfzXjgJR769+bZp2OdJ/gIcyw6eV9uDbrZYfYqy94=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=S1IGMcT08ao0hwDGJzqBdAkNO4DApUFqp8GnaCnfdloVF0tQVkpQPXq33zy9MXBFn
	 VwrrHyWCVjPM3XrZNvZ8ORlH+pvFzLEWVtqsqviKRHIoAV2gzgohc/yV7wY9Mr7BEY
	 5YjHNYxfBHCNq21pZjS5qzFsxCuWw/aw6gRhI+5IHFw2+3TdWWXfIfcruNLGsURU+H
	 RTtZPnsSB2lhB+jv6Y6GGs+NTUWxBUFq799ChP7rBGZ6arHiaj4n/+s5SM2sFbPLqY
	 3WBa8MgmrExFADKhSOwjW6fUhhfvO8f5v/HPZbT/ywQ2nurSxySSBU5OCkmxJ3kwy8
	 p2VVHW+rm6/PA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 30 Oct 2026 00:21:42 +0100
Subject: [PATCH mptcp-next v2 4/5] mptcp: pm: kernel: skip operating on
 closing connections
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261030-mptcp-reset-mpj-early-v2-4-90f119392263@kernel.org>
References: <20261030-mptcp-reset-mpj-early-v2-0-90f119392263@kernel.org>
In-Reply-To: <20261030-mptcp-reset-mpj-early-v2-0-90f119392263@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: Paolo Abeni <pabeni@redhat.com>, 
 Chenguang Zhao <chenguang.zhao@linux.dev>, Gang Yan <gang.yan@linux.dev>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2910; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=woq2Ebd+o/geGRTdpEwZaJeha2d3xtjlNHgyH/ud76k=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLIeX5VJOmllLrR4npY7307nj78vsfosVdGMr1RSzFyc+
 MHOTGhZRykLgxgXg6yYIot0W2T+zOdVvCVefhYwc1iZQIYwcHEKwER2v2Fk2F6ZEzrzu7IUQ7iu
 VG7MmQ/HtHRad4Rc+CUkq9jWu+22IsM/i0tSk44F2EQ2vJ7wZpNvutocP/ON7Ivrbh4RP3yde2Y
 LLwA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

When iterating over each MPTCP connection after having manipulated MPTCP
endpoints, there is no need to operate on closing (or not ready)
connections.

We can then safely skip those.

Note that mptcp_nl_add_subflow_or_signal_addr() was already checking the
fully_established state, but it is better to check the connection state
with mptcp_is_fully_established(): no need to create new subflows or
signal new addresses if we are closing.

For the other states, better not to check the connection state: it might
still be interesting to do some signalling while the connection is half
closed.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
v2: don't check the connection state, except for new subflow/ADD_ADDR.
---
 net/mptcp/pm_kernel.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
index d3014bf57bf3..096ffea80f61 100644
--- a/net/mptcp/pm_kernel.c
+++ b/net/mptcp/pm_kernel.c
@@ -969,7 +969,7 @@ static int mptcp_nl_add_subflow_or_signal_addr(struct net *net,
 		struct sock *sk = (struct sock *)msk;
 		struct mptcp_addr_info mpc_addr;
 
-		if (!READ_ONCE(msk->fully_established) ||
+		if (!mptcp_is_fully_established(sk) ||
 		    mptcp_pm_is_userspace(msk))
 			goto next;
 
@@ -1095,7 +1095,8 @@ static int mptcp_nl_remove_subflow_and_signal_addr(struct net *net,
 		struct sock *sk = (struct sock *)msk;
 		bool remove_subflow;
 
-		if (mptcp_pm_is_userspace(msk))
+		if (!READ_ONCE(msk->fully_established) ||
+		    mptcp_pm_is_userspace(msk))
 			goto next;
 
 		lock_sock(sk);
@@ -1141,7 +1142,9 @@ static int mptcp_nl_remove_id_zero_address(struct net *net,
 		struct mptcp_addr_info anno_addr;
 		bool announced;
 
-		if (list_empty(&msk->conn_list) || mptcp_pm_is_userspace(msk))
+		if (list_empty(&msk->conn_list) ||
+		    !READ_ONCE(msk->fully_established) ||
+		    mptcp_pm_is_userspace(msk))
 			goto next;
 
 		mptcp_local_address((struct sock_common *)msk, &msk_local);
@@ -1288,7 +1291,8 @@ static void mptcp_nl_flush_addrs_list(struct net *net,
 	while ((msk = mptcp_token_iter_next(net, &s_slot, &s_num)) != NULL) {
 		struct sock *sk = (struct sock *)msk;
 
-		if (!mptcp_pm_is_userspace(msk)) {
+		if (READ_ONCE(msk->fully_established) &&
+		    !mptcp_pm_is_userspace(msk)) {
 			lock_sock(sk);
 			mptcp_pm_flush_addrs_and_subflows(msk, rm_list, NULL);
 			release_sock(sk);
@@ -1502,7 +1506,9 @@ static void mptcp_pm_nl_set_flags_all(struct net *net,
 	while ((msk = mptcp_token_iter_next(net, &s_slot, &s_num)) != NULL) {
 		struct sock *sk = (struct sock *)msk;
 
-		if (list_empty(&msk->conn_list) || mptcp_pm_is_userspace(msk))
+		if (list_empty(&msk->conn_list) ||
+		    !READ_ONCE(msk->fully_established) ||
+		    mptcp_pm_is_userspace(msk))
 			goto next;
 
 		lock_sock(sk);

-- 
2.55.0

