Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17CA870
	for <mptcp@lists.linux.dev>; Tue,  4 May 2021 21:42:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1620164561;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S7xYSRVOluDLzjshsmvEfG3WTMPV/xZB+aq/BQVXuBM=;
	b=Zfzu8d9w9j8wYQpFcYwGBvrPuNFtsUHBpVksTBYhODAaK8qmLY2vowzwSItf7ud3v0Hq8q
	s1k0sjJcCizDokm22/EoWxyDiW8PQgEjZtewvemfP4FsD/5SOHQ/IwWa0N2LKamyvY9gCg
	B8d+szhrgeJw0IK1GcI5yv/KGW/bu94=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-194-zdUaHXxyPpyQgiBewttO6Q-1; Tue, 04 May 2021 17:42:39 -0400
X-MC-Unique: zdUaHXxyPpyQgiBewttO6Q-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E6B96835DE1
	for <mptcp@lists.linux.dev>; Tue,  4 May 2021 21:42:38 +0000 (UTC)
Received: from gerbillo.redhat.com (ovpn-114-126.ams2.redhat.com [10.36.114.126])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 5F4275C22A
	for <mptcp@lists.linux.dev>; Tue,  4 May 2021 21:42:38 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH v6 mptcp-next 10/22] mptcp: add csum_reqd in mptcp_options_received
Date: Tue,  4 May 2021 23:41:58 +0200
Message-Id: <fcfa7d198150907013ec51da9174c0a688307e64.1620163861.git.pabeni@redhat.com>
In-Reply-To: <cover.1620163861.git.pabeni@redhat.com>
References: <cover.1620163861.git.pabeni@redhat.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"

From: Geliang Tang <geliangtang@gmail.com>

This patch added a new flag csum_reqd in struct mptcp_options_received, if
the flag MPTCP_CAP_CHECKSUM_REQD is set in the receiving MP_CAPABLE
suboption, set this flag.

In mptcp_sk_clone and subflow_finish_connect, if the csum_reqd flag is set,
enable the msk->csum_enabled flag.

Signed-off-by: Geliang Tang <geliangtang@gmail.com>
---
 net/mptcp/options.c  | 8 +++++---
 net/mptcp/protocol.c | 2 ++
 net/mptcp/protocol.h | 1 +
 net/mptcp/subflow.c  | 2 ++
 4 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 8f768c517586..b86777b2b505 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -25,6 +25,8 @@ static void mptcp_parse_option(const struct sock *sk,
 			       const unsigned char *ptr, int opsize,
 			       struct mptcp_options_received *mp_opt)
 {
+	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(sk);
+	struct mptcp_sock *msk = mptcp_sk(subflow->conn);
 	u8 subtype = *ptr >> 4;
 	int expected_opsize;
 	u8 version;
@@ -72,11 +74,10 @@ static void mptcp_parse_option(const struct sock *sk,
 		 * "If a checksum is not present when its use has been
 		 * negotiated, the receiver MUST close the subflow with a RST as
 		 * it is considered broken."
-		 *
-		 * We don't implement DSS checksum - fall back to TCP.
 		 */
+		mp_opt->csum_reqd = READ_ONCE(msk->csum_enabled);
 		if (flags & MPTCP_CAP_CHECKSUM_REQD)
-			break;
+			mp_opt->csum_reqd = 1;
 
 		mp_opt->mp_capable = 1;
 		if (opsize >= TCPOLEN_MPTCP_MPC_SYNACK) {
@@ -344,6 +345,7 @@ void mptcp_get_options(const struct sock *sk,
 	mp_opt->dss = 0;
 	mp_opt->mp_prio = 0;
 	mp_opt->reset = 0;
+	mp_opt->csum_reqd = 0;
 
 	length = (th->doff * 4) - sizeof(struct tcphdr);
 	ptr = (const unsigned char *)(th + 1);
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index f2874afca3ce..4c79b0518e81 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2764,6 +2764,8 @@ struct sock *mptcp_sk_clone(const struct sock *sk,
 	msk->token = subflow_req->token;
 	msk->subflow = NULL;
 	WRITE_ONCE(msk->fully_established, false);
+	if (mp_opt->csum_reqd)
+		WRITE_ONCE(msk->csum_enabled, true);
 
 	msk->write_seq = subflow_req->idsn + 1;
 	msk->snd_nxt = msk->write_seq;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index a1def094899c..b1d360a498a0 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -133,6 +133,7 @@ struct mptcp_options_received {
 		rm_addr : 1,
 		mp_prio : 1,
 		echo : 1,
+		csum_reqd : 1,
 		backup : 1;
 	u32	token;
 	u32	nonce;
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index f12ea479a70f..f8732e11a392 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -405,6 +405,8 @@ static void subflow_finish_connect(struct sock *sk, const struct sk_buff *skb)
 			goto fallback;
 		}
 
+		if (mp_opt.csum_reqd)
+			WRITE_ONCE(mptcp_sk(parent)->csum_enabled, true);
 		subflow->mp_capable = 1;
 		subflow->can_ack = 1;
 		subflow->remote_key = mp_opt.sndr_key;
-- 
2.26.2

