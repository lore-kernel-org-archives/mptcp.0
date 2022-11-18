Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4691D194
	for <mptcp@lists.linux.dev>; Fri, 18 Nov 2022 18:33:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1668796395; x=1700332395;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=2xxkhtirLoiR/Yo67rwiv1iyOP8QuqPDWHmtYXr+4Eo=;
  b=A1tCLzlXMeirSHEKV7p+DxBOTwIicH0wBkkBxWAQP4g2QzMtDcTZOjNK
   UTY4bcg/vQ/7RGN+bRd7grNJlq6Pw1MhSYQx0Kc73dHLq0ivcC92zR3It
   LS0bOe+gZjVKdu6ef3J6ItFIjSYbUBd68H/U1gjQD1OcaSWN5/ZxNwGoy
   U=;
X-IronPort-AV: E=Sophos;i="5.96,175,1665446400"; 
   d="scan'208";a="264668879"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-iad-1d-m6i4x-d8e96288.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2022 18:25:23 +0000
Received: from EX13MTAUWB002.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
	by email-inbound-relay-iad-1d-m6i4x-d8e96288.us-east-1.amazon.com (Postfix) with ESMTPS id 336C58549C;
	Fri, 18 Nov 2022 18:25:18 +0000 (UTC)
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX13MTAUWB002.ant.amazon.com (10.43.161.202) with Microsoft SMTP Server (TLS)
 id 15.0.1497.42; Fri, 18 Nov 2022 18:25:18 +0000
Received: from 88665a182662.ant.amazon.com.com (10.43.160.223) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.20;
 Fri, 18 Nov 2022 18:25:15 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, Hideaki YOSHIFUJI
	<yoshfuji@linux-ipv6.org>
CC: Christoph Paasch <cpaasch@apple.com>, Florian Westphal <fw@strlen.de>,
	Peter Krystad <peter.krystad@linux.intel.com>, Kuniyuki Iwashima
	<kuniyu@amazon.com>, Kuniyuki Iwashima <kuni1840@gmail.com>,
	<netdev@vger.kernel.org>, <mptcp@lists.linux.dev>
Subject: [PATCH v2 net-next] net: Return errno in sk->sk_prot->get_port().
Date: Fri, 18 Nov 2022 10:25:06 -0800
Message-ID: <20221118182506.6226-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.43.160.223]
X-ClientProxiedBy: EX13D29UWC002.ant.amazon.com (10.43.162.254) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk

We assume the correct errno is -EADDRINUSE when sk->sk_prot->get_port()
fails, so some ->get_port() functions return just 1 on failure and the
callers return -EADDRINUSE instead.

However, mptcp_get_port() can return -EINVAL.  Let's not ignore the error.

Note the only exception is inet_autobind(), all of whose callers return
-EAGAIN instead.

Fixes: cec37a6e41aa ("mptcp: Handle MP_CAPABLE options for outgoing connections")
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
v2:
  * Rebase and target net-next

v1: https://lore.kernel.org/netdev/20221117184723.29318-1-kuniyu@amazon.com/
---
---
 net/ipv4/af_inet.c              | 4 ++--
 net/ipv4/inet_connection_sock.c | 7 ++++---
 net/ipv4/ping.c                 | 2 +-
 net/ipv4/udp.c                  | 2 +-
 net/ipv6/af_inet6.c             | 4 ++--
 5 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
