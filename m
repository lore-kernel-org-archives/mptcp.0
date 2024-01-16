Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D7A1CD21
	for <mptcp@lists.linux.dev>; Tue, 16 Jan 2024 18:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705428987; cv=none; b=XdKAbXSRufAwhzLO/RnQdsEa0dUt7JqJYAAASuXD8zqyIoqW3pAOzweUVr3dFrk7K8enJ/1uYqo9Ku9izkgH6T2LrqISBMlfY63pOTfwXqc/DEdiCrn3j55HqRyzoxv070mlBoGjiZ8R9GMbWz7UDtjFH7clNLS1AgtOmJkBtqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705428987; c=relaxed/simple;
	bh=JAdd3wng0B/X6jRk4nsqgyqR5ZDLrf0oqjst/pHFdng=;
	h=DKIM-Signature:Received:X-MC-Unique:Received:Received:From:To:
	 Subject:Date:Message-ID:In-Reply-To:References:MIME-Version:
	 X-Scanned-By:X-Mimecast-Spam-Score:X-Mimecast-Originator:
	 Content-Transfer-Encoding:Content-Type; b=Lh3LHzlSLnh8h5tfQJYxlyLq/ABYDbOjejc+ZEhL8XljPe9uuLIc+yybb9BZMFbVdNZWaMms5OCZjAcz3QWvGfAT2zgdcwTpWfIgEde/MKHy/Yc/B6yhaUS6Kg+tTgOnShTWYJO21KArPRZ0BKW9HYnqcT6A3DZejuH/RAixMjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XpjK7lEA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XpjK7lEA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705428985;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JeSTqZcI6r9ZCof/h7CPLjlVy137iejm9AXS9B/fQY8=;
	b=XpjK7lEAaX7ytEQc5YS5G+9DTx09Zf4E6ZqL5HB911jXzjse3PHvBotubTIeymH8Bjngw/
	U28vjbNCO0+KJQLiOk2aMWEwSMEjsmadEqZ3xfUTHdBfLVi7jPDFk1p5Xi6lS8R//NcPsc
	wBWfMapuAdy0X0skR8IcdKaE5u/Rmjk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-623-8vxCph3kN0qMbGd76xXNhQ-1; Tue, 16 Jan 2024 13:16:23 -0500
X-MC-Unique: 8vxCph3kN0qMbGd76xXNhQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5185E811E9E
	for <mptcp@lists.linux.dev>; Tue, 16 Jan 2024 18:16:23 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.225.11])
	by smtp.corp.redhat.com (Postfix) with ESMTP id D4D8D1121306
	for <mptcp@lists.linux.dev>; Tue, 16 Jan 2024 18:16:22 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next 1/5] mptcp: annotate access for msk keys
Date: Tue, 16 Jan 2024 19:16:10 +0100
Message-ID: <1ab56741c6fb79307b91051080db1d2254f28b9c.1705427537.git.pabeni@redhat.com>
In-Reply-To: <cover.1705427537.git.pabeni@redhat.com>
References: <cover.1705427537.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

