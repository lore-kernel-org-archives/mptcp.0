Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C04526FA1
	for <mptcp@lists.linux.dev>; Wed, 25 Jan 2023 17:38:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1674668301;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=HUhfx3lBpiPRer8MpFBJ2H0SifUezJBKZf5dRAoNDpg=;
	b=I8bYlfCmDkOjXbAoei4peULwuaXbGvA9JgPBa6Iz3OvVrII8V2WyTI/n3hy9xap16Dqn9T
	GHk9bkr3BJJOe489BK4nDU8FPnRZn7f0IrY83r1X36Fn6UYMWM71inal28hfR+TiNtB7mD
	bVb9xTqJGP8KfyIncWOL7qf1RzmrUr8=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-160-BmzcB4tpNfewzwvrVdzN-g-1; Wed, 25 Jan 2023 12:38:20 -0500
X-MC-Unique: BmzcB4tpNfewzwvrVdzN-g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5D5952804832
	for <mptcp@lists.linux.dev>; Wed, 25 Jan 2023 17:38:20 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.192.60])
	by smtp.corp.redhat.com (Postfix) with ESMTP id E16012026D4B
	for <mptcp@lists.linux.dev>; Wed, 25 Jan 2023 17:38:19 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-net] mptcp: do not propagate fallback subflow status on error
Date: Wed, 25 Jan 2023 18:38:16 +0100
Message-Id: <97f7deb4132d567132088d43f3e7f5ff0602a45b.1674668294.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

Currently the subflow error report callback unconditionally
propagates the fallback subflow status to the owning msk.

That is not needed as there is a great deal of infrastructure
trying to propagate correctly the fallback subflow status to
the owning mptcp socket, e.g. via mptcp_subflow_eof() and
subflow_sched_work_if_closed().

And in some circumstances - specifically if the msk is already
orphaned - it prevents the code from correctly tracking the msk
moving to the TCP_CLOSE state and doing the appropriate
cleanup.

All the above causes increasing memory usage over time and
sporadic self-tests failures.

Address the issue simply removing the unneeded state update.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/339
Fixes: 15cc10453398 ("mptcp: deliver ssk errors to msk")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/subflow.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index beaec843f5ca..5f952d0e06d4 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1410,7 +1410,6 @@ void __mptcp_error_report(struct sock *sk)
 		if (sk->sk_state != TCP_SYN_SENT && !__mptcp_check_fallback(msk))
 			continue;
 
-		inet_sk_state_store(sk, inet_sk_state_load(ssk));
 		sk->sk_err = -err;
 
 		/* This barrier is coupled with smp_rmb() in mptcp_poll() */
-- 
2.39.1

