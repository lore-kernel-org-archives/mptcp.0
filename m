Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [216.205.24.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 134D02C81
	for <mptcp@lists.linux.dev>; Fri, 15 Oct 2021 09:26:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1634289959;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9CfqUPu7O1w8W4v6WD5zHDCxWC8uPzyP6pFLYQwAak8=;
	b=QsT7taihAY+93tiNUieo0pxKHQy3oa/1IoAhHLNLPiLVe3e8iK/rK6iSjbozOUosGuhiXG
	c2w1HwlmCkLCIW1rlYPItTrRp/e08Tbq5r9TbZisDYPbKHfU5vX9gESpg0sFRoVfXCga/n
	KWeoAN9o5lTVm9D7j7VQKB/hDsaNAqg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-551-XWY17dKNOUKGkE9uZC2C-Q-1; Fri, 15 Oct 2021 05:25:45 -0400
X-MC-Unique: XWY17dKNOUKGkE9uZC2C-Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E2D2B18358EF
	for <mptcp@lists.linux.dev>; Fri, 15 Oct 2021 09:25:44 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.192.85])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 56DD35F4E3
	for <mptcp@lists.linux.dev>; Fri, 15 Oct 2021 09:25:44 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next 2/3] net: introduce sk_forward_alloc_get()
Date: Fri, 15 Oct 2021 11:25:24 +0200
Message-Id: <944348e29bd564a3e45d7ab6683c4e64ef48aec1.1634289695.git.pabeni@redhat.com>
In-Reply-To: <cover.1634289695.git.pabeni@redhat.com>
References: <cover.1634289695.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"

A later patch will change the mptcp memory accounting schema
in such a way that MPTCP sockets will encode total amount of
forward allocated memory in two separate fields (one for tx
 and one for rx).

MPTCP sockets will use their own helper to provide the accurate
amount of fwd alloced memory.

To allow the above, this patch adds a new, optional, sk method to
fetch the fwd memory, wrap the call in a new helper and use it
where apprioriate.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
This schema was suggested long time ago by Eric in a completely
different context:

https://marc.info/?l=linux-netdev&m=147516056204838&w=2

I'm unsure if that is still applicable/valid.
---
 include/net/sock.h   | 11 +++++++++++
 net/ipv4/af_inet.c   |  2 +-
 net/ipv4/inet_diag.c |  2 +-
 net/sched/em_meta.c  |  2 +-
 4 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/include/net/sock.h b/include/net/sock.h
index 9c5d0502090f..86ea60df6e84 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -1205,6 +1205,8 @@ struct proto {
 	unsigned int		inuse_idx;
 #endif
 
+	int			(*forward_alloc_get)(const struct sock *sk);
+
 	bool			(*stream_memory_free)(const struct sock *sk, int wake);
 	bool			(*stream_memory_read)(const struct sock *sk);
 	/* Memory pressure */
@@ -1212,6 +1214,7 @@ struct proto {
 	void			(*leave_memory_pressure)(struct sock *sk);
 	atomic_long_t		*memory_allocated;	/* Current allocated memory. */
 	struct percpu_counter	*sockets_allocated;	/* Current number of sockets. */
+
 	/*
 	 * Pressure flag: try to collapse.
 	 * Technical note: it is used by multiple contexts non atomically.
@@ -1289,6 +1292,14 @@ static inline void sk_refcnt_debug_release(const struct sock *sk)
 
 INDIRECT_CALLABLE_DECLARE(bool tcp_stream_memory_free(const struct sock *sk, int wake));
 
+static inline int sk_forward_alloc_get(const struct sock *sk)
+{
+	if (!sk->sk_prot->forward_alloc_get)
+		return sk->sk_forward_alloc;
+
+	return sk->sk_prot->forward_alloc_get(sk);
+}
+
 static inline bool __sk_stream_memory_free(const struct sock *sk, int wake)
 {
 	if (READ_ONCE(sk->sk_wmem_queued) >= READ_ONCE(sk->sk_sndbuf))
diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
index 37e69fd9246c..55f862abe811 100644
--- a/net/ipv4/af_inet.c
+++ b/net/ipv4/af_inet.c
@@ -150,7 +150,7 @@ void inet_sock_destruct(struct sock *sk)
 	WARN_ON(atomic_read(&sk->sk_rmem_alloc));
 	WARN_ON(refcount_read(&sk->sk_wmem_alloc));
 	WARN_ON(sk->sk_wmem_queued);
-	WARN_ON(sk->sk_forward_alloc);
+	WARN_ON(sk_forward_alloc_get(sk));
 
 	kfree(rcu_dereference_protected(inet->inet_opt, 1));
 	dst_release(rcu_dereference_protected(sk->sk_dst_cache, 1));
diff --git a/net/ipv4/inet_diag.c b/net/ipv4/inet_diag.c
index ef7897226f08..c8fa6e7f7d12 100644
--- a/net/ipv4/inet_diag.c
+++ b/net/ipv4/inet_diag.c
@@ -271,7 +271,7 @@ int inet_sk_diag_fill(struct sock *sk, struct inet_connection_sock *icsk,
 		struct inet_diag_meminfo minfo = {
 			.idiag_rmem = sk_rmem_alloc_get(sk),
 			.idiag_wmem = READ_ONCE(sk->sk_wmem_queued),
-			.idiag_fmem = sk->sk_forward_alloc,
+			.idiag_fmem = sk_forward_alloc_get(sk),
 			.idiag_tmem = sk_wmem_alloc_get(sk),
 		};
 
diff --git a/net/sched/em_meta.c b/net/sched/em_meta.c
index 46254968d390..0a04468b7314 100644
--- a/net/sched/em_meta.c
+++ b/net/sched/em_meta.c
@@ -457,7 +457,7 @@ META_COLLECTOR(int_sk_fwd_alloc)
 		*err = -1;
 		return;
 	}
-	dst->value = sk->sk_forward_alloc;
+	dst->value = sk_forward_alloc_get(sk);
 }
 
 META_COLLECTOR(int_sk_sndbuf)
-- 
2.26.3

