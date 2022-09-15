Received: from sender11-of-o51.zoho.eu (sender11-of-o51.zoho.eu [31.186.226.237])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C339F670B
	for <mptcp@lists.linux.dev>; Thu, 15 Sep 2022 23:56:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1663286186; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=TMBLy+IgH3EcB4iOIjCVjxPHnkWgN+SiXo3CGmDSIdn21L9WbguaDZd1rZiDPL76hgwpgeRPXBsTE9sAmk5NJRpc/2jYArQrZxQKRIifNLfJnb1KyLvQJVhkvYG5ncL7z5rAouYeKAwgB9+LD/uO/K7SoEZ3VAxvNFvbJScLfSE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1663286186; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
	bh=2N3o6l/q6D7RtZEz3bpDPeMZps8KZHlbykcetGxgfdk=; 
	b=Vd+0x8+LCW5xARd8VpC/I5K48zFsgBtwTLps/xE9kcwTPTO+TSKgmCVfgn+ncLgfRSmScByZLvzrrC/m1LMPD7Jdv6M3wUnehyeUhTNmZ0s846fr+BOPgRdXlLOWyiY8lWrpWccG9rMMb5RGorP1XIyYQ34M9namRp9B7e91jFw=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=shytyi.net;
	spf=pass  smtp.mailfrom=dmytro@shytyi.net;
	dmarc=pass header.from=<dmytro@shytyi.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1663286186;
	s=hs; d=shytyi.net; i=dmytro@shytyi.net;
	h=From:From:To:To:Cc:Cc:Message-ID:Subject:Subject:Date:Date:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
	bh=2N3o6l/q6D7RtZEz3bpDPeMZps8KZHlbykcetGxgfdk=;
	b=BPZHPiFaifAVr+ny5TTlmIAwSELjN3AJQjSa/P1QUwwtOCgs+QJN1F5/+3Nn2cml
	6NFd0ALdN4uoRyH4X/RowKrmbUe5cPD+Bo4XhIlMMSPviJYu9fELosya+wHkuUBkwWW
	B0tYvsND/CQ0Sd1VcPxLGvtlkzQjWmWGCmnUB4AA=
Received: from doris.localdomain (243.34.22.93.rev.sfr.net [93.22.34.243]) by mx.zoho.eu
	with SMTPS id 1663286184801578.0101048230161; Fri, 16 Sep 2022 01:56:24 +0200 (CEST)
From: Dmytro Shytyi <dmytro@shytyi.net>
To: mptcp@lists.linux.dev
Cc: Dmytro Shytyi <dmytro@shytyi.net>
Message-ID: <20220915235604.26018-5-dmytro@shytyi.net>
Subject: [RFC PATCH mptcp-next v6 4/9] Initiator: add locks() to mptcp_sendmsg_fastopen.
Date: Fri, 16 Sep 2022 01:55:59 +0200
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220915235604.26018-1-dmytro@shytyi.net>
References: <20220915235604.26018-1-dmytro@shytyi.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-ZohoMailClient: External
Content-Type: text/plain; charset=utf8

Suggestion of @mmartineau : 'add locks' is implemented in this patch=20

Signed-off-by: Dmytro Shytyi <dmytro@shytyi.net>
---
 net/mptcp/fastopen.c | 42 ++++++++++++++++++++++++++++++++++++++++--
 net/mptcp/protocol.c |  4 ++--
 net/mptcp/protocol.h |  5 +++++
 net/mptcp/sockopt.c  |  3 +++
 4 files changed, 50 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/fastopen.c b/net/mptcp/fastopen.c
