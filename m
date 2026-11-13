Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794599664;
	b=OJA4Zu0vFFeetQ1DYAjybjtGzWn/Zsd4Bc+adO+myE3uG41iFijd7ydU7xJRiBvzw3b0
	 k2Oct1+FyXQfi+6bLZSTAAisbB6qcx+xEW40V+aoZqDsAL8aF7HXmC5RWplHd2GjfIEqu
	 ZWi2Q9d/z+jd/BdnBVEWi44Qxqcu4mtx2IntSq6DMrkK+695PBNqTA5UzfS6iroUbTBQ5
	 nh2liu1aG9MxfpxQv5nze628SpjGlt4DyYxtK1tIAuFkxRPsOWDvQWPNdxhcPMWJarzb2
	 yjf392hw/JHtJAK0B0eNAR2NIbo+DjUYWKRqsjZVtnfcQJsVgbElEaCWUQJtMHEE3NA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794599664;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=WlVoQwBOD98FsntzSXYjwcQNRhMCA32Z4TULn6kiQX4=;
	b=HElqvsxXF7ypku0QA9enNIoOkdZqHdveyGBFwf+YF6Ad+RW5kmKwMzIsttWlQnfQbSMG
	 oOVRev+cw1Mq+8z4t36Wa07asChCgEQuNsXpzrbYlGAcNAc9BZt5DSLNWixf2BjOw1sK7
	 FZjNR/GEycRYedvbnfuD8Cjlumx6UyXoioJROjwCH6t3Pq3uBfhzbnYTBA+KPSqsSNOyW
	 Y61fwMWcink5L9UtpGJ3X30kynBQpm7vDPNKo/h4PZVUAGoN+ShkGrUi2MrJPO7bht4Q7
	 qmmGxsz98PPq4TZaCvXjrQM14iyX6Umt14Ph7HntQq5tt3RMni8dEpYurSP3cdqfvmA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YSLpblRr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37ED760A6F5E
	for <mptcp@lists.linux.dev>; Fri, 13 Nov 2026 19:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YSLpblRr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AADE1F000C4;
	Fri, 13 Nov 2026 19:54:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794599663;
	bh=WlVoQwBOD98FsntzSXYjwcQNRhMCA32Z4TULn6kiQX4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=YSLpblRrLQ8BLC/+sXbyQwTbEtr5BFndCGhVi7dT0d7gtkBLXTErtggBNdrONYSDj
	 jcR0F624asOo04MTDLgu0Jb/fTJYhVUBDA5ebWXrxy5pEDrXuhX5VnY30vE8Ja7tMm
	 Skzd800DLF4N+oMlxAVQj9vIxf09PNbZkd/Y7FGf0jsUuizwB1mLC64ptY6mOrDA4N
	 HFT5BHTP5Dyfd4Lwmg9H1sg+G1Xg1L9L+rmiOzlbI9Ras5JjyxjI+gSCc/yYT5naYh
	 KsIuRWaDZsLCeXBoDJnAr1rxPAoTlH3lQcxLR/B+yUEZkfczyAJ+N/Ubh45iQzcuGP
	 fxVyB9TfBj/nQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 13 Nov 2026 20:53:39 +0100
Subject: [PATCH mptcp-net 01/34] tcp: drain the queues of a listen() that
 fails
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
Message-Id: <20261113-mptcp-cmason-fixes-v1-1-9205b77e9a2f@kernel.org>
References: <20261113-mptcp-cmason-fixes-v1-0-9205b77e9a2f@kernel.org>
In-Reply-To: <20261113-mptcp-cmason-fixes-v1-0-9205b77e9a2f@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: Chris Mason <mason@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3030; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=ui59Jfi6boLWjAp+vVvjeH9o6lXzt/dtmY5zVvV9JUk=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLK+Z10yvx0RmPfIyKppp+b53d2N5ms5xHqZjy531T97O
 zhg14x1HaUsDGJcDLJiiizSbZH5M59X8ZZ4+VnAzGFlAhnCwMUpABc5zcjwKbD45wff730dNxnX
 79Q6KXn7EqfPodNfSuN1D17qCiiPYWTY5nx768nXm97lb9yxf/1Ta4kb/zb1pZ+WlPK3/6XNu+Y
 MNwA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Chris Mason <mason@kernel.org>

If listen() fails on a TCP socket that has listened before, the sockets
of connections from the earlier listen() can leak, together with their
network namespace.

inet_csk_listen_start() sets TCP_LISTEN before it calls get_port() and
hash(), and its error path only sets TCP_CLOSE again, which relies on
nothing reaching the socket before it is in the listener hash. But
pending request socks outlive an earlier listen() and still point to the
socket, so in TCP_LISTEN, inet_csk_reqsk_queue_add() adds them to the
accept queue and reqsk_fastopen_remove() adds them to the RST queue.
These entries, and the sockets that they hold, are never freed, since
close() drains the two queues only in TCP_LISTEN and the next listen()
stores NULL in both heads, rskq_accept_head and fastopenq.rskq_rst_head.

The fix used here is to call inet_csk_listen_stop() after the error path
sets TCP_CLOSE, except for an MPTCP subflow, which needs
mptcp_subflow_queue_clean() first: mptcp_listen() has to drain it, which
is done in the next patch, "mptcp: drain the queues of a listen() that
fails".

This issue has been found with the help of an LLM, and reproduced in a
VM, with the reproducer shared with the original version of this patch,
run as an unprivileged user: listen() failing with EADDRINUSE in a loop,
while the connections of an earlier listen() complete. Without this
patch, sockets were leaked, and network namespaces too when each round
was in its own one, without any message from the kernel:

  result: request socks: 10000 made, 3025 left. Sockets: 33205 made, 6050 left
  [...]
  result: namespaces: 1000 made, 735 taken down, 265 left

Fixes: 8336886f786f ("tcp: TCP Fast Open Server - support TFO listeners")
Signed-off-by: Chris Mason <mason@kernel.org>
[ Shorter comments. Commit message: how the issue was found, and its
  symptoms. ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/ipv4/inet_connection_sock.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
index 5807067083c9..3d9cc189c807 100644
--- a/net/ipv4/inet_connection_sock.c
+++ b/net/ipv4/inet_connection_sock.c
@@ -1355,8 +1355,8 @@ int inet_csk_listen_start(struct sock *sk)
 
 	/* There is race window here: we announce ourselves listening,
 	 * but this transition is still not validated by get_port().
-	 * It is OK, because this socket enters to hash table only
-	 * after validation is complete.
+	 * This socket enters to hash table only after validation is
+	 * complete, but reqs of an earlier listen() may queue children.
 	 */
 	inet_sk_state_store(sk, TCP_LISTEN);
 	err = sk->sk_prot->get_port(sk, inet->inet_num);
@@ -1371,6 +1371,10 @@ int inet_csk_listen_start(struct sock *sk)
 	}
 
 	inet_sk_set_state(sk, TCP_CLOSE);
+
+	/* MPTCP subflows are drained by mptcp_listen() */
+	if (!sk_is_mptcp(sk))
+		inet_csk_listen_stop(sk);
 	return err;
 }
 

-- 
2.55.0

