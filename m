Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794599683;
	b=zFhNEPi85vctSXdNSDY5DzhbXZbBy8s5Moi1UXyEf38SDlE6ikUgHEEgHE0PH/Ilh4mw
	 VYuXDlVf9VwU+scHc7LrWGWJsxQAriWFVtE1Dh7MZa3jKF3nq8YU8WUwlGTh40YMnxemU
	 CN6rCGyhieeqWYd1jfh8hML/uVIvHA5nvKtyJFdf/gnhblE+7Nz9SFMvIuOjRiswffU6l
	 t52lr63S1fN9s5WkFma1SOgye/qx/gZvnljUBJJFVBcOqHRrdXTVidZMuI/ftjHTgI35y
	 tNj4os7shn+dOnRQ0ujes4M0p1ulMM730uu+DSIWhCuNWRzCh32grrB0BwuFKt7zPUQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794599683;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=WeSZTbUfTmiY4P3kv0k2uDVrCyD2mmUymj2WUv9LguY=;
	b=gW3iWvbLl0sZ/QsZA+AH7hrpcO6QOwK0F6XTvL2La9C8G8QYZkxlwsv1Kujhfnscy/J0
	 1LsLnd3v2HlYoQFsqZzz9ibWHegni3J++BvZSbnXk0Lr4VATs6Q1D9IGdCHxR1JFpSAuf
	 G4VBntnHYPypfsU9mIDo/ZQLCrwTTS2W4J7Ho9c6Ea/cdCA7O590zpQdpCaq2NFMAHlKb
	 1Knd9pi4C36RKnKLBs/TaIprWsqO9jMtkLs3Bu1HR9KPOAMTfpytda8EM7MbbB5brllnp
	 X2fnUZsepBrL5uf8zkyJzKo4fNEOks2JCxjk22saPN18Xzm9WRNEA0DvMLDvqNj/6Bg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="HPte//c5";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B852E60A2637
	for <mptcp@lists.linux.dev>; Fri, 13 Nov 2026 19:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HPte//c5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6B3D1F000C4;
	Fri, 13 Nov 2026 19:54:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794599683;
	bh=WeSZTbUfTmiY4P3kv0k2uDVrCyD2mmUymj2WUv9LguY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=HPte//c5dEO6cV5bwQQoDYimk34vACe9lMWCv7i7EqoKmq3VtqpSlSj5I+LPx7NzW
	 SmWrS++MpR8dfRSwtKnOo46Ye8R7YmBFMm+CgpBA/tEX7EKwtS66su9nBX+7iBDfUA
	 pgVpvlaxGscdlJN1cdI5alZLR62uZbCHbnQP37Z8QGfwj6Vgp5KaJ3uMkMF0wyq0Fc
	 jG35Z5WdSbYjy5qKAofp3pxICssK7/b0lqGZ14g8pS297HTyQJBa+d9B/x8txgl3A3
	 iJQ+oEKTGy8RxhOPdtPsnmShkpYeMvkfd1ieD3wmeS+g4BueFPIwtthihIDWbanvsB
	 M47Ng/rDQ9AfQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 13 Nov 2026 20:53:56 +0100
Subject: [PATCH mptcp-net 18/34] mptcp: count a listener once when listen()
 is called again
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
Message-Id: <20261113-mptcp-cmason-fixes-v1-18-9205b77e9a2f@kernel.org>
References: <20261113-mptcp-cmason-fixes-v1-0-9205b77e9a2f@kernel.org>
In-Reply-To: <20261113-mptcp-cmason-fixes-v1-0-9205b77e9a2f@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: Chris Mason <mason@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2648; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=t8BnfJts93zbU93F5dtfmVY8DEQMiji/CE7gCVGyXgE=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLK+Z93jZhaYH7X3G9vyxf5Lkq9+O2q+Qbd1slVDY612t
 /yqW8z/O0pZGMS4GGTFFFmk2yLzZz6v4i3x8rOAmcPKBDKEgYtTACYS8oqRYRpn/DW7mscZdi37
 VvecizPlvn56ktjRhGDJLeHdLUa88YwMHzz1f3z6tzlc+1TMv4sP1sx7aHzkaADndqbt6jfDll7
 g5gUA
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

Fixes: f8c9dfbd875b ("mptcp: add pm listener events")
Fixes: c558246ee73e ("mptcp: add statistics for mptcp socket in use")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/protocol.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 6dc55a3f027b..8f954a752797 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -4381,6 +4381,7 @@ static int mptcp_listen(struct socket *sock, int backlog)
 	struct mptcp_sock *msk = mptcp_sk(sock->sk);
 	struct sock *sk = sock->sk;
 	struct sock *ssk;
+	bool listening;
 	int err;
 
 	pr_debug("msk=%p\n", msk);
@@ -4397,6 +4398,7 @@ static int mptcp_listen(struct socket *sock, int backlog)
 		goto unlock;
 	}
 
+	listening = sk->sk_state == TCP_LISTEN;
 	set_bit(MPTCP_RTX_ENABLED, &msk->flags);
 	mptcp_set_state(sk, TCP_LISTEN);
 	sock_set_flag(sk, SOCK_RCU_FREE);
@@ -4411,7 +4413,8 @@ static int mptcp_listen(struct socket *sock, int backlog)
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

