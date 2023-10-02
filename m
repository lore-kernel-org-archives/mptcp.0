Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DBA563DF
	for <mptcp@lists.linux.dev>; Mon,  2 Oct 2023 09:13:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1696238036;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=TnaxqB3aknZiecyIQh0g3wUJBNXFa6N+WpJDR99Sg2g=;
	b=MBtQ4E4Q7Ww2mjIM8iRiKKpmZFx2W6IIFvkp40jM3Ia8FsEK+YKJXmVQFmLqNDsRRChnK4
	Qap3L0frSnAX4qaCyardTMwjhJW2BwjnoOqCz82qvQryyBmvS29DPy8Y0uF/dq7SjyY23n
	rGi6Yn2YaNIZwiov2dv3FktpGZz2XtY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-444-c1pWrWupMCSC0mEKGjjwTw-1; Mon, 02 Oct 2023 05:13:53 -0400
X-MC-Unique: c1pWrWupMCSC0mEKGjjwTw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E8E4D101B041;
	Mon,  2 Oct 2023 09:13:52 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.225.2])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 597742026D4B;
	Mon,  2 Oct 2023 09:13:52 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Cc: Christoph Paasch <cpaasch@apple.com>
Subject: [PATCH mptcp-next v2 1/2] tcp: define initial scaling factor value as a macro
Date: Mon,  2 Oct 2023 11:13:41 +0200
Message-ID: <c71297499300a20bc41fe9c526d4a6cad08c176f.1696237983.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

So that other users could access it. Notably MPTCP will use
it in the next patch.

No functional change intended.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 include/net/tcp.h | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 91688d0dadcd..8b0364b44dd9 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -1453,13 +1453,15 @@ static inline int tcp_space_from_win(const struct sock *sk, int win)
 	return __tcp_space_from_win(tcp_sk(sk)->scaling_ratio, win);
 }
 
+/* Assume a conservative default of 1200 bytes of payload per 4K page.
+ * This may be adjusted later in tcp_measure_rcv_mss().
+ */
+#define TCP_DEFAULT_SCALING_RATIO ((1200 << TCP_RMEM_TO_WIN_SCALE) / \
+				   SKB_TRUESIZE(4096))
+
 static inline void tcp_scaling_ratio_init(struct sock *sk)
 {
-	/* Assume a conservative default of 1200 bytes of payload per 4K page.
-	 * This may be adjusted later in tcp_measure_rcv_mss().
-	 */
-	tcp_sk(sk)->scaling_ratio = (1200 << TCP_RMEM_TO_WIN_SCALE) /
-				    SKB_TRUESIZE(4096);
+	tcp_sk(sk)->scaling_ratio = TCP_DEFAULT_SCALING_RATIO;
 }
 
 /* Note: caller must be prepared to deal with negative returns */
-- 
2.41.0

