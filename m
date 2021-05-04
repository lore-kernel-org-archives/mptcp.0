Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [216.205.24.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0466A70
	for <mptcp@lists.linux.dev>; Tue,  4 May 2021 21:29:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1620163792;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IhBJ5ZSWsF1uxrbAUPcIzWRXL04I6ibULv6PbwktwYc=;
	b=KAKk3wtAXaV1CXsAQlfemJIKcmoEaWyVDJSy/ap6NtU3lCODPM/ug3bD7d7wF39Epa88cs
	/Jj7OViwtw9VVL4wKjO5kaFgDx8z+QvzTOuehSnQY5Eruya9RCbUMFbndvjP4qf8FH3upb
	5IkQNmxlmiwhkh+WtH5oLT9WiJTjhvs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-577-7AhIqan7PDOyGXQsabQN9g-1; Tue, 04 May 2021 17:29:49 -0400
X-MC-Unique: 7AhIqan7PDOyGXQsabQN9g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B8D6E1A8A62;
	Tue,  4 May 2021 21:29:48 +0000 (UTC)
Received: from gerbillo.redhat.com (ovpn-114-126.ams2.redhat.com [10.36.114.126])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 044FC6090F;
	Tue,  4 May 2021 21:29:47 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>
Subject: [PATCH v5 mptcp-next 04/21] mptcp: send out checksum for MP_CAPABLE with data
Date: Tue,  4 May 2021 23:29:14 +0200
Message-Id: <80e47d3778ba209b088fea808b54868b370f79a8.1620162984.git.pabeni@redhat.com>
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

If the checksum is enabled, send out the data checksum with the
MP_CAPABLE suboption with data.

In mptcp_established_options_mp, save the data checksum in
opts->ext_copy.csum. In mptcp_write_options, adjust the option length and
send it out with the MP_CAPABLE suboption.

Signed-off-by: Geliang Tang <geliangtang@gmail.com>
---
 net/mptcp/options.c | 35 ++++++++++++++++++++++++++---------
 1 file changed, 26 insertions(+), 9 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 389d48978004..175635214ce6 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -440,6 +440,8 @@ static bool mptcp_established_options_mp(struct sock *sk, struct sk_buff *skb,
 	struct mptcp_sock *msk = mptcp_sk(subflow->conn);
 	struct mptcp_ext *mpext;
 	unsigned int data_len;
+	__sum16 csum;
+	u8 len;
 
 	/* When skb is not available, we better over-estimate the emitted
 	 * options len. A full DSS option (28 bytes) is longer than
@@ -459,6 +461,7 @@ static bool mptcp_established_options_mp(struct sock *sk, struct sk_buff *skb,
 	if (subflow->mp_capable) {
 		mpext = mptcp_get_ext(skb);
 		data_len = mpext ? mpext->data_len : 0;
+		csum = mpext ? mpext->csum : 0;
 
 		/* we will check ext_copy.data_len in mptcp_write_options() to
 		 * discriminate between TCPOLEN_MPTCP_MPC_ACK_DATA and
@@ -469,16 +472,22 @@ static bool mptcp_established_options_mp(struct sock *sk, struct sk_buff *skb,
 		opts->sndr_key = subflow->local_key;
 		opts->rcvr_key = subflow->remote_key;
 		opts->csum_reqd = READ_ONCE(msk->csum_enabled);
+		if (opts->csum_reqd)
+			opts->ext_copy.csum = csum;
 
 		/* Section 3.1.
 		 * The MP_CAPABLE option is carried on the SYN, SYN/ACK, and ACK
 		 * packets that start the first subflow of an MPTCP connection,
 		 * as well as the first packet that carries data
 		 */
-		if (data_len > 0)
-			*size = ALIGN(TCPOLEN_MPTCP_MPC_ACK_DATA, 4);
-		else
+		if (data_len > 0) {
+			len = TCPOLEN_MPTCP_MPC_ACK_DATA;
+			if (opts->csum_reqd)
+				len += TCPOLEN_MPTCP_DSS_CHECKSUM;
+			*size = ALIGN(len, 4);
+		} else {
 			*size = TCPOLEN_MPTCP_MPC_ACK;
+		}
 
 		pr_debug("subflow=%p, local_key=%llu, remote_key=%llu map_len=%d",
 			 subflow, subflow->local_key, subflow->remote_key,
@@ -1133,14 +1142,17 @@ void mptcp_write_options(__be32 *ptr, const struct tcp_sock *tp,
 	     OPTION_MPTCP_MPC_ACK) & opts->suboptions) {
 		u8 len, flag = MPTCP_CAP_HMAC_SHA256;
 
-		if (OPTION_MPTCP_MPC_SYN & opts->suboptions)
+		if (OPTION_MPTCP_MPC_SYN & opts->suboptions) {
 			len = TCPOLEN_MPTCP_MPC_SYN;
-		else if (OPTION_MPTCP_MPC_SYNACK & opts->suboptions)
+		} else if (OPTION_MPTCP_MPC_SYNACK & opts->suboptions) {
 			len = TCPOLEN_MPTCP_MPC_SYNACK;
-		else if (opts->ext_copy.data_len)
+		} else if (opts->ext_copy.data_len) {
 			len = TCPOLEN_MPTCP_MPC_ACK_DATA;
-		else
+			if (opts->csum_reqd)
+				len += TCPOLEN_MPTCP_DSS_CHECKSUM;
+		} else {
 			len = TCPOLEN_MPTCP_MPC_ACK;
+		}
 
 		if (opts->csum_reqd)
 			flag |= MPTCP_CAP_CHECKSUM_REQD;
@@ -1163,8 +1175,13 @@ void mptcp_write_options(__be32 *ptr, const struct tcp_sock *tp,
 		if (!opts->ext_copy.data_len)
 			goto mp_capable_done;
 
-		put_unaligned_be32(opts->ext_copy.data_len << 16 |
-				   TCPOPT_NOP << 8 | TCPOPT_NOP, ptr);
+		if (opts->csum_reqd) {
+			put_unaligned_be32(opts->ext_copy.data_len << 16 |
+					   (__force u16)opts->ext_copy.csum, ptr);
+		} else {
+			put_unaligned_be32(opts->ext_copy.data_len << 16 |
+					   TCPOPT_NOP << 8 | TCPOPT_NOP, ptr);
+		}
 		ptr += 1;
 	}
 
-- 
2.26.2

