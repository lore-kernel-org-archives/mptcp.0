Received: from mail-pj1-f68.google.com (mail-pj1-f68.google.com [209.85.216.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DEA0539F
	for <mptcp@lists.linux.dev>; Wed,  7 Sep 2022 11:12:03 +0000 (UTC)
Received: by mail-pj1-f68.google.com with SMTP id m3so3583888pjo.1
        for <mptcp@lists.linux.dev>; Wed, 07 Sep 2022 04:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=9JyQhGC5twBqhnVSFX5NB4Ii/dlVPnV+Lg33o+If3Tw=;
        b=UBhSDsLvEo7utzJeHRlIrXtRWLWXUnfWNvyjSe3ZttdKDIc8MBErGKy2Q92ZzvRtWT
         bb1h5pdjAiqkzlYbKCab80ujf7Ltyk3oycevvb6Mp0x9zndVf5wMQwTXuoxuFpQie6Lv
         0Lb+bSxqL+QKvf++pKwSbMeM/rbpi5Yr21OpnugqoZTg2MXrWedhcpq6XGZJkL2TrFFD
         Hhy0+LnJsKjHkXQk+Zs3d3y6/eRtc9j4vDE45HK+MTZsdwHolIzMEC9IH2B+F66AW5jN
         x8rS6PgE3rN+IvFAToBDHvODpglap3OlTpZFBnqsZByO+zPhkP+tsiWV5h/AEdfBbfR1
         3Uyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=9JyQhGC5twBqhnVSFX5NB4Ii/dlVPnV+Lg33o+If3Tw=;
        b=bCGUAZr77hDE/WjwvlrgEjNqO00eq+ReBhCdgy+L3R2WXBiSFqC0L5F6e6FM/sSvhA
         dzJhQdo+SJmwYR8mUckqNMoK5y0kXYbtBs82+4Brlb+pHtvromYhZE9mgOAqqVX73sVu
         Tf/ATLlTJcdybPnGjLA9IeqeXfC0P5/v2hs0bUG4OwTL0u+RHLFUl6xB0xYL/5RLbHU/
         QzAr2iDhwOiZZXqKXMOuCvVjPV/bZYMSNiv1mPzo7tlsny3e/fmXuRCBjn5GQHtYc03O
         2xg156fsr5x9tLTFEfmvlfDwEi0zTf4YiOIbT3ru84eqctSZ080QDzHuBXlIh1mQGcD5
         jddA==
X-Gm-Message-State: ACgBeo0E93lZEiB2GFU1JWJAyR4Ii3NpN4iCWD6fJud9XcvSor3yMEMH
	IX2dO3Bc7bGOxWpe5Waf1Lc=
X-Google-Smtp-Source: AA6agR5rxp/8oBEHwaj8lcja+zOf+HJVJGRuIE/uxzGzja1ttN3dJ8S3cmoVGATrGirA1B4TM2Ll4g==
X-Received: by 2002:a17:90b:2708:b0:200:40aa:5cf5 with SMTP id px8-20020a17090b270800b0020040aa5cf5mr19613370pjb.134.1662549122678;
        Wed, 07 Sep 2022 04:12:02 -0700 (PDT)
Received: from localhost.localdomain ([203.205.141.84])
        by smtp.gmail.com with ESMTPSA id p186-20020a625bc3000000b00535d3caa66fsm12225683pfb.197.2022.09.07.04.11.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 04:12:02 -0700 (PDT)
From: menglong8.dong@gmail.com
X-Google-Original-From: imagedong@tencent.com
To: pabeni@redhat.com
Cc: mathew.j.martineau@linux.intel.com,
	matthieu.baerts@tessares.net,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	fw@strlen.de,
	peter.krystad@linux.intel.com,
	netdev@vger.kernel.org,
	mptcp@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Menglong Dong <imagedong@tencent.com>,
	Jiang Biao <benbjiang@tencent.com>,
	Mengen Sun <mengensun@tencent.com>
Subject: [PATCH net v3] net: mptcp: fix unreleased socket in accept queue
Date: Wed,  7 Sep 2022 19:11:32 +0800
Message-Id: <20220907111132.31722-1-imagedong@tencent.com>
X-Mailer: git-send-email 2.37.2
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Menglong Dong <imagedong@tencent.com>

The mptcp socket and its subflow sockets in accept queue can't be
released after the process exit.

While the release of a mptcp socket in listening state, the
corresponding tcp socket will be released too. Meanwhile, the tcp
socket in the unaccept queue will be released too. However, only init
subflow is in the unaccept queue, and the joined subflow is not in the
unaccept queue, which makes the joined subflow won't be released, and
therefore the corresponding unaccepted mptcp socket will not be released
to.

This can be reproduced easily with following steps:

1. create 2 namespace and veth:
   $ ip netns add mptcp-client
   $ ip netns add mptcp-server
   $ sysctl -w net.ipv4.conf.all.rp_filter=0
   $ ip netns exec mptcp-client sysctl -w net.mptcp.enabled=1
   $ ip netns exec mptcp-server sysctl -w net.mptcp.enabled=1
   $ ip link add red-client netns mptcp-client type veth peer red-server \
     netns mptcp-server
   $ ip -n mptcp-server address add 10.0.0.1/24 dev red-server
   $ ip -n mptcp-server address add 192.168.0.1/24 dev red-server
   $ ip -n mptcp-client address add 10.0.0.2/24 dev red-client
   $ ip -n mptcp-client address add 192.168.0.2/24 dev red-client
   $ ip -n mptcp-server link set red-server up
   $ ip -n mptcp-client link set red-client up

2. configure the endpoint and limit for client and server:
   $ ip -n mptcp-server mptcp endpoint flush
   $ ip -n mptcp-server mptcp limits set subflow 2 add_addr_accepted 2
   $ ip -n mptcp-client mptcp endpoint flush
   $ ip -n mptcp-client mptcp limits set subflow 2 add_addr_accepted 2
   $ ip -n mptcp-client mptcp endpoint add 192.168.0.2 dev red-client id \
     1 subflow

3. listen and accept on a port, such as 9999. The nc command we used
   here is modified, which makes it use mptcp protocol by default.
   $ ip netns exec mptcp-server nc -l -k -p 9999

4. open another *two* terminal and use each of them to connect to the
   server with the following command:
   $ ip netns exec mptcp-client nc 10.0.0.1 9999
   Input something after connect to triger the connection of the second
   subflow. So that there are two established mptcp connections, with the
   second one still unaccepted.

5. exit all the nc command, and check the tcp socket in server namespace.
   And you will find that there is one tcp socket in CLOSE_WAIT state
   and can't release forever.

Fix this by closing all of the unaccepted mptcp socket in
mptcp_subflow_queue_clean() with mptcp_close(). As the mptcp_cancel_work()
is called inside mptcp_close(), we can't introduce a mptcp_close_nolock()
and call it here, which will cause deadlock.

Now, we can ensure that all unaccepted mptcp sockets will be cleaned by
mptcp_close() before they are released, so mptcp_sock_destruct(), which is
used to clean the unaccepted mptcp socket, is not needed anymore.

The selftests for mptcp is ran for this commit, and no new failures.
However, there are some failures before this commit for mptcp_join.sh:

 5 failure(s) has(ve) been detected:
        - 27: invalid address, ADD_ADDR timeout
        - 34: remove invalid addresses
        - 102: userspace pm no echo w/o daemon
        - 103: userspace pm type rejects join
        - 105: userspace pm type prevents mp_prio

Fixes: f296234c98a8 ("mptcp: Add handling of incoming MP_JOIN requests")
Reviewed-by: Jiang Biao <benbjiang@tencent.com>
Reviewed-by: Mengen Sun <mengensun@tencent.com>
Signed-off-by: Menglong Dong <imagedong@tencent.com>
---
v3:
- remove mptcp_close_nolock() and call mptcp_close() directly in
  mptcp_subflow_queue_clean(), as mptcp_close_nolock() will cause
  dead lock.

v2:
- remove mptcp_sock_destruct()
- introduce mptcp_close_nolock() and replace mptcp_close() with it in
  mptcp_subflow_queue_clean()
---
 net/mptcp/protocol.c |  2 +-
 net/mptcp/protocol.h |  1 +
 net/mptcp/subflow.c  | 31 ++++++-------------------------
 3 files changed, 8 insertions(+), 26 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index d398f3810662..2de33626b73f 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2796,7 +2796,7 @@ static void __mptcp_destroy_sock(struct sock *sk)
 	sock_put(sk);
 }
 
-static void mptcp_close(struct sock *sk, long timeout)
+void mptcp_close(struct sock *sk, long timeout)
 {
 	struct mptcp_subflow_context *subflow;
 	struct mptcp_sock *msk = mptcp_sk(sk);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 132d50833df1..102692b581dd 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -612,6 +612,7 @@ void mptcp_subflow_reset(struct sock *ssk);
 void mptcp_subflow_queue_clean(struct sock *ssk);
 void mptcp_sock_graft(struct sock *sk, struct socket *parent);
 struct socket *__mptcp_nmpc_socket(const struct mptcp_sock *msk);
+void mptcp_close(struct sock *sk, long timeout);
 
 bool mptcp_addresses_equal(const struct mptcp_addr_info *a,
 			   const struct mptcp_addr_info *b, bool use_port);
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index c7d49fb6e7bd..45315a57185a 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -602,30 +602,6 @@ static bool subflow_hmac_valid(const struct request_sock *req,
 	return !crypto_memneq(hmac, mp_opt->hmac, MPTCPOPT_HMAC_LEN);
 }
 
-static void mptcp_sock_destruct(struct sock *sk)
-{
-	/* if new mptcp socket isn't accepted, it is free'd
-	 * from the tcp listener sockets request queue, linked
-	 * from req->sk.  The tcp socket is released.
-	 * This calls the ULP release function which will
-	 * also remove the mptcp socket, via
-	 * sock_put(ctx->conn).
-	 *
-	 * Problem is that the mptcp socket will be in
-	 * ESTABLISHED state and will not have the SOCK_DEAD flag.
-	 * Both result in warnings from inet_sock_destruct.
-	 */
-	if ((1 << sk->sk_state) & (TCPF_ESTABLISHED | TCPF_CLOSE_WAIT)) {
-		sk->sk_state = TCP_CLOSE;
-		WARN_ON_ONCE(sk->sk_socket);
-		sock_orphan(sk);
-	}
-
-	/* We don't need to clear msk->subflow, as it's still NULL at this point */
-	mptcp_destroy_common(mptcp_sk(sk), 0);
-	inet_sock_destruct(sk);
-}
-
 static void mptcp_force_close(struct sock *sk)
 {
 	/* the msk is not yet exposed to user-space */
@@ -768,7 +744,6 @@ static struct sock *subflow_syn_recv_sock(const struct sock *sk,
 			/* new mpc subflow takes ownership of the newly
 			 * created mptcp socket
 			 */
-			new_msk->sk_destruct = mptcp_sock_destruct;
 			mptcp_sk(new_msk)->setsockopt_seq = ctx->setsockopt_seq;
 			mptcp_pm_new_connection(mptcp_sk(new_msk), child, 1);
 			mptcp_token_accept(subflow_req, mptcp_sk(new_msk));
@@ -1770,6 +1745,12 @@ void mptcp_subflow_queue_clean(struct sock *listener_ssk)
 		msk->first = NULL;
 		msk->dl_next = NULL;
 		unlock_sock_fast(sk, slow);
+
+		/* mptcp_close() will put a extra reference on sk,
+		 * so we hold one here.
+		 */
+		sock_hold(sk);
+		mptcp_close(sk, 0);
 	}
 
 	/* we are still under the listener msk socket lock */
-- 
2.37.2

