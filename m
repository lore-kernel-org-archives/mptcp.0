Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1305E6D3A
	for <mptcp@lists.linux.dev>; Thu, 15 Apr 2021 16:02:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1618502549;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=72pHPVDPmEuxwjYH0+v/QR9Kwbj0zbpBiWuTUjMdRSk=;
	b=R2wcE6ypYuftFoN3UwoeAPP3TpFOeBPpRZfaJ8z+i7PQ9XB/F75XzPXRmFxWS8/BHtJZke
	z2jZx21GGl3jghgoFUnnZa8842I0N2CkHTZGxoaRI7gq6mRgbN8UCNlPGoBX5OSbRjFvO7
	EtlPbf+3iSN0teoAJmRWRWoPA11e1XA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-464-GXAVbMOPMQ6Xb3Gug6TGwA-1; Thu, 15 Apr 2021 12:02:27 -0400
X-MC-Unique: GXAVbMOPMQ6Xb3Gug6TGwA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B3125A3482A
	for <mptcp@lists.linux.dev>; Thu, 15 Apr 2021 16:02:15 +0000 (UTC)
Received: from gerbillo.redhat.com (ovpn-115-128.ams2.redhat.com [10.36.115.128])
	by smtp.corp.redhat.com (Postfix) with ESMTP id E78126025C
	for <mptcp@lists.linux.dev>; Thu, 15 Apr 2021 16:02:14 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH net-next 1/3] mptcp: implement dummy MSG_ERRQUEUE support
Date: Thu, 15 Apr 2021 18:02:05 +0200
Message-Id: <372f93e8d85570f897fd1801cb90f591ef478c2a.1618502178.git.pabeni@redhat.com>
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

mptcp_recvmsg() currently silently ignores MSG_ERRQUEUE, returning
input data instead of error cmsg.

This change provides a dummy implementation for MSG_ERRQUEUE - always
returns no data. That is consistent with the current lack of a suitable
IP_RECVERR setsockopt() support.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/protocol.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 0437fe4f0552..ed9ada31f2da 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1945,6 +1945,10 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 	int target;
 	long timeo;
 
+	/* MSG_ERRQUEUE is really a no-op till we support IP_RECVERR */
+	if (unlikely(flags & MSG_ERRQUEUE))
+		return inet_recv_error(sk, msg, len, addr_len);
+
 	if (msg->msg_flags & ~(MSG_WAITALL | MSG_DONTWAIT))
 		return -EOPNOTSUPP;
 
-- 
2.26.2

