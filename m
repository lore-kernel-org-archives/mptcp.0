Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B3162582
	for <mptcp@lists.linux.dev>; Fri, 11 Nov 2022 11:19:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1668165548;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=IO7sl8weeH181qCIzERBH563x8/ec4/97HLYCOVexGc=;
	b=Nj08AmwjTkBmzB1e5LOLcFHCH3XVmIgWl0HA1tJrM6H/+4Cb6jAw8w/qkDWcxIR+atlCf0
	AJhXRxiKuF5SwFYaYcWdxhTK87d7CzW2H4GGc+oaTavKhQkL/45kbb66Ql5ylB+LqkN53h
	/Ptww70xF+bWi1z1LRCYWNgs6vle06k=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-255-YgIICTpVPbWRcoupfAaT4A-1; Fri, 11 Nov 2022 06:19:05 -0500
X-MC-Unique: YgIICTpVPbWRcoupfAaT4A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D96A3280D727;
	Fri, 11 Nov 2022 11:19:04 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.194.106])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 42076C15BA8;
	Fri, 11 Nov 2022 11:19:04 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Cc: Dmytro Shytyi <dmytro@shytyi.net>
Subject: [PATCH mptcp-next 1/2] Squash-to: "mptcp: implement delayed seq generation for passive fastopen"
Date: Fri, 11 Nov 2022 12:18:58 +0100
Message-Id: <00a831a7ae3ffb0573dca58f270a98799f5230bf.1668165456.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

is_mptfo is only used/accessed at the subflow level, we are better
off tracking it in the subflow struct and avoid the (currently missing)
_ONCE() accessors.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/options.c  | 2 +-
 net/mptcp/protocol.h | 5 +++--
 net/mptcp/subflow.c  | 2 +-
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 398f5afac124..7138b10d28a2 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -950,7 +950,7 @@ static bool check_fully_established(struct mptcp_sock *msk, struct sock *ssk,
 	if (TCP_SKB_CB(skb)->seq != subflow->ssn_offset + 1) {
 		if (subflow->mp_join)
 			goto reset;
-		if (msk->is_mptfo && mp_opt->suboptions & OPTION_MPTCP_MPC_ACK)
+		if (subflow->is_mptfo && mp_opt->suboptions & OPTION_MPTCP_MPC_ACK)
 			goto set_fully_established;
 		return subflow->mp_capable;
 	}
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index f805036e3c93..c81bb7d6aab7 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -291,7 +291,6 @@ struct mptcp_sock {
 	bool		use_64bit_ack; /* Set when we received a 64-bit DSN */
 	bool		csum_enabled;
 	bool		allow_infinite_fallback;
-	bool		is_mptfo;
 	u8		mpc_endpoint_id;
 	u8		recvmsg_inq:1,
 			cork:1,
@@ -482,7 +481,9 @@ struct mptcp_subflow_context {
 		disposable : 1,	    /* ctx can be free at ulp release time */
 		stale : 1,	    /* unable to snd/rcv data, do not use for xmit */
 		local_id_valid : 1, /* local_id is correctly initialized */
-		valid_csum_seen : 1;        /* at least one csum validated */
+		valid_csum_seen : 1,        /* at least one csum validated */
+		is_mptfo : 1,	    /* subflow is doing TFO */
+		__unused : 8;
 	enum mptcp_data_avail data_avail;
 	bool	scheduled;
 	u32	remote_nonce;
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index ff9716e53786..9c6f6c9a1f9a 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -686,7 +686,7 @@ void mptcp_subflow_fully_established(struct mptcp_subflow_context *subflow,
 	subflow->can_ack = 1;
 	WRITE_ONCE(msk->fully_established, true);
 
-	if (msk->is_mptfo)
+	if (subflow->is_mptfo)
 		mptcp_gen_msk_ackseq_fastopen(msk, subflow, mp_opt);
 }
 
-- 
2.38.1

