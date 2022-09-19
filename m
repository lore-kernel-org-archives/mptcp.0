Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com [209.85.210.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A883256F
	for <mptcp@lists.linux.dev>; Mon, 19 Sep 2022 13:23:18 +0000 (UTC)
Received: by mail-pf1-f195.google.com with SMTP id c198so28064840pfc.13
        for <mptcp@lists.linux.dev>; Mon, 19 Sep 2022 06:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=XQUVrFwBLSG6cw41QKQ+VH9yclGvZ7B9EM1AUf7nyrc=;
        b=d4DlwIinK2zoo1Gy0MMGxWnMaQsFDYNAmnsX4zdIydkGgpsWhgasN4N19xdCfpjyvx
         obwV0+v3Gf14aSHfBSNVuKLEt/x9iF31kbPmQ2cP2uQRJi0BtRT5+Wr5OLxo22SMFW6B
         ng6PkyL3xmvlhGLoW0wvzZs8Bmf7YUfBtK6s7l1zcGCbNBR/P6MV6M9KdB7RYQQhL1sf
         GkAhJ3xSXlDqbXknxlTaG2aDrdBh3kTFn6E7Cvj6rtGg7j1neWVBV8xIv4T/le0a2rjI
         324w6GAzcaTdrCb6jJV6RtNsgenTrOyUFzy4nlnOcpRt7lvC3JuOLY9iFcc2Y77OgnX9
         xCdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=XQUVrFwBLSG6cw41QKQ+VH9yclGvZ7B9EM1AUf7nyrc=;
        b=uwCuioLQdR54nZAfrV7BLzJBqeBqO/EKq7bA8m+35KlWS5Ur9d77DGnqGAr6tP+1TQ
         mk3Tbrj7/FLS3Dd6MZYg2tP5PxysSy3ZdzuzXKgsYLyTiaoyxRyxSAy/LEhOeId/u9Oq
         ts2T9KdYsbsNvbZk8qM66tBw64BD692uNq1kRl9DRVu8calD03LMHRyrDzKjbtdL/GnA
         WMZjkNkt8vze52MMfkoHuAijjMg9lmZGDEKXJ3KkgSDA6zCreqNBvxfZgd8plHbjj5QG
         9yAPHd7USNYjp8hxPFKjA8iHi8hfn+K3p3LIKu2AzNdsDE+qL00MwYgYRTWJPAjul3w9
         55lw==
X-Gm-Message-State: ACrzQf1ZJB47TLvcoRKDyV02bbDN2MAh43S7njWUz0KHrpLZQ7hUYNdx
	KCRnEBEF62EbHUL7dqZktsw=
X-Google-Smtp-Source: AMsMyM47yb+ga51uupetgTgKY6RYczccMeoiDhkxraiHmw/0kT7HXmZOufi+FhiTFHSgCM8JqH+PoA==
X-Received: by 2002:a05:6a00:a29:b0:54e:6aed:c655 with SMTP id p41-20020a056a000a2900b0054e6aedc655mr6131307pfh.25.1663593797683;
        Mon, 19 Sep 2022 06:23:17 -0700 (PDT)
Received: from localhost.localdomain ([203.205.141.83])
        by smtp.gmail.com with ESMTPSA id c16-20020a624e10000000b0053b2681b0e4sm20390593pfb.67.2022.09.19.06.23.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 06:23:17 -0700 (PDT)
From: menglong8.dong@gmail.com
X-Google-Original-From: imagedong@tencent.com
To: pabeni@redhat.com
Cc: mptcp@lists.linux.dev,
	Menglong Dong <imagedong@tencent.com>
Subject: [PATCH mptcp] net: mptcp: add statistics for mptcp socket in use
Date: Mon, 19 Sep 2022 21:21:56 +0800
Message-Id: <20220919132156.3649522-1-imagedong@tencent.com>
X-Mailer: git-send-email 2.37.2
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
 net/mptcp/protocol.c | 19 +++++++++++++------
 net/mptcp/subflow.c  |  3 +++
 2 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 45ed50e9aec9..4da77aa8b070 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2311,6 +2311,7 @@ static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 			tcp_set_state(ssk, TCP_CLOSE);
 			mptcp_subflow_queue_clean(ssk);
 			inet_csk_listen_stop(ssk);
+			sock_prot_inuse_add(sock_net(sk), sk->sk_prot, -1);
 		}
 		__tcp_close(ssk, 0);
 
@@ -3067,6 +3068,9 @@ void mptcp_destroy_common(struct mptcp_sock *msk, unsigned int flags)
 	skb_rbtree_purge(&msk->out_of_order_queue);
 	mptcp_data_unlock(sk);
 
+	if (!sk_unhashed(sk) || __mptcp_check_fallback(msk))
+		sock_prot_inuse_add(sock_net(sk), sk->sk_prot, -1);
+
 	/* move all the rx fwd alloc into the sk_mem_reclaim_final in
 	 * inet_sock_destruct() will dispose it
 	 */
@@ -3513,6 +3517,7 @@ static int mptcp_stream_connect(struct socket *sock, struct sockaddr *uaddr,
 	mptcp_token_destroy(msk);
 	inet_sk_state_store(sock->sk, TCP_SYN_SENT);
 	subflow = mptcp_subflow_ctx(ssock->sk);
+	sock_prot_inuse_add(sock_net(sock->sk), sock->sk->sk_prot, 1);
 #ifdef CONFIG_TCP_MD5SIG
 	/* no MPTCP if MD5SIG is enabled on this socket or we may run out of
 	 * TCP option space.
@@ -3547,12 +3552,13 @@ static int mptcp_stream_connect(struct socket *sock, struct sockaddr *uaddr,
 static int mptcp_listen(struct socket *sock, int backlog)
 {
 	struct mptcp_sock *msk = mptcp_sk(sock->sk);
+	struct sock *sk = sock->sk;
 	struct socket *ssock;
 	int err;
 
 	pr_debug("msk=%p", msk);
 
-	lock_sock(sock->sk);
+	lock_sock(sk);
 	ssock = __mptcp_nmpc_socket(msk);
 	if (!ssock) {
 		err = -EINVAL;
@@ -3560,16 +3566,17 @@ static int mptcp_listen(struct socket *sock, int backlog)
 	}
 
 	mptcp_token_destroy(msk);
-	inet_sk_state_store(sock->sk, TCP_LISTEN);
-	sock_set_flag(sock->sk, SOCK_RCU_FREE);
+	inet_sk_state_store(sk, TCP_LISTEN);
+	sock_set_flag(sk, SOCK_RCU_FREE);
+	sock_prot_inuse_add(sock_net(sk), sk->sk_prot, 1);
 
 	err = ssock->ops->listen(ssock, backlog);
-	inet_sk_state_store(sock->sk, inet_sk_state_load(ssock->sk));
+	inet_sk_state_store(sk, inet_sk_state_load(ssock->sk));
 	if (!err)
-		mptcp_copy_inaddrs(sock->sk, ssock->sk);
+		mptcp_copy_inaddrs(sk, ssock->sk);
 
 unlock:
-	release_sock(sock->sk);
+	release_sock(sk);
 	return err;
 }
 
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

