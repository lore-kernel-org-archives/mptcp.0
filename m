Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [216.205.24.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E68272
	for <mptcp@lists.linux.dev>; Tue, 24 Aug 2021 09:16:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1629796586;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=jTFPfQNQOy2loMBw5xB2esdE+kPXasHIqOX8UQHf4LY=;
	b=EzLHehgWcDSO+OO/3/RJXTd66jcfsLpiVA6nCxZ5Vxm7DGjb/rpt8Zj1ifmhmqEo6OF8LN
	NLhr4C+WuJ/X6hcrBLdIaXfhC0ecKKoumbBZ7b/HU8ECFzgjKVbDgb/vkZHRVCdyQNax2H
	en37EMEgrKFL7dpgGx4VUN7e3VUTGJ0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-419-tZquxwO1NHqrt71RvwBVSw-1; Tue, 24 Aug 2021 05:16:25 -0400
X-MC-Unique: tZquxwO1NHqrt71RvwBVSw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 62CA1801E72
	for <mptcp@lists.linux.dev>; Tue, 24 Aug 2021 09:16:24 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.193.164])
	by smtp.corp.redhat.com (Postfix) with ESMTP id CDCD360CC9
	for <mptcp@lists.linux.dev>; Tue, 24 Aug 2021 09:16:23 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-net] Squash-to: "mptcp: fix possible divide by zero"
Date: Tue, 24 Aug 2021 11:16:19 +0200
Message-Id: <0a5ab819684c76d5947ee91c43a1bbd75f5aa47c.1629796563.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"

With the current 'can_collapse' definition, skb collapsing/coalescing
may not happen have if can_collapse is true. Since we fill the
tx cache only if 'can_collapse' is false, the TCP code can end-up
allocating an skb without mptcp extension and triggering a later
WARN

Fix the issue using a much more restrictive check for collapsing, so
that if such check is true, collapsing will happen for sure.
Additionally change the variable name accordingly and remove a now
erronous WARN_ON - collapsing can happen even if must_collapse is false.

Note that if by some bug we hit the opposite erroneous condition -
collapsing did not happen even if must_collapse is true - we will hit
the existing WARN_ON_ONCE(!mpext) check.

The coming message in the squash to commit should be updated replacing:

"""
This change addresses the issue refactoring the skb allocation
code so that skb allocation always happens after the call
to tcp_send_mss() correctly initialize mss_now.
"""

with:
"""
This change addresses the issue refactoring the skb allocation
code checking if skb collapsing will happen for sure and doing
the skb allocation only after such check. Skb allocation will happens
only after that the call to tcp_send_mss() correctly initializes mss_now.
"""

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/protocol.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index cd690794e22b..af8f677162f3 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1290,7 +1290,7 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct sock *ssk,
 	bool zero_window_probe = false;
 	struct mptcp_ext *mpext = NULL;
 	struct sk_buff *skb, *tail;
-	bool can_collapse = false;
+	bool must_collapse = false;
 	int size_bias = 0;
 	int avail_size;
 	size_t ret = 0;
@@ -1310,17 +1310,21 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct sock *ssk,
 		 * SSN association set here
 		 */
 		mpext = skb_ext_find(skb, SKB_EXT_MPTCP);
-		can_collapse = (info->size_goal - skb->len > 0) &&
-			 mptcp_skb_can_collapse_to(data_seq, skb, mpext);
-		if (!can_collapse) {
+		if (!mptcp_skb_can_collapse_to(data_seq, skb, mpext)) {
 			TCP_SKB_CB(skb)->eor = 1;
-		} else {
+			goto alloc_skb;
+		}
+
+		must_collapse = (info->size_goal - skb->len > 0) &&
+				(skb_shinfo(skb)->nr_frags < sysctl_max_skb_frags);
+		if (must_collapse) {
 			size_bias = skb->len;
 			avail_size = info->size_goal - skb->len;
 		}
 	}
 
-	if (!can_collapse && !ssk->sk_tx_skb_cache &&
+alloc_skb:
+	if (!must_collapse && !ssk->sk_tx_skb_cache &&
 	    !mptcp_alloc_tx_skb(sk, ssk, info->data_lock_held))
 		return 0;
 
@@ -1353,7 +1357,6 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct sock *ssk,
 	if (skb == tail) {
 		TCP_SKB_CB(tail)->tcp_flags &= ~TCPHDR_PSH;
 		mpext->data_len += ret;
-		WARN_ON_ONCE(!can_collapse);
 		WARN_ON_ONCE(zero_window_probe);
 		goto out;
 	}
-- 
2.26.3

