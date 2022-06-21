Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 335ED1397
	for <mptcp@lists.linux.dev>; Tue, 21 Jun 2022 16:27:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1655828873;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ik1XcngKKAtAbxBpsNRYCk0QrxMk94lneBx6Xeqq0hk=;
	b=YJREfTZbx6gY+JzxCpbsx6cd09mDgnyLr0E1z5FtKC/YsJRBOm+q4abuNKceDDKCeCyXeq
	x4JBzhKt4B3tgY4X101G3ORcUmSDAromsGGsJBn9eWCMgTO95oUtcQ6jzTiHLgctCPpa+X
	yth4LFhtRHxu/EEw0RWr0yEm5Zb/Bjs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-576-bvKSnL9cNmi5t8eLSc6fhg-1; Tue, 21 Jun 2022 12:27:49 -0400
X-MC-Unique: bvKSnL9cNmi5t8eLSc6fhg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2894385A580
	for <mptcp@lists.linux.dev>; Tue, 21 Jun 2022 16:27:49 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.193.164])
	by smtp.corp.redhat.com (Postfix) with ESMTP id ABF2F492C3B
	for <mptcp@lists.linux.dev>; Tue, 21 Jun 2022 16:27:48 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH v4 mptcp-next 4/4] net: remove SK_RECLAIM_THRESHOLD and SK_RECLAIM_CHUNK
Date: Tue, 21 Jun 2022 18:27:37 +0200
Message-Id: <746be47fdbbf4c5fadb9d5dcb2ee2e9cff0dacf5.1655828070.git.pabeni@redhat.com>
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

There are no more users for the mentioned macros, just
drop them.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 include/net/sock.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/include/net/sock.h b/include/net/sock.h
index 5bed1ea7a722..c3ac36b7b7b8 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -1619,11 +1619,6 @@ static inline void sk_mem_charge(struct sock *sk, int size)
 	sk->sk_forward_alloc -= size;
 }
 
-/* the following macros control memory reclaiming in mptcp_rmem_uncharge()
- */
-#define SK_RECLAIM_THRESHOLD	(1 << 21)
-#define SK_RECLAIM_CHUNK	(1 << 20)
-
 static inline void sk_mem_uncharge(struct sock *sk, int size)
 {
 	if (!sk_has_account(sk))
-- 
2.35.3

