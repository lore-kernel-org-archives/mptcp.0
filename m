Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8B9B71
	for <mptcp@lists.linux.dev>; Tue, 22 Jun 2021 10:34:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1624358098;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=RnQScOZzUUouVL4RcnZunh6UJhB1XZbZsivCqMXCSKA=;
	b=EzwVqc8+uJ2dDy5bb8Ouw6zwxkas/axs5ZCgpT8pgi4j0VcyV7Q6de+dmeHk/Uky8dLL7N
	udxE9lwoicBd0xSnkKoDq2QsluBnFGboo5rHB7tMwpq9cT8R8k4Vco62IfRqlMrQQDVNhV
	6bvTTQrvXu/NE/BTUSTJn6XmZlm+gro=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-358-nWBmrffAOvCouVHVKigQfw-1; Tue, 22 Jun 2021 06:34:56 -0400
X-MC-Unique: nWBmrffAOvCouVHVKigQfw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 88CA4100C660;
	Tue, 22 Jun 2021 10:34:55 +0000 (UTC)
Received: from gerbillo.redhat.com (ovpn-114-227.ams2.redhat.com [10.36.114.227])
	by smtp.corp.redhat.com (Postfix) with ESMTP id A45AF5D6AD;
	Tue, 22 Jun 2021 10:34:54 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH mptcp-net] mptcp: properly account bulk freed memory
Date: Tue, 22 Jun 2021 12:34:41 +0200
Message-Id: <dc58277ea9c9bb6d8a71130a8fc19d995cb49b0c.1624357695.git.pabeni@redhat.com>
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

After commit 879526030c8b ("mptcp: protect the rx path with
the msk socket spinlock") the rmem currently used by a given
msk is really sk_rmem_alloc - rmem_released.

The safety check in mptcp_data_ready() does not take the above
in due account, as a result legit incoming data is keept in
subflow receive queue with no reason, delaying or blocking
MPTCP-level ack generation.

This change addresses the issue updating the check in mptcp_data_ready()
as needed. Additionally add a counter for such exceptional event
- the peer is misbehaving.

Finally update __mptcp_space() to properly compute the window size
given the current memory allocation.

Fixes: 879526030c8b ("mptcp: protect the rx path with the msk socket spinlock")
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/211
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
This additionally improves simult_flows.sh stability. @matttbe: could
you please have a spin in your testbad to see if we could close
issues/137, too?

side note: if the VM is slow enough, it could end-up causing failures
even if the protocol would be "perfect", not sure if we should consider
baremetal (or less VM nesting) here.
---
 net/mptcp/mib.c      | 1 +
 net/mptcp/mib.h      | 1 +
 net/mptcp/protocol.c | 4 +++-
 net/mptcp/protocol.h | 7 ++++++-
 4 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/mib.c b/net/mptcp/mib.c
index 52ea2517e856..ff2cc0e3273d 100644
--- a/net/mptcp/mib.c
+++ b/net/mptcp/mib.c
@@ -44,6 +44,7 @@ static const struct snmp_mib mptcp_snmp_list[] = {
 	SNMP_MIB_ITEM("RmSubflow", MPTCP_MIB_RMSUBFLOW),
 	SNMP_MIB_ITEM("MPPrioTx", MPTCP_MIB_MPPRIOTX),
 	SNMP_MIB_ITEM("MPPrioRx", MPTCP_MIB_MPPRIORX),
+	SNMP_MIB_ITEM("RcvPruned", MPTCP_MIB_RCVPRUNED),
 	SNMP_MIB_SENTINEL
 };
 
diff --git a/net/mptcp/mib.h b/net/mptcp/mib.h
index 193466c9b549..0663cb12b448 100644
--- a/net/mptcp/mib.h
+++ b/net/mptcp/mib.h
@@ -37,6 +37,7 @@ enum linux_mptcp_mib_field {
 	MPTCP_MIB_RMSUBFLOW,		/* Remove a subflow */
 	MPTCP_MIB_MPPRIOTX,		/* Transmit a MP_PRIO */
 	MPTCP_MIB_MPPRIORX,		/* Received a MP_PRIO */
+	MPTCP_MIB_RCVPRUNED,		/* Incoming packet dropped due to memory limit */
 	__MPTCP_MIB_MAX
 };
 
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index ddce5b7bbefd..105b312b1036 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -720,8 +720,10 @@ void mptcp_data_ready(struct sock *sk, struct sock *ssk)
 		sk_rbuf = ssk_rbuf;
 
 	/* over limit? can't append more skbs to msk, Also, no need to wake-up*/
-	if (atomic_read(&sk->sk_rmem_alloc) > sk_rbuf)
+	if (atomic_read(&sk->sk_rmem_alloc) - READ_ONCE(msk->rmem_released) > sk_rbuf) {
+		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_RCVPRUNED);
 		return;
+	}
 
 	/* Wake-up the reader only for in-sequence data */
 	mptcp_data_lock(sk);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 426ed80fe72f..60bd78210a36 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -296,9 +296,14 @@ static inline struct mptcp_sock *mptcp_sk(const struct sock *sk)
 	return (struct mptcp_sock *)sk;
 }
 
+/* the msk socket don't use the backlog, also account for the bulk
+ * free memory
+ */
 static inline int __mptcp_space(const struct sock *sk)
 {
-	return tcp_space(sk) + READ_ONCE(mptcp_sk(sk)->rmem_released);
+	return tcp_win_from_space(sk, READ_ONCE(sk->sk_rcvbuf) -
+				  atomic_read(&sk->sk_rmem_alloc) +
+				  mptcp_sk(sk)->rmem_released);
 }
 
 static inline struct mptcp_data_frag *mptcp_send_head(const struct sock *sk)
-- 
2.26.3

