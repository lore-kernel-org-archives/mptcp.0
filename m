Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [63.128.21.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24B026D13
	for <mptcp@lists.linux.dev>; Thu, 15 Apr 2021 16:02:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1618502556;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VJtz8jweh4LNEcP7q3KQb6D8EoEPJUsr5mLhNo3rO3M=;
	b=W0SBT/X1eRG9iey4eccu+Sxli1xnDQmSg51MiiXusyKPQTDzgvXi6uiefFdxFPsN3O5x1m
	nvG9nsGiTwLFuxGmCu9OoDe95cMOYhd2RFcqQ4/Pvne1WeMIMbn6ibnUw/UBPXmaH8GMvG
	/jtptqrvlDgeiIlPINyfyk83EjmZ8s0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-600-OVunpmmoNl6HxHkusa44Vw-1; Thu, 15 Apr 2021 12:02:32 -0400
X-MC-Unique: OVunpmmoNl6HxHkusa44Vw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7952F64169
	for <mptcp@lists.linux.dev>; Thu, 15 Apr 2021 16:02:17 +0000 (UTC)
Received: from gerbillo.redhat.com (ovpn-115-128.ams2.redhat.com [10.36.115.128])
	by smtp.corp.redhat.com (Postfix) with ESMTP id E4E48610A8
	for <mptcp@lists.linux.dev>; Thu, 15 Apr 2021 16:02:16 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH net-next 3/3] mptcp: ignore unsupported msg flags
Date: Thu, 15 Apr 2021 18:02:07 +0200
Message-Id: <6254a6cfbb7269d0833be8aa07cbde1fd51a158c.1618502178.git.pabeni@redhat.com>
In-Reply-To: <cover.1618502178.git.pabeni@redhat.com>
References: <cover.1618502178.git.pabeni@redhat.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"

Currently mptcp_sendmsg() fails with EOPNOTSUPP if the
user-space provides some unsupported flag. That is unexpected
and may foul existing applications migrated to MPTCP, which
expect a different behavior.

Change the mentioned function to silently ignore the unsupported
flags except MSG_FASTOPEN. This is the only flags currently not
supported by MPTCP with user-space visible side-effects.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/162
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
v1 -> v2:
 - bail on MSG_FASTOPEN only

Note: this will conflict with the pending MSG_PEEK changes, with
hopefully simple resolution
---
 net/mptcp/protocol.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index e6d1c293a615..04cb937630f6 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1614,8 +1614,12 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 	int ret = 0;
 	long timeo;
 
-	if (msg->msg_flags & ~(MSG_MORE | MSG_DONTWAIT | MSG_NOSIGNAL))
-		return -EOPNOTSUPP;
+	/* we don't support FASTOPEN yet */
+	if (msg->msg_flags & MSG_FASTOPEN)
+		return -ENOTSUPP;
+
+	/* silently ignore everything else */
+	msg->msg_flags &= MSG_MORE | MSG_DONTWAIT | MSG_NOSIGNAL;
 
 	mptcp_lock_sock(sk, __mptcp_wmem_reserve(sk, min_t(size_t, 1 << 20, len)));
 
@@ -1951,9 +1955,6 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 	if (unlikely(flags & MSG_ERRQUEUE))
 		return inet_recv_error(sk, msg, len, addr_len);
 
-	if (msg->msg_flags & ~(MSG_WAITALL | MSG_DONTWAIT))
-		return -EOPNOTSUPP;
-
 	mptcp_lock_sock(sk, __mptcp_splice_receive_queue(sk));
 	if (unlikely(sk->sk_state == TCP_LISTEN)) {
 		copied = -ENOTCONN;
-- 
2.26.2

