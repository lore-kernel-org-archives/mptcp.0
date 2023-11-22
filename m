Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 243584A99B
	for <mptcp@lists.linux.dev>; Wed, 22 Nov 2023 16:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z7BkyQr1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700670094;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=0kcCqkJwZLeUek61NS8uZNUlOKvMZ4/JGYmw71R9BFI=;
	b=Z7BkyQr17b/RBif8uSuc3SIQMVkbOruBFU7G0uEVlawA75jSm/x9tzhWU5usNd+0AL/94a
	GVOu0+mSgNdGbBzXZlzPzA32hSvyg7UmWpKPeBZgfhApWT3eqHT1LFmOowbtuhVlPSs+jw
	c5eb/OW0Wq/f0BXby7mJnLFEe5X19jE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-656--CX83Q1rMDCTY7ES66e-Ow-1; Wed, 22 Nov 2023 11:21:32 -0500
X-MC-Unique: -CX83Q1rMDCTY7ES66e-Ow-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 96D238007B3
	for <mptcp@lists.linux.dev>; Wed, 22 Nov 2023 16:21:32 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.225.207])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 24039C1596F
	for <mptcp@lists.linux.dev>; Wed, 22 Nov 2023 16:21:31 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-net-next] mptcp: cleanup state propagation.
Date: Wed, 22 Nov 2023 17:21:26 +0100
Message-ID: <240a97d522887a938faeb24a6a3e3a9ed24570b1.1700667908.git.pabeni@redhat.com>
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

When propagating the first subflow state via the release_cb, the
msk must actually take to 2 separate actions: state sync-up and
send buffer sync-up. Relaying on the specific flags instead of
bounding both in __mptcp_sync_state(), allows cleaning up a bit
the code.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/protocol.c | 3 +--
 net/mptcp/subflow.c  | 5 ++---
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 199b2e09f1ac..4fc038d29623 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3404,9 +3404,8 @@ static void mptcp_release_cb(struct sock *sk)
 	if (unlikely(msk->cb_flags)) {
 		/* be sure to sync the msk state before taking actions
 		 * depending on sk_state (MPTCP_ERROR_REPORT)
-		 * On sk release avoid actions depending on the first subflow
 		 */
-		if (__test_and_clear_bit(MPTCP_SYNC_STATE, &msk->cb_flags) && msk->first)
+		if (__test_and_clear_bit(MPTCP_SYNC_STATE, &msk->cb_flags))
 			__mptcp_sync_state(sk, msk->pending_state);
 		if (__test_and_clear_bit(MPTCP_ERROR_REPORT, &msk->cb_flags))
 			__mptcp_error_report(sk);
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 6d7684c35e93..64302a1ac306 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -421,9 +421,6 @@ static bool subflow_use_different_dport(struct mptcp_sock *msk, const struct soc
 
 void __mptcp_sync_state(struct sock *sk, int state)
 {
-	struct mptcp_sock *msk = mptcp_sk(sk);
-
-	__mptcp_propagate_sndbuf(sk, msk->first);
 	if (sk->sk_state == TCP_SYN_SENT) {
 		inet_sk_state_store(sk, state);
 		sk->sk_state_change(sk);
@@ -436,10 +433,12 @@ static void mptcp_propagate_state(struct sock *sk, struct sock *ssk)
 
 	mptcp_data_lock(sk);
 	if (!sock_owned_by_user(sk)) {
+		__mptcp_propagate_sndbuf(sk, msk->first);
 		__mptcp_sync_state(sk, ssk->sk_state);
 	} else {
 		msk->pending_state = ssk->sk_state;
 		__set_bit(MPTCP_SYNC_STATE, &msk->cb_flags);
+		__set_bit(MPTCP_SYNC_SNDBUF, &msk->cb_flags);
 	}
 	mptcp_data_unlock(sk);
 }
-- 
2.41.0

