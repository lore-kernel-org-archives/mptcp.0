Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CEF179D0
	for <mptcp@lists.linux.dev>; Wed,  8 Feb 2023 21:44:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1675892659;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P2f11UH+ovsC9lb7JNzsG62bYFjoMeJfnN7KO4dshPQ=;
	b=GGtlss7FCakV361dww0tfOMJKes3mmCUfXlSC9ejUZFx7kks61VWo1qaRLF3L/MxHKtAe+
	uZCJNtczkAibW++Uv+Gdps+wS3k8JpZDHMtUFTGvlewS8yeu1StTChq0AkpkSDwqKaFDm/
	wtzsAWoy+Xh1uW68txt8rwUn9rdaddA=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-491-pQERzo9uOICGG-bWv-rJ-A-1; Wed, 08 Feb 2023 16:44:17 -0500
X-MC-Unique: pQERzo9uOICGG-bWv-rJ-A-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 799ED29A9D3F;
	Wed,  8 Feb 2023 21:44:17 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.193.120])
	by smtp.corp.redhat.com (Postfix) with ESMTP id D9022492C3E;
	Wed,  8 Feb 2023 21:44:16 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Cc: Christoph Paasch <cpaasch@apple.com>
Subject: [PATCH mptcp-net 1/2] mptcp: use the workqueue to destroy unaccepted sockets.
Date: Wed,  8 Feb 2023 22:44:09 +0100
Message-Id: <b569cbd73ff8fabb04911142f39cd8edb0585bf8.1675892307.git.pabeni@redhat.com>
In-Reply-To: <cover.1675892307.git.pabeni@redhat.com>
References: <cover.1675892307.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

Christoph reported a UaF while disposing unaccepted MPC
subflow.

We need to properly clean-up all the paired MPTCP-level
resources and be sure to release the msk last, even when
the unaccepted subflow is destroyed by the TCP internals
via inet_child_forget().

We can re-use the existing MPTCP_WORK_CLOSE_SUBFLOW infra,
explicitly checking that for the critical scenario: the
closed subflow is the MPC one, the msk is not accepted and
eventually going through full cleanup.

With such change, __mptcp_destroy_sock() is always called
on msk sockets, even on accepted ones. We don't need anymore
to transiently drop one sk reference at msk clone time.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/protocol.c | 26 +++++++++++++++++---------
 net/mptcp/protocol.h |  3 ++-
 net/mptcp/subflow.c  | 11 +++++++++--
 3 files changed, 28 insertions(+), 12 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 546df81c162f..d7588535bf6d 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2444,9 +2444,10 @@ static unsigned int mptcp_sync_mss(struct sock *sk, u32 pmtu)
 	return 0;
 }
 
-static void __mptcp_close_subflow(struct mptcp_sock *msk)
+static void __mptcp_close_subflow(struct sock *sk)
 {
 	struct mptcp_subflow_context *subflow, *tmp;
+	struct mptcp_sock *msk = mptcp_sk(sk);
 
 	might_sleep();
 
@@ -2460,7 +2461,15 @@ static void __mptcp_close_subflow(struct mptcp_sock *msk)
 		if (!skb_queue_empty_lockless(&ssk->sk_receive_queue))
 			continue;
 
-		mptcp_close_ssk((struct sock *)msk, ssk, subflow);
+		mptcp_close_ssk(sk, ssk, subflow);
+	}
+
+	/* if the MPC subflow has been closed before the msk is accepted,
+	 * msk will never be accept-ed, close it now
+	 */
+	if (!msk->first && msk->in_accept_queue) {
+		sock_set_flag(sk, SOCK_DEAD);
+		sk->sk_state = TCP_CLOSE;
 	}
 }
 
@@ -2684,6 +2693,9 @@ static void mptcp_worker(struct work_struct *work)
 	__mptcp_check_send_data_fin(sk);
 	mptcp_check_data_fin(sk);
 
