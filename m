Received: from mail-pg1-f195.google.com (mail-pg1-f195.google.com [209.85.215.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E827BA4E
	for <mptcp@lists.linux.dev>; Fri,  7 Oct 2022 09:31:39 +0000 (UTC)
Received: by mail-pg1-f195.google.com with SMTP id e129so4146436pgc.9
        for <mptcp@lists.linux.dev>; Fri, 07 Oct 2022 02:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oOQDNU+tpQiTofOoC1wShftRml644KUfUVNzyJL61kQ=;
        b=jbZ16Z/gT109JJzqzR3AIsqRMTypqrayYq0gB4/xbOhMnmKC+JFp2V/a8VW0DZ2Nth
         cMxtmH9xlS0qTmh6//PlOXh6/Gh7rSvWwEol5mTG07rFtx6jPHbYpHV7qm04A0FwMCU0
         5q0Mp1wwvdYcrEfmJC6KhW5VmoUfVs9r+1GrKsIB0mUhogIWru5mZETG/EUJaEvI4Tjr
         CQFWhKHKPf+95hglgAsPfvxE06xSybQyb/NRtmmQ9hVquZOHfYgLuQq3O13+oa0NnZtb
         pX5EUHC3nTYRY65Y/cBQGPvB7GIKgYmD9YdJ+oTGhvK/zfULaCuQUtoSmvxr6AEKdxHW
         3How==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oOQDNU+tpQiTofOoC1wShftRml644KUfUVNzyJL61kQ=;
        b=fsKdb/jhHfUj6xAPj1tuajlK7v33vG30Jaq1q2+W8/C9PHC65NGH8lXhqpuw2xFiC6
         ymBfHbAm9ArYyxFRxYAIUZfTuUL1r2+Gn3noHMFk8IOcFVLqtQVxr/yE933zMui9sAll
         XaofA0H5hDe3qoiq98iPO4iQ2+p+d5qdwTnbX1U0AvQSafSvLKyCsysrBygZnhpwth0s
         b5d4rxyRQtbn4FBG0XqFenJg2uRu7rPtKsUX9GiaaidG0lnru6w3K+U8YVKjp5GLd4pR
         CzTHLEII9TCwez8/vi/bJe4SqEfctK2sRXlerXIpXRLpilorll8X+ZIuQfL+pa+lGntd
         1xJg==
X-Gm-Message-State: ACrzQf1S5RXFZr+0pwYUyxCzjjbhCRkT+6ReoCyNnAvSO7sLFt9yJt0o
	TLdxHOcYzJU6ApdWG9IZW80=
X-Google-Smtp-Source: AMsMyM4wOeud4iOn5jJdX9aooxrmpnUCexM2XClsKfp8FAD278UURkB2sEgxk1+d2CYmK4/hmrpq+Q==
X-Received: by 2002:a63:5a05:0:b0:434:23a5:a5ca with SMTP id o5-20020a635a05000000b0043423a5a5camr3751073pgb.515.1665135099447;
        Fri, 07 Oct 2022 02:31:39 -0700 (PDT)
Received: from localhost.localdomain ([203.205.141.87])
        by smtp.gmail.com with ESMTPSA id 61-20020a17090a0fc300b001fd7e56da4csm4187421pjz.39.2022.10.07.02.31.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Oct 2022 02:31:38 -0700 (PDT)
From: menglong8.dong@gmail.com
X-Google-Original-From: imagedong@tencent.com
To: mathew.j.martineau@linux.intel.com
Cc: mptcp@lists.linux.dev,
	Menglong Dong <imagedong@tencent.com>
Subject: [PATCH mptcp-next v5 2/3] mptcp: add statistics for mptcp socket in use
Date: Fri,  7 Oct 2022 17:29:21 +0800
Message-Id: <20221007092922.13169-3-imagedong@tencent.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221007092922.13169-1-imagedong@tencent.com>
References: <20221007092922.13169-1-imagedong@tencent.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Menglong Dong <imagedong@tencent.com>

Do the statistics of mptcp socket in use with sock_prot_inuse_add().
Therefore, we can get the count of used mptcp socket from
/proc/net/protocols:

& cat /proc/net/protocols
protocol  size sockets  memory press maxhdr  slab module     cl co di ac io in de sh ss gs se re sp bi br ha uh gp em
MPTCPv6   2048      0       0   no       0   yes  kernel      y  n  y  y  y  y  y  y  y  y  y  y  n  n  n  y  y  y  n
MPTCP     1896      1       0   no       0   yes  kernel      y  n  y  y  y  y  y  y  y  y  y  y  n  n  n  y  y  y  n

Signed-off-by: Menglong Dong <imagedong@tencent.com>
---
v5:
- rebase to solve merge conflict

v4:
- rename MPTCP_DESTROIED to MPTCP_DESTROYED

v2:
- decrease the statistics for listening mptcp socket inuse with
  mptcp_listen_inuse_dec()
- add MPTCP_DESTROIED flags to store if mptcp_destroy_common() was
  called on the msk. For fallback case, we need to decrease the
  statistics only once, and mptcp_destroy_common() can be called
  more than once.
---
 net/mptcp/protocol.c | 22 +++++++++++++++++++++-
 net/mptcp/protocol.h |  1 +
 net/mptcp/subflow.c  |  3 +++
 3 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 04d92dc0941f..3d1570a9d3e9 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2974,6 +2974,16 @@ static void mptcp_copy_inaddrs(struct sock *msk, const struct sock *ssk)
 	inet_sk(msk)->inet_rcv_saddr = inet_sk(ssk)->inet_rcv_saddr;
 }
 
+static void mptcp_listen_inuse_dec(struct sock *sk)
+{
+	struct mptcp_sock *msk = mptcp_sk(sk);
+	struct socket *ssock;
+
+	ssock = __mptcp_nmpc_socket(msk);
+	if (ssock && inet_sk_state_load(ssock->sk) == TCP_LISTEN)
+		sock_prot_inuse_add(sock_net(sk), sk->sk_prot, -1);
+}
+
 static int mptcp_disconnect(struct sock *sk, int flags)
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
@@ -2986,6 +2996,7 @@ static int mptcp_disconnect(struct sock *sk, int flags)
 	if (mptcp_sk(sk)->token)
 		mptcp_event(MPTCP_EVENT_CLOSED, mptcp_sk(sk), NULL, GFP_KERNEL);
 
+	mptcp_listen_inuse_dec(sk);
 	/* msk->subflow is still intact, the following will not free the first
 	 * subflow
 	 */
@@ -3160,6 +3171,11 @@ void mptcp_destroy_common(struct mptcp_sock *msk, unsigned int flags)
 	skb_rbtree_purge(&msk->out_of_order_queue);
 	mptcp_data_unlock(sk);
 
+	if ((__mptcp_check_fallback(msk) &&
+	     !test_and_set_bit(MPTCP_DESTROYED, &msk->flags)) ||
+	    !sk_unhashed(sk))
+		sock_prot_inuse_add(sock_net(sk), sk->sk_prot, -1);
+
 	/* move all the rx fwd alloc into the sk_mem_reclaim_final in
 	 * inet_sock_destruct() will dispose it
 	 */
@@ -3174,6 +3190,7 @@ static void mptcp_destroy(struct sock *sk)
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
 
+	mptcp_listen_inuse_dec(sk);
 	/* clears msk->subflow, allowing the following to close
 	 * even the initial subflow
 	 */
@@ -3529,6 +3546,7 @@ static int mptcp_connect(struct sock *sk, struct sockaddr *uaddr, int addr_len)
 
 	mptcp_token_destroy(msk);
 	inet_sk_state_store(sk, TCP_SYN_SENT);
+	sock_prot_inuse_add(sock_net(sk), sk->sk_prot, 1);
 	subflow = mptcp_subflow_ctx(ssock->sk);
 #ifdef CONFIG_TCP_MD5SIG
 	/* no MPTCP if MD5SIG is enabled on this socket or we may run out of
@@ -3661,8 +3679,10 @@ static int mptcp_listen(struct socket *sock, int backlog)
 
 	err = ssock->ops->listen(ssock, backlog);
 	inet_sk_state_store(sk, inet_sk_state_load(ssock->sk));
-	if (!err)
+	if (!err) {
+		sock_prot_inuse_add(sock_net(sk), sk->sk_prot, 1);
 		mptcp_copy_inaddrs(sk, ssock->sk);
+	}
 
 unlock:
 	release_sock(sk);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 18f866b1afda..374ef75e4bb9 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -116,6 +116,7 @@
 #define MPTCP_WORK_EOF		3
 #define MPTCP_FALLBACK_DONE	4
 #define MPTCP_WORK_CLOSE_SUBFLOW 5
+#define MPTCP_DESTROYED		6
 
 /* MPTCP socket release cb flags */
 #define MPTCP_PUSH_PENDING	1
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 07dd23d0fe04..da6cfa73a3bd 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -747,6 +747,9 @@ static struct sock *subflow_syn_recv_sock(const struct sock *sk,
 			mptcp_sk(new_msk)->setsockopt_seq = ctx->setsockopt_seq;
 			mptcp_pm_new_connection(mptcp_sk(new_msk), child, 1);
 			mptcp_token_accept(subflow_req, mptcp_sk(new_msk));
+			sock_prot_inuse_add(sock_net(new_msk),
+					    new_msk->sk_prot,
+					    1);
 			ctx->conn = new_msk;
 			new_msk = NULL;
 
-- 
2.37.2