Both the local and the remote key follow the same locking
schema, put in place the proper ONCE accessors.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/options.c  | 12 ++++++------
 net/mptcp/protocol.c |  2 +-
 net/mptcp/protocol.h |  6 ++++--
 net/mptcp/subflow.c  | 10 ++++++----
 4 files changed, 17 insertions(+), 13 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index e3e96a49f922..cebbd0bc32aa 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -689,8 +689,8 @@ static bool mptcp_established_options_add_addr(struct sock *sk, struct sk_buff *
 	opts->suboptions |= OPTION_MPTCP_ADD_ADDR;
 	if (!echo) {
 		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_ADDADDRTX);
-		opts->ahmac = add_addr_generate_hmac(msk->local_key,
-						     msk->remote_key,
+		opts->ahmac = add_addr_generate_hmac(READ_ONCE(msk->local_key),
+						     READ_ONCE(msk->remote_key),
 						     &opts->addr);
 	} else {
 		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_ECHOADDTX);
@@ -792,7 +792,7 @@ static bool mptcp_established_options_fastclose(struct sock *sk,
 
 	*size = TCPOLEN_MPTCP_FASTCLOSE;
 	opts->suboptions |= OPTION_MPTCP_FASTCLOSE;
-	opts->rcvr_key = msk->remote_key;
+	opts->rcvr_key = READ_ONCE(msk->remote_key);
 
 	pr_debug("FASTCLOSE key=%llu", opts->rcvr_key);
 	MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_MPFASTCLOSETX);
@@ -1100,8 +1100,8 @@ static bool add_addr_hmac_valid(struct mptcp_sock *msk,
 	if (mp_opt->echo)
 		return true;
 
-	hmac = add_addr_generate_hmac(msk->remote_key,
-				      msk->local_key,
+	hmac = add_addr_generate_hmac(READ_ONCE(msk->remote_key),
+				      READ_ONCE(msk->local_key),
 				      &mp_opt->addr);
 
 	pr_debug("msk=%p, ahmac=%llu, mp_opt->ahmac=%llu\n",
@@ -1148,7 +1148,7 @@ bool mptcp_incoming_options(struct sock *sk, struct sk_buff *skb)
 
 	if (unlikely(mp_opt.suboptions != OPTION_MPTCP_DSS)) {
 		if ((mp_opt.suboptions & OPTION_MPTCP_FASTCLOSE) &&
-		    msk->local_key == mp_opt.rcvr_key) {
+		    READ_ONCE(msk->local_key) == mp_opt.rcvr_key) {
 			WRITE_ONCE(msk->rcv_fastclose, true);
 			mptcp_schedule_work((struct sock *)msk);
 			MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_MPFASTCLOSERX);
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 70108854ec9b..9ad672a10c11 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3203,7 +3203,7 @@ struct sock *mptcp_sk_clone_init(const struct sock *sk,
 	__mptcp_init_sock(nsk);
 
 	msk = mptcp_sk(nsk);
-	msk->local_key = subflow_req->local_key;
+	WRITE_ONCE(msk->local_key, subflow_req->local_key);
 	msk->token = subflow_req->token;
 	msk->in_accept_queue = 1;
 	WRITE_ONCE(msk->fully_established, false);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index d442d876f465..3af85643328e 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -260,8 +260,10 @@ struct mptcp_data_frag {
 struct mptcp_sock {
 	/* inet_connection_sock must be the first member */
 	struct inet_connection_sock sk;
-	u64		local_key;
-	u64		remote_key;
+	u64		local_key;		/* protected by the first subflow socket lock
+						 * lockless access read
+						 */
+	u64		remote_key;		/* same as above */
 	u64		write_seq;
 	u64		bytes_sent;
 	u64		snd_nxt;
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index c34ecadee120..02dab0669cfc 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -75,7 +75,8 @@ static void subflow_req_create_thmac(struct mptcp_subflow_request_sock *subflow_
 
 	get_random_bytes(&subflow_req->local_nonce, sizeof(u32));
 
-	subflow_generate_hmac(msk->local_key, msk->remote_key,
+	subflow_generate_hmac(READ_ONCE(msk->local_key),
+			      READ_ONCE(msk->remote_key),
 			      subflow_req->local_nonce,
 			      subflow_req->remote_nonce, hmac);
 
@@ -714,7 +715,8 @@ static bool subflow_hmac_valid(const struct request_sock *req,
 	if (!msk)
 		return false;
 
-	subflow_generate_hmac(msk->remote_key, msk->local_key,
+	subflow_generate_hmac(READ_ONCE(msk->remote_key),
+			      READ_ONCE(msk->local_key),
 			      subflow_req->remote_nonce,
 			      subflow_req->local_nonce, hmac);
 
@@ -1548,8 +1550,8 @@ int __mptcp_subflow_connect(struct sock *sk, const struct mptcp_addr_info *loc,
 	mptcp_pm_get_flags_and_ifindex_by_id(msk, local_id,
 					     &flags, &ifindex);
 	subflow->remote_key_valid = 1;
-	subflow->remote_key = msk->remote_key;
-	subflow->local_key = msk->local_key;
+	subflow->remote_key = READ_ONCE(msk->remote_key);
+	subflow->local_key = READ_ONCE(msk->local_key);
 	subflow->token = msk->token;
 	mptcp_info2sockaddr(loc, &addr, ssk->sk_family);
 
-- 
2.43.0

