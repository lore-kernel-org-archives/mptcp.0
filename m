Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [216.205.24.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56D4E29CA
	for <mptcp@lists.linux.dev>; Thu,  2 Sep 2021 14:20:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1630592446;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5mDJU6NE9VaROPqiItmVTwgDB2WVu7JPOayM+M/8Tak=;
	b=ivPMN3cR5nMp6I5sl2LSSeVDLwzXwn2vL7LKLVs6oSXpIloXpime7++6KniCtIlrzfnz1Y
	e2CknR4jdSXGv8cWNk8vbUvrmtSsKVLCDxSqZaJSJyZ4y8URp2SCxpao0ObBE3mGjoi8sM
	AZuY7TrC105Wf7Br/mLe58cRgedajvQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-283-KMqgrBw1MNiwz8i9PTCxNw-1; Thu, 02 Sep 2021 10:20:45 -0400
X-MC-Unique: KMqgrBw1MNiwz8i9PTCxNw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 760D0DF8A3
	for <mptcp@lists.linux.dev>; Thu,  2 Sep 2021 14:20:44 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.194.237])
	by smtp.corp.redhat.com (Postfix) with ESMTP id E06C21042A40
	for <mptcp@lists.linux.dev>; Thu,  2 Sep 2021 14:20:43 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next 1/4] tcp: expose the tcp_mark_push() and skb_entail() helpers
Date: Thu,  2 Sep 2021 16:20:29 +0200
Message-Id: <1c29a0077ea95b4429a3dd82a4ea3ec826b3ae99.1630591985.git.pabeni@redhat.com>
In-Reply-To: <cover.1630591985.git.pabeni@redhat.com>
References: <cover.1630591985.git.pabeni@redhat.com>
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

They will be used by the next patch.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 include/net/tcp.h | 2 ++
 net/ipv4/tcp.c    | 4 ++--
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 3166dc15d7d6..dc52ea8adfc7 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -581,6 +581,8 @@ __u32 cookie_v6_init_sequence(const struct sk_buff *skb, __u16 *mss);
 #endif
 /* tcp_output.c */
 
+void skb_entail(struct sock *sk, struct sk_buff *skb);
+void tcp_mark_push(struct tcp_sock *tp, struct sk_buff *skb);
 void __tcp_push_pending_frames(struct sock *sk, unsigned int cur_mss,
 			       int nonagle);
 int __tcp_retransmit_skb(struct sock *sk, struct sk_buff *skb, int segs);
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index e8b48df73c85..7a3e632b0048 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -647,7 +647,7 @@ int tcp_ioctl(struct sock *sk, int cmd, unsigned long arg)
 }
 EXPORT_SYMBOL(tcp_ioctl);
 
-static inline void tcp_mark_push(struct tcp_sock *tp, struct sk_buff *skb)
+void tcp_mark_push(struct tcp_sock *tp, struct sk_buff *skb)
 {
 	TCP_SKB_CB(skb)->tcp_flags |= TCPHDR_PSH;
 	tp->pushed_seq = tp->write_seq;
@@ -658,7 +658,7 @@ static inline bool forced_push(const struct tcp_sock *tp)
 	return after(tp->write_seq, tp->pushed_seq + (tp->max_window >> 1));
 }
 
-static void skb_entail(struct sock *sk, struct sk_buff *skb)
+void skb_entail(struct sock *sk, struct sk_buff *skb)
 {
 	struct tcp_sock *tp = tcp_sk(sk);
 	struct tcp_skb_cb *tcb = TCP_SKB_CB(skb);
-- 
2.26.3

