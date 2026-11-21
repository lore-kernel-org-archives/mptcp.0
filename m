Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795254182;
	b=aV4TP/xOOKNQ///fS00Y9y2xXwQSx3YEu3cnPnUFZ1MC922CoSj2ILf36STu3Zq2e0iJ
	 KK1Bp6fpOVYELCqNZbtQF9VFw3MykgO1IisAWfVHrgkJs1Jm+/bxdimPWB/QvBmDH9aAp
	 QHbfSElI24vdzmGSIjI+sPPgLSV4HKKKGfYkMQmaxu1TWHJrlkq31zoq6fL/lLuSxMFwM
	 TBz9kX0j/Ti3xffVf7SvvtoCy7HVOsj71nbxcpMflr+osqLXkHw7qdUoE05h8+Oglz5bY
	 7b+dG1aRuQ/XFwSwM8SL6GtucnUjQfZ7hVO5mEWTwztB53m5N0G2oDaveFsjrqt0n5g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795254182;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=ia1DWgqWy0P2JKk9je9n1B4CFCgpK4MUxLPC6PKr19c=;
	b=4Nkt7iRS+B+BSPDo2VjsuDq0zV0k8YV1WWKTB7WImF5mT5ETTY5/8GT2vbCgk3/T4kZJ
	 yTOJvPe9AEeyJHywistxTG9B9zWCQYf891eQmCMom+2ZTvC3i60mEJTJ+Hb/bz/+OeQ6g
	 EVrfbaRcsxE8M5frtYYCJD+vyUpF1YDSpkowtTHG1LPuGZ6m2HYjmr1/j+y9GPPNtHzEb
	 7io6qCPrZR1ba2kZe/AdQkDO5uavsGXrJagW9HYlqXs3hUgDnjp2qwQz8X3u8W3FIESSy
	 VLrdAqFIYBLFRnLOyegOuNZE7cbo9eifRSZ0renvHwo042k0xByWbQEG5BRjbzjewGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X07U3eWG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76B93606A320
	for <mptcp@lists.linux.dev>; Sat, 21 Nov 2026 09:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X07U3eWG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0C7C1F000C0;
	Sat, 21 Nov 2026 09:43:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795254182;
	bh=ia1DWgqWy0P2JKk9je9n1B4CFCgpK4MUxLPC6PKr19c=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=X07U3eWGWV0svxA9Vjocz8Hx8wec2DS5UxX09140SRoOnoVvos/lW1SHNXeYYjNHv
	 yyqxCIGXIXvYnW0dCqiWPfo0Pn9Cxu62xJyY1xyvaZCmbKfA5RRzueedTtcy2otZRS
	 UP2auyMSfmkf5dsuLH5W6DFvnH0c9FbGyWw7SxvbUuVcaynPJf0gkloGF5ydTA07oA
	 IsqvFdoEX88ZBELaj12U1/WW2i74Yk9sIPs4qs6oPSndf7ooeKoraR2/sT9mm1dvFP
	 n7eNDyOuwa8q6EAsJUWqOIUDEGJUeGvuxpuAUAVxO/2tb+zqj2OU+XhODAj18ViUbf
	 mkVUvLuMXoq1w==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Sat, 21 Nov 2026 10:41:47 +0100
Subject: [PATCH mptcp-net v2 49/62] mptcp: don't charge a subflow twice
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
Message-Id: <20261121-mptcp-cmason-fixes-v2-49-00327fd1de1f@kernel.org>
References: <20261121-mptcp-cmason-fixes-v2-0-00327fd1de1f@kernel.org>
In-Reply-To: <20261121-mptcp-cmason-fixes-v2-0-00327fd1de1f@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3140; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=5AP99MUQejesCJErjrK2RKdoKAWEdYHHwBLGL5uDdc8=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLIZ03Mlwo4a2vP+PtqT1fHo6M7Q16v/MdkeXL92nf49g
 ahn5ZZWHaUsDGJcDLJiiizSbZH5M59X8ZZ4+VnAzGFlAhnCwMUpABOZ+YXhF/PRb1c9t804NTvn
 hVpOzo1nr5Vm6e08Pz1PTmpq89y2j88ZGe5+PbCwyKjfvvTRr+/TD9ne7bvaVzH3V++00mPx917
 1qLMDAA==
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
index 9f5e8b5cde60..c16daa461290 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -4650,8 +4650,8 @@ static void mptcp_graft_subflows(struct sock *sk)
 
 		/* Subflows joining after __inet_accept() will get the
 		 * mem CG properly initialized at mptcp_finish_join() time,
-		 * but subflows pending in join_list need explicit
-		 * initialization by the loop below.
+		 * even if pending in join_list. The ones that joined before
+		 * need explicit initialization by the loop below.
 		 */
 		mptcp_data_lock(sk);
 		list_splice_init(&msk->join_list, &join_list);
@@ -4674,7 +4674,8 @@ static void mptcp_graft_subflows(struct sock *sk)
 		if (!ssk->sk_socket)
 			mptcp_sock_graft(ssk, sk->sk_socket);
 
-		if (!mem_cgroup_sk_enabled(sk))
+		/* Got the memcg when joining: its memory is already charged */
+		if (!mem_cgroup_sk_enabled(sk) || mem_cgroup_from_sk(ssk))
 			goto unlock;
 
 		__mptcp_inherit_cgrp_data(sk, ssk);

-- 
2.55.0

