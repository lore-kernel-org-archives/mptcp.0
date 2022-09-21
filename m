Received: from mail-pj1-f66.google.com (mail-pj1-f66.google.com [209.85.216.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 697113211
	for <mptcp@lists.linux.dev>; Wed, 21 Sep 2022 12:07:29 +0000 (UTC)
Received: by mail-pj1-f66.google.com with SMTP id s90-20020a17090a2f6300b00203a685a1aaso5620804pjd.1
        for <mptcp@lists.linux.dev>; Wed, 21 Sep 2022 05:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=P1NIMRpz20m2QRFbTexZEn857WvNnY57Z01D+FEYPJg=;
        b=CKzw2Z6U55NxZu4EctnG/lUyUxNmS/Is8dOv0s3ZEwVHnE29NDuiuQIxssZIJdrlKO
         jzK/Fl1EN2aECnn1q6WLPnSw8LolcBPm39TTfWsxTsEEs7htbAny4HLm9YfhHqYW7pV3
         CPBJ+JDrM6hVwnA0WZPgHLCiDRYHpNV0Nbz43R5jeFQ4i6Fi8NVFUhkszgv+xwbG7FXl
         I/fs/KBCr/pwMjtHVQ+cvp7iu1TTa/TNqeTodkfnjjDmEI7OQ4SmTn9ehbAWBkJ9gEQy
         lnBxFG/2olSfakZfymKcszpXoB90TtuBZJ4Jc5tJAR5ykFnfINeCWCnnQArHruFbe4xX
         SE2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=P1NIMRpz20m2QRFbTexZEn857WvNnY57Z01D+FEYPJg=;
        b=E8x4AOOoU29NTzoumw1eYB81nFUZkcjWqqyKp7o2dwLf6kFEcM6va6M3qK/jdnWU2M
         tjHEuR4mtjNbw624GxBDP/raxXU4d15X5xNj2JhCNbJXmEa4V2Pymsk3XnCBlPPvc/O5
         696kC2DC1Q4BVTV3fiXxDvHruDFyORDrPXm4T6ZFAhHCPYaWVVYXIa4Gs32WdxSuL5XB
         o3gZaL9q4YbE+DV3i1qxoe/xzk+Kk07ot6iby0zBM3cmWD+a6xUP+ctiFzhwmyKaOSo8
         Dq7YfThCEaWrBAPj/CTkppyBhH9C5PVSz7i/o8D+4nNjD0nqSlnv2U8HA7DG4Vr3RPxL
         RBQg==
X-Gm-Message-State: ACrzQf3mbBn+eMuqur5VksO06ivi+u+DUpo5sH8L6XutzAqc1hgaaDv+
	qFL5V1RFbrmHPllDkoVNM00=
X-Google-Smtp-Source: AMsMyM55wVbguIQv0ucuBTVD1JF0HFnfuwahCNEele2ktTINRD2+CyZEGm7+l0UFjfWkJyVkaKo2YQ==
X-Received: by 2002:a17:90a:3806:b0:202:880e:81d with SMTP id w6-20020a17090a380600b00202880e081dmr9170113pjb.161.1663762048908;
        Wed, 21 Sep 2022 05:07:28 -0700 (PDT)
Received: from localhost.localdomain ([203.205.141.16])
        by smtp.gmail.com with ESMTPSA id u7-20020a17090341c700b00174fa8cbf31sm1869233ple.303.2022.09.21.05.07.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 05:07:28 -0700 (PDT)
From: menglong8.dong@gmail.com
X-Google-Original-From: imagedong@tencent.com
To: mathew.j.martineau@linux.intel.com
Cc: mptcp@lists.linux.dev,
	Menglong Dong <imagedong@tencent.com>
Subject: [PATCH mptcp-next v2 2/2] mptcp: add statistics for mptcp socket in use
Date: Wed, 21 Sep 2022 20:04:42 +0800
Message-Id: <20220921120442.320727-3-imagedong@tencent.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220921120442.320727-1-imagedong@tencent.com>
References: <20220921120442.320727-1-imagedong@tencent.com>
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
index 1550455f7640..57d468b24a92 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2885,6 +2885,16 @@ static void mptcp_copy_inaddrs(struct sock *msk, const struct sock *ssk)
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
@@ -2897,6 +2907,7 @@ static int mptcp_disconnect(struct sock *sk, int flags)
 	if (mptcp_sk(sk)->token)
 		mptcp_event(MPTCP_EVENT_CLOSED, mptcp_sk(sk), NULL, GFP_KERNEL);
 
+	mptcp_listen_inuse_dec(sk);
 	/* msk->subflow is still intact, the following will not free the first
 	 * subflow
 	 */
@@ -3068,6 +3079,11 @@ void mptcp_destroy_common(struct mptcp_sock *msk, unsigned int flags)
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
@@ -3082,6 +3098,7 @@ static void mptcp_destroy(struct sock *sk)
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
 
+	mptcp_listen_inuse_dec(sk);
 	/* clears msk->subflow, allowing the following to close
 	 * even the initial subflow
 	 */
@@ -3514,6 +3531,7 @@ static int mptcp_stream_connect(struct socket *sock, struct sockaddr *uaddr,
 	mptcp_token_destroy(msk);
 	inet_sk_state_store(sock->sk, TCP_SYN_SENT);
 	subflow = mptcp_subflow_ctx(ssock->sk);
+	sock_prot_inuse_add(sock_net(sock->sk), sock->sk->sk_prot, 1);
 #ifdef CONFIG_TCP_MD5SIG
 	/* no MPTCP if MD5SIG is enabled on this socket or we may run out of
 	 * TCP option space.
@@ -3567,8 +3585,10 @@ static int mptcp_listen(struct socket *sock, int backlog)
 
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

