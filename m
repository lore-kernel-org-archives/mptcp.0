Received: from sender11-of-o51.zoho.eu (sender11-of-o51.zoho.eu [31.186.226.237])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D07496AA9
	for <mptcp@lists.linux.dev>; Thu, 15 Sep 2022 23:56:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1663286187; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=b5DPWH8Pk4o97unsALMrFFJnp2S873dzVfklAm0q3ZdBvkhCnWX4L3pUQAi3UvCkoizwSnbls5vpMow0t+kMslaPWGFQ5NE+SwvJ2d0RJMmyMr2P9VnS35oGDJQlcqRuMiWFY/in/ljm5dbe1BTDUuTI5HooVekVBIoXVy+WyQw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1663286187; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
	bh=Mp/yDBj06jP76eco8LmFyPLhjSEIxCkX+ZUDyJXkFLM=; 
	b=g8nsrjWk82yHcUFyZoVVSpKUQIl7X2OhSZ/inVtlx/hYUrDSkhXgvslqilQytsoZBdNrCgcqlmUGc0hCjc8/ibSFh6emh3EBJe8soT9bY2WKhuR23Oz8FsKYu+x65Uyypm+/CN7COpRED9dOxLMTDyb6kK0Ns6cmNvqrU3xpV5A=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=shytyi.net;
	spf=pass  smtp.mailfrom=dmytro@shytyi.net;
	dmarc=pass header.from=<dmytro@shytyi.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1663286187;
	s=hs; d=shytyi.net; i=dmytro@shytyi.net;
	h=From:From:To:To:Cc:Cc:Message-ID:Subject:Subject:Date:Date:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
	bh=Mp/yDBj06jP76eco8LmFyPLhjSEIxCkX+ZUDyJXkFLM=;
	b=LhjBC5rm7HbOvETJAn2dj7ZzAJ7kVng2nCnEsjPt2nmMdjM3QpKUNR4QWxVOWrjm
	3dMhB1EuaNUGQ40rpo+qwLPiLSQjQ3DgleHB9aBCUpMUztOcO27/xa0NN8dJmtpLAUd
	RsIogrzcjNEFfIQANGH5ErYDhntsUOJ7LQkJNhSk=
Received: from doris.localdomain (243.34.22.93.rev.sfr.net [93.22.34.243]) by mx.zoho.eu
	with SMTPS id 166328618501544.71671186897254; Fri, 16 Sep 2022 01:56:25 +0200 (CEST)
From: Dmytro Shytyi <dmytro@shytyi.net>
To: mptcp@lists.linux.dev
Cc: Dmytro Shytyi <dmytro@shytyi.net>
Message-ID: <20220915235604.26018-6-dmytro@shytyi.net>
Subject: [RFC PATCH mptcp-next v6 5/9] Fix unxpctd val of subflow->map_seq(dscrd packet)
Date: Fri, 16 Sep 2022 01:56:00 +0200
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220915235604.26018-1-dmytro@shytyi.net>
References: <20220915235604.26018-1-dmytro@shytyi.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-ZohoMailClient: External
Content-Type: text/plain; charset=utf8

This fixes the unexpected value of subflow->map_seq for the=20
second packet that leads to packet discard and further=20
retransmit.

Signed-off-by: Dmytro Shytyi <dmytro@shytyi.net>
---
 net/mptcp/subflow.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index c7d49fb6e7bd..075c61d1d37f 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1077,8 +1077,10 @@ static enum mapping_status get_mapping_status(struct=
 sock *ssk,
 =09=09/* will validate the next map after consuming the current one */
 =09=09goto validate_csum;
 =09}
-
-=09subflow->map_seq =3D map_seq;
+=09if (msk->is_mptfo)
+=09=09subflow->map_seq =3D READ_ONCE(msk->ack_seq);
+=09else
+=09=09subflow->map_seq =3D map_seq;
 =09subflow->map_subflow_seq =3D mpext->subflow_seq;
 =09subflow->map_data_len =3D data_len;
 =09subflow->map_valid =3D 1;
--=20
2.25.1


