Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBF741FF7A1
	for <mptcp@lists.linux.dev>; Fri,  6 Dec 2024 12:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733487083; cv=none; b=kGnvK/KsYXz8MFlpVPtehtyqWpQybivGoV1VKg6jFBbtPTssqmAmYqKkoxYMuhIB4PBxsncmLOfm+sXd9c+j0aeOusOmzb9PuZJZhmuYFCr06402kgzwLDPfIjT3pFgAthoEkgwyEVAG0xVHsaimV8qXLLNe6loEgT/IbT51wEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733487083; c=relaxed/simple;
	bh=OP2x2sT4/evFes6aikOpvmLL6ZF2P8+lSi+wylxgd6Y=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=oT6nMRn+Jy4kfBRl27EN9gOFH7vJYVUuflNIOhn+SQudX0CIcEo7+cJ7IZmsYs6+dgiriWePuBNdtHCbwK/NWhKfCPK2cgOCKr6JMyfQYnV6Pz62UOXWuEzj2lUztCLH9V/XrsmsSm7z1WUClUgFQBw4QaOxvb2cTeb8xhAy3/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MPd2kW+z; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MPd2kW+z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733487080;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lhRAL4quweAJyOzJHKhn3E8lg7d7AH45OOR5g93Eb/w=;
	b=MPd2kW+zh3k07gFyIobG40AvWw7WK9gI1rxQXShBzMNoxOaPGMSycWArBhFl0o40OMGSE5
	ApR7ahFWkHfnKwTITG4zRUCvwQgEefRoHFU2ThfxvdJt1zKgt0DyEpjoR/Uxr9N4RKiSp2
	Jnp/yTOahScUOGReZdtEBDurJf/FlBU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-38-uz6Pm4JENuiNZKIUouOXyg-1; Fri,
 06 Dec 2024 07:11:19 -0500
X-MC-Unique: uz6Pm4JENuiNZKIUouOXyg-1
X-Mimecast-MFC-AGG-ID: uz6Pm4JENuiNZKIUouOXyg
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B34E51956054
	for <mptcp@lists.linux.dev>; Fri,  6 Dec 2024 12:11:17 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.192.243])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E7B651956095
	for <mptcp@lists.linux.dev>; Fri,  6 Dec 2024 12:11:16 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next v2 7/7] net: dismiss sk_forward_alloc_get()
Date: Fri,  6 Dec 2024 13:11:14 +0100
Message-ID: <a0494d990134ce69459481c8d278695bcc86b48b.1733486870.git.pabeni@redhat.com>
In-Reply-To: <cover.1733486870.git.pabeni@redhat.com>
References: <cover.1733486870.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: iispmeqHp93JvUMGC_cLVWn3V0ESviRXyaev2-kAiqs_1733487077
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

