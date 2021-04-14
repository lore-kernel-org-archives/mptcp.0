Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [216.205.24.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D16D6D28
	for <mptcp@lists.linux.dev>; Wed, 14 Apr 2021 15:24:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1618413839;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=rM193jpSn99K6IZckUB0pfghkwzJTdUMlovlihhFq08=;
	b=WhWgdpEd4L5fEYqwZ0KlhGJOMLZpqF+47mmQbRH8Tk4SAiZ2Mpuvy3f/FJusav+YEKRuz6
	g/FxgQrRZp4+mVnMrcfz257wwhCy2Kk4y28pasVMqNMA8u5B0QWlXoh855fTzYEpXSc/Ah
	BeY1Zl6Cfn76Y0lbF7l8l1jNc5V/bNY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-167-wOrvJme3PTmMMEEpKgzfCg-1; Wed, 14 Apr 2021 11:23:55 -0400
X-MC-Unique: wOrvJme3PTmMMEEpKgzfCg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CFF63107ACE6
	for <mptcp@lists.linux.dev>; Wed, 14 Apr 2021 15:23:54 +0000 (UTC)
Received: from gerbillo.redhat.com (ovpn-113-255.ams2.redhat.com [10.36.113.255])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 484EA60877
	for <mptcp@lists.linux.dev>; Wed, 14 Apr 2021 15:23:54 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next] mptcp: ignore unsupported msg flags
Date: Wed, 14 Apr 2021 17:23:19 +0200
Message-Id: <fb3746774c97c3042beb7d76cf9f23e57d7f85e1.1618413785.git.pabeni@redhat.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"

Currently mptcp_sendmsg()/mptcp_recvmsg() fail with EOPNOTSUPP
if the user-space provides some unsupported flag. That is
unexpected and may foul existing applications migrated to MPTCP,
which expect a different behavior.

Change the mentioned function to silently ignore the unsupported
flags.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/162
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/protocol.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 2d895c3c8746..bdec946b9b04 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1585,8 +1585,8 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 	int ret = 0;
 	long timeo;
 
-	if (msg->msg_flags & ~(MSG_MORE | MSG_DONTWAIT | MSG_NOSIGNAL))
-		return -EOPNOTSUPP;
+	/* ignore unsupported flags */
+	msg->msg_flags &= MSG_MORE | MSG_DONTWAIT | MSG_NOSIGNAL;
 
 	mptcp_lock_sock(sk, __mptcp_wmem_reserve(sk, min_t(size_t, 1 << 20, len)));
 
@@ -1916,8 +1916,8 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 	int target;
 	long timeo;
 
-	if (msg->msg_flags & ~(MSG_WAITALL | MSG_DONTWAIT))
-		return -EOPNOTSUPP;
+	/* ignore unsupported flags */
+	msg->msg_flags &= MSG_WAITALL | MSG_DONTWAIT;
 
 	mptcp_lock_sock(sk, __mptcp_splice_receive_queue(sk));
 	if (unlikely(sk->sk_state == TCP_LISTEN)) {
-- 
2.26.2

