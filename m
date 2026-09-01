Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 753144756AE
	for <mptcp@lists.linux.dev>; Tue,  1 Sep 2026 10:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788258839; cv=none; b=YtF/ZFVbsBRikBU+qoazJYIruRwiSpC08HkwG1q5/BUrCgV9DExGsfBlIBCxsmpqOCNVKK5wuLXNjDTX0tf3rR/v4Z8+IlvS206Tq1zU0gGrvFeG/8jdlR6qLCdHksdeat/mYqFXYz9xOmZEOXgKpGg+Lzt9v2sVgND2PVOLMG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788258839; c=relaxed/simple;
	bh=D5pWhR/BCEVZYTIoxRFAtgfGjgOwcmTTALSO3ofcpV0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RsQvn8vhZif/qzSnum4B2Orcqhk46MIUQ6k0g1XLpAo27BYftLgSpeUHGfcuCK8w15k1BRzxJsNTWhjRBhiUgMpQ0wh4GD5AgiUOE+GSIq5s+5dGhbIfO0hX3aRZ0vA/nLxbu17Z0yxDScYU5njGtEyI2OHfmCut5seLluQd8Tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=FpNETJGM; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="FpNETJGM"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-cbb8b54fcf8so5127891a12.0
        for <mptcp@lists.linux.dev>; Tue, 01 Sep 2026 03:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1788258837; x=1788863637; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4mNR2C2WOCyf9H0m6p861mvJvZWGJihwNKlkIQiMnQo=;
        b=FpNETJGMuUmp35UuzcNOcKNKbumPsv6L+/vZqkHCThuDIepd8X6knSBy6AGNDLcoUE
         PlRqqNUTAGe9zW7VpHoDMBoNOYK+tjV7rfpTMC03neVRfsjvmtlYbAdCwbv8Lk9vHoo0
         eD0LadF+wNVPOoizS9+WFEGJQFQmwEtUPLrr48xDhin3r2l8Xo23mVato10YSdJHIEEJ
         RjsacFOW9lte3a6foYYZckyfKf7qH29Rm0mwzz/tVzzm5y95zZ1n085wnHcfrGoMqmT9
         6NHMtq/19/8n+cx7eDEKXa0mwzBbceFecVu1LvrmTzcLoqbSsb9bWTW4/GC4ak6FZNZP
         c0Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788258837; x=1788863637;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4mNR2C2WOCyf9H0m6p861mvJvZWGJihwNKlkIQiMnQo=;
        b=RhMyfrtGP/dFCzz3OSFMbP0/s7ixwiucYh2NL/eZ47sxa1/2trijP8eJpn4U2SA+Zp
         SfR4WttzPXKMRwvd4Gsp/2Qb99kaqe+nEwVFUPTaLrvQ5OhfiE6Nw536yQfvwQb7sgKK
         id7T6unwnbe1UqDlU6GYmOn0bBC7DOMiMUQkaS5vBxp/14n84LcyZ/0q7e9S5fzUJyw+
         G8xuBtzhijn5GdL/H5wqha3H94Ui0PDGBnFzSmNyHM9D8baIPy4kS4eI+lC6fk/NAKkw
         3LmoNGCkEBK8apTRscPBoSCUGMsrL4D+Wat31XpYTkWPCqREG6Sxuj7wzUwlfW81bEq2
         E/Yw==
X-Forwarded-Encrypted: i=1; AKwUvBxz8Rv+PT9yDq7/uwdHNPaMq2BUCApjDat/xr09RMxg9Y0e/it0p3TeA8ra7LAO0qxAyRMbvg==@lists.linux.dev
X-Gm-Message-State: AFuF++nw9pOGLy7vYI1Rp7KeYuSa6SxEvIlcgNcHbqv75d66meV0KZva
	mRG+ev0zGfAxknGruFiXfy1y+wUmkX9/9lDG9EPqyF8T6UMpMJPQ2mygchIDBwDGywBx
