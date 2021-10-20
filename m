Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [216.205.24.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91E1D72
	for <mptcp@lists.linux.dev>; Wed, 20 Oct 2021 19:56:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1634759804;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:content-type:content-type;
	bh=WQtrsjIFoB7ijExUec1g9gasg0XP+c/vsJtJ1rHZezo=;
	b=DPs8cYFXC6jbYkuLeX78P7spFNfv06o+p4zLx6YKVYLb139Ctd8mbPpEQnhjfnLXQcvILC
	nKgCyVYBYSja42DjGFX7bHvGUqPZGnGy5S1t+WesjIoHKz0rwtwo2UgXBqiqw19ZJyI3iX
	54j1ZhFqslbIFGzjea2qz7i/JdYK32w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-189-SW45Gq9sOZSJQOdNqFWVwQ-1; Wed, 20 Oct 2021 15:56:40 -0400
X-MC-Unique: SW45Gq9sOZSJQOdNqFWVwQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C7801802575
	for <mptcp@lists.linux.dev>; Wed, 20 Oct 2021 19:56:39 +0000 (UTC)
Received: from nst.lab.eng.brq.redhat.com (nst.lab.eng.brq.redhat.com [10.37.153.171])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 25596100238C;
	Wed, 20 Oct 2021 19:56:38 +0000 (UTC)
From: Poorva Sonparote <psonparo@redhat.com>
To: mptcp@lists.linux.dev
Cc: dcaratti@redhat.com
Subject: [PATCH RFC] Support for SOL_IP for MPTCP setsockopt
Date: Wed, 20 Oct 2021 19:56:01 +0000
Message-Id: <0c05b2c0bfb6cd5b6788d00c7f61474d0cd5a747.1634749192.git.psonparo@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=psonparo@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="US-ASCII"
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>

Hello!

I have been working on adding support for IP_TOS for setsockopt(). I
am attaching the packetdrill test and the patch but it  still won't set the TOS value
for the subflows that are created after the setsockopt() call.

https://github.com/multipath-tcp/mptcp_net-next/issues/220#issuecomment-947863717

Thanks,
Poorva




This patch adds support for IP_TOS for setsockopt(.. ,SOL_IP, ..)
https://github.com/multipath-tcp/mptcp_net-next/issues/220

Currently, any new subflows that are created after the setsockopt()
call are not being updated with the set IP_TOS value.

Signed-off-by: Poorva Sonparote <psonparo@redhat.com>
---
 net/mptcp/sockopt.c | 39 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 38 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index 8137cc3a4296..f5ee49660902 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -598,6 +598,40 @@ static int mptcp_setsockopt_sol_tcp_congestion(struct mptcp_sock *msk, sockptr_t
 	return ret;
 }
 
+static int mptcp_setsockopt_sol_ip_set_tos(struct mptcp_sock *msk, int optname,
+					   sockptr_t optval, unsigned int optlen)
+{
+	struct mptcp_subflow_context *subflow;
+	struct sock *sk = (struct sock *)msk;
+	int ret, err;
+	int val = 0;
+
+	err = ip_setsockopt(sk, SOL_IP, optname, optval, optlen);
+	val = inet_sk(sk)->tos;
+
+	if (err != 0)
+		return err;
+	lock_sock(sk);
+	mptcp_for_each_subflow(msk, subflow) {
+		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
+
+		ip_sock_set_tos(ssk, val);
+	}
+	release_sock(sk);
+	return ret;
+}
+
+static int mptcp_setsockopt_sol_ip(struct mptcp_sock *msk, int optname,
+				   sockptr_t optval, unsigned int optlen)
+{
+	switch (optname) {
+	case IP_TOS:
+		return  mptcp_setsockopt_sol_ip_set_tos(msk, optname, optval, optlen);
+	}
+
+	return -EOPNOTSUPP;
+}
+
 static int mptcp_setsockopt_sol_tcp(struct mptcp_sock *msk, int optname,
 				    sockptr_t optval, unsigned int optlen)
 {
@@ -637,12 +671,14 @@ int mptcp_setsockopt(struct sock *sk, int level, int optname,
 	if (ssk)
 		return tcp_setsockopt(ssk, level, optname, optval, optlen);
 
+	if (level == SOL_IP)
+		return mptcp_setsockopt_sol_ip(msk, optname, optval, optlen);
+
 	if (level == SOL_IPV6)
 		return mptcp_setsockopt_v6(msk, optname, optval, optlen);
 
 	if (level == SOL_TCP)
 		return mptcp_setsockopt_sol_tcp(msk, optname, optval, optlen);
-
 	return -EOPNOTSUPP;
 }
 
@@ -1000,6 +1036,7 @@ static void sync_socket_options(struct mptcp_sock *msk, struct sock *ssk)
 	ssk->sk_priority = sk->sk_priority;
 	ssk->sk_bound_dev_if = sk->sk_bound_dev_if;
 	ssk->sk_incoming_cpu = sk->sk_incoming_cpu;
+	ip_sock_set_tos(ssk, inet_sk(sk)->tos);
 
 	if (sk->sk_userlocks & tx_rx_locks) {
 		ssk->sk_userlocks |= sk->sk_userlocks & tx_rx_locks;
-- 
2.18.2

