Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B803672
	for <mptcp@lists.linux.dev>; Fri, 20 Aug 2021 17:44:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1629481470;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WBLK9dxkwCOWt6U7lkJUMXpyc2VWFGNdXQWWFZ/vMEQ=;
	b=VIDyI8YWrdCJRfE08f2WTzLesJhcDjvgouyzI/qZdNaU/z7HHz3u6T2JtbfSqBzO4Wflpk
	voRemjXLKBIQ2icaf2Vjli1k68Tz7u0vagZ+ey7Gy1GKi8s3zyf0LoRAuXiaWdwCQov1dE
	S5JwBEEsQ5wQNNEGx0q//tZ6jfeHhIs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-458-G83NAlYBOAycVF1KK-Ve0w-1; Fri, 20 Aug 2021 13:44:29 -0400
X-MC-Unique: G83NAlYBOAycVF1KK-Ve0w-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C2E09193F560
	for <mptcp@lists.linux.dev>; Fri, 20 Aug 2021 17:44:28 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.194.87])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 384EE5D9D5
	for <mptcp@lists.linux.dev>; Fri, 20 Aug 2021 17:44:28 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp 2/2] mptcp: make the locking tx schema more readable
Date: Fri, 20 Aug 2021 19:44:13 +0200
Message-Id: <67b8b55e97771cd60b2e80de05eda1998d6046b9.1629481305.git.pabeni@redhat.com>
In-Reply-To: <cover.1629481305.git.pabeni@redhat.com>
References: <cover.1629481305.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"

Florian noted the locking schema used by __mptcp_push_pending()
is hard to follow, let's add some more descriptive comments
and drop an unneeded and confusing check.

Suggested-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/protocol.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 84aa11a0b2d5..cd690794e22b 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1525,15 +1525,19 @@ void __mptcp_push_pending(struct sock *sk, unsigned int flags)
 			mptcp_flush_join_list(msk);
 			ssk = mptcp_subflow_get_send(msk);
 
-			/* try to keep the subflow socket lock across
-			 * consecutive xmit on the same socket
+			/* First check. If the ssk has changed since
+			 * the last round, release prev_ssk
 			 */
 			if (ssk != prev_ssk && prev_ssk)
 				mptcp_push_release(sk, prev_ssk, &info);
 			if (!ssk)
 				goto out;
 
-			if (ssk != prev_ssk || !prev_ssk)
+			/* Need to lock the new subflow only if different
+			 * from the previous one, otherwise we are still
+			 * helding the relevant lock
+			 */
+			if (ssk != prev_ssk)
 				lock_sock(ssk);
 
 			ret = mptcp_sendmsg_frag(sk, ssk, dfrag, &info);
-- 
2.26.3

