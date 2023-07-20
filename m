Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBF9B10785
	for <mptcp@lists.linux.dev>; Thu, 20 Jul 2023 06:34:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1689834876;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tmw6yiU46wVY8ao7MIape28CS3UbDHwvcjdFhSG+H2c=;
	b=elmc6fY74IkdXxNtcEGJYgs8Vr+O/15cezbK2pSDG2C+PwbQSxGGybf+BVK3KMQI+ZGYfC
	DW4BYOJP63yz8CLZfK3MBLddTXX/wFxYIXbrRWsWQI917D0k4SqiJ1FyOKmd6fYM/KTTQl
	w53Zqssg8W0mMQ4ZEAehsJ9NrcXwQ78=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-629-F1TJm25fMu-O86LQ-Rv1yw-1; Thu, 20 Jul 2023 02:34:34 -0400
X-MC-Unique: F1TJm25fMu-O86LQ-Rv1yw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2F6AE8564EF
	for <mptcp@lists.linux.dev>; Thu, 20 Jul 2023 06:34:34 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.225])
	by smtp.corp.redhat.com (Postfix) with ESMTP id B1F761454143
	for <mptcp@lists.linux.dev>; Thu, 20 Jul 2023 06:34:33 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next 2/2] Squash-to: "mptcp: avoid additional __inet_stream_connect() call"
Date: Thu, 20 Jul 2023 08:34:26 +0200
Message-ID: <af7285778734d7e4f238663b457602cea05a309e.1689834758.git.pabeni@redhat.com>
In-Reply-To: <cover.1689834758.git.pabeni@redhat.com>
References: <cover.1689834758.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

In the mentioned commit I unintenionally left over a couple of
possible cleanup.

Add the following to the commit message, befere "No functional change
intended.":

"""
The sk-level connect never return -EINPROGRESS, cleanup the error
path accordingly. Additionally, the ssk status on error is always
TCP_CLOSE. Avoid unneeded access to the subflow sk state.
"""

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/protocol.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 9e48dfbd102f..067e90168a49 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3655,18 +3655,14 @@ static int mptcp_connect(struct sock *sk, struct sockaddr *uaddr, int addr_len)
 	/* on successful connect, the msk state will be moved to established by
 	 * subflow_finish_connect()
 	 */
-	if (unlikely(err && err != -EINPROGRESS)) {
+	if (unlikely(err)) {
 		/* avoid leaving a dangling token in an unconnected socket */
 		mptcp_token_destroy(msk);
-		inet_sk_state_store(sk, inet_sk_state_load(ssk));
+		inet_sk_state_store(sk, TCP_CLOSE);
 		return err;
 	}
 
 	mptcp_copy_inaddrs(sk, ssk);
-
-	/* silence EINPROGRESS and let the caller inet_stream_connect
-	 * handle the connection in progress
-	 */
 	return 0;
 }
 
-- 
2.41.0

