Received: from sender11-of-o51.zoho.eu (sender11-of-o51.zoho.eu [31.186.226.237])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA4644C98
	for <mptcp@lists.linux.dev>; Tue, 27 Sep 2022 22:54:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1664319260; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=NlP3vuPXiaoKkH6DTn0+w6e9QM4gtG+0mw7OivAyUwtyw4v2aSBtTJ53FgmhpfybFCTmEY50mONFUIIPkbMQxvpM6tYozuGDeH/FWnk5bNOuTuWM7WSXy4271rg+Xw+OcNZRnr1wYAvMUflvGSF8HFmVQdIyNtKAt26ey2RlWYo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1664319260; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
	bh=nxl5+Ng5QWmikY2EfQfFbubzWMPVWXzlSNHyHniwuq8=; 
	b=BOeuEWngJ0wJcd3RkCF0V+Km8LWxqEZoBhRUYfCsRzbdAKOKBqt7TSJQ5qVzb9YIdN97fZbf8lCppOdkGenA8FBZb0Lu520x91wC9Yz9sKxqpc3w7vyILy2dNaSOYZjkjNk+vtzS25oipZuMbuU0pggLZdUSCG6c2zi8t2BLKgk=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=shytyi.net;
	spf=pass  smtp.mailfrom=dmytro@shytyi.net;
	dmarc=pass header.from=<dmytro@shytyi.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1664319260;
	s=hs; d=shytyi.net; i=dmytro@shytyi.net;
	h=From:From:To:To:Cc:Cc:Message-ID:Subject:Subject:Date:Date:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
	bh=nxl5+Ng5QWmikY2EfQfFbubzWMPVWXzlSNHyHniwuq8=;
	b=WknD31QQKQ5RcvjlqKukrhWPO6y1119wSDUNZfKWmuodrKXJio5puesIAQuCgc8U
	GpTq/tIvEuKZ4RkoRyZh80oUwZYj2CPQsu3v3AfPNVoasXAz8z9ULohwBJdQ9YEC6ol
	zUKft3FAZG6NMRB0X0jUSrIz+uq5p5FQArqnBp2g=
Received: from localhost.localdomain (243.34.22.93.rev.sfr.net [93.22.34.243]) by mx.zoho.eu
	with SMTPS id 1664319258267182.38766513430357; Wed, 28 Sep 2022 00:54:18 +0200 (CEST)
From: Dmytro Shytyi <dmytro@shytyi.net>
To: mptcp@lists.linux.dev
Cc: Dmytro Shytyi <dmytro@shytyi.net>
Message-ID: <20220927225341.14165-7-dmytro@shytyi.net>
Subject: [RFC PATCH mptcp-next v12 6/7] mptcp: add TCP_FASTOPEN option
Date: Tue, 27 Sep 2022 22:53:40 +0000
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

We add the TCP_FASTOPEN socket option in this patch that is going to
 be set by the listener side.

Signed-off-by: Dmytro Shytyi <dmytro@shytyi.net>
---
 net/mptcp/sockopt.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index 1857281a0dd5..ab3ba8558efd 100644
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
@@ -811,6 +812,7 @@ static int mptcp_setsockopt_sol_tcp(struct mptcp_sock *=
msk, int optname,
 =09=09return mptcp_setsockopt_sol_tcp_nodelay(msk, optval, optlen);
 =09case TCP_DEFER_ACCEPT:
 =09=09return mptcp_setsockopt_sol_tcp_defer(msk, optval, optlen);
+=09case TCP_FASTOPEN:
 =09case TCP_FASTOPEN_CONNECT:
 =09case TCP_FASTOPEN_NO_COOKIE:
 =09=09return mptcp_setsockopt_first_sf_only(msk, SOL_TCP, optname,
@@ -1176,6 +1178,7 @@ static int mptcp_getsockopt_sol_tcp(struct mptcp_sock=
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


