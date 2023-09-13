Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79D54200DE
	for <mptcp@lists.linux.dev>; Wed, 13 Sep 2023 21:05:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1694639111;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aEVBOaAzEqajZTBC12YcikiwAQ8spCarEy0dLAtSHWI=;
	b=WmRu54aGVO2cTIZo8eR23uP6fZt+m/trk0Xi/7GGsr3tgLo272vJV+8HGgDOZgm73ykBAk
	AHMBXdLhtfeRRI3wnoujCrsPETcwnPZQzCDnvuTBDHowtDT0YBD4hznGTMXhPth1bbr9Ax
	jcikz4zDXLDI+5CKmx2T5ztDVM1Uqm4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-608-r7RA0mzjPlmqIf-MelGtYQ-1; Wed, 13 Sep 2023 17:05:10 -0400
X-MC-Unique: r7RA0mzjPlmqIf-MelGtYQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BFE8C185A79B
	for <mptcp@lists.linux.dev>; Wed, 13 Sep 2023 21:05:09 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.33])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 4DB947B62
	for <mptcp@lists.linux.dev>; Wed, 13 Sep 2023 21:05:09 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next 1/3] mptcp: consolidate sockopt synchronization
Date: Wed, 13 Sep 2023 23:05:00 +0200
Message-ID: <9ad5120b406ac73ea2ca65de714966dafad3dc3c.1694638162.git.pabeni@redhat.com>
In-Reply-To: <cover.1694638162.git.pabeni@redhat.com>
References: <cover.1694638162.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

Move the socket option synchronization for active subflows
at subflow creation time. This allows removing the now unused
unlocked variant of such helper.

While at that, clean-up a bit the mptcp_subflow_create_socket()
errors path.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/protocol.c |  2 --
 net/mptcp/sockopt.c  | 22 ----------------------
 net/mptcp/subflow.c  | 18 +++++++++---------
 3 files changed, 9 insertions(+), 33 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 3facdc006adc..3a905c122306 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -121,8 +121,6 @@ struct sock *__mptcp_nmpc_sk(struct mptcp_sock *msk)
 		ret = __mptcp_socket_create(msk);
 		if (ret)
 			return ERR_PTR(ret);
-
-		mptcp_sockopt_sync(msk, msk->first);
 	}
 
 	return msk->first;
diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index 8260202c0066..f44b364b0055 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -1444,28 +1444,6 @@ static void sync_socket_options(struct mptcp_sock *msk, struct sock *ssk)
 	inet_assign_bit(FREEBIND, ssk, inet_test_bit(FREEBIND, sk));
 }
 
-static void __mptcp_sockopt_sync(struct mptcp_sock *msk, struct sock *ssk)
-{
-	bool slow = lock_sock_fast(ssk);
-
-	sync_socket_options(msk, ssk);
-
-	unlock_sock_fast(ssk, slow);
-}
-
-void mptcp_sockopt_sync(struct mptcp_sock *msk, struct sock *ssk)
-{
-	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
-
-	msk_owned_by_me(msk);
-
-	if (READ_ONCE(subflow->setsockopt_seq) != msk->setsockopt_seq) {
-		__mptcp_sockopt_sync(msk, ssk);
-
-		subflow->setsockopt_seq = msk->setsockopt_seq;
-	}
-}
-
 void mptcp_sockopt_sync_locked(struct mptcp_sock *msk, struct sock *ssk)
 {
 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 918c1a235790..1c7ff7247bc0 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1525,8 +1525,6 @@ int __mptcp_subflow_connect(struct sock *sk, const struct mptcp_addr_info *loc,
 	if (addr.ss_family == AF_INET6)
 		addrlen = sizeof(struct sockaddr_in6);
 #endif
-	mptcp_sockopt_sync(msk, ssk);
-
 	ssk->sk_bound_dev_if = ifindex;
 	err = kernel_bind(sf, (struct sockaddr *)&addr, addrlen);
 	if (err)
@@ -1637,7 +1635,7 @@ int mptcp_subflow_create_socket(struct sock *sk, unsigned short family,
 
 	err = security_mptcp_add_subflow(sk, sf->sk);
 	if (err)
-		goto release_ssk;
+		goto err_free;
 
 	/* the newly created socket has to be in the same cgroup as its parent */
 	mptcp_attach_cgroup(sk, sf->sk);
@@ -1651,15 +1649,12 @@ int mptcp_subflow_create_socket(struct sock *sk, unsigned short family,
 	get_net_track(net, &sf->sk->ns_tracker, GFP_KERNEL);
 	sock_inuse_add(net, 1);
 	err = tcp_set_ulp(sf->sk, "mptcp");
+	if (err)
+		goto err_free;
 
-release_ssk:
+	mptcp_sockopt_sync_locked(mptcp_sk(sk), sf->sk);
 	release_sock(sf->sk);
 
-	if (err) {
-		sock_release(sf);
-		return err;
-	}
-
 	/* the newly created socket really belongs to the owning MPTCP master
 	 * socket, even if for additional subflows the allocation is performed
 	 * by a kernel workqueue. Adjust inode references, so that the
@@ -1679,6 +1674,11 @@ int mptcp_subflow_create_socket(struct sock *sk, unsigned short family,
 	mptcp_subflow_ops_override(sf->sk);
 
 	return 0;
+
+err_free:
+	release_sock(sf->sk);
+	sock_release(sf);
+	return err;
 }
 
 static struct mptcp_subflow_context *subflow_create_ctx(struct sock *sk,
-- 
2.41.0

