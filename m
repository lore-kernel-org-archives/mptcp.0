Received: from sender11-of-o51.zoho.eu (sender11-of-o51.zoho.eu [31.186.226.237])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F621A55
	for <mptcp@lists.linux.dev>; Tue, 20 Sep 2022 12:53:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1663678408; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=hyWrzCyw5gm9LVw77JHGg5z5GEym3YPU3HsSzesb1VTWoDPtOE5uKu84RYwii7527t0jHnQBsM009ovNwd31MVlLA8d6mg9++/SI+29Gj0RUZYJ8Hffiz9AY8oHT85lE1vTtPlAujEBn0wlQnyef4+GfXMFLrixBM56HMqGqdHM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1663678408; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
	bh=bITp/RdzclZx2p+1gR0KyOs5jBdwvIgNgDuUAxniFdk=; 
	b=MV02K96goNa2MHJvq9rvJKWORcXtQZd3BZ+e3XY/y5DHkevnxomyrfjvVEDnHuAb1BEXZEogiN1H/OojPIooX4vPnwaOLvMcjE6iS/bXq7hhteLYfbYN9kSgve6y4uXC44bEu5R79bAhkh7KfBOq5x1Zp+ASmm4d9GovqBlmtMY=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=shytyi.net;
	spf=pass  smtp.mailfrom=dmytro@shytyi.net;
	dmarc=pass header.from=<dmytro@shytyi.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1663678408;
	s=hs; d=shytyi.net; i=dmytro@shytyi.net;
	h=From:From:To:To:Cc:Cc:Message-ID:Subject:Subject:Date:Date:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
	bh=bITp/RdzclZx2p+1gR0KyOs5jBdwvIgNgDuUAxniFdk=;
	b=UJz+CSbOnpo4cULnAlSJ/u7P4yfghieq7jM8iiFu6DArXsE0/S2tz9RH4lC5gBZA
	7c+5MQjIoLutX5ocHTYPmoMRVqiCc0CU2/FVLbeg2WMqyoU0M5Ns1ExcByga+KOdQxF
	neZFt+6igibsn17cOgF3+Ccs9G8LEXJB7onIsJXk=
Received: from doris.localdomain (243.34.22.93.rev.sfr.net [93.22.34.243]) by mx.zoho.eu
	with SMTPS id 1663678369073953.9286586842846; Tue, 20 Sep 2022 14:52:49 +0200 (CEST)
From: Dmytro Shytyi <dmytro@shytyi.net>
To: mptcp@lists.linux.dev
Cc: Dmytro Shytyi <dmytro@shytyi.net>
Message-ID: <20220920125243.2880-4-dmytro@shytyi.net>
Subject: [RFC PATCH mptcp-next v8 3/7] reuse tcp_sendmsg_fastopen()
Date: Tue, 20 Sep 2022 14:52:39 +0200
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220920125243.2880-1-dmytro@shytyi.net>
References: <20220920125243.2880-1-dmytro@shytyi.net>
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
 net/ipv4/tcp.c       | 18 +++++++++++++-----
 net/mptcp/protocol.c | 11 +++++++++--
 3 files changed, 25 insertions(+), 7 deletions(-)

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
index 9251c99d3cfd..d10a3cdae220 100644
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
@@ -1197,8 +1200,13 @@ static int tcp_sendmsg_fastopen(struct sock *sk, str=
uct msghdr *msg,
 =09=09}
 =09}
 =09flags =3D (msg->msg_flags & MSG_DONTWAIT) ? O_NONBLOCK : 0;
-=09err =3D __inet_stream_connect(sk->sk_socket, uaddr,
-=09=09=09=09    msg->msg_namelen, flags, 1);
+=09if (!sk_is_mptcp(sk))
+=09=09err =3D __inet_stream_connect(sk->sk_socket, uaddr,
+=09=09=09=09=09    msg->msg_namelen, flags, 1);
+=09else
+=09=09err =3D mptcp_stream_connect(sk->sk_socket, uaddr,
+=09=09=09=09=09   msg->msg_namelen, msg->msg_flags);
+
 =09/* fastopen_req could already be freed in __inet_stream_connect
 =09 * if the connection times out or gets rst
 =09 */
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 470045793181..8cf307e4e59c 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1673,9 +1673,16 @@ static int mptcp_sendmsg(struct sock *sk, struct msg=
hdr *msg, size_t len)
 =09long timeo;
=20
 =09/* we don't support FASTOPEN yet */
-=09if (msg->msg_flags & MSG_FASTOPEN)
-=09=09return -EOPNOTSUPP;
+=09if (msg->msg_flags & MSG_FASTOPEN) {
+=09=09struct socket *ssock =3D __mptcp_nmpc_socket(msk);
=20
+=09=09if (ssock) {
+=09=09=09int copied_syn_fastopen =3D 0;
+
+=09=09=09ret =3D tcp_sendmsg_fastopen(ssock->sk, msg, &copied_syn_fastopen=
, len, NULL);
+=09=09=09copied +=3D copied_syn_fastopen;
+=09=09}
+=09}
 =09/* silently ignore everything else */
 =09msg->msg_flags &=3D MSG_MORE | MSG_DONTWAIT | MSG_NOSIGNAL;
=20
--=20
2.25.1


