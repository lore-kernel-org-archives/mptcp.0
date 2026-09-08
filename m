Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF31D582BAF
	for <mptcp@lists.linux.dev>; Tue,  8 Sep 2026 16:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788885734; cv=none; b=jRomKMgafUpsqkJc63XewA31bHoWIZsfa0oSqV9XBDErhmLUQokbfb5KJrTVQGKsdTY2CD7rMgs4pq2yXyOBqgFbpRm8NFtdbDrWufz9brYAbpe/4u0snyS48V++06P/jf8GhigUY8N0rux+zVCf82RyYIq7qMy4H02IWDK2KdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788885734; c=relaxed/simple;
	bh=2pNMsghCxBPWbI5Ey+9ncTphoqUSztAom4HC6/qtENI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SJstHo87CWR9zdwZVvgBXV68yYkfiFAAXIgA0RFNdXmN63kZWz0Uj4x9aAN7yjFdNADGJXJxnchcKtObBfRlAfR9xRxNsyblQhJWCd+OL/JBnVWRg0u1Zp/n9uKS27X/nU8Dxv/bdwD05PFkWslqbnF4HrA3HH3Org4i0lu3RH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=GF/b+thi; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="GF/b+thi"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-cc149372c14so2413269a12.1
        for <mptcp@lists.linux.dev>; Tue, 08 Sep 2026 09:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1788885732; x=1789490532; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iZVfb/hy/EPDfXIzaiCqkxmhdIO311aYWlx8QWhnXx0=;
        b=GF/b+thidXry0o2aY0fzTkE3Sxuiz1LL3vpYTnmz3WkzIHHBNgBRUxO39iGh/cfwog
         /rjkkt1jPHkJkxegQIyMV9qAbxiXw46dXTathUETPEEEcN6Ps8v7n2cZqJjUurzccUaw
         C6hzgfOFoyTakuGZcn9boSngWmnZtgItYuafhYOz3tTZ4juwmrJP8+uH9AE/j3GXnegS
         Gs1JQv78KISGFMs18DLqNXiLIZfjIEv8VEor5d8u6LXfL3VRQ6XvbITIomYFDagyuE2F
         DAqKVrVwMr36DuoT2SiW5yHY5CVCjLW0XY/GzujNclmjzOPVbM9AHUK+dEzjYSlsRgMu
         Bbgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788885732; x=1789490532;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=iZVfb/hy/EPDfXIzaiCqkxmhdIO311aYWlx8QWhnXx0=;
        b=HJ8YyYPl+u7uAZ0Qu++ae1rV4ONPyIABTexM+N86DDsk5JWBh32Nkru4BP96isQMYP
         yuabAEvodkSHkasIzI7U/JkG/30c4dorOUlyyrSNcv+qxBtcj0T/NOeII6mXBwt1TE4c
         zyGwHysht+Qg/1o3B/qy0zK/amzugjwE+1rzyYep2axWbhjjGEVC2WfFeXCWFX5z+PC7
         EAJbYPon8GIdnksjsI7Dlj7YOyyD1lTREjZM1tBXfASLLuObGx7hsbzh2Ca1Y0fm3bh4
         qtIm0viVh5YRr38ffQe0uZVUkbtxSkH6Ak/l7KnzBeEkmMkASi3+GzaJsrOeiWP3wPs1
         DEew==
X-Forwarded-Encrypted: i=1; AKwUvByUd/7rTVdDkijTs8tEAUf8nXBNUbvSO0l1CsmwjDXJDaqRbMrNEDV/B316Tp5IExJyaewXXg==@lists.linux.dev
X-Gm-Message-State: AFuF++nkDsUY0biFSVwCa3HEnQJ47QT8hNGZxFODAy//AxIaclT6RnYA
	m0NjdXLlrbyvj4a18cNc3SIkpnSvNZv183fxrC3mbPUaj9FwCcWXBN+PGEnfen5Mn5c8
X-Gm-Gg: AYBFou0o/SdnCzhxrLSJFuci2FThLZ1doHNFj5z8oyUiewsYOz10GOX40LAOgZlsvai
	W8xkrDiO0UwPO/z9tIRp8gXYo3nwsoSi8Y+S2GlNveF53gaLilqfDfJfrw4UftEZ6ebn3AfWQgG
	Z1U2J2hjCHFEGbHI8z9PCACozFxjNc/kcPME5nf47DYZHECJbCuaflnhtpDYLqkunGCZgQOgr6G
	f84lnhKagDpafw9S42j7FBgtS/c7ZTCiMykaQT/CPoB8VWc0aB1Rh3XIGVGS6NKq0GVDP1UB3lO
	80LA+kiP/KydTDln+PeUFa+6+TR78yAmAMbVUX5OrVH8H+hum8igAZHmc2U3eYFuPpjRu82lrnK
	KrG7NEZIQFjHOSDExbxBE2jFpacAeZJluro1rYBWZrTzC7pQqLbpE/adJce5To7voN0z7FA3VGR
	rTw2+b1Tzirf3/5Vhu8i4kwo1E/5u9cCZgf7lQvh5zslrsUKWscOLRu//xBhwlbC1sOYM9oGFwZ
	YOxLqJF
