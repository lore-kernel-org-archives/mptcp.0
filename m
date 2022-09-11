Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F93D7F
	for <mptcp@lists.linux.dev>; Sun, 11 Sep 2022 04:15:01 +0000 (UTC)
Received: by mail-pl1-f196.google.com with SMTP id 9so5471552plj.11
        for <mptcp@lists.linux.dev>; Sat, 10 Sep 2022 21:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=cQMOtc1wgGNHfMrUSNQlEZN+BDRVfb/rPFJupFn0jm8=;
        b=b4FgwiMkYUS8YQtVeHJI4+2kBR+qJgAYV9tzU5NYXRURUg7Ya5aFqmMD+XEkUn7/Qw
         xOiwbMtpDbOn+uIe4qa3dBjHkf2Z1u6bHoMEHnpTOmPbUd3eAkWDJ37gHeAgnlR1Ky2D
         hecji4nu7Fjv399h77TVDMA7g1udcTr538YIfCzhNStAPmYRqBGQ4xh7vFYAxlQl/6qn
         ouyhxFDHfM65IwHjyNq7STXzSD8kpUJQp3QAc+Rj5G0jgRE8kof2FBsWgOYULyV0DvLl
         U+4Epr2VkycbKJxPJ0/ZHYVKcrsO4ydi7q+mhU38PBE2y8SdorG57unoda+uPp4h5qN9
         1Zzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=cQMOtc1wgGNHfMrUSNQlEZN+BDRVfb/rPFJupFn0jm8=;
        b=53Z0gbzsejFrfGBL8shK0BI+lDozrI/Np2MdtoPa9ZxjWCm1+7vZJKsioKohhxcCP6
         PVqS6zdIjL2b10EZa2EpHNflFpjoCsbEJt2mxSO4LqEGRLDHlQDzGRGNId1fQTjiVRP5
         YzFT/PsEsKttyOw3gGD/a7XD9Jt9QDJLLSTFd/AKp/dgzgd6zx4dE7oTM272H81MKdtA
         hn7J3xJiM3yN2JwdqxThDN26K7CNpDYRpRnazZJBvfqqqMqSkQZAB3VH1VDGh4Mz8Rw0
         8uip8nGle+21iLNA6hvpKGSQwnYMHYJlybBxqmhPV8+904TwrLwWkGAptjXfGWGAmmdL
         Qkaw==
X-Gm-Message-State: ACgBeo2HJjiMGyALLta6BqAAiTxllF0eGrh1mbs+5XaQcdIIAWxrv+sz
	N0X1SOTMsalDUS7si1Y5Fl4JDWuqbBM=
X-Google-Smtp-Source: AA6agR6SBJy/VEsGvO3n/OOUpnOM3psAc4afwPjBX5GXQqWwobz6WcMA0BNH2voxyJ6C271qqGOh9g==
X-Received: by 2002:a17:90b:1490:b0:202:7d15:fabb with SMTP id js16-20020a17090b149000b002027d15fabbmr13611670pjb.42.1662869700707;
        Sat, 10 Sep 2022 21:15:00 -0700 (PDT)
Received: from localhost.localdomain ([203.205.141.24])
        by smtp.gmail.com with ESMTPSA id s8-20020a17090ad48800b001f2fa09786asm2783752pju.19.2022.09.10.21.14.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Sep 2022 21:15:00 -0700 (PDT)
From: menglong8.dong@gmail.com
X-Google-Original-From: imagedong@tencent.com
To: pabeni@redhat.com
Cc: mptcp@lists.linux.dev,
	Menglong Dong <imagedong@tencent.com>,
	Jiang Biao <benbjiang@tencent.com>,
	Mengen Sun <mengensun@tencent.com>
Subject: [PATCH net v5 2/2] net: mptcp: fix unreleased socket in accept queue
Date: Sun, 11 Sep 2022 12:14:18 +0800
Message-Id: <20220911041418.818201-3-imagedong@tencent.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220911041418.818201-1-imagedong@tencent.com>
References: <20220911041418.818201-1-imagedong@tencent.com>
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
mptcp_subflow_queue_clean() with __mptcp_close().

Now, we can ensure that all unaccepted mptcp sockets will be cleaned by
__mptcp_close() before they are released, so mptcp_sock_destruct(), which
is used to clean the unaccepted mptcp socket, is not needed anymore.

The selftests for mptcp is ran for this commit, and no new failures.

Fixes: f296234c98a8 ("mptcp: Add handling of incoming MP_JOIN requests")
Reviewed-by: Jiang Biao <benbjiang@tencent.com>
Reviewed-by: Mengen Sun <mengensun@tencent.com>
Signed-off-by: Menglong Dong <imagedong@tencent.com>
---
v5:
- don't make mptcp_cancel_work() inline

v4:
- factor-out __mptcp_close() and use it in this commit.

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
 net/mptcp/subflow.c  | 33 +++++++--------------------------
 3 files changed, 9 insertions(+), 27 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 06bb43455c62..45ed50e9aec9 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2656,7 +2656,7 @@ static void __mptcp_clear_xmit(struct sock *sk)
 		dfrag_clear(sk, dfrag);
 }
 
-static void mptcp_cancel_work(struct sock *sk)
+void mptcp_cancel_work(struct sock *sk)
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
 
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 8f123d450c76..8f372b8f059c 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -613,6 +613,7 @@ void mptcp_subflow_queue_clean(struct sock *ssk);
 void mptcp_sock_graft(struct sock *sk, struct socket *parent);
 struct socket *__mptcp_nmpc_socket(const struct mptcp_sock *msk);
 bool __mptcp_close(struct sock *sk, long timeout);
+void mptcp_cancel_work(struct sock *sk);
 
 bool mptcp_addresses_equal(const struct mptcp_addr_info *a,
 			   const struct mptcp_addr_info *b, bool use_port);
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index c7d49fb6e7bd..07dd23d0fe04 100644
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
@@ -1763,13 +1738,19 @@ void mptcp_subflow_queue_clean(struct sock *listener_ssk)
 
 	for (msk = head; msk; msk = next) {
 		struct sock *sk = (struct sock *)msk;
-		bool slow;
+		bool slow, do_cancel_work;
 
+		sock_hold(sk);
 		slow = lock_sock_fast_nested(sk);
 		next = msk->dl_next;
 		msk->first = NULL;
 		msk->dl_next = NULL;
+
+		do_cancel_work = __mptcp_close(sk, 0);
 		unlock_sock_fast(sk, slow);
+		if (do_cancel_work)
+			mptcp_cancel_work(sk);
+		sock_put(sk);
 	}
 
 	/* we are still under the listener msk socket lock */
-- 
2.37.2

