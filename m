Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 220867484
	for <mptcp@lists.linux.dev>; Thu,  4 May 2023 16:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1683218409;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aufn6V7/vKjwjO0iPIY+KfPJUxnB5NFZC8y5CTaQyhk=;
	b=dGj4vJ06nsGyT2S3AhAuuXnxiwrleW40FBezHz6n/Iud9wGqMyLldZxTEESdS7TZCURw+a
	Rce/LBFoC40E6Xotu88I3gnVUmVRAzjQwck0Euk0WbFXyW4AW1p+AZ7jZpJuPAT+xKyn9U
	FeOz+33q7Gh9FXhkny8PDeyuDoK6K9Q=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-644-guai4iQRNfmVbqt1qKZOtA-1; Thu, 04 May 2023 12:40:08 -0400
X-MC-Unique: guai4iQRNfmVbqt1qKZOtA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 32436101A531
	for <mptcp@lists.linux.dev>; Thu,  4 May 2023 16:40:08 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.193.75])
	by smtp.corp.redhat.com (Postfix) with ESMTP id B68321121331
	for <mptcp@lists.linux.dev>; Thu,  4 May 2023 16:40:07 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next 1/4] mptcp: add subflow unique id
Date: Thu,  4 May 2023 18:39:59 +0200
Message-Id: <456718f354d8db508b2db8590d9b055d49c728e9.1683212362.git.pabeni@redhat.com>
In-Reply-To: <cover.1683212362.git.pabeni@redhat.com>
References: <cover.1683212362.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

The user-space need to preperly account the data received/sent by
individual subflows. When additional subflows are created and/or
closed during the MPTCP socket lifetime, the information currently
exposed via MPTCP_TCPINFO are not enough: subflows are identifed only
by the sequential position inside the info dumps, and that will change
with the above mentioned events.

To solve the above problem, this patch introduces a new subflow identifier
that is unique inside the given mptcp socket scope.

The initial subflow get the id 1 and the other subflows get incremental
values at join time.

The identifier is exposed to user-space overloading tcpi_fackets in
MPTCP_TCPINFO.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 include/uapi/linux/mptcp.h | 3 +++
 net/mptcp/protocol.c       | 3 +++
 net/mptcp/protocol.h       | 5 ++++-
 net/mptcp/sockopt.c        | 1 +
 4 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/mptcp.h b/include/uapi/linux/mptcp.h
index 32af2d278cb4..49bfbf85cb80 100644
--- a/include/uapi/linux/mptcp.h
+++ b/include/uapi/linux/mptcp.h
@@ -249,4 +249,7 @@ struct mptcp_subflow_addrs {
 #define MPTCP_TCPINFO		2
 #define MPTCP_SUBFLOW_ADDRS	3
 
+/* MPTCP_TCPINFO overload obsoleted tcp fields with MPTCP-specific info */
+#define tcpi_subflow_id		tcpi_fackets
+
 #endif /* _UAPI_MPTCP_H */
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 2d331b2d62b7..7f5c89315aad 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -96,6 +96,7 @@ static int __mptcp_socket_create(struct mptcp_sock *msk)
 	list_add(&subflow->node, &msk->conn_list);
 	sock_hold(ssock->sk);
 	subflow->request_mptcp = 1;
+	subflow->subflow_id = msk->subflow_id++;
 
 	/* This is the first subflow, always with id 0 */
 	subflow->local_id_valid = 1;
@@ -838,6 +839,7 @@ static bool __mptcp_finish_join(struct mptcp_sock *msk, struct sock *ssk)
 	if (sk->sk_socket && !ssk->sk_socket)
 		mptcp_sock_graft(ssk, sk->sk_socket);
 
+	mptcp_subflow_ctx(ssk)->subflow_id = msk->subflow_id++;
 	mptcp_sockopt_sync_locked(msk, ssk);
 	return true;
 }
@@ -2726,6 +2728,7 @@ static int __mptcp_init_sock(struct sock *sk)
 	WRITE_ONCE(msk->csum_enabled, mptcp_is_checksum_enabled(sock_net(sk)));
 	WRITE_ONCE(msk->allow_infinite_fallback, true);
 	msk->recovery = false;
+	msk->subflow_id = 1;
 
 	mptcp_pm_data_init(msk);
 
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 2d7b2c80a164..babf1230c84d 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -316,7 +316,8 @@ struct mptcp_sock {
 		u64	rtt_us; /* last maximum rtt of subflows */
 	} rcvq_space;
 
-	u32 setsockopt_seq;
+	u32		subflow_id;
+	u32		setsockopt_seq;
 	char		ca_name[TCP_CA_NAME_MAX];
 	struct mptcp_sock	*dl_next;
 };
@@ -497,6 +498,8 @@ struct mptcp_subflow_context {
 	u8	reset_reason:4;
 	u8	stale_count;
 
+	u32	subflow_id;
+
 	long	delegated_status;
 	unsigned long	fail_tout;
 
diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index d4258869ac48..d2aa02e28917 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -1032,6 +1032,7 @@ static int mptcp_getsockopt_tcpinfo(struct mptcp_sock *msk, char __user *optval,
 			struct tcp_info info;
 
 			tcp_get_info(ssk, &info);
+			info.tcpi_subflow_id = subflow->subflow_id;
 
 			if (copy_to_user(infoptr, &info, sfd.size_user)) {
 				release_sock(sk);
-- 
2.40.0

