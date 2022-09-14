Received: from sender11-of-o51.zoho.eu (sender11-of-o51.zoho.eu [31.186.226.237])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7BA43D6D
	for <mptcp@lists.linux.dev>; Wed, 14 Sep 2022 11:32:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1663155123; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=S2lIuyGT8b/Vyo97Lvk4EdWgQSFgPwC1NPJNHMArAQRYVI8b09jA/1D2HVykSMMcLBDSq+yo6yhO+HvyVTmOJvDTT+lCXUDnS4sZCjZGttK4uZQHs6q1s+zPnA4WXforQzgy3AnAEXSFEFT53LjomwKFgq94AsMfvt5xB6ryA5g=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1663155123; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
	bh=2Q+WmU1jKq/6TkuklPgw6DAxH8Cd/PhhA0+xImf0+5o=; 
	b=HTL/lAS05xMJJ9CENF66171+giGQBmFP5M6yQYso0VGZ9eFIVtAQW/rMN4mljTJupL4bvLQNEH5BkEyJoAn6NtnkekYwmqFnY2wQns/Bztqak8v2YNoKSwLmsZynpwRRzfmPCbX/spWohFgR0KcTPjc0v8HCSWdTVNsEbpFGOG8=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=shytyi.net;
	spf=pass  smtp.mailfrom=dmytro@shytyi.net;
	dmarc=pass header.from=<dmytro@shytyi.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1663155123;
	s=hs; d=shytyi.net; i=dmytro@shytyi.net;
	h=From:From:To:To:Cc:Cc:Message-ID:Subject:Subject:Date:Date:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
	bh=2Q+WmU1jKq/6TkuklPgw6DAxH8Cd/PhhA0+xImf0+5o=;
	b=S0dciJ24ur/NyapurT+DMwEglm/OUAu7dIACTTM/mOiUpa7UZcczWIdTtbYfq0Gg
	5QMrXKKHh7gF2+a4NyuC4hde91FwgsbLpVTXtfT75D+QIbKvGToNY6k6/oc6rqGslmU
	Uw7wBQFeeSmIRHV2Z8SVOCK0/iz+S9pQnu7ENqus=
Received: from doris.localdomain (243.34.22.93.rev.sfr.net [93.22.34.243]) by mx.zoho.eu
	with SMTPS id 1663155121220674.4300355826497; Wed, 14 Sep 2022 13:32:01 +0200 (CEST)
From: Dmytro Shytyi <dmytro@shytyi.net>
To: mptcp@lists.linux.dev
Cc: Dmytro Shytyi <dmytro@shytyi.net>
Message-ID: <20220914113151.9898-3-dmytro@shytyi.net>
Subject: [RFC PATCH mptcp-next v5 03/10] Initiator: mptcp_sendmsg_fastopen. Usage of lock_sock() / release_sock() leads to hangup'
Date: Wed, 14 Sep 2022 13:31:44 +0200
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

Initiator: mptcp_sendmsg_fastopen. Usage of=20
lock_sock() / release_sock() leads to hangup'

Signed-off-by: Dmytro Shytyi <dmytro@shytyi.net>
---
 net/mptcp/fastopen.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/mptcp/fastopen.c b/net/mptcp/fastopen.c
index 9974508e0f4c..0e071c988894 100644
--- a/net/mptcp/fastopen.c
+++ b/net/mptcp/fastopen.c
@@ -49,6 +49,7 @@ int mptcp_sendmsg_fastopen(struct sock *sk, struct msghdr=
 *msg,
 =09if (!ret)
 =09=09*copied =3D len;
 =09return ret;
+
 out_EFAULT:
 =09ret =3D -EFAULT;
 =09return ret;
--=20
2.25.1


