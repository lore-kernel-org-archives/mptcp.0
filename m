Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795557701;
	b=kRnBkmsUjWmzDwFHSLzMQqyGzvYcuSvnhqXKuZe3hfvNtWZtBiqK3kHoBzDkD69TDU/6
	 PO5WkptvHHKq7//q2tkE9Yfn+zTmSn5473u1xQITCP6V1OOmOwUu+5Np9GhsZHAsSuSvF
	 5+EqvGri2xmxnr8cZniqxI+nxQkH+jNnTg5yw99uD12L8hqmch9Q5rsx4OD0gnSC22dFF
	 qy+WFI2W+Vhf/vQvCCtrjTi01r6P/Q+dPOTW3XHBDSFVNGeDR3m+VEz0yR61jDKTpod05
	 zt8uVVw22O+FRinhwN7cWF4xiQ82GbU9VZmWP5jIIsJcK6WbnItn9A6Re6QLTnPZubw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795557701;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=Go74yThHBrsGIdc8q8T69DSh++6U4M/PkWT1eGOmrMM=;
	b=c0sIBjZWNBqoj25Tgu9Of8troySqucSE/uTqBDm/+sRCl55Vi7+Euz/oQ1qLOr3U3GLc
	 YWCX/T3JCks3WEnOZ1jPD58TDVOy2RwUH5ZL2fEeDu8MD+kIZWooG4VEAu5/5GiDdcHIW
	 nkPiSczVXnf+VkcQN6TkDOmQ5oSajRHg4VWsLTDCSp9vclEpTDR4JZuyoHR/ShP8PJAAI
	 PTiVFxvDjlTuLH+VQkMdYSrbXWriuECcNf1PvqZDBI8l+tCnRX/k8no0aENZpav69AhC0
	 J+rLF6LiWgiG6HQlJuWFqjA1+N0uEFzhLtZbfLBs7oRq0xj0l+cnz7/fYeCwEDzvBiQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KE4YuMZ6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52DC0606A31E
	for <mptcp@lists.linux.dev>; Tue, 24 Nov 2026 22:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KE4YuMZ6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FEF51F000C0;
	Tue, 24 Nov 2026 22:01:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795557700;
	bh=Go74yThHBrsGIdc8q8T69DSh++6U4M/PkWT1eGOmrMM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=KE4YuMZ6D8LzwxT4hyumc9LvNFDdKx3Jjo4u+1Q4duu42YS2W2TGdLyJBHxfYDMis
	 vFZKnKwltazZOcTW2oueixF1dMUw+ogzSb99BZoWHnaelItmpKZkSQWVs+ybnF9Aoc
	 eaBT/hzbmrtu2klNyO50Y1CtiTFmj1kOdupGhGqEarSUaJC0F2lM044I9VrlbDfT4S
	 2A9e0lcRTQ47ObpWA9KyaR+PP/zmJjDtbirz+U+HEGQcg56hu3IbuN0pPYDMcFBa5G
	 YCkgea1IRoSb1ig9xdSCb6XHQulh9l8657N4wQEhDzlAlZd5D4RaBWJ40TpoOlx0kQ
	 F0/bxNw2+cNqA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 24 Nov 2026 22:59:52 +0100
Subject: [PATCH mptcp-net v3 35/50] mptcp: don't charge a subflow twice
 when it joins during accept()
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
Message-Id: <20261124-mptcp-cmason-fixes-v3-35-416c0920c73f@kernel.org>
References: <20261124-mptcp-cmason-fixes-v3-0-416c0920c73f@kernel.org>
In-Reply-To: <20261124-mptcp-cmason-fixes-v3-0-416c0920c73f@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3140; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=c2+ix/HGvshaaudfQy1jEBX8gZQBc0AgBNBUND/L2DE=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLLZOHm+ey1pvjxdcmXU912fzvT0vZRYfM7nz+eMCiWtr
 ffTbpxX7ShlYRDjYpAVU2SRbovMn/m8irfEy88CZg4rE8gQBi5OAZhIUwPDf9dVrC15BwWEOHLc
 djSuiFu6M+vPdYbz1dHTtnTdM/QTdmRkuMjbUp4ayGxSeOa9r63kXr5+p4271th933Pf3JJ15iV
 uFgA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

A subflow that joins an MPTCP connection while accept() runs can be
charged twice to the memory cgroup of the server, for the memory that
it already holds when accept() charges it. Nothing removes this extra
charge.

At accept(), __inet_accept() gives the MPTCP socket (msk) the memory
cgroup of the caller, then sets its sk_socket. From then on,
mptcp_finish_join() gives this memory cgroup to a joining subflow, via
mptcp_sock_check_graft(), and each page that the subflow reserves is
charged. Because accept() owns the msk, such a subflow is added to the
join list, which mptcp_graft_subflows() moves to the subflow list
before charging each subflow for the memory that it holds. A subflow
that joined in between is then charged a second time for this memory,
which will be uncharged only once.

The window is short: from the end of __inet_accept() to the start of
mptcp_graft_subflows(). And the extra charge is not zero only if data
was received on the new subflow before mptcp_graft_subflows() gets to
it, while a peer must not send data on it before the fourth ACK
(RFC 8684, section 3.2).

The fix used here is to skip, in mptcp_graft_subflows(), the subflows
that already have a memory cgroup: they got it when they joined, and
their memory has been charged since then.

This issue has been found by an AI code review agent, while reviewing
the code of the commit "mptcp: don't charge a shared page twice at
accept()". It cannot be triggered on demand: the window is too narrow.
It has been reproduced with a 500 ms sleep added after __inet_accept(),
to widen it, and a Packetdrill script sending 1000 bytes on a subflow
joining during accept(). Without this patch, a page stayed charged to
the memory cgroup once all the sockets were freed, and none with it:

  memcg sock: 4096 bytes

Fixes: 6228efe0cc01 ("mptcp: leverage the backlog for RX packet processing")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
v2: update a comment (Clashiko)
---
 net/mptcp/protocol.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index c9ef23276399..8017f8775728 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -4678,8 +4678,8 @@ static void mptcp_graft_subflows(struct sock *sk)
 
 		/* Subflows joining after __inet_accept() will get the
 		 * mem CG properly initialized at mptcp_finish_join() time,
-		 * but subflows pending in join_list need explicit
-		 * initialization by the loop below.
+		 * even if pending in join_list. The ones that joined before
+		 * need explicit initialization by the loop below.
 		 */
 		mptcp_data_lock(sk);
 		list_splice_init(&msk->join_list, &join_list);
@@ -4702,7 +4702,8 @@ static void mptcp_graft_subflows(struct sock *sk)
 		if (!ssk->sk_socket)
 			mptcp_sock_graft(ssk, sk->sk_socket);
 
-		if (!mem_cgroup_sk_enabled(sk))
+		/* Got the memcg when joining: its memory is already charged */
+		if (!mem_cgroup_sk_enabled(sk) || mem_cgroup_from_sk(ssk))
 			goto unlock;
 
 		__mptcp_inherit_cgrp_data(sk, ssk);

-- 
2.55.0

