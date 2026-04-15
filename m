Received: from zg8tmtyylji0my4xnjeumjiw.icoremail.net (zg8tmtyylji0my4xnjeumjiw.icoremail.net [162.243.161.220])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35B6F33A9C3
	for <mptcp@lists.linux.dev>; Wed, 15 Apr 2026 09:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.161.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776245613; cv=none; b=H+r+IRNT575JDzbvPg8wm8A9om24iSp0csRnezfZ+8LkSJy6KIeMrJ8K3lPjlxuXnoT1S/4+WOTxyyzVxkGGdG0/mbLR8FR2uSyE3OI4YQEylTmfXYNb14Ihl73qcbzBvx/bfkXNA80ZS5bo3iqAgrUpL4EZWWEu74EJ2o0ctA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776245613; c=relaxed/simple;
	bh=ttxF1S5iNK2dHntTScBOiUpfR7Wguucy/wubn7BFdSI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vFKW0z3JSW7vwI07X8oxRmUSt1LoiXf5aRZXV8nvJ5ZbfL3jXd63PfTwihRVLRqHtWxZXZzUJozeiATuYin7KyG9AuA5auibi5MTXVclxkek6TWrTfy1ckvXAXKigIyI/pEoxm4WnCNe/+BrSyI2e6VYyvLcijAEpw2BJfaMA9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lzu.edu.cn; spf=pass smtp.mailfrom=lzu.edu.cn; arc=none smtp.client-ip=162.243.161.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lzu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lzu.edu.cn
Received: from enjou-Legion-Y7000P-2019.coin-barley.ts.net (unknown [172.23.56.36])
	by app1 (Coremail) with SMTP id ygmowAAnmPhVW99pg3LHAA--.2965S3;
	Wed, 15 Apr 2026 17:33:14 +0800 (CST)
From: Ren Wei <n05ec@lzu.edu.cn>
To: netdev@vger.kernel.org,
	mptcp@lists.linux.dev
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	ncardwell@google.com,
	kuniyu@google.com,
	dsahern@kernel.org,
	matttbe@kernel.org,
	martineau@kernel.org,
	geliang@kernel.org,
	daniel@iogearbox.net,
	kafai@fb.com,
	yuantan098@gmail.com,
	yifanwucs@gmail.com,
	tomapufckgml@gmail.com,
	bird@lzu.edu.cn,
	caoruide123@gmail.com,
	enjou1224z@gmail.com,
	n05ec@lzu.edu.cn
Subject: [PATCH net 1/1] mptcp: hold subflow request owners when cloning reqsk
Date: Wed, 15 Apr 2026 17:31:12 +0800
Message-ID: <86e2514b533bf4d55d4aa2fdbf1404022e8c9430.1776149210.git.caoruide123@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1776149210.git.caoruide123@gmail.com>
References: <cover.1776149210.git.caoruide123@gmail.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:ygmowAAnmPhVW99pg3LHAA--.2965S3
X-Coremail-Antispam: 1UD129KBjvJXoWxCr1fGF4fZFWUZw4DuFW5Awb_yoWrWF4xpF
	4DJFWjkrs3X3W5uFWfJFWUAr15KF4IkrZxJa1UKwnay3sFgws3uF1Dur1UZry3AFs2kFWU
	CF4qgFs8XF12vaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBY1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
	w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
	IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2
	z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcV
	Aq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j
	6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64
	vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0E
	n4kS14v26r4a6rW5MxkIecxEwVCm-wCF04k20xvY0x0EwIxGrwCF04k20xvE74AGY7Cv6c
	x26r48MxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCj
	r7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6x
	IIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAI
	w20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x
	0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7sRi_HU3UUUUU==
X-CM-SenderInfo: zqqvvuo6o23hxhgxhubq/1tbiAQsSCWnfUN8BxwAAsu

From: Ruide Cao <caoruide123@gmail.com>

TCP request migration clones pending request sockets with
inet_reqsk_clone(). For MPTCP MP_JOIN requests this raw-copies
subflow_req->msk, but the cloned request does not take a new reference.

Both the original and the cloned request can later drop the same msk in
subflow_req_destructor(), and a migrated request may keep a dangling msk
pointer after the original owner has already been released.

