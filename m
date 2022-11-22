Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 569D4EA8
	for <mptcp@lists.linux.dev>; Tue, 22 Nov 2022 03:51:25 +0000 (UTC)
Received: by mail-pl1-f193.google.com with SMTP id y4so12447983plb.2
        for <mptcp@lists.linux.dev>; Mon, 21 Nov 2022 19:51:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ItPs0xNbAoC8iNFB4T5B/tl90pqN6u7kcnVF047XcB8=;
        b=caPpNw1Ver6sRCf4Nl20IZgnpRV7+gN0DIfb8LwdcsR9OHmdPLomaQ6uph5FuoG6rB
         jRkSu8gtntan50rBUAPyQ33/5JuZA/Q8Llf3r1MAUjyTf6MoAGmpSN1StujswoK0s/1s
         l9pVvUgFsg9hWQEdqF6ppk+jJ7D4NNLynpHMrqh2zafp9QDmuK7w7G3anIRNGbQAr//y
         OFgGPHhTU7ur//E4rVVRIYYB1BcStz6wd9mu13YETyDu6hP5l3tv0mL5SE/3DkVwAdWZ
         CYCnyaHKcNl0GO+dybz6AaVEHcGHRUQqmO4+WoKNw3pl7zPPloxaYLVzLCcw4xRfDWhC
         X0Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ItPs0xNbAoC8iNFB4T5B/tl90pqN6u7kcnVF047XcB8=;
        b=o98ypetJYBCimxn1clWmLwC733U1Gi0GLzYMuIJKJDiXuZj9yyahFWs1lqtL7G2jJT
         efKHlfIPW25JFO8loaU/MYASlC/5lTU7ptCoopUIJHQcchNgbtTcgc+VpK6R6N1qJImM
         DrZwDcILFbeSoYCJxfGi36tFOrHnByPH4jw49x8CupdROG4L9papYpZQ58epL9wwNzoI
         gfcZQJTwPyCaIh+mz+zmQ4duWH0V3do3imiWoat1TFvvLiOJ462p726dygJdzm/T0g/L
         Szl3A/eunVhH6u7WtgtC8H7AUjGu2VajHgZBhHoxWUg4EbtghdTIDxQwzjqaLsFGUdoI
         BzSA==
X-Gm-Message-State: ANoB5pl0RQooDeEGF7rsko0JvHfon0cSaudVQHC1rVgd2NKVABwSXoRy
	FoLdyUZ0nb4WM9mLicU3524=
X-Google-Smtp-Source: AA0mqf6hEdF/iJ/pMna/ahNPbVHxZMGAQDWSwJIu9Ydhhtz6IP3uZ6p7dVui7Fb4SyGe0i3jyBMuOQ==
X-Received: by 2002:a17:902:f391:b0:178:71f9:b8fc with SMTP id f17-20020a170902f39100b0017871f9b8fcmr2237459ple.44.1669089084775;
        Mon, 21 Nov 2022 19:51:24 -0800 (PST)
Received: from localhost.localdomain ([162.14.78.182])
        by smtp.gmail.com with ESMTPSA id x11-20020a170902ec8b00b001869d71228bsm10707220plg.170.2022.11.21.19.51.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Nov 2022 19:51:24 -0800 (PST)
From: menglong8.dong@gmail.com
X-Google-Original-From: imagedong@tencent.com
To: mathew.j.martineau@linux.intel.com,
	matthieu.baerts@tessares.net
Cc: mptcp@lists.linux.dev,
	Menglong Dong <imagedong@tencent.com>
