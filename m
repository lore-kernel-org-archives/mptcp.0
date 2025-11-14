Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 941832FFF8D
	for <mptcp@lists.linux.dev>; Fri, 14 Nov 2025 09:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763111852; cv=none; b=RYMus64dPTjJrSlOB0S7MfD2xN5GznF8Uop2g/wJE1hvzj1QXIzlYWAVClQ72QWMRp3Or6MyWMxiEELgRlw2B0RY4HVfAgNNXtoDygDFw2sJXhSMzB6dPLcIyeGim3HLh/eVrfa/RcIayhElfXYOOiWhHf3Z913s9yEViY1oH0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763111852; c=relaxed/simple;
	bh=ZFSichs7VCZoDKwgYB3F9ufWUlKfDQW7rCXhsuAWdq8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=DcdVT3ACu3cmuozvvKjNxrwC9J9tuAZFUcLM8YdQesLYlO6Cv2P7wxdQO88dlQWzQoVOfEsHakOFdH/WDM+NvhjXm8AJfM4zVWn0sQjnh6Srnm1REz7XMUbHP/hoK12e4Vgs+sH/qplzm9rFmMHuLS56L3MlALaushv3sxb8ud0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Cty7Q7uX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Cty7Q7uX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763111849;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nEQ7pEH5g/wMbOVnibEWnOJT+RPdVKjpC3uYflBWDig=;
	b=Cty7Q7uXJ67cHC//25g7runXIW8gjhbWoxgvfhyoLPn72mL/hjWR1ahG7NXPjf9Gf8Q/DX
	KhHk331F+eUO4hwkAwxAuxushjOU58HNNDyYD7twVTXxgl8L1r+84QjknpOv6x4Fb/IYBx
	ws3qISuk+u93ADEHN7kDbgms7hasFv4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-647-SI5dmxzvOrqKlnSFH0Mdzw-1; Fri,
 14 Nov 2025 04:17:28 -0500
X-MC-Unique: SI5dmxzvOrqKlnSFH0Mdzw-1
X-Mimecast-MFC-AGG-ID: SI5dmxzvOrqKlnSFH0Mdzw_1763111847
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 94FC818001D1
	for <mptcp@lists.linux.dev>; Fri, 14 Nov 2025 09:17:27 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.32.173])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8FE9E180049F
	for <mptcp@lists.linux.dev>; Fri, 14 Nov 2025 09:17:26 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH v4 mptcp-next 2/3] Squash-to: "mptcp: fix memcg accounting for passive sockets"
Date: Fri, 14 Nov 2025 10:17:13 +0100
Message-ID: <3a879a5ea9b186b7966c373d6d18f35165133a40.1763111767.git.pabeni@redhat.com>
In-Reply-To: <cover.1763111767.git.pabeni@redhat.com>
References: <cover.1763111767.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 0OaICK8FNh7DOfOCpOBaHxJ1eggy7OlpVKgliLv5TMc_1763111847
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

__mptcp_inherit_memcg() is currently invoked by mptcp_graph_subflows()
with the wrong GFP flags, as lock_sock_fast() can yield atomic scope.

Since this is not the most extreme fast path, use plain lock_sock()
instead.

Additionally move the subflow CG initialization earlier under the msk data
lock, so that the next patch could use the latter as a synchronization
point to ensure all subflows are CG accounted.

Finally fix a typo in the mentioned helper name.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
v3 -> v4:
  - rebased
---
 net/mptcp/protocol.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 4a4cb9952596..2364c144bf4f 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -936,8 +936,6 @@ static bool __mptcp_finish_join(struct mptcp_sock *msk, struct sock *ssk)
 	mptcp_subflow_ctx(ssk)->subflow_id = msk->subflow_id++;
 	mptcp_sockopt_sync_locked(msk, ssk);
 	mptcp_stop_tout_timer(sk);
-	__mptcp_inherit_cgrp_data(sk, ssk);
-	__mptcp_inherit_memcg(sk, ssk, GFP_ATOMIC);
 	__mptcp_propagate_sndbuf(sk, ssk);
 	return true;
 }
@@ -3764,8 +3762,11 @@ static void mptcp_sock_check_graft(struct sock *sk, struct sock *ssk)
 	write_lock_bh(&sk->sk_callback_lock);
 	sock = sk->sk_socket;
 	write_unlock_bh(&sk->sk_callback_lock);
-	if (sock)
+	if (sock) {
 		mptcp_sock_graft(ssk, sock);
+		__mptcp_inherit_cgrp_data(sk, ssk);
+		__mptcp_inherit_memcg(sk, ssk, GFP_ATOMIC);
+	}
 }
 
 bool mptcp_finish_join(struct sock *ssk)
@@ -4083,18 +4084,17 @@ static int mptcp_listen(struct socket *sock, int backlog)
 	return err;
 }
 
-static void mptcp_graph_subflows(struct sock *sk)
+static void mptcp_graft_subflows(struct sock *sk)
 {
 	struct mptcp_subflow_context *subflow;
 	struct mptcp_sock *msk = mptcp_sk(sk);
 
 	mptcp_for_each_subflow(msk, subflow) {
 		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
-		bool slow;
 
-		slow = lock_sock_fast(ssk);
+		lock_sock(ssk);
 
-		/* set ssk->sk_socket of accept()ed flows to mptcp socket.
+		/* Set ssk->sk_socket of accept()ed flows to mptcp socket.
 		 * This is needed so NOSPACE flag can be set from tcp stack.
 		 */
 		if (!ssk->sk_socket)
@@ -4102,7 +4102,7 @@ static void mptcp_graph_subflows(struct sock *sk)
 
 		__mptcp_inherit_cgrp_data(sk, ssk);
 		__mptcp_inherit_memcg(sk, ssk, GFP_KERNEL);
-		unlock_sock_fast(ssk, slow);
+		release_sock(ssk);
 	}
 }
 
@@ -4153,7 +4153,7 @@ static int mptcp_stream_accept(struct socket *sock, struct socket *newsock,
 		msk = mptcp_sk(newsk);
 		msk->in_accept_queue = 0;
 
-		mptcp_graph_subflows(newsk);
+		mptcp_graft_subflows(newsk);
 		mptcp_rps_record_subflows(msk);
 
 		/* Do late cleanup for the first subflow as necessary. Also
-- 
2.51.1

