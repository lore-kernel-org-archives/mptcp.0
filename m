Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DA6540BE9
	for <mptcp@lists.linux.dev>; Mon,  5 Feb 2024 15:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707148319; cv=none; b=N7j0F8I/VesHNvvfUoHuvupM6fjy2mguEy/t3yJtvGf9+aarxvQqbxS+rDFboY9Gr6tWWGBz39+bcgZTmJ62ssN+2RO7+ZibXYU3ZEd11KYIO8HtJFoFxeBMhpRY2vBPQphjE7KeU+JsrymnIAqOYQh5i6GhRaZQbaRGnmZMfUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707148319; c=relaxed/simple;
	bh=G3CKvM8wlK6AvhNlAFOQSSpGyZ9LdXN0sN141Ge73kE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uM1YoZGiwOugs+u0ehsVtty6XQ7ZqQUmSIRkMAltF7uw3XU8vq3j0fp9dsvB0IiI7nicP9JDoQVWnbW41yy+0vOwbX+rwUq2XAVe4jMZPeAg8Z/IvuPfrC1N7ZIBv1nWBcDJs+rFBkC0MtV6BW4LncNVnvSJsZ8X/Z72HDXgKCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DL3HLsfM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DL3HLsfM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707148316;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TUZIjyARMdM26P2VsgyKnw0h+VT5+V8rFaL40RPG22s=;
	b=DL3HLsfMk8ppb80BMW8aBf0TqRurYO/cE9R3blmtmmcZbZ3Tr7t0qwFooBdzxuNe71Ardc
	3JzfiNB2Cgnj+pFi2XeQofapbIpukg4FXaUWLCokSLhCR/mFwMCFkUp8iX12z/xpCrzz5O
	XOtIsgUs7AV2FEmQOcudE7dqZXEiJzk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-91-Jvw5a_5dMoOdwlJWdNMWmA-1; Mon, 05 Feb 2024 10:51:55 -0500
X-MC-Unique: Jvw5a_5dMoOdwlJWdNMWmA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EFDCF88F2EC
	for <mptcp@lists.linux.dev>; Mon,  5 Feb 2024 15:51:54 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.225.229])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 7F9933C2E
	for <mptcp@lists.linux.dev>; Mon,  5 Feb 2024 15:51:54 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-net 1/4] mptcp: fix lockless access in subflow ULP diag
Date: Mon,  5 Feb 2024 16:51:39 +0100
Message-ID: <96f99278110c7ebd0ac401094b367f9bbdf5240f.1707144963.git.pabeni@redhat.com>
In-Reply-To: <cover.1707144963.git.pabeni@redhat.com>
References: <cover.1707144963.git.pabeni@redhat.com>
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

