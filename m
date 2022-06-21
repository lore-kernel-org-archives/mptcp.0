Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36F931397
	for <mptcp@lists.linux.dev>; Tue, 21 Jun 2022 16:27:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1655828870;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qfvy5xe8v42Riddjtvknu6QPPK/Cd+lPocQdapZEuh0=;
	b=gg2Jl1yViNhgNXh7ohY5q0h3DSKBGl4WHeKqCdoV9/NB60gLtt5mc8Bt7Ks61vOq95UPRT
	zRQmdM3P1V2qocLs7Jt8UKo+prZa5STpRRMWsAm45vLX6/2mRlI9tVEBOV1AXZzVD4bfm4
	JXssiIsRdlm8yFcBj9ijZfCZ9oFKXWY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-281-TNUxs1b8O_-7NT17tSxRuA-1; Tue, 21 Jun 2022 12:27:48 -0400
X-MC-Unique: TNUxs1b8O_-7NT17tSxRuA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 657D883397C
	for <mptcp@lists.linux.dev>; Tue, 21 Jun 2022 16:27:48 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.193.164])
	by smtp.corp.redhat.com (Postfix) with ESMTP id E9C2F492CA3
	for <mptcp@lists.linux.dev>; Tue, 21 Jun 2022 16:27:47 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH v4 mptcp-next 3/4] mptcp: refine memory scheduling
Date: Tue, 21 Jun 2022 18:27:36 +0200
Message-Id: <fe5cb4f8ae9c9218147af1cd37f60c3ef28ec5df.1655828070.git.pabeni@redhat.com>
In-Reply-To: <630f7e13d7226f8c37a9cc0c66008a298c1e6b9e.1655828070.git.pabeni@redhat.com>
References: <630f7e13d7226f8c37a9cc0c66008a298c1e6b9e.1655828070.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
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
v3 -> v4:
 - do not allocate 0 bytes (Mat)
---
 net/mptcp/protocol.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index b31bac33f87a..b1fae2f747c9 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -323,9 +323,10 @@ static bool mptcp_rmem_schedule(struct sock *sk, struct sock *ssk, int size)
 	struct mptcp_sock *msk = mptcp_sk(sk);
 	int amt, amount;
 
-	if (size < msk->rmem_fwd_alloc)
+	if (size <= msk->rmem_fwd_alloc)
 		return true;
 
+	size -= msk->rmem_fwd_alloc;
 	amt = sk_mem_pages(size);
 	amount = amt << PAGE_SHIFT;
 	if (!__sk_mem_raise_allocated(sk, size, amt, SK_MEM_RECV))
-- 
2.35.3

