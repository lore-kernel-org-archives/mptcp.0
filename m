Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [216.205.24.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1C1D2C81
	for <mptcp@lists.linux.dev>; Thu, 11 Nov 2021 16:21:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1636647718;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=44DfOAC6I6ruJeti5Ujr/kwA8RUOK+Jd1rYbql/5lMM=;
	b=ENqlE8aRtCr4DLhvjxuUmBXC7JGetwQIBbvfuXJG3z51yX9zm8N9VoGkBMFkHLfhPZ3ReP
	uHyl+8nMEEWB9KGQ4bVooJcHbpCNO4vQF6qUGG5l0gifiHvuJ0kyqwKXa4di/AlOHAgvR7
	hfYFf1wDIFJtp7rWsYxwXpC8WP9lqMg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-585-lXkPt4MIPDuL5vEEdYVBKQ-1; Thu, 11 Nov 2021 11:21:56 -0500
X-MC-Unique: lXkPt4MIPDuL5vEEdYVBKQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EB682A40C0
	for <mptcp@lists.linux.dev>; Thu, 11 Nov 2021 16:21:55 +0000 (UTC)
Received: from gerbillo.fritz.box (unknown [10.39.194.197])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 594EA5D6B1
	for <mptcp@lists.linux.dev>; Thu, 11 Nov 2021 16:21:55 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH v2 mptcp-next 6/7] mptcp: implement support for user-space disconnect
Date: Thu, 11 Nov 2021 17:21:41 +0100
Message-Id: <3ca2682745f315b4106c2041a85e58b325eed03b.1636647623.git.pabeni@redhat.com>
In-Reply-To: <cover.1636647623.git.pabeni@redhat.com>
References: <cover.1636647623.git.pabeni@redhat.com>
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

Handle explicitly AF_UNSPEC in mptcp_stream_connnect() to
allow user-space to disconnect established MPTCP connections

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/protocol.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index ee2a5169c13a..8319db8ae3ed 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3428,9 +3428,20 @@ static int mptcp_stream_connect(struct socket *sock, struct sockaddr *uaddr,
 	struct mptcp_sock *msk = mptcp_sk(sock->sk);
 	struct mptcp_subflow_context *subflow;
 	struct socket *ssock;
-	int err;
+	int err = -EINVAL;
 
 	lock_sock(sock->sk);
+	if (uaddr) {
+		if (addr_len < sizeof(uaddr->sa_family))
+			goto unlock;
+
+		if (uaddr->sa_family == AF_UNSPEC) {
+			err = mptcp_disconnect(sock->sk, flags);
+			sock->state = err ? SS_DISCONNECTING : SS_UNCONNECTED;
+			goto unlock;
+		}
+	}
+
 	if (sock->state != SS_UNCONNECTED && msk->subflow) {
 		/* pending connection or invalid state, let existing subflow
 		 * cope with that
@@ -3440,10 +3451,8 @@ static int mptcp_stream_connect(struct socket *sock, struct sockaddr *uaddr,
 	}
 
 	ssock = __mptcp_nmpc_socket(msk);
-	if (!ssock) {
-		err = -EINVAL;
+	if (!ssock)
 		goto unlock;
-	}
 
 	mptcp_token_destroy(msk);
 	inet_sk_state_store(sock->sk, TCP_SYN_SENT);
-- 
2.33.1

