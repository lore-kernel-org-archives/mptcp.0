Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795254140;
	b=SQPkqIMz2p8NzDIXWtppJMrQ+MnN14k3OrWTEN9YQAtUfD4dgqkgnmmWY2Nner0+ZrZw
	 HcGPf5TYCUukOy59o8b+kv9IqGR9WpH4sK2RMNuszuw0svrE+kMYp8sQno7m8gn+P1o9r
	 +GkLvL0lMjz1FD7SdY5X5QOeZC8zw4LhKB+0XJ/1BTw64kQ8CR/wRR+qSLGW4ovXWKzS2
	 qkrcRkMEbf0Cg+GgwWJDYJIBxzty5C2db/W6Xkg2RNA/dVRq04cbtp2aXHgQGLYgbXVU9
	 QXQeQ0xYbJoFxwOJ+/xTcCa6cU6+qjUoo24RGFlWsiXaa34nLIh5YBwoMGvHK0B6JVQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795254140;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=zdkOP5u3F8iJrSXZpJujP1iIRDBzaID9prVsX1HDW8s=;
	b=HfGeteU2UR2ABBHURQo8HN+2HUUJyyzDHUpgRifpBK0ppYAw+UMuLXBglg97JaXTR/Qu
	 GPLM7Xr9lu0NPYOtqD9dP8MZDe60ngogmy5hK1QMeuQSdVxuWdEL1lL37lY7dQMCFvlZ3
	 4aHHZRvcFrHbY5KmkqnHzNh0KkbyL833S947rzfFGAXhWLUqFZaavQRDnehvxKeVbTNO1
	 nPqo2VWz6LNYvJIA1UesJ67l1k5YL+izQVt6ADLCydvCX1+tla0CEdK0DsyfttCBfR034
	 Y0p/0J1jJgZP/++XOwrsjCgFgjyi3XYdaU0Op3rbXdHZ+lQQQ0+/6vJ+BsnYkuWRx6g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HhStdCg8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86B12606A320
	for <mptcp@lists.linux.dev>; Sat, 21 Nov 2026 09:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HhStdCg8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DA0A1F000CF;
	Sat, 21 Nov 2026 09:42:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795254140;
	bh=zdkOP5u3F8iJrSXZpJujP1iIRDBzaID9prVsX1HDW8s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=HhStdCg8qy4uy1vCv50fNRmycgWKUXBVf4W07IMQdinsT2cHUo4gq8cKbI/NqsqMd
	 O3DBw19vPTjmMxq7jmcg6jOtB9hR0Jlcczq89IS+QI2wd0NrT7hcyKUINE/FlyItjY
	 3dxp0PMI0rkm4osOH4Y19WtpE0c8gQxh+JkLpxzY2YDWnVGUvLTJlfYwjSr7y6JIMa
	 gGA9IlwXanGU1BM+/ejhYBr9I5e43L5fbuT2/j3wB1o7/3tozsHivPjASoQHGflve5
	 SbGlndkLf+ImtO+Ac5XVKkx/HP7IP5Xq9SEb5o3pMmRuwrvgI74lz9Sz7LKNmNBA2q
	 BbhqhtvjCsGtA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Sat, 21 Nov 2026 10:40:59 +0100
Subject: [PATCH mptcp-net v2 01/62] tcp: drain the queues of a listen()
 that fails
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
Message-Id: <20261121-mptcp-cmason-fixes-v2-1-00327fd1de1f@kernel.org>
References: <20261121-mptcp-cmason-fixes-v2-0-00327fd1de1f@kernel.org>
In-Reply-To: <20261121-mptcp-cmason-fixes-v2-0-00327fd1de1f@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Chris Mason <mason@kernel.org>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3641; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=LlcC3gecNJA9oVVjOA445C6SC7Y9d9nYfwqNr2w5AiE=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLIZ0z3MrnBpsnvzv9KavHRpvemS9uOHWQKlw/TWmhnof
 N4eK+zcUcrCIMbFICumyCLdFpk/83kVb4mXnwXMHFYmkCEMXJwCMBH1uQz/VLw+pXkv+Vgmt2mL
 kGNdMn945BmGZ80n3Tvv7VD1fxu3hOF/5vaLf2J+7f4ZOGmldoD/Hwa3zdM9Q25eMH0l3X10d+w
 ZDgA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Chris Mason <mason@kernel.org>

