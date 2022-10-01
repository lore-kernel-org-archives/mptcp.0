Received: from sender11-of-o51.zoho.eu (sender11-of-o51.zoho.eu [31.186.226.237])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9FE71FD3
	for <mptcp@lists.linux.dev>; Sat,  1 Oct 2022 03:15:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1664594118; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=CjE7ptcFhocwVFeJCwKpJE9DyOR3P7TdgNZ1ilLecii2958qhxTk/P9AsMo3mziUteUP7zmoH4JzZWqupXaO9ESwfyO+QejrKPpP1h1vKTsTW6uz4SSaNWdOgtS+ScUItdvZVCMwMq8cwVkDOj9339wx3Q7uOm0tZK7HdxgkzcE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1664594118; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
	bh=N3RtdGtzmUBXzQ7LRfA+iQiYh4l80rmrjXzHJl6ZLKk=; 
	b=NSiEHyl9xipehhPu+7qE2Yw56sspfIXRv7T5OH69tr5vCyPUZfy06H0EPSIRXVT5i6I5wkbGH5UW3Kmb2plVCGRAQi8SbwvhGyeG39z6jV4J49IiOyPT1wS0ODHvUcTMfvhOLxIyjTkbCom4h488GvAN9McTFQb2KoUOa7gwdTs=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=shytyi.net;
	spf=pass  smtp.mailfrom=dmytro@shytyi.net;
	dmarc=pass header.from=<dmytro@shytyi.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1664594118;
	s=hs; d=shytyi.net; i=dmytro@shytyi.net;
	h=From:From:To:To:Cc:Cc:Message-ID:Subject:Subject:Date:Date:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
	bh=N3RtdGtzmUBXzQ7LRfA+iQiYh4l80rmrjXzHJl6ZLKk=;
	b=KbpZiPIybHkX9rh2lM+R4M5YSbhNlmlxGSQCB8RQTmvDry7lsOBEVCn+HHR+YbyJ
	Ml4zpu/ghjZVKI4bwxQitEoj0hFZD+HSxEAeZiLwka7opNrBBie2DGPWSbhILPLyshJ
	y2GyLXkpfOiajAO9K7dqSxnXUGyZ8xT4yRv1A/9Q=
Received: from localhost.localdomain (243.34.22.93.rev.sfr.net [93.22.34.243]) by mx.zoho.eu
	with SMTPS id 1664594116082515.4649384482763; Sat, 1 Oct 2022 05:15:16 +0200 (CEST)
From: Dmytro Shytyi <dmytro@shytyi.net>
To: mptcp@lists.linux.dev
Cc: Dmytro Shytyi <dmytro@shytyi.net>
Message-ID: <20221001031502.29152-3-dmytro@shytyi.net>
Subject: [RFC PATCH mptcp-next v13 2/7] mptcp: add __mptcp_stream_connect() helper
Date: Sat,  1 Oct 2022 03:14:57 +0000
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221001031502.29152-1-dmytro@shytyi.net>
References: <20221001031502.29152-1-dmytro@shytyi.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-ZohoMailClient: External
Content-Type: text/plain; charset=utf8

This helper is exctract from mptcp_stream_connect() without locks.
Used in the mptcp_sendmsg() in conjunction with __mptcp_pre_connect().

Signed-off-by: Dmytro Shytyi <dmytro@shytyi.net>
---
 net/mptcp/protocol.c | 53 +++++++++++++++++++++++++++++++-------------
 net/mptcp/protocol.h |  2 ++
 2 files changed, 40 insertions(+), 15 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index b080237d9d7e..f499e3e5a06b 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1687,22 +1687,35 @@ static int mptcp_sendmsg(struct sock *sk, struct ms=
ghdr *msg, size_t len)
 =09=09struct sock *ssk =3D ssock->sk;
 =09=09int copied_syn =3D 0;
