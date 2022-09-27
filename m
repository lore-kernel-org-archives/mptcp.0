Received: from sender11-of-o51.zoho.eu (sender11-of-o51.zoho.eu [31.186.226.237])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F8374C95
	for <mptcp@lists.linux.dev>; Tue, 27 Sep 2022 22:54:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1664319260; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=ZKru6BaiWr/AoKId3qk3z0fF0vZk7nBKARS/qleBwOr1N0Fh8jgVdMiLpimtI7xo/bF0UeT93KPy3dI4aHzg6b/2o8Z+3NcrygtqK5OkJlHg7j2ma15v+ocOA/A1pU8dSR5GH6CFog5QAVWR7TBLTQ+LROn7GgcYXYvMKOMNumE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1664319260; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
	bh=TRTqjKeha7LjFQdVpFzahmDMQCFZayAcXH1Kq9U+N48=; 
	b=M3LBTvfBvZl+h9HZWI+Q4sU4NFvyRN+Nilw1oaVPuwg7DTpKE+oK80nGOxqm9CqYae3oAeLhLug9L/DE6R1H6KudBcMI35NYNzGHaPPhBxYvWkWCwNaa0W7/7wyOLi4Jo++IXlE+xrNWL1348kpsjBDmiL4GBSggSaU0EKHj4rI=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=shytyi.net;
	spf=pass  smtp.mailfrom=dmytro@shytyi.net;
	dmarc=pass header.from=<dmytro@shytyi.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1664319260;
	s=hs; d=shytyi.net; i=dmytro@shytyi.net;
	h=From:From:To:To:Cc:Cc:Message-ID:Subject:Subject:Date:Date:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
	bh=TRTqjKeha7LjFQdVpFzahmDMQCFZayAcXH1Kq9U+N48=;
	b=A3MdoI9GO79Qr9RztVGLpxNlsOHyVfAo5kpP0OBi76Ma/+TVw0ORltFVaCFyvgbg
	mqtkVyj7PZXnmsjxci7Md1uAd5IzAefwmNzXkFCCa7cRuQosiG7iG7XcVgv2c0RW0Ii
	xstpdZCRvnD8+gdHHrGrCfapVXeeAogJnvwuOQP0=
Received: from localhost.localdomain (243.34.22.93.rev.sfr.net [93.22.34.243]) by mx.zoho.eu
	with SMTPS id 166431925775567.36965479881292; Wed, 28 Sep 2022 00:54:17 +0200 (CEST)
From: Dmytro Shytyi <dmytro@shytyi.net>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>
Message-ID: <20220927225341.14165-5-dmytro@shytyi.net>
Subject: [RFC PATCH mptcp-next v12 4/7] mptcp: sockopt: make 'tcp_fastopen_connect' generic
Date: Tue, 27 Sep 2022 22:53:38 +0000
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

From: Matthieu Baerts <matthieu.baerts@tessares.net>

This is patch provided by Matthieu. As it seems it not yet merged I
temprorarly integrated in into my series for compilation.
'https://lore.kernel.org/mptcp/
20220927150306.1552795-1-matthieu.baerts@tessares.net/T/'
When it will be merged I will delete it from this set of patches.

Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 net/mptcp/sockopt.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index c7cb68c725b2..8d3b09d75c3a 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -769,17 +769,17 @@ static int mptcp_setsockopt_sol_tcp_defer(struct mptc=
p_sock *msk, sockptr_t optv
 =09return tcp_setsockopt(listener->sk, SOL_TCP, TCP_DEFER_ACCEPT, optval, =
optlen);
 }
=20
-static int mptcp_setsockopt_sol_tcp_fastopen_connect(struct mptcp_sock *ms=
k, sockptr_t optval,
-=09=09=09=09=09=09     unsigned int optlen)
+static int mptcp_setsockopt_first_sf_only(struct mptcp_sock *msk, int leve=
l, int optname,
+=09=09=09=09=09  sockptr_t optval, unsigned int optlen)
 {
 =09struct socket *sock;
=20
-=09/* Limit to first subflow */
+=09/* Limit to first subflow, before the connection establishment */
 =09sock =3D __mptcp_nmpc_socket(msk);
 =09if (!sock)
 =09=09return -EINVAL;
=20
-=09return tcp_setsockopt(sock->sk, SOL_TCP, TCP_FASTOPEN_CONNECT, optval, =
optlen);
+=09return tcp_setsockopt(sock->sk, level, optname, optval, optlen);
 }
=20
 static int mptcp_setsockopt_sol_tcp(struct mptcp_sock *msk, int optname,
@@ -811,7 +811,8 @@ static int mptcp_setsockopt_sol_tcp(struct mptcp_sock *=
msk, int optname,
 =09case TCP_DEFER_ACCEPT:
 =09=09return mptcp_setsockopt_sol_tcp_defer(msk, optval, optlen);
 =09case TCP_FASTOPEN_CONNECT:
-=09=09return mptcp_setsockopt_sol_tcp_fastopen_connect(msk, optval, optlen=
);
+=09=09return mptcp_setsockopt_first_sf_only(msk, SOL_TCP, optname,
+=09=09=09=09=09=09      optval, optlen);
 =09}
=20
 =09return -EOPNOTSUPP;
--=20
2.34.1


