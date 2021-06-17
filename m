Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB25872
	for <mptcp@lists.linux.dev>; Thu, 17 Jun 2021 17:05:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1623949529;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=MJK2iZEat6fhLZbH99clAkrUE62eSBG7L/NW5jpiuas=;
	b=C9+MpP9l/Bpd1gHMbSGdT0w5+KKiumjxZ1nIigCoojggq0H+TUSd8Lk8RP5j1HRNCoLYvJ
	zP3LPW9Ir8lH15iwVeFV8WO1j/9g0A5ePf1Qa+ZvR6v56xuhButWsCfGpxJvgkAPQHRQ8h
	TKuSFv/5yYPfQYd3aECLJMQuqg+o2S4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-286-o0J-plFtPwuEqpeuXZdgrA-1; Thu, 17 Jun 2021 13:05:27 -0400
X-MC-Unique: o0J-plFtPwuEqpeuXZdgrA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A066B100C664
	for <mptcp@lists.linux.dev>; Thu, 17 Jun 2021 17:05:26 +0000 (UTC)
Received: from gerbillo.redhat.com (ovpn-114-131.ams2.redhat.com [10.36.114.131])
	by smtp.corp.redhat.com (Postfix) with ESMTP id D41AD6062C
	for <mptcp@lists.linux.dev>; Thu, 17 Jun 2021 17:05:25 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH v2 mptcp-net] mptcp: avoid race on msk state changes
Date: Thu, 17 Jun 2021 19:05:21 +0200
Message-Id: <a96e100aa429a9bb947a2b22cc16682649c93550.1623949487.git.pabeni@redhat.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"

The msk socket state is currently updated in a few spots without
owning the msk socket lock itself.

Some of such operations are safe, as they happens before exposing
the msk socket to user-space and can't race with other changes.

A couple of them, at connect time, can actually race with close()
or shutdown(), leaving breaking the socket state machine.

This change addresses the issue moving such update under the msk
socket lock with the usual:

<acquire spinlock>
<check sk lock onwers>
<ev defer to release_cb>

scheme.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/56
Fixes: 8fd738049ac3 ("mptcp: fallback in case of simultaneous connect")
Fixes: c3c123d16c0e ("net: mptcp: don't hang in mptcp_sendmsg() after TCP fallbac")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
--
v1 -> v2:
 - move the hooks inside release_cb() before other state-related actions
---
 net/mptcp/protocol.c |  5 +++++
 net/mptcp/protocol.h |  2 ++
 net/mptcp/subflow.c  | 30 ++++++++++++++++++++++--------
 3 files changed, 29 insertions(+), 8 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 05c8382aafef..ddce5b7bbefd 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2902,6 +2902,11 @@ static void mptcp_release_cb(struct sock *sk)
 		spin_lock_bh(&sk->sk_lock.slock);
 	}
 
+	/* be sure to set the current sk state before tacking actions
+	 * depending on sk_state
+	 */
+	if (test_and_clear_bit(MPTCP_CONNECTED, &mptcp_sk(sk)->flags))
+		__mptcp_set_connected(sk);
 	if (test_and_clear_bit(MPTCP_CLEAN_UNA, &mptcp_sk(sk)->flags))
 		__mptcp_clean_una_wakeup(sk);
 	if (test_and_clear_bit(MPTCP_ERROR_REPORT, &mptcp_sk(sk)->flags))
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 2480db50cbd2..515bb1e6acec 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -112,6 +112,7 @@
 #define MPTCP_ERROR_REPORT	8
 #define MPTCP_RETRANSMIT	9
 #define MPTCP_WORK_SYNC_SETSOCKOPT 10
+#define MPTCP_CONNECTED		11
 
 static inline bool before64(__u64 seq1, __u64 seq2)
 {
@@ -600,6 +601,7 @@ void mptcp_get_options(const struct sock *sk,
 		       struct mptcp_options_received *mp_opt);
 
 void mptcp_finish_connect(struct sock *sk);
+void __mptcp_set_connected(struct sock *sk);
 static inline bool mptcp_is_fully_established(struct sock *sk)
 {
 	return inet_sk_state_load(sk) == TCP_ESTABLISHED &&
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 6772802737e4..0b5d4a3eadcd 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -373,6 +373,24 @@ static bool subflow_use_different_dport(struct mptcp_sock *msk, const struct soc
 	return inet_sk(sk)->inet_dport != inet_sk((struct sock *)msk)->inet_dport;
 }
 
+void __mptcp_set_connected(struct sock *sk)
+{
+	if (sk->sk_state == TCP_SYN_SENT) {
+		inet_sk_state_store(sk, TCP_ESTABLISHED);
+		sk->sk_state_change(sk);
+	}
+}
+
+static void mptcp_set_connected(struct sock *sk)
+{
+	mptcp_data_lock(sk);
+	if (!sock_owned_by_user(sk))
+		__mptcp_set_connected(sk);
+	else
+		set_bit(MPTCP_CONNECTED, &mptcp_sk(sk)->flags);
+	mptcp_data_unlock(sk);
+}
+
 static void subflow_finish_connect(struct sock *sk, const struct sk_buff *skb)
 {
 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(sk);
@@ -381,10 +399,6 @@ static void subflow_finish_connect(struct sock *sk, const struct sk_buff *skb)
 
 	subflow->icsk_af_ops->sk_rx_dst_set(sk, skb);
 
-	if (inet_sk_state_load(parent) == TCP_SYN_SENT) {
-		inet_sk_state_store(parent, TCP_ESTABLISHED);
-		parent->sk_state_change(parent);
-	}
 
 	/* be sure no special action on any packet other than syn-ack */
 	if (subflow->conn_finished)
@@ -417,6 +431,7 @@ static void subflow_finish_connect(struct sock *sk, const struct sk_buff *skb)
 			 subflow->remote_key);
 		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_MPCAPABLEACTIVEACK);
 		mptcp_finish_connect(sk);
+		mptcp_set_connected(parent);
 	} else if (subflow->request_join) {
 		u8 hmac[SHA256_DIGEST_SIZE];
 
@@ -457,6 +472,7 @@ static void subflow_finish_connect(struct sock *sk, const struct sk_buff *skb)
 	} else if (mptcp_check_fallback(sk)) {
 fallback:
 		mptcp_rcv_space_init(mptcp_sk(parent), sk);
+		mptcp_set_connected(parent);
 	}
 	return;
 
@@ -564,6 +580,7 @@ static void mptcp_sock_destruct(struct sock *sk)
 
 static void mptcp_force_close(struct sock *sk)
 {
+	/* the msk is not yet exposed to user-space */
 	inet_sk_state_store(sk, TCP_CLOSE);
 	sk_common_release(sk);
 }
@@ -1577,10 +1594,7 @@ static void subflow_state_change(struct sock *sk)
 		mptcp_rcv_space_init(mptcp_sk(parent), sk);
 		pr_fallback(mptcp_sk(parent));
 		subflow->conn_finished = 1;
-		if (inet_sk_state_load(parent) == TCP_SYN_SENT) {
-			inet_sk_state_store(parent, TCP_ESTABLISHED);
-			parent->sk_state_change(parent);
-		}
+		mptcp_set_connected(parent);
 	}
 
 	/* as recvmsg() does not acquire the subflow socket for ssk selection
-- 
2.26.3

