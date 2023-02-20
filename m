Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E34A763CB
	for <mptcp@lists.linux.dev>; Mon, 20 Feb 2023 14:27:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1676903260;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=YmhL+W87uANXPBq7knCoxvmIIMHULPTFZ+vmQs7nRzk=;
	b=KA5EWivxBiMaNohslRzRfErJoFOHh6XHImdWDUKEhwzLHCaNis6WQf7yhPmr68bOtBo+JL
	U2dT7svkqnRcffAwvxcXFTfQlmrCBw00/qJQA/WB6792EqPGp6jZ32JdayWJbM7xQiMyZC
	iUFq7mB5oOgZGeMdIHVhWUrHmGkM+EM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-523-o5ZjlvH6Ncye-nFN68hOLQ-1; Mon, 20 Feb 2023 09:27:39 -0500
X-MC-Unique: o5ZjlvH6Ncye-nFN68hOLQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8952518A6461
	for <mptcp@lists.linux.dev>; Mon, 20 Feb 2023 14:27:39 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.192.157])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 190EA40C1423
	for <mptcp@lists.linux.dev>; Mon, 20 Feb 2023 14:27:38 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next] Squash-to: mptcp: refactor passive socket initialization
Date: Mon, 20 Feb 2023 15:27:26 +0100
Message-Id: <29f3677f2032145ac2b1c1a90ec96ef0d61e4269.1676889558.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

Since the squash-to commit, msk->first is set even for unaccepted
sockets: mptcp_mp_fail_no_response() can take action and reset
the subflow even when msk->first is still in the accept queue,
after that incoming reset already closed such socket.

That in turn will end-up calling tcp_done() - via mptcp_subflow_reset()
- on already closed sockets, which is illegal.

Let's fix the issue explicitly checking the subflow socket status
in mptcp_subflow_reset().

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
Since is a squash-to patch this will likely lose the reported-by
tag, but perhaps we can preserve the:
Tested-by: Christoph Paasch <cpaasch@apple.com>
Also:
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/357
but I think it's better to handle the issue workflow manually here
---
 net/mptcp/subflow.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index a14c3a0c7c00..28c64811a8af 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -397,6 +397,12 @@ void mptcp_subflow_reset(struct sock *ssk)
 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
 	struct sock *sk = subflow->conn;
 
+	/* mptcp_mp_fail_no_response() can reach here on an already closed
+	 * socket
+	 */
+	if (ssk->sk_state == TCP_CLOSE)
+		return;
+
 	/* must hold: tcp_done() could drop last reference on parent */
 	sock_hold(sk);
 
-- 
2.39.2

