Received: from sender11-of-o51.zoho.eu (sender11-of-o51.zoho.eu [31.186.226.237])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7098C4684
	for <mptcp@lists.linux.dev>; Sun, 25 Sep 2022 23:26:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1664148370; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=ZjtaGueAHAuj/ZxVJvJSImUbkaIEYWSXBGS+oQiN6Mit1saT945IQ8H+VqiQ+eps/WD9qV/vnB6KejSbzJ/ELECKRPd42VBOvffiuBEXWzq+V+CrJniLKuZ5n5Mn0IQpwkdwn00l0s/kYiFSaj89mREHysheRwWZh6XKLNerNlo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1664148370; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
	bh=m5ozyr2RckgQ5NrtzpjNAamU9T+wocXkWjxuI7mu1x8=; 
	b=Cwi73t9gjwxrZnxT02NIwDSbfFkUjrwx7mdSjUd6qf5tlFKBhSRb1D9uMMLq+UVb5oBmQQBXuRDUqK860olom6Ja7DEiQiOj1rrcTLFyp927yDy5a9umvB2YtXGx4aMoneprtjtUxy74y+X5DfoBVxTquJT0kRGDaY32BpX5DYg=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=shytyi.net;
	spf=pass  smtp.mailfrom=dmytro@shytyi.net;
	dmarc=pass header.from=<dmytro@shytyi.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1664148370;
	s=hs; d=shytyi.net; i=dmytro@shytyi.net;
	h=From:From:To:To:Cc:Cc:Message-ID:Subject:Subject:Date:Date:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
	bh=m5ozyr2RckgQ5NrtzpjNAamU9T+wocXkWjxuI7mu1x8=;
	b=UVKK2taxEptzJeNjgwn9PNwvRJDmB62UVnWT59DezYzHy5zNvOeGyEQijkxulgl5
	xWyvkRFjGD4DtcVORe9/9pbFiwPbp/+3r+4Yis+PDWgMEAi6WzfHXqno/0tDysQMvgE
	osrJnaBDWXc2F1LeBo/qdFXOaS5P9ID13yZJvd4k=
Received: from doris.localdomain (243.34.22.93.rev.sfr.net [93.22.34.243]) by mx.zoho.eu
	with SMTPS id 1664148369123871.0247626027892; Mon, 26 Sep 2022 01:26:09 +0200 (CEST)
From: Dmytro Shytyi <dmytro@shytyi.net>
To: mptcp@lists.linux.dev
Cc: Dmytro Shytyi <dmytro@shytyi.net>
Message-ID: <20220925232601.25252-3-dmytro@shytyi.net>
Subject: [RFC PATCH mptcp-next v11 2/4] mptcp: add mptcp_stream_connect to *.h
Date: Mon, 26 Sep 2022 01:25:59 +0200
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220925232601.25252-1-dmytro@shytyi.net>
References: <20220925232601.25252-1-dmytro@shytyi.net>
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
 include/net/mptcp.h  | 8 ++++++++
 net/mptcp/protocol.c | 4 ++--
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index c25939b2af68..d9908b839059 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -150,6 +150,7 @@ void mptcp_write_options(struct tcphdr *th, __be32 *ptr=
, struct tcp_sock *tp,
 =09=09=09 struct mptcp_out_options *opts);
=20
 void mptcp_diag_fill_info(struct mptcp_sock *msk, struct mptcp_info *info)=
;
+int mptcp_stream_connect(struct socket *sock, struct sockaddr *uaddr, int =
addr_len, int flags);
=20
 /* move the skb extension owership, with the assumption that 'to' is
  * newly allocated
@@ -286,6 +287,13 @@ static inline bool mptcp_skb_can_collapse(const struct=
 sk_buff *to,
=20
 static inline void mptcp_space(const struct sock *ssk, int *s, int *fs) { =
}
 static inline void mptcp_seq_show(struct seq_file *seq) { }
+static inline int mptcp_stream_connect(struct socket *sock,
+=09=09=09=09       struct sockaddr *uaddr,
+=09=09=09=09       int addr_len,
+=09=09=09=09       int flags)
+{
+
+}
=20
 static inline int mptcp_subflow_init_cookie_req(struct request_sock *req,
 =09=09=09=09=09=09const struct sock *sk_listener,
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 7d4e197ec567..c39ed726c1c0 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3543,8 +3543,8 @@ static void mptcp_subflow_early_fallback(struct mptcp=
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
--=20
2.25.1


