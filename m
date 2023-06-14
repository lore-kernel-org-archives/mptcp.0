Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 680C22C9C
	for <mptcp@lists.linux.dev>; Wed, 14 Jun 2023 14:54:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1686754481;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=CR74xvAVOkqMmE1IZ7asw0yxqg7hfYR9aU7nfH5Z7lA=;
	b=JpLHb8JYWEQbAnKevLTZ506/3/bZxnueQ+/n5slgIHwIaIp2hQ8jwXqoguufRoAtffWBox
	UJlxhlo7MDF2zpim7vunBUqh4wWKg7NGUQQPt00t445vJOW/pUsCvSvRR1Ji/ZsLx2H/gr
	4uuwEQOekA58QwavQ7c8SOUE8jD4wLo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-672-6O7SQDMfP6u0asnDResjZg-1; Wed, 14 Jun 2023 10:54:39 -0400
X-MC-Unique: 6O7SQDMfP6u0asnDResjZg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5B564101A588;
	Wed, 14 Jun 2023 14:54:39 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.193.87])
	by smtp.corp.redhat.com (Postfix) with ESMTP id B9AE6C1603B;
	Wed, 14 Jun 2023 14:54:38 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Cc: Christoph Paasch <cpaasch@apple.com>
Subject: [PATCH mptcp-net] mptcp: ensure listener is unhashed before updating the sk status
Date: Wed, 14 Jun 2023 16:54:31 +0200
Message-Id: <b96e12c9dd08dca94ce2539b01d0e609d472a22a.1686754464.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

The MPTCP protocol access the listener subflow in a lockless
manner in a couple of places (poll, diag). That works only if
the msk itself leaves the listener status only after that the
subflow itself has been closed/disconnected. Otherwise we risk
deadlock in diag, as reported by Christoph.

Address the issue ensuring that the first subflow (the listener
one) is always disconnected before updating the msk socket status.

Reported-by: Christoph Paasch <cpaasch@apple.com>
Fixes: b29fcfb54cd7 ("mptcp: full disconnect implementation")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
should close issues/407 for good
---
 net/mptcp/pm_netlink.c                        |  1 +
 net/mptcp/protocol.c                          | 31 ++++++++++++-------
 .../testing/selftests/net/mptcp/mptcp_join.sh |  3 ++
 3 files changed, 23 insertions(+), 12 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index ba1406e601e4..333c7e2a7f78 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1043,6 +1043,7 @@ static int mptcp_pm_nl_create_listen_socket(struct sock *sk,
 	if (err)
 		return err;
 
+	inet_sk_state_store(newsk, TCP_LISTEN);
 	err = kernel_listen(ssock, backlog);
 	if (err)
 		return err;
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index feaedfd2b3eb..015745108d8b 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2395,13 +2395,6 @@ static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 		kfree_rcu(subflow, rcu);
 	} else {
 		/* otherwise tcp will dispose of the ssk and subflow ctx */
-		if (ssk->sk_state == TCP_LISTEN) {
-			tcp_set_state(ssk, TCP_CLOSE);
-			mptcp_subflow_queue_clean(sk, ssk);
-			inet_csk_listen_stop(ssk);
-			mptcp_event_pm_listener(ssk, MPTCP_EVENT_LISTENER_CLOSED);
-		}
-
 		__tcp_close(ssk, 0);
 
 		/* close acquired an extra ref */
@@ -2952,10 +2945,24 @@ static __poll_t mptcp_check_readable(struct mptcp_sock *msk)
 	return EPOLLIN | EPOLLRDNORM;
 }
 
-static void mptcp_listen_inuse_dec(struct sock *sk)
+static void mptcp_check_listen_stop(struct sock *sk)
 {
-	if (inet_sk_state_load(sk) == TCP_LISTEN)
-		sock_prot_inuse_add(sock_net(sk), sk->sk_prot, -1);
+	struct sock *ssk;
+
+	if (inet_sk_state_load(sk) != TCP_LISTEN)
+		return;
+
+	sock_prot_inuse_add(sock_net(sk), sk->sk_prot, -1);
+	ssk = mptcp_sk(sk)->first;
+	if (WARN_ON_ONCE(!ssk || inet_sk_state_load(ssk) != TCP_LISTEN))
+		return;
+
+	lock_sock_nested(ssk, SINGLE_DEPTH_NESTING);
+	mptcp_subflow_queue_clean(sk, ssk);
+	inet_csk_listen_stop(ssk);
+	mptcp_event_pm_listener(ssk, MPTCP_EVENT_LISTENER_CLOSED);
+	tcp_set_state(ssk, TCP_CLOSE);
+	release_sock(ssk);
 }
 
 bool __mptcp_close(struct sock *sk, long timeout)
@@ -2968,7 +2975,7 @@ bool __mptcp_close(struct sock *sk, long timeout)
 	WRITE_ONCE(sk->sk_shutdown, SHUTDOWN_MASK);
 
 	if ((1 << sk->sk_state) & (TCPF_LISTEN | TCPF_CLOSE)) {
-		mptcp_listen_inuse_dec(sk);
+		mptcp_check_listen_stop(sk);
 		inet_sk_state_store(sk, TCP_CLOSE);
 		goto cleanup;
 	}
@@ -3084,7 +3091,7 @@ static int mptcp_disconnect(struct sock *sk, int flags)
 	if (msk->fastopening)
 		return -EBUSY;
 
-	mptcp_listen_inuse_dec(sk);
+	mptcp_check_listen_stop(sk);
 	inet_sk_state_store(sk, TCP_CLOSE);
 
 	mptcp_stop_timer(sk);
diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index a7973d6a40a0..cbb6c097da54 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -2808,6 +2808,9 @@ verify_listener_events()
 		echo "[ ok ]"
 		return 0
 	fi
+	echo  "$type ?=  $e_type - $family ?= $e_family - $saddr ?= $e_saddr - $sport ?= $e_sport"
+	echo $evt
+	cat $evt 
 	fail_test
 	echo "[fail]"
 }
-- 
2.40.1