index 378bcd777514..5b4d86701822 100644
--- a/net/ipv4/af_inet.c
+++ b/net/ipv4/af_inet.c
@@ -522,9 +522,9 @@ int __inet_bind(struct sock *sk, struct sockaddr *uaddr, int addr_len,
 	/* Make sure we are allowed to bind here. */
 	if (snum || !(inet->bind_address_no_port ||
 		      (flags & BIND_FORCE_ADDRESS_NO_PORT))) {
-		if (sk->sk_prot->get_port(sk, snum)) {
+		err = sk->sk_prot->get_port(sk, snum);
+		if (err) {
 			inet->inet_saddr = inet->inet_rcv_saddr = 0;
-			err = -EADDRINUSE;
 			goto out_release_sock;
 		}
 		if (!(flags & BIND_FROM_BPF)) {
diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
index 4e84ed21d16f..4a34bc7cb15e 100644
--- a/net/ipv4/inet_connection_sock.c
+++ b/net/ipv4/inet_connection_sock.c
@@ -471,11 +471,11 @@ int inet_csk_get_port(struct sock *sk, unsigned short snum)
 	bool reuse = sk->sk_reuse && sk->sk_state != TCP_LISTEN;
 	bool found_port = false, check_bind_conflict = true;
 	bool bhash_created = false, bhash2_created = false;
+	int ret = -EADDRINUSE, port = snum, l3mdev;
 	struct inet_bind_hashbucket *head, *head2;
 	struct inet_bind2_bucket *tb2 = NULL;
 	struct inet_bind_bucket *tb = NULL;
 	bool head2_lock_acquired = false;
-	int ret = 1, port = snum, l3mdev;
 	struct net *net = sock_net(sk);
 
 	l3mdev = inet_sk_bound_l3mdev(sk);
@@ -1186,7 +1186,7 @@ int inet_csk_listen_start(struct sock *sk)
 {
 	struct inet_connection_sock *icsk = inet_csk(sk);
 	struct inet_sock *inet = inet_sk(sk);
-	int err = -EADDRINUSE;
+	int err;
 
 	reqsk_queue_alloc(&icsk->icsk_accept_queue);
 
@@ -1202,7 +1202,8 @@ int inet_csk_listen_start(struct sock *sk)
 	 * after validation is complete.
 	 */
 	inet_sk_state_store(sk, TCP_LISTEN);
-	if (!sk->sk_prot->get_port(sk, inet->inet_num)) {
+	err = sk->sk_prot->get_port(sk, inet->inet_num);
+	if (!err) {
 		inet->inet_sport = htons(inet->inet_num);
 
 		sk_dst_reset(sk);
diff --git a/net/ipv4/ping.c b/net/ipv4/ping.c
index bde333b24837..bb9854c2b7a1 100644
--- a/net/ipv4/ping.c
+++ b/net/ipv4/ping.c
@@ -138,7 +138,7 @@ int ping_get_port(struct sock *sk, unsigned short ident)
 
 fail:
 	spin_unlock(&ping_table.lock);
-	return 1;
+	return -EADDRINUSE;
 }
 EXPORT_SYMBOL_GPL(ping_get_port);
 
diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 1fb7d1ed1cb1..9592fe3e444a 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -240,7 +240,7 @@ int udp_lib_get_port(struct sock *sk, unsigned short snum,
 	struct udp_table *udptable = udp_get_table_prot(sk);
 	struct udp_hslot *hslot, *hslot2;
 	struct net *net = sock_net(sk);
-	int error = 1;
+	int error = -EADDRINUSE;
 
 	if (!snum) {
 		DECLARE_BITMAP(bitmap, PORTS_PER_CHAIN);
diff --git a/net/ipv6/af_inet6.c b/net/ipv6/af_inet6.c
index 68075295d587..fee9163382c2 100644
--- a/net/ipv6/af_inet6.c
+++ b/net/ipv6/af_inet6.c
@@ -410,10 +410,10 @@ static int __inet6_bind(struct sock *sk, struct sockaddr *uaddr, int addr_len,
 	/* Make sure we are allowed to bind here. */
 	if (snum || !(inet->bind_address_no_port ||
 		      (flags & BIND_FORCE_ADDRESS_NO_PORT))) {
-		if (sk->sk_prot->get_port(sk, snum)) {
+		err = sk->sk_prot->get_port(sk, snum);
+		if (err) {
 			sk->sk_ipv6only = saved_ipv6only;
 			inet_reset_saddr(sk);
-			err = -EADDRINUSE;
 			goto out;
 		}
 		if (!(flags & BIND_FROM_BPF)) {
-- 
2.30.2