Subject: [PATCH mptcp-next v7 2/4] mptcp: add statistics for mptcp socket in use
Date: Tue, 22 Nov 2022 11:49:21 +0800
Message-Id: <20221122034923.804955-3-imagedong@tencent.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221122034923.804955-1-imagedong@tencent.com>
References: <20221122034923.804955-1-imagedong@tencent.com>
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
v6:
- introduce the 'MPTCP_INUSE' flag and check if msk is in use by it

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
 net/mptcp/protocol.c |  8 +++++++-
 net/mptcp/protocol.h | 13 +++++++++++++
 net/mptcp/subflow.c  |  1 +
 3 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index f9bcc724d9e2..9c1152e16005 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3073,6 +3073,7 @@ struct sock *mptcp_sk_clone(const struct sock *sk,
 	msk->snd_una = msk->write_seq;
 	msk->wnd_end = msk->snd_nxt + req->rsk_rcv_wnd;
 	msk->setsockopt_seq = mptcp_sk(sk)->setsockopt_seq;
+	clear_bit(MPTCP_INUSE, &msk->flags);
 
 	if (mp_opt->suboptions & OPTIONS_MPTCP_MPC) {
 		msk->can_ack = true;
@@ -3179,6 +3180,8 @@ void mptcp_destroy_common(struct mptcp_sock *msk, unsigned int flags)
 	skb_rbtree_purge(&msk->out_of_order_queue);
 	mptcp_data_unlock(sk);
 
+	mptcp_inuse_dec(sk);
+
 	/* move all the rx fwd alloc into the sk_mem_reclaim_final in
 	 * inet_sock_destruct() will dispose it
 	 */
@@ -3542,6 +3545,7 @@ static int mptcp_connect(struct sock *sk, struct sockaddr *uaddr, int addr_len)
 
 	mptcp_token_destroy(msk);
 	inet_sk_state_store(sk, TCP_SYN_SENT);
+	mptcp_inuse_inc(sk);
 	subflow = mptcp_subflow_ctx(ssock->sk);
 #ifdef CONFIG_TCP_MD5SIG
 	/* no MPTCP if MD5SIG is enabled on this socket or we may run out of
@@ -3674,8 +3678,10 @@ static int mptcp_listen(struct socket *sock, int backlog)
 
 	err = ssock->ops->listen(ssock, backlog);
 	inet_sk_state_store(sk, inet_sk_state_load(ssock->sk));
-	if (!err)
+	if (!err) {
+		mptcp_inuse_inc(sk);
 		mptcp_copy_inaddrs(sk, ssock->sk);
+	}
 
 unlock:
 	release_sock(sk);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 6a09ab99a12d..441bbd77ae8e 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -116,6 +116,7 @@
 #define MPTCP_WORK_EOF		3
 #define MPTCP_FALLBACK_DONE	4
 #define MPTCP_WORK_CLOSE_SUBFLOW 5
+#define MPTCP_INUSE		6
 
 /* MPTCP socket release cb flags */
 #define MPTCP_PUSH_PENDING	1
@@ -382,6 +383,18 @@ static inline struct mptcp_data_frag *mptcp_rtx_head(const struct sock *sk)
 	return list_first_entry_or_null(&msk->rtx_queue, struct mptcp_data_frag, list);
 }
 
+static inline void mptcp_inuse_inc(const struct sock *sk)
+{
+	if (!test_and_set_bit(MPTCP_INUSE, &mptcp_sk(sk)->flags))
+		sock_prot_inuse_add(sock_net(sk), sk->sk_prot, 1);
+}
+
+static inline void mptcp_inuse_dec(const struct sock *sk)
+{
+	if (test_and_clear_bit(MPTCP_INUSE, &mptcp_sk(sk)->flags))
+		sock_prot_inuse_add(sock_net(sk), sk->sk_prot, -1);
+}
+
 struct csum_pseudo_header {
 	__be64 data_seq;
 	__be32 subflow_seq;
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 437a283ba6ea..2e3bf29b4006 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -749,6 +749,7 @@ static struct sock *subflow_syn_recv_sock(const struct sock *sk,
 			mptcp_sk(new_msk)->setsockopt_seq = ctx->setsockopt_seq;
 			mptcp_pm_new_connection(mptcp_sk(new_msk), child, 1);
 			mptcp_token_accept(subflow_req, mptcp_sk(new_msk));
+			mptcp_inuse_inc(new_msk);
 			ctx->conn = new_msk;
 			new_msk = NULL;
 
-- 
2.37.2

