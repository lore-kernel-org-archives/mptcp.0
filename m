Received: from sender11-of-o51.zoho.eu (sender11-of-o51.zoho.eu [31.186.226.237])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE1F03D75
	for <mptcp@lists.linux.dev>; Wed, 14 Sep 2022 11:32:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1663155123; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=hygTbvvhBa/xL//fer7qIyiwbMbdEnA5dK/8OH2uzloJkltt041KwoLIw/npHQuk5MlZfaes4mvueYl4rIZL9GHTPiMzeuJ6eC3zVO5kdMuGpKm+7gtiRG4y9B6ngeGiVo2a/+OGdlQJddOQTurDBlb8Vf7WW4DLbOkUHDaM38Q=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1663155123; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
	bh=2XpL+SceAwnOP8J9Tjm3l0rGc3X2yBYLg52A0CIoN2I=; 
	b=PKSKBCF24nLXoeChcCwesSkU7FS+6FYU3OcNmZq6Ovwo+ljLVUNaeNRobKccj/hUfqszUnBZyC74qWrJw1jPsrNUBMyr2VsjMJAYI7GAOF2yKpxVePQt4HeOyd2r/o3b+YMDusLTTtNyshvMMc/8bk+kscXrrH27Kg4hSwwX674=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=shytyi.net;
	spf=pass  smtp.mailfrom=dmytro@shytyi.net;
	dmarc=pass header.from=<dmytro@shytyi.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1663155123;
	s=hs; d=shytyi.net; i=dmytro@shytyi.net;
	h=From:From:To:To:Cc:Cc:Message-ID:Subject:Subject:Date:Date:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
	bh=2XpL+SceAwnOP8J9Tjm3l0rGc3X2yBYLg52A0CIoN2I=;
	b=ZdwlFsteb5rnoYFlRwbucSxnEnkmKSkZT9q16dNEoJt+p/xziNWNJJkGFRvxYszL
	Iwbih21YD5kgA3uGfi7T/ePzPSmyBUMx0grTJ6/1v8lElvNNnff2wjJLB7zTrzl2UmC
	SWTAJ4UcB+/Dn82pPqLHxl5GCMpw8A2Gk2A6GfbI=
Received: from doris.localdomain (243.34.22.93.rev.sfr.net [93.22.34.243]) by mx.zoho.eu
	with SMTPS id 1663155121438835.6725507585129; Wed, 14 Sep 2022 13:32:01 +0200 (CEST)
From: Dmytro Shytyi <dmytro@shytyi.net>
To: mptcp@lists.linux.dev
Cc: Dmytro Shytyi <dmytro@shytyi.net>
Message-ID: <20220914113151.9898-4-dmytro@shytyi.net>
Subject: [RFC PATCH mptcp-next v5 04/10] Treat a socket option TCP_FASTOPEN on Lister side. Suggestion @mmartineau(MAY 22): 'Need to use ssk instead of sk in these several lines' (1 AUG): 'Since fastopen is only relevant for the initial subflow (and never with MP_JOIN). __mptcp_nmpc_socket() should give the initial subflow'
Date: Wed, 14 Sep 2022 13:31:45 +0200
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220914113151.9898-1-dmytro@shytyi.net>
References: <20220914113151.9898-1-dmytro@shytyi.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-ZohoMailClient: External
Content-Type: text/plain; charset=utf8

Treat a socket option TCP_FASTOPEN on
Lister side. Suggestion @mmartineau(MAY 22): 'Need to use ssk instead of sk
in these several lines' (1 AUG): 'Since fastopen is only relevant for the
initial subflow (and never with MP_JOIN). __mptcp_nmpc_socket() should give
the initial subflow'

Signed-off-by: Dmytro Shytyi <dmytro@shytyi.net>
---
 net/mptcp/fastopen.c | 31 +++++++++++++++++++++++++++++++
 net/mptcp/protocol.c |  4 ++--
 net/mptcp/protocol.h |  3 +++
 net/mptcp/sockopt.c  |  3 +++
 4 files changed, 39 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/fastopen.c b/net/mptcp/fastopen.c
index 0e071c988894..2633d5148dcb 100644
--- a/net/mptcp/fastopen.c
+++ b/net/mptcp/fastopen.c
@@ -54,3 +54,34 @@ int mptcp_sendmsg_fastopen(struct sock *sk, struct msghd=
r *msg,
 =09ret =3D -EFAULT;
 =09return ret;
 }
+
+int mptcp_setsockopt_sol_tcp_fastopen(struct mptcp_sock *msk, sockptr_t op=
tval,
+=09=09=09=09      unsigned int optlen)
+{
+=09struct sock *ssk =3D __mptcp_nmpc_socket(msk)->sk;
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
+=09lock_sock(ssk);
+
+=09if (val >=3D 0 && ((1 << ssk->sk_state) & (TCPF_CLOSE |
+=09    TCPF_LISTEN))) {
+=09=09tcp_fastopen_init_key_once(net);
+=09=09fastopen_queue_tune(ssk, val);
+=09} else {
+=09=09ret =3D -EINVAL;
+=09}
+
+=09release_sock(ssk);
+=09release_sock(sk);
+
+=09return ret;
+}
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 6bbf1b86465d..af99a03021c9 100644
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
index ad51910f1cc9..ef8330d5a9b5 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -835,11 +835,14 @@ void mptcp_event(enum mptcp_event_type type, const st=
ruct mptcp_sock *msk,
 void mptcp_event_addr_announced(const struct sock *ssk, const struct mptcp=
_addr_info *info);
 void mptcp_event_addr_removed(const struct mptcp_sock *msk, u8 id);
 bool mptcp_userspace_pm_active(const struct mptcp_sock *msk);
+int mptcp_stream_connect(struct socket *sock, struct sockaddr *uaddr, int =
addr_len, int flags);
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


