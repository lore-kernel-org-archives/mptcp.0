Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C88B5BA2F
	for <mptcp@lists.linux.dev>; Thu, 25 May 2023 07:17:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1684999053;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Gsb4908GkOnJZxmQ0qWl6DCfidAj/to7N51dZR2wTOw=;
	b=V+CLlAwspv2m+m8CXTc3Vv+hmSwxqECK4sinYbv9M2H/dbYQy/JgzsftUM93BrAuakg0bO
	iBwzSsoiNyzo48aBNgGq1wlmn985L7KzSUGZTbfVGQ9EaSPo07DTiFIDDWcZ5xdMVODefp
	Uypq8OExiPgwxPaSq2+tXyGJKWGrooo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-152-ga3MLYFPPgmqVUFK7XnrLA-1; Thu, 25 May 2023 03:17:30 -0400
X-MC-Unique: ga3MLYFPPgmqVUFK7XnrLA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 42FB5811E7F;
	Thu, 25 May 2023 07:17:30 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.193.113])
	by smtp.corp.redhat.com (Postfix) with ESMTP id A7392492B0A;
	Thu, 25 May 2023 07:17:29 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Cc: Florian Westphal <fw@strlen.de>
Subject: [PATCH v6 mptcp-next 4/6] mptcp: add subflow unique id
Date: Thu, 25 May 2023 09:17:11 +0200
Message-Id: <a627cb92f8118c87513c9b0c66ecb348c82e1e2c.1684997011.git.pabeni@redhat.com>
In-Reply-To: <cover.1684997011.git.pabeni@redhat.com>
References: <cover.1684997011.git.pabeni@redhat.com>
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
index 79b3059ca3ef..895eda3d79e8 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -96,6 +96,7 @@ static int __mptcp_socket_create(struct mptcp_sock *msk)
 	list_add(&subflow->node, &msk->conn_list);
 	sock_hold(ssock->sk);
 	subflow->request_mptcp = 1;
+	subflow->subflow_id = msk->subflow_id++;
 
 	/* This is the first subflow, always with id 0 */
 	subflow->local_id_valid = 1;
@@ -847,6 +848,7 @@ static bool __mptcp_finish_join(struct mptcp_sock *msk, struct sock *ssk)
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
 
@@ -3210,6 +3213,9 @@ struct sock *mptcp_sk_clone_init(const struct sock *sk,
 	msk->setsockopt_seq = mptcp_sk(sk)->setsockopt_seq;
 	mptcp_init_sched(msk, mptcp_sk(sk)->sched);
 
+	/* passive msk is created after the first/MPC subflow */
+	msk->subflow_id = 2;
+
 	sock_reset_flag(nsk, SOCK_RCU_FREE);
 	security_inet_csk_clone(nsk, req);
 
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index ec733955f18e..b4b5c5004f34 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -323,7 +323,8 @@ struct mptcp_sock {
 		u64	rtt_us; /* last maximum rtt of subflows */
 	} rcvq_space;
 
-	u32 setsockopt_seq;
+	u32		subflow_id;
+	u32		setsockopt_seq;
 	char		ca_name[TCP_CA_NAME_MAX];
 	struct mptcp_sock	*dl_next;
 };
@@ -505,6 +506,8 @@ struct mptcp_subflow_context {
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

