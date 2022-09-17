Received: from sender11-of-o51.zoho.eu (sender11-of-o51.zoho.eu [31.186.226.237])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7B525CA4
	for <mptcp@lists.linux.dev>; Sat, 17 Sep 2022 22:29:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1663453761; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=IKOipHfF/+bz6XTLwq+rr5gnYjgrL0MTtjhyA5XjAEBf32LWcyqs5swMEYg3CYv0denI1JlSgz0uq6moOiqjZ5uylX5vVA7ql8H24iwE54EkWEnVork2LUk1QPrgx80m/DvrVYoMjz/OacCoCY8lBR4ESDKwyMsmVFoTY/gU9eA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1663453761; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
	bh=VUQ2DrqX5H85H/h5p3TVuwYf0CORD1YLYTYfaKLasHw=; 
	b=V+bon2RHZ9xokdm5JrwIW7/XxqdN5nWLY97zlFXsbH6TQoTm/NXhIoUxM4Adb+ccfh+wQJeC3QyGqH+MVeWUE+2QMsP4k0elmyt2bTImVgmcjBopPMM+GX6x4DWf5wsQ1p/UPIDInxO++TQ4QL+T/zPrxe+xcKB2//JZGQpm9dE=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=shytyi.net;
	spf=pass  smtp.mailfrom=dmytro@shytyi.net;
	dmarc=pass header.from=<dmytro@shytyi.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1663453761;
	s=hs; d=shytyi.net; i=dmytro@shytyi.net;
	h=From:From:To:To:Cc:Cc:Message-ID:Subject:Subject:Date:Date:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
	bh=VUQ2DrqX5H85H/h5p3TVuwYf0CORD1YLYTYfaKLasHw=;
	b=AOEtPJU6Grsq50Cl7kTYEqTEX6HA5E6PaklXSnEJDk/W8KkyOEbb7IGpBlyttSpY
	cFs5y7xwYAr1nHU/fys6qMG9jeWjmasq2y+MVygxvim7j/vUjZN04zlvwnF67wK5aC1
	7kRLLD/cWnmxaImnKVhK0NOq7E7qFUfenImm9+kc=
Received: from doris.localdomain (243.34.22.93.rev.sfr.net [93.22.34.243]) by mx.zoho.eu
	with SMTPS id 1663453758759400.21130895780834; Sun, 18 Sep 2022 00:29:18 +0200 (CEST)
From: Dmytro Shytyi <dmytro@shytyi.net>
To: mptcp@lists.linux.dev
Cc: Dmytro Shytyi <dmytro@shytyi.net>
Message-ID: <20220917222853.2406-7-dmytro@shytyi.net>
Subject: [RFC PATCH mptcp-next v7 06/11] add mptcp_setsockopt_fastopen
Date: Sun, 18 Sep 2022 00:28:48 +0200
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220917222853.2406-1-dmytro@shytyi.net>
References: <20220917222853.2406-1-dmytro@shytyi.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-ZohoMailClient: External
Content-Type: text/plain; charset=utf8

Add set MPTFO socket option for MPTCP.

Signed-off-by: Dmytro Shytyi <dmytro@shytyi.net>
---
 net/mptcp/fastopen.c | 28 ++++++++++++++++++++++++++++
 net/mptcp/protocol.h |  2 ++
 net/mptcp/sockopt.c  |  3 +++
 3 files changed, 33 insertions(+)

diff --git a/net/mptcp/fastopen.c b/net/mptcp/fastopen.c
index 50b5c3376672..436e773d798a 100644
--- a/net/mptcp/fastopen.c
+++ b/net/mptcp/fastopen.c
@@ -63,3 +63,31 @@ int mptcp_sendmsg_fastopen(struct sock *sk, struct msghd=
r *msg,
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
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 5cd14eacd1d6..8caaeeedb9da 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -843,6 +843,8 @@ void mptcp_rfree(struct sk_buff *skb);
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


