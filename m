Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795557661;
	b=j9gI7B/VldDVAEMrozXNaOZDzzgRRSpwQ8yLA4io42t7If6YMPKfeTEGXNjKvXDb729t
	 ruMelHfjn4Pp9/O/ngYfRE16Daga8DZd5L6dAHqucqfk/gmURTh8yfVdrHFDGCqWIPZqC
	 EvCx8Q7REvpyJSuARhS43sW+bSSKOcnGhmwRZKJneOjyQzWvEP7tn+Cbk0HPBml0QLLdA
	 RmcqSzUUFKvtmAWed1Qgpl9rd5ALhUVT3WeMG5v+NW3+V5miR/0LHk2W90eolfAnrbQeR
	 6Tta/74u8CXOG3eKe+wOQ3plSPnSCFWqVl6WXTgjWmodv83/1SUTf7XzPpIPl9GZRwA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795557661;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=j7YnxP6rOSNn2PLyHdvoPa30Rf+gWB4c1ghCXQvP3qE=;
	b=HjiNdYKEkpF0S1F5N8g3sFnhF3qkbBGP0bfGatGrDg8sBLZ+9xXMnrjSNuTMuUe+9rX2
	 rXtHxUbOgSbV8RCeOLI6y63bF050TP8XNf3JVQzAMCvAd9gxL27p1woBCUJncFdVq8OSL
	 gwjT8jhnqNqT/6dufQZwxPMBjykD7J5JKmMU3GKPqIi04bx2G7d/ZNf+FrnJhakc19qTI
	 c6b+gU3HPPtvtZe3/wQQQwACbfwbNTf63lKcZdAog91kIJA0i2+HQQpe5qC1Bludki9px
	 EnrNHdHThcQ0Y+qadI1Sq0p+xPmu4p7vRzmit5UEOO9tlHJbSnhTyP6wavV9xswnYNQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mAZrFlms;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F955606A321
	for <mptcp@lists.linux.dev>; Tue, 24 Nov 2026 22:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mAZrFlms
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBBFB1F000E6;
	Tue, 24 Nov 2026 22:01:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795557661;
	bh=j7YnxP6rOSNn2PLyHdvoPa30Rf+gWB4c1ghCXQvP3qE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=mAZrFlmsf02t7X6Rj9b69lfChEnfNrmowdsxTeeKhgj4pVtyjGKRmMcTq0t5j1so4
	 cZhO01NWK7oeqvWN+TppSVVN7eyLPdA6XFN530qVh9QOvLCjrZJO7NeO65szC3l9l1
	 2dJTSSZbL1jO6T8jiWlxq6v1sHrWt8PDGCgUSxhB9Mg9hvG+cayZsfuk5gdVntP7KW
	 LUw1u417+0u1s7Wx+ienaY8qRWGzSCo9zWre4HoXVEjIdSoyskCLs4SVQZNVqGXuCg
	 WTwXirJoKHRiSmxA/ZH8ecs1MOuPCLtNlk96HQG8rkNI/GhV9M66xOFjE94309M++j
	 PRGOOVJlHJTtg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 24 Nov 2026 22:59:20 +0100
Subject: [PATCH mptcp-net v3 03/50] mptcp: count orphans as TCP does
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
Message-Id: <20261124-mptcp-cmason-fixes-v3-3-416c0920c73f@kernel.org>
References: <20261124-mptcp-cmason-fixes-v3-0-416c0920c73f@kernel.org>
In-Reply-To: <20261124-mptcp-cmason-fixes-v3-0-416c0920c73f@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3856; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=Vg4GQk5+3D7+3VKlhfVN6aAsV+cniQHjHlFCuV3qc70=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLLZOH68+he2dX28y/2PL641zj6+cPtU5XyP1YuusbS75
 bpUs1vrdZSyMIhxMciKKbJIt0Xmz3xexVvi5WcBM4eVCWQIAxenAExk8haGPxw3DAI2/GPiqy5o
 tMkQvxP3fOksW9cgXc2pmjHTWy7kTmb4Z/NoqaFFhiLfkxl/m5afabHaH8BnJ++8xGjyhzCn8mI
 LHgA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

