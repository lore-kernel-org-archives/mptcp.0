Received: from m12-17.163.com (m12-17.163.com [220.181.12.17])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F7FF71
	for <mptcp@lists.linux.dev>; Wed, 21 Apr 2021 09:03:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Message-ID:Date:MIME-Version; bh=lFaco
	1g6smDShrwPItBPq9j8sf30CR4M7kHTEwF+vUg=; b=myobrroriAKDS2HbRyPCu
	JvbRUNkKp7E+cd5JY/lQYS1Zv225ZKXEeORAAvTjGbdF0fuQAKGHF5ydCSgT0JNZ
	wP1dnqder0P03ykUPv+Nne2hTPRJvg/bD80MfIINLlaUvQ/tqE+19ft1+3dsCiWQ
	Kh9VBfKvEE4Quy2bcSbIxs=
Received: from [192.168.15.51] (unknown [120.36.226.89])
	by smtp13 (Coremail) with SMTP id EcCowAAXFY156n9g1Sdpwg--.24939S2;
	Wed, 21 Apr 2021 17:03:54 +0800 (CST)
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>
From: Jianguo Wu <wujianguo106@163.com>
Subject: [PATCH v2] mptcp: using TOKEN_MAX_RETRIES instead of magic number
Message-ID: <39df61d9-15f4-6fbe-3f8b-42415de50044@163.com>
Date: Wed, 21 Apr 2021 17:03:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:EcCowAAXFY156n9g1Sdpwg--.24939S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Ww4fKw1UCw18uw4xWFy3Arb_yoW8ZF48pF
	4UWrW3Ar4fXFZxWF4kJF48Zr13W3ZYk3s8Gayjkwn3tr4qgwnrWFy8GF4UGrW3GF4vqFnx
	ZFsrXwn8Xa17uaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07bFuWLUUUUU=
X-Originating-IP: [120.36.226.89]
X-CM-SenderInfo: 5zxmxt5qjx0iiqw6il2tof0z/1tbiURB7kFWBS4w89AABsw

From: Jianguo Wu <wujianguo@chinatelecom.cn>

We have macro TOKEN_MAX_RETRIES for the number of token generate retries,
so using TOKEN_MAX_RETRIES in subflow_check_req(),
and rename TOKEN_MAX_RETRIES to MPTCP_TOKEN_MAX_RETRIES.

Fixes: 535fb8152f31 ("mptcp: token: move retry to caller")
Signed-off-by: Jianguo Wu <wujianguo@chinatelecom.cn>
---
 net/mptcp/protocol.h | 2 ++
 net/mptcp/subflow.c  | 2 +-
 net/mptcp/token.c    | 3 +--
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index abd8e31..d90f45d 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -627,6 +627,8 @@ static inline void mptcp_write_space(struct sock *sk)

 void mptcp_destroy_common(struct mptcp_sock *msk);

+#define MPTCP_TOKEN_MAX_RETRIES	4
+
 void __init mptcp_token_init(void);
 static inline void mptcp_token_init_request(struct request_sock *req)
 {
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 325ea7e..43aee6b 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -162,7 +162,7 @@ static int subflow_check_req(struct request_sock *req,
 	}

 	if (mp_opt.mp_capable && listener->request_mptcp) {
-		int err, retries = 4;
+		int err, retries = MPTCP_TOKEN_MAX_RETRIES;

 		subflow_req->ssn_offset = TCP_SKB_CB(skb)->seq;
 again:
diff --git a/net/mptcp/token.c b/net/mptcp/token.c
index 72a24e6..a98e554 100644
--- a/net/mptcp/token.c
+++ b/net/mptcp/token.c
@@ -33,7 +33,6 @@
 #include <net/mptcp.h>
 #include "protocol.h"

-#define TOKEN_MAX_RETRIES	4
 #define TOKEN_MAX_CHAIN_LEN	4

 struct token_bucket {
@@ -153,7 +152,7 @@ int mptcp_token_new_connect(struct sock *sk)
 {
 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(sk);
 	struct mptcp_sock *msk = mptcp_sk(subflow->conn);
-	int retries = TOKEN_MAX_RETRIES;
+	int retries = MPTCP_TOKEN_MAX_RETRIES;
 	struct token_bucket *bucket;

 again:
-- 
1.8.3.1

