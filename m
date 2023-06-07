Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56E4538CAC
	for <mptcp@lists.linux.dev>; Wed,  7 Jun 2023 16:33:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1686155622;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=0oQkmYUAXPDgcyhIIv4olpmRnfX4924cXDdkf4mZPy4=;
	b=UTrAOCfuqD1IkaPVjhzxWPQft1r6CC2X1L3Yp11HlB6rNEH2RRRGBArsSuFyGZZkVfn7wd
	YaSiGaTHX385ToTWhjJcjSaSfkwk5UJxZ9qZ7+XFlFX7GhIaHw/Nx5NxlGzzKWVO1xlkHL
	kPrmYvTcLzJxHXUtOw0PdLIjw/6dGYc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-643-OdXSg4sSNQmatrxvSFgOYg-1; Wed, 07 Jun 2023 12:33:41 -0400
X-MC-Unique: OdXSg4sSNQmatrxvSFgOYg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1D88E801182
	for <mptcp@lists.linux.dev>; Wed,  7 Jun 2023 16:33:41 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.193.14])
	by smtp.corp.redhat.com (Postfix) with ESMTP id A0A7340D1B66
	for <mptcp@lists.linux.dev>; Wed,  7 Jun 2023 16:33:40 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-net 1/2] mptcp: fix possible list corruption on passive MPJ
Date: Wed,  7 Jun 2023 18:33:35 +0200
Message-Id: <f88902bdf5168d86a858575a95882e3fbbadf556.1686155270.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

At passive MPJ time, if the msk socket lock is held by the user,
the new subflow is appended to the msk->join_list under the msk
data lock.

In mptcp_release_cb()/__mptcp_flush_join_list(), the subflows in
that list are moved from the join_list into the conn_list under the
msk socket lock.

Append and removal could race, possibly corrupting such list.
Address the issue splicing the join list into a temporary one while
still under the msk data lock.

Found by code inspection, the race itself should be almost impossible
to trigger in practice.

Fixes: 3e5014909b56 ("mptcp: cleanup MPJ subflow list handling")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/protocol.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index f2e9f72c1c9a..94229a318fc1 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -854,12 +854,12 @@ static bool __mptcp_finish_join(struct mptcp_sock *msk, struct sock *ssk)
 	return true;
 }
 
-static void __mptcp_flush_join_list(struct sock *sk)
+static void __mptcp_flush_join_list(struct sock *sk, struct list_head *join_list)
 {
 	struct mptcp_subflow_context *tmp, *subflow;
 	struct mptcp_sock *msk = mptcp_sk(sk);
 
-	list_for_each_entry_safe(subflow, tmp, &msk->join_list, node) {
+	list_for_each_entry_safe(subflow, tmp, join_list, node) {
 		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
 		bool slow = lock_sock_fast(ssk);
 
@@ -3401,9 +3401,14 @@ static void mptcp_release_cb(struct sock *sk)
 	for (;;) {
 		unsigned long flags = (msk->cb_flags & MPTCP_FLAGS_PROCESS_CTX_NEED) |
 				      msk->push_pending;
+		struct list_head join_list;
+
 		if (!flags)
 			break;
 
+		INIT_LIST_HEAD(&join_list);
+		list_splice_init(&msk->join_list, &join_list);
+
 		/* the following actions acquire the subflow socket lock
 		 *
 		 * 1) can't be invoked in atomic scope
@@ -3414,8 +3419,9 @@ static void mptcp_release_cb(struct sock *sk)
 		msk->push_pending = 0;
 		msk->cb_flags &= ~flags;
 		spin_unlock_bh(&sk->sk_lock.slock);
+
 		if (flags & BIT(MPTCP_FLUSH_JOIN_LIST))
-			__mptcp_flush_join_list(sk);
+			__mptcp_flush_join_list(sk, &join_list);
 		if (flags & BIT(MPTCP_PUSH_PENDING))
 			__mptcp_push_pending(sk, 0);
 		if (flags & BIT(MPTCP_RETRANSMIT))
-- 
2.40.1

