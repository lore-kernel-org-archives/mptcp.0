Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A035A221299
	for <mptcp@lists.linux.dev>; Fri,  7 Nov 2025 21:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762552564; cv=none; b=uSMBijMc3YPXowGj+A8kcToINj/UQDqlEObN2spFFD4fP+uJLwccdWTVjwnqAVv8FJIXDR1uaCeE1N3Yj4zPl/5wWrfMeBljgeBgcWG/hpld2X+rhpM2IvpQcqOmqUsYQAp9+vlBtNtmHtcWxE306jKHg4EA4BagknZLhUAXhhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762552564; c=relaxed/simple;
	bh=X9qIFp/0P9U8zCZu7DAonAkYdL4qMViQLXtbS4w6piw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=UCHxm8T2wWcW4dWtxx08Mz+oBkGDbPGOCVzQs8LE1tGtNChONxzfJc1r7zVyl3oBRAlclPlVNHl8ZygPIR5AJEHFNjLh4qdKWgFIHo1xySs7xpAVtnVx9Yd7I5CLjHshN5meYFemeo3stb2q3728IgEKVnDNV4bQcrGZn+lhibk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gN/pnlj5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gN/pnlj5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762552560;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pm3THznvJQg2GNvO7XB2TW1MWmtCQrZpgsymtOhgt0w=;
	b=gN/pnlj5BvHtfYnTimqUZ6cYa9+JQJatIj+OZFxcCISpYfACKhaxnrUcLyrUqJStyOBNPU
	b4vB2bfPuS2XrOQsXLYcevvyQfad/qmbF5iR+vBU1Oe7HEBMJAMdCQkuKyHYpbF50ZcP+L
	TktnjhxqRhsYfdRm2oqlEFaYA0yc690=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-115-4LaUAhUVMliftKTJq3gvSQ-1; Fri,
 07 Nov 2025 16:55:59 -0500
X-MC-Unique: 4LaUAhUVMliftKTJq3gvSQ-1
X-Mimecast-MFC-AGG-ID: 4LaUAhUVMliftKTJq3gvSQ_1762552558
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A06EF1800359
	for <mptcp@lists.linux.dev>; Fri,  7 Nov 2025 21:55:58 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.32.157])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BE49819560A7
	for <mptcp@lists.linux.dev>; Fri,  7 Nov 2025 21:55:57 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-net 1/3] net: factor-out _sk_charge() helper
Date: Fri,  7 Nov 2025 22:55:45 +0100
Message-ID: <063e2bc8e98ce050286eb4309bf4bd47716cc3f8.1762551942.git.pabeni@redhat.com>
In-Reply-To: <cover.1762551942.git.pabeni@redhat.com>
References: <cover.1762551942.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: sW7F4HQpnaQ8XhuwXHpDA1rZqbbANJekZQrKNjly9QQ_1762552558
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Move out of __inet_accept() the code dealing charging newly
accepted socket to memcg. MPTCP will soon use it to on a per
subflow basis, in different contexts.

No functional changes intended.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 include/net/sock.h |  2 ++
 net/core/sock.c    | 18 ++++++++++++++++++
 net/ipv4/af_inet.c | 17 +----------------
 3 files changed, 21 insertions(+), 16 deletions(-)

diff --git a/include/net/sock.h b/include/net/sock.h
index a5f36ea9d46f..38d48cfe0741 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -1631,6 +1631,8 @@ static inline void sk_mem_uncharge(struct sock *sk, int size)
 	sk_mem_reclaim(sk);
 }
 
+void __sk_charge(struct sock *sk, gfp_t gfp);
+
 #if IS_ENABLED(CONFIG_PROVE_LOCKING) && IS_ENABLED(CONFIG_MODULES)
 static inline void sk_owner_set(struct sock *sk, struct module *owner)
 {
diff --git a/net/core/sock.c b/net/core/sock.c
index 3b74fc71f51c..b26a6cdc9bcd 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -3448,6 +3448,24 @@ void __sk_mem_reclaim(struct sock *sk, int amount)
 }
 EXPORT_SYMBOL(__sk_mem_reclaim);
 
+void __sk_charge(struct sock *sk, gfp_t gfp)
+{
+	int amt;
+
+	gfp |= __GFP_NOFAIL;
+	if (mem_cgroup_from_sk(sk)) {
+		/* The socket has not been accepted yet, no need
+		 * to look at newsk->sk_wmem_queued.
+		 */
+		amt = sk_mem_pages(sk->sk_forward_alloc +
+				   atomic_read(&sk->sk_rmem_alloc));
+		if (amt)
+			mem_cgroup_sk_charge(sk, amt, gfp);
+	}
+
+	kmem_cache_charge(sk, gfp);
+}
+
 int sk_set_peek_off(struct sock *sk, int val)
 {
 	WRITE_ONCE(sk->sk_peek_off, val);
diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
index a31b94ce8968..08d811f11896 100644
--- a/net/ipv4/af_inet.c
+++ b/net/ipv4/af_inet.c
@@ -756,23 +756,8 @@ EXPORT_SYMBOL(inet_stream_connect);
 void __inet_accept(struct socket *sock, struct socket *newsock, struct sock *newsk)
 {
 	if (mem_cgroup_sockets_enabled) {
-		gfp_t gfp = GFP_KERNEL | __GFP_NOFAIL;
-
 		mem_cgroup_sk_alloc(newsk);
-
-		if (mem_cgroup_from_sk(newsk)) {
-			int amt;
-
-			/* The socket has not been accepted yet, no need
-			 * to look at newsk->sk_wmem_queued.
-			 */
-			amt = sk_mem_pages(newsk->sk_forward_alloc +
-					   atomic_read(&newsk->sk_rmem_alloc));
-			if (amt)
-				mem_cgroup_sk_charge(newsk, amt, gfp);
-		}
-
-		kmem_cache_charge(newsk, gfp);
+		__sk_charge(newsk, GFP_KERNEL);
 	}
 
 	sock_rps_record_flow(newsk);
-- 
2.51.0