The MPTCP sockets orphaned by close() were not counted in
tcp_orphan_count, contrary to TCP: tcp_max_orphans did not limit them,
and they were not visible in /proc/net/sockstat.

This is all the more needed since commit "mptcp: keep an orphan while it
can send its data": an orphan can then be kept longer than its close
timeout, e.g., as Sashiko noticed, by a peer acking the data at the TCP
level only, without moving the DATA_ACK.

Count them, and as TCP does, reset an orphan when there are too many
orphans, or when TCP uses too much memory: at close(), and when its
close timeout expires while it is kept to send its data. This is similar
to what tcp_out_of_resources() does from the TCP timers, without the
stricter limit for the stalled orphans. These resets are counted in
TCPAbortOnMemory, not in a new MPTCP counter: the MPTCP orphans now
share the TCP orphan count and limits.

This has been found by a review agent, and validated with a script
closing 8 connections whose peer doesn't read, with tcp_max_orphans set
to 4: the MPTCP orphans were all kept, without being counted, while
other orphans were reset. Now, only 5 or 6 are kept, vs 4 or 5 with TCP,
which also checks the limit from the timers of its orphans.

Fixes: e16163b6e2b7 ("mptcp: refactor shutdown and close")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
v2: new, spotted by a review agent

Note (Clashiko on v2): the reset reason stays TCP_ABORT_ON_CLOSE, as for
the other fastclose resets: only the tracepoint is affected.
---
 net/mptcp/protocol.c | 24 ++++++++++++++++++++++--
 net/mptcp/protocol.h |  1 +
 2 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index ff71f1954077..9e297fa08bfe 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2897,6 +2897,16 @@ static bool mptcp_subflow_probe_timed_out(struct sock *ssk)
 	return ret;
 }
 
+/* As TCP orphans: limited in number and memory */
+static bool mptcp_orphan_oom(struct sock *sk)
+{
+	if (!tcp_check_oom(sk, 0))
+		return false;
+
+	NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPABORTONMEMORY);
+	return true;
+}
+
 /* Before its DATA_FIN, keep an orphan while a subflow can send its data */
 static bool mptcp_orphan_keep(struct sock *sk)
 {
@@ -2914,7 +2924,7 @@ static bool mptcp_orphan_keep(struct sock *sk)
 		    tcp_jiffies32 - READ_ONCE(tcp_sk(ssk)->rcv_tstamp) <
 		    2 * TCP_RTO_MAX &&
 		    !mptcp_subflow_probe_timed_out(ssk))
-			return true;
+			return !mptcp_orphan_oom(sk);
 	}
 
 	return false;
@@ -3547,6 +3557,9 @@ static void __mptcp_destroy_sock(struct sock *sk)
 	sk_stream_kill_queues(sk);
 	xfrm_sk_free_policy(sk);
 
+	if (test_and_clear_bit(MPTCP_ORPHAN_COUNTED, &msk->flags))
+		tcp_orphan_count_dec();
+
 	sock_put(sk);
 }
 
@@ -3636,8 +3649,15 @@ bool __mptcp_close(struct sock *sk, long timeout)
 	/* all the subflows are closed, only timeout can change the msk
 	 * state, let's not keep resources busy for no reasons
 	 */
-	if (subflows_alive == 0)
+	if (subflows_alive == 0) {
 		mptcp_set_state(sk, TCP_CLOSE);
+	} else if (sk->sk_state != TCP_CLOSE) {
+		/* as TCP orphans: counted, and limited */
+		tcp_orphan_count_inc();
+		set_bit(MPTCP_ORPHAN_COUNTED, &msk->flags);
+		if (mptcp_orphan_oom(sk))
+			mptcp_do_fastclose(sk);
+	}
 
 	sock_hold(sk);
 	pr_debug("msk=%p state=%d\n", sk, sk->sk_state);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 2c9a442dacd6..888ee9d66967 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -117,6 +117,7 @@
 #define MPTCP_FALLBACK_DONE	2
 #define MPTCP_WORK_CLOSE_SUBFLOW 3
 #define MPTCP_RTX_ENABLED	4
+#define MPTCP_ORPHAN_COUNTED	5
 
 /* MPTCP socket release cb flags */
 #define MPTCP_PUSH_PENDING	1

-- 
2.55.0

