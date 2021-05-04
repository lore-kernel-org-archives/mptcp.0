Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DF8F70
	for <mptcp@lists.linux.dev>; Tue,  4 May 2021 21:29:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1620163790;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V7fNPcM9xYHMDIVE2mVjOnMR1FYUQky74yTKMpuJHGA=;
	b=HZ9o69C8TOZBGIF7Eq8nh4VWmjBa2RkP37BBFhuZcc2AYrU7LifVFCq8JkOVB4v3kVeFei
	+8H+PQlqT9+D5MvwLJR0cmm3XlsFFoJKKI4+qrgx+sbpIPcEmPTn8LFRX0+UJFVJ7KeIWb
	cG+xyqxQ3q2vW9MAQF9JYDyETLApMyQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-598-iqVVfnEAN9-P01TW2tvY4A-1; Tue, 04 May 2021 17:29:48 -0400
X-MC-Unique: iqVVfnEAN9-P01TW2tvY4A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A209D18B9EC3;
	Tue,  4 May 2021 21:29:47 +0000 (UTC)
Received: from gerbillo.redhat.com (ovpn-114-126.ams2.redhat.com [10.36.114.126])
	by smtp.corp.redhat.com (Postfix) with ESMTP id E27A66090F;
	Tue,  4 May 2021 21:29:46 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>
Subject: [PATCH v5 mptcp-next 03/21] mptcp: add csum_reqd in mptcp_out_options
Date: Tue,  4 May 2021 23:29:13 +0200
Message-Id: <221b0bbe00cb899ba6840d1de8c11c7868a07e63.1620162984.git.pabeni@redhat.com>
In-Reply-To: <cover.1620162984.git.pabeni@redhat.com>
References: <cover.1620162984.git.pabeni@redhat.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"

From: Geliang Tang <geliangtang@gmail.com>

This patch added a new member csum_reqd in struct mptcp_out_options and
struct mptcp_subflow_request_sock. Initialized it with the helper
function mptcp_is_checksum_enabled().

In mptcp_write_options, if this field is enabled, send out the MP_CAPABLE
suboption with the MPTCP_CAP_CHECKSUM_REQD flag.

Signed-off-by: Geliang Tang <geliangtang@gmail.com>
---
 include/net/mptcp.h  |  3 ++-
 net/mptcp/options.c  | 11 +++++++++--
 net/mptcp/protocol.h |  3 ++-
 net/mptcp/subflow.c  |  1 +
 4 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index 23bbd439e115..8f86c05ddbfd 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -65,7 +65,8 @@ struct mptcp_out_options {
 	u8 join_id;
 	u8 backup;
 	u8 reset_reason:4;
-	u8 reset_transient:1;
+	u8 reset_transient:1,
+	   csum_reqd:1;
 	u32 nonce;
 	u64 thmac;
 	u32 token;
diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index beac01f58cba..389d48978004 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -381,6 +381,7 @@ bool mptcp_syn_options(struct sock *sk, const struct sk_buff *skb,
 	subflow->snd_isn = TCP_SKB_CB(skb)->end_seq;
 	if (subflow->request_mptcp) {
 		opts->suboptions = OPTION_MPTCP_MPC_SYN;
+		opts->csum_reqd = mptcp_is_checksum_enabled(sock_net(sk));
 		*size = TCPOLEN_MPTCP_MPC_SYN;
 		return true;
 	} else if (subflow->request_join) {
@@ -436,6 +437,7 @@ static bool mptcp_established_options_mp(struct sock *sk, struct sk_buff *skb,
 					 struct mptcp_out_options *opts)
 {
 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(sk);
+	struct mptcp_sock *msk = mptcp_sk(subflow->conn);
 	struct mptcp_ext *mpext;
 	unsigned int data_len;
 
@@ -466,6 +468,7 @@ static bool mptcp_established_options_mp(struct sock *sk, struct sk_buff *skb,
 		opts->suboptions = OPTION_MPTCP_MPC_ACK;
 		opts->sndr_key = subflow->local_key;
 		opts->rcvr_key = subflow->remote_key;
+		opts->csum_reqd = READ_ONCE(msk->csum_enabled);
 
 		/* Section 3.1.
 		 * The MP_CAPABLE option is carried on the SYN, SYN/ACK, and ACK
@@ -793,6 +796,7 @@ bool mptcp_synack_options(const struct request_sock *req, unsigned int *size,
 	if (subflow_req->mp_capable) {
 		opts->suboptions = OPTION_MPTCP_MPC_SYNACK;
 		opts->sndr_key = subflow_req->local_key;
+		opts->csum_reqd = subflow_req->csum_reqd;
 		*size = TCPOLEN_MPTCP_MPC_SYNACK;
 		pr_debug("subflow_req=%p, local_key=%llu",
 			 subflow_req, subflow_req->local_key);
@@ -1127,7 +1131,7 @@ void mptcp_write_options(__be32 *ptr, const struct tcp_sock *tp,
 {
 	if ((OPTION_MPTCP_MPC_SYN | OPTION_MPTCP_MPC_SYNACK |
 	     OPTION_MPTCP_MPC_ACK) & opts->suboptions) {
-		u8 len;
+		u8 len, flag = MPTCP_CAP_HMAC_SHA256;
 
 		if (OPTION_MPTCP_MPC_SYN & opts->suboptions)
 			len = TCPOLEN_MPTCP_MPC_SYN;
@@ -1138,9 +1142,12 @@ void mptcp_write_options(__be32 *ptr, const struct tcp_sock *tp,
 		else
 			len = TCPOLEN_MPTCP_MPC_ACK;
 
+		if (opts->csum_reqd)
+			flag |= MPTCP_CAP_CHECKSUM_REQD;
+
 		*ptr++ = mptcp_option(MPTCPOPT_MP_CAPABLE, len,
 				      MPTCP_SUPPORTED_VERSION,
-				      MPTCP_CAP_HMAC_SHA256);
+				      flag);
 
 		if (!((OPTION_MPTCP_MPC_SYNACK | OPTION_MPTCP_MPC_ACK) &
 		    opts->suboptions))
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 236782702bfb..141317aa6c52 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -346,7 +346,8 @@ struct mptcp_subflow_request_sock {
 	struct	tcp_request_sock sk;
 	u16	mp_capable : 1,
 		mp_join : 1,
-		backup : 1;
+		backup : 1,
+		csum_reqd : 1;
 	u8	local_id;
 	u8	remote_id;
 	u64	local_key;
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 15620bafc544..2ca20f5ba29c 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -108,6 +108,7 @@ static void subflow_init_req(struct request_sock *req, const struct sock *sk_lis
 
 	subflow_req->mp_capable = 0;
 	subflow_req->mp_join = 0;
+	subflow_req->csum_reqd = mptcp_is_checksum_enabled(sock_net(sk_listener));
 	subflow_req->msk = NULL;
 	mptcp_token_init_request(req);
 }
-- 
2.26.2