index 9974508e0f4c..436e773d798a 100644
--- a/net/mptcp/fastopen.c
+++ b/net/mptcp/fastopen.c
@@ -16,6 +16,7 @@ int mptcp_sendmsg_fastopen(struct sock *sk, struct msghdr=
 *msg,
 =09struct socket *ssk;
 =09int ret;
=20
+=09lock_sock((struct sock *)msk);
 =09ssk =3D __mptcp_nmpc_socket(msk);
 =09if (unlikely(!ssk))
 =09=09goto out_EFAULT;
@@ -30,26 +31,63 @@ int mptcp_sendmsg_fastopen(struct sock *sk, struct msgh=
dr *msg,
 =09=09goto out_EFAULT;
 =09uaddr =3D msg->msg_name;
=20
+=09lock_sock(ssk->sk);
+
 =09tp =3D tcp_sk(ssk->sk);
 =09if (unlikely(!tp))
-=09=09goto out_EFAULT;
+=09=09goto out_lock_EFAULT;
 =09if (!tp->fastopen_req)
 =09=09tp->fastopen_req =3D kzalloc(sizeof(*tp->fastopen_req),
 =09=09=09=09=09   ssk->sk->sk_allocation);
=20
 =09if (unlikely(!tp->fastopen_req))
-=09=09goto out_EFAULT;
+=09=09goto out_lock_EFAULT;
 =09tp->fastopen_req->data =3D msg;
 =09tp->fastopen_req->size =3D len;
 =09tp->fastopen_req->uarg =3D uarg;
=20
+=09release_sock(ssk->sk);
+=09release_sock((struct sock *)msk);
+
 =09/* requests a cookie */
 =09ret =3D mptcp_stream_connect(sk->sk_socket, uaddr,
 =09=09=09=09   msg->msg_namelen, msg->msg_flags);
 =09if (!ret)
 =09=09*copied =3D len;
 =09return ret;
+
+out_lock_EFAULT:
+=09release_sock(ssk->sk);
 out_EFAULT:
+=09release_sock((struct sock *)msk);
 =09ret =3D -EFAULT;
 =09return ret;
 }
+
+int mptcp_setsockopt_sol_tcp_fastopen(struct mptcp_sock *msk, sockptr_t op=
tval,
+=09=09=09=09      unsigned int optlen)
+{
+=09struct sock *sk =3D (struct sock *)msk;
+=09struct net *net =3D sock_net(sk);
+=09int val;
+=09int ret;
+
+=09ret =3D 0;
+
+=09if (copy_from_sockptr(&val, optval, sizeof(val)))
+=09=09return -EFAULT;
+
+=09lock_sock(sk);
+
+=09if (val >=3D 0 && ((1 << sk->sk_state) & (TCPF_CLOSE |
+=09    TCPF_LISTEN))) {
+=09=09tcp_fastopen_init_key_once(net);
+=09=09fastopen_queue_tune(sk, val);
+=09} else {
+=09=09ret =3D -EINVAL;
+=09}
+
+=09release_sock(sk);
+
+=09return ret;
+}
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index ba50aa88d5d8..357767a84c57 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3474,8 +3474,8 @@ static void mptcp_subflow_early_fallback(struct mptcp=
_sock *msk,
 =09__mptcp_do_fallback(msk);
 }
=20
-static int mptcp_stream_connect(struct socket *sock, struct sockaddr *uadd=
r,
-=09=09=09=09int addr_len, int flags)
+int mptcp_stream_connect(struct socket *sock, struct sockaddr *uaddr,
+=09=09=09 int addr_len, int flags)
 {
 =09struct mptcp_sock *msk =3D mptcp_sk(sock->sk);
 =09struct mptcp_subflow_context *subflow;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 5cd14eacd1d6..2a4b6dfb6f8f 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -838,11 +838,16 @@ bool mptcp_userspace_pm_active(const struct mptcp_soc=
k *msk);
 int mptcp_stream_connect(struct socket *sock, struct sockaddr *uaddr, int =
addr_len, int flags);
 void mptcp_rmem_uncharge(struct sock *sk, int size);
 void mptcp_rfree(struct sk_buff *skb);
+int mptcp_stream_connect(struct socket *sock, struct sockaddr *uaddr, int =
addr_len, int flags);
+void mptcp_rmem_uncharge(struct sock *sk, int size);
+void mptcp_rfree(struct sk_buff *skb);
=20
 // Fast Open Mechanism functions begin
 int mptcp_sendmsg_fastopen(struct sock *sk, struct msghdr *msg,
 =09=09=09   size_t len, struct mptcp_sock *msk,
 =09=09=09   size_t *copied);
+int mptcp_setsockopt_sol_tcp_fastopen(struct mptcp_sock *msk, sockptr_t op=
tval,
+=09=09=09=09      unsigned int optlen);
 // Fast Open Mechanism functions end
=20
 static inline bool mptcp_pm_should_add_signal(struct mptcp_sock *msk)
diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index 423d3826ca1e..f62f0d63b8e6 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -559,6 +559,7 @@ static bool mptcp_supported_sockopt(int level, int optn=
ame)
 =09=09case TCP_NOTSENT_LOWAT:
 =09=09case TCP_TX_DELAY:
 =09=09case TCP_INQ:
+=09=09case TCP_FASTOPEN:
 =09=09=09return true;
 =09=09}
=20
@@ -796,6 +797,8 @@ static int mptcp_setsockopt_sol_tcp(struct mptcp_sock *=
msk, int optname,
 =09=09return mptcp_setsockopt_sol_tcp_nodelay(msk, optval, optlen);
 =09case TCP_DEFER_ACCEPT:
 =09=09return mptcp_setsockopt_sol_tcp_defer(msk, optval, optlen);
+=09case TCP_FASTOPEN:
+=09=09return mptcp_setsockopt_sol_tcp_fastopen(msk, optval, optlen);
 =09}
=20
 =09return -EOPNOTSUPP;
--=20
2.25.1


