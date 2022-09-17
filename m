Received: from sender11-of-o51.zoho.eu (sender11-of-o51.zoho.eu [31.186.226.237])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E44665C80
	for <mptcp@lists.linux.dev>; Sat, 17 Sep 2022 22:29:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1663453761; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=YUN9suur0TtQ/dETTl80ZqWRvd9uDlzYVD6Gtk1pvvZPRcFVk/NhDj518T4rPVyIVKlRS5yMgwwO6mOa0Gp7DloBvK7czT93bhvnWVZRLMaB57t5T0F6VvrmsKDpT2+5HAtP/E7Wn/8gh6Dt2P6znIIgYP1utWyA5PtJBuHXZh0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1663453761; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
	bh=+8imo3OCRmqKISgsXkqfhzJBUDKk85uQ/XsmLjuFMtA=; 
	b=gYOJgm7xmnSf5Btvhw89IkY40ZuFq5zlH/kh//9WtUvyIyPRWgqm9nkaQpPtIV3bBt5I5wJ5qjTESZyLo7QPc1S61DwOZH1q91kVs2z7h6tl2fpmnUWQZFr38H0s1IrlhFd7pM0HzQ/PEUEELumKYmv9PfJ9bHfD7IEsoizhrxc=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=shytyi.net;
	spf=pass  smtp.mailfrom=dmytro@shytyi.net;
	dmarc=pass header.from=<dmytro@shytyi.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1663453761;
	s=hs; d=shytyi.net; i=dmytro@shytyi.net;
	h=From:From:To:To:Cc:Cc:Message-ID:Subject:Subject:Date:Date:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
	bh=+8imo3OCRmqKISgsXkqfhzJBUDKk85uQ/XsmLjuFMtA=;
	b=Uyp8WXlTCtE93TIb6ILWlHuQR2z3u/QADTb2REs4/TNK+5IyB6M1THBQC0dUlyeW
	wsqTfFCdEX/TM4LmlSy89bnSy9Yb2aU9YokRaNfzvfxenSlALFjOmtRpKnWOF4qc61J
	86sTKubwGkdRVRdskh5w13VKhugP/i9skEHwUqoY=
Received: from doris.localdomain (243.34.22.93.rev.sfr.net [93.22.34.243]) by mx.zoho.eu
	with SMTPS id 1663453759189384.00449923472763; Sun, 18 Sep 2022 00:29:19 +0200 (CEST)
From: Dmytro Shytyi <dmytro@shytyi.net>
To: mptcp@lists.linux.dev
Cc: Dmytro Shytyi <dmytro@shytyi.net>
Message-ID: <20220917222853.2406-9-dmytro@shytyi.net>
Subject: [RFC PATCH mptcp-next v7 08/11] Fix unxpctd val of subflow->map_seq(dscrd packet)
Date: Sun, 18 Sep 2022 00:28:50 +0200
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

Fix unexpected value of subflow->map_seq (discarded and after
retransmitted 2nd packet)

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


