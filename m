Received: from mail-pj1-f68.google.com (mail-pj1-f68.google.com [209.85.216.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9317ED2
	for <mptcp@lists.linux.dev>; Mon, 19 Dec 2022 07:51:41 +0000 (UTC)
Received: by mail-pj1-f68.google.com with SMTP id v23so2986638pju.3
        for <mptcp@lists.linux.dev>; Sun, 18 Dec 2022 23:51:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q89bB0etj5gNAJ4ghjKps16lPq061+dXHL9eOYdlKaY=;
        b=bGp7umo7og0Wf68qGsXEHnmbjNJPz8VviOZYjFt4RmM+8FKkxmLOvPvbe1E/Ua6cQg
         yEQFfqcdqH9oNBkJsbwZzZ8+d1GkQKTMKgZ+Y5nQGOxtSlxnCzrkasRfKziPJbQcKWtq
         +HDHiqji4+RLw0jR32r8msXtYVtoo/8IBNgwfjg6hSbCs/tAakZEU4hT4aBglNzqwktu
         QSQx9hkRLPNTZl+e0XbXgnmdvd5DAXcWjZb/n7Dk/c8Wd7PhbJte5UwQflM+jPVzSwa3
         VWqoMBV005v+A5DrdY9c/C9HhbadrmAMem+GrzK0XT9ryXbtUiGkR9KZe9MpbWCI4lRF
         4waA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q89bB0etj5gNAJ4ghjKps16lPq061+dXHL9eOYdlKaY=;
        b=It5L/yJV0yTGLpeGBtkn7UG8o9/7iCaaiQD8jcLJ945IOe0td1F1jq0PPhyYgeL6FT
         Ik1+aE8Z4yTZtWZ0hbPMs1KYBLIOCirsf91aSrlzyeInltiLfGs2Xi+yvSORTCkEEKFM
         EF+3KZSUv4oEVbPERO2psOlCPcrzb3xZhVD9qiv+tYc3n02FbaKDwRIkM2suYgOTLU8V
         7I2Q6qbIMgnJl2vzCpfaT+2l43721T5ZCfwPPl3dYCquG9jhDNCnU1CFXKx5dOviUCz4
         0VFGBFzve7AEZsoY+2JlctBUiMsomWwHq4m70g/1ApR6/QFbvmsYCvuk4gsFhg1jlkVn
         Xcew==
X-Gm-Message-State: ANoB5plyfdp3Xq+u/8jMvMLaGPqeQmCniyHjbt+dlCILrsJzl/B0SmyP
	wWcqxkQNRLqoCoacLQ+Psoc=
X-Google-Smtp-Source: AA0mqf69wp/+oO4Y/7OEQo0mDivbTWgp53Okol/o+orXun62uwql96S70pfK4pX9ep6c/2VCEBPjxw==
X-Received: by 2002:a17:902:7104:b0:189:bf5d:c951 with SMTP id a4-20020a170902710400b00189bf5dc951mr39532129pll.26.1671436301148;
        Sun, 18 Dec 2022 23:51:41 -0800 (PST)
Received: from localhost.localdomain ([203.205.141.21])
        by smtp.gmail.com with ESMTPSA id t9-20020a170902e84900b001888cadf8f6sm6366673plg.49.2022.12.18.23.51.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Dec 2022 23:51:40 -0800 (PST)
From: menglong8.dong@gmail.com
X-Google-Original-From: imagedong@tencent.com
To: pabeni@redhat.com,
	mathew.j.martineau@linux.intel.com,
	matthieu.baerts@tessares.net
Cc: mptcp@lists.linux.dev,
	Menglong Dong <imagedong@tencent.com>
Subject: [PATCH mptcp-next v9 3/6] mptcp: add statistics for mptcp socket in use
Date: Mon, 19 Dec 2022 15:50:45 +0800
Message-Id: <20221219075048.255811-4-imagedong@tencent.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221219075048.255811-1-imagedong@tencent.com>
References: <20221219075048.255811-1-imagedong@tencent.com>
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
v9:
- check the state of msk instead of ssk for listening socket

v8:
- remove the MPTCP_INUSE flag and do the statistics according to the
  creation and destruction of the token

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
---
 net/mptcp/protocol.c | 12 +++++++++++-
 net/mptcp/token.c    |  6 ++++++
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 3de45444557d..44d66bd0f51e 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2907,6 +2907,12 @@ static __poll_t mptcp_check_readable(struct mptcp_sock *msk)
 	return EPOLLIN | EPOLLRDNORM;
 }
 
+static void mptcp_listen_inuse_dec(struct sock *sk)
+{
+	if (inet_sk_state_load(sk) == TCP_LISTEN)
+		sock_prot_inuse_add(sock_net(sk), sk->sk_prot, -1);
+}
+
 bool __mptcp_close(struct sock *sk, long timeout)
 {
 	struct mptcp_subflow_context *subflow;
@@ -2916,6 +2922,7 @@ bool __mptcp_close(struct sock *sk, long timeout)
 	sk->sk_shutdown = SHUTDOWN_MASK;
 
 	if ((1 << sk->sk_state) & (TCPF_LISTEN | TCPF_CLOSE)) {
+		mptcp_listen_inuse_dec(sk);
 		inet_sk_state_store(sk, TCP_CLOSE);
 		goto cleanup;
 	}
@@ -3016,6 +3023,7 @@ static int mptcp_disconnect(struct sock *sk, int flags)
 	if (msk->fastopening)
 		return 0;
 
+	mptcp_listen_inuse_dec(sk);
 	inet_sk_state_store(sk, TCP_CLOSE);
 
 	mptcp_stop_timer(sk);
@@ -3674,8 +3682,10 @@ static int mptcp_listen(struct socket *sock, int backlog)
 
 	err = ssock->ops->listen(ssock, backlog);
 	inet_sk_state_store(sk, inet_sk_state_load(ssock->sk));
-	if (!err)
+	if (!err) {
+		sock_prot_inuse_add(sock_net(sk), sk->sk_prot, 1);
 		mptcp_copy_inaddrs(sk, ssock->sk);
+	}
 
 	mptcp_event_pm_listener(ssock->sk, MPTCP_EVENT_LISTENER_CREATED);
 
diff --git a/net/mptcp/token.c b/net/mptcp/token.c
index 968008f6db45..5cca503f8899 100644
--- a/net/mptcp/token.c
+++ b/net/mptcp/token.c
@@ -153,6 +153,7 @@ int mptcp_token_new_connect(struct sock *ssk)
 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
 	struct mptcp_sock *msk = mptcp_sk(subflow->conn);
 	int retries = MPTCP_TOKEN_MAX_RETRIES;
+	struct sock *sk = subflow->conn;
 	struct token_bucket *bucket;
 
 again:
@@ -175,6 +176,7 @@ int mptcp_token_new_connect(struct sock *ssk)
 	__sk_nulls_add_node_rcu((struct sock *)msk, &bucket->msk_chain);
 	bucket->chain_len++;
 	spin_unlock_bh(&bucket->lock);
+	sock_prot_inuse_add(sock_net(sk), sk->sk_prot, 1);
 	return 0;
 }
 
@@ -190,8 +192,10 @@ void mptcp_token_accept(struct mptcp_subflow_request_sock *req,
 			struct mptcp_sock *msk)
 {
 	struct mptcp_subflow_request_sock *pos;
+	struct sock *sk = (struct sock *)msk;
 	struct token_bucket *bucket;
 
+	sock_prot_inuse_add(sock_net(sk), sk->sk_prot, 1);
 	bucket = token_bucket(req->token);
 	spin_lock_bh(&bucket->lock);
 
@@ -370,12 +374,14 @@ void mptcp_token_destroy_request(struct request_sock *req)
  */
 void mptcp_token_destroy(struct mptcp_sock *msk)
 {
+	struct sock *sk = (struct sock *)msk;
 	struct token_bucket *bucket;
 	struct mptcp_sock *pos;
 
 	if (sk_unhashed((struct sock *)msk))
 		return;
 
+	sock_prot_inuse_add(sock_net(sk), sk->sk_prot, -1);
 	bucket = token_bucket(msk->token);
 	spin_lock_bh(&bucket->lock);
 	pos = __token_lookup_msk(bucket, msk->token);
-- 
2.37.2

