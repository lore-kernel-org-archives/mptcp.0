Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68BDF3233
	for <mptcp@lists.linux.dev>; Thu,  8 Sep 2022 13:38:52 +0000 (UTC)
Received: by mail-wr1-f44.google.com with SMTP id e20so26094274wri.13
        for <mptcp@lists.linux.dev>; Thu, 08 Sep 2022 06:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date;
        bh=se5gaMpcKM25jMOs3a3vW1g+Gsv2qMzh5/kD+TSXIFc=;
        b=zbqqnYmrzx4ppQd0ONY77vST8YtVSEBOsDJDRbpZmTlZLj6Uf1PPF4flb7kjocY0eh
         32oeeYOp/fhsJSSIsMw/hhXA7cOCuBHeyp2UA5HXxnPRrgWsJ7knJfpzTzLUWrny/XFW
         q/gKWRBXvJbdPChQOv/dS/wjMST5Ts3xI/vxq8sjeFfE6IKj4vJ5Onm+g3UOQPQ+djR8
         Ww/txrBOL75nZsE8cZ+XRREb2XlOQv5EfB/C7ZajKMzi6IWoaeRxdoPN3ch5kouIdACe
         WXiXvHdMlqPsDKQQ7dHU0yncvZSik0Aw1uZ0x+PVRMmPvcNhVsAehsXWi/iC6ujNz3dr
         6Fxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date;
        bh=se5gaMpcKM25jMOs3a3vW1g+Gsv2qMzh5/kD+TSXIFc=;
        b=gGYEix5u3zW9sbrZPwoWllZlu1yZo97zbgglIQ+AHFrygOZudcqhXHyhh33BdM4AN1
         IMKaKdgucPqH+KjGflExFORItXmeqGrWr0wKBPWV5e4s8qNvJ0M5pSdOvV+6xRjf1d5B
         t64M8sfs/KFdzM7F4Gpc5ssjz59/IG1YTVD+6eixssCKTGBi98JDRi3vMWw4V4bWPmut
         v7zxF4IWbgc8yIeI7x+I33ZkzVt9YfCtBD9fjoUvZGyyg4I6rb3XeRlyp1ExF6LMQtyM
         Xs7W/71e1YTqaMWJ4NCbZJiC/2sorxyWSdw6jJ7wc9SlqI4uaYvj/3b52MIw0CK6VKdu
         crFA==
X-Gm-Message-State: ACgBeo2uCOO68dJLlDUd9Q2v60uLAkkgwDmEuVYQRgzU//+pg9N8Hrus
	9q8VJ2KZoZHV4JkTLqns70Sde4eRUFpA3xED04ZlXzISm7i/Ysf7k8WaTZzvnGzkt0mRZBhp3GY
	fvIhuDbhPeRMWEtFhUW9cSg==
X-Google-Smtp-Source: AA6agR5vHsVCfQcTmh+nuhj0Lt+NZ3R0yLnuVv3X19OzVByMBLGERI6Xp3366W24UAQLifPQKdzKLw==
X-Received: by 2002:adf:e510:0:b0:228:d6be:23b0 with SMTP id j16-20020adfe510000000b00228d6be23b0mr5179866wrm.588.1662644330585;
        Thu, 08 Sep 2022 06:38:50 -0700 (PDT)
Received: from vdi02.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id fc15-20020a05600c524f00b003a5260b8392sm3100822wmb.23.2022.09.08.06.38.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Sep 2022 06:38:50 -0700 (PDT)
From: Benjamin Hesmans <benjamin.hesmans@tessares.net>
To: mptcp@lists.linux.dev
Cc: Benjamin Hesmans <benjamin.hesmans@tessares.net>
Subject: [PATCH RFC mptcp-next 07/10] mptcp: TFO receive: bypass mapping check
Date: Thu,  8 Sep 2022 15:38:26 +0200
Message-Id: <20220908133829.3410092-8-benjamin.hesmans@tessares.net>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220908133829.3410092-1-benjamin.hesmans@tessares.net>
References: <20220908133829.3410092-1-benjamin.hesmans@tessares.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"

With TFO, there is no mapping, the stack can bypass any check related to
the mapping.

=> I'm not fully convinced this is the correct way to do this. I made
this into a small isolated patch to ease the reviews.
Maybe we could MPTCP SKB extension for this? (I didn't check yet)

Signed-off-by: Benjamin Hesmans <benjamin.hesmans@tessares.net>
---
 include/net/tcp.h       | 3 ++-
 net/ipv4/tcp_fastopen.c | 2 ++
 net/mptcp/protocol.c    | 6 ++++++
 net/mptcp/subflow.c     | 5 +++++
 4 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 9a073b58dc4b..0c7996e7ad3f 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -881,7 +881,8 @@ struct tcp_skb_cb {
 	__u8		txstamp_ack:1,	/* Record TX timestamp for ack? */
 			eor:1,		/* Is skb MSG_EOR marked? */
 			has_rxtstamp:1,	/* SKB has a RX timestamp	*/
-			unused:5;
+			is_tfo:1,
+			unused:4;
 	__u32		ack_seq;	/* Sequence number ACK'd	*/
 	union {
 		struct {
diff --git a/net/ipv4/tcp_fastopen.c b/net/ipv4/tcp_fastopen.c
index 45cc7f1ca296..1b2d045604e3 100644
--- a/net/ipv4/tcp_fastopen.c
+++ b/net/ipv4/tcp_fastopen.c
@@ -193,6 +193,8 @@ void tcp_fastopen_add_skb(struct sock *sk, struct sk_buff *skb)
 	TCP_SKB_CB(skb)->seq++;
 	TCP_SKB_CB(skb)->tcp_flags &= ~TCPHDR_SYN;
 
+	TCP_SKB_CB(skb)->is_tfo = 1;
+
 	tp->rcv_nxt = TCP_SKB_CB(skb)->end_seq;
 	__skb_queue_tail(&sk->sk_receive_queue, skb);
 	tp->syn_data_acked = 1;
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index f5a0dd589ad5..765c50bd6bb3 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -362,6 +362,12 @@ static bool __mptcp_move_skb(struct mptcp_sock *msk, struct sock *ssk,
 
 	has_rxtstamp = TCP_SKB_CB(skb)->has_rxtstamp;
 
+	if (TCP_SKB_CB(skb)->is_tfo) {
+		mptcp_set_owner_r(skb, sk);
+		__skb_queue_tail(&sk->sk_receive_queue, skb);
+		return true;
+	}
+
 	/* the skb map_seq accounts for the skb offset:
 	 * mptcp_subflow_get_mapped_dsn() is based on the current tp->copied_seq
 	 * value
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index c7d49fb6e7bd..c2d1ba21c8c2 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -984,6 +984,11 @@ static enum mapping_status get_mapping_status(struct sock *ssk,
 	if (mptcp_check_fallback(ssk))
 		return MAPPING_DUMMY;
 
+	if (TCP_SKB_CB(skb)->is_tfo) {
+		/* subflow->map_valid = 1; */
+		return MAPPING_OK; /* or DUMMY ? */
+	}
+
 	mpext = mptcp_get_ext(skb);
 	if (!mpext || !mpext->use_map) {
 		if (!subflow->map_valid && !skb->len) {
-- 
2.25.1


-- 


Disclaimer: https://www.tessares.net/mail-disclaimer/ 
<https://www.tessares.net/mail-disclaimer/>