After the previous patch we can remove the forward_alloc_get
proto callback, basically reverting commit 292e6077b040 ("net: introduce
sk_forward_alloc_get()") and commit 66d58f046c9d ("net: use
sk_forward_alloc_get() in sk_get_meminfo()").

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 include/net/sock.h   | 13 -------------
 net/core/sock.c      |  2 +-
 net/ipv4/af_inet.c   |  2 +-
 net/ipv4/inet_diag.c |  2 +-
 net/sched/em_meta.c  |  2 +-
 5 files changed, 4 insertions(+), 17 deletions(-)

diff --git a/include/net/sock.h b/include/net/sock.h
index 7464e9f9f47c..a5c28a4f0263 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -1283,10 +1283,6 @@ struct proto {
 	unsigned int		inuse_idx;
 #endif
 
-#if IS_ENABLED(CONFIG_MPTCP)
-	int			(*forward_alloc_get)(const struct sock *sk);
-#endif
-
 	bool			(*stream_memory_free)(const struct sock *sk, int wake);
 	bool			(*sock_is_readable)(struct sock *sk);
 	/* Memory pressure */
@@ -1347,15 +1343,6 @@ int sock_load_diag_module(int family, int protocol);
 
 INDIRECT_CALLABLE_DECLARE(bool tcp_stream_memory_free(const struct sock *sk, int wake));
 
-static inline int sk_forward_alloc_get(const struct sock *sk)
-{
-#if IS_ENABLED(CONFIG_MPTCP)
-	if (sk->sk_prot->forward_alloc_get)
-		return sk->sk_prot->forward_alloc_get(sk);
-#endif
-	return READ_ONCE(sk->sk_forward_alloc);
-}
-
 static inline bool __sk_stream_memory_free(const struct sock *sk, int wake)
 {
 	if (READ_ONCE(sk->sk_wmem_queued) >= READ_ONCE(sk->sk_sndbuf))
diff --git a/net/core/sock.c b/net/core/sock.c
index 74729d20cd00..06b732604bf2 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -3858,7 +3858,7 @@ void sk_get_meminfo(const struct sock *sk, u32 *mem)
 	mem[SK_MEMINFO_RCVBUF] = READ_ONCE(sk->sk_rcvbuf);
 	mem[SK_MEMINFO_WMEM_ALLOC] = sk_wmem_alloc_get(sk);
 	mem[SK_MEMINFO_SNDBUF] = READ_ONCE(sk->sk_sndbuf);
-	mem[SK_MEMINFO_FWD_ALLOC] = sk_forward_alloc_get(sk);
+	mem[SK_MEMINFO_FWD_ALLOC] = READ_ONCE(sk->sk_forward_alloc);
 	mem[SK_MEMINFO_WMEM_QUEUED] = READ_ONCE(sk->sk_wmem_queued);
 	mem[SK_MEMINFO_OPTMEM] = atomic_read(&sk->sk_omem_alloc);
 	mem[SK_MEMINFO_BACKLOG] = READ_ONCE(sk->sk_backlog.len);
diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
index 8095e82de808..a460ef3a2b0b 100644
--- a/net/ipv4/af_inet.c
+++ b/net/ipv4/af_inet.c
@@ -153,7 +153,7 @@ void inet_sock_destruct(struct sock *sk)
 	WARN_ON_ONCE(atomic_read(&sk->sk_rmem_alloc));
 	WARN_ON_ONCE(refcount_read(&sk->sk_wmem_alloc));
 	WARN_ON_ONCE(sk->sk_wmem_queued);
-	WARN_ON_ONCE(sk_forward_alloc_get(sk));
+	WARN_ON_ONCE(sk->sk_forward_alloc);
 
 	kfree(rcu_dereference_protected(inet->inet_opt, 1));
 	dst_release(rcu_dereference_protected(sk->sk_dst_cache, 1));
diff --git a/net/ipv4/inet_diag.c b/net/ipv4/inet_diag.c
index 321acc8abf17..efe2a085cf68 100644
--- a/net/ipv4/inet_diag.c
+++ b/net/ipv4/inet_diag.c
@@ -282,7 +282,7 @@ int inet_sk_diag_fill(struct sock *sk, struct inet_connection_sock *icsk,
 		struct inet_diag_meminfo minfo = {
 			.idiag_rmem = sk_rmem_alloc_get(sk),
 			.idiag_wmem = READ_ONCE(sk->sk_wmem_queued),
-			.idiag_fmem = sk_forward_alloc_get(sk),
+			.idiag_fmem = READ_ONCE(sk->sk_forward_alloc),
 			.idiag_tmem = sk_wmem_alloc_get(sk),
 		};
 
diff --git a/net/sched/em_meta.c b/net/sched/em_meta.c
index 8996c73c9779..3f2e707a11d1 100644
--- a/net/sched/em_meta.c
+++ b/net/sched/em_meta.c
@@ -460,7 +460,7 @@ META_COLLECTOR(int_sk_fwd_alloc)
 		*err = -1;
 		return;
 	}
-	dst->value = sk_forward_alloc_get(sk);
+	dst->value = READ_ONCE(sk->sk_forward_alloc);
 }
 
 META_COLLECTOR(int_sk_sndbuf)
-- 
2.45.2

