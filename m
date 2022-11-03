Received: from mail-pj1-f65.google.com (mail-pj1-f65.google.com [209.85.216.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C6AB2F21
	for <mptcp@lists.linux.dev>; Thu,  3 Nov 2022 11:07:41 +0000 (UTC)
Received: by mail-pj1-f65.google.com with SMTP id f5-20020a17090a4a8500b002131bb59d61so5231603pjh.1
        for <mptcp@lists.linux.dev>; Thu, 03 Nov 2022 04:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LMC/FaXCklvWVbgeLHA5owCI176LRpZvem/NIC6gb5E=;
        b=IrYdjwRTz57zpnt0LWpWrIjan1XiLbobmJlA4xINgRdKy/rAy0NUYjjdQDO5l32dB9
         TKh8aGddW6xWrQDD2PyUeG/f4v8zFHMT+xHihJZj+gf+fEwNpsF+ClIT4RsFz3q3Iu2P
         GdaL92Zafeh/awa1EerEO6gsvKqz/1cP1F9o8z9zEZaquZ0+JeH1fcu2lNkJBhn93S2G
         kNpu4n6YsPxqWPV0phDuQ975dpfS+RpXUTBU/J/3/p9MU7GiZtRTkBlDw0bVrXq7BADQ
         22XDea/k0oARYkYsVrB9EDsm7CcmLqmnJPrJj7vIWTlw5l+cpPcwAzUmS6sqpfniedCb
         +mGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LMC/FaXCklvWVbgeLHA5owCI176LRpZvem/NIC6gb5E=;
        b=yWO44GE3FemrotB6rkWr47a17l/2Z2PbxjRfyef6/tAVoMhGa5vLMvqaxsTurkQvI7
         YDZ1H0O8tKI9bFjfxHFYCgw+p0nSJ1PBVZzzriAKhoigtsKJyf59NGijGcs9dUiMCrLq
         gX/sVdCDqbFSquZvALcMYv/ThBlG5vu0qIpC8tFXbNmBMYbyz2r77GdsqhBy9KA+TLEK
         zGmsCBxhQxreWhrSITx/3eXZBy9yinbhOQ6bNuyso/6w4puk8BSU4WZXqV50l6OsDmGj
         PBGNWdKVLM80lWQonfG/rdSh6apFoydQvCdpbPCjGNDKvpO9HP7CJjjFiPIQjVAQRVsh
         PZYw==
X-Gm-Message-State: ACrzQf0EpvVjlxD8aa5odUpgELKAhpRRXuc5yhJUxVgOPvDZWvkRhaeY
	vOyRBoIB99PvGIL34KxE5Qw=
X-Google-Smtp-Source: AMsMyM5l4GiP4KvVE1Uv7HsU0DKrb9xgRR0eCGe+kaWvHoEnmJKjWk4WlkGk1DB2/mxPTfB1y9sB3A==
X-Received: by 2002:a17:90a:f306:b0:213:b191:f3bf with SMTP id ca6-20020a17090af30600b00213b191f3bfmr28502440pjb.237.1667473661030;
        Thu, 03 Nov 2022 04:07:41 -0700 (PDT)
Received: from localhost.localdomain ([203.205.141.83])
        by smtp.gmail.com with ESMTPSA id w14-20020a627b0e000000b0056bd4ec964csm450555pfc.194.2022.11.03.04.07.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 04:07:40 -0700 (PDT)
From: menglong8.dong@gmail.com
X-Google-Original-From: imagedong@tencent.com
To: mathew.j.martineau@linux.intel.com,
	matthieu.baerts@tessares.net
Cc: mptcp@lists.linux.dev,
	Menglong Dong <imagedong@tencent.com>
Subject: [PATCH mptcp-next v6 2/4] mptcp: add statistics for mptcp socket in use
Date: Thu,  3 Nov 2022 19:06:47 +0800
Message-Id: <20221103110649.299284-3-imagedong@tencent.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221103110649.299284-1-imagedong@tencent.com>
References: <20221103110649.299284-1-imagedong@tencent.com>
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
index 151d22c91b7e..0abdba83a576 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3068,6 +3068,7 @@ struct sock *mptcp_sk_clone(const struct sock *sk,
 	msk->snd_una = msk->write_seq;
 	msk->wnd_end = msk->snd_nxt + req->rsk_rcv_wnd;
 	msk->setsockopt_seq = mptcp_sk(sk)->setsockopt_seq;
+	clear_bit(MPTCP_INUSE, &msk->flags);
 	mptcp_init_sched(msk, mptcp_sk(sk)->sched);
 
 	if (mp_opt->suboptions & OPTIONS_MPTCP_MPC) {
@@ -3177,6 +3178,8 @@ void mptcp_destroy_common(struct mptcp_sock *msk, unsigned int flags)
 	skb_rbtree_purge(&msk->out_of_order_queue);
 	mptcp_data_unlock(sk);
 
+	mptcp_inuse_dec(sk);
+
 	/* move all the rx fwd alloc into the sk_mem_reclaim_final in
 	 * inet_sock_destruct() will dispose it
 	 */
@@ -3540,6 +3543,7 @@ static int mptcp_connect(struct sock *sk, struct sockaddr *uaddr, int addr_len)
 
 	mptcp_token_destroy(msk);
 	inet_sk_state_store(sk, TCP_SYN_SENT);
+	mptcp_inuse_inc(sk);
 	subflow = mptcp_subflow_ctx(ssock->sk);
 #ifdef CONFIG_TCP_MD5SIG
 	/* no MPTCP if MD5SIG is enabled on this socket or we may run out of
@@ -3672,8 +3676,10 @@ static int mptcp_listen(struct socket *sock, int backlog)
 
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
index 8f48f881adf8..d6d2ab17129b 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -116,6 +116,7 @@
 #define MPTCP_WORK_EOF		3
 #define MPTCP_FALLBACK_DONE	4
 #define MPTCP_WORK_CLOSE_SUBFLOW 5
+#define MPTCP_INUSE		6
 
 /* MPTCP socket release cb flags */
 #define MPTCP_PUSH_PENDING	1
@@ -383,6 +384,18 @@ static inline struct mptcp_data_frag *mptcp_rtx_head(const struct sock *sk)
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
index 02a54d59697b..c5934140f3f3 100644
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

