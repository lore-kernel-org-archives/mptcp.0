Received: from m12-11.163.com (m12-11.163.com [220.181.12.11])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC52B71
	for <mptcp@lists.linux.dev>; Tue, 20 Apr 2021 10:24:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Message-ID:Date:MIME-Version; bh=USBQM
	qpmUTNDj9WSUDhMPLaHhV6JFYFlDoKD+byP8Q0=; b=cuqlUQ/usr8n9mj4Vd0SJ
	x8b/P+U8/oNvI3tqyMBGDm39c984LvUp//jIa1/gkruia6fjt4jagkWgI7txH4SR
	5YfoV1PK1GmnCLzcuVmSM5oz+qO2s3yneJ2UxuiBs5Qzz1s8bnDISYi2C5f+oiiH
	TLIB2QL2AdBrZxtMLZ1Ij0=
Received: from [192.168.15.51] (unknown [120.36.226.89])
	by smtp7 (Coremail) with SMTP id C8CowABnY_MtqH5gGhWvYA--.34982S2;
	Tue, 20 Apr 2021 18:08:46 +0800 (CST)
From: Jianguo Wu <wujianguo106@163.com>
Subject: [PATCH] mptcp: fix pr_debug in mptcp_token_new_connect
To: mptcp@lists.linux.dev
Cc: mathew.j.martineau@linux.intel.com, matthieu.baerts@tessares.net,
 Florian Westphal <fw@strlen.de>, pabeni@redhat.com
Message-ID: <5533e6e3-b94b-4fdf-a4b9-a4fcda4ec09e@163.com>
Date: Tue, 20 Apr 2021 18:08:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:C8CowABnY_MtqH5gGhWvYA--.34982S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Ww48Gw1Utw1xur1kuFyfZwb_yoW8Xr4rpr
	4UKr13Gw4rtFyYka1kJrW8urnxW3s5ua43G3Wrua4fArsagrnxGF15KFZa9ry7Wa18t3W3
	JrWav3WDWF1DuaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07b2-B_UUUUU=
X-Originating-IP: [120.36.226.89]
X-CM-SenderInfo: 5zxmxt5qjx0iiqw6il2tof0z/xtbB9xZ6kF2MYlWkswAAs6

From: Jianguo Wu <wujianguo@chinatelecom.cn>

After commit 2c5ebd001d4f ("mptcp: refactor token container"),
pr_debug() is called before mptcp_crypto_key_gen_sha() in
mptcp_token_new_connect(), so the output local_key, token and
idsn are 0, like:
  MPTCP: ssk=00000000f6b3c4a2, local_key=0, token=0, idsn=0

Move pr_debug() after mptcp_crypto_key_gen_sha().

Fixes: 2c5ebd001d4f ("mptcp: refactor token container")
Signed-off-by: Jianguo Wu <wujianguo@chinatelecom.cn>
---
 net/mptcp/token.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/token.c b/net/mptcp/token.c
index 8f0270a..72a24e6 100644
--- a/net/mptcp/token.c
+++ b/net/mptcp/token.c
@@ -156,9 +156,6 @@ int mptcp_token_new_connect(struct sock *sk)
 	int retries = TOKEN_MAX_RETRIES;
 	struct token_bucket *bucket;

-	pr_debug("ssk=%p, local_key=%llu, token=%u, idsn=%llu\n",
-		 sk, subflow->local_key, subflow->token, subflow->idsn);
-
 again:
 	mptcp_crypto_key_gen_sha(&subflow->local_key, &subflow->token,
 				 &subflow->idsn);
@@ -172,6 +169,9 @@ int mptcp_token_new_connect(struct sock *sk)
 		goto again;
 	}

+	pr_debug("ssk=%p, local_key=%llu, token=%u, idsn=%llu\n",
+		 sk, subflow->local_key, subflow->token, subflow->idsn);
+
 	WRITE_ONCE(msk->token, subflow->token);
 	__sk_nulls_add_node_rcu((struct sock *)msk, &bucket->msk_chain);
 	bucket->chain_len++;
-- 
1.8.3.1

