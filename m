Received: from sender11-of-o51.zoho.eu (sender11-of-o51.zoho.eu [31.186.226.237])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2472E4C94
	for <mptcp@lists.linux.dev>; Tue, 27 Sep 2022 22:54:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1664319258; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=KL+BtACxdnkvlTVkOSPuZXqnP5BYBI6aCCTriAOJugm4bG/N+v9QZYeTyDKn4vVuyJoHgtXeTFywn98XYOUvoG3dgHB/5RBq1IwisC8mF9tAQbuhQo6fA0Us2j53QtMZSRYSaQKD3gwWi3ADWJPkH+NghcxNxjNYxFQodyOpkxo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1664319258; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
	bh=4pwWAZoUy/AWF7AAjotjTrwZ5Kzq6ua8imvf56tRp4I=; 
	b=RJzVHnqSNSLcQwoWSYdxqVFRgage8uojazSdGkoMPXsNsNkR6kQVHbY8toYEy90cIRIwcnv2dNUG/a6tAgCulbmX5aewnAZqt5usDITjFHbEymnULQ6K/yzOcgUvovrcVwOS873yyc+J/tLnPlO10Z/uH99oL0Yo7Po97eyiyq4=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=shytyi.net;
	spf=pass  smtp.mailfrom=dmytro@shytyi.net;
	dmarc=pass header.from=<dmytro@shytyi.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1664319258;
	s=hs; d=shytyi.net; i=dmytro@shytyi.net;
	h=From:From:To:To:Cc:Cc:Message-ID:Subject:Subject:Date:Date:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
	bh=4pwWAZoUy/AWF7AAjotjTrwZ5Kzq6ua8imvf56tRp4I=;
	b=JfjtfkKk3DZBlGaSKLzTBWHcfHea2RNEbuZzUtpZPw66PmP1Bal6J9AL2r7IutjP
	UPNfAYbBHo5b8RKzg6vgl6CiEZ9OuialF8lPPNVnd1zKFG7GhiL9GYaYHpmVAyFg/WE
	IJAjZA1XeuZePCyQPdgXL4s+aNkszeGOPNirvk48=
Received: from localhost.localdomain (243.34.22.93.rev.sfr.net [93.22.34.243]) by mx.zoho.eu
	with SMTPS id 1664319256917110.94208261457095; Wed, 28 Sep 2022 00:54:16 +0200 (CEST)
From: Dmytro Shytyi <dmytro@shytyi.net>
To: mptcp@lists.linux.dev
Cc: Dmytro Shytyi <dmytro@shytyi.net>,
	Benjamin Hesmans <benjamin.hesmans@tessares.net>
Message-ID: <20220927225341.14165-2-dmytro@shytyi.net>
Subject: [RFC PATCH mptcp-next v12 1/7] mptcp: introduce MSG_FASTOPEN flag.
Date: Tue, 27 Sep 2022 22:53:35 +0000
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220927225341.14165-1-dmytro@shytyi.net>
References: <20220927225341.14165-1-dmytro@shytyi.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-ZohoMailClient: External
Content-Type: text/plain; charset=utf8

In the following patches we will analyse the MSG_FASTOPEN flag
in the mptcp_sendmsg() and invoke the MPTFO.

Signed-of-by: Benjamin Hesmans <benjamin.hesmans@tessares.net>
Signed-off-by: Dmytro Shytyi <dmytro@shytyi.net>
---
 include/net/mptcp.h  |  9 +++++++++
 include/net/tcp.h    |  3 +++
 net/ipv4/tcp.c       | 20 ++++++++++++++++----
 net/mptcp/protocol.c | 19 +++++++++++--------
 4 files changed, 39 insertions(+), 12 deletions(-)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index c25939b2af68..ccf2b42837a1 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -150,6 +150,8 @@ void mptcp_write_options(struct tcphdr *th, __be32 *ptr=
, struct tcp_sock *tp,
 =09=09=09 struct mptcp_out_options *opts);
=20
 void mptcp_diag_fill_info(struct mptcp_sock *msk, struct mptcp_info *info)=