If listen() fails on a TCP socket that has listened before, the sockets
of connections from the earlier listen() can leak, together with their
network namespace.

inet_csk_listen_start() sets TCP_LISTEN before it calls get_port() and
hash(), and its error path sets TCP_CLOSE again, then purges the Fast
Open RST queue since commit 342e62fd34c2 ("tcp: purge Fast Open RST
queue when listen() fails"), but not the accept queue. Pending request
socks outlive an earlier listen() and still point to the socket, so in
TCP_LISTEN, inet_csk_reqsk_queue_add() adds them to the accept queue,
with their new child. These entries, and the sockets that they hold,
are never freed, since close() drains this queue only in TCP_LISTEN and
the next listen() stores NULL in rskq_accept_head.

The fix used here is to call inet_csk_listen_stop() after the error path
sets TCP_CLOSE, which also purges the RST queue, except for an MPTCP
subflow, which needs mptcp_subflow_queue_clean() first: only its RST
queue is purged here, and mptcp_listen() has to drain its accept queue,
which is done in the next patch, "mptcp: drain the queues of a listen()
that fails".

This issue has been found with the help of an LLM, and reproduced in a
VM, with the reproducer shared with the original version of this patch,
run as an unprivileged user: listen() failing with EADDRINUSE in a loop,
while the connections of an earlier listen() complete. Without this
patch, sockets were leaked, and network namespaces too when each round
was in its own one, without any message from the kernel:

  result: request socks: 10000 made, 2535 left. Sockets: 33373 made, 5070 left
  [...]
  result: namespaces: 1000 made, 694 taken down, 306 left

Fixes: 079096f103fa ("tcp/dccp: install syn_recv requests into ehash table")
Signed-off-by: Chris Mason <mason@kernel.org>
[ Shorter comments. Commit message: how the issue was found, and its
  symptoms. On top of commit 342e62fd34c2, with a Fixes tag for the
  accept queue. ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
v2: on top of commit 342e62fd34c2, which purges the RST queue, still
done for MPTCP subflows: Fixes tag for the accept queue.
---
 net/ipv4/inet_connection_sock.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
index dec0ce6ff0f3..8b0e0746dfda 100644
--- a/net/ipv4/inet_connection_sock.c
+++ b/net/ipv4/inet_connection_sock.c
@@ -1371,8 +1371,8 @@ int inet_csk_listen_start(struct sock *sk)
 
 	/* There is race window here: we announce ourselves listening,
 	 * but this transition is still not validated by get_port().
-	 * It is OK, because this socket enters to hash table only
-	 * after validation is complete.
+	 * This socket enters to hash table only after validation is
+	 * complete, but reqs of an earlier listen() may queue children.
 	 */
 	inet_sk_state_store(sk, TCP_LISTEN);
 	err = sk->sk_prot->get_port(sk, inet->inet_num);
@@ -1390,9 +1390,13 @@ int inet_csk_listen_start(struct sock *sk)
 
 	/* A Fast Open child accepted before a previous shutdown() of this
 	 * listener might have queued its request in rskq_rst_head while
-	 * we were transiently in TCP_LISTEN state.
+	 * we were transiently in TCP_LISTEN state. The accept queue of an
+	 * MPTCP subflow is drained by mptcp_listen().
 	 */
-	reqsk_fastopen_purge_rst(&icsk->icsk_accept_queue);
+	if (sk_is_mptcp(sk))
+		reqsk_fastopen_purge_rst(&icsk->icsk_accept_queue);
+	else
+		inet_csk_listen_stop(sk);
 	return err;
 }
 

-- 
2.55.0

