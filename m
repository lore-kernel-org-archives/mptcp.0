Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F2780C
	for <mptcp@lists.linux.dev>; Mon, 10 Jul 2023 12:55:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1688993733;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=joBGKcUdoUahqUpfr7bFbYlaoHLCEnUeJd+IkRK8ZAY=;
	b=RhAoI8SWwa8L02j5KRgq7lwm+zT70YFxr1oeQpSlr5XRglWF5caqCt6LSzkE0akR4ADbyy
	tDvlnT2oMH19kJhbpiioI4i88oB74BR88b1pHZ03gfnfNUecK5bW+8M6pZPfvNfY8014kH
	vaKMjp1hHw7GibEtPm6Ad1lfv4ce+40=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-128-xHs5OYF0PEedUObDGXCX_Q-1; Mon, 10 Jul 2023 08:55:31 -0400
X-MC-Unique: xHs5OYF0PEedUObDGXCX_Q-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A95BB908301
	for <mptcp@lists.linux.dev>; Mon, 10 Jul 2023 12:55:31 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.225.74])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 38AA1C09A09
	for <mptcp@lists.linux.dev>; Mon, 10 Jul 2023 12:55:31 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next 12/14] mptcp: avoid ssock usage in mptcp_pm_nl_create_listen_socket()
Date: Mon, 10 Jul 2023 14:55:07 +0200
Message-ID: <e029c254ad8010a8cf038b675b0fc066190947a4.1688993569.git.pabeni@redhat.com>
In-Reply-To: <cover.1688993569.git.pabeni@redhat.com>
References: <cover.1688993569.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

This is one of the few remaining spots actually manipulating the
first subflow socket. We can leverage the recently introduced
inet helpers to get rid of ssock there.

No functional changes intended.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/pm_netlink.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 3be32f134d2a..b939e442477a 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -9,6 +9,7 @@
 #include <linux/inet.h>
 #include <linux/kernel.h>
 #include <net/tcp.h>
+#include <net/inet_common.h>
 #include <net/netns/generic.h>
 #include <net/mptcp.h>
 #include <net/genetlink.h>
@@ -1002,8 +1003,8 @@ static int mptcp_pm_nl_create_listen_socket(struct sock *sk,
 	bool is_ipv6 = sk->sk_family == AF_INET6;
 	int addrlen = sizeof(struct sockaddr_in);
 	struct sockaddr_storage addr;
+	struct sock *newsk, *ssk;
 	struct socket *ssock;
-	struct sock *newsk;
 	int backlog = 1024;
 	int err;
 
@@ -1039,18 +1040,23 @@ static int mptcp_pm_nl_create_listen_socket(struct sock *sk,
 	if (entry->addr.family == AF_INET6)
 		addrlen = sizeof(struct sockaddr_in6);
 #endif
-	err = kernel_bind(ssock, (struct sockaddr *)&addr, addrlen);
+	ssk = mptcp_sk(newsk)->first;
+	if (ssk->sk_family == AF_INET)
+		err = inet_bind_sk(ssk, (struct sockaddr *)&addr, addrlen);
+#if IS_ENABLED(CONFIG_MPTCP_IPV6)
+	else if (ssk->sk_family == AF_INET6)
+		err = inet6_bind_sk(ssk, (struct sockaddr *)&addr, addrlen);
+#endif
 	if (err)
 		return err;
 
 	inet_sk_state_store(newsk, TCP_LISTEN);
-	err = kernel_listen(ssock, backlog);
-	if (err)
-		return err;
-
-	mptcp_event_pm_listener(ssock->sk, MPTCP_EVENT_LISTENER_CREATED);
-
-	return 0;
+	lock_sock(ssk);
+	err = __inet_listen_sk(ssk, backlog);
+	if (!err)
+		mptcp_event_pm_listener(ssk, MPTCP_EVENT_LISTENER_CREATED);
+	release_sock(ssk);
+	return err;
 }
 
 int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk, struct mptcp_addr_info *skc)
-- 
2.41.0

