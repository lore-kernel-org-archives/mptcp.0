Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8A663EA7B
	for <mptcp@lists.linux.dev>; Wed, 15 May 2024 17:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715794472; cv=none; b=D3+bG2aif/kjW3fhWjKOUQvGVQvaQWTbwC5BwwViym2qW+ppxpYgnGDYpotGvgVSSV71OfmxQnPjEyYF124hVslGJkK1gwWtpIuQ2dHBau0mIu4bhTb7wD8at7nVMTL1DoLbOJ9K0I121ot0tk9AkXnPWPD6gc4QCULZRo5Op/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715794472; c=relaxed/simple;
	bh=25ivvDa11rt94CVQbskM6C59Bv3SdiAETkwm36/ylxo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HdaEsDgVpizH88/LVEyPvMhTlI1JHbCuefELOGElLJABwYpgwDjlxMgYjRRsYFAh1j9XgXNJs8clHiZxoHVOrZ+24/87aoIGuflvES2IF0w6hB/9Ik8+6xIBZyzKPp391wvmxC/FvZLd1o+Bi1Q7ywBDXXWVGN2dZ27F0efM8IE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dVssbJNh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dVssbJNh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715794469;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=PhYptmRUOBn9FeNSOHDOIW8Cj9HYXEoas4CPDAN+pIs=;
	b=dVssbJNhDzpe9qkAlrOOZ+uQYExDRccyJLdGdDjPiJUYwXpoyexjkJk7pdAzbLydzl2YP5
	Sh4hPdoVr853xDWWZL1Rz1JB+Hr7beHtO4BvJKX0ktNldtcKT8dL5L+BvSwQdrIWeYXImr
	CJaFxqvjSyueg2P7hveo7aamUnUtVVU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-367-eRIH-yi3Mc2sIX_GqkZxxg-1; Wed, 15 May 2024 13:34:26 -0400
X-MC-Unique: eRIH-yi3Mc2sIX_GqkZxxg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 20B358058D3;
	Wed, 15 May 2024 17:34:26 +0000 (UTC)
Received: from dcaratti.users.ipa.redhat.com (unknown [10.45.225.185])
	by smtp.corp.redhat.com (Postfix) with ESMTP id C24D87414;
	Wed, 15 May 2024 17:34:24 +0000 (UTC)
From: Davide Caratti <dcaratti@redhat.com>
To: Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>,
	mptcp@lists.linux.dev
Subject: [PATCH mptcp-next] mptcp: refer to 'MPTCP' socket in comments
Date: Wed, 15 May 2024 19:34:15 +0200
Message-ID: <829272fc031f542c7a3d8e446eba19ee0f78dffb.1715794371.git.dcaratti@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

we used to call it 'master' socket at the early stages of MPTCP
development, but the correct wording is 'MPTCP' socket opposed to 'TCP
subflows': convert the last 3 coments to use a more appropriate term.

Signed-off-by: Davide Caratti <dcaratti@redhat.com>
---
 net/mptcp/protocol.c | 4 ++--
 net/mptcp/subflow.c  | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 579031c60937..fc879f1a7a1f 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2202,7 +2202,7 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 		if (skb_queue_empty(&msk->receive_queue) && __mptcp_move_skbs(msk))
 			continue;
 
-		/* only the master socket status is relevant here. The exit
+		/* only the MPTCP socket status is relevant here. The exit
 		 * conditions mirror closely tcp_recvmsg()
 		 */
 		if (copied >= target)
@@ -3521,7 +3521,7 @@ void mptcp_subflow_process_delegated(struct sock *ssk, long status)
 static int mptcp_hash(struct sock *sk)
 {
 	/* should never be called,
-	 * we hash the TCP subflows not the master socket
+	 * we hash the TCP subflows not the MPTCP socket
 	 */
 	WARN_ON_ONCE(1);
 	return 0;
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 612c38570a64..39e2cbdf3801 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1719,7 +1719,7 @@ int mptcp_subflow_create_socket(struct sock *sk, unsigned short family,
 	mptcp_sockopt_sync_locked(mptcp_sk(sk), sf->sk);
 	release_sock(sf->sk);
 
-	/* the newly created socket really belongs to the owning MPTCP master
+	/* the newly created socket really belongs to the owning MPTCP
 	 * socket, even if for additional subflows the allocation is performed
 	 * by a kernel workqueue. Adjust inode references, so that the
 	 * procfs/diag interfaces really show this one belonging to the correct
-- 
2.44.0

