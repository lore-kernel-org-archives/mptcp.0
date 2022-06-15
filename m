Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E6763D96
	for <mptcp@lists.linux.dev>; Wed, 15 Jun 2022 20:28:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1655324907;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PKbQkM9NksZKJWJ79oRNw0LFN3Wzl0ZPlA4jqwkj9vg=;
	b=JJC3LArtC4MOG9n8Qxlgbio3JnccrZGM31MUEHJkarcx7GeQr7wtbEiFWQSObHOqP+CQyU
	oNc1q85Z1TUydQ9VEh/EYM3oHkMFUSxL5x0uCzHHzfVHH9O3wBn6PdR6d75JgDNIn77N+M
	zjPtjYHFYHRYtLTnZquhawbLZYprDiE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-673-5980L5PfOIWo_K4k24FRNw-1; Wed, 15 Jun 2022 16:28:26 -0400
X-MC-Unique: 5980L5PfOIWo_K4k24FRNw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C0B06811E80
	for <mptcp@lists.linux.dev>; Wed, 15 Jun 2022 20:28:25 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.193.220])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 502BD400F3FF
	for <mptcp@lists.linux.dev>; Wed, 15 Jun 2022 20:28:25 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-net v2 6/6] mptcp: fix race on unaccepted mptcp sockets
Date: Wed, 15 Jun 2022 22:28:13 +0200
Message-Id: <a87184583103c8dd66dc9e314ccb99d3daadc00e.1655324843.git.pabeni@redhat.com>
In-Reply-To: <cover.1655324843.git.pabeni@redhat.com>
References: <cover.1655324843.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

When the listener socket owning the relevant request is closed,
it frees the unaccepted subflows and that causes later deletion
of the paired MPTCP sockets.

The mptcp socket's worker can run in the time interval between such delete
operations. When that happens, any access to msk->first will cause an UaF
access, as the subflow cleanup did not cleared such field in the mptcp
socket.

Address the issue explictly traversing the listener socket accept
queue at close time and performing the needed cleanup on the pending
msk.

Note that the locking is a bit tricky, as we need to acquire the msk
socket lock, while still owning the subflow socket one.

Fixes: 86e39e04482b ("mptcp: keep track of local endpoint still available for each msk")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/protocol.c |  5 +++++
 net/mptcp/protocol.h |  2 ++
 net/mptcp/subflow.c  | 50 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 57 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 4f4d6c66e190..35e3060233c9 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2318,6 +2318,11 @@ static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 		kfree_rcu(subflow, rcu);
 	} else {
 		/* otherwise tcp will dispose of the ssk and subflow ctx */
+		if (ssk->sk_state == TCP_LISTEN) {
+			tcp_set_state(ssk, TCP_CLOSE);
+			mptcp_subflow_queue_clean(ssk);
+			inet_csk_listen_stop(ssk);
+		}
 		__tcp_close(ssk, 0);
 
 		/* close acquired an extra ref */
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index ad9b02b1b3e6..95c9ace1437b 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -306,6 +306,7 @@ struct mptcp_sock {
 
 	u32 setsockopt_seq;
 	char		ca_name[TCP_CA_NAME_MAX];
+	struct mptcp_sock	*dl_next;
 };
 
 #define mptcp_data_lock(sk) spin_lock_bh(&(sk)->sk_lock.slock)
@@ -610,6 +611,7 @@ void mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 		     struct mptcp_subflow_context *subflow);
 void mptcp_subflow_send_ack(struct sock *ssk);
 void mptcp_subflow_reset(struct sock *ssk);
+void mptcp_subflow_queue_clean(struct sock *ssk);
 void mptcp_sock_graft(struct sock *sk, struct socket *parent);
 struct socket *__mptcp_nmpc_socket(const struct mptcp_sock *msk);
 
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index bec36e2bcc32..02a12f271a60 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1717,6 +1717,56 @@ static void subflow_state_change(struct sock *sk)
 	}
 }
 
+void mptcp_subflow_queue_clean(struct sock *listener_ssk)
+{
+	struct request_sock_queue *queue = &inet_csk(listener_ssk)->icsk_accept_queue;
+	struct mptcp_sock *msk, *next, *head = NULL;
+	struct request_sock *req;
+
+	/* build a list of all unaccepted mptcp sockets */
+	spin_lock_bh(&queue->rskq_lock);
+	for (req = queue->rskq_accept_head; req; req = req->dl_next) {
+		struct mptcp_subflow_context *subflow;
+		struct sock *ssk = req->sk;
+		struct mptcp_sock *msk;
+
+		if (!sk_is_mptcp(ssk))
+			continue;
+
+		subflow = mptcp_subflow_ctx(ssk);
+		if (!subflow || !subflow->conn)
+			continue;
+
+		/* skip if already in list */
+		msk = mptcp_sk(subflow->conn);
+		if (msk->dl_next || msk == head)
+			continue;
+
+		msk->dl_next = head;
+		head = msk;
+	}
+	spin_unlock_bh(&queue->rskq_lock);
+	if (!head)
+		return;
+
+	/* can't acquire the msk socket lock under the subflow one,
+	 * or will cause ABBA deadlock
+	 */
+	release_sock(listener_ssk);
+
+	for (msk = head; msk; msk = next) {
+		struct sock *sk = (struct sock *)msk;
+		bool slow;
+
+		slow = lock_sock_fast_nested(sk);
+		next = msk->dl_next;
+		msk->first = NULL;
+		msk->dl_next = NULL;
+		unlock_sock_fast(sk, slow);
+	}
+	lock_sock(listener_ssk);
+}
+
 static int subflow_ulp_init(struct sock *sk)
 {
 	struct inet_connection_sock *icsk = inet_csk(sk);
-- 
2.35.3

