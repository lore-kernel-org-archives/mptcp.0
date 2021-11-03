Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 578F72C98
	for <mptcp@lists.linux.dev>; Wed,  3 Nov 2021 17:42:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1635961377;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=q5PS9Xot1aGC0oE41fMYmTmdBkde45aIIIn6WNtLgnQ=;
	b=cbG2P6XVoFjpidCCd5qT2M+k7Y6xy5p7v0a0qU0O/1tizA/k3YtR099chMkPmmIefEK1yi
	K7bkcmacToReTrXem3rLgparNRSHyMgWMFr/i6EjZNddsll3g/cR7jLjffmUq2pM0W1ULj
	+EpqdCecy13HL9Yz+BVR9nYeZkAa9c0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-155-DW5crJgyN_eCI7ByHI_O6Q-1; Wed, 03 Nov 2021 13:42:52 -0400
X-MC-Unique: DW5crJgyN_eCI7ByHI_O6Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0E9458042A8
	for <mptcp@lists.linux.dev>; Wed,  3 Nov 2021 17:42:52 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.195.53])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 6CFE460843
	for <mptcp@lists.linux.dev>; Wed,  3 Nov 2021 17:42:51 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-net] mptcp: fix race between close() and accept()
Date: Wed,  3 Nov 2021 18:42:47 +0100
Message-Id: <beea1c3bd7e3fc9b8bc309874cec2597766d7fba.1635958931.git.pabeni@redhat.com>
Precedence: bulk
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

The current implementation of mptcp_accept() is prone to the
following race vs mptcp_close():

(on CPU 0)
listen(msk)
accept(msk)
  |-> mptcp_stream_accept(msk)
        |-> <listen status check successful>

(preempted or on CPU 1)
close(msk)
  |-> <msk->sk_state = TCP_CLOSE, ssk is orphaned, ssk state is unchanged>

(preempted or on CPU 0, continuing accept())
  |-> mptcp_accept()
        |-> inet_csk_accept()
              |-> <ssk status check is successful even if ssk is orphaned: oops>

The solution is atomically close the listener subflow at mptcp_close()
time.

Reported-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
Fixes: e16163b6e2b7 ("mptcp: refactor shutdown and close")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
Note: this should close:

https://github.com/multipath-tcp/mptcp_net-next/issues/239

but without a repro I can't be sure...
---
 net/mptcp/protocol.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 1ee3530ac2a3..4c96a9eb2142 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2712,18 +2712,25 @@ static void mptcp_close(struct sock *sk, long timeout)
 	lock_sock(sk);
 	sk->sk_shutdown = SHUTDOWN_MASK;
 
-	if ((1 << sk->sk_state) & (TCPF_LISTEN | TCPF_CLOSE)) {
-		inet_sk_state_store(sk, TCP_CLOSE);
+	if (sk->sk_state == TCP_LISTEN) {
+		struct socket *listener;
+
+		listener = __mptcp_nmpc_socket(mptcp_sk(sk));
+		if (listener)
+			__mptcp_close_ssk(sk, listener->sk, mptcp_subflow_ctx(listener->sk));
 		goto cleanup;
 	}
 
+	if (sk->sk_state == TCP_CLOSE)
+		goto cleanup;
+
 	if (mptcp_close_state(sk))
 		__mptcp_wr_shutdown(sk);
 
 	sk_stream_wait_close(sk, timeout);
 
 cleanup:
-	/* orphan all the subflows */
+	/* orphan all the non listener subflows */
 	inet_csk(sk)->icsk_mtup.probe_timestamp = tcp_jiffies32;
 	mptcp_for_each_subflow(mptcp_sk(sk), subflow) {
 		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
-- 
2.26.3

