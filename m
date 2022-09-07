Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C457E
	for <mptcp@lists.linux.dev>; Wed,  7 Sep 2022 08:34:32 +0000 (UTC)
Received: by mail-pl1-f195.google.com with SMTP id 9so10570972plj.11
        for <mptcp@lists.linux.dev>; Wed, 07 Sep 2022 01:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=excKST2WeSyoEQqZJo7Cstb+BJAfbu3Kg3gLESDMOLg=;
        b=D3o7FmiHi3XQ99QPVvTZfRxafcxi4ptp2gfK0WR3m7VGvlrGSw+2+NCMyNGzS7fD3f
         TwpPAvImSmTocJrC3rBq9GKAN9PxLtFLL8kWx17dCZR/FO1cQPJs/dJF29tvaJJ+GAvm
         e7dJIysq3d3vfn7Y+wDlR9uHhhuy2O4QrH4Dj1l3oVsJklL/PB3eWi21Q4ESJ1SK985x
         bsyLsptfIQzwnCLUq5AfYMHDcf4qxncA0vNDVXktZkhbqTCGRrAfZwscBOTraczSNQjn
         hx6Ig30QfSWe6cftaPZCAXSMutTz1ZwfoBZPJ5aJ6NBM6YSwyhi9YF7z8CB0gT70hI9+
         JUNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=excKST2WeSyoEQqZJo7Cstb+BJAfbu3Kg3gLESDMOLg=;
        b=QHYBWo2AteuA1N3RzBBRo3q+U7QdXhmJGXCLHsZ7rUoUpPKvsGH4NHVv16VlJM0C2z
         GnqB+uv5VxlfIeMslcDyRPN4kYnLq4wth0C/uJjlpU+DFPp266Cu9W3SKdk+zT5ey0dC
         lUXwj2jANeBcDZ2Fo9LBKqvQQUXznDkscbHihR0TFwkAHTh+pzorynwRErb+sls9S5ii
         VE9SFH5kclxCrIaM6wCfQwatSmwMY0IwMF+U7H7JoiU7zfcj2R615NbuaRucuv+ca+gj
         vxaEgrZQjddmB39zACCEHrq96QFgc9cXMGzoVZRw118OUj/RLw+oPfNvfVTIXSN6dGDR
         ag0Q==
X-Gm-Message-State: ACgBeo3+LgoZorOm4HfyLzkYdiGHfmBHbsXP05z8Xy/+XRUPQKTrhFv/
	fqgybOQFlikKGLBkcOJZCXU=
X-Google-Smtp-Source: AA6agR4JSlJLPmlzogVp7zk0mOXoFYa8kYD13qT5+g/CVbf5hfyWtz4H6HEX1m327SU022EGPIZR6g==
X-Received: by 2002:a17:902:d885:b0:172:868f:188c with SMTP id b5-20020a170902d88500b00172868f188cmr2626362plz.78.1662539671405;
        Wed, 07 Sep 2022 01:34:31 -0700 (PDT)
Received: from localhost.localdomain ([203.205.141.84])
        by smtp.gmail.com with ESMTPSA id mn22-20020a17090b189600b001fd7cde9990sm14565341pjb.0.2022.09.07.01.34.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 01:34:31 -0700 (PDT)
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
Subject: [PATCH net v2] net: mptcp: fix unreleased socket in accept queue
Date: Wed,  7 Sep 2022 16:33:04 +0800
Message-Id: <20220907083304.605526-1-imagedong@tencent.com>
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
mptcp_subflow_queue_clean() with mptcp_close_nolock().

Now, we can ensure that all unaccepted mptcp sockets will be cleaned by
mptcp_close() before they are released, so mptcp_sock_destruct(), which is
used to clean the unaccepted mptcp socket, is not needed anymore.

Fixes: f296234c98a8 ("mptcp: Add handling of incoming MP_JOIN requests")
Reviewed-by: Jiang Biao <benbjiang@tencent.com>
Reviewed-by: Mengen Sun <mengensun@tencent.com>
Signed-off-by: Menglong Dong <imagedong@tencent.com>
---
 net/mptcp/protocol.c | 13 +++++++++----
 net/mptcp/subflow.c  | 33 ++++++++-------------------------
 2 files changed, 17 insertions(+), 29 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index d398f3810662..fe6b7fbb145c 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2796,13 +2796,12 @@ static void __mptcp_destroy_sock(struct sock *sk)
 	sock_put(sk);
 }
 
-static void mptcp_close(struct sock *sk, long timeout)
+void mptcp_close_nolock(struct sock *sk, long timeout)
 {
 	struct mptcp_subflow_context *subflow;
 	struct mptcp_sock *msk = mptcp_sk(sk);
 	bool do_cancel_work = false;
 
-	lock_sock(sk);
 	sk->sk_shutdown = SHUTDOWN_MASK;
 
 	if ((1 << sk->sk_state) & (TCPF_LISTEN | TCPF_CLOSE)) {
@@ -2833,7 +2832,6 @@ static void mptcp_close(struct sock *sk, long timeout)
 	}
 	sock_orphan(sk);
 
-	sock_hold(sk);
 	pr_debug("msk=%p state=%d", sk, sk->sk_state);
 	if (mptcp_sk(sk)->token)
 		mptcp_event(MPTCP_EVENT_CLOSED, msk, NULL, GFP_KERNEL);
@@ -2844,10 +2842,17 @@ static void mptcp_close(struct sock *sk, long timeout)
 	} else {
 		mptcp_reset_timeout(msk, 0);
 	}
-	release_sock(sk);
+
 	if (do_cancel_work)
 		mptcp_cancel_work(sk);
+}
 
+static void mptcp_close(struct sock *sk, long timeout)
+{
+	sock_hold(sk);
+	lock_sock(sk);
+	mptcp_close_nolock(sk, timeout);
+	release_sock(sk);
 	sock_put(sk);
 }
 
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index c7d49fb6e7bd..cebabf2bb222 100644
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
@@ -1765,11 +1740,19 @@ void mptcp_subflow_queue_clean(struct sock *listener_ssk)
 		struct sock *sk = (struct sock *)msk;
 		bool slow;
 
+		sock_hold(sk);
 		slow = lock_sock_fast_nested(sk);
 		next = msk->dl_next;
 		msk->first = NULL;
 		msk->dl_next = NULL;
+
+		/* mptcp_close_nolock() will put a extra reference on sk,
+		 * so we hold one here.
+		 */
+		sock_hold(sk);
+		mptcp_close_nolock(sk, 0);
 		unlock_sock_fast(sk, slow);
+		sock_put(sk);
 	}
 
 	/* we are still under the listener msk socket lock */
-- 
2.37.2

