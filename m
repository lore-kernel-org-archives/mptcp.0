Received: from sender11-of-o51.zoho.eu (sender11-of-o51.zoho.eu [31.186.226.237])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 912265CB2
	for <mptcp@lists.linux.dev>; Sat, 17 Sep 2022 22:29:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1663453761; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=IDDxXAwVGGdxN9NJwP7NOzUXEal2xsEVcPEocS0XfPc2z8ip/DsTp9wVgfu3CeeYWp+WnN3bagkpdBchDojVrOJ6Gv25GGhB9ef55+mEdpnGRnitXm5I8b0pTYD+U584anFojSVYE7tohrtDaH+l7RGqGNqAkZIsyWYfRlA2Tho=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1663453761; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
	bh=SC+suiNAZkW/fD2mjxJ+3iyyTMFO/a23DalUYjpKULA=; 
	b=PJ5PvnQLnNORd8wJmUwUmN4oKsUBgIRpv/ppManJNRjUPpi/WAPwwSa9zrTNKq+hGmYSiNAmNC2RzczIFOc6AZNeF53vWE9cKQGextJrNldB20tEBQPFDvwQwNOTLURiozsZrpUTO68r978u1Yk0pbEk0KxQ6KJ4YCyoJef/nLg=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=shytyi.net;
	spf=pass  smtp.mailfrom=dmytro@shytyi.net;
	dmarc=pass header.from=<dmytro@shytyi.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1663453761;
	s=hs; d=shytyi.net; i=dmytro@shytyi.net;
	h=From:From:To:To:Cc:Cc:Message-ID:Subject:Subject:Date:Date:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
	bh=SC+suiNAZkW/fD2mjxJ+3iyyTMFO/a23DalUYjpKULA=;
	b=eWjkYyl128LMRimbRAKQURiMgC2+C+wmmQcMVXSdtwl1OiUFejlzcUzOyxEAPtim
	AOUCBEM5NS+9dUSAgZzQix+mtZj8LHb4JjB2rUWGzH7oCxOi4C7/w1MBFbVTYy2SRj7
	KqgfpLqlprzkslpmYWSjcsiHQe53c3Uhp7Nc0pyI=
Received: from doris.localdomain (243.34.22.93.rev.sfr.net [93.22.34.243]) by mx.zoho.eu
	with SMTPS id 1663453758328617.93880329637; Sun, 18 Sep 2022 00:29:18 +0200 (CEST)
From: Dmytro Shytyi <dmytro@shytyi.net>
To: mptcp@lists.linux.dev
Cc: Dmytro Shytyi <dmytro@shytyi.net>
Message-ID: <20220917222853.2406-5-dmytro@shytyi.net>
Subject: [RFC PATCH mptcp-next v7 04/11] rfree(), rmem_uncharge() prototypes to protocol.h
Date: Sun, 18 Sep 2022 00:28:46 +0200
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

These 2 functions required the mptcp_fastopen_add_skb() that is not in
protocol.c. Thus we export them to *.h and reuse in fastopen.c

Signed-off-by: Dmytro Shytyi <dmytro@shytyi.net>
---
 net/mptcp/protocol.c | 4 ++--
 net/mptcp/protocol.h | 2 ++
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index af99a03021c9..357767a84c57 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -178,7 +178,7 @@ static void __mptcp_rmem_reclaim(struct sock *sk, int a=
mount)
 =09__sk_mem_reduce_allocated(sk, amount);
 }
=20
-static void mptcp_rmem_uncharge(struct sock *sk, int size)
+void mptcp_rmem_uncharge(struct sock *sk, int size)
 {
 =09struct mptcp_sock *msk =3D mptcp_sk(sk);
 =09int reclaimable;
@@ -191,7 +191,7 @@ static void mptcp_rmem_uncharge(struct sock *sk, int si=
ze)
 =09=09__mptcp_rmem_reclaim(sk, reclaimable);
 }
=20
-static void mptcp_rfree(struct sk_buff *skb)
+void mptcp_rfree(struct sk_buff *skb)
 {
 =09unsigned int len =3D skb->truesize;
 =09struct sock *sk =3D skb->sk;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 21f9bf6d2f7e..5cd14eacd1d6 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -836,6 +836,8 @@ void mptcp_event_addr_announced(const struct sock *ssk,=
 const struct mptcp_addr_
 void mptcp_event_addr_removed(const struct mptcp_sock *msk, u8 id);
 bool mptcp_userspace_pm_active(const struct mptcp_sock *msk);
 int mptcp_stream_connect(struct socket *sock, struct sockaddr *uaddr, int =
addr_len, int flags);
+void mptcp_rmem_uncharge(struct sock *sk, int size);
+void mptcp_rfree(struct sk_buff *skb);
=20
 // Fast Open Mechanism functions begin
 int mptcp_sendmsg_fastopen(struct sock *sk, struct msghdr *msg,
--=20
2.25.1


