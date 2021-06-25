Received: from m12-18.163.com (m12-18.163.com [220.181.12.18])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B23A2FB2
	for <mptcp@lists.linux.dev>; Fri, 25 Jun 2021 08:26:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id; bh=oVwxxQqg9LgPACKg5H
	RT/dVdDa8LWQi6BWHlU87hNPY=; b=iKWNZQUWok8WwiRZGr1aWdZWznwSIb1EDk
	ln+UaeQnqP00Ee2W37XI9W2sXAXJQR8a3x0mq+3er97am4EbCiOalXA5Jumh7B/m
	Ms4CpiaSIX0pcWOrc8brIq/Q7kkxI0t23/bVWM8f1Ptz44XumYSH+/01YipEv3aV
	+8BYOaQ70=
Received: from localhost.localdomain (unknown [36.111.140.26])
	by smtp14 (Coremail) with SMTP id EsCowAAnK+MXk9VgPJySrQ--.35196S4;
	Fri, 25 Jun 2021 16:26:04 +0800 (CST)
From: wujianguo106@163.com
To: mptcp@lists.linux.dev
Cc: pabeni@redhat.com,
	mathew.j.martineau@linux.intel.com
Subject: [PATCH mptcp-net v7 2/5] mptcp: remove redundant req destruct in subflow_check_req()
Date: Fri, 25 Jun 2021 16:25:56 +0800
Message-Id: <1624609559-6786-3-git-send-email-wujianguo106@163.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1624609559-6786-1-git-send-email-wujianguo106@163.com>
References: <1624609559-6786-1-git-send-email-wujianguo106@163.com>
X-CM-TRANSID:EsCowAAnK+MXk9VgPJySrQ--.35196S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7Cr4Dtw47WFWrtryktF4ktFb_yoW8Gryfpr
	sxXw1FyrZxZFyakF4rJr4DZrn0gayFvFn5GFyY9asxJr4qqws3KF1UWr4UuFy3Aa1kKay7
	GF43tFnxX3Wq9aUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jSsjbUUUUU=
X-Originating-IP: [36.111.140.26]
X-CM-SenderInfo: 5zxmxt5qjx0iiqw6il2tof0z/xtbB+AS8kF2MZYKzTgAAsb
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
index 0b5d4a3..3a849fb 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -214,11 +214,6 @@ static int subflow_check_req(struct request_sock *req,
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


