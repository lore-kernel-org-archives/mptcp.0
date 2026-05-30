Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE802FD7D3
	for <mptcp@lists.linux.dev>; Sat, 30 May 2026 15:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780153742; cv=none; b=lJpiCYiVVetADNWUh9V7zSbWIrE7fAkk6xNv9uQ0uSZbE3lE81Oi7J0zQ3iBGo4GLziNO+x/qcMrI9eZseIujjhmwzF6DiVCV51CphqWVhFcwJrwgKlaxRy6GeE7Xb53IPX9IStj/YsrDiiOBOKmXXo6tLmqYH5/TgXSEoEr4O4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780153742; c=relaxed/simple;
	bh=RnbuBRhSw7nN3Fpujyqfi5X3SJAeM2mafBeQCSmv7Uo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:content-type; b=i/RK1UfPAeOTSCBilfrhDggH/wwbNseQUNWIb/Bi7mBe7YBva5YJwOBZ6jNPvHzM+2lc4p/XoyK8aYm4OiARQYUzV/KpCIBhr80Gkk8E3rwt0jZOgGbCAjmPT1vA3mKxQPSxv36s2gkHAtQCbi5luolyQ6CXyCSJ2jtOgzxurTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MU+A3NHv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MU+A3NHv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780153740;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=lpjAfbGYO1NzxaA0KBrbmjWMka7/qmOZgeVexMxGfww=;
	b=MU+A3NHvyrbdSnAahehReuBP1194leG9AZOxxTMhMFLGU8uiRHicD9B0whvLBxzep0CBfl
	XPeiCJdbjqodDN/UVHNzfgLMiYWp9BQOAT8cNcJxUwwr4b4UZQxDi70mtcqQREiY+4NdIk
	j51WVtyHPXp7J3oBGcQosv9o7JCAz/k=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-467-DIXlFdaYN9KP1DuLsLpn6A-1; Sat,
 30 May 2026 11:08:58 -0400
X-MC-Unique: DIXlFdaYN9KP1DuLsLpn6A-1
X-Mimecast-MFC-AGG-ID: DIXlFdaYN9KP1DuLsLpn6A_1780153738
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0D9E319560B2
	for <mptcp@lists.linux.dev>; Sat, 30 May 2026 15:08:58 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.32.9])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3B36F1955F22
	for <mptcp@lists.linux.dev>; Sat, 30 May 2026 15:08:57 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next] Squash-to: "mptcp: implemented OoO queue pruning"
Date: Sat, 30 May 2026 17:08:53 +0200
Message-ID: <406ff2a2ec71581f6ea6e7882a8ea631c20e23c7.1780153732.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: dPqoW5JE0Tx2NHQbphKIe_BfDUQJgMn5WJtzh3eH2_Y_1780153738
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Sashiko noted that mptcp_prune_ofo_queue() is 1 byte too restrictive with
the bound check compared to the pre-existing code.

Accepts rmem <= sk_rcvbuf.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/protocol.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 264a13bc6f3e..8bfa21ef52ff 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -402,7 +402,7 @@ static bool mptcp_prune_ofo_queue(struct sock *sk, u64 seq)
 		msk->ooo_last_skb = rb_to_skb(prev);
 
 		mem = (unsigned int)sk_rmem_alloc_get(sk);
-		if (mem < sk->sk_rcvbuf)
+		if (mem <= sk->sk_rcvbuf)
 			break;
 
 		node = prev;
@@ -413,7 +413,7 @@ static bool mptcp_prune_ofo_queue(struct sock *sk, u64 seq)
 
 out:
 	mem = (unsigned int)sk_rmem_alloc_get(sk);
-	return mem < sk->sk_rcvbuf;
+	return mem <= sk->sk_rcvbuf;
 }
 
 static bool __mptcp_move_skb(struct sock *sk, struct sk_buff *skb)
-- 
2.54.0

