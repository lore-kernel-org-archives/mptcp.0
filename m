Received: from sender11-of-o51.zoho.eu (sender11-of-o51.zoho.eu [31.186.226.237])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2AED291C
	for <mptcp@lists.linux.dev>; Sun,  6 Nov 2022 15:24:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1667748272; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=iMRKhJDGSF+0ztG9gaqJnbe/p2sKgM6XO3j+uGU1PzqWYR5t5W5i3xW4AvCBO+Ou67dfc2OA5zLEqkFdNGzbz4odjds/pmwXn5FPTj/yFA9NFgd2O69E0QPGleEV8JyFf4Ukh3I3QTjGKUUdZ0geCZKIITruBGWgE9L5/4UjBJM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1667748272; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
	bh=47KsXtqvgfdp5fHSeNYVlFXhTzq+vd4zu9jynPaG38k=; 
	b=AI6S1QZ0B0d1DGLfQCSUHqJTOH7g5g5dygs7K2/imoB3egwP7BjGBVCuVjcohtOdU5s48NfytqnBGZgbReTcjHEcjVkLdGTEg5VH0IWUfnWXhvsG0dIaYclq5QuBV7BSvOrMS++Vxymf3LssyZc2MhebJzmWnPbKi5Crrh0A0gk=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=shytyi.net;
	spf=pass  smtp.mailfrom=dmytro@shytyi.net;
	dmarc=pass header.from=<dmytro@shytyi.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1667748272;
	s=hs; d=shytyi.net; i=dmytro@shytyi.net;
	h=From:From:To:To:Cc:Cc:Message-ID:Subject:Subject:Date:Date:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
	bh=47KsXtqvgfdp5fHSeNYVlFXhTzq+vd4zu9jynPaG38k=;
	b=PNX7rIdE20eOFdXuKB6TR41IQ2qyOInj6MtcS8P85aBmvSPEmMl66z7Co1ml2xkC
	lTjnFLUOiupUXWkHsYRPTtuo86pA7D15Opg3+xduwCvn8LkvjJRb3QZPNDNZfFtMQcM
	LTM/AKKavZPwn9UKT7Y336Z8IXcRZvUYbkkzoalw=
Received: from localhost.localdomain (vps-940813d4.vps.ovh.net [198.244.188.50]) by mx.zoho.eu
	with SMTPS id 1667748270672261.0089987436238; Sun, 6 Nov 2022 16:24:30 +0100 (CET)
From: Dmytro Shytyi <dmytro@shytyi.net>
To: mptcp@lists.linux.dev
Cc: Dmytro Shytyi <dmytro@shytyi.net>,
	Benjamin Hesmans <benjamin.hesmans@tessares.net>
Message-ID: <20221106152411.655-2-dmytro@shytyi.net>
Subject: [RFC PATCH mptcp-next v15 1/5] mptcp: introduce MSG_FASTOPEN flag
Date: Sun,  6 Nov 2022 15:24:07 +0000
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221106152411.655-1-dmytro@shytyi.net>
References: <20221106152411.655-1-dmytro@shytyi.net>
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
index 3196d2a350f9..f4247218fd1b 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1704,17 +1704,14 @@ static int mptcp_sendmsg(struct sock *sk, struct ms=
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
 =09=09int copied_syn =3D 0;
=20
 =09=09ret =3D mptcp_sendmsg_fastopen(sk, ssock->sk, msg, len, &copied_syn)=
;
--=20
2.34.1


