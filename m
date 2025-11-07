Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A91830F7FE
	for <mptcp@lists.linux.dev>; Fri,  7 Nov 2025 21:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762552567; cv=none; b=UXJXZTHzM/kHOLzP+26l7vYyPs6ocjOEi1q01i7XmjABNNSXs/2foa/yM2+jQwILuB8e+xLBUucPG1Q84QPKzuY9x6G8YsSQoaRaELGcJIpKYJHV9Eshfq5zFfMampdWXgAhbYkSeRLwjFGekNMG/IMQzW+4ZGgzLeXQmXbAbLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762552567; c=relaxed/simple;
	bh=1C/kKz/uV+sdUPonXIGCW9FKDrPQwiLyIoZiNC6Cn+k=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=iK+pYx+YstczBOw5fqZP9vCkv7opnPzd4XXGCXq4m0046nbIDasyUS29fFZ8XoA07pC8lK4QpWijm6F5Ve8zRnMIbMMFkwhbV2YJIzoR0BDsWecr9rBVJv1PlCxQ/EqtMiVhdt6Gpd4BRZW2kzolEqBhBHTnGkQKzAXmwH5Mzkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YSjhnhGs; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YSjhnhGs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762552565;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UEjlN43R/ES2J9/+tGFkSuZt6aRiFLz9EBRnTqRiNu4=;
	b=YSjhnhGsj444qPsEkyO6G15ZYqZggXnrT39smuHVBfbCSRtBXR852IO8y3rC/zLXaRQqcZ
	bJWD/yI9wurZ7CEZgxSc2Ng5pX5MEyd8u6xXlCe53TkGb9sEDsu1XLcvpEYH+HaBm4QZU1
	BE1FBZ6JXY8u6OdPklO8ZU55t43tjBY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-479-TUrSo7AeMS6j4OyusHRMLg-1; Fri,
 07 Nov 2025 16:56:02 -0500
X-MC-Unique: TUrSo7AeMS6j4OyusHRMLg-1
X-Mimecast-MFC-AGG-ID: TUrSo7AeMS6j4OyusHRMLg_1762552561
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9137E180047F
	for <mptcp@lists.linux.dev>; Fri,  7 Nov 2025 21:56:01 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.32.157])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id ACFAC19560B2
	for <mptcp@lists.linux.dev>; Fri,  7 Nov 2025 21:56:00 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-net 3/3] mptcp: fix memcg accounting for passive sockets
Date: Fri,  7 Nov 2025 22:55:47 +0100
Message-ID: <b78e4fb6552cc0b94aa9c1471590d7af1ec2a221.1762551942.git.pabeni@redhat.com>
In-Reply-To: <cover.1762551942.git.pabeni@redhat.com>
References: <cover.1762551942.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: xtZs33RpI3I9ZuFqAtXweM_KB4sePM_RDF6mCa-MpzM_1762552561
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

The passive sockets never got proper memcg accounting: the msk
socket is associated with the memcg at accept time, but the
passive subflows never got it right.

At accept time, traverse the subflows list and associate each of them
with the msk memcg, and try to do the same at join completion time, if
the msk has been already accepted.

Fixes: cf7da0d66cc1 ("mptcp: Create SUBFLOW socket for incoming connections")
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/298
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/597
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/protocol.c | 36 ++++++++++++++++++++++++++----------
 net/mptcp/protocol.h |  1 +
 net/mptcp/subflow.c  | 10 ++++++++++
 3 files changed, 37 insertions(+), 10 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 34e6bc731085..5e9325c7ea9c 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -959,6 +959,8 @@ static bool __mptcp_finish_join(struct mptcp_sock *msk, struct sock *ssk)
 	mptcp_subflow_ctx(ssk)->subflow_id = msk->subflow_id++;
 	mptcp_sockopt_sync_locked(msk, ssk);
 	mptcp_stop_tout_timer(sk);
+	__mptcp_inherit_cgrp_data(sk, ssk);
+	__mptcp_inherit_memcg(sk, ssk, GFP_ATOMIC);
 	__mptcp_propagate_sndbuf(sk, ssk);
 	__mptcp_propagate_rcvspace(sk, ssk);
 	return true;
@@ -4076,6 +4078,29 @@ static int mptcp_listen(struct socket *sock, int backlog)
 	return err;
 }
 
+static void mptcp_graph_subflows(struct sock *sk)
+{
+	struct mptcp_subflow_context *subflow;
+	struct mptcp_sock *msk = mptcp_sk(sk);
+
+	mptcp_for_each_subflow(msk, subflow) {
+		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
+		bool slow;
+
+		slow = lock_sock_fast(ssk);
+
+		/* set ssk->sk_socket of accept()ed flows to mptcp socket.
+		 * This is needed so NOSPACE flag can be set from tcp stack.
+		 */
+		if (!ssk->sk_socket)
+			mptcp_sock_graft(ssk, sk->sk_socket);
+
+		__mptcp_inherit_cgrp_data(sk, ssk);
+		__mptcp_inherit_memcg(sk, ssk, GFP_KERNEL);
+		unlock_sock_fast(ssk, slow);
+	}
+}
+
 static int mptcp_stream_accept(struct socket *sock, struct socket *newsock,
 			       struct proto_accept_arg *arg)
 {
@@ -4123,16 +4148,7 @@ static int mptcp_stream_accept(struct socket *sock, struct socket *newsock,
 		msk = mptcp_sk(newsk);
 		msk->in_accept_queue = 0;
 
-		/* set ssk->sk_socket of accept()ed flows to mptcp socket.
-		 * This is needed so NOSPACE flag can be set from tcp stack.
-		 */
-		mptcp_for_each_subflow(msk, subflow) {
-			struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
-
-			if (!ssk->sk_socket)
-				mptcp_sock_graft(ssk, newsock);
-		}
-
+		mptcp_graph_subflows(newsk);
 		mptcp_rps_record_subflows(msk);
 
 		/* Do late cleanup for the first subflow as necessary. Also
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 300ac7030958..60bfe50530dc 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -755,6 +755,7 @@ mptcp_subflow_delegated_next(struct mptcp_delegated_action *delegated)
 	return ret;
 }
 
+void __mptcp_inherit_memcg(struct sock *sk, struct sock *ssk, gfp_t gfp);
 void __mptcp_inherit_cgrp_data(struct sock *sk, struct sock *ssk);
 
 int mptcp_is_enabled(const struct net *net);
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 599a21d92590..39bf69e73975 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1721,6 +1721,16 @@ int __mptcp_subflow_connect(struct sock *sk, const struct mptcp_pm_local *local,
 	return err;
 }
 
+void __mptcp_inherit_memcg(struct sock *sk, struct sock *ssk, gfp_t gfp)
+{
+	/* Only if the msk has been accepted already (and not orphaned).*/
+	if (!mem_cgroup_sockets_enabled || !sk->sk_socket)
+		return;
+
+	mem_cgroup_sk_inherit(sk, ssk);
+	__sk_charge(ssk, gfp);
+}
+
 void __mptcp_inherit_cgrp_data(struct sock *sk, struct sock *ssk)
 {
 #ifdef CONFIG_SOCK_CGROUP_DATA
-- 
2.51.0

