Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A422F80
	for <mptcp@lists.linux.dev>; Tue,  4 May 2021 21:29:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1620163797;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S0/Wh8PEOM3r3M6vmUyJ1/kbTkmac+6srrtvFD5l/mY=;
	b=VckooN/QohDLYr7kGnhMHvkpoiM4fWyNuqjeO/C0gnIV/EWRByYgssN93f/iFIkKuRg7MO
	OsIfzuJ1Si2jYUXnj7KHnKDQ78qxAIOLjLYMaJRoZAUL82F4Ug0P+Gml0JDYL30ZRh1EtP
	u216+2LWpQ/Y66ue6MTLGTca6cwaAC8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-436-xlginLL8PhGFxQ58y3LHSg-1; Tue, 04 May 2021 17:29:54 -0400
X-MC-Unique: xlginLL8PhGFxQ58y3LHSg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 53DC818B9ECA;
	Tue,  4 May 2021 21:29:53 +0000 (UTC)
Received: from gerbillo.redhat.com (ovpn-114-126.ams2.redhat.com [10.36.114.126])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 921946090F;
	Tue,  4 May 2021 21:29:52 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>
Subject: [PATCH v5 mptcp-next 08/21] mptcp: add sk parameter for mptcp_parse_option
Date: Tue,  4 May 2021 23:29:18 +0200
Message-Id: <7c42a4e99aa9d299c917b5db6f21b8c7ae3ad134.1620162984.git.pabeni@redhat.com>
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

This patch added a new parameter name sk in mptcp_parse_option() and
mptcp_get_options().

Signed-off-by: Geliang Tang <geliangtang@gmail.com>
---
 net/mptcp/options.c  | 10 ++++++----
 net/mptcp/protocol.h |  3 ++-
 net/mptcp/subflow.c  | 10 +++++-----
 3 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index ef951cb2aff3..8f768c517586 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -20,7 +20,8 @@ static bool mptcp_cap_flag_sha256(u8 flags)
 	return (flags & MPTCP_CAP_FLAG_MASK) == MPTCP_CAP_HMAC_SHA256;
 }
 
-static void mptcp_parse_option(const struct sk_buff *skb,
+static void mptcp_parse_option(const struct sock *sk,
+			       const struct sk_buff *skb,
 			       const unsigned char *ptr, int opsize,
 			       struct mptcp_options_received *mp_opt)
 {
@@ -324,7 +325,8 @@ static void mptcp_parse_option(const struct sk_buff *skb,
 	}
 }
 
-void mptcp_get_options(const struct sk_buff *skb,
+void mptcp_get_options(const struct sock *sk,
+		       const struct sk_buff *skb,
 		       struct mptcp_options_received *mp_opt)
 {
 	const struct tcphdr *th = tcp_hdr(skb);
@@ -363,7 +365,7 @@ void mptcp_get_options(const struct sk_buff *skb,
 			if (opsize > length)
 				return;	/* don't parse partial options */
 			if (opcode == TCPOPT_MPTCP)
-				mptcp_parse_option(skb, ptr, opsize, mp_opt);
+				mptcp_parse_option(sk, skb, ptr, opsize, mp_opt);
 			ptr += opsize - 2;
 			length -= opsize;
 		}
@@ -1028,7 +1030,7 @@ void mptcp_incoming_options(struct sock *sk, struct sk_buff *skb)
 		return;
 	}
 
-	mptcp_get_options(skb, &mp_opt);
+	mptcp_get_options(sk, skb, &mp_opt);
 	if (!check_fully_established(msk, sk, subflow, skb, &mp_opt))
 		return;
 
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 141317aa6c52..a1def094899c 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -585,7 +585,8 @@ int __init mptcp_proto_v6_init(void);
 struct sock *mptcp_sk_clone(const struct sock *sk,
 			    const struct mptcp_options_received *mp_opt,
 			    struct request_sock *req);
-void mptcp_get_options(const struct sk_buff *skb,
+void mptcp_get_options(const struct sock *sk,
+		       const struct sk_buff *skb,
 		       struct mptcp_options_received *mp_opt);
 
 void mptcp_finish_connect(struct sock *sk);
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 2ca20f5ba29c..f12ea479a70f 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -151,7 +151,7 @@ static int subflow_check_req(struct request_sock *req,
 		return -EINVAL;
 #endif
 
-	mptcp_get_options(skb, &mp_opt);
+	mptcp_get_options(sk_listener, skb, &mp_opt);
 
 	if (mp_opt.mp_capable) {
 		SUBFLOW_REQ_INC_STATS(req, MPTCP_MIB_MPCAPABLEPASSIVE);
@@ -248,7 +248,7 @@ int mptcp_subflow_init_cookie_req(struct request_sock *req,
 	int err;
 
 	subflow_init_req(req, sk_listener);
-	mptcp_get_options(skb, &mp_opt);
+	mptcp_get_options(sk_listener, skb, &mp_opt);
 
 	if (mp_opt.mp_capable && mp_opt.mp_join)
 		return -EINVAL;
@@ -395,7 +395,7 @@ static void subflow_finish_connect(struct sock *sk, const struct sk_buff *skb)
 	subflow->ssn_offset = TCP_SKB_CB(skb)->seq;
 	pr_debug("subflow=%p synack seq=%x", subflow, subflow->ssn_offset);
 
-	mptcp_get_options(skb, &mp_opt);
+	mptcp_get_options(sk, skb, &mp_opt);
 	if (subflow->request_mptcp) {
 		if (!mp_opt.mp_capable) {
 			MPTCP_INC_STATS(sock_net(sk),
@@ -640,7 +640,7 @@ static struct sock *subflow_syn_recv_sock(const struct sock *sk,
 			goto create_msk;
 		}
 
-		mptcp_get_options(skb, &mp_opt);
+		mptcp_get_options(sk, skb, &mp_opt);
 		if (!mp_opt.mp_capable) {
 			fallback = true;
 			goto create_child;
@@ -651,7 +651,7 @@ static struct sock *subflow_syn_recv_sock(const struct sock *sk,
 		if (!new_msk)
 			fallback = true;
 	} else if (subflow_req->mp_join) {
-		mptcp_get_options(skb, &mp_opt);
+		mptcp_get_options(sk, skb, &mp_opt);
 		if (!mp_opt.mp_join || !subflow_hmac_valid(req, &mp_opt) ||
 		    !mptcp_can_accept_new_subflow(subflow_req->msk)) {
 			SUBFLOW_REQ_INC_STATS(req, MPTCP_MIB_JOINACKMAC);
-- 
2.26.2

