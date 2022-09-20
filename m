Received: from sender11-of-o51.zoho.eu (sender11-of-o51.zoho.eu [31.186.226.237])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EB951C26
	for <mptcp@lists.linux.dev>; Tue, 20 Sep 2022 12:52:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1663678371; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=bwBPRoLWPJ4oMc3nWEvYl36YYd0y+nNY+IxXW+izlm+04QCcLnWMsP/Y5PTnUMv2/24s/VKf66iaa6u9evYiWCVut4MyM5u5uWRWNTVWg9Nx4h8pXor83E3VDHrNGWbt/X7FNMEg7g/h8hG/z00gx63IVNK8M9QbXeAUH5y8M7M=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1663678371; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
	bh=Kc3dIgypXaAFTV5ZQnDy9B33pM/DUI0xqBu0W2vd1jc=; 
	b=bACUgjgde+69NIQxyKUr74twgJcp323ehZ7sv3YZlzWuvVoroIheskBEV700+TMz1ZSvctHFUNkoNVuuiC2Ljrbr/YVuQMNFJzmUkbrmyK4/vl/47kVh6homllxxuDm7PfBhY12O7XyyB35SgOB+ZXmf/KjRRA4WJ7qy2LOVeMA=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=shytyi.net;
	spf=pass  smtp.mailfrom=dmytro@shytyi.net;
	dmarc=pass header.from=<dmytro@shytyi.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1663678371;
	s=hs; d=shytyi.net; i=dmytro@shytyi.net;
	h=From:From:To:To:Cc:Cc:Message-ID:Subject:Subject:Date:Date:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
	bh=Kc3dIgypXaAFTV5ZQnDy9B33pM/DUI0xqBu0W2vd1jc=;
	b=JZz1C/8bGM5ObXvcn/EbPKSSir03BJ1nA32Zksxv8/N9D5ID1208cGY8+cUffZ9H
	U4rwiekQxzt8nja5uGpEFyS5hbcMrtqL9aoEEoCHiXWecH4jTg2BdvxAKy3tjYZkkvH
	mfj5eFRG9fqz2WnNQ7WPqVEcp2PWrE8E7SgbBCfI=
Received: from doris.localdomain (243.34.22.93.rev.sfr.net [93.22.34.243]) by mx.zoho.eu
	with SMTPS id 1663678369512887.626353964329; Tue, 20 Sep 2022 14:52:49 +0200 (CEST)
From: Dmytro Shytyi <dmytro@shytyi.net>
To: mptcp@lists.linux.dev
Cc: Dmytro Shytyi <dmytro@shytyi.net>
Message-ID: <20220920125243.2880-6-dmytro@shytyi.net>
Subject: [RFC PATCH mptcp-next v8 5/7] Fix unxpctd val of subflow->map_seq(dscrd packet)
Date: Tue, 20 Sep 2022 14:52:41 +0200
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220920125243.2880-1-dmytro@shytyi.net>
References: <20220920125243.2880-1-dmytro@shytyi.net>
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
retransmitted 2nd packet(1st after TFO)).
We use mptcp_gen_msk_ackseq_fasopen()
when we know this is the first chunk of data after TFO.

Signed-off-by: Dmytro Shytyi <dmytro@shytyi.net>
---
 net/mptcp/options.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 8852a13cfe62..8e937a422909 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -1212,6 +1212,11 @@ bool mptcp_incoming_options(struct sock *sk, struct =
sk_buff *skb)
 =09=09=09mpext->dsn64 =3D 1;
 =09=09=09mpext->mpc_map =3D 1;
 =09=09=09mpext->data_fin =3D 0;
+=09=09=09
+=09=09=09if (msk->is_mptfo) {
+=09=09=09=09mptcp_gen_msk_ackseq_fastopen(msk, subflow, mp_opt);
+=09=09=09=09mpext->data_seq =3D READ_ONCE(msk->ack_seq);
+=09=09=09}
 =09=09} else {
 =09=09=09mpext->data_seq =3D mp_opt.data_seq;
 =09=09=09mpext->subflow_seq =3D mp_opt.subflow_seq;
--=20
2.25.1


