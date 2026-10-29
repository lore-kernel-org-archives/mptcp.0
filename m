Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793316132;
	b=QF2M0htWZbQbDt7WkoVW9oMFP1F6WyPmBe0StLUP4cD3yNuhKWikq+TIhCsD78Rz5wAn
	 WwUMK2V7vrw5VzFTL8jPhqdzANtLrrpKXtTecSK3rXT0oPWAGcWx2ycYw9Tee60Vy2jJp
	 isz3JC1swf5hDvyPRCkI5n5NPF9Z3fwqa+7V9lmrRciBuG4xNRoN34DBEYk0WhFqcqDoc
	 NY3H4w5hih+tsmm4M3eP0RCXUndi3wxCgaVibfi+RCS1lrSb4WPzOGB92B9LLmWOzZga0
	 tbtlrCuU7yN030JPxWuqF94XUvfLn4hIqFYNP8JbuZRzKG/XRHriwNKNo5OY0bQ3kDg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793316132;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=ofd+qT7rZ+7/1JgYE+QZsiVah8zOgG1yfTI4XPBplDQ=;
	b=k3PfCK9M0+ZGYVx2gB+hwC7vmFDBgNJI8xE0t4AmkZHmwDy6iI1qZkOfD9ONFnp8BUqB
	 wtOH/Doq8pd8XoHXiRrNC8kKAKhE2UemhUONmxOsiTc/sirhCkHbFNYcAxbiMcKwrtoDO
	 7lZydjpYu4Ndi3Ksi1RQBWlJe/74lTzAJrql6ZB00Nxsr5xKr2aqo5pbokhwQkhR4BSZu
	 3J9e2TXrKh7lDP+8nXqI6SOHEjhAiJKFYsjGstfLlWroXKskAfsWAchkl1LMBZ+vDAxBd
	 ibJvJ9Mzh8rvN8jDO3YYyub9LYFJEJF9XLUD+V9USlLd7cawQiRLWdjzE0FR9bNZrEA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YXebYZKI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB238606A31A
	for <mptcp@lists.linux.dev>; Thu, 29 Oct 2026 23:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YXebYZKI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 395771F01824;
	Thu, 29 Oct 2026 23:22:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793316131;
	bh=ofd+qT7rZ+7/1JgYE+QZsiVah8zOgG1yfTI4XPBplDQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=YXebYZKI1I1kS65YSNK87B0dgrHP0u4+k8d7+ku9NLRe2Esa9NHE+TxGBpwdozE5u
	 IsIWSMrgjDm4O04QL7cPC1YNrmUSC2CDKDQgYaJT3WqW5F+WuUg40NglKFZVGXE91V
	 H0i2sLr/ulB5ihPDzPXG7xzVHSiS18zAwOyDpsTsf/iX0ZqB2iEm1rbboszS42q6Qk
	 d9ACthz0QnkNxY4XYhPRicU8BFj8uza4105Hmw5zlhM5pib82OANLQ208EnIkOniE7
	 vTSqIRyKzO85k77LCeJNkeYreo7QXfOwA1N1o527Lw01Dqfhv/IXLtVPoRbT7I0DEu
	 HIOr++baM1xig==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 30 Oct 2026 00:21:41 +0100
Subject: [PATCH mptcp-next v2 3/5] mptcp: subflow: split
 subflow_check_req()
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261030-mptcp-reset-mpj-early-v2-3-90f119392263@kernel.org>
References: <20261030-mptcp-reset-mpj-early-v2-0-90f119392263@kernel.org>
In-Reply-To: <20261030-mptcp-reset-mpj-early-v2-0-90f119392263@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: Paolo Abeni <pabeni@redhat.com>, 
 Chenguang Zhao <chenguang.zhao@linux.dev>, Gang Yan <gang.yan@linux.dev>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=9132; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=s2mwdgSBo3odqZGeX/p1TZSunrF9WB5ATJNuRblN1zY=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLIeX5V+dcP79qGytU8uh2f0a74Oqdu9XVDx50HO75Njm
 385vv1m0VHKwiDGxSArpsgi3RaZP/N5FW+Jl58FzBxWJpAhDFycAjCRHkuG/yUGuXP3Xgjp/rLr
 Y9H2+LjVq0vPXdzHcF1umoud5ux3m28x/C/6LLuB77SE0dSuheUiro8yl/yb4y+t4WeVIPfphDu
 TGhcA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

