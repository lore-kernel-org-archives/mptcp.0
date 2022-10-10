Received: from sender11-of-o51.zoho.eu (sender11-of-o51.zoho.eu [31.186.226.237])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE91D5CBB
	for <mptcp@lists.linux.dev>; Mon, 10 Oct 2022 22:18:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1665440308; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=b9ZIwlCyRlWueCJd3GdKnixePW3j0M5fjkkplD1CtU/70SFAcpBng9Su6nDyVWVrC+gdObF7r74cI7BOQTkdupttuq/eRZhY8TgQqxUGfAN5bRpLepauozcSdL8eMyjFRjSwpLAEQxQEHJ04ZS7S8vicYIaXhBEQzbSCrv0W9SM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1665440308; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
	bh=cvQq9gdDu5XKGiQ44zR2uokoRkYA4OAqfh2u37svOLU=; 
	b=J1+SROhkIdJff5TJP7Kx1kcH2mXhDXXsI35BKxdUij61WupwnmfdFzQSf2Zd5j+SfjyDbLPp/foe84HnsOpGkTSBKz7u23WCOhpaqga1EafHEtKrWJXwY5LTrpQAHsdmhXVaWSnwNqv2f8NrpVdZXfJ1yk/bE+UGfSjN2WCZTZY=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=shytyi.net;
	spf=pass  smtp.mailfrom=dmytro@shytyi.net;
	dmarc=pass header.from=<dmytro@shytyi.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1665440308;
	s=hs; d=shytyi.net; i=dmytro@shytyi.net;
	h=From:From:To:To:Cc:Cc:Message-ID:Subject:Subject:Date:Date:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
	bh=cvQq9gdDu5XKGiQ44zR2uokoRkYA4OAqfh2u37svOLU=;
	b=DXJsfMJ3V6SaYGXvA03iLRW97VwXekOgR+MbT78vDD4mphg3jE3keTCySB+e72V0
	+C/AZ0/0HfQ3uTNPNQfMDN436fNU++ZEA0xoK3/5ojHEiXnJM7rQlE4ze87RrsfX6AW
	PwgEAFpB4h0kv6SjQxxdphRad/JuEWF+o4To/6gY=
Received: from localhost.localdomain (vps-940813d4.vps.ovh.net [198.244.188.50]) by mx.zoho.eu
	with SMTPS id 1665440306478135.64254988044843; Tue, 11 Oct 2022 00:18:26 +0200 (CEST)
From: Dmytro Shytyi <dmytro@shytyi.net>
To: mptcp@lists.linux.dev
Cc: Dmytro Shytyi <dmytro@shytyi.net>,
	Benjamin Hesmans <benjamin.hesmans@tessares.net>
Message-ID: <20221010221809.1792-2-dmytro@shytyi.net>
Subject: [RFC PATCH mptcp-next v14 1/5] mptcp: introduce MSG_FASTOPEN flag.
Date: Mon, 10 Oct 2022 22:18:05 +0000
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221010221809.1792-1-dmytro@shytyi.net>
References: <20221010221809.1792-1-dmytro@shytyi.net>
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
index 1aa940928b4f..b06f9bbe0e0a 100644
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


