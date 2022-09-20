Received: from sender11-of-o51.zoho.eu (sender11-of-o51.zoho.eu [31.186.226.237])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 892271C14
	for <mptcp@lists.linux.dev>; Tue, 20 Sep 2022 12:52:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1663678370; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=Gfr3pbHQtURUlUgDrVw3FSbVRVrTCFhpO5XqfjDs3AvI2gpQDuCaMcAG/eS/b8AELTAzTbw9KsvLLkS5LJ+bB3D6r01LmlUYG4sv01pXnaV30sTilvlwK/RZ4ofRN3WcfbGsjp/vnx/R2RVBNp8aFnfUSrBk1M4b2hJTw9GAUOw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1663678370; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
	bh=4rVkQa3qMMUlSRfyOKnPoxRWIYdOpkQv2kjbajFkgxY=; 
	b=JsXOmzlCcJKYqu0+kg6F57VhNzayMAxa4BWJRK6W7POg8+7rzGsE5g4mK0JEi5Pj1DNESg+9BKgF/t4pZCTUTSy55gA0+JK86KCX6ZUR2Tds2E7JgP42izapBO+UkQa6XCN9CG31uSQKaiUuxDXi12VwwAGDUqFG+eFdvCuI0iQ=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=shytyi.net;
	spf=pass  smtp.mailfrom=dmytro@shytyi.net;
	dmarc=pass header.from=<dmytro@shytyi.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1663678370;
	s=hs; d=shytyi.net; i=dmytro@shytyi.net;
	h=From:From:To:To:Cc:Cc:Message-ID:Subject:Subject:Date:Date:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
	bh=4rVkQa3qMMUlSRfyOKnPoxRWIYdOpkQv2kjbajFkgxY=;
	b=cCjehvUj74qgPeo9ZhY7JO+sGdNwQrVBEFP+db7JDyrrxA7S5RRPki/pSVX0HF8k
	HrkJgpNb6AQ1sLjsbasl7K9O1qFvbkbf41A53CZcxqmnzjyEsb9Az+Gwc00gFD7NKGr
	11cGhaKA6HZcgib6kDbW/0EsXDeinGXcSHhoD22M=
Received: from doris.localdomain (243.34.22.93.rev.sfr.net [93.22.34.243]) by mx.zoho.eu
	with SMTPS id 1663678368568884.2600163466974; Tue, 20 Sep 2022 14:52:48 +0200 (CEST)
From: Dmytro Shytyi <dmytro@shytyi.net>
To: mptcp@lists.linux.dev
Cc: Dmytro Shytyi <dmytro@shytyi.net>
Message-ID: <20220920125243.2880-2-dmytro@shytyi.net>
Subject: [RFC PATCH mptcp-next v8 1/7] add mptcp_stream_connect to protocol.h
Date: Tue, 20 Sep 2022 14:52:37 +0200
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

In the following patches we will call mptcp_stream_connect() from
function tcp_sendmsg_fastopen() in file "net/ipv4/tcp.c", thus make
such symbol visible.

Signed-off-by: Dmytro Shytyi <dmytro@shytyi.net>
---
 net/mptcp/protocol.c | 4 ++--
 net/mptcp/protocol.h | 1 +
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index c0bf48e3149b..470045793181 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3484,8 +3484,8 @@ static void mptcp_subflow_early_fallback(struct mptcp=
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
index 93c535440a5c..632161b13950 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -837,6 +837,7 @@ void mptcp_event(enum mptcp_event_type type, const stru=
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


