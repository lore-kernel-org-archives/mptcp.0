Received: from sender11-of-o51.zoho.eu (sender11-of-o51.zoho.eu [31.186.226.237])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9BA35CA5
	for <mptcp@lists.linux.dev>; Sat, 17 Sep 2022 22:29:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1663453760; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=itcpAeE80FIJYwj5SB/rpDIbzmDCUArKcdB8G8ueS07C7lBCwa1LAI2mCwlPxwUh2yhVCKHN/HH1QSByRvm19bvNxqGxmJ9G/CEHrrEZhEmbgJ3MTgZ4T2k5ao1URxNjF+VQYGQWp46hnuolaRUN0T3Q/LIdP0UWtAHahLkQZkc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1663453760; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
	bh=7IYuOTC/csJn4GK6bWNW85nwG5yGcE+PlbLHcHsmsH0=; 
	b=a1wm9IlSysrnJOmgHrq1XthFkv4NhaiTa9NujOQtiGJp+oYL9ELF5/rzMduv2uepddhZibC5nF4waEToyfuMCx9Gj7PmBBkqE2WFPep0jFXnDXtOMf/tdmtM5v7sQCm4Q7igyz5gh7XMq81qCNMBmyMpz+xuhkOY4j9vVD9jyl8=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=shytyi.net;
	spf=pass  smtp.mailfrom=dmytro@shytyi.net;
	dmarc=pass header.from=<dmytro@shytyi.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1663453760;
	s=hs; d=shytyi.net; i=dmytro@shytyi.net;
	h=From:From:To:To:Cc:Cc:Message-ID:Subject:Subject:Date:Date:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
	bh=7IYuOTC/csJn4GK6bWNW85nwG5yGcE+PlbLHcHsmsH0=;
	b=TbSkzJ5+5JKo8vm3sBgpg72u4GGHnMXzfBXt3gVh0yARm3O4FGz6+i1ZWaCotWVb
	c9kGBucCBx66oVa5Uv2IjJQFtMLdP5zaTpnHEHPbzg6bATd1u9AxNdVN6A8VuvNzurB
	C6STK2c+pSanlf4wUD4hn8t2CNDC4PHXURkhxHuI=
Received: from doris.localdomain (243.34.22.93.rev.sfr.net [93.22.34.243]) by mx.zoho.eu
	with SMTPS id 1663453758103740.42406034695; Sun, 18 Sep 2022 00:29:18 +0200 (CEST)
From: Dmytro Shytyi <dmytro@shytyi.net>
To: mptcp@lists.linux.dev
Cc: Dmytro Shytyi <dmytro@shytyi.net>
Message-ID: <20220917222853.2406-4-dmytro@shytyi.net>
Subject: [RFC PATCH mptcp-next v7 03/11] Initiator: MSG_FASTOPEN sendto(). request cookie
Date: Sun, 18 Sep 2022 00:28:45 +0200
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

Initiator: MSG_FASTOPEN in sendto triggers the mptcp_sendsmg_fastopen.
It requests a MPTFO cookie.
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
index 0e5db0a634d3..af99a03021c9 100644
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
index 1e21293bceaa..21f9bf6d2f7e 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -837,6 +837,12 @@ void mptcp_event_addr_removed(const struct mptcp_sock =
*msk, u8 id);
 bool mptcp_userspace_pm_active(const struct mptcp_sock *msk);
 int mptcp_stream_connect(struct socket *sock, struct sockaddr *uaddr, int =
addr_len, int flags);
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


