Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 322AC139C
	for <mptcp@lists.linux.dev>; Wed, 24 Aug 2022 11:18:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1661339904;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4K/ilaNjHULF35m8WGbIYb9Dt50PAoquRCu6phEih4E=;
	b=ZjkVPw0R4CyhKGdV/4/20iMmdSNrLC5p9TMjorunQGdcBXONG4VaPvLrB8NRlcfVUlX/Xi
	p9Tq0sa0/qwn+PKrGoU+Tnw9pFgIf9qu3kcnsqO7/CFt2U5CBhaLQuqIEqZ40cT8inX/0n
	ZW3AZp0tAr1lqBq04rBlvrl8BIxxD54=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-404-Vv3TppSSMMq-u9lKHTSAyw-1; Wed, 24 Aug 2022 07:18:23 -0400
X-MC-Unique: Vv3TppSSMMq-u9lKHTSAyw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 847BC101A54E
	for <mptcp@lists.linux.dev>; Wed, 24 Aug 2022 11:18:23 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.194.133])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 14F73492C3B
	for <mptcp@lists.linux.dev>; Wed, 24 Aug 2022 11:18:22 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next 1/2] Squash-to: "mptcp: move msk input path under full msk socket lock"
Date: Wed, 24 Aug 2022 13:18:13 +0200
Message-Id: <30ec171851daca06e3c3a60a1d3e41ff5887eae2.1661339834.git.pabeni@redhat.com>
In-Reply-To: <cover.1661339834.git.pabeni@redhat.com>
References: <cover.1661339834.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

whoops, I forgot to really test for pending data at release_cb time.

The above causes several recurring failures in the self-tests.

Note that this could affect badly the mptcp performance (as we now
really move relevant CPU time from the subflow rx path/ksoftirqd to
the user-space process), even if I haven't performed perf-tests yet
on top of this change.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
This should be placed just before: "mptcp: move RCVPRUNE event later"/
the last rx path refactor
---
 net/mptcp/protocol.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 74699bd47edf..d47c19494023 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3008,7 +3008,8 @@ void __mptcp_check_push(struct sock *sk, struct sock *ssk)
 
 #define MPTCP_FLAGS_PROCESS_CTX_NEED (BIT(MPTCP_PUSH_PENDING) | \
 				      BIT(MPTCP_RETRANSMIT) | \
-				      BIT(MPTCP_FLUSH_JOIN_LIST))
+				      BIT(MPTCP_FLUSH_JOIN_LIST) | \
+				      BIT(MPTCP_DEQUEUE))
 
 /* processes deferred events and flush wmem */
 static void mptcp_release_cb(struct sock *sk)
-- 
2.37.1