X-Gm-Gg: AYBFou2XsHXBdAq5GiVbHgFFz194jMaJ5lbfJrcT4cicsmCNAwVz2WgwrNNBdvgKydD
	26yTHJY3CC6caWBoYEH2OPmz2BrHbVX0N21vJr8Qy0cF/Z/diFohPeogqJ6KcWjJ2euoMFlrXi9
	ZgQhMQjMN+wbuWuHsmuyfGei82tSMFQsz3YleMpJy3jXd35whlm+308FroGva+1bmBisSvxXHEk
	QIOpHG7s9KmWoDWNl7TnblSh3BgIv8z+235XzRMkT8+A54n8uU0zJJPvGBusu+S4N7nDJYPDvWr
	au+ZC3wB82XULTGlYRnwD9ycIekqBSAolSYCbiTbuW7E9fsf7DXxW80MIMkhpujPaBPnzdzbhSU
	WuCBAoL1xG19JUQuhP3Jcw87fbBDoglVFlmVDsUzGIe7CNka8MtwH2h0WQ7vQifR2GSo7DTNbYi
	MkmDX453csMgQUnjvnoX8S1KVeaRTOzzQBFgCVIC3vzSx0OxmED7+Q4GuYPaiqiIZvPCMNO/Qdf
	tAup7/C2w==
X-Received: by 2002:a17:90b:1b0d:b0:396:b918:c2a with SMTP id 98e67ed59e1d1-39907e0f7ccmr10044783a91.12.1788258836583;
        Tue, 01 Sep 2026 03:33:56 -0700 (PDT)
Received: from enjou-Legion-Y7000P-2019 ([167.71.204.91])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3990bd1b395sm6126574a91.1.2026.09.01.03.33.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 03:33:56 -0700 (PDT)
From: Ren Wei <weir@nebusec.ai>
To: netdev@vger.kernel.org,
	mptcp@lists.linux.dev
Cc: matttbe@kernel.org,
	martineau@kernel.org,
	geliang@kernel.org,
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
Subject: [PATCH net v5 2/2] mptcp: fix MP_CAPABLE token migration when cloning reqsk
Date: Tue,  1 Sep 2026 18:33:23 +0800
Message-ID: <93dafd2c918b42d635b03e7d3d83f6f2cff49697.1788202924.git.caoruide123@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1788202924.git.caoruide123@gmail.com>
References: <cover.1788202924.git.caoruide123@gmail.com>
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

Move token request ownership from the original request to the clone
under the token bucket lock.  Make mptcp_token_accept() and
mptcp_token_destroy_request() re-check token_node under the same lock and
treat an already moved or removed request as a normal race instead of
warning.  This also keeps token bucket chain_len accounting balanced.

If a passive MP_CAPABLE socket cannot claim the token, destroy the
provisional MPTCP socket and let the subflow fall back rather than
installing a socket with mismatched token ownership.

If the speculative clone later loses the inet_ehash_insert() ownership
arbitration, the original request may find that its token was already
moved and fall back to plain TCP.  The clone destructor then releases
the token reservation and keeps chain_len balanced.  This trades an
exceptionally rare fallback for eliminating the warning and persistent
accounting drift.

Patch 1/2 introduces mptcp_subflow_reqsk_clone() and fixes the MP_JOIN
msk reference.  This patch completes the same clone fixup for MP_CAPABLE
token ownership.  Both patches carry the same Fixes tag and are required
for stable backports.

Fixes: c905dee62232 ("tcp: Migrate TCP_NEW_SYN_RECV requests at retransmitting SYN+ACKs.")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/86e2514b533bf4d55d4aa2fdbf1404022e8c9430.1776149210.git.caoruide123%40gmail.com
Assisted-by: Codex:gpt-5.4
Signed-off-by: Ruide Cao <caoruide123@gmail.com>
Signed-off-by: Ren Wei <weir@nebusec.ai>
---
 net/mptcp/protocol.c   | 31 +++++++++++++++----
 net/mptcp/protocol.h   |  4 ++-
 net/mptcp/subflow.c    |  2 ++
 net/mptcp/token.c      | 68 +++++++++++++++++++++++++++++++++++++-----
 net/mptcp/token_test.c |  4 +--
 5 files changed, 94 insertions(+), 15 deletions(-)

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
index e08d1036ad78..033c0d6eb376 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -76,6 +76,8 @@ void mptcp_subflow_reqsk_clone(struct request_sock *req,
 	}
 
 	new_subflow_req->msk = msk;
+
+	mptcp_token_move_request(req, new_req);
 }
 
 static void subflow_generate_hmac(u64 key1, u64 key2, u32 nonce1, u32 nonce2,
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

