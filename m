Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8682B206A8
	for <mptcp@lists.linux.dev>; Tue, 23 May 2023 17:37:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1684863455;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1eVJzRfpuRDooyTPMWRikPWwGwaEqCH2TqU1KiUpAPA=;
	b=aVt0GVFeSSWfayvIjIh2LPHJNgPifUz6CYlBx6wih1G7CIvqSvo/eG5Sfpawj8tf0QYibd
	OEQNUhSliWNt6DgRMx+9kg0tHdfwQxRwMzHtQcAaRBZeMgpqoOUuUsD5siFR6SNYY/gMMC
	SJwDsN5/T4ggQN7+BoH8gnbHSd31S+g=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-407-NeuBOTaVMzSnhUWkN_Wd9Q-1; Tue, 23 May 2023 13:37:34 -0400
X-MC-Unique: NeuBOTaVMzSnhUWkN_Wd9Q-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B100085A5B5
	for <mptcp@lists.linux.dev>; Tue, 23 May 2023 17:37:33 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.193.138])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 414F7140E95D
	for <mptcp@lists.linux.dev>; Tue, 23 May 2023 17:37:33 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH v3 mptcp-next 1/6] mptcp: add subflow unique id
Date: Tue, 23 May 2023 19:37:24 +0200
Message-Id: <1c34f66818566a46418b5de33e0a32f572604615.1684863309.git.pabeni@redhat.com>
In-Reply-To: <cover.1684863309.git.pabeni@redhat.com>
References: <cover.1684863309.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
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

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
v2 -> v3:
 - fix msk subflow_id init (Matttbe)

v1 -> v2:
 - properly set subflow_id for the first passive subflow and active subflows, too
 - drop the tcpi_fackets overload
---
 net/mptcp/protocol.c | 6 ++++++
 net/mptcp/protocol.h | 5 ++++-
 net/mptcp/subflow.c  | 2 ++
 3 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 28da6a9fe8fd..9998b2dd150e 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -96,6 +96,7 @@ static int __mptcp_socket_create(struct mptcp_sock *msk)
 	list_add(&subflow->node, &msk->conn_list);
 	sock_hold(ssock->sk);
 	subflow->request_mptcp = 1;
+	subflow->subflow_id = msk->subflow_id++;
 
 	/* This is the first subflow, always with id 0 */
 	subflow->local_id_valid = 1;
@@ -845,6 +846,7 @@ static bool __mptcp_finish_join(struct mptcp_sock *msk, struct sock *ssk)
 	if (sk->sk_socket && !ssk->sk_socket)
 		mptcp_sock_graft(ssk, sk->sk_socket);
 
+	mptcp_subflow_ctx(ssk)->subflow_id = msk->subflow_id++;
 	mptcp_sockopt_sync_locked(msk, ssk);
 	mptcp_subflow_joined(msk, ssk);
 	return true;
@@ -2775,6 +2777,7 @@ static int __mptcp_init_sock(struct sock *sk)
 	WRITE_ONCE(msk->csum_enabled, mptcp_is_checksum_enabled(sock_net(sk)));
 	WRITE_ONCE(msk->allow_infinite_fallback, true);
 	msk->recovery = false;
+	msk->subflow_id = 1;
 
 	mptcp_pm_data_init(msk);
 
@@ -3206,6 +3209,9 @@ struct sock *mptcp_sk_clone_init(const struct sock *sk,
 	msk->setsockopt_seq = mptcp_sk(sk)->setsockopt_seq;
 	mptcp_init_sched(msk, mptcp_sk(sk)->sched);
 
+	/* passive msk is created after the first/MPC subflow */
+	msk->subflow_id = 2;
+
 	sock_reset_flag(nsk, SOCK_RCU_FREE);
 	security_inet_csk_clone(nsk, req);
 
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index de94c01746dc..f9180ecce5e4 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -319,7 +319,8 @@ struct mptcp_sock {
 		u64	rtt_us; /* last maximum rtt of subflows */
 	} rcvq_space;
 
-	u32 setsockopt_seq;
+	u32		subflow_id;
+	u32		setsockopt_seq;
 	char		ca_name[TCP_CA_NAME_MAX];
 	struct mptcp_sock	*dl_next;
 };
@@ -501,6 +502,8 @@ struct mptcp_subflow_context {
 	u8	reset_reason:4;
 	u8	stale_count;
 
+	u32	subflow_id;
+
 	long	delegated_status;
 	unsigned long	fail_tout;
 
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 63ac4dc621d4..c7001a23550a 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -819,6 +819,7 @@ static struct sock *subflow_syn_recv_sock(const struct sock *sk,
 			if (!ctx->conn)
 				goto fallback;
 
+			ctx->subflow_id = 1;
 			owner = mptcp_sk(ctx->conn);
 			mptcp_pm_new_connection(owner, child, 1);
 
@@ -1574,6 +1575,7 @@ int __mptcp_subflow_connect(struct sock *sk, const struct mptcp_addr_info *loc,
 	subflow->remote_id = remote_id;
 	subflow->request_join = 1;
 	subflow->request_bkup = !!(flags & MPTCP_PM_ADDR_FLAG_BACKUP);
+	subflow->subflow_id = msk->subflow_id++;
 	mptcp_info2sockaddr(remote, &addr, ssk->sk_family);
 
 	sock_hold(ssk);
-- 
2.40.1

