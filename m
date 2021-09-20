Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DAFE29CA
	for <mptcp@lists.linux.dev>; Mon, 20 Sep 2021 17:24:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1632158683;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=02oLvmsxDylXifmWi/t243YphWofM9PNvpTCGshx69c=;
	b=FNyhUKtRC2SOvgSHbiEpfZ2UTjuOy2NlQ3hwBzsW54wDVha76kihnvU0w3gCxn0a3heB/L
	j7AOsAXyaWUZS5DXRsRrRSa38bxsg9TvD+SloA1vLZ11MrmbmnfZM9uK/7uRtX6BPGxl2U
	OEuCqZ7YixqfetQQtxkDmyEKCgGrWdk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-152-itKTiJcTNdiiIp49749G_A-1; Mon, 20 Sep 2021 13:24:41 -0400
X-MC-Unique: itKTiJcTNdiiIp49749G_A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 124091084681
	for <mptcp@lists.linux.dev>; Mon, 20 Sep 2021 17:24:41 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.193.11])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 80A096060F
	for <mptcp@lists.linux.dev>; Mon, 20 Sep 2021 17:24:40 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next 1/3] Squash-to: "tcp: expose the tcp_mark_push() and skb_entail() helpers"
Date: Mon, 20 Sep 2021 19:24:27 +0200
Message-Id: <9934d3a84518fac74119c18044baeb4241c13e98.1632158356.git.pabeni@redhat.com>
In-Reply-To: <cover.1632158356.git.pabeni@redhat.com>
References: <cover.1632158356.git.pabeni@redhat.com>
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

Also change the commit title and message to:

"""
tcp: expose the tcp_mark_push() and tcp_skb_entail() helpers

the tcp_skb_entail() helper actually skb_entail(), renamed
to provide proper scope.

    The two helper will be used by the next patch.

RFC -> v1:
 - rename skb_entail to tcp_skb_entail (Eric)

"""

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 include/net/tcp.h | 2 +-
 net/ipv4/tcp.c    | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index dc52ea8adfc7..4a96f6e0f6f8 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -581,7 +581,7 @@ __u32 cookie_v6_init_sequence(const struct sk_buff *skb, __u16 *mss);
 #endif
 /* tcp_output.c */
 
-void skb_entail(struct sock *sk, struct sk_buff *skb);
+void tcp_skb_entail(struct sock *sk, struct sk_buff *skb);
 void tcp_mark_push(struct tcp_sock *tp, struct sk_buff *skb);
 void __tcp_push_pending_frames(struct sock *sk, unsigned int cur_mss,
 			       int nonagle);
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 7a3e632b0048..c592454625e1 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -658,7 +658,7 @@ static inline bool forced_push(const struct tcp_sock *tp)
 	return after(tp->write_seq, tp->pushed_seq + (tp->max_window >> 1));
 }
 
-void skb_entail(struct sock *sk, struct sk_buff *skb)
+void tcp_skb_entail(struct sock *sk, struct sk_buff *skb)
 {
 	struct tcp_sock *tp = tcp_sk(sk);
 	struct tcp_skb_cb *tcb = TCP_SKB_CB(skb);
@@ -985,7 +985,7 @@ struct sk_buff *tcp_build_frag(struct sock *sk, int size_goal, int flags,
 #ifdef CONFIG_TLS_DEVICE
 		skb->decrypted = !!(flags & MSG_SENDPAGE_DECRYPTED);
 #endif
-		skb_entail(sk, skb);
+		tcp_skb_entail(sk, skb);
 		copy = size_goal;
 	}
 
@@ -1314,7 +1314,7 @@ int tcp_sendmsg_locked(struct sock *sk, struct msghdr *msg, size_t size)
 			process_backlog++;
 			skb->ip_summed = CHECKSUM_PARTIAL;
 
-			skb_entail(sk, skb);
+			tcp_skb_entail(sk, skb);
 			copy = size_goal;
 
 			/* All packets are restored as if they have
-- 
2.26.3

