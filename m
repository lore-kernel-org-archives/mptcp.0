Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0257628E4
	for <mptcp@lists.linux.dev>; Thu, 16 Jun 2022 13:26:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1655386004;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=3yYEsbY1MX5dVaWbZ1rgBtnQPF3NrwaSq2tJ7Q49ZUw=;
	b=UnfDwroHq7MQ5JuSowb2hgOd27O8ZworJNfwXkNBl/yhCaD0yjQ9tqk4e9HGOKxxIqVSe5
	YFtyXCFqoV1dy8gu9MJgBKBgwUBkdCjpR1kWnwCDGCKjSs9hxUp2cnbIViFdhSG7bvJjNx
	JaeT9jpNj7NAlN8VVGlN12UFKB/DWTs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-626-gEhnUGfSPSSmutBydLI09w-1; Thu, 16 Jun 2022 09:26:43 -0400
X-MC-Unique: gEhnUGfSPSSmutBydLI09w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E64A58339A7
	for <mptcp@lists.linux.dev>; Thu, 16 Jun 2022 13:26:42 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.193.220])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 773EB1121314
	for <mptcp@lists.linux.dev>; Thu, 16 Jun 2022 13:26:42 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next 1/2] mptcp: never fetch fwd memory from the subflow
Date: Thu, 16 Jun 2022 15:26:36 +0200
Message-Id: <8a8f923a2d66057e4025892a4e83fc81fc7461f6.1655385956.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

The memory accounting is broken in such exceptional code
path, and after commit 4890b686f408 ("net: keep sk->sk_forward_alloc
as small as possible") we can't find much help there.

Drop the broken code.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
This is possibly for net, but makes sense only on top of recent
net-next patches, so whatever ;)
---
 net/mptcp/protocol.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 35e3060233c9..390ac5d95664 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -328,15 +328,10 @@ static bool mptcp_rmem_schedule(struct sock *sk, struct sock *ssk, int size)
 
 	amt = sk_mem_pages(size);
 	amount = amt << PAGE_SHIFT;
-	msk->rmem_fwd_alloc += amount;
-	if (!__sk_mem_raise_allocated(sk, size, amt, SK_MEM_RECV)) {
-		if (ssk->sk_forward_alloc < amount) {
-			msk->rmem_fwd_alloc -= amount;
-			return false;
-		}
+	if (!__sk_mem_raise_allocated(sk, size, amt, SK_MEM_RECV))
+		return false;
 
-		ssk->sk_forward_alloc -= amount;
-	}
+	msk->rmem_fwd_alloc += amount;
 	return true;
 }
 
-- 
2.35.3

