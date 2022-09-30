Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com [209.85.210.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6D9E1841
	for <mptcp@lists.linux.dev>; Fri, 30 Sep 2022 02:50:31 +0000 (UTC)
Received: by mail-pf1-f193.google.com with SMTP id i6so3087800pfb.2
        for <mptcp@lists.linux.dev>; Thu, 29 Sep 2022 19:50:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=jft4718IEEVHDu9HsPOBb4JZoFbW4W+O45C/4dPktjE=;
        b=oYWIzQvAOBZNcRcDE/3qyUJ94TMOrESfLPX+V+y/0Vc37WmlsEHRPfo+Raaa8r0dPn
         HOIBdLA9DJT+eTjEO6iHBI9Tpv2fT8NCwAHqfhIK9m+njnYI5TXViDHKG1JFh3dyPUyW
         bL6qYYae3/9tBzpBmrn+O9Ht8rHlrW+9A1lcbDmbOCDomWGnVwRdU7h66H7GrXGPT81h
         bcIyEIdGeSv7dH5DstvQHju9gMifNRAobCFPaUbxsr1+xVUHQBomFnmGqOIZ+m4Ols/e
         2VBW/gxV/E9/77LUU01e5SnuvmIxQJrcrctPXm1BMbgGQT12ngHY2SwN7wKAoP5/g1Z5
         YFDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=jft4718IEEVHDu9HsPOBb4JZoFbW4W+O45C/4dPktjE=;
        b=191Nil8SA2KGgsF/7LNUpaAjuSu5d6O1fgzzh1/pJ+RIzxdiBY7fFmpkNC04fVraOX
         bOL8aH8hij9S4oCjWtRoyUvvV/iOTnNXiAg/3KNO6Z4odWo0NKBbv/pbXXvPiO/qn1l/
         hgmrpmjJNVZptmEDeOPuik78zNxloYsrK2qXjIVhL+VpcpUnbfFn4NapCYPaVe55I4Dx
         f+us/32JtxqHvqIR47vOGRNhWs3LOFp+yMTePjpzRI2yswsLbtPfeGAi8Z+eeVQd62+w
         FznMYgAHrE4KwwTlX0j9eUSaOPtjQR1D8UYsXsUlyA5UvVx9IKeqxisqMAr4EpCcFZPi
         RAKw==
X-Gm-Message-State: ACrzQf3tbQqxryBi3bE3x96A1YC6HnHe7atj2yhi7sVKeieYQDC2exOF
	diGJ+CeG5jVFPPV8/UCbu5PG89bODEgQxQ==
X-Google-Smtp-Source: AMsMyM5i7c71vunMbcfMtYmMANtgHHHZaNsi4Wm/C1CIbaCd6kqAfmsFmQrNDVMug2bUoZwfSx9saA==
X-Received: by 2002:a65:4c85:0:b0:43b:f860:98f9 with SMTP id m5-20020a654c85000000b0043bf86098f9mr5647439pgt.368.1664506231388;
        Thu, 29 Sep 2022 19:50:31 -0700 (PDT)
Received: from localhost.localdomain ([203.205.141.17])
        by smtp.gmail.com with ESMTPSA id j12-20020a170903024c00b00176d218889esm606911plh.228.2022.09.29.19.50.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Sep 2022 19:50:30 -0700 (PDT)
From: menglong8.dong@gmail.com
X-Google-Original-From: imagedong@tencent.com
To: mathew.j.martineau@linux.intel.com
Cc: mptcp@lists.linux.dev,
	Menglong Dong <imagedong@tencent.com>
Subject: [PATCH mptcp-next v3 2/3] mptcp: add statistics for mptcp socket in use
Date: Fri, 30 Sep 2022 10:46:06 +0800
Message-Id: <20220930024607.128202-3-imagedong@tencent.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220930024607.128202-1-imagedong@tencent.com>
References: <20220930024607.128202-1-imagedong@tencent.com>
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
index d817fdb2f6ef..e6d358027b7b 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2913,6 +2913,16 @@ static void mptcp_copy_inaddrs(struct sock *msk, const struct sock *ssk)
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
@@ -2925,6 +2935,7 @@ static int mptcp_disconnect(struct sock *sk, int flags)
 	if (mptcp_sk(sk)->token)
 		mptcp_event(MPTCP_EVENT_CLOSED, mptcp_sk(sk), NULL, GFP_KERNEL);
 
+	mptcp_listen_inuse_dec(sk);
 	/* msk->subflow is still intact, the following will not free the first
 	 * subflow
 	 */
@@ -3096,6 +3107,11 @@ void mptcp_destroy_common(struct mptcp_sock *msk, unsigned int flags)
 	skb_rbtree_purge(&msk->out_of_order_queue);
 	mptcp_data_unlock(sk);
 
+	if ((__mptcp_check_fallback(msk) &&
+	     !test_and_set_bit(MPTCP_DESTROIED, &msk->flags)) ||
+	    !sk_unhashed(sk))
+		sock_prot_inuse_add(sock_net(sk), sk->sk_prot, -1);
+
 	/* move all the rx fwd alloc into the sk_mem_reclaim_final in
 	 * inet_sock_destruct() will dispose it
 	 */
@@ -3110,6 +3126,7 @@ static void mptcp_destroy(struct sock *sk)
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
 
+	mptcp_listen_inuse_dec(sk);
 	/* clears msk->subflow, allowing the following to close
 	 * even the initial subflow
 	 */
@@ -3542,6 +3559,7 @@ static int mptcp_stream_connect(struct socket *sock, struct sockaddr *uaddr,
 	mptcp_token_destroy(msk);
 	inet_sk_state_store(sock->sk, TCP_SYN_SENT);
 	subflow = mptcp_subflow_ctx(ssock->sk);
+	sock_prot_inuse_add(sock_net(sock->sk), sock->sk->sk_prot, 1);
 #ifdef CONFIG_TCP_MD5SIG
 	/* no MPTCP if MD5SIG is enabled on this socket or we may run out of
 	 * TCP option space.
@@ -3596,8 +3614,10 @@ static int mptcp_listen(struct socket *sock, int backlog)
 
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
index c0b5b4628f65..675de024de10 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -116,6 +116,7 @@
 #define MPTCP_WORK_EOF		3
 #define MPTCP_FALLBACK_DONE	4
 #define MPTCP_WORK_CLOSE_SUBFLOW 5
+#define MPTCP_DESTROIED		6
 
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

