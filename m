Received: from m12-17.163.com (m12-17.163.com [220.181.12.17])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AD832F9B
	for <mptcp@lists.linux.dev>; Wed, 21 Apr 2021 07:52:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Message-ID:Date:MIME-Version; bh=nQ5Fl
	f7DA3Uiuxyxi8HWyJP5mE6zjSPU95yfianwVVs=; b=YVvN+MKKD8uf89kd6nmow
	SyrH5EtEYz5CKJdh/N9x0BSoX8Zx4S9wIkPYRQZIbVyFxP8VRQDgZ7EMHAXV9+Fk
	bFTJ+yx11t+rMtkTQhqMPoLU/iiT7nulra2B4KLLNNx5JsqfbvDRh5r4Wj+ibGuT
	ECXPASoXhAhS2omwOgTReI=
Received: from [192.168.15.51] (unknown [120.36.226.89])
	by smtp13 (Coremail) with SMTP id EcCowACHRk711X9gXahcwg--.22147S2;
	Wed, 21 Apr 2021 15:36:22 +0800 (CST)
To: mptcp@lists.linux.dev
Cc: Florian Westphal <fw@strlen.de>,
 Mat Martineau <mathew.j.martineau@linux.intel.com>,
 matthieu.baerts@tessares.net, pabeni@redhat.com
From: Jianguo Wu <wujianguo106@163.com>
Subject: [PATCH] mptcp: using TOKEN_MAX_RETRIES instead of magic number
Message-ID: <8f1cc82d-a4a1-ef5e-0430-8e3632e378d0@163.com>
Date: Wed, 21 Apr 2021 15:36:21 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:EcCowACHRk711X9gXahcwg--.22147S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Ww4fKw1UCw18uw1ftr43KFg_yoW8XF4UpF
	sxuay5XrWSqFZrJa1xJF4rWr17W3Z8GrZ0k3yY9wn3trs0qw1DWa4rKr45GrW7GF4ktFnx
	XFZFvwn8XanruaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07b3JP_UUUUU=
X-Originating-IP: [120.36.226.89]
X-CM-SenderInfo: 5zxmxt5qjx0iiqw6il2tof0z/1tbiJxZ7kF5u+EffaQAAsj

From: Jianguo Wu <wujianguo@chinatelecom.cn>

We have macro TOKEN_MAX_RETRIES for the number of token generate retries,
so using TOKEN_MAX_RETRIES in subflow_check_req().

Fixes: 535fb8152f31 ("mptcp: token: move retry to caller")
Signed-off-by: Jianguo Wu <wujianguo@chinatelecom.cn>
---
 net/mptcp/protocol.h | 2 ++
 net/mptcp/subflow.c  | 2 +-
 net/mptcp/token.c    | 1 -
 3 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index abd8e31..88f1e2b 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -14,6 +14,8 @@

 #define MPTCP_SUPPORTED_VERSION	1

+#define TOKEN_MAX_RETRIES	4
+
 /* MPTCP option bits */
 #define OPTION_MPTCP_MPC_SYN	BIT(0)
 #define OPTION_MPTCP_MPC_SYNACK	BIT(1)
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 325ea7e..977a848 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -162,7 +162,7 @@ static int subflow_check_req(struct request_sock *req,
 	}

 	if (mp_opt.mp_capable && listener->request_mptcp) {
-		int err, retries = 4;
+		int err, retries = TOKEN_MAX_RETRIES;

 		subflow_req->ssn_offset = TCP_SKB_CB(skb)->seq;
 again:
diff --git a/net/mptcp/token.c b/net/mptcp/token.c
index 72a24e6..555c962 100644
--- a/net/mptcp/token.c
+++ b/net/mptcp/token.c
@@ -33,7 +33,6 @@
 #include <net/mptcp.h>
 #include "protocol.h"

-#define TOKEN_MAX_RETRIES	4
 #define TOKEN_MAX_CHAIN_LEN	4

 struct token_bucket {
-- 
1.8.3.1