X-Received: by 2002:a05:6a20:2d0b:b0:3d3:af85:eb99 with SMTP id adf61e73a8af0-3da3a16270fmr49192203637.27.1788885731912;
        Tue, 08 Sep 2026 09:42:11 -0700 (PDT)
Received: from enjou-Legion-Y7000P-2019 ([165.232.167.5])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc45542bd2asm5685043a12.12.2026.09.08.09.42.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 09:42:11 -0700 (PDT)
From: Ren Wei <weir@nebusec.ai>
To: netdev@vger.kernel.org,
	mptcp@lists.linux.dev,
	geliang@kernel.org
Cc: matttbe@kernel.org,
	martineau@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	ncardwell@google.com,
	kuniyu@google.com,
	daniel@iogearbox.net,
	kafai@fb.com,
	kylebot@openai.com,
	david.lee@trailofbits.com,
	vega@nebusec.ai,
	caoruide123@gmail.com,
	weir@nebusec.ai,
	sashiko-bot@kernel.org
Subject: [PATCH net v6 2/2] mptcp: fix MP_CAPABLE token migration when cloning reqsk
Date: Wed,  9 Sep 2026 00:41:25 +0800
Message-ID: <0ccff5ee6a0e8ac1bd6e90b0f1c840bcc6246984.1788800732.git.caoruide123@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1788800732.git.caoruide123@gmail.com>
References: <cover.1788800732.git.caoruide123@gmail.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ruide Cao <caoruide123@gmail.com>

TCP request migration clones pending request sockets with
inet_reqsk_clone().  For MPTCP MP_CAPABLE requests this byte-copies the
token_node hlist state into the clone even though the token table still
names the original request.

Move token request ownership from the original request to the clone under
the token bucket lock.  Make mptcp_token_accept() and
mptcp_token_destroy_request() re-check token_node under the same lock and
treat an already moved or removed request as a normal race instead of
warning.  This also keeps token bucket chain_len accounting balanced.

If a passive MP_CAPABLE socket cannot claim the token, destroy the
provisional MPTCP socket and let the subflow fall back rather than
installing a socket with mismatched token ownership.  Mark that path as a
passive handshake fallback so MPCapableFallbackACK records the downgrade.

If the speculative clone later loses the inet_ehash_insert() ownership
arbitration, the original request may find that its token was already moved
and fall back to plain TCP.  The clone destructor then releases the token
reservation and keeps chain_len balanced.  This trades an exceptionally
rare fallback for eliminating the warning and persistent accounting drift.

Patch 1/2 introduces mptcp_subflow_reqsk_clone() and fixes the MP_JOIN msk
reference.  This patch completes the same clone fixup for MP_CAPABLE token
ownership.  Both patches carry the same Fixes tag and are required for
stable backports.

Fixes: c905dee62232 ("tcp: Migrate TCP_NEW_SYN_RECV requests at retransmitting SYN+ACKs.")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/86e2514b533bf4d55d4aa2fdbf1404022e8c9430.1776149210.git.caoruide123%40gmail.com
Assisted-by: LLM
Signed-off-by: Ruide Cao <caoruide123@gmail.com>
Signed-off-by: Ren Wei <weir@nebusec.ai>
---
 net/mptcp/protocol.c   | 31 +++++++++++++++----
 net/mptcp/protocol.h   |  4 ++-
 net/mptcp/subflow.c    |  6 +++-
 net/mptcp/token.c      | 68 +++++++++++++++++++++++++++++++++++++-----
 net/mptcp/token_test.c |  4 +--
 5 files changed, 97 insertions(+), 16 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index ca644ec53eed..907a81425816 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3555,6 +3555,24 @@ static void mptcp_copy_ip_options(struct sock *newsk, const struct sock *sk)
 	rcu_read_unlock();
 }
 
