Received: from sender11-of-o51.zoho.eu (sender11-of-o51.zoho.eu [31.186.226.237])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40E5B6712
	for <mptcp@lists.linux.dev>; Thu, 15 Sep 2022 23:56:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1663286186; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=XftBtHEApY6XMQLIdwqVbinzxh34JeWNwUn08qSmHwWUDOFdUUaEEZGo19V2Q3gKNJityUD/pHLSzhPT6sbupCnrvVk4lyU0bv5+UHSq0UkqaQ7kBoXyXDCjOOJ0X6JeK3AzvNjpNFUSAb3Iajq+IXOP/eRydo9agiMNWlmAIF0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1663286186; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
	bh=nJx9T7UcYHoYNb+qgpWl9AFqIl7y/SRTGdgCMh6o250=; 
	b=b1sCPqwmrTH1YbDcmUjN0+eZ9NQ+Ild3nNc9Fjp028oYtkKMrsIDkSZ6Qq6CMt4ldm3tAYJmm1VUXLzzZflDeMi9b+SNl7OPOj8k0DBOMnVqB7a+mpwBLJR+DQjZ/zDoK7EUaa4CQBBrtlv+588fUdgcCM3mPZwPzhKWPIoql00=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=shytyi.net;
	spf=pass  smtp.mailfrom=dmytro@shytyi.net;
	dmarc=pass header.from=<dmytro@shytyi.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1663286186;
	s=hs; d=shytyi.net; i=dmytro@shytyi.net;
	h=From:From:To:To:Cc:Cc:Message-ID:Subject:Subject:Date:Date:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
	bh=nJx9T7UcYHoYNb+qgpWl9AFqIl7y/SRTGdgCMh6o250=;
	b=hHGfEY8DJT1TvwBILYLD/kpf2hHapYSrUbz8Fso2KldiMazKPv92dHzYDhYPI1aE
	AICvsc4cR9t8y9vaDgXlzXcACv3X8TCywulXB2Nz1UNcRUlUnxiHmDyFp/KLyNRoVCW
	Qvk2GRpe+CL57EDLay0tTHArLgisIjNiTfwBfp9Q=
Received: from doris.localdomain (243.34.22.93.rev.sfr.net [93.22.34.243]) by mx.zoho.eu
	with SMTPS id 1663286184373652.6967180822953; Fri, 16 Sep 2022 01:56:24 +0200 (CEST)
From: Dmytro Shytyi <dmytro@shytyi.net>
To: mptcp@lists.linux.dev
Cc: Dmytro Shytyi <dmytro@shytyi.net>
Message-ID: <20220915235604.26018-3-dmytro@shytyi.net>
Subject: [RFC PATCH mptcp-next v6 2/9] Initiator: MSG_FASTOPEN sendto(). request cookie
Date: Fri, 16 Sep 2022 01:55:57 +0200
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

Initiator: MSG_FASTOPEN in sendto triggers the mptcp_sendsmg_fastopen.
It requests a MPTFO cookie.=20
Suggestion @palbeni(JAN 17): 'split the patch in several small one'.

Signed-off-by: Dmytro Shytyi <dmytro@shytyi.net>
---
 net/mptcp/fastopen.c | 50 ++++++++++++++++++++++++++++++++++++++++++++
 net/mptcp/protocol.c |  4 ++--
 net/mptcp/protocol.h |  6 ++++++
 3 files changed, 58 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/fastopen.c b/net/mptcp/fastopen.c
index 0c9ef6f5d528..9974508e0f4c 100644
--- a/net/mptcp/fastopen.c
+++ b/net/mptcp/fastopen.c
@@ -3,3 +3,53 @@
  */
=20
 #include "protocol.h"
+
+int mptcp_sendmsg_fastopen(struct sock *sk, struct msghdr *msg,
+=09=09=09   size_t len, struct mptcp_sock *msk,
+=09=09=09   size_t *copied)
+{
+=09const struct iphdr *iph;
+=09struct ubuf_info *uarg;
+=09struct sockaddr *uaddr;
+=09struct sk_buff *skb;
+=09struct tcp_sock *tp;
+=09struct socket *ssk;
+=09int ret;
+
+=09ssk =3D __mptcp_nmpc_socket(msk);
+=09if (unlikely(!ssk))
+=09=09goto out_EFAULT;
+=09skb =3D tcp_stream_alloc_skb(ssk->sk, 0, ssk->sk->sk_allocation, true);
+=09if (unlikely(!skb))
+=09=09goto out_EFAULT;
+=09iph =3D ip_hdr(skb);
+=09if (unlikely(!iph))
+=09=09goto out_EFAULT;
+=09uarg =3D msg_zerocopy_realloc(sk, len, skb_zcopy(skb));
+=09if (unlikely(!uarg))
+=09=09goto out_EFAULT;
+=09uaddr =3D msg->msg_name;
+
+=09tp =3D tcp_sk(ssk->sk);
+=09if (unlikely(!tp))
+=09=09goto out_EFAULT;
+=09if (!tp->fastopen_req)
+=09=09tp->fastopen_req =3D kzalloc(sizeof(*tp->fastopen_req),
+=09=09=09=09=09   ssk->sk->sk_allocation);
+
+=09if (unlikely(!tp->fastopen_req))
+=09=09goto out_EFAULT;
+=09tp->fastopen_req->data =3D msg;
+=09tp->fastopen_req->size =3D len;
+=09tp->fastopen_req->uarg =3D uarg;
+
+=09/* requests a cookie */
+=09ret =3D mptcp_stream_connect(sk->sk_socket, uaddr,
+=09=09=09=09   msg->msg_namelen, msg->msg_flags);
+=09if (!ret)
+=09=09*copied =3D len;
+=09return ret;
+out_EFAULT:
+=09ret =3D -EFAULT;
+=09return ret;
+}
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 55442df8fb97..6bbf1b86465d 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1672,9 +1672,9 @@ static int mptcp_sendmsg(struct sock *sk, struct msgh=
dr *msg, size_t len)
 =09int ret =3D 0;
 =09long timeo;
=20
-=09/* we don't support FASTOPEN yet */
+=09/* we don't fully support FASTOPEN yet */
 =09if (msg->msg_flags & MSG_FASTOPEN)
-=09=09return -EOPNOTSUPP;
+=09=09ret =3D mptcp_sendmsg_fastopen(sk, msg, len, msk, &copied);
=20
 =09/* silently ignore everything else */
 =09msg->msg_flags &=3D MSG_MORE | MSG_DONTWAIT | MSG_NOSIGNAL;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 1bc9f6e77ddd..ad51910f1cc9 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -836,6 +836,12 @@ void mptcp_event_addr_announced(const struct sock *ssk=
, const struct mptcp_addr_
 void mptcp_event_addr_removed(const struct mptcp_sock *msk, u8 id);
 bool mptcp_userspace_pm_active(const struct mptcp_sock *msk);
=20
+// Fast Open Mechanism functions begin
+int mptcp_sendmsg_fastopen(struct sock *sk, struct msghdr *msg,
+=09=09=09   size_t len, struct mptcp_sock *msk,
+=09=09=09   size_t *copied);
+// Fast Open Mechanism functions end
+
 static inline bool mptcp_pm_should_add_signal(struct mptcp_sock *msk)
 {
 =09return READ_ONCE(msk->pm.addr_signal) &
--=20
2.25.1


