Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3ED063BB
	for <mptcp@lists.linux.dev>; Mon, 20 Feb 2023 14:27:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1676903259;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=JRK4i3ZRhfBxdmzSYCHDGkzQ8eLQcXa4qGrYxCl6Uxg=;
	b=DP5MVHWws9t7ihI2NzW435Ri9pA4eW6c6tQQJV4OiDHpAir8MZ24q/17jnATyfTKSnaAMe
	LgsrO09FsfcdGg9PypuSVuFg81idKpM1qIUDyHnxzAplgOxHHufCU0t6cEuN2roNPBNWfm
	vNA8er+VTR1wRygHRntG/ulFHQ/EoJI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-537-5KZQm71yMAmidfLEHAWFlA-1; Mon, 20 Feb 2023 09:27:38 -0500
X-MC-Unique: 5KZQm71yMAmidfLEHAWFlA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1E6E485A588
	for <mptcp@lists.linux.dev>; Mon, 20 Feb 2023 14:27:38 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.192.157])
	by smtp.corp.redhat.com (Postfix) with ESMTP id A0DBE40C1423
	for <mptcp@lists.linux.dev>; Mon, 20 Feb 2023 14:27:37 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-net] mptcp: fix possible deadlock in subflow_error_report
Date: Mon, 20 Feb 2023 15:27:25 +0100
Message-Id: <c2265383cb2190247f7dec66fb67182e558bf5a1.1676889543.git.pabeni@redhat.com>
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

Christoph reported a possible deadlock while the TCP stack
destroys an unaccepted subflow due to an incoming reset: the
MPTCP socket error path tries to acquire the msk-level socket
lock while TCP still owns the listener socket accept queue
spinlock, and the reverse dependency already exists in the
TCP stack.

Note that the above is actually a lockdep false positive, as
the chain involves two separate sockets. A different per-socket
lockdep key will address the issue, but such a change will be
quite invasive.

Instead, we can simply stop earlier the socket error handling
for orphaned or unaccepted subflows, breaking the critical
lockdep chain. Error handling in such a scenario is a no-op.

Reported-and-tested-by: Christoph Paasch <cpaasch@apple.com>
Fixes: 15cc10453398 ("mptcp: deliver ssk errors to msk")
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/355
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
Note that the fixes tag above is different from the bisected, much
more recent, commit pointed by syzkaller, but I believe (code
inspection shows) that the DL scenario is present since it.
---
 net/mptcp/subflow.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 8b46311b8d5e..a14c3a0c7c00 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1437,6 +1437,13 @@ static void subflow_error_report(struct sock *ssk)
 {
 	struct sock *sk = mptcp_subflow_ctx(ssk)->conn;
 
+	/* bail early if this is a no-op, so that we avoid introducing a
+	 * problematic lockdep dependency between TCP accept queue lock
+	 * and msk socket spinlock
+	 */
+	if (!sk->sk_socket)
+		return;
+
 	mptcp_data_lock(sk);
 	if (!sock_owned_by_user(sk))
 		__mptcp_error_report(sk);
-- 
2.39.2