+static void mptcp_sk_clone_destroy(struct sock *nsk)
+{
+	struct mptcp_sock *msk = mptcp_sk(nsk);
+
+	mptcp_release_sched(msk);
+	mptcp_set_state(nsk, TCP_CLOSE);
+	/* inet_csk_prepare_forced_close() clears TCP sock_ops state via
+	 * tcp_sk(), but nsk is an MPTCP master socket; keep the inet-level
+	 * destroy preparation here.
+	 */
+	bh_unlock_sock(nsk);
+	sock_put(nsk);
+	sock_set_flag(nsk, SOCK_DEAD);
+	tcp_orphan_count_inc();
+	inet_sk(nsk)->inet_num = 0;
+	inet_csk_destroy_sock(nsk);
+}
+
 struct sock *mptcp_sk_clone_init(const struct sock *sk,
 				 const struct mptcp_options_received *mp_opt,
 				 struct sock *ssk,
@@ -3614,11 +3632,6 @@ struct sock *mptcp_sk_clone_init(const struct sock *sk,
 	list_add(&subflow->node, &msk->conn_list);
 	sock_hold(ssk);
 
-	/* new mpc subflow takes ownership of the newly
-	 * created mptcp socket
-	 */
-	mptcp_token_accept(subflow_req, msk);
-
 	/* set msk addresses early to ensure mptcp_pm_get_local_id()
 	 * uses the correct data
 	 */
@@ -3627,6 +3640,14 @@ struct sock *mptcp_sk_clone_init(const struct sock *sk,
 	mptcp_rcv_space_init(msk, ssk);
 	msk->rcvq_space.time = mptcp_stamp();
 
+	if (!mptcp_token_accept(subflow_req, msk)) {
+		list_del_init(&subflow->node);
+		WRITE_ONCE(msk->first, NULL);
+		sock_put(ssk);
+		mptcp_sk_clone_destroy(nsk);
+		return NULL;
+	}
+
 	if (mp_opt->suboptions & OPTION_MPTCP_MPC_ACK)
 		__mptcp_subflow_fully_established(msk, subflow, mp_opt);
 	bh_unlock_sock(nsk);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 4a2d40cd7b13..c58cfb1326b7 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1074,9 +1074,11 @@ static inline void mptcp_token_init_request(struct request_sock *req)
 }
 
 int mptcp_token_new_request(struct request_sock *req);
+void mptcp_token_move_request(struct request_sock *req,
+			      struct request_sock *new_req);
 void mptcp_token_destroy_request(struct request_sock *req);
 int mptcp_token_new_connect(struct sock *ssk);
-void mptcp_token_accept(struct mptcp_subflow_request_sock *r,
+bool mptcp_token_accept(struct mptcp_subflow_request_sock *r,
 			struct mptcp_sock *msk);
 bool mptcp_token_exists(u32 token);
 struct mptcp_sock *mptcp_token_get_sock(struct net *net, u32 token);
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index cb0354985858..129b641af3c9 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -78,6 +78,8 @@ void mptcp_subflow_reqsk_clone(struct request_sock *req,
 	}
 
 	new_subflow_req->msk = msk;
+
+	mptcp_token_move_request(req, new_req);
 }
 
 static void subflow_generate_hmac(u64 key1, u64 key2, u32 nonce1, u32 nonce2,
@@ -914,8 +916,10 @@ static struct sock *subflow_syn_recv_sock(const struct sock *sk,
 
 		if (ctx->mp_capable) {
 			ctx->conn = mptcp_sk_clone_init(listener->conn, &mp_opt, child, req);
-			if (!ctx->conn)
+			if (!ctx->conn) {
+				fallback = true;
 				goto fallback;
+			}
 
 			ctx->subflow_id = 1;
 			owner = mptcp_sk(ctx->conn);
diff --git a/net/mptcp/token.c b/net/mptcp/token.c
index f1a50f367add..e0f2823f92ef 100644
--- a/net/mptcp/token.c
+++ b/net/mptcp/token.c
@@ -180,6 +180,43 @@ int mptcp_token_new_connect(struct sock *ssk)
 	return 0;
 }
 
+/**
+ * mptcp_token_move_request - move request token ownership to a clone
+ * @req: original request socket
+ * @new_req: cloned request socket
+ *
+ * Move the token hash entry from the original request to its clone.
+ */
+void mptcp_token_move_request(struct request_sock *req,
+			      struct request_sock *new_req)
+{
+	struct mptcp_subflow_request_sock *subflow_req = mptcp_subflow_rsk(req);
+	struct mptcp_subflow_request_sock *new_subflow_req;
+	struct mptcp_subflow_request_sock *pos;
+	struct token_bucket *bucket;
+
+	new_subflow_req = mptcp_subflow_rsk(new_req);
+
+	if (hlist_nulls_unhashed_lockless(&subflow_req->token_node)) {
+		mptcp_token_init_request(new_req);
+		return;
+	}
+
+	bucket = token_bucket(subflow_req->token);
+	spin_lock_bh(&bucket->lock);
+	if (hlist_nulls_unhashed(&subflow_req->token_node)) {
+		mptcp_token_init_request(new_req);
+	} else {
+		pos = __token_lookup_req(bucket, subflow_req->token);
+		if (pos == subflow_req)
+			hlist_nulls_replace_init_rcu(&subflow_req->token_node,
+						     &new_subflow_req->token_node);
+		else
+			mptcp_token_init_request(new_req);
+	}
+	spin_unlock_bh(&bucket->lock);
+}
+
 /**
  * mptcp_token_accept - replace a req sk with full sock in token hash
  * @req: the request socket to be removed
@@ -187,24 +224,36 @@ int mptcp_token_new_connect(struct sock *ssk)
  *
  * Called when a SYN packet creates a new logical connection, i.e.
  * is not a join request.
+ *
+ * Return: true on success.
  */
-void mptcp_token_accept(struct mptcp_subflow_request_sock *req,
+bool mptcp_token_accept(struct mptcp_subflow_request_sock *req,
 			struct mptcp_sock *msk)
 {
 	struct mptcp_subflow_request_sock *pos;
 	struct sock *sk = (struct sock *)msk;
 	struct token_bucket *bucket;
+	bool ret = false;
 
-	sock_prot_inuse_add(sock_net(sk), sk->sk_prot, 1);
 	bucket = token_bucket(req->token);
 	spin_lock_bh(&bucket->lock);
+	if (hlist_nulls_unhashed(&req->token_node))
+		goto unlock;
 
-	/* pedantic lookup check for the moved token */
 	pos = __token_lookup_req(bucket, req->token);
-	if (!WARN_ON_ONCE(pos != req))
-		hlist_nulls_del_init_rcu(&req->token_node);
+	if (pos != req)
+		goto unlock;
+
+	hlist_nulls_del_init_rcu(&req->token_node);
 	__sk_nulls_add_node_rcu((struct sock *)msk, &bucket->msk_chain);
+	ret = true;
+
+unlock:
 	spin_unlock_bh(&bucket->lock);
+	if (ret)
+		sock_prot_inuse_add(sock_net(sk), sk->sk_prot, 1);
+
+	return ret;
 }
 
 bool mptcp_token_exists(u32 token)
@@ -355,16 +404,21 @@ void mptcp_token_destroy_request(struct request_sock *req)
 	struct mptcp_subflow_request_sock *pos;
 	struct token_bucket *bucket;
 
-	if (hlist_nulls_unhashed(&subflow_req->token_node))
+	if (hlist_nulls_unhashed_lockless(&subflow_req->token_node))
 		return;
 
 	bucket = token_bucket(subflow_req->token);
 	spin_lock_bh(&bucket->lock);
+	if (hlist_nulls_unhashed(&subflow_req->token_node))
+		goto unlock;
+
 	pos = __token_lookup_req(bucket, subflow_req->token);
-	if (!WARN_ON_ONCE(pos != subflow_req)) {
+	if (pos == subflow_req) {
 		hlist_nulls_del_init_rcu(&pos->token_node);
 		bucket->chain_len--;
 	}
+
+unlock:
 	spin_unlock_bh(&bucket->lock);
 }
 
diff --git a/net/mptcp/token_test.c b/net/mptcp/token_test.c
index 4fc39fa2e262..be9acce8a567 100644
--- a/net/mptcp/token_test.c
+++ b/net/mptcp/token_test.c
@@ -99,7 +99,7 @@ static void mptcp_token_test_accept(struct kunit *test)
 	KUNIT_ASSERT_EQ(test, 0,
 			mptcp_token_new_request((struct request_sock *)req));
 	msk->token = req->token;
-	mptcp_token_accept(req, msk);
+	KUNIT_EXPECT_TRUE(test, mptcp_token_accept(req, msk));
 	KUNIT_EXPECT_PTR_EQ(test, msk, mptcp_token_get_sock(&init_net, msk->token));
 
 	/* this is now a no-op */
@@ -122,7 +122,7 @@ static void mptcp_token_test_destroyed(struct kunit *test)
 	KUNIT_ASSERT_EQ(test, 0,
 			mptcp_token_new_request((struct request_sock *)req));
 	msk->token = req->token;
-	mptcp_token_accept(req, msk);
+	KUNIT_EXPECT_TRUE(test, mptcp_token_accept(req, msk));
 
 	/* simulate race on removal */
 	refcount_set(&sk->sk_refcnt, 0);
-- 
2.34.1
