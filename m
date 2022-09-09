Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com [209.85.210.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94783622
	for <mptcp@lists.linux.dev>; Fri,  9 Sep 2022 05:50:00 +0000 (UTC)
Received: by mail-pf1-f194.google.com with SMTP id 65so722474pfx.0
        for <mptcp@lists.linux.dev>; Thu, 08 Sep 2022 22:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=hxOsQXqYB5p3LBql73gLnoT0HiWgd6JDTJpeO12YlMY=;
        b=akEJj8ZEHC5X6GlIK0/sFBtU6Bm2TfC0wUeYq15rP0iyBQdojislHOXGDMtqF7pAqd
         WPi5w70FyNd97gHMEAIeJssH5PwsZ76SZLmoFx+pUT9gfYlwPcNcuWyQ/F7Inpb2OuZJ
         eT54O4tr/9sxUIyFKJO3vvM6K9dShm/Y3lLVvLQ3VuMoYEVe3H+fwz3anOWqiiSoaLOB
         vdTp3ufkqjI2WvMyMui8P9BpstRTYt4brjXLL4Y2oGlBJieepyTpquCjh/SiGg3b9fSo
         ZaBRByAyYDb/wfig6/gJxJA8hh1GTW2mIgccATNb3wpGGIXpK/HcZlx9SLCrt54SJEMT
         5T3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=hxOsQXqYB5p3LBql73gLnoT0HiWgd6JDTJpeO12YlMY=;
        b=RZtocw8EbwB+xvHmPzz+iIqWuJhIRN18HuPnwx+fPyEcN7ZjbCRUbDE7oKTkGhzlzi
         DBEFseh/qTUvWMjEQjInjyCxZyM4U5v4Hg8mxv0305diExWMb46HJjoUhmZYAxwxI2Az
         ZaMQ8Oo749uFIEvcs0lqPw8i9omtXjHuP+jk4wycY3oRVCKcviRRlBpZ7hSuoH6+5jz5
         0eCbAz/40sdi8qbwMhvu5B9qupBv76Rgc7HP7AbTQFoG+I1Rg+U6XT1Yprmm/orAoy5W
         L8RSxTTKJZwNKZ9Zfxq528/bii8DCynIEDwmZSkTMj6j8ueox07b+lCl+r4lpaOod5Ly
         GlLA==
X-Gm-Message-State: ACgBeo2WGo2swgxhOmx3s7u5h7DP/eoKOd1XCBoYviT3+gTHPKEnk6Ux
	PzSPoMwEiirL4E087BFkuEY=
X-Google-Smtp-Source: AA6agR7WYOJxbiAGW7kULNHVTQgnaJbR8BfTmOBdWzn66t476h/jZpzwkOl7VISJBm7TIo1wvShGUg==
X-Received: by 2002:a05:6a00:8cc:b0:52c:7ab5:2ce7 with SMTP id s12-20020a056a0008cc00b0052c7ab52ce7mr12350017pfu.28.1662702600070;
        Thu, 08 Sep 2022 22:50:00 -0700 (PDT)
Received: from localhost.localdomain ([203.205.141.12])
        by smtp.gmail.com with ESMTPSA id d3-20020a170903230300b0016cf3f124e1sm492646plh.234.2022.09.08.22.49.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Sep 2022 22:49:59 -0700 (PDT)
From: menglong8.dong@gmail.com
X-Google-Original-From: imagedong@tencent.com
To: pabeni@redhat.com
Cc: mptcp@lists.linux.dev,
	Menglong Dong <imagedong@tencent.com>,
	Jiang Biao <benbjiang@tencent.com>,
	Mengen Sun <mengensun@tencent.com>
Subject: [PATCH net v4 3/3] net: mptcp: fix unreleased socket in accept queue
Date: Fri,  9 Sep 2022 13:49:32 +0800
Message-Id: <20220909054932.246221-4-imagedong@tencent.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220909054932.246221-1-imagedong@tencent.com>
References: <20220909054932.246221-1-imagedong@tencent.com>
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
 net/mptcp/subflow.c | 37 +++++++++++--------------------------
 1 file changed, 11 insertions(+), 26 deletions(-)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index c7d49fb6e7bd..7c437debc368 100644
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
@@ -1763,13 +1738,23 @@ void mptcp_subflow_queue_clean(struct sock *listener_ssk)
 
 	for (msk = head; msk; msk = next) {
 		struct sock *sk = (struct sock *)msk;
-		bool slow;
+		bool slow, cancel_work;
 
+		sock_hold(sk);
 		slow = lock_sock_fast_nested(sk);
 		next = msk->dl_next;
 		msk->first = NULL;
 		msk->dl_next = NULL;
+
+		/* __mptcp_close() will put a extra reference on sk,
+		 * so we hold one here.
+		 */
+		sock_hold(sk);
+		cancel_work = __mptcp_close(sk, 0);
 		unlock_sock_fast(sk, slow);
+		if (cancel_work)
+			mptcp_cancel_work(sk);
+		sock_put(sk);
 	}
 
 	/* we are still under the listener msk socket lock */
-- 
2.37.2

