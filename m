Received: from sender11-of-o51.zoho.eu (sender11-of-o51.zoho.eu [31.186.226.237])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9641B1FD1
	for <mptcp@lists.linux.dev>; Sat,  1 Oct 2022 03:15:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1664594118; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=Y0MdkWsjeY56/3HvzsxPfCFsRcp9K05EcgecoWyilIWdS6cHRliDMpSgplT9NRfD7BS6X59Eggx7RobMUQPcrJBcSzarsCuddQlhpjpVFjtqI2amKn4trZ8x1UNAyq/zEWVt7V/cXPol4oKxO9aY6eFCR8ZSnH5YQU6gEDYSLYI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1664594118; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
	bh=pNu48RZme7ExKQiNWIIrnxNBbaEyThENQeRocKx8Nq8=; 
	b=h7Cb/pUu7j6iYrUjmMCD8rv1Y06tzt14/mxMwyGnTFOVx17J78DxarKovsP/ORJmQC1+nQ6yaH2q/PIqqB1Tgh3MOv/XQim7cospgRHPtT1+BaB9SFmpdBACay7gBXCpNEySUZHpVW7Dqq43K2zi710VhMGWF4YbrVykftPC2Rs=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=shytyi.net;
	spf=pass  smtp.mailfrom=dmytro@shytyi.net;
	dmarc=pass header.from=<dmytro@shytyi.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1664594118;
	s=hs; d=shytyi.net; i=dmytro@shytyi.net;
	h=From:From:To:To:Cc:Cc:Message-ID:Subject:Subject:Date:Date:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
	bh=pNu48RZme7ExKQiNWIIrnxNBbaEyThENQeRocKx8Nq8=;
	b=awoOjZqgxIPwDWHD7N5GjweRCTBErLyE+iE5niVD1b6PCdsh7DLpHLLv6eSkSeIy
	GTejbghSDikxHfe9ddkFa0Wa+oSll9RQshaz96D8VvyF+8IFIqkQjt+iFep1mst+i6q
	T5mvUo+IQtfGkkq7DrzJcSA3EEuZLXbA4qpsFvFY=
Received: from localhost.localdomain (243.34.22.93.rev.sfr.net [93.22.34.243]) by mx.zoho.eu
	with SMTPS id 1664594117228932.9975573445407; Sat, 1 Oct 2022 05:15:17 +0200 (CEST)
From: Dmytro Shytyi <dmytro@shytyi.net>
To: mptcp@lists.linux.dev
Cc: Dmytro Shytyi <dmytro@shytyi.net>
Message-ID: <20221001031502.29152-7-dmytro@shytyi.net>
Subject: [RFC PATCH mptcp-next v13 6/7] mptcp: add TCP_FASTOPEN sock option
Date: Sat,  1 Oct 2022 03:15:01 +0000
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

We add the TCP_FASTOPEN socket option in this patch that is going to
 be set by the listener side.

Signed-off-by: Dmytro Shytyi <dmytro@shytyi.net>
---
 net/mptcp/sockopt.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index f85e9bbfe86f..7f6977295256 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -559,6 +559,7 @@ static bool mptcp_supported_sockopt(int level, int optn=
ame)
 =09=09case TCP_NOTSENT_LOWAT:
 =09=09case TCP_TX_DELAY:
 =09=09case TCP_INQ:
+=09=09case TCP_FASTOPEN:
 =09=09case TCP_FASTOPEN_CONNECT:
 =09=09case TCP_FASTOPEN_NO_COOKIE:
 =09=09=09return true;
@@ -569,7 +570,7 @@ static bool mptcp_supported_sockopt(int level, int optn=
ame)
 =09=09/* TCP_REPAIR, TCP_REPAIR_QUEUE, TCP_QUEUE_SEQ, TCP_REPAIR_OPTIONS,
 =09=09 * TCP_REPAIR_WINDOW are not supported, better avoid this mess
 =09=09 */
-=09=09/* TCP_FASTOPEN_KEY, TCP_FASTOPEN are not supported because
+=09=09/* TCP_FASTOPEN_KEY is not supported because
 =09=09 * fastopen for the listener side is currently unsupported
 =09=09 */
 =09}
@@ -801,6 +802,7 @@ static int mptcp_setsockopt_sol_tcp(struct mptcp_sock *=
msk, int optname,
 =09=09/* See tcp.c: TCP_DEFER_ACCEPT does not fail */
 =09=09mptcp_setsockopt_first_sf_only(msk, SOL_TCP, optname, optval, optlen=
);
 =09=09return 0;
+=09case TCP_FASTOPEN:
 =09case TCP_FASTOPEN_CONNECT:
 =09case TCP_FASTOPEN_NO_COOKIE:
 =09=09return mptcp_setsockopt_first_sf_only(msk, SOL_TCP, optname,
@@ -1166,6 +1168,7 @@ static int mptcp_getsockopt_sol_tcp(struct mptcp_sock=
 *msk, int optname,
 =09case TCP_INFO:
 =09case TCP_CC_INFO:
 =09case TCP_DEFER_ACCEPT:
+=09case TCP_FASTOPEN:
 =09case TCP_FASTOPEN_CONNECT:
 =09case TCP_FASTOPEN_NO_COOKIE:
 =09=09return mptcp_getsockopt_first_sf_only(msk, SOL_TCP, optname,
--=20
2.34.1


