Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [216.205.24.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 189C82C83
	for <mptcp@lists.linux.dev>; Fri, 15 Oct 2021 09:25:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1634289946;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1egjQgvve1wj1U6ZexQM4//Hlh3iOTX1wIEtAwnp8o0=;
	b=ARXAXb8+AqGivP6M4MDe5g4DZVspNUuDjA/FmeiN72Qg0X/N4DD4rvyYzq6odElauwbGxl
	obiTH8m0JuTtuv/7Ue4skTNY2C1SFEm5O9q4xUNAQfpuJKcYRqdpCp045LMYJvKZgOdE9B
	w0BnpgU1GF6XO9G3LVia/iL01Rqeko0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-467-y-WGq23iPb-caZ5PE5Ow7Q-1; Fri, 15 Oct 2021 05:25:44 -0400
X-MC-Unique: y-WGq23iPb-caZ5PE5Ow7Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0299356BEF
	for <mptcp@lists.linux.dev>; Fri, 15 Oct 2021 09:25:44 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.192.85])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 6E1875D740
	for <mptcp@lists.linux.dev>; Fri, 15 Oct 2021 09:25:43 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next 1/3] tcp: define macros for a couple reclaim thresholds
Date: Fri, 15 Oct 2021 11:25:23 +0200
Message-Id: <0d3f747f3a1dcdc67e71fc93cc1d64eee9e6b803.1634289695.git.pabeni@redhat.com>
In-Reply-To: <cover.1634289695.git.pabeni@redhat.com>
References: <cover.1634289695.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"

A following patch is going to implment for the MPTCP protocol
a similar reclaim schema, with different locking.

Let's define a couple of macros for the used thresholds, so
that the latter code will be more easily maintainable.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 include/net/sock.h | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/include/net/sock.h b/include/net/sock.h
index d08ab55fa4a0..9c5d0502090f 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -1568,6 +1568,12 @@ static inline void sk_mem_charge(struct sock *sk, int size)
 	sk->sk_forward_alloc -= size;
 }
 
+/* the following macros control control memory reclaiming in
+ * sk_mem_uncharge()
+ */
+#define SK_RECLAIM_THRESHOLD	(1 << 21)
+#define SK_RECLAIM_CHUNK	(1 << 20)
+
 static inline void sk_mem_uncharge(struct sock *sk, int size)
 {
 	int reclaimable;
@@ -1584,8 +1590,8 @@ static inline void sk_mem_uncharge(struct sock *sk, int size)
 	 * If we reach 2 MBytes, reclaim 1 MBytes right now, there is
 	 * no need to hold that much forward allocation anyway.
 	 */
-	if (unlikely(reclaimable >= 1 << 21))
-		__sk_mem_reclaim(sk, 1 << 20);
+	if (unlikely(reclaimable >= SK_RECLAIM_THRESHOLD))
+		__sk_mem_reclaim(sk, SK_RECLAIM_CHUNK);
 }
 
 static inline void sk_wmem_free_skb(struct sock *sk, struct sk_buff *skb)
-- 
2.26.3

