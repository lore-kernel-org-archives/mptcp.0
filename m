Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F693FC2
	for <mptcp@lists.linux.dev>; Tue, 31 Aug 2021 07:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1630395614;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=skqGj8zXu/GOJRbSuByip/VQbdUsmCd7j2B+QTRoGKQ=;
	b=asFl/juTLsIDCwxwE/O1D8wKAfynQTkHP4DiUYdcwOXI78NwtmRtLZ5kbTW/xxUtmBpTok
	FKf21BVNZFS1tDkcuYOQ4P+g0994CwoJewEESc9EUo9kMbJL/3ncBFsA/m/m2yS2jf7txz
	51d0Nx1KOUP1fflUQCa+GJb0ooJ5V3w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-122-OT7LvPobMaePWvMKY8cKqw-1; Tue, 31 Aug 2021 03:40:12 -0400
X-MC-Unique: OT7LvPobMaePWvMKY8cKqw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D1EFA18C8C0C
	for <mptcp@lists.linux.dev>; Tue, 31 Aug 2021 07:40:11 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.194.25])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 38E605D6D5
	for <mptcp@lists.linux.dev>; Tue, 31 Aug 2021 07:40:11 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH net-next] Squash-to: "mptcp: fix possible divide by zero"
Date: Tue, 31 Aug 2021 09:40:07 +0200
Message-Id: <87b65514b5296bbf24b50d08b5289a977fa2a31e.1630395581.git.pabeni@redhat.com>
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

To be appended to the commit message:

v1 -> v2:
 - use lockdep_assert_held_once() - Jakub
 - fix indentation - Jakub

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/protocol.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 898485e4c1dd..eda149d89f4e 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1008,9 +1008,7 @@ static void mptcp_wmem_uncharge(struct sock *sk, int size)
 
 static void __mptcp_mem_reclaim_partial(struct sock *sk)
 {
-#ifdef CONFIG_LOCKDEP
-	WARN_ON_ONCE(!lockdep_is_held(&sk->sk_lock.slock));
-#endif
+	lockdep_assert_held_once(&sk->sk_lock.slock);
 	__mptcp_update_wmem(sk);
 	sk_mem_reclaim_partial(sk);
 }
@@ -1515,7 +1513,7 @@ void __mptcp_push_pending(struct sock *sk, unsigned int flags)
 	struct sock *prev_ssk = NULL, *ssk = NULL;
 	struct mptcp_sock *msk = mptcp_sk(sk);
 	struct mptcp_sendmsg_info info = {
-				.flags = flags,
+		.flags = flags,
 	};
 	struct mptcp_data_frag *dfrag;
 	int len, copied = 0;
-- 
2.26.3

