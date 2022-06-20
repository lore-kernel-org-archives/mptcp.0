Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 776F92562
	for <mptcp@lists.linux.dev>; Mon, 20 Jun 2022 16:19:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1655741976;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6hgnm+tHg/Nq6/RCmdaH5beEZtteyR8AKDGBcJxwjp4=;
	b=g3uS0XCINS005rQW6Z9xAIGeRq6Z4rQ/G2wUVTO0Xo9YAmzp80XzYxiaJFoUX/v1O4GkeY
	mnaxIsDQ6Y78MYy4pEb0X8fyfaMJuf/228kah2itT6vLesSRQASaC294j87auHHh0cQ0p+
	Y5Pz1YztoBu6KYsDEZA+R8i5xvi3ek8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-220-g7ivmPF4N6aGdn-oszyGvw-1; Mon, 20 Jun 2022 12:19:27 -0400
X-MC-Unique: g7ivmPF4N6aGdn-oszyGvw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9054980B90C
	for <mptcp@lists.linux.dev>; Mon, 20 Jun 2022 16:19:27 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.195.59])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 209EE40CF8F0
	for <mptcp@lists.linux.dev>; Mon, 20 Jun 2022 16:19:26 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH net-next v3 3/3] mptcp: refine memory scheduling
Date: Mon, 20 Jun 2022 18:19:05 +0200
Message-Id: <9ab1ce9ee1019cb90181d4e6268c37448c8af46b.1655741931.git.pabeni@redhat.com>
In-Reply-To: <630f7e13d7226f8c37a9cc0c66008a298c1e6b9e.1655741931.git.pabeni@redhat.com>
References: <630f7e13d7226f8c37a9cc0c66008a298c1e6b9e.1655741931.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.1
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

Similar to commit 7c80b038d23e ("net: fix sk_wmem_schedule() and
sk_rmem_schedule() errors"), let the MPTCP receive path schedule
exactly the required amount of memory.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/protocol.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index b31bac33f87a..0e295b3bce54 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -326,6 +326,7 @@ static bool mptcp_rmem_schedule(struct sock *sk, struct sock *ssk, int size)
 	if (size < msk->rmem_fwd_alloc)
 		return true;
 
+	size -= msk->rmem_fwd_alloc;
 	amt = sk_mem_pages(size);
 	amount = amt << PAGE_SHIFT;
 	if (!__sk_mem_raise_allocated(sk, size, amt, SK_MEM_RECV))
-- 
2.35.3