Add a request_sock clone callback and let MPTCP grab a reference for cloned
subflow requests that carry an msk. This keeps ownership balanced across
both successful migrations and failed clone/insert paths without changing
other protocols.

Fixes: c905dee62232 ("tcp: Migrate TCP_NEW_SYN_RECV requests at retransmitting SYN+ACKs.")
Cc: stable@kernel.org
Reported-by: Yuan Tan <yuantan098@gmail.com>
Reported-by: Yifan Wu <yifanwucs@gmail.com>
Reported-by: Juefei Pu <tomapufckgml@gmail.com>
Reported-by: Xin Liu <bird@lzu.edu.cn>
Signed-off-by: Ruide Cao <caoruide123@gmail.com>
Tested-by: Ren Wei <enjou1224z@gmail.com>
Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
---
 include/net/request_sock.h      |  2 ++
 net/ipv4/inet_connection_sock.c |  3 +++
 net/mptcp/subflow.c             | 13 +++++++++++++
 3 files changed, 18 insertions(+)

diff --git a/include/net/request_sock.h b/include/net/request_sock.h
index 5a9c826a7092..560e464c400f 100644
--- a/include/net/request_sock.h
+++ b/include/net/request_sock.h
@@ -36,6 +36,8 @@ struct request_sock_ops {
 				      struct sk_buff *skb,
 				      enum sk_rst_reason reason);
 	void		(*destructor)(struct request_sock *req);
+	void		(*init_clone)(const struct request_sock *req,
+				      struct request_sock *new_req);
 };
 
 struct saved_syn {
diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
index e961936b6be7..140a9e96ad58 100644
--- a/net/ipv4/inet_connection_sock.c
+++ b/net/ipv4/inet_connection_sock.c
@@ -954,6 +954,9 @@ static struct request_sock *inet_reqsk_clone(struct request_sock *req,
 	if (sk->sk_protocol == IPPROTO_TCP && tcp_rsk(nreq)->tfo_listener)
 		rcu_assign_pointer(tcp_sk(nreq->sk)->fastopen_rsk, nreq);
 
+	if (req->rsk_ops->init_clone)
+		req->rsk_ops->init_clone(req, nreq);
+
 	return nreq;
 }
 
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 4ff5863aa9fd..5f4069647822 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -47,6 +47,17 @@ static void subflow_req_destructor(struct request_sock *req)
 	mptcp_token_destroy_request(req);
 }
 
+static void subflow_req_clone(const struct request_sock *req,
+			      struct request_sock *new_req)
+{
+	struct mptcp_subflow_request_sock *subflow_req = mptcp_subflow_rsk(new_req);
+
+	(void)req;
+
+	if (subflow_req->msk)
+		sock_hold((struct sock *)subflow_req->msk);
+}
+
 static void subflow_generate_hmac(u64 key1, u64 key2, u32 nonce1, u32 nonce2,
 				  void *hmac)
 {
@@ -2143,6 +2154,7 @@ void __init mptcp_subflow_init(void)
 	mptcp_subflow_v4_request_sock_ops = tcp_request_sock_ops;
 	mptcp_subflow_v4_request_sock_ops.slab_name = "request_sock_subflow_v4";
 	mptcp_subflow_v4_request_sock_ops.destructor = subflow_v4_req_destructor;
+	mptcp_subflow_v4_request_sock_ops.init_clone = subflow_req_clone;
 
 	if (subflow_ops_init(&mptcp_subflow_v4_request_sock_ops) != 0)
 		panic("MPTCP: failed to init subflow v4 request sock ops\n");
@@ -2184,6 +2196,7 @@ void __init mptcp_subflow_v6_init(void)
 	mptcp_subflow_v6_request_sock_ops = tcp6_request_sock_ops;
 	mptcp_subflow_v6_request_sock_ops.slab_name = "request_sock_subflow_v6";
 	mptcp_subflow_v6_request_sock_ops.destructor = subflow_v6_req_destructor;
+	mptcp_subflow_v6_request_sock_ops.init_clone = subflow_req_clone;
 
 	if (subflow_ops_init(&mptcp_subflow_v6_request_sock_ops) != 0)
 		panic("MPTCP: failed to init subflow v6 request sock ops\n");
-- 
2.34.1

