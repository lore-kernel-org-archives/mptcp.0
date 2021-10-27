Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F4452C9F
	for <mptcp@lists.linux.dev>; Wed, 27 Oct 2021 21:06:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1635368787;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:content-type:content-type:in-reply-to:in-reply-to:
	 references:references; bh=3KTkVx7luJyA4eL1h3efgiMD5QmmIEDZJB8uhR4bYCQ=;
	b=fOIaxxVIDs8vcCBp9g9vj4mLQpkoXgOJSrZ6seUJ/FhD7JIg0ZScmrMV/LqYB93B9yDXvp
	2lNkuXxC/7VsegV5Tq299miStGqZ/iGoX04VQIr9oaxxRGs3jg3IYZ5HT9mbKrBSGcQ3Ng
	8PJbZOSW85aN2O2cDhVhDyBpBr4UHyU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-474-SnCEWYsuNnGif0AgWUA5fA-1; Wed, 27 Oct 2021 17:06:21 -0400
X-MC-Unique: SnCEWYsuNnGif0AgWUA5fA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F0BF610A8E1C;
	Wed, 27 Oct 2021 21:06:20 +0000 (UTC)
Received: from nst.lab.eng.brq.redhat.com (nst.lab.eng.brq.redhat.com [10.37.153.171])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 2A3D25C1B4;
	Wed, 27 Oct 2021 21:06:20 +0000 (UTC)
From: Poorva Sonparote <psonparo@redhat.com>
To: mptcp@lists.linux.dev
Cc: mathew.j.martineau@linux.intel.com,
	matthieu.baerts@tessares.net
Subject: [PATCH mptcp-next v4 2/2] Support for IP_TOS for MPTCP setsockopt()
Date: Wed, 27 Oct 2021 21:05:08 +0000
Message-Id: <26ff53b562d73cecbfa84f0e42d3ff100bc936cf.1635367735.git.psonparo@redhat.com>
In-Reply-To: <cover.1635367735.git.psonparo@redhat.com>
References: <cover.1635367735.git.psonparo@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
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

SOL_IP provides a way to configure network layer attributes in a
socket. This patch adds support for IP_TOS for setsockopt(.. ,SOL_IP, ..)
https://github.com/multipath-tcp/mptcp_net-next/issues/220

Support for SOL_IP is added in mptcp_setsockopt() and IP_TOS is handled in
a private function. The idea here is to take in the value passed for IP_TOS
and set it to the current subflow, open subflows as well new subflows that
might be created after the initial call to setsockopt(). This sync is done
using sync_socket_options(.., ssk) and setting the value of tos using
__ip_sock_set_tos(ssk,..).

The patch has been tested using the packetdrill script here -
https://github.com/multipath-tcp/mptcp_net-next/issues/220#issuecomment-947863717

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/220
Signed-off-by: Poorva Sonparote <psonparo@redhat.com>
---

Notes:
     - fixed formatting errors
     - split out the main patch into two commits
          1. Support for IP_TOS for MPTCP setsockopt()
          2. Exposing  __ip_sock_set_tos() in ip.h
     - Changed the return value of mptcp_setsockopt_v4_set_tos() as
       reported by kernel test robot.
       Earlier it used to return a variable "ret" which wasn't being
       used anywhere.
     - The patch does not have a kselftest because there's no support for IP_TOS in
       getsockopt() yet.

 net/mptcp/sockopt.c | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index 8137cc3a4296..91ccce57616b 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -598,6 +598,42 @@ static int mptcp_setsockopt_sol_tcp_congestion(struct mptcp_sock *msk, sockptr_t
 	return ret;
 }
 
+static int mptcp_setsockopt_v4_set_tos(struct mptcp_sock *msk, int optname,
+				       sockptr_t optval, unsigned int optlen)
+{
+	struct mptcp_subflow_context *subflow;
+	struct sock *sk = (struct sock *)msk;
+	int err, val;
+
+	err = ip_setsockopt(sk, SOL_IP, optname, optval, optlen);
+
+	if (err != 0)
+		return err;
+
+	lock_sock(sk);
+	sockopt_seq_inc(msk);
+	val = inet_sk(sk)->tos;
+	mptcp_for_each_subflow(msk, subflow) {
+		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
+
+		__ip_sock_set_tos(ssk, val);
+	}
+	release_sock(sk);
+
+	return err;
+}
+
+static int mptcp_setsockopt_v4(struct mptcp_sock *msk, int optname,
+			       sockptr_t optval, unsigned int optlen)
+{
+	switch (optname) {
+	case IP_TOS:
+		return mptcp_setsockopt_v4_set_tos(msk, optname, optval, optlen);
+	}
+
+	return -EOPNOTSUPP;
+}
+
 static int mptcp_setsockopt_sol_tcp(struct mptcp_sock *msk, int optname,
 				    sockptr_t optval, unsigned int optlen)
 {
@@ -637,6 +673,9 @@ int mptcp_setsockopt(struct sock *sk, int level, int optname,
 	if (ssk)
 		return tcp_setsockopt(ssk, level, optname, optval, optlen);
 
+	if (level == SOL_IP)
+		return mptcp_setsockopt_v4(msk, optname, optval, optlen);
+
 	if (level == SOL_IPV6)
 		return mptcp_setsockopt_v6(msk, optname, optval, optlen);
 
@@ -1000,6 +1039,7 @@ static void sync_socket_options(struct mptcp_sock *msk, struct sock *ssk)
 	ssk->sk_priority = sk->sk_priority;
 	ssk->sk_bound_dev_if = sk->sk_bound_dev_if;
 	ssk->sk_incoming_cpu = sk->sk_incoming_cpu;
+	__ip_sock_set_tos(ssk, inet_sk(sk)->tos);
 
 	if (sk->sk_userlocks & tx_rx_locks) {
 		ssk->sk_userlocks |= sk->sk_userlocks & tx_rx_locks;
-- 
2.18.2

