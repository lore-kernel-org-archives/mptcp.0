Received: from sender11-of-o51.zoho.eu (sender11-of-o51.zoho.eu [31.186.226.237])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2F2746BA
	for <mptcp@lists.linux.dev>; Sat, 17 Sep 2022 22:29:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1663453759; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=jZvMGDzgqE7fLpBcWQhOsrPvxbPUGlnBgHzVF8kWkPpFvqgtJ7iasaxrGH5uQMPAMlSafu6yacE7dDp5c3f/6yIhfa0yw3BlEk783x/cVK9unuzmJ1Bwn92rcUWFEIMjTBwk+tKE0A4kZAr004WQAMcjmrADgajJgF20sluu5hI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1663453759; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
	bh=lQrsdQ7WntcxlzBejgs67ot2JiQC73UDXM2RJFaYzv0=; 
	b=fCjX9NZ20Uf3RtVEv6kR3kgSHPlKA3p+891QKMb1EAdu4gEPFH1eSU7y+nhXHsMYi5pLHwiGN5yg44EVfwtNR5mrOVKmwBFlQJSC4SiKRIgi9+LgEx2+MKoN1UNc+nAxo6tQwa3dy3mq2OHNSZgJeiLcIFXLGi+GZhsJTCGgN+k=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=shytyi.net;
	spf=pass  smtp.mailfrom=dmytro@shytyi.net;
	dmarc=pass header.from=<dmytro@shytyi.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1663453759;
	s=hs; d=shytyi.net; i=dmytro@shytyi.net;
	h=From:From:To:To:Cc:Cc:Message-ID:Subject:Subject:Date:Date:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
	bh=lQrsdQ7WntcxlzBejgs67ot2JiQC73UDXM2RJFaYzv0=;
	b=YnM+9PGdd8cZFwn/Kr56fiFSCp3Kgw7YHMjWAEfoS3uO2noXNGw/oHo55xhpRV73
	dG0RBie+/QRk1voZNJrrNH6NfkXXWidB+//57F7/A0Q7ZHF/lv51RqbOO19eAWp1g0N
	xnSqt7NbfbILmRybrnb8RbBp9nO0ccPqcno+a6ew=
Received: from doris.localdomain (243.34.22.93.rev.sfr.net [93.22.34.243]) by mx.zoho.eu
	with SMTPS id 166345375788882.48674977069504; Sun, 18 Sep 2022 00:29:17 +0200 (CEST)
From: Dmytro Shytyi <dmytro@shytyi.net>
To: mptcp@lists.linux.dev
Cc: Dmytro Shytyi <dmytro@shytyi.net>
Message-ID: <20220917222853.2406-3-dmytro@shytyi.net>
Subject: [RFC PATCH mptcp-next v7 02/11] add mptcp_stream_connect to protocol.h
Date: Sun, 18 Sep 2022 00:28:44 +0200
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

We call mptcp_stream_connect() from mptcp_sendmsg_fastopen() in
fastopen.c

Signed-off-by: Dmytro Shytyi <dmytro@shytyi.net>
---
 net/mptcp/protocol.c | 4 ++--
 net/mptcp/protocol.h | 1 +
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 55442df8fb97..0e5db0a634d3 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3474,8 +3474,8 @@ static void mptcp_subflow_early_fallback(struct mptcp=
_sock *msk,
 =09__mptcp_do_fallback(msk);
 }
=20
-static int mptcp_stream_connect(struct socket *sock, struct sockaddr *uadd=
r,
-=09=09=09=09int addr_len, int flags)
+int mptcp_stream_connect(struct socket *sock, struct sockaddr *uaddr,
+=09=09=09 int addr_len, int flags)
 {
 =09struct mptcp_sock *msk =3D mptcp_sk(sock->sk);
 =09struct mptcp_subflow_context *subflow;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 1bc9f6e77ddd..1e21293bceaa 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -835,6 +835,7 @@ void mptcp_event(enum mptcp_event_type type, const stru=
ct mptcp_sock *msk,
 void mptcp_event_addr_announced(const struct sock *ssk, const struct mptcp=
_addr_info *info);
 void mptcp_event_addr_removed(const struct mptcp_sock *msk, u8 id);
 bool mptcp_userspace_pm_active(const struct mptcp_sock *msk);
+int mptcp_stream_connect(struct socket *sock, struct sockaddr *uaddr, int =
addr_len, int flags);
=20
 static inline bool mptcp_pm_should_add_signal(struct mptcp_sock *msk)
 {
--=20
2.25.1


