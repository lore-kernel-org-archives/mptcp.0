Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D44C979D6
	for <mptcp@lists.linux.dev>; Wed,  5 Apr 2023 22:47:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1680734869;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bEE5f7/2/S4jkoe5f5gpLftEXutV5Xo2thLzHOxJOF8=;
	b=fUH6wu4akqEroL0pVg33QrMRoryimKLhoo18orQWUeo5UvB098bLShVwKMMvJ6iLbFK81g
	dRgE8/VAskZB7JdyxM8mRkT8aJpoBkEqY/dQucCmN399okrsR73TPccQbTYivYV0FI7wLj
	/ikgJm/b1a9/oLgZUtSBFUCj640MAhc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-262-zm4eqpD4Pu2mrv6SHcQTEw-1; Wed, 05 Apr 2023 18:47:48 -0400
X-MC-Unique: zm4eqpD4Pu2mrv6SHcQTEw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D3C80185A791;
	Wed,  5 Apr 2023 22:47:47 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.193.138])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 3F46A140EBF4;
	Wed,  5 Apr 2023 22:47:47 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Cc: Christoph Paasch <cpaasch@apple.com>
Subject: [PATCH mptcp-net 2/2] Squash-to: "mptcp: stops worker on unaccepted sockets at listener close"
Date: Thu,  6 Apr 2023 00:47:38 +0200
Message-Id: <728d7ef6b46f1f38ae37a49411ca90e0991057d0.1680733942.git.pabeni@redhat.com>
In-Reply-To: <cover.1680733942.git.pabeni@redhat.com>
References: <cover.1680733942.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

The mentioned patch carries a bad lockdep annotation. The msk socket
lock is not nested, as that is the outermost one, held only by the
user-space.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/subflow.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 32e54b7fdbbc..c6ae5ddd3bb0 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1882,8 +1882,7 @@ void mptcp_subflow_queue_clean(struct sock *listener_sk, struct sock *listener_s
 		 */
 		mutex_release(&listener_sk->sk_lock.dep_map, _RET_IP_);
 		mptcp_cancel_work(sk);
-		mutex_acquire(&listener_sk->sk_lock.dep_map,
-			      SINGLE_DEPTH_NESTING, 0, _RET_IP_);
+		mutex_acquire(&listener_sk->sk_lock.dep_map, 0, 0, _RET_IP_);
 
 		sock_put(sk);
 	}
-- 
2.39.2