=20
-=09=09lock_sock(ssk);
-=09=09if (msg->msg_flags & MSG_FASTOPEN && sk->sk_state =3D=3D TCP_CLOSE)
+=09=09if (msg->msg_flags & MSG_FASTOPEN  && sk->sk_state =3D=3D TCP_CLOSE)=
 {
 =09=09=09__mptcp_pre_connect(msk, ssk, msg, len);
+=09=09=09/* we take nmpc_socket (first subflow) inside of __mptcp_stream_c=
onnect() */
+=09=09=09/* avoid lock_sock(ssk) as it seems leading to deadlock */
+=09=09=09ret =3D __mptcp_stream_connect(sk->sk_socket, msg->msg_name,
+=09=09=09=09=09=09     msg->msg_namelen, msg->msg_flags);
+
+=09=09=09if (ret >=3D 0)
+=09=09=09=09copied +=3D len;
+=09=09=09else
+=09=09=09=09goto do_error;
+=09=09} else {
=20
-=09=09ret =3D tcp_sendmsg_fastopen(ssk, msg, &copied_syn, len, NULL);
-=09=09copied +=3D copied_syn;
-=09=09if (ret =3D=3D -EINPROGRESS && copied_syn > 0) {
-=09=09=09/* reflect the new state on the MPTCP socket */
-=09=09=09inet_sk_state_store(sk, inet_sk_state_load(ssk));
-=09=09=09release_sock(ssk);
-=09=09=09goto out;
-=09=09} else if (ret) {
+=09=09=09lock_sock(ssk);
+
+=09=09=09ret =3D tcp_sendmsg_fastopen(ssk, msg, &copied_syn, len, NULL);
+
+=09=09=09copied +=3D copied_syn;
+=09=09=09if (ret =3D=3D -EINPROGRESS && copied_syn > 0) {
+=09=09=09=09/* reflect the new state on the MPTCP socket */
+=09=09=09=09inet_sk_state_store(sk, inet_sk_state_load(ssk));
+=09=09=09=09release_sock(ssk);
+=09=09=09=09goto out;
+=09=09=09} else if (ret) {
+=09=09=09=09release_sock(ssk);
+=09=09=09=09goto do_error;
+=09=09=09}
 =09=09=09release_sock(ssk);
-=09=09=09goto do_error;
 =09=09}
-=09=09release_sock(ssk);
 =09}
=20
 =09timeo =3D sock_sndtimeo(sk, msg->msg_flags & MSG_DONTWAIT);
@@ -3570,15 +3583,14 @@ static void mptcp_subflow_early_fallback(struct mpt=
cp_sock *msk,
 =09__mptcp_do_fallback(msk);
 }
=20
-static int mptcp_stream_connect(struct socket *sock, struct sockaddr *uadd=
r,
-=09=09=09=09int addr_len, int flags)
+int __mptcp_stream_connect(struct socket *sock, struct sockaddr *uaddr,
+=09=09=09   int addr_len, int flags)
 {
 =09struct mptcp_sock *msk =3D mptcp_sk(sock->sk);
 =09struct mptcp_subflow_context *subflow;
 =09struct socket *ssock;
 =09int err =3D -EINVAL;
=20
-=09lock_sock(sock->sk);
 =09if (uaddr) {
 =09=09if (addr_len < sizeof(uaddr->sa_family))
 =09=09=09goto unlock;
@@ -3633,7 +3645,18 @@ static int mptcp_stream_connect(struct socket *sock,=
 struct sockaddr *uaddr,
 =09=09inet_sk_state_store(sock->sk, inet_sk_state_load(ssock->sk));
=20
 unlock:
+=09return err;
+}
+
+static int mptcp_stream_connect(struct socket *sock, struct sockaddr *uadd=
r,
+=09=09=09=09int addr_len, int flags)
+{
+=09int err =3D -EINVAL;
+
+=09lock_sock(sock->sk);
+=09err =3D __mptcp_stream_connect(sock, uaddr, addr_len, flags);
 =09release_sock(sock->sk);
+
 =09return err;
 }
=20
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 30c03c70fdeb..e596f45763fd 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -837,6 +837,8 @@ void mptcp_event(enum mptcp_event_type type, const stru=
ct mptcp_sock *msk,
 void mptcp_event_addr_announced(const struct sock *ssk, const struct mptcp=
_addr_info *info);
 void mptcp_event_addr_removed(const struct mptcp_sock *msk, u8 id);
 bool mptcp_userspace_pm_active(const struct mptcp_sock *msk);
+int __mptcp_stream_connect(struct socket *sock, struct sockaddr *uaddr,
+=09=09=09   int addr_len, int flags);
=20
 // Fast Open Mechanism functions begin
 void __mptcp_pre_connect(struct mptcp_sock *msk, struct sock *ssk,
--=20
2.34.1