;
+int mptcp_stream_connect(struct socket *sock, struct sockaddr *uaddr, int =
addr_len, int flags);
+struct sock *mptcp_subflow_conn_sock(struct sock *sk);
=20
 /* move the skb extension owership, with the assumption that 'to' is
  * newly allocated
@@ -286,6 +288,13 @@ static inline bool mptcp_skb_can_collapse(const struct=
 sk_buff *to,
=20
 static inline void mptcp_space(const struct sock *ssk, int *s, int *fs) { =
}
 static inline void mptcp_seq_show(struct seq_file *seq) { }
+static inline int mptcp_stream_connect(struct socket *sock,
+=09=09=09=09       struct sockaddr *uaddr,
+=09=09=09=09       int addr_len,
+=09=09=09=09       int flags)
+{
+
+}
=20
 static inline int mptcp_subflow_init_cookie_req(struct request_sock *req,
 =09=09=09=09=09=09const struct sock *sk_listener,
diff --git a/include/net/tcp.h b/include/net/tcp.h
index 4f71cc15ff8e..e53d26d74dec 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -1757,6 +1757,9 @@ struct sock *tcp_try_fastopen(struct sock *sk, struct=
 sk_buff *skb,
 =09=09=09      struct request_sock *req,
 =09=09=09      struct tcp_fastopen_cookie *foc,
 =09=09=09      const struct dst_entry *dst);
+int tcp_sendmsg_fastopen(struct sock *sk, struct msghdr *msg,
+=09=09=09 int *copied, size_t size,
+=09=09=09 struct ubuf_info *uarg);
 void tcp_fastopen_init_key_once(struct net *net);
 bool tcp_fastopen_cookie_check(struct sock *sk, u16 *mss,
 =09=09=09     struct tcp_fastopen_cookie *cookie);
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 5237a3f08c94..daa611671d9a 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -1162,8 +1162,9 @@ void tcp_free_fastopen_req(struct tcp_sock *tp)
 =09}
 }
=20
-int tcp_sendmsg_fastopen(struct sock *sk, struct msghdr *msg, int *copied,
-=09=09=09 size_t size, struct ubuf_info *uarg)
+int tcp_sendmsg_fastopen(struct sock *sk, struct msghdr *msg,
+=09=09=09 int *copied, size_t size,
+=09=09=09 struct ubuf_info *uarg)
 {
 =09struct tcp_sock *tp =3D tcp_sk(sk);
 =09struct inet_sock *inet =3D inet_sk(sk);
@@ -1196,8 +1197,19 @@ int tcp_sendmsg_fastopen(struct sock *sk, struct msg=
hdr *msg, int *copied,
 =09=09}
 =09}
 =09flags =3D (msg->msg_flags & MSG_DONTWAIT) ? O_NONBLOCK : 0;
-=09err =3D __inet_stream_connect(sk->sk_socket, uaddr,
-=09=09=09=09    msg->msg_namelen, flags, 1);
+=09if (!sk_is_mptcp(sk)) {
+=09=09err =3D __inet_stream_connect(sk->sk_socket, uaddr,
+=09=09=09=09=09    msg->msg_namelen, flags, 1);
+=09} else {
+=09=09struct sock *parent =3D mptcp_subflow_conn_sock(sk);
+
+=09=09release_sock(sk);
+=09=09release_sock(parent);
+=09=09err =3D mptcp_stream_connect(sk->sk_socket, uaddr,
+=09=09=09=09=09   msg->msg_namelen, msg->msg_flags);
+=09=09lock_sock(parent);
+=09=09lock_sock(sk);
+=09}
 =09/* fastopen_req could already be freed in __inet_stream_connect
 =09 * if the connection times out or gets rst
 =09 */
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 8feb684408f7..0db50712bad7 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -58,6 +58,12 @@ static void __mptcp_check_send_data_fin(struct sock *sk)=
;
 DEFINE_PER_CPU(struct mptcp_delegated_action, mptcp_delegated_actions);
 static struct net_device mptcp_napi_dev;
=20
+struct sock *
+mptcp_subflow_conn_sock(struct sock *sk)
+{
+=09return ((mptcp_subflow_ctx(sk))->conn);
+}
+
 /* If msk has an initial subflow socket, and the MP_CAPABLE handshake has =
not
  * completed yet or has failed, return the subflow socket.
  * Otherwise return NULL.
@@ -1673,17 +1679,14 @@ static int mptcp_sendmsg(struct sock *sk, struct ms=
ghdr *msg, size_t len)
 =09int ret =3D 0;
 =09long timeo;
=20
-=09/* we don't support FASTOPEN yet */
-=09if (msg->msg_flags & MSG_FASTOPEN)
-=09=09return -EOPNOTSUPP;
-
 =09/* silently ignore everything else */
-=09msg->msg_flags &=3D MSG_MORE | MSG_DONTWAIT | MSG_NOSIGNAL;
+=09msg->msg_flags &=3D MSG_MORE | MSG_DONTWAIT | MSG_NOSIGNAL | MSG_FASTOP=
EN;
=20
 =09lock_sock(sk);
=20
 =09ssock =3D __mptcp_nmpc_socket(msk);
-=09if (unlikely(ssock && inet_sk(ssock->sk)->defer_connect)) {
+=09if (unlikely(ssock && (inet_sk(ssock->sk)->defer_connect ||
+=09=09=09       msg->msg_flags & MSG_FASTOPEN))) {
 =09=09struct sock *ssk =3D ssock->sk;
 =09=09int copied_syn =3D 0;
=20
@@ -3568,8 +3571,8 @@ static void mptcp_subflow_early_fallback(struct mptcp=
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
--=20
2.34.1


