Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com [209.85.210.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A02C864C
	for <mptcp@lists.linux.dev>; Thu,  6 Oct 2022 06:11:54 +0000 (UTC)
Received: by mail-pf1-f194.google.com with SMTP id g28so1151157pfk.8
        for <mptcp@lists.linux.dev>; Wed, 05 Oct 2022 23:11:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=5takVyvCtWINHH9Pi7mbPiBWb+RZKtzoHCCpiaszXhc=;
        b=S3LdundaUxDkgnKQwE+IGS6cOjPnrs9PJ+Z2kuEXHbWEqwOm8Rjk3mNSaH4gxHbYfF
         APKOftC/THQNI1332i4r54TlcZNs7qwHNKqOf9l48oFrSs0t+BXU/s691ADc52vBBfdw
         FVxrqQSpON+1kkwvjE0HcfZY2fSU/7hDFq0FKwz/7LZ4LLtmi0NLcy1cyDg6DThyYE/0
         YQwP55SxnTIrT9XtY03lbzeAN8vF8fNCsKWMufyHB/cNuvDzguSxrW2hxtmfkrz5J8hE
         Qlu4jiNOSosiv0d0W7a/+EaoXbol9EYgQi0t84wEY+EwIW7ZRZA5u9pXc87ROunPWSC8
         TGSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=5takVyvCtWINHH9Pi7mbPiBWb+RZKtzoHCCpiaszXhc=;
        b=sAC6TMLSh+J8rDmJhThwgaAIz4tNyKf4vqNkhN39N+zAl3T0FJh/vI/j143yMoPXFK
         FnjbwnJLrHiBmNYuUV8vHPPDIT+HVnePgmLTHld5HwMmE9qModeoX5OP0fmXquRglxFv
         wbUeQW3E3HddU4mVAxvtg0faxAbD7SPnku0mDRzjBK+fbY20UUcV7jefaaK1bDBorg/4
         lkYVDTwaccJf0GFXlH/LqybGh94oxwxarfhlgOafJ2z0OMhML+Sq+E+mEMzIInBnTXJO
         zV7vUGL1Y3vuP4ntwMmyxaRIMd8fmatTa6lK0wh0Imj7em+4rqpcU4Sqz3LH+SuRtY0K
         Jnmw==
X-Gm-Message-State: ACrzQf2ZGqw4/UsoJvazSywTeOhzpoHzIlwtZyz/Se8kIzDipqsQL0TR
	netl1EkzxGhux5EYWIDSB68=
X-Google-Smtp-Source: AMsMyM48k/7WReNMQdzOxMYPkf7CoKykBIRVcP+xR6M999Mq7VRhNTTQIGgPF9q1frxzFhvqIZFkHA==
X-Received: by 2002:a63:2212:0:b0:43b:f03d:856a with SMTP id i18-20020a632212000000b0043bf03d856amr3125999pgi.192.1665036713987;
        Wed, 05 Oct 2022 23:11:53 -0700 (PDT)
Received: from localhost.localdomain ([203.205.141.12])
        by smtp.gmail.com with ESMTPSA id bd12-20020a170902830c00b0017bbd845c17sm11398046plb.158.2022.10.05.23.11.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Oct 2022 23:11:53 -0700 (PDT)
From: menglong8.dong@gmail.com
X-Google-Original-From: imagedong@tencent.com
To: mathew.j.martineau@linux.intel.com
Cc: mptcp@lists.linux.dev,
	Menglong Dong <imagedong@tencent.com>
Subject: [PATCH mptcp-next v4 2/3] mptcp: add statistics for mptcp socket in use
Date: Thu,  6 Oct 2022 14:11:21 +0800
Message-Id: <20221006061123.1474224-3-imagedong@tencent.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221006061123.1474224-1-imagedong@tencent.com>
References: <20221006061123.1474224-1-imagedong@tencent.com>
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
index d817fdb2f6ef..248a28ffd3d6 100644
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
+	     !test_and_set_bit(MPTCP_DESTROYED, &msk->flags)) ||
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
index c0b5b4628f65..767b1899e59c 100644
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

