Received: from sender11-of-o51.zoho.eu (sender11-of-o51.zoho.eu [31.186.226.237])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C30A33D2
	for <mptcp@lists.linux.dev>; Wed, 21 Sep 2022 12:56:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1663764964; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=IthWvBJktwbeKBbY4Ev4qUiK/OnI5hOea9pcTrdKjeYL2JerXN0h58libu+rbiTZtotlgI9EIru2bA+OxBh3i8QaNPEks44XXAPn5dFXc/PiwutOkEl/M4TxJEBExMet340/X6UMP2agVvL8y1Z7BGa8Kg4rCx/SioGHST7wrFM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1663764964; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
	bh=4rVkQa3qMMUlSRfyOKnPoxRWIYdOpkQv2kjbajFkgxY=; 
	b=ejn1mcJnfuN8uYUKAsI1cx6PQqDu/QPs8OyZZI4wNQRvVtS+mfbR/PUPUgjqB7NmJJacODxRkqVzW9Niiivf68tviVHeaZfLh3X0pkGzQbJfGT8nZmX/AsXFwbPbllywo2qLknnUuezjm4frHNayqF5r+kwSwD6g2stIzEbG5GM=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=shytyi.net;
	spf=pass  smtp.mailfrom=dmytro@shytyi.net;
	dmarc=pass header.from=<dmytro@shytyi.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1663764964;
	s=hs; d=shytyi.net; i=dmytro@shytyi.net;
	h=From:From:To:To:Cc:Cc:Message-ID:Subject:Subject:Date:Date:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
	bh=4rVkQa3qMMUlSRfyOKnPoxRWIYdOpkQv2kjbajFkgxY=;
	b=XwKskZ5PUENRgeK4snDwFVIIigXC2S7nZrwpQqrPWTPJqWGX4bvnX7CMAbkwjMNc
	98gB49mAPQK65x0TqKi9EYKiWPWbBdsK8uEciHt40pl4osS5olJYKvNfCzmjHWZPgSK
	6aYjVnV+MowYb9qwBJhjkq3A4wL0G7E+sp5jNoEE=
Received: from doris.localdomain (243.34.22.93.rev.sfr.net [93.22.34.243]) by mx.zoho.eu
	with SMTPS id 1663764962725995.374396107438; Wed, 21 Sep 2022 14:56:02 +0200 (CEST)
From: Dmytro Shytyi <dmytro@shytyi.net>
To: mptcp@lists.linux.dev
Cc: Dmytro Shytyi <dmytro@shytyi.net>
Message-ID: <20220921125558.19483-2-dmytro@shytyi.net>
Subject: [RFC PATCH mptcp-next v9 1/6] mptcp: add mptcp_stream_connect to protocol.h
Date: Wed, 21 Sep 2022 14:55:53 +0200
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220921125558.19483-1-dmytro@shytyi.net>
References: <20220921125558.19483-1-dmytro@shytyi.net>
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