subflow_check_req() is quite long, and hard to read. Plus the
subflow_token_join_request helper is confusing: it also modifies
subflow_req to set the local_id and request_bkup.

This is a pure refactoring, to reduce subflow_check_req size, no
behavioural changes intended. With one exception: it is no longer
needed to call sock_put(msk) when new subflows are not accepted,
or the local_id is negative, because subflow_req->msk is now set
earlier, and the msk refcount will be decremented in the destructor.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
v2: new. (Paolo)
---
 net/mptcp/subflow.c | 219 +++++++++++++++++++++++++++-------------------------
 1 file changed, 114 insertions(+), 105 deletions(-)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index f9785e20e209..be6c8ce48fcd 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -117,44 +117,6 @@ static void subflow_req_create_thmac(struct mptcp_subflow_request_sock *subflow_
 	subflow_req->thmac = get_unaligned_be64(hmac);
 }
 
-static struct mptcp_sock *subflow_token_join_request(struct request_sock *req,
-						     u8 *reason)
-{
-	struct mptcp_subflow_request_sock *subflow_req = mptcp_subflow_rsk(req);
-	struct mptcp_sock *msk;
-	int local_id;
-
-	msk = mptcp_token_get_sock(sock_net(req_to_sk(req)), subflow_req->token);
-	if (!msk) {
-		SUBFLOW_REQ_INC_STATS(req, MPTCP_MIB_JOINNOTOKEN);
-		*reason = MPTCP_RST_EMPTCP;
-		return NULL;
-	}
-
-	/* Stop it early if the subflow cannot be accepted.
-	 * This check is inherently racy, the consistency safeguard is given by
-	 * the fallback check at finish_join time.
-	 */
-	if (!mptcp_can_accept_new_subflow(msk)) {
-		SUBFLOW_REQ_INC_STATS(req, MPTCP_MIB_MPJOINDISALLOWED);
-		*reason = MPTCP_RST_EPROHIBIT;
-		sock_put((struct sock *)msk);
-		return NULL;
-	}
-
-	local_id = mptcp_pm_get_local_id(msk, (struct sock_common *)req);
-	if (local_id < 0) {
-		SUBFLOW_REQ_INC_STATS(req, MPTCP_MIB_MPJOINNOIDFOUND);
-		*reason = MPTCP_RST_EMPTCP;
-		sock_put((struct sock *)msk);
-		return NULL;
-	}
-	subflow_req->local_id = local_id;
-	subflow_req->request_bkup = mptcp_pm_is_backup(msk, (struct sock_common *)req);
-
-	return msk;
-}
-
 static void subflow_init_req(struct request_sock *req, const struct sock *sk_listener)
 {
 	struct mptcp_subflow_request_sock *subflow_req = mptcp_subflow_rsk(req);
@@ -189,6 +151,112 @@ static int subflow_reset_req_endp(struct request_sock *req, struct sk_buff *skb)
 	return -EPERM;
 }
 
