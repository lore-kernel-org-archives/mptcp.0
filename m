Received: from sender11-of-o51.zoho.eu (sender11-of-o51.zoho.eu [31.186.226.237])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9BEC33C0
	for <mptcp@lists.linux.dev>; Wed, 21 Sep 2022 12:56:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1663764964; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=V0HOIILVDDRINsf+m8VghZhehssavHByYS9xFkJC52O+PXfQb4a1aZtjqKw8pGUnXqBq4uqs7gXS81iCnla4YVuXau/UNBv26OmXuvoJB0WvjnxVQvGJUACsp5uONErRUSW1KB1/LL3bq+eeC3o/ziqyqmNjELIRlrL02la+Xxc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1663764964; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
	bh=WRncidMfE40C+dTPtggN1+TrhPs22BWkn0VJlHw1exc=; 
	b=WQZw8CB1X5RLGA3Y9WOmUwGoFtSJp5HfahHxo6q7Wlar2qByhmHY2Bbr4+cA4jJqb5TqnwizNqK+qreYvv+7HjQ6JszBfY4pQe/UNsdai0jmRY6oB4AeLwpOG3Ed4Th29lUfi5WWdnKQOsFay6Gxe0VN/W0mRwM3O1rbQWxkZo0=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=shytyi.net;
	spf=pass  smtp.mailfrom=dmytro@shytyi.net;
	dmarc=pass header.from=<dmytro@shytyi.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1663764964;
	s=hs; d=shytyi.net; i=dmytro@shytyi.net;
	h=From:From:To:To:Cc:Cc:Message-ID:Subject:Subject:Date:Date:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
	bh=WRncidMfE40C+dTPtggN1+TrhPs22BWkn0VJlHw1exc=;
	b=BVhG5UaCJbvLrIq4wJbkw6AG/25Nf7/tuO0h+L5Dzv5reLAIf98Ft4E+VF8noIYA
	8wGOrdHt5r5oczsdig4ehZ0Oyu/fl8PR26YwQwTSUJD2O0zqOhlR4YU5QQBiTWa7i3p
	bMxDGYTIfuEXVEBUf4eRKNB5hu2rDSOVfBlZk0/4=
Received: from doris.localdomain (243.34.22.93.rev.sfr.net [93.22.34.243]) by mx.zoho.eu
	with SMTPS id 16637649631431022.7540864576093; Wed, 21 Sep 2022 14:56:03 +0200 (CEST)
From: Dmytro Shytyi <dmytro@shytyi.net>
To: mptcp@lists.linux.dev
Cc: Dmytro Shytyi <dmytro@shytyi.net>
Message-ID: <20220921125558.19483-4-dmytro@shytyi.net>
Subject: [RFC PATCH mptcp-next v9 3/6] mptcp: reuse tcp_sendmsg_fastopen()
Date: Wed, 21 Sep 2022 14:55:55 +0200
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220921125558.19483-1-dmytro@shytyi.net>
References: <20220921125558.19483-1-dmytro@shytyi.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-ZohoMailClient: External
Content-Type: text/plain; charset=utf8

In the following patches we will reuse modified tcp_sendmsg_fastopen().
We call it from mptcp_sendmsg().

Signed-off-by: Dmytro Shytyi <dmytro@shytyi.net>
---
 include/net/tcp.h    |  3 +++
 net/ipv4/tcp.c       | 24 +++++++++++++++++++-----
 net/mptcp/protocol.c | 29 +++++++++++++++++++++++++++--
 3 files changed, 49 insertions(+), 7 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 735e957f7f4b..a7d49e42470a 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -1754,6 +1754,9 @@ struct sock *tcp_try_fastopen(struct sock *sk, struct=
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
index 9251c99d3cfd..41fa9e840e0e 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -280,6 +280,9 @@
 #include <asm/ioctls.h>
 #include <net/busy_poll.h>
=20
+#include <net/mptcp.h>
+#include "../mptcp/protocol.h"
+
 /* Track pending CMSGs. */
 enum {
 =09TCP_CMSG_INQ =3D 1,
@@ -1162,9 +1165,9 @@ void tcp_free_fastopen_req(struct tcp_sock *tp)
 =09}
 }
=20
-static int tcp_sendmsg_fastopen(struct sock *sk, struct msghdr *msg,
-=09=09=09=09int *copied, size_t size,
-=09=09=09=09struct ubuf_info *uarg)
+int tcp_sendmsg_fastopen(struct sock *sk, struct msghdr *msg,
+=09=09=09 int *copied, size_t size,
+=09=09=09 struct ubuf_info *uarg)
 {
 =09struct tcp_sock *tp =3D tcp_sk(sk);
 =09struct inet_sock *inet =3D inet_sk(sk);
@@ -1197,8 +1200,19 @@ static int tcp_sendmsg_fastopen(struct sock *sk, str=
uct msghdr *msg,
 =09=09}
 =09}
 =09flags =3D (msg->msg_flags & MSG_DONTWAIT) ? O_NONBLOCK : 0;
-=09err =3D __inet_stream_connect(sk->sk_socket, uaddr,
-=09=09=09=09    msg->msg_namelen, flags, 1);
+=09if (!sk_is_mptcp(sk)) {
+=09=09err =3D __inet_stream_connect(sk->sk_socket, uaddr,
+=09=09=09=09=09    msg->msg_namelen, flags, 1);
+=09} else {
+=09=09struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(sk);
+
+=09=09release_sock(sk);
+=09=09release_sock(subflow->conn);
+=09=09err =3D mptcp_stream_connect(sk->sk_socket, uaddr,
+=09=09=09=09=09   msg->msg_namelen, msg->msg_flags);
+=09=09lock_sock(subflow->conn);
+=09=09lock_sock(sk);
+=09}
 =09/* fastopen_req could already be freed in __inet_stream_connect
 =09 * if the connection times out or gets rst
 =09 */
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 470045793181..d5c502d141b4 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1668,14 +1668,39 @@ static int mptcp_sendmsg(struct sock *sk, struct ms=
ghdr *msg, size_t len)
 {
 =09struct mptcp_sock *msk =3D mptcp_sk(sk);
 =09struct page_frag *pfrag;
+=09struct socket *ssock;
 =09size_t copied =3D 0;
 =09int ret =3D 0;
 =09long timeo;
=20
+=09lock_sock(sk);
+
+=09ssock =3D __mptcp_nmpc_socket(msk);
+
+=09if (ssock && inet_sk(ssock->sk)->defer_connect) {
+=09=09release_sock(sk);
+=09=09goto fastopen;
+=09} else {
+=09=09release_sock(sk);
+=09}
 =09/* we don't support FASTOPEN yet */
-=09if (msg->msg_flags & MSG_FASTOPEN)
-=09=09return -EOPNOTSUPP;
+=09if (msg->msg_flags & MSG_FASTOPEN) {
+fastopen:
+=09=09lock_sock(sk);
+
+=09=09ssock =3D __mptcp_nmpc_socket(msk);
+
+=09=09lock_sock(ssock->sk);
=20
+=09=09if (ssock) {
+=09=09=09int copied_syn_fastopen =3D 0;
+
+=09=09=09ret =3D tcp_sendmsg_fastopen(ssock->sk, msg, &copied_syn_fastopen=
, len, NULL);
+=09=09=09copied +=3D copied_syn_fastopen;
+=09=09}
+=09=09release_sock(ssock->sk);
+=09=09release_sock(sk);
+=09}
 =09/* silently ignore everything else */
 =09msg->msg_flags &=3D MSG_MORE | MSG_DONTWAIT | MSG_NOSIGNAL;
=20
--=20
2.25.1


