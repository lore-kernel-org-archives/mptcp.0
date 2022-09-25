Received: from sender11-of-o51.zoho.eu (sender11-of-o51.zoho.eu [31.186.226.237])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 851114685
	for <mptcp@lists.linux.dev>; Sun, 25 Sep 2022 23:26:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1664148371; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=bg9eJRqim7mb5OutGludFX98Tc+12wJuprE+a1BAZTS9o7TpIvD0WM/WlB9QaPaaaHZmCdH+MA4hchkexdt4P5LxSAxpUnQDhAC5hghTTgJKCnZaiMHoatashCZ85wUYly3ZHoyFODlwLDQtf8gr06Qgnk/tpthibjhCnj/PCFE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1664148371; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
	bh=29/2Wv8ppT+6/XSVyrfjLFk6pFV1hhH3C4UmdC18qPc=; 
	b=VDoR4TKy4EDd8ULNV5nTb1buZdPM8E7Eq+v9ELPGOzAUTVNci2u9vi1Uduq0w9UEISuJ3nntG6wW368k4jSZkf/4H33XVFT15NJkvOxuFSdrQT7mZbAB861q5+JF4NOjM33QA2rnRBR8xR7+wm4/ZAVpgMNs8qndBIO2htQNK/k=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=shytyi.net;
	spf=pass  smtp.mailfrom=dmytro@shytyi.net;
	dmarc=pass header.from=<dmytro@shytyi.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1664148371;
	s=hs; d=shytyi.net; i=dmytro@shytyi.net;
	h=From:From:To:To:Cc:Cc:Message-ID:Subject:Subject:Date:Date:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
	bh=29/2Wv8ppT+6/XSVyrfjLFk6pFV1hhH3C4UmdC18qPc=;
	b=HmOZpHI2LDRMTZSTKqYGaFG2hm1vhAnDaX8tQKKyAPLAR/OJMn/9bdyIAIDzeaDG
	b/Zp1IfTUnjkQn9uOA0YP81S5AMSRxj6gYttmZZ0gE0uzD2Mq65+17BPqzrg3+OEZxt
	5ri2TaPNdAY/nsaZ3bWrJ21wfPRjtRe9giqJxA2s=
Received: from doris.localdomain (243.34.22.93.rev.sfr.net [93.22.34.243]) by mx.zoho.eu
	with SMTPS id 16641483695721005.7720995242595; Mon, 26 Sep 2022 01:26:09 +0200 (CEST)
From: Dmytro Shytyi <dmytro@shytyi.net>
To: mptcp@lists.linux.dev
Cc: Dmytro Shytyi <dmytro@shytyi.net>
Message-ID: <20220925232601.25252-4-dmytro@shytyi.net>
Subject: [RFC PATCH mptcp-next v11 3/4] mptcp: add mptcp_subflow_conn_sock()
Date: Mon, 26 Sep 2022 01:26:00 +0200
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

In the following patches we will call mptcp_subflow_conn_sock() from=20
tcp_sendmsg_fastopen() in file "net/ipv4/tcp.c", thus make such symbol
visible.

Signed-off-by: Dmytro Shytyi <dmytro@shytyi.net>
---
 include/net/mptcp.h  |  1 +
 net/ipv4/tcp.c       | 15 +++++++++++++--
 net/mptcp/protocol.c |  6 ++++++
 3 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index d9908b839059..ccf2b42837a1 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -151,6 +151,7 @@ void mptcp_write_options(struct tcphdr *th, __be32 *ptr=
, struct tcp_sock *tp,
=20
 void mptcp_diag_fill_info(struct mptcp_sock *msk, struct mptcp_info *info)=
;
 int mptcp_stream_connect(struct socket *sock, struct sockaddr *uaddr, int =
addr_len, int flags);
+struct sock *mptcp_subflow_conn_sock(struct sock *sk);
=20
 /* move the skb extension owership, with the assumption that 'to' is
  * newly allocated
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 5702ca9b952d..a22c8044de17 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -1197,8 +1197,19 @@ static int tcp_sendmsg_fastopen(struct sock *sk, str=
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
index c39ed726c1c0..fb08e1f458c0 100644
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
--=20
2.25.1


