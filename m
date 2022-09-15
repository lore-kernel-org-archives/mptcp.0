Received: from sender11-of-o51.zoho.eu (sender11-of-o51.zoho.eu [31.186.226.237])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C126D184
	for <mptcp@lists.linux.dev>; Thu, 15 Sep 2022 23:56:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1663286185; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=D/3Z49ObZNi6/URMHVALG5BBWkjM/5OTeMYo7UOAVbfxfUV6smoJT/ALx7unBPtcxv3NpUhSymF9gh+cLcDmKKj+y6XDykBq7/1kKoSy1phq+XYzUeSWM8DpYjqq2LEcCMCcp/TiEdwfXvrsYy32Yx+ElaU5YXFVMT933wbpDHI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1663286185; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
	bh=zntg//5FjP1US/NQkEPqMMv2dDieVdYUJMm6/o1css0=; 
	b=RsM2v9td7pptDOpiAeXYXGfj3enLvVlHpa+5HS1VMEuur4f2X7+griYLasLLPAIMy6YjJvzBJCeaz9O9klJ1NSYXCvsOXDSYjaDYcNM0KEx1I1eDfSwUB/XXQGAZYifBFskZ0i8McHJqMPQtQNLhKFmUyv/u1YdbF15GAJOPnr0=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=shytyi.net;
	spf=pass  smtp.mailfrom=dmytro@shytyi.net;
	dmarc=pass header.from=<dmytro@shytyi.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1663286185;
	s=hs; d=shytyi.net; i=dmytro@shytyi.net;
	h=From:From:To:To:Cc:Cc:Message-ID:Subject:Subject:Date:Date:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
	bh=zntg//5FjP1US/NQkEPqMMv2dDieVdYUJMm6/o1css0=;
	b=fJNdykHLkOEpslNslKpB024fVmV+fd0YGbFbaeoVmSwtSe/mbFjzMdDmta9wtw3X
	aEKHkiSSinivNfrMypzUhyB6HhaOH4SUI3z4NWvGAMNCt/RlLXhuL3XflElEKGP0b05
	l+1nE9DxuO8JuvAAVSw6c/upQ8NRIbVxrJ7qTFRM=
Received: from doris.localdomain (243.34.22.93.rev.sfr.net [93.22.34.243]) by mx.zoho.eu
	with SMTPS id 1663286184587218.62465368228095; Fri, 16 Sep 2022 01:56:24 +0200 (CEST)
From: Dmytro Shytyi <dmytro@shytyi.net>
To: mptcp@lists.linux.dev
Cc: Dmytro Shytyi <dmytro@shytyi.net>
Message-ID: <20220915235604.26018-4-dmytro@shytyi.net>
Subject: [RFC PATCH mptcp-next v6 3/9] rfree(), rmem_uncharge() prototypes to protocol.h
Date: Fri, 16 Sep 2022 01:55:58 +0200
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

These 2 functions required the mptcp_fastopen_add_skb() that is not in
protocol.c. Thus we export them to *.h and reuse in fastopen.c

Signed-off-by: Dmytro Shytyi <dmytro@shytyi.net>
---
 net/mptcp/protocol.c | 4 ++--
 net/mptcp/protocol.h | 3 +++
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 6bbf1b86465d..ba50aa88d5d8 100644
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
index ad51910f1cc9..5cd14eacd1d6 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -835,6 +835,9 @@ void mptcp_event(enum mptcp_event_type type, const stru=
ct mptcp_sock *msk,
 void mptcp_event_addr_announced(const struct sock *ssk, const struct mptcp=
_addr_info *info);
 void mptcp_event_addr_removed(const struct mptcp_sock *msk, u8 id);
 bool mptcp_userspace_pm_active(const struct mptcp_sock *msk);
+int mptcp_stream_connect(struct socket *sock, struct sockaddr *uaddr, int =
addr_len, int flags);
+void mptcp_rmem_uncharge(struct sock *sk, int size);
+void mptcp_rfree(struct sk_buff *skb);
=20
 // Fast Open Mechanism functions begin
 int mptcp_sendmsg_fastopen(struct sock *sk, struct msghdr *msg,
--=20
2.25.1


