Received: from sender11-of-o51.zoho.eu (sender11-of-o51.zoho.eu [31.186.226.237])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ADFF4C9A
	for <mptcp@lists.linux.dev>; Tue, 27 Sep 2022 22:54:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1664319260; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=dVl1RnIo8y88c9TMHM7ArjcPOJZQlSUcwhjfB2+Qem/OMtUMG+0krxZE+jgXpradlixnDlsEsHdTGZN/z29okt56nvX/R+ZUQp7iiP8Ynm7/9DkzCgtJdnTTYclwWq5nMW2ai5GpJiv2CiKbjdBhfiEFSgKO/KL8yN3BiTTgHvQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1664319260; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
	bh=C5+JLBx3Z5RGSz9ifWcfgtyT4XsoQfREPNE7FNnssFE=; 
	b=MsiAdpJ4GPBSawYzUdVTxPW9dGS9lA0cSEVyCwfOpG3ayJCxVQZSXUP2c1pk66gulyPW5xUzdiOMCyE3ALJNxRGZMlL7X7HEGHqZCvloOhG738yAQgvyOrwYzCj9a/RGRfcrNs9A1Z2vwILDtj6Cjl0uQd5FeS0P7YODHFEXmnk=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=shytyi.net;
	spf=pass  smtp.mailfrom=dmytro@shytyi.net;
	dmarc=pass header.from=<dmytro@shytyi.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1664319260;
	s=hs; d=shytyi.net; i=dmytro@shytyi.net;
	h=From:From:To:To:Cc:Cc:Message-ID:Subject:Subject:Date:Date:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
	bh=C5+JLBx3Z5RGSz9ifWcfgtyT4XsoQfREPNE7FNnssFE=;
	b=bXLZqqJIgbFN9y4B9A5VcVyy4wueZ+O+tJkP+xuVTuIYoem1K5TwF9fsxsacHR1p
	44DlRMpyTAwQ8dh5L9Oft8fVdw6nPF1Ve7ybjlkq+HwLGuh5T/jCi0qXQROX0WliyAk
	VskCFZXXm7obzSxl3c5rleBMX7ossmeR+ytn2i10=
Received: from localhost.localdomain (243.34.22.93.rev.sfr.net [93.22.34.243]) by mx.zoho.eu
	with SMTPS id 1664319258009197.78128357472542; Wed, 28 Sep 2022 00:54:18 +0200 (CEST)
From: Dmytro Shytyi <dmytro@shytyi.net>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>
Message-ID: <20220927225341.14165-6-dmytro@shytyi.net>
Subject: [RFC PATCH mptcp-next v12 5/7] mptcp: add TCP_FASTOPEN_NO_COOKIE support
Date: Tue, 27 Sep 2022 22:53:39 +0000
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
 net/mptcp/sockopt.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index 8d3b09d75c3a..1857281a0dd5 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -560,6 +560,7 @@ static bool mptcp_supported_sockopt(int level, int optn=
ame)
 =09=09case TCP_TX_DELAY:
 =09=09case TCP_INQ:
 =09=09case TCP_FASTOPEN_CONNECT:
+=09=09case TCP_FASTOPEN_NO_COOKIE:
 =09=09=09return true;
 =09=09}
=20
@@ -568,8 +569,8 @@ static bool mptcp_supported_sockopt(int level, int optn=
ame)
 =09=09/* TCP_REPAIR, TCP_REPAIR_QUEUE, TCP_QUEUE_SEQ, TCP_REPAIR_OPTIONS,
 =09=09 * TCP_REPAIR_WINDOW are not supported, better avoid this mess
 =09=09 */
-=09=09/* TCP_FASTOPEN_KEY, TCP_FASTOPEN, TCP_FASTOPEN_NO_COOKIE,
-=09=09 * are not supported fastopen is currently unsupported
+=09=09/* TCP_FASTOPEN_KEY, TCP_FASTOPEN are not supported because
+=09=09 * fastopen for the listener side is currently unsupported
 =09=09 */
 =09}
 =09return false;
@@ -811,6 +812,7 @@ static int mptcp_setsockopt_sol_tcp(struct mptcp_sock *=
msk, int optname,
 =09case TCP_DEFER_ACCEPT:
 =09=09return mptcp_setsockopt_sol_tcp_defer(msk, optval, optlen);
 =09case TCP_FASTOPEN_CONNECT:
+=09case TCP_FASTOPEN_NO_COOKIE:
 =09=09return mptcp_setsockopt_first_sf_only(msk, SOL_TCP, optname,
 =09=09=09=09=09=09      optval, optlen);
 =09}
@@ -1175,6 +1177,7 @@ static int mptcp_getsockopt_sol_tcp(struct mptcp_sock=
 *msk, int optname,
 =09case TCP_CC_INFO:
 =09case TCP_DEFER_ACCEPT:
 =09case TCP_FASTOPEN_CONNECT:
+=09case TCP_FASTOPEN_NO_COOKIE:
 =09=09return mptcp_getsockopt_first_sf_only(msk, SOL_TCP, optname,
 =09=09=09=09=09=09      optval, optlen);
 =09case TCP_INQ:
--=20
2.34.1


