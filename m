Received: from sender11-of-o51.zoho.eu (sender11-of-o51.zoho.eu [31.186.226.237])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 852535CA6
	for <mptcp@lists.linux.dev>; Sat, 17 Sep 2022 22:29:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1663453760; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=MybpxLPW3aruFCqgsWr4V8zozzFCZi9+8ikHKGv/4qOuTqd/x8tmlyI1X5KdD3crApG2i+vrl1vsmDy1IXV5jVEmtZJ00rhPTw04QbUSi+Pvq7U6p0+m5sA0q1TOr7Dmuu/gCfOKNL6IX3UlFICou4DqJXePhKbBoYqOKbsOue4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1663453760; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
	bh=PdOfAx87hUidcxyexSbnMCRoaRxCRRCf+MrLYZHkhkQ=; 
	b=QkpqXl4NYfYVdKTjxX4e7dvZBIe3uIhF6B2lqA3V5HewOqRQSzVvuu6c4i+Bekv0yHHKvSC+4UuhfMiing8X5f5caR4iwMhdzfrTKffEWbetZWO2s9FH//azklUvh2Vol4x7OqGq+2I9+bTnrWwT258muqzwWz+Pewt1Nl1jJSU=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=shytyi.net;
	spf=pass  smtp.mailfrom=dmytro@shytyi.net;
	dmarc=pass header.from=<dmytro@shytyi.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1663453760;
	s=hs; d=shytyi.net; i=dmytro@shytyi.net;
	h=From:From:To:To:Cc:Cc:Message-ID:Subject:Subject:Date:Date:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
	bh=PdOfAx87hUidcxyexSbnMCRoaRxCRRCf+MrLYZHkhkQ=;
	b=TrugaokDLbMM9E98JLViOqmXBy49GZp21ENWJe3q4X/DW8OD/DrnWrTaq4qEOzAD
	fZsdJ+YxstfYGU9BqrnqSgldNb/ckzl2LZVcZQqaywMg87vSJCdi/SdvCDap/hcOtuw
	ewJScKHrBh9mptgBpNhX/Pe01U8uY6xk2PzpK7Pc=
Received: from doris.localdomain (243.34.22.93.rev.sfr.net [93.22.34.243]) by mx.zoho.eu
	with SMTPS id 1663453758548401.1813275717594; Sun, 18 Sep 2022 00:29:18 +0200 (CEST)
From: Dmytro Shytyi <dmytro@shytyi.net>
To: mptcp@lists.linux.dev
Cc: Dmytro Shytyi <dmytro@shytyi.net>
Message-ID: <20220917222853.2406-6-dmytro@shytyi.net>
Subject: [RFC PATCH mptcp-next v7 05/11] Initiator: add locks() to mptcp_sendmsg_fastopen.
Date: Sun, 18 Sep 2022 00:28:47 +0200
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

Suggestion of @mmartineau : 'add locks' is implemented in this patch

Signed-off-by: Dmytro Shytyi <dmytro@shytyi.net>
---
 net/mptcp/fastopen.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/fastopen.c b/net/mptcp/fastopen.c
index 9974508e0f4c..50b5c3376672 100644
--- a/net/mptcp/fastopen.c
+++ b/net/mptcp/fastopen.c
@@ -16,6 +16,7 @@ int mptcp_sendmsg_fastopen(struct sock *sk, struct msghdr=
 *msg,
 =09struct socket *ssk;
 =09int ret;
=20
+=09lock_sock((struct sock *)msk);
 =09ssk =3D __mptcp_nmpc_socket(msk);
 =09if (unlikely(!ssk))
 =09=09goto out_EFAULT;
@@ -30,26 +31,35 @@ int mptcp_sendmsg_fastopen(struct sock *sk, struct msgh=
dr *msg,
 =09=09goto out_EFAULT;
 =09uaddr =3D msg->msg_name;
=20
+=09lock_sock(ssk->sk);
+
 =09tp =3D tcp_sk(ssk->sk);
 =09if (unlikely(!tp))
-=09=09goto out_EFAULT;
+=09=09goto out_lock_EFAULT;
 =09if (!tp->fastopen_req)
 =09=09tp->fastopen_req =3D kzalloc(sizeof(*tp->fastopen_req),
 =09=09=09=09=09   ssk->sk->sk_allocation);
=20
 =09if (unlikely(!tp->fastopen_req))
-=09=09goto out_EFAULT;
+=09=09goto out_lock_EFAULT;
 =09tp->fastopen_req->data =3D msg;
 =09tp->fastopen_req->size =3D len;
 =09tp->fastopen_req->uarg =3D uarg;
=20
+=09release_sock(ssk->sk);
+=09release_sock((struct sock *)msk);
+
 =09/* requests a cookie */
 =09ret =3D mptcp_stream_connect(sk->sk_socket, uaddr,
 =09=09=09=09   msg->msg_namelen, msg->msg_flags);
 =09if (!ret)
 =09=09*copied =3D len;
 =09return ret;
+
+out_lock_EFAULT:
+=09release_sock(ssk->sk);
 out_EFAULT:
+=09release_sock((struct sock *)msk);
 =09ret =3D -EFAULT;
 =09return ret;
 }
--=20
2.25.1