+	if (test_and_clear_bit(MPTCP_WORK_CLOSE_SUBFLOW, &msk->flags))
+		__mptcp_close_subflow(sk);
+
 	/* There is no point in keeping around an orphaned sk timedout or
 	 * closed, but we need the msk around to reply to incoming DATA_FIN,
 	 * even if it is orphaned and in FIN_WAIT2 state
@@ -2699,9 +2711,6 @@ static void mptcp_worker(struct work_struct *work)
 		}
 	}
 
-	if (test_and_clear_bit(MPTCP_WORK_CLOSE_SUBFLOW, &msk->flags))
-		__mptcp_close_subflow(msk);
-
 	if (test_and_clear_bit(MPTCP_WORK_RTX, &msk->flags))
 		__mptcp_retrans(sk);
 
@@ -3149,6 +3158,7 @@ struct sock *mptcp_sk_clone(const struct sock *sk,
 	msk->local_key = subflow_req->local_key;
 	msk->token = subflow_req->token;
 	msk->subflow = NULL;
+	msk->in_accept_queue = 1;
 	WRITE_ONCE(msk->fully_established, false);
 	if (mp_opt->suboptions & OPTION_MPTCP_CSUMREQD)
 		WRITE_ONCE(msk->csum_enabled, true);
@@ -3169,8 +3179,7 @@ struct sock *mptcp_sk_clone(const struct sock *sk,
 	security_inet_csk_clone(nsk, req);
 	bh_unlock_sock(nsk);
 
-	/* keep a single reference */
-	__sock_put(nsk);
+	/* note: the newly allocated socket refcount is 2 now */
 	return nsk;
 }
 
@@ -3226,8 +3235,6 @@ static struct sock *mptcp_accept(struct sock *sk, int flags, int *err,
 			goto out;
 		}
 
-		/* acquire the 2nd reference for the owning socket */
-		sock_hold(new_mptcp_sock);
 		newsk = new_mptcp_sock;
 		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_MPCAPABLEPASSIVEACK);
 	} else {
@@ -3781,6 +3788,7 @@ static int mptcp_stream_accept(struct socket *sock, struct socket *newsock,
 		struct mptcp_subflow_context *subflow;
 
 		set_bit(SOCK_CUSTOM_SOCKOPT, &newsock->flags);
+		msk->in_accept_queue = 0;
 
 		/* set ssk->sk_socket of accept()ed flows to mptcp socket.
 		 * This is needed so NOSPACE flag can be set from tcp stack.
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 3a055438c65e..252f050c96c6 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -294,7 +294,8 @@ struct mptcp_sock {
 	u8		recvmsg_inq:1,
 			cork:1,
 			nodelay:1,
-			fastopening:1;
+			fastopening:1,
+			in_accept_queue:1;
 	int		connect_flags;
 	struct work_struct work;
 	struct sk_buff  *ooo_last_skb;
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index f075607adad4..1dff2ea6d6d3 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -693,9 +693,10 @@ static bool subflow_hmac_valid(const struct request_sock *req,
 
 static void mptcp_force_close(struct sock *sk)
 {
-	/* the msk is not yet exposed to user-space */
+	/* the msk is not yet exposed to user-space, and refcount is 2 */
 	inet_sk_state_store(sk, TCP_CLOSE);
 	sk_common_release(sk);
+	sock_put(sk);
 }
 
 static void subflow_ulp_fallback(struct sock *sk,
@@ -1854,7 +1855,6 @@ void mptcp_subflow_queue_clean(struct sock *listener_sk, struct sock *listener_s
 		struct sock *sk = (struct sock *)msk;
 		bool do_cancel_work;
 
-		sock_hold(sk);
 		lock_sock_nested(sk, SINGLE_DEPTH_NESTING);
 		next = msk->dl_next;
 		msk->dl_next = NULL;
@@ -1949,6 +1949,13 @@ static void subflow_ulp_release(struct sock *ssk)
 		 * the ctx alive, will be freed by __mptcp_close_ssk()
 		 */
 		release = ctx->disposable;
+
+		/* inet_child_forget() does not call sk_state_change(),
+		 * explicitly trigger the socket close machinery
+		 */
+		if (!release && !test_and_set_bit(MPTCP_WORK_CLOSE_SUBFLOW,
+						  &mptcp_sk(sk)->flags))
+			schedule_work(&mptcp_sk(sk)->work);
 		sock_put(sk);
 	}
 
-- 
2.39.1

