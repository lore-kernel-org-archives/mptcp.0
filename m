Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3A5E11723
	for <mptcp@lists.linux.dev>; Wed, 20 Sep 2023 12:45:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1695213945;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XbzKWWksyDUbgC3/lIzZ5LXCz/d93qA82ePjAsteVIY=;
	b=Ua2ZVYlfJhXeKWiLfI5T8OY6m59lbRSM6ve2nU7E2hUOQbIgMUjB90jnzL+zdPR91b5s4n
	VLIWSeiuJI6hezru/BZJh+e2MwBiUEudXHRMn3Eofbnt93xR0QRdo2pmaYyFutP1E58tWv
	S4MkPP1yMXqe7TZu2Uhlk/eERkU3oGQ=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-3-wf4CaAHtMq29I7_MqI_ADA-1; Wed, 20 Sep 2023 08:45:44 -0400
X-MC-Unique: wf4CaAHtMq29I7_MqI_ADA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0466C1C04B5C
	for <mptcp@lists.linux.dev>; Wed, 20 Sep 2023 12:45:44 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.123])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 86CE91055466
	for <mptcp@lists.linux.dev>; Wed, 20 Sep 2023 12:45:43 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next 4/4] mptcp: use copy_from_iter helpers on transmit..
Date: Wed, 20 Sep 2023 14:45:37 +0200
Message-ID: <02b40c4152ec29335d06c0b6d4ccd9f5bd64ea3c.1695208066.git.pabeni@redhat.com>
In-Reply-To: <cover.1695208066.git.pabeni@redhat.com>
References: <cover.1695208066.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

The perf traces show an high cost for the MPTCP transmit path memcpy.

It turn out that the helper currently in use carries quite a bit
of unneeded overhead, e.g. to map/unmap the memory pages.

Moving to the 'copy_from_iter' variant removes such overhead and
additionally gains the no-cache support.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/protocol.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 1de8eaccd48b..6f9e116598ed 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1766,6 +1766,18 @@ static int mptcp_sendmsg_fastopen(struct sock *sk, struct msghdr *msg,
 	return ret;
 }
 
+static int do_copy_data_nocache(struct sock *sk, int copy,
+				struct iov_iter *from, char *to)
+{
+	if (sk->sk_route_caps & NETIF_F_NOCACHE_COPY) {
+		if (!copy_from_iter_full_nocache(to, copy, from))
+			return -EFAULT;
+	} else if (!copy_from_iter_full(to, copy, from)) {
+		return -EFAULT;
+	}
+	return 0;
+}
+
 static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
@@ -1839,11 +1851,10 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 		if (!sk_wmem_schedule(sk, total_ts))
 			goto wait_for_memory;
 
-		if (copy_page_from_iter(dfrag->page, offset, psize,
-					&msg->msg_iter) != psize) {
-			ret = -EFAULT;
+		ret = do_copy_data_nocache(sk, psize, &msg->msg_iter,
+					   page_address(dfrag->page) + offset);
+		if (ret)
 			goto do_error;
-		}
 
 		/* data successfully copied into the write queue */
 		sk_forward_alloc_add(sk, -total_ts);
-- 
2.41.0

