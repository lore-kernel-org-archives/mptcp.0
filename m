Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A6A036AED
	for <mptcp@lists.linux.dev>; Wed,  8 Nov 2023 18:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hh9zVSF9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699468014;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=hc6/19TLhX/F0guKEHUVljK1EXhMSFQPgZsotRD7eac=;
	b=hh9zVSF9kufnGdazXH7jWPfr/cDkm1zkQ0wUYkkNF5/hlz9h9+aA21XJu4npSZmp0eSH4U
	C7IwV9R/Vo0kNZsgW0CVmI+Dmep/sDgx+A7fx01ueqf6CLMhinWt3sL8cAxBk9srPacHn7
	TgdCgKtk2yR+Tcm1sWCQubaTY7ZWh3w=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-398-VU01UX36Me2KXMNf4Srtng-1; Wed,
 08 Nov 2023 13:26:52 -0500
X-MC-Unique: VU01UX36Me2KXMNf4Srtng-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6350E280FEC3
	for <mptcp@lists.linux.dev>; Wed,  8 Nov 2023 18:26:52 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.225.137])
	by smtp.corp.redhat.com (Postfix) with ESMTP id E63D925C1
	for <mptcp@lists.linux.dev>; Wed,  8 Nov 2023 18:26:51 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-net] mptcp: fix setsockopt(IP_TOS) subflow locking
Date: Wed,  8 Nov 2023 19:26:47 +0100
Message-ID: <f2cf8a00fdf178f314b92c8809ca9deed98464fa.1699466615.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

The mptcp implementation of the IP_TOS socket option uses the lockless
variant of the TOS manipulation helper and does not hold suck lock at
the helper invocation time.

Add the required locking.

Fixes: ffcacff87cd6 ("mptcp: Support for IP_TOS for MPTCP setsockopt()")
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/457
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/sockopt.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index 8d485c40585a..cabe856b2a45 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -738,8 +738,11 @@ static int mptcp_setsockopt_v4_set_tos(struct mptcp_sock *msk, int optname,
 	val = READ_ONCE(inet_sk(sk)->tos);
 	mptcp_for_each_subflow(msk, subflow) {
 		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
+		bool slow;
 
+		slow = lock_sock_fast(ssk);
 		__ip_sock_set_tos(ssk, val);
+		unlock_sock_fast(ssk, slow);
 	}
 	release_sock(sk);
 
-- 
2.41.0

