Received: from mail-pj1-f66.google.com (mail-pj1-f66.google.com [209.85.216.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E406162C
	for <mptcp@lists.linux.dev>; Thu,  8 Dec 2022 02:46:37 +0000 (UTC)
Received: by mail-pj1-f66.google.com with SMTP id u5so319784pjy.5
        for <mptcp@lists.linux.dev>; Wed, 07 Dec 2022 18:46:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SDxupugxA4j3iu+Sx18nuzXfQ7swC3BH0oWcZxdifXg=;
        b=Osz5AxCUNvAhuCrLuBmLVsyKP10CRBLmWtk4r/veD6Tf71DtQ7XQ98oKqTooPThUyy
         5J0Sow/Trh01gMaO3RbKpXSnE23KBbhNabP6OjLyq9DQvS+ia2WLK04ax0Vvc/cqcDFt
         4deQ0i852wonZ6cN3GuKbSpXQYkk8Q7lgRdbDqnAFUxMQ5RKEvvSI6eBpvzGApBk8Jd3
         4OOCjAD/nsfjYzTw0opQmM9d9qM25ZxyIFpO0LEnX63ni8sQAnYxgMEiOwS4md2FmMtg
         vrAH/rej2Sqi6Lkl30JLV21jdYDNM4NHz+uzflT7CaAvd3TNT5XqRYeMJY8B4rKdib+D
         YBBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SDxupugxA4j3iu+Sx18nuzXfQ7swC3BH0oWcZxdifXg=;
        b=OV8hCnJpq5mva1M8eEDBpQ5O3fd64OX6pCsrhP7K9sOlDgZtERhTBxYNLXx3GvbclI
         KDNe6rYaygkEM0D6jrn9Jygkpq3kF02yFOOgxkejrmziwvS93xH68BMlNjlkwa2hCCiF
         iUNUb0vE9NFh6Oe2tWwkO9hrmjSYE9eoodkk7IB4Kq84P54ajvLjHdKph5w0+F030hBs
         G200Knj4Nm0sVq9KxNk8LCl8GJ03CMaNesrtwhm7T56Ip3EsSOhi+NqwlP6fcpCfgTaE
         78s61xvzY73raK25YvojbTGfYCTP564UT4R2MXcAiNkf3+NC3XJAp7q0r+Ch/hc4dwKj
         Yigw==
X-Gm-Message-State: ANoB5pkqnqmbYgWDK15BfSpDU96jwWi7t8mRc7aXLZ3/n/Cu95eql3D+
	Wd+7CQYXKoytJmGxr1JRXN4=
X-Google-Smtp-Source: AA0mqf68u/UNsz7EIpcjryq9W2vetNGgipFAmulAdOHmMNBATA3j08F2kB1MD1t4SOD3Ab1POU0YGg==
X-Received: by 2002:a17:902:c104:b0:189:a931:c8a1 with SMTP id 4-20020a170902c10400b00189a931c8a1mr39056593pli.112.1670467597367;
        Wed, 07 Dec 2022 18:46:37 -0800 (PST)
Received: from localhost.localdomain ([203.205.141.17])
        by smtp.gmail.com with ESMTPSA id a26-20020aa78e9a000000b005769cee6735sm8606394pfr.43.2022.12.07.18.46.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Dec 2022 18:46:37 -0800 (PST)
From: menglong8.dong@gmail.com
X-Google-Original-From: imagedong@tencent.com
To: pabeni@redhat.com,
	mathew.j.martineau@linux.intel.com,
	matthieu.baerts@tessares.net
Cc: mptcp@lists.linux.dev,
	Menglong Dong <imagedong@tencent.com>
Subject: [PATCH mptcp-next v8 2/4] mptcp: add statistics for mptcp socket in use
Date: Thu,  8 Dec 2022 10:45:41 +0800
Message-Id: <20221208024543.113633-3-imagedong@tencent.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221208024543.113633-1-imagedong@tencent.com>
References: <20221208024543.113633-1-imagedong@tencent.com>
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
 net/mptcp/protocol.c | 16 +++++++++++++++-
 net/mptcp/token.c    |  7 +++++++
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index ffdccf26af99..775454a9d49b 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3005,6 +3005,16 @@ void mptcp_copy_inaddrs(struct sock *msk, const struct sock *ssk)
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
@@ -3025,6 +3035,7 @@ static int mptcp_disconnect(struct sock *sk, int flags)
 	if (msk->token)
 		mptcp_event(MPTCP_EVENT_CLOSED, msk, NULL, GFP_KERNEL);
 
+	mptcp_listen_inuse_dec(sk);
 	/* msk->subflow is still intact, the following will not free the first
 	 * subflow
 	 */
@@ -3203,6 +3214,7 @@ static void mptcp_destroy(struct sock *sk)
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
 
+	mptcp_listen_inuse_dec(sk);
 	/* clears msk->subflow, allowing the following to close
 	 * even the initial subflow
 	 */
@@ -3675,8 +3687,10 @@ static int mptcp_listen(struct socket *sock, int backlog)
 
 	err = ssock->ops->listen(ssock, backlog);
 	inet_sk_state_store(sk, inet_sk_state_load(ssock->sk));
-	if (!err)
+	if (!err) {
+		sock_prot_inuse_add(sock_net(sk), sk->sk_prot, 1);
 		mptcp_copy_inaddrs(sk, ssock->sk);
+	}
 
 	mptcp_event_pm_listener(ssock->sk, MPTCP_EVENT_LISTENER_CREATED);
 
diff --git a/net/mptcp/token.c b/net/mptcp/token.c
index 65430f314a68..54064146175f 100644
--- a/net/mptcp/token.c
+++ b/net/mptcp/token.c
@@ -175,6 +175,9 @@ int mptcp_token_new_connect(struct sock *sk)
 	__sk_nulls_add_node_rcu((struct sock *)msk, &bucket->msk_chain);
 	bucket->chain_len++;
 	spin_unlock_bh(&bucket->lock);
+	sock_prot_inuse_add(sock_net(subflow->conn),
+			    subflow->conn->sk_prot,
+			    1);
 	return 0;
 }
 
@@ -190,8 +193,10 @@ void mptcp_token_accept(struct mptcp_subflow_request_sock *req,
 			struct mptcp_sock *msk)
 {
 	struct mptcp_subflow_request_sock *pos;
+	struct sock *sk = (struct sock *)msk;
 	struct token_bucket *bucket;
 
+	sock_prot_inuse_add(sock_net(sk), sk->sk_prot, 1);
 	bucket = token_bucket(req->token);
 	spin_lock_bh(&bucket->lock);
 
@@ -370,12 +375,14 @@ void mptcp_token_destroy_request(struct request_sock *req)
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

