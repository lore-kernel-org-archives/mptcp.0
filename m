Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ACF46137
	for <mptcp@lists.linux.dev>; Mon,  6 Mar 2023 18:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1678127431;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IWELGuxVrarX1Qvkg+rKE0LMkRdNvIoH1Btd5XNDu+o=;
	b=EtA7yhEiSuF+0lbO2ZDCUwMfsfQhcZwioL3Evg8+ZeRCkog1amAjd+ox9ATmGuX6drkHk/
	zzMXFO+dTb3ZDlhBr0EddMI/MAR8jq4PVyUcSlBqb3wwhliAGXWlNa8K9rI0CItSfJvUph
	Dx47Gt4SVL98r1TdJZz0wFNpT5vRwFo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-37-T1HZcaz5OKOvMnN62NCxSQ-1; Mon, 06 Mar 2023 13:30:29 -0500
X-MC-Unique: T1HZcaz5OKOvMnN62NCxSQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7A8D6857A8E
	for <mptcp@lists.linux.dev>; Mon,  6 Mar 2023 18:30:29 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.195.34])
	by smtp.corp.redhat.com (Postfix) with ESMTP id ED27E440DF
	for <mptcp@lists.linux.dev>; Mon,  6 Mar 2023 18:30:28 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next 2/2] mptcp: simplify subflow_syn_recv_sock()
Date: Mon,  6 Mar 2023 19:30:21 +0100
Message-Id: <ec8a2809ee4556d8b28efaef2aec26ce1a23ef4b.1678122760.git.pabeni@redhat.com>
In-Reply-To: <cover.1678122760.git.pabeni@redhat.com>
References: <cover.1678122760.git.pabeni@redhat.com>
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

Postpone the msk cloning to the child process creation
so that we can avoid a bunch of conditionals.

Close: https://github.com/multipath-tcp/mptcp_net-next/issues/61
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/subflow.c | 38 ++++++++++----------------------------
 1 file changed, 10 insertions(+), 28 deletions(-)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index f0758b23c6b2..d79926cb9152 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -696,14 +696,6 @@ static bool subflow_hmac_valid(const struct request_sock *req,
 	return !crypto_memneq(hmac, mp_opt->hmac, MPTCPOPT_HMAC_LEN);
 }
 
-static void mptcp_force_close(struct sock *sk)
-{
-	/* the msk is not yet exposed to user-space, and refcount is 2 */
-	inet_sk_state_store(sk, TCP_CLOSE);
-	sk_common_release(sk);
-	sock_put(sk);
-}
-
 static void subflow_ulp_fallback(struct sock *sk,
 				 struct mptcp_subflow_context *old_ctx)
 {
@@ -755,7 +747,6 @@ static struct sock *subflow_syn_recv_sock(const struct sock *sk,
 	struct mptcp_subflow_request_sock *subflow_req;
 	struct mptcp_options_received mp_opt;
 	bool fallback, fallback_is_fatal;
-	struct sock *new_msk = NULL;
 	struct mptcp_sock *owner;
 	struct sock *child;
 
@@ -784,14 +775,9 @@ static struct sock *subflow_syn_recv_sock(const struct sock *sk,
 		 * options.
 		 */
 		mptcp_get_options(skb, &mp_opt);
-		if (!(mp_opt.suboptions & OPTIONS_MPTCP_MPC)) {
+		if (!(mp_opt.suboptions & OPTIONS_MPTCP_MPC))
 			fallback = true;
-			goto create_child;
-		}
 
-		new_msk = mptcp_sk_clone(listener->conn, &mp_opt, req);
-		if (!new_msk)
-			fallback = true;
 	} else if (subflow_req->mp_join) {
 		mptcp_get_options(skb, &mp_opt);
 		if (!(mp_opt.suboptions & OPTIONS_MPTCP_MPJ) ||
@@ -820,21 +806,23 @@ static struct sock *subflow_syn_recv_sock(const struct sock *sk,
 				subflow_add_reset_reason(skb, MPTCP_RST_EMPTCP);
 				goto dispose_child;
 			}
-
-			mptcp_subflow_drop_ctx(child);
-			goto out;
+			goto fallback;
 		}
 
 		/* ssk inherits options of listener sk */
 		ctx->setsockopt_seq = listener->setsockopt_seq;
 
 		if (ctx->mp_capable) {
-			owner = mptcp_sk(new_msk);
+			ctx->conn = mptcp_sk_clone(listener->conn, &mp_opt, req);
+			if (!ctx->conn)
+				goto fallback;
+
+			owner = mptcp_sk(ctx->conn);
 
 			/* this can't race with mptcp_close(), as the msk is
 			 * not yet exposted to user-space
 			 */
-			inet_sk_state_store((void *)new_msk, TCP_ESTABLISHED);
+			inet_sk_state_store(ctx->conn, TCP_ESTABLISHED);
 
 			/* record the newly created socket as the first msk
 			 * subflow, but don't link it yet into conn_list
@@ -844,11 +832,9 @@ static struct sock *subflow_syn_recv_sock(const struct sock *sk,
 			/* new mpc subflow takes ownership of the newly
 			 * created mptcp socket
 			 */
-			mptcp_sk(new_msk)->setsockopt_seq = ctx->setsockopt_seq;
+			owner->setsockopt_seq = ctx->setsockopt_seq;
 			mptcp_pm_new_connection(owner, child, 1);
 			mptcp_token_accept(subflow_req, owner);
-			ctx->conn = new_msk;
-			new_msk = NULL;
 
 			/* set msk addresses early to ensure mptcp_pm_get_local_id()
 			 * uses the correct data
@@ -901,14 +887,10 @@ static struct sock *subflow_syn_recv_sock(const struct sock *sk,
 		 * soon, but context must be explicitly deleted or will be
 		 * leaked
 		 */
+fallback:
 		mptcp_subflow_drop_ctx(child);
 	}
 
-out:
-	/* dispose of the left over mptcp master, if any */
-	if (unlikely(new_msk))
-		mptcp_force_close(new_msk);
-
 	/* check for expected invariant - should never trigger, just help
 	 * catching eariler subtle bugs
 	 */
-- 
2.39.2

