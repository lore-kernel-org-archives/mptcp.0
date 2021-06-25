Received: from m12-17.163.com (m12-17.163.com [220.181.12.17])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A6B32FB3
	for <mptcp@lists.linux.dev>; Fri, 25 Jun 2021 03:04:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id; bh=LtwwSfKH64AUddqgd7
	0rafjih+T5w5SjpqFt6dRKttM=; b=SbAZgQfK6qQc8svC2QdDh8BNeYftGeN5W6
	jxTyfOIwYzthKu7zvN0x7lPPnnxHGlHDdpC3qTnCbJGPovwvNk16gMF9CixXFg6G
	aA7zQVkMgxxxmOMHA9tlakA+56VAE5+iXsfq/AEtkrVumtPH61CUzSNYtOCZ/voC
	v7gqagKAg=
Received: from localhost.localdomain (unknown [36.111.140.26])
	by smtp13 (Coremail) with SMTP id EcCowACntjoSRNVg6_a69Q--.41874S4;
	Fri, 25 Jun 2021 10:48:54 +0800 (CST)
From: wujianguo106@163.com
To: mptcp@lists.linux.dev
Cc: pabeni@redhat.com,
	mathew.j.martineau@linux.intel.com
Subject: [PATCH mptcp-net v6 2/5] mptcp: remove redundant req destruct in subflow_check_req()
Date: Fri, 25 Jun 2021 10:48:47 +0800
Message-Id: <1624589330-2579-3-git-send-email-wujianguo106@163.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1624589330-2579-1-git-send-email-wujianguo106@163.com>
References: <1624589330-2579-1-git-send-email-wujianguo106@163.com>
X-CM-TRANSID:EcCowACntjoSRNVg6_a69Q--.41874S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7Cr4Dtw47WFWrtryktF4ktFb_yoW8GrWfpr
	sxXw1YyrZxZFyakF4rJF4DZrn0gayFvFn5GFyY93sxJr4qqws3KF1UWF48uFy3Aan7Kay7
	GFsxtFnxX3ZF9aUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j3l19UUUUU=
X-Originating-IP: [36.111.140.26]
X-CM-SenderInfo: 5zxmxt5qjx0iiqw6il2tof0z/xtbB+Aa8kF2MZX7gtwAAsP
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>

From: Jianguo Wu <wujianguo@chinatelecom.cn>

In subflow_check_req(), if subflow sport is mismatch, will put msk,
destroy token, and destruct req, then return -EPERM, which can be
done by subflow_req_destructor() via:
  tcp_conn_request()
    |--__reqsk_free()
      |--subflow_req_destructor()
So we should remove these redundant code, otherwise will call
tcp_v4_reqsk_destructor() twice, and may double free inet_rsk(req)->ireq_opt.

Fixes: 5bc56388c74f ("mptcp: add port number check for MP_JOIN")
Signed-off-by: Jianguo Wu <wujianguo@chinatelecom.cn>
---
 net/mptcp/subflow.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 6b1cd4257edf..75ed530706c0 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -213,11 +213,6 @@ static int subflow_check_req(struct request_sock *req,
 				 ntohs(inet_sk(sk_listener)->inet_sport),
 				 ntohs(inet_sk((struct sock *)subflow_req->msk)->inet_sport));
 			if (!mptcp_pm_sport_in_anno_list(subflow_req->msk, sk_listener)) {
-				sock_put((struct sock *)subflow_req->msk);
-				mptcp_token_destroy_request(req);
-				tcp_request_sock_ops.destructor(req);
-				subflow_req->msk = NULL;
-				subflow_req->mp_join = 0;
 				SUBFLOW_REQ_INC_STATS(req, MPTCP_MIB_MISMATCHPORTSYNRX);
 				return -EPERM;
 			}
-- 
1.8.3.1