+static int subflow_check_req_mp_join(struct request_sock *req,
+				     const struct sock *sk_listener,
+				     struct sk_buff *skb,
+				     struct mptcp_options_received *mp_opt)
+{
+	struct mptcp_subflow_request_sock *subflow_req = mptcp_subflow_rsk(req);
+	int local_id;
+
+	subflow_req->ssn_offset = TCP_SKB_CB(skb)->seq;
+	subflow_req->mp_join = 1;
+	subflow_req->backup = mp_opt->backup;
+	subflow_req->remote_id = mp_opt->join_id;
+	subflow_req->token = mp_opt->token;
+	subflow_req->remote_nonce = mp_opt->nonce;
+	/* The msk refcount will be decremented in subflow_req_destructor */
+	subflow_req->msk = mptcp_token_get_sock(sock_net(req_to_sk(req)),
+						subflow_req->token);
+
+	/* Can't fall back to TCP in this case. */
+	if (!subflow_req->msk) {
+		SUBFLOW_REQ_INC_STATS(req, MPTCP_MIB_JOINNOTOKEN);
+		subflow_add_reset_reason(skb, MPTCP_RST_EMPTCP);
+		return -EPERM;
+	}
+
+	/* Stop it early if the subflow cannot be accepted.
+	 * This check is inherently racy, the consistency safeguard is given by
+	 * the fallback check at finish_join time.
+	 */
+	if (!mptcp_can_accept_new_subflow(subflow_req->msk)) {
+		SUBFLOW_REQ_INC_STATS(req, MPTCP_MIB_MPJOINDISALLOWED);
+		subflow_add_reset_reason(skb, MPTCP_RST_EPROHIBIT);
+		return -EPERM;
+	}
+
+	if (subflow_use_different_sport(subflow_req->msk, sk_listener)) {
+		pr_debug("syn inet_sport=%d %d\n",
+			 ntohs(inet_sk(sk_listener)->inet_sport),
+			 ntohs(inet_sk((struct sock *)subflow_req->msk)->inet_sport));
+		if (!mptcp_pm_announced_has_ssk(subflow_req->msk, sk_listener)) {
+			SUBFLOW_REQ_INC_STATS(req, MPTCP_MIB_MISMATCHPORTSYNRX);
+			subflow_add_reset_reason(skb, MPTCP_RST_EPROHIBIT);
+			return -EPERM;
+		}
+		SUBFLOW_REQ_INC_STATS(req, MPTCP_MIB_JOINPORTSYNRX);
+	}
+
+	local_id = mptcp_pm_get_local_id(subflow_req->msk,
+					 (struct sock_common *)req);
+	if (local_id < 0) {
+		SUBFLOW_REQ_INC_STATS(req, MPTCP_MIB_MPJOINNOIDFOUND);
+		subflow_add_reset_reason(skb, MPTCP_RST_EMPTCP);
+		return -EPERM;
+	}
+	subflow_req->local_id = local_id;
+	subflow_req->request_bkup = mptcp_pm_is_backup(subflow_req->msk,
+						       (struct sock_common *)req);
+	subflow_req_create_thmac(subflow_req);
+
+	if (unlikely(req->syncookie))
+		subflow_init_req_cookie_join_save(subflow_req, skb);
+
+	pr_debug("token=%u, remote_nonce=%u msk=%p\n", subflow_req->token,
+		 subflow_req->remote_nonce, subflow_req->msk);
+
+	return 0;
+}
+
+static int subflow_check_req_mp_capable(struct request_sock *req,
+					struct sk_buff *skb)
+{
+	struct mptcp_subflow_request_sock *subflow_req = mptcp_subflow_rsk(req);
+	int err, retries = MPTCP_TOKEN_MAX_RETRIES;
+
+	subflow_req->ssn_offset = TCP_SKB_CB(skb)->seq;
+again:
+	do {
+		get_random_bytes(&subflow_req->local_key,
+				 sizeof(subflow_req->local_key));
+	} while (subflow_req->local_key == 0);
+
+	if (unlikely(req->syncookie)) {
+		mptcp_crypto_key_sha(subflow_req->local_key,
+				     &subflow_req->token,
+				     &subflow_req->idsn);
+		if (mptcp_token_exists(subflow_req->token)) {
+			if (retries-- > 0)
+				goto again;
+			SUBFLOW_REQ_INC_STATS(req, MPTCP_MIB_TOKENFALLBACKINIT);
+		} else {
+			subflow_req->mp_capable = 1;
+		}
+		return 0;
+	}
+
+	err = mptcp_token_new_request(req);
+	if (err == 0)
+		subflow_req->mp_capable = 1;
+	else if (retries-- > 0)
+		goto again;
+	else
+		SUBFLOW_REQ_INC_STATS(req, MPTCP_MIB_TOKENFALLBACKINIT);
+
+	return 0;
+}
+
 /* Init mptcp request socket.
  *
  * Returns an error code if a JOIN has failed and a TCP reset
@@ -234,74 +302,15 @@ static int subflow_check_req(struct request_sock *req,
 		return subflow_reset_req_endp(req, skb);
 	}
 
-	if (opt_mp_capable && listener->request_mptcp) {
-		int err, retries = MPTCP_TOKEN_MAX_RETRIES;
+	if (!listener->request_mptcp)
+		return 0;
 
-		subflow_req->ssn_offset = TCP_SKB_CB(skb)->seq;
-again:
-		do {
-			get_random_bytes(&subflow_req->local_key, sizeof(subflow_req->local_key));
-		} while (subflow_req->local_key == 0);
+	if (opt_mp_capable)
+		return subflow_check_req_mp_capable(req, skb);
 
-		if (unlikely(req->syncookie)) {
-			mptcp_crypto_key_sha(subflow_req->local_key,
-					     &subflow_req->token,
-					     &subflow_req->idsn);
-			if (mptcp_token_exists(subflow_req->token)) {
-				if (retries-- > 0)
-					goto again;
-				SUBFLOW_REQ_INC_STATS(req, MPTCP_MIB_TOKENFALLBACKINIT);
-			} else {
-				subflow_req->mp_capable = 1;
-			}
-			return 0;
-		}
-
-		err = mptcp_token_new_request(req);
-		if (err == 0)
-			subflow_req->mp_capable = 1;
-		else if (retries-- > 0)
-			goto again;
-		else
-			SUBFLOW_REQ_INC_STATS(req, MPTCP_MIB_TOKENFALLBACKINIT);
-
-	} else if (opt_mp_join && listener->request_mptcp) {
-		u8 reason;
-
-		subflow_req->ssn_offset = TCP_SKB_CB(skb)->seq;
-		subflow_req->mp_join = 1;
-		subflow_req->backup = mp_opt.backup;
-		subflow_req->remote_id = mp_opt.join_id;
-		subflow_req->token = mp_opt.token;
-		subflow_req->remote_nonce = mp_opt.nonce;
-		subflow_req->msk = subflow_token_join_request(req, &reason);
-
-		/* Can't fall back to TCP in this case. */
-		if (!subflow_req->msk) {
-			subflow_add_reset_reason(skb, reason);
-			return -EPERM;
-		}
-
-		if (subflow_use_different_sport(subflow_req->msk, sk_listener)) {
-			pr_debug("syn inet_sport=%d %d\n",
-				 ntohs(inet_sk(sk_listener)->inet_sport),
-				 ntohs(inet_sk((struct sock *)subflow_req->msk)->inet_sport));
-			if (!mptcp_pm_announced_has_ssk(subflow_req->msk, sk_listener)) {
-				SUBFLOW_REQ_INC_STATS(req, MPTCP_MIB_MISMATCHPORTSYNRX);
-				subflow_add_reset_reason(skb, MPTCP_RST_EPROHIBIT);
-				return -EPERM;
-			}
-			SUBFLOW_REQ_INC_STATS(req, MPTCP_MIB_JOINPORTSYNRX);
-		}
-
-		subflow_req_create_thmac(subflow_req);
-
-		if (unlikely(req->syncookie))
-			subflow_init_req_cookie_join_save(subflow_req, skb);
-
-		pr_debug("token=%u, remote_nonce=%u msk=%p\n", subflow_req->token,
-			 subflow_req->remote_nonce, subflow_req->msk);
-	}
+	if (opt_mp_join)
+		return subflow_check_req_mp_join(req, sk_listener, skb,
+						 &mp_opt);
 
 	return 0;
 }
@@ -2148,7 +2157,7 @@ static void subflow_ulp_clone(const struct request_sock *req,
 		new_ctx->token = subflow_req->token;
 
 		/* the subflow req id is valid, fetched via subflow_check_req()
-		 * and subflow_token_join_request()
+		 * and subflow_check_req_mp_join()
 		 */
 		subflow_set_local_id(new_ctx, subflow_req->local_id);
 	}

-- 
2.55.0

