Received: from sender11-of-o51.zoho.eu (sender11-of-o51.zoho.eu [31.186.226.237])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4EA53D78
	for <mptcp@lists.linux.dev>; Wed, 14 Sep 2022 11:32:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1663155123; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=SFJhCIq+Nue6JjCwgMYMTZ6hAIKz8kMIEzsn0odX0+ZVXmL9s93KXfw88lLqOCgHEoaVLttkuRySS6HZRgjXiGaJ+An1vZ9ea7Rr07kSSuNDt7EBOH9KOrctsl98/RNVFUH66t0j0YSGnijl4g2aL+Na4vknw+fw/nE6LeiGyuU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1663155123; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
	bh=MK2tczdk80cOse2QUi2tSXnL08breIsISDHpQOOFYsc=; 
	b=EIdb2NYsXMoYjPi17qWUyiM0CM+wqKPqPGMY7QKJniKXVm9XjbRfEc2bNR3MRK4wBv2m+upvs+ujsLwaxW8V0LML9eJD1f9Bb+2DiEfkqWqdeeNxDWUGYlWeEY7jFVaf0YUQ7XkDhEWbWg971B2vuzPWGQdOjxZYjNLxxDIYUIU=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=shytyi.net;
	spf=pass  smtp.mailfrom=dmytro@shytyi.net;
	dmarc=pass header.from=<dmytro@shytyi.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1663155123;
	s=hs; d=shytyi.net; i=dmytro@shytyi.net;
	h=From:From:To:To:Cc:Cc:Message-ID:Subject:Subject:Date:Date:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
	bh=MK2tczdk80cOse2QUi2tSXnL08breIsISDHpQOOFYsc=;
	b=CZGcCA2PIF01WyyAkVZV02rWQI7SbwUTrbKoe6Vq0uRcOVhoCcUEqQquO1rmQfw3
	r2bFY33a0aI+bsFA9F+xYQ7rC1y1Nn0ewLA8hSlc0SJlQtaE4PMsFm+jdVelgdqe6BV
	jOClsZIJzW9DomOMOjv41SbFjp30Nkc82kkV+uQ0=
Received: from doris.localdomain (243.34.22.93.rev.sfr.net [93.22.34.243]) by mx.zoho.eu
	with SMTPS id 1663155121668925.1547391571731; Wed, 14 Sep 2022 13:32:01 +0200 (CEST)
From: Dmytro Shytyi <dmytro@shytyi.net>
To: mptcp@lists.linux.dev
Cc: Dmytro Shytyi <dmytro@shytyi.net>
Message-ID: <20220914113151.9898-5-dmytro@shytyi.net>
Subject: [RFC PATCH mptcp-next v5 05/10] This fixes the unexpected value of subflow->map_seq for the second packet that leads to packet discard and further retransmit
Date: Wed, 14 Sep 2022 13:31:46 +0200
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

This fixes the unexpected value of
subflow->map_seq for the second packet that leads to packet discard and
further retransmit.

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


