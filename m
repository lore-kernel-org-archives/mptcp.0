Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65EE06D19
	for <mptcp@lists.linux.dev>; Wed, 18 Aug 2021 10:36:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1629282965;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HxWDBVzKJin/EH197ZN+hgOhXxSu8tazl/C2xjrDNAQ=;
	b=a3oJ0Ib1rT9U5wvSQd9eJ4YLlUKk+1P/rBTLwBbdd88YrliAIt9FmSxRJG8StqMT9pwsPU
	z7EC0MH7kVM/MRZAIvpkO0AltauPJB3szmfGjItffWzPWU34OU7Cv4+SwBF40FNwgs6Zm2
	sezuFkHJcMS3F9QxU3buGc6XoEyjZso=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-222-RoTX1ylSNFe_tcwg7EbBcA-1; Wed, 18 Aug 2021 06:36:02 -0400
X-MC-Unique: RoTX1ylSNFe_tcwg7EbBcA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CB7E78799EF
	for <mptcp@lists.linux.dev>; Wed, 18 Aug 2021 10:36:01 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.194.166])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 437931036D35
	for <mptcp@lists.linux.dev>; Wed, 18 Aug 2021 10:36:01 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH net-next 2/4] mptcp: better binary layout for mptcp_options_received
Date: Wed, 18 Aug 2021 12:35:47 +0200
Message-Id: <a7c664675492801390198711b3e03aeaa112fe95.1629133749.git.pabeni@redhat.com>
In-Reply-To: <4209d5f5217483e4c06a43afb8e3e8322566085d.1629133749.git.pabeni@redhat.com>
References: <4209d5f5217483e4c06a43afb8e3e8322566085d.1629133749.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"

This change reorder the mptcp_options_received fields
to shrink the structure a bit and to ensure the most
frequently used fields are all in the first cacheline.

Sub-opt specific flags are are moved out of the suboptions
area, and we must now explicitly set them when the relevant
suboption is parsed.

This latter part will simplfy the next patch.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/options.c  | 13 ++++---------
 net/mptcp/protocol.h | 24 ++++++++++++------------
 2 files changed, 16 insertions(+), 21 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index b3d5547fdb61..500137f93c28 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -80,11 +80,8 @@ static void mptcp_parse_option(const struct sk_buff *skb,
 		 * In other words, the only way for checksums not to be used
 		 * is if both hosts in their SYNs set A=0."
 		 */
-		if (flags & MPTCP_CAP_CHECKSUM_REQD)
-			mp_opt->csum_reqd = 1;
-
-		if (flags & MPTCP_CAP_DENY_JOIN_ID0)
-			mp_opt->deny_join_id0 = 1;
+		mp_opt->csum_reqd = !!(flags & MPTCP_CAP_CHECKSUM_REQD);
+		mp_opt->deny_join_id0 = !!(flags & MPTCP_CAP_DENY_JOIN_ID0);
 
 		mp_opt->mp_capable = 1;
 		if (opsize >= TCPOLEN_MPTCP_MPC_SYNACK) {
@@ -262,6 +259,7 @@ static void mptcp_parse_option(const struct sk_buff *skb,
 
 		mp_opt->add_addr = 1;
 		mp_opt->addr.id = *ptr++;
+		mp_opt->addr.port = 0;
 		if (mp_opt->addr.family == AF_INET) {
 			memcpy((u8 *)&mp_opt->addr.addr.s_addr, (u8 *)ptr, 4);
 			ptr += 4;
@@ -282,6 +280,7 @@ static void mptcp_parse_option(const struct sk_buff *skb,
 			}
 		}
 #endif
+		mp_opt->ahmac = 0;
 		if (!mp_opt->echo) {
 			mp_opt->ahmac = get_unaligned_be64(ptr);
 			ptr += 8;
@@ -363,15 +362,11 @@ void mptcp_get_options(const struct sock *sk,
 	mp_opt->mp_capable = 0;
 	mp_opt->mp_join = 0;
 	mp_opt->add_addr = 0;
-	mp_opt->ahmac = 0;
 	mp_opt->fastclose = 0;
-	mp_opt->addr.port = 0;
 	mp_opt->rm_addr = 0;
 	mp_opt->dss = 0;
 	mp_opt->mp_prio = 0;
 	mp_opt->reset = 0;
-	mp_opt->csum_reqd = 0;
-	mp_opt->deny_join_id0 = 0;
 	mp_opt->mp_fail = 0;
 
 	length = (th->doff * 4) - sizeof(struct tcphdr);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 57a50b1194a9..624a72e7ea17 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -140,28 +140,28 @@ struct mptcp_options_received {
 		add_addr : 1,
 		rm_addr : 1,
 		mp_prio : 1,
-		mp_fail : 1,
-		echo : 1,
-		csum_reqd : 1,
-		backup : 1,
-		deny_join_id0 : 1;
+		mp_fail : 1;
 	u32	token;
 	u32	nonce;
-	u64	thmac;
-	u8	hmac[MPTCPOPT_HMAC_LEN];
-	u8	join_id;
-	u8	use_map:1,
+	u16	use_map:1,
 		dsn64:1,
 		data_fin:1,
 		use_ack:1,
 		ack64:1,
 		mpc_map:1,
-		__unused:2;
+		reset_reason:4,
+		reset_transient:1,
+		echo:1,
+		csum_reqd:1,
+		backup:1,
+		deny_join_id0:1,
+		__unused:1;
+	u8	join_id;
+	u64	thmac;
+	u8	hmac[MPTCPOPT_HMAC_LEN];
 	struct mptcp_addr_info addr;
 	struct mptcp_rm_list rm_list;
 	u64	ahmac;
-	u8	reset_reason:4;
-	u8	reset_transient:1;
 	u64	fail_seq;
 };
 
-- 
2.26.3

