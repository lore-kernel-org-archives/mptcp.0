Received: from sender11-of-o51.zoho.eu (sender11-of-o51.zoho.eu [31.186.226.237])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C03F73D76
	for <mptcp@lists.linux.dev>; Wed, 14 Sep 2022 11:32:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1663155123; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=fbzM7HBg09FC/HlJHVWgOtyZpqsxBGojzuR4wpmk4lVj8S6cCr1i4eKvW9spIBt2RlIm1JZ8d6eIX775llep2e6rtsD+m/ZumAoArX/lM1iEDl1B8kUBR0sISmcLs4wgHj3oIbMF+aUq1q1gbmryzs8T5CZc6/PWUJ4JhHxZNYc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1663155123; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
	bh=AN4r9vYqYv/C9ZhNCTHGl69lmQ+7KAE2A5hF3GSyRdo=; 
	b=k/U5EuCdAWk/6P850I27M0jVRpae+F0ClTKLlIv9qnSJmZXaSUO7NpStk0Be6zNt/wN2srbjFnE21vjE28iPKVUEYDbxkX3S7OZV0kT97tD69/P6wguePoUOIW0eghX/bZphHaF+vg+0mSRl/jG7rS/foZ3Vn9+k/WEgYYAEYXE=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=shytyi.net;
	spf=pass  smtp.mailfrom=dmytro@shytyi.net;
	dmarc=pass header.from=<dmytro@shytyi.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1663155123;
	s=hs; d=shytyi.net; i=dmytro@shytyi.net;
	h=From:From:To:To:Cc:Cc:Message-ID:Subject:Subject:Date:Date:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
	bh=AN4r9vYqYv/C9ZhNCTHGl69lmQ+7KAE2A5hF3GSyRdo=;
	b=aSq00re637ujQH5VxuhWv5WWE/q06pigdkBQmG0lOHn9iLqqwtFr4ohrS2w3Fxbr
	enULBzb3v/rii/VJL2vJgz9m0KiP7zr1vIlxV5F40WNZb4o1Kru8dhwpUFozLGvOfQU
	JEwPBqhgkCzUhpWDyCi2VUfgntDv4lT3IrVFQnYU=
Received: from doris.localdomain (243.34.22.93.rev.sfr.net [93.22.34.243]) by mx.zoho.eu
	with SMTPS id 1663155122533164.44474331162792; Wed, 14 Sep 2022 13:32:02 +0200 (CEST)
From: Dmytro Shytyi <dmytro@shytyi.net>
To: mptcp@lists.linux.dev
Cc: Dmytro Shytyi <dmytro@shytyi.net>
Message-ID: <20220914113151.9898-9-dmytro@shytyi.net>
Subject: [RFC PATCH mptcp-next v5 09/10] These 2 functions are from protocol.c. Cannot import as not in protocol.h. Should I leave them like this? Or add prototypes in protocol.h and reuse?
Date: Wed, 14 Sep 2022 13:31:50 +0200
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

These 2 functions are from
protocol.c. Cannot import as not in protocol.h. Should I leave them like
this? Or add prototypes in protocol.h and reuse?

Signed-off-by: Dmytro Shytyi <dmytro@shytyi.net>
---
 net/mptcp/fastopen.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/net/mptcp/fastopen.c b/net/mptcp/fastopen.c
index fd0e4b7c8f68..6a4cb7a28871 100644
--- a/net/mptcp/fastopen.c
+++ b/net/mptcp/fastopen.c
@@ -102,6 +102,25 @@ void mptcp_treat_3d_ack_fastopen(struct mptcp_sock *ms=
k, struct mptcp_subflow_co
 =09}
 }
=20
+static void mptcp_rmem_uncharge(struct sock *sk, int size)
+{
+=09struct mptcp_sock *msk =3D mptcp_sk(sk);
+=09int reclaimable;
+
+=09msk->rmem_fwd_alloc +=3D size;
+=09reclaimable =3D msk->rmem_fwd_alloc - sk_unused_reserved_mem(sk);
+
+}
+
+static void mptcp_rfree(struct sk_buff *skb)
+{
+=09unsigned int len =3D skb->truesize;
+=09struct sock *sk =3D skb->sk;
+
+=09atomic_sub(len, &sk->sk_rmem_alloc);
+=09mptcp_rmem_uncharge(sk, len);
+}
+
 void mptcp_fastopen_add_skb(struct sock *sk, struct sk_buff *skb, struct r=
equest_sock *req)
 {
 =09struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(sk);
--=20
2.25.1


