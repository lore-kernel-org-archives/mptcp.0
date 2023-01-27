Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26A13187F
	for <mptcp@lists.linux.dev>; Fri, 27 Jan 2023 18:41:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1674844897;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=K+krZCyycGVUiCFFhSll4cZYh0MWVM3/mg2hteRjV5M=;
	b=CxOFmxjOrFVgfMIWqHgIXXAWyWrSCkY8hUc23YuG2hyhYNh97HkwgLEtZdbs+S2g0xB9jC
	XFL4vuTea3fnaoYV/9zHMhIE8T17B/SSRAL2o8PyXTkYXbrb2jLWb9IpwreX5hcEz0afzI
	ddkzbIc/x+Y3es2px6dndz1a+LNIGlE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-456-aYfSk4cZMCq3jFO1k1Dz1g-1; Fri, 27 Jan 2023 13:41:35 -0500
X-MC-Unique: aYfSk4cZMCq3jFO1k1Dz1g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4EEB585C6E1
	for <mptcp@lists.linux.dev>; Fri, 27 Jan 2023 18:41:35 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.193.209])
	by smtp.corp.redhat.com (Postfix) with ESMTP id B4876400DE84
	for <mptcp@lists.linux.dev>; Fri, 27 Jan 2023 18:41:34 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-net v2] mptcp: be careful on subflow status propagation on errors
Date: Fri, 27 Jan 2023 19:40:44 +0100
Message-Id: <d2091b4407a0d54f561f44fcc438555454d9fb47.1674844826.git.pabeni@redhat.com>
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

Currently the subflow error report callback unconditionally
propagates the fallback subflow status to the owning msk.

If the msk is already orphaned, the above prevents the code
from correctly tracking the msk moving to the TCP_CLOSE state
and doing the appropriate cleanup.

All the above causes increasing memory usage over time and
sporadic self-tests failures.

There is a great deal of infrastructure trying to propagate
correctly the fallback subflow status to the owning mptcp socket,
e.g. via mptcp_subflow_eof() and subflow_sched_work_if_closed():
in the error propagation path we need only to cope with unorphaned
sockets.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/339
Fixes: 15cc10453398 ("mptcp: deliver ssk errors to msk")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
--
v1 -> v2:
 - propagate the status for non orphaned sockets
---
 net/mptcp/subflow.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 5e57a9a7178b..39a4b60f6d6b 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1404,6 +1404,7 @@ void __mptcp_error_report(struct sock *sk)
 	mptcp_for_each_subflow(msk, subflow) {
 		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
 		int err = sock_error(ssk);
+		int ssk_state;
 
 		if (!err)
 			continue;
@@ -1414,7 +1415,14 @@ void __mptcp_error_report(struct sock *sk)
 		if (sk->sk_state != TCP_SYN_SENT && !__mptcp_check_fallback(msk))
 			continue;
 
-		inet_sk_state_store(sk, inet_sk_state_load(ssk));
+		/* We need to propagate only transition to CLOSE statue and
+		 * orphaned socket will see such state change via
+		 * subflow_sched_work_if_closed() and that path will properly
+		 * destroy the msk as needed
+		 */
+		ssk_state = inet_sk_state_load(ssk);
+		if (ssk_state == TCP_CLOSE && !sock_flag(sk, SOCK_DEAD))
+			inet_sk_state_store(sk, ssk_state);
 		sk->sk_err = -err;
 
 		/* This barrier is coupled with smp_rmb() in mptcp_poll() */
-- 
2.39.1

