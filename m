Received: from sender11-of-o51.zoho.eu (sender11-of-o51.zoho.eu [31.186.226.237])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF7E24682
	for <mptcp@lists.linux.dev>; Sun, 25 Sep 2022 23:27:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1664148431; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=UDjw2VvgNsR03Ry+D137KF0Cdz20jlMllvXTG1UQIbdXZr55/uzsqbk/dumMQwsg+z5tDdDaLgraylABFanlILVvCeHWXy9a/dv6W391d7AdvWhMwbIqfXmhoWoN4HVmh06ZyIpo+1q/0C3v5P7QvDT48cZmq0dAHBfrDUPP8nA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1664148431; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
	bh=80Ksk8Qlj9QydeBYveFPQAA9IxDN0PgU6HvxcL4LlC0=; 
	b=i8/pU1sae6tvAeAK/2Mpj0C9kxFbqwp1S/Sr4F1K9x6zawb/JDfstL0vghreMjbvFJru+0oRnwBQ3ECAQasf3C997GjZlIiVPgEffkfgZxiigqoq/aqlWM54pK/lcRHhlMjsAKDJcZO3yUH/DHFE0T87mFh8sY4ZtvpAGtnCGE8=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=shytyi.net;
	spf=pass  smtp.mailfrom=dmytro@shytyi.net;
	dmarc=pass header.from=<dmytro@shytyi.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1664148431;
	s=hs; d=shytyi.net; i=dmytro@shytyi.net;
	h=From:From:To:To:Cc:Cc:Message-ID:Subject:Subject:Date:Date:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
	bh=80Ksk8Qlj9QydeBYveFPQAA9IxDN0PgU6HvxcL4LlC0=;
	b=Y+nis/+5AXEIp++OPuaeoCgAKAmXp/4ZdA9thfWLqi6waS0U5lgOwdbX00iioUW+
	vyQAPOQ8t2+VtUETLIogXTvloeBX/ozIS1pBvEjTrrwHxXWF1vmZaHJFlN6yGJk8RFm
	SUrtDsRqdIEb/AFXToeF9wxnVNGufq54IvU5yxT0=
Received: from doris.localdomain (243.34.22.93.rev.sfr.net [93.22.34.243]) by mx.zoho.eu
	with SMTPS id 1664148369818729.127890630177; Mon, 26 Sep 2022 01:26:09 +0200 (CEST)
From: Dmytro Shytyi <dmytro@shytyi.net>
To: mptcp@lists.linux.dev
Cc: Dmytro Shytyi <dmytro@shytyi.net>,
	Benjamin Hesmans <benjamin.hesmans@tessares.net>
Message-ID: <20220925232601.25252-5-dmytro@shytyi.net>
Subject: [RFC PATCH mptcp-next v11 4/4] mptcp: reuse tcp_sendmsg_fastopen()
Date: Mon, 26 Sep 2022 01:26:01 +0200
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220925232601.25252-1-dmytro@shytyi.net>
References: <20220925232601.25252-1-dmytro@shytyi.net>
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

Signed-of-by: Benjamin Hesmans <benjamin.hesmans@tessares.net>
Signed-off-by: Dmytro Shytyi <dmytro@shytyi.net>
---
 include/net/tcp.h    |  3 +++
 net/ipv4/tcp.c       |  6 +++---
 net/mptcp/protocol.c | 25 +++++++++++++++++++++++--
 3 files changed, 29 insertions(+), 5 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 27e8d378c70a..97cb014ddcab 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -1755,6 +1755,9 @@ struct sock *tcp_try_fastopen(struct sock *sk, struct=
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
index a22c8044de17..daa611671d9a 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -1162,9 +1162,9 @@ void tcp_free_fastopen_req(struct tcp_sock *tp)
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
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index fb08e1f458c0..dd2414fdcf04 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1679,9 +1679,30 @@ static int mptcp_sendmsg(struct sock *sk, struct msg=
hdr *msg, size_t len)
 =09long timeo;
=20
 =09/* we don't support FASTOPEN yet */
-=09if (msg->msg_flags & MSG_FASTOPEN)
-=09=09return -EOPNOTSUPP;
+=09if (msg->msg_flags & MSG_FASTOPEN) {
+=09=09struct socket *ssock;
+=09=09struct sock *ssk;
=20
+=09=09lock_sock(sk);
+
+=09=09ssock =3D __mptcp_nmpc_socket(msk);
+=09=09ssk =3D ssock->sk;
+
+=09=09lock_sock(ssk);
+
+=09=09if (ssock) {
+=09=09=09int copied_syn_fastopen =3D 0;
+
+=09=09=09ret =3D tcp_sendmsg_fastopen(ssk, msg, &copied_syn_fastopen, len,=
 NULL);
+=09=09=09copied +=3D copied_syn_fastopen;
+=09=09=09if (ret) {
+=09=09=09=09release_sock(ssk);
+=09=09=09=09goto do_error;
+=09=09=09}
+=09=09}
+=09=09release_sock(ssock->sk);
+=09=09release_sock(sk);
+=09}
 =09/* silently ignore everything else */
 =09msg->msg_flags &=3D MSG_MORE | MSG_DONTWAIT | MSG_NOSIGNAL;
=20
--=20
2.25.1


