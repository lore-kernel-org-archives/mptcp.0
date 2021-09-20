Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9E233FCB
	for <mptcp@lists.linux.dev>; Mon, 20 Sep 2021 17:24:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1632158685;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jHJuP6TU+3CSIWM10S4+0yoR3zKV97SHbHfLlIweF6M=;
	b=PL1ByMO/mJzBUiihFtsnVIbfHXilRrV/YG6xqUMUOtJ2mw96ZH1Z9z4dd6A3Ag+w5ITmrX
	XPniSqcSFIksxvheUj3cGYgAYzBShwPU23/6jiId13wRVtgHY/oJZ7QgcT2d+UwMapa7wy
	FWIHxz5F/kojMEHvJn78eG4UUrGa/R0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-304-YRTxEMcwP5qEL1qOWgCqYQ-1; Mon, 20 Sep 2021 13:24:43 -0400
X-MC-Unique: YRTxEMcwP5qEL1qOWgCqYQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D56751923767
	for <mptcp@lists.linux.dev>; Mon, 20 Sep 2021 17:24:42 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.193.11])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 4D1FE1B400
	for <mptcp@lists.linux.dev>; Mon, 20 Sep 2021 17:24:42 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next 3/3] tcp: make tcp_build_frag() static
Date: Mon, 20 Sep 2021 19:24:29 +0200
Message-Id: <1949660e9af338adc8913b7cdf8c632401d6d6e0.1632158356.git.pabeni@redhat.com>
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

After the previous patch the mentioned helper is
used only inside its compilation unit: let's make
it static.

RFC -> v1:
 - preserve the tcp_build_frag() helper (Eric)

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
Note:
this should _replace_:
"""
Partially revert "tcp: factor out tcp_build_frag()"
"""

I did not opted for a squash to patch, as it would
still require conflicts resolution after the previous
squash-to patch. @matttbe: please let me know if you
prefer otherwise.
---
 include/net/tcp.h | 2 --
 net/ipv4/tcp.c    | 5 ++---
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 4a96f6e0f6f8..673c3b01e287 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -330,8 +330,6 @@ int tcp_sendpage(struct sock *sk, struct page *page, int offset, size_t size,
 		 int flags);
 int tcp_sendpage_locked(struct sock *sk, struct page *page, int offset,
 			size_t size, int flags);
-struct sk_buff *tcp_build_frag(struct sock *sk, int size_goal, int flags,
-			       struct page *page, int offset, size_t *size);
 ssize_t do_tcp_sendpages(struct sock *sk, struct page *page, int offset,
 		 size_t size, int flags);
 int tcp_send_mss(struct sock *sk, int *size_goal, int flags);
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index c592454625e1..4ae43222d71f 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -963,8 +963,8 @@ void tcp_remove_empty_skb(struct sock *sk, struct sk_buff *skb)
 	}
 }
 
-struct sk_buff *tcp_build_frag(struct sock *sk, int size_goal, int flags,
-			       struct page *page, int offset, size_t *size)
+static struct sk_buff *tcp_build_frag(struct sock *sk, int size_goal, int flags,
+				      struct page *page, int offset, size_t *size)
 {
 	struct sk_buff *skb = tcp_write_queue_tail(sk);
 	struct tcp_sock *tp = tcp_sk(sk);
@@ -1064,7 +1064,6 @@ ssize_t do_tcp_sendpages(struct sock *sk, struct page *page, int offset,
 		size_t copy = size;
 
 		skb = tcp_build_frag(sk, size_goal, flags, page, offset, &copy);
-		if (!skb)
 			goto wait_for_space;
 
 		if (!copied)
-- 
2.26.3

