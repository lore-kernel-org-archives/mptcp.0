Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [216.205.24.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C83A2F83
	for <mptcp@lists.linux.dev>; Wed, 21 Apr 2021 20:21:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1619036497;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ipYYkV0b2broBA6MH0XiFxOXl+1LPcELx9rXJKNplg4=;
	b=i7tqaeFWM4AuCIYpSo8QWLwkzLMhxX3x8BK3RJazTfzi+4mYf3X+FtKNUTsogTr8j8FP+f
	NMQGJV43fcdb8pnbZoXWYKeno2NcNWLXvcab4daSYwwoxTCPU9JQXuQ377ygIb2yWmbOCw
	AMFM8ekkub/3xYmL4VO/FgPi3QR7n9o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-143-24L1PTKRMhWhd8o1bsYuSA-1; Wed, 21 Apr 2021 16:20:45 -0400
X-MC-Unique: 24L1PTKRMhWhd8o1bsYuSA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 17FA81008060;
	Wed, 21 Apr 2021 20:20:44 +0000 (UTC)
Received: from gerbillo.redhat.com (ovpn-112-15.ams2.redhat.com [10.36.112.15])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 3E6296085A;
	Wed, 21 Apr 2021 20:20:42 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>
Subject: [PATCH v3 mptcp-next 10/21] mptcp: add csum_reqd in mptcp_options_received
Date: Wed, 21 Apr 2021 22:17:59 +0200
Message-Id: <50359c72290e3c19210c8d4bf5b47eb76050085d.1619035356.git.pabeni@redhat.com>
In-Reply-To: <cover.1619035356.git.pabeni@redhat.com>
References: <cover.1619035356.git.pabeni@redhat.com>
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
index cf465b62e4b4..2d6b0158e19b 100644
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
index d012b9998fdd..0d8005b480ab 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2753,6 +2753,8 @@ struct sock *mptcp_sk_clone(const struct sock *sk,
 	msk->token = subflow_req->token;
 	msk->subflow = NULL;
 	WRITE_ONCE(msk->fully_established, false);
+	if (mp_opt->csum_reqd)
+		WRITE_ONCE(msk->csum_enabled, true);
 
 	msk->write_seq = subflow_req->idsn + 1;
 	msk->snd_nxt = msk->write_seq;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 87d78819a545..51f4bbe1703a 100644
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
index 39ae86d12f06..fc39107b25ec 100644
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

