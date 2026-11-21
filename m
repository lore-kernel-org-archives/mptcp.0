Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795254171;
	b=g6y+/smIOZ3qwG9XncnMKpEAj7IhfKWiK3zhFiobsn7jDGrUX+CkY8ucEfRFwqmNE6e2
	 bOgWnFjY+NhOn1/og6vaC08VLm0+Nl5AhU2awKaa6L4CO0/eHI7nGo9Wb4KtYk5UqYbiX
	 qZF23L2tVVtmWqd/kt9CczndxZchRGWPvo1Y6W8263AF3ei78rw1hQPTIyfk+0COVePe3
	 srQKHtW/Agmp+ZNkEdnqGZfrdsbZeidw949vaiAT9z44JpdOaA1sddjH8TjLNLS87D8om
	 B/b1zBkdhXGtcDdX+r/U9m9fQ5N2Xu9n1T8ImtwEHDHcDq3hZc4EBRyXqRC+HLUxBnQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795254171;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=DXNq2NBTnuP6KEZgPzVF9BPAHUhB0yg2Yu54Jzvl4Dc=;
	b=kfHEEkgtMNCHh0eSTgGuRhFin62BkNIrVIwNArE0Ms18bhckrwwGwnsApYcQpx9x+C/s
	 cUqFAcZkqlh/Mfb6kN3Hf7R6dgaqBDY8pxRwKd+8Olr9OXhMQNkA/qRBSEY5Jp6oRt02B
	 uF4B9+kAQljkIs6RgJ4f8u/aDaIOU69cVdbCHNCmF+JoQbjJZoJDTJYKMORInnhmO2S+n
	 iD3c/jXTVQ9wmdrtgn5ZObq7SULxXXIF47tyLSRoeDzCzPVfJfyUdkeEwWQJWxay8NXkw
	 WSQkphd3FvH2gTfr9YkOOhhtUh8KClLCRqNPwa9vpeZqCphjaPeGmIeYD6dw+QDeJCg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MWBDZYcS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98D8C606A320
	for <mptcp@lists.linux.dev>; Sat, 21 Nov 2026 09:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MWBDZYcS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1117F1F000C0;
	Sat, 21 Nov 2026 09:42:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795254171;
	bh=DXNq2NBTnuP6KEZgPzVF9BPAHUhB0yg2Yu54Jzvl4Dc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=MWBDZYcSI2tSDf9zNd0sE6ZQxPi9vxUB4Dq9gg+zAob1VQB6iQudlT0H3xuSmQI+l
	 tL5k2LsI9Xkjx1GSsEXqsqP9EAAGC+ESJ6jx20BK1PzEMTcwKc4Rj+NrRDO1GuIcls
	 jqYofdkbOXyCuj24QB7s+yDP9qAVEi7j3E8gL+RhhPTdCsKhcpOvd9dTRX26ns7e46
	 IA8IAZZLfne/IIiCFghmiZR9Jkm4ibAm685unrNzpqNbR1JdsjzvIaqyP6QP0gFN4P
	 rwdgQJFD0NLRrFE6k3S9r9Z8eoio9/cn+w31Gb1RSvCQvW7Q8RVMxSWstCakeW/NSD
	 J6GQ5vjYVtdHA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Sat, 21 Nov 2026 10:41:35 +0100
Subject: [PATCH mptcp-net v2 37/62] mptcp: count a listener once when
 listen() is called again
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
Message-Id: <20261121-mptcp-cmason-fixes-v2-37-00327fd1de1f@kernel.org>
References: <20261121-mptcp-cmason-fixes-v2-0-00327fd1de1f@kernel.org>
In-Reply-To: <20261121-mptcp-cmason-fixes-v2-0-00327fd1de1f@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2837; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=aAO3v21i2NZQBA5RaoNlk3u9ADhknoHelAikiRDnBDk=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLIZ01Pm8bmyRz+ov/Hz6e6JDveW+n1K/yzWWrJ3wsKkL
 VrmdeISHaUsDGJcDLJiiizSbZH5M59X8ZZ4+VnAzGFlAhnCwMUpABN5V8HwP9h3I68A170+ewmz
 7+whT4s0XXNTFt+7t7BPRT6W18z7AiPDSaPmi5vjglcF6h+Ysf/k9r1fC4rU6itFRTzSru+ZtVy
 KGwA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

listen() on a listening MPTCP socket only updates its backlog, as with
TCP. But mptcp_listen() then counts this socket once more in the
"sockets" column of the MPTCP or MPTCPv6 row of /proc/net/protocols, and
sends a new MPTCP_EVENT_LISTENER_CREATED event, while only one decrement
and one MPTCP_EVENT_LISTENER_CLOSED event are done when it is closed.
Each extra listen() call then leaves the counter one above the number of
MPTCP sockets in use, for the lifetime of the netns, and a userspace
path manager can see two listeners created for one closed.

With TCP, the socket is only counted when it is hashed, which is not
done again for a listening socket.

The fix used here is to only count the socket, and send the event, if it
was not already listening.

This issue has been found by an AI code review agent, while reviewing
the code of the commit "mptcp: pm: kernel: count endpoint listeners as
sockets in use", and confirmed with a new Packetdrill test, and with a
script calling listen() twice. Without this patch:

  listen_listen.pkt:12: error executing `test $(awk '/^MPTCP/ { n += $3 } END { print n }' /proc/net/protocols) -eq 1` command: non-zero status 1

  inuse: relisten: listening: 2 (expected 1)
  inuse: relisten: closed: 1 (expected 0)

The extra event comes from the commit below, and the extra count from
commit c558246ee73e ("mptcp: add statistics for mptcp socket in use"),
which is in all the stable versions having the commit below.

Fixes: f8c9dfbd875b ("mptcp: add pm listener events")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
v2: commit message: explain the two Fixes tags
---
 net/mptcp/protocol.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 9202b14c030e..d16269d27b1d 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -4540,6 +4540,7 @@ static int mptcp_listen(struct socket *sock, int backlog)
 	struct mptcp_sock *msk = mptcp_sk(sock->sk);
 	struct sock *sk = sock->sk;
 	struct sock *ssk;
+	bool listening;
 	int err;
 
 	pr_debug("msk=%p\n", msk);
@@ -4556,6 +4557,7 @@ static int mptcp_listen(struct socket *sock, int backlog)
 		goto unlock;
 	}
 
+	listening = sk->sk_state == TCP_LISTEN;
 	set_bit(MPTCP_RTX_ENABLED, &msk->flags);
 	mptcp_set_state(sk, TCP_LISTEN);
 	sock_set_flag(sk, SOCK_RCU_FREE);
@@ -4570,7 +4572,8 @@ static int mptcp_listen(struct socket *sock, int backlog)
 	release_sock(ssk);
 	mptcp_set_state(sk, inet_sk_state_load(ssk));
 
-	if (!err) {
+	/* only the backlog changes when listening already */
+	if (!err && !listening) {
 		sock_prot_inuse_add(sock_net(sk), sk->sk_prot, 1);
 		mptcp_copy_inaddrs(sk, ssk);
 		mptcp_event_pm_listener(ssk, MPTCP_EVENT_LISTENER_CREATED);

-- 
2.55.0

