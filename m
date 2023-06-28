Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F2E6BA32
	for <mptcp@lists.linux.dev>; Wed, 28 Jun 2023 11:27:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1687951665;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=EyoDHMyIq3940cRKe3aVcrbLhJkflJApf52NkM+hlBU=;
	b=LlbgA5N1q/gzDjsbGBT/wN6KwOLdMzZzbnx2Q/TXlLfl+9lbxXvx0i845xKGdKywC0u/fW
	OZgvi7pTdTwdqRuOaIEYmcSsjAMxVwUcq07FUFAki0BAH5YygYC3/COECGaP45yohYPsGt
	ip/l3o6gvx5JL0hd03bodf3QjynEdSs=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-564-uHP7wQjtOuSBLAVkm1m1Xw-1; Wed, 28 Jun 2023 07:27:42 -0400
X-MC-Unique: uHP7wQjtOuSBLAVkm1m1Xw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B1AA23C10146;
	Wed, 28 Jun 2023 11:27:41 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.225.51])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 19F0F40C2063;
	Wed, 28 Jun 2023 11:27:40 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Cc: Christoph Paasch <cpaasch@apple.com>
Subject: [PATCH mptcp-net] mptcp: do not rely on implicit state check in mptcp_listen()
Date: Wed, 28 Jun 2023 13:27:31 +0200
Message-Id: <9a42270be1b4d109351b22ad0331bab8051803fb.1687951613.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

Since the blamed commit, closing the first subflow resets the first
subflow socket state to SS_UNCONNECTED.

The current mptcp listen implementation relies only on such
state to prevent touching not-fully-disconnected sockets.

Incoming mptcp fastclose (or paired endpoint removal) unconditionally
closes the first subflow.

All the above allows an incoming fastclose followed by a listen() call
to successfully race with a blocking recvmsg(), potentially causing the
latter to hit a divide by zero bug in cleanup_rbuf/__tcp_select_window().

Address the issue explicitly checking the msk socket state in
mptcp_listen(). An alternative solution would be moving the first
subflow socket state update into mptcp_disconnect(), but in the long
term the first subflow socket should be removed: better avoid relaying
on it for internal consistency check.

Fixes: b29fcfb54cd7 ("mptcp: full disconnect implementation")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
This is basically a new version of "mptcp: fix bogus socket state update",
but since it uses a quite different logic, no revision increase ;)

Should close issues/414
---
 net/mptcp/protocol.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index a50eaa01ba8a..d3ff2a2c60de 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3751,6 +3751,11 @@ static int mptcp_listen(struct socket *sock, int backlog)
 	pr_debug("msk=%p", msk);
 
 	lock_sock(sk);
+
+	err = -EINVAL;
+	if (sock->state != SS_UNCONNECTED || sock->type != SOCK_STREAM)
+		goto unlock;
+
 	ssock = __mptcp_nmpc_socket(msk);
 	if (IS_ERR(ssock)) {
 		err = PTR_ERR(ssock);
-- 
2.40.1

