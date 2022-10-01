Received: from sender11-of-o51.zoho.eu (sender11-of-o51.zoho.eu [31.186.226.237])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15FE61FC8
	for <mptcp@lists.linux.dev>; Sat,  1 Oct 2022 03:15:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1664594117; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=aEWnBZ1KveJoxcGota4rm+0xM3U0xS6UJ91GYJeFyXLL0xdTqyMD/JmZzzq3C71jVL2xrbo9tmnCMpH39aJRcR4u6NR7BDVGdCfUXqt0VNtGJawkFEljw1mI73gEBzNvso0Z3jGs7j7ndNDXLZZMYk4c4anqHOTbC4rkQcAtJpA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1664594117; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
	bh=3EYDLHBlylvA6XJ6g7t9U8oLS5AOCcnQetOl+H9K3yQ=; 
	b=bEIpapF/h8NwdihSpb38iVkWpktr3JudR/SVGlc99YflGoMx5NEVwJOmRKnJZF2yuwjwXa5QULA9B4yoBB2aP//op4dZJ1zs9zpa+67WeFRp7qMhWE4liG2azukkK+3qXCx8SKT+DXE2TwQDND3DkR6w8K4JWff+cgKHRu4LvXQ=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=shytyi.net;
	spf=pass  smtp.mailfrom=dmytro@shytyi.net;
	dmarc=pass header.from=<dmytro@shytyi.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1664594117;
	s=hs; d=shytyi.net; i=dmytro@shytyi.net;
	h=From:From:To:To:Cc:Cc:Message-ID:Subject:Subject:Date:Date:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
	bh=3EYDLHBlylvA6XJ6g7t9U8oLS5AOCcnQetOl+H9K3yQ=;
	b=EnznYydjYKs9GhxzHW5T7ArumyxmlmPar5ObYuY6UTCxDGxAZ1+HQjyIX7OU55la
	xMFTwky7SltnmtXHGBziJhUf8gqEQczvcJPb3323ZKcz1RY7TLOdjpx62Tkd3FrCcy6
	c7kG3TsTGuFa5WhyVLURdVfu1P4wj12vS/PV73CA=
Received: from localhost.localdomain (243.34.22.93.rev.sfr.net [93.22.34.243]) by mx.zoho.eu
	with SMTPS id 1664594116307732.6650134812088; Sat, 1 Oct 2022 05:15:16 +0200 (CEST)
From: Dmytro Shytyi <dmytro@shytyi.net>
To: mptcp@lists.linux.dev
Cc: Dmytro Shytyi <dmytro@shytyi.net>,
	Benjamin Hesmans <benjamin.hesmans@tessares.net>
Message-ID: <20221001031502.29152-4-dmytro@shytyi.net>
Subject: [RFC PATCH mptcp-next v13 3/7] mptcp: introduce MSG_FASTOPEN flag.
Date: Sat,  1 Oct 2022 03:14:58 +0000
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

In the following patches we will analyse the MSG_FASTOPEN flag
in the mptcp_sendmsg() and invoke the MPTFO.

Signed-of-by: Benjamin Hesmans <benjamin.hesmans@tessares.net>
Signed-off-by: Dmytro Shytyi <dmytro@shytyi.net>
---
 net/mptcp/protocol.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index f499e3e5a06b..0d8602ddf146 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1673,17 +1673,14 @@ static int mptcp_sendmsg(struct sock *sk, struct ms=
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
--=20
2.34.1


