Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C1EB4C3BC
	for <mptcp@lists.linux.dev>; Thu,  8 Feb 2024 20:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707424979; cv=none; b=epdBgB4Fn+AeJKUORZ5Yuh/0GuKXkuDB1YDzqWxwmjUf/VgwQP81/L/6+ukJKFEJyogNXpDD4jcC2uCrzBGDb4DK5DQgSJp/n2F6EAZ7/gVRXVGztnyMFrj8o6cKfxA62dojbm3QH+8ltrszIyGlrCPeOOexQHP7XjacMtYLZ1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707424979; c=relaxed/simple;
	bh=G3CKvM8wlK6AvhNlAFOQSSpGyZ9LdXN0sN141Ge73kE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oSL05koDtt7IIW2QRYn+ht/UwfYOOif2kt3bEWXxwcOgwpsUJQBvzAmO5h5/er0qATqm1CtnWE3+tRWmUmFYaRkRWxditL09ghyzGCVQdxvpwLYmvofP3bUvuVyPTux3xH506nCs8VawefU9/fN21M6XBJncsSyZl08RrbkwPn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hHWczACD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hHWczACD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707424977;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TUZIjyARMdM26P2VsgyKnw0h+VT5+V8rFaL40RPG22s=;
	b=hHWczACDTaoRqv6yzkCbNiris4lse14jPb0ORzlUsO5ZFFH1qQ63LpvD7MZT2nYUuD16Zi
	eqjbsQMWi9viiTiWmCrNdvnvjHeSDqSClMFVmI1BqeBsqSE3kDwu0uI2mbBX0yk/n3em76
	nSuBJ1wWXILwjrXNOcwKJ/EwrPz6Rio=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-173-ZjLL_ZePM8uYiZQ9YY0xaA-1; Thu,
 08 Feb 2024 15:42:55 -0500
X-MC-Unique: ZjLL_ZePM8uYiZQ9YY0xaA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 923E11C05141
	for <mptcp@lists.linux.dev>; Thu,  8 Feb 2024 20:42:55 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.247])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 21AB4C1596E
	for <mptcp@lists.linux.dev>; Thu,  8 Feb 2024 20:42:54 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-net v2 1/4] mptcp: fix lockless access in subflow ULP diag
Date: Thu,  8 Feb 2024 21:42:45 +0100
Message-ID: <96f99278110c7ebd0ac401094b367f9bbdf5240f.1707418323.git.pabeni@redhat.com>
In-Reply-To: <cover.1707418323.git.pabeni@redhat.com>
References: <cover.1707418323.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

Since the introduction of the subflow ULP diag interface, the
dump callback accessed all the subflow data with lockless.

We need either to annotate all the read and write operation accordingly,
or acquire the subflow socket lock. Let's do latter, even if slower, to
avoid a diffstat havoc.

Fixes: 5147dfb50832 ("mptcp: allow dumping subflow context to userspace")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
note: tls ulp diag has likely the same issue.
---
 include/net/tcp.h  | 2 +-
 net/mptcp/diag.c   | 6 +++++-
 net/tls/tls_main.c | 2 +-
 3 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 58e65af74ad1..33bf92dff0af 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -2551,7 +2551,7 @@ struct tcp_ulp_ops {
 	/* cleanup ulp */
 	void (*release)(struct sock *sk);
 	/* diagnostic */
-	int (*get_info)(const struct sock *sk, struct sk_buff *skb);
+	int (*get_info)(struct sock *sk, struct sk_buff *skb);
 	size_t (*get_info_size)(const struct sock *sk);
 	/* clone ulp */
 	void (*clone)(const struct request_sock *req, struct sock *newsk,
diff --git a/net/mptcp/diag.c b/net/mptcp/diag.c
index a536586742f2..e57c5f47f035 100644
--- a/net/mptcp/diag.c
+++ b/net/mptcp/diag.c
@@ -13,17 +13,19 @@
 #include <uapi/linux/mptcp.h>
 #include "protocol.h"
 
-static int subflow_get_info(const struct sock *sk, struct sk_buff *skb)
+static int subflow_get_info(struct sock *sk, struct sk_buff *skb)
 {
 	struct mptcp_subflow_context *sf;
 	struct nlattr *start;
 	u32 flags = 0;
+	bool slow;
 	int err;
 
 	start = nla_nest_start_noflag(skb, INET_ULP_INFO_MPTCP);
 	if (!start)
 		return -EMSGSIZE;
 
+	slow = lock_sock_fast(sk);
 	rcu_read_lock();
 	sf = rcu_dereference(inet_csk(sk)->icsk_ulp_data);
 	if (!sf) {
@@ -69,11 +71,13 @@ static int subflow_get_info(const struct sock *sk, struct sk_buff *skb)
 	}
 
 	rcu_read_unlock();
+	unlock_sock_fast(sk, slow);
 	nla_nest_end(skb, start);
 	return 0;
 
 nla_failure:
 	rcu_read_unlock();
+	unlock_sock_fast(sk, slow);
 	nla_nest_cancel(skb, start);
 	return err;
 }
diff --git a/net/tls/tls_main.c b/net/tls/tls_main.c
index 1c2c6800949d..b4674f03d71a 100644
--- a/net/tls/tls_main.c
+++ b/net/tls/tls_main.c
@@ -1003,7 +1003,7 @@ static u16 tls_user_config(struct tls_context *ctx, bool tx)
 	return 0;
 }
 
-static int tls_get_info(const struct sock *sk, struct sk_buff *skb)
+static int tls_get_info(struct sock *sk, struct sk_buff *skb)
 {
 	u16 version, cipher_type;
 	struct tls_context *ctx;
-- 
2.43.0

