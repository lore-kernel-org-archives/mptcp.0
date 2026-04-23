Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17F101DC9B5
	for <mptcp@lists.linux.dev>; Thu, 23 Apr 2026 06:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776926007; cv=none; b=dWCn5cGpiOw3uDeJJEW30dTMA6+Tywf9TP073LHhKlB9LcZk3IG5xUJRkUewkbtQ/Pdrh0B0Sg2EwiNS2JB2EgGm80xX/t84AcZStsjeUuo29OdZ27sYHoPm9wX7Iq81w9Gph9YdiSV0aDytdpJrwxH+xwvP+o12vyoaU+UxAbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776926007; c=relaxed/simple;
	bh=6PF98KCtOvGmgw3ysWDZqbAt+r1mE72fyjV7TZc/gqo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FnW2QbLKeRjiQzn2ED0t88ZDNBaBlF1T/L3yjURRJV+qrLwq6StnV20zCBS4Dcg8iA0eX15jqjdPEUFa7jSKfO+AbgHiKlx2/au72/9kHqn1HGAfyIDVx2TylQv0q4TYJUiOUtQzwfzyz+d7bmS3KsI3W9y3MPf52dDhEasV4cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cjmWxxP/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cjmWxxP/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7940FC2BCB2;
	Thu, 23 Apr 2026 06:33:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776926006;
	bh=6PF98KCtOvGmgw3ysWDZqbAt+r1mE72fyjV7TZc/gqo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cjmWxxP/fOIZNIadhU+zyg6DAKvCycw+H1PuEqE8zXraUPSRhY4sOln7WgrfjKL8D
	 NCbqSyzqLVwkB27KbujJwfmVNbqNJeI+VhL+1AzmA7tw09bDQlldE3VtjMdk2LhM62
	 VKYbEG36IC7sdF02PrEGv9SnrOzVBhtqlkTsk04VV6p+sPSvENzjkkkKoBsNUqwSYl
	 wWGDDQdHEP9N1uGSDI/eywDolmRvrWQAZyYRqn1ANvmvkCS8wzNcIMDHxgylbUiZPp
	 Q2JmKObQQGf+hrAALDyjtngvK+JkWO4vYd066slP5d4s/NW/eHF4jCY5YN4sDrPiht
	 /aaQIcTjD0shA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [PATCH mptcp-next v16 03/16] tls: add tls_prot_ops pointer to tls_proto
Date: Thu, 23 Apr 2026 14:32:56 +0800
Message-ID: <afe7bd82ee5fa183a3454b9b5f4a8f169d845724.1776924681.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1776924681.git.tanggeliang@kylinos.cn>
References: <cover.1776924681.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

A pointer to struct tls_prot_ops, named 'ops', has been added to struct
tls_proto.

In tls_build_proto(), proto->ops is assigned either 'tls_mptcp_ops' or
'tls_tcp_ops' based on the socket protocol. Fix module reference counting
bug where each socket release called module_put() without matching get
for existing tls_proto.

Co-developed-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 include/net/tls.h  |  1 +
 net/tls/tls_main.c | 25 ++++++++++++++++++++++++-
 2 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/include/net/tls.h b/include/net/tls.h
index 0865932d8cc7..ee24f9d24324 100644
--- a/include/net/tls.h
+++ b/include/net/tls.h
@@ -249,6 +249,7 @@ struct tls_proto {
 	refcount_t			refcnt;
 	struct list_head		list;
 	const struct proto		*prot;
+	const struct tls_prot_ops	*ops;
 	struct proto prots[TLS_NUM_PROTS][TLS_NUM_CONFIG][TLS_NUM_CONFIG];
 	struct proto_ops proto_ops[TLS_NUM_PROTS][TLS_NUM_CONFIG][TLS_NUM_CONFIG];
 };
diff --git a/net/tls/tls_main.c b/net/tls/tls_main.c
index 1ee891405cde..68308a42899b 100644
--- a/net/tls/tls_main.c
+++ b/net/tls/tls_main.c
@@ -145,6 +145,7 @@ static void tls_proto_cleanup(void)
 		if (refcount_dec_and_test(&prot->refcnt)) {
 			list_del_rcu(&prot->list);
 			synchronize_rcu();
+			module_put(prot->ops->owner);
 			kfree(prot);
 		}
 	}
@@ -367,9 +368,11 @@ void tls_ctx_free(struct sock *sk, struct tls_context *ctx)
 		return;
 
 	if (ctx->proto) {
+		module_put(ctx->proto->ops->owner);
 		if (refcount_dec_and_test(&ctx->proto->refcnt)) {
 			list_del_rcu(&ctx->proto->list);
 			synchronize_rcu();
+			module_put(ctx->proto->ops->owner);
 			kfree(ctx->proto);
 		}
 	}
@@ -1021,6 +1024,7 @@ static struct tls_proto *tls_build_proto(struct sock *sk)
 {
 	int ip_ver = sk->sk_family == AF_INET6 ? TLSV6 : TLSV4;
 	struct proto *prot = READ_ONCE(sk->sk_prot);
+	struct tls_prot_ops *ops;
 	struct tls_proto *proto;
 
 	mutex_lock(&tls_proto_mutex);
@@ -1028,11 +1032,22 @@ static struct tls_proto *tls_build_proto(struct sock *sk)
 	if (proto)
 		goto out;
 
+	rcu_read_lock();
+	ops = tls_prot_ops_find(sk->sk_protocol);
+	if (!ops || !try_module_get(ops->owner)) {
+		rcu_read_unlock();
+		goto out;
+	}
+	rcu_read_unlock();
+
 	proto = kzalloc(sizeof(*proto), GFP_KERNEL);
-	if (!proto)
+	if (!proto) {
+		module_put(ops->owner);
 		goto out;
+	}
 
 	proto->prot = prot;
+	proto->ops = ops;
 	refcount_set(&proto->refcnt, 2);
 	build_protos(proto->prots[ip_ver], prot);
 	build_proto_ops(proto->proto_ops[ip_ver],
@@ -1099,9 +1114,15 @@ static int tls_init(struct sock *sk)
 	if (!proto)
 		return -ENOMEM;
 
+	if (!try_module_get(proto->ops->owner)) {
+		refcount_dec(&proto->refcnt);
+		return -ENOENT;
+	}
+
 #ifdef CONFIG_TLS_TOE
 	if (tls_toe_bypass(sk, proto)) {
 		refcount_dec(&proto->refcnt);
+		module_put(proto->ops->owner);
 		return 0;
 	}
 #endif
@@ -1114,6 +1135,7 @@ static int tls_init(struct sock *sk)
 	 */
 	if (sk->sk_state != TCP_ESTABLISHED) {
 		refcount_dec(&proto->refcnt);
+		module_put(proto->ops->owner);
 		return -ENOTCONN;
 	}
 
@@ -1122,6 +1144,7 @@ static int tls_init(struct sock *sk)
 	ctx = tls_ctx_create(sk, proto);
 	if (!ctx) {
 		refcount_dec(&proto->refcnt);
+		module_put(proto->ops->owner);
 		rc = -ENOMEM;
 		goto out;
 	}
-- 
2.51.0

