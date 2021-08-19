Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 446606D24
	for <mptcp@lists.linux.dev>; Thu, 19 Aug 2021 15:16:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1629386195;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SDnkGszzREtJAXKECsO+fzRxfF1c9czdC/pkkXnBF8o=;
	b=XD6U3akd4mKDLi2L7La8OaHW1Ro/4Rx1Mmm2wFUNJpZMMluVPkqqEvXMcwJNAxZHw1sCr6
	ljbAZhVX+IdBnxob86eeu4yzqDJ4LqbJkLT1TPtaoNU93w4fsQXU2SexWbTrEg9PFzTOHj
	gqwhXSJjawjkEek1ZzohYSK3V3oDs3M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-562-VelfaXXMM9G4932mZ3r0hA-1; Thu, 19 Aug 2021 11:16:32 -0400
X-MC-Unique: VelfaXXMM9G4932mZ3r0hA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7350D1008073
	for <mptcp@lists.linux.dev>; Thu, 19 Aug 2021 15:16:31 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.194.179])
	by smtp.corp.redhat.com (Postfix) with ESMTP id DF9227A8D7
	for <mptcp@lists.linux.dev>; Thu, 19 Aug 2021 15:16:30 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH v2 mptcp-next 2/4] mptcp: better binary layout for mptcp_options_received
Date: Thu, 19 Aug 2021 17:16:15 +0200
Message-Id: <7c51dc3494e3ddf76e4225f97f1b380d3b4b7d1e.1629386016.git.pabeni@redhat.com>
In-Reply-To: <cover.1629386016.git.pabeni@redhat.com>
References: <cover.1629386016.git.pabeni@redhat.com>
Precedence: bulk
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

This change reorder the mptcp_options_received fields
to shrink the structure a bit and to ensure the most
frequently used fields are all in the first cacheline.

Sub-opt specific flags are are moved out of the suboptions
area, and we must now explicitly set them when the relevant
suboption is parsed.

There is a notable exception: 'csum_reqd' is used by both DSS
and MPC suboptions, and keeping such field in the suboptions
flag area will simplfy the next patch.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/options.c  |  8 +++-----
 net/mptcp/protocol.h | 20 ++++++++++----------
 2 files changed, 13 insertions(+), 15 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index f012a71dd996..79b68ae9ef4d 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -83,8 +83,7 @@ static void mptcp_parse_option(const struct sk_buff *skb,
 		if (flags & MPTCP_CAP_CHECKSUM_REQD)
 			mp_opt->csum_reqd = 1;
 
-		if (flags & MPTCP_CAP_DENY_JOIN_ID0)
-			mp_opt->deny_join_id0 = 1;
+		mp_opt->deny_join_id0 = !!(flags & MPTCP_CAP_DENY_JOIN_ID0);
 
 		mp_opt->mp_capable = 1;
 		if (opsize >= TCPOLEN_MPTCP_MPC_SYNACK) {
@@ -262,6 +261,8 @@ static void mptcp_parse_option(const struct sk_buff *skb,
 
 		mp_opt->add_addr = 1;
 		mp_opt->addr.id = *ptr++;
+		mp_opt->addr.port = 0;
+		mp_opt->ahmac = 0;
 		if (mp_opt->addr.family == AF_INET) {
 			memcpy((u8 *)&mp_opt->addr.addr.s_addr, (u8 *)ptr, 4);
 			ptr += 4;
@@ -363,15 +364,12 @@ void mptcp_get_options(const struct sock *sk,
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
 	mp_opt->csum_reqd = 0;
-	mp_opt->deny_join_id0 = 0;
 	mp_opt->mp_fail = 0;
 
 	length = (th->doff * 4) - sizeof(struct tcphdr);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 57a50b1194a9..9a0d91f92bbc 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -140,28 +140,28 @@ struct mptcp_options_received {
 		add_addr : 1,
 		rm_addr : 1,
 		mp_prio : 1,
-		mp_fail : 1,
-		echo : 1,
 		csum_reqd : 1,
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
+		reset_reason:4,
+		reset_transient:1,
+		echo:1,
+		backup:1,
+		deny_join_id0:1,
 		__unused:2;
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

