Received: from m12-15.163.com (m12-15.163.com [220.181.12.15])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69949173
	for <mptcp@lists.linux.dev>; Wed, 16 Jun 2021 10:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id; bh=LtwwSfKH64AUddqgd7
	0rafjih+T5w5SjpqFt6dRKttM=; b=bjOQrCdb+ewvdjEtW3LeRutmfqM/MwB2NV
	gpTGOTVMngjfMoB7vQcw3zmoqGAsFOiLipY9Ix4Op4DwK0og1+94qHL67CjNB/tO
	gU9TR7b+wgOuvv2YRK1aGdSMCAAZfOyWcqCYFtQUWZJ/oAEdXD8RACKQHNrvRIez
	wkF/tIEC8=
Received: from localhost.localdomain (unknown [36.111.140.26])
	by smtp11 (Coremail) with SMTP id D8CowAB33vY718lgxTs1AA--.106S4;
	Wed, 16 Jun 2021 18:50:33 +0800 (CST)
From: wujianguo106@163.com
To: mptcp@lists.linux.dev
Cc: pabeni@redhat.com,
	fw@strlen.de
Subject: [PATCH v5 2/4] mptcp: remove redundant req destruct in subflow_check_req()
Date: Wed, 16 Jun 2021 18:49:28 +0800
Message-Id: <1623840570-42004-3-git-send-email-wujianguo106@163.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1623840570-42004-1-git-send-email-wujianguo106@163.com>
References: <1623840570-42004-1-git-send-email-wujianguo106@163.com>
X-CM-TRANSID:D8CowAB33vY718lgxTs1AA--.106S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7Cr4Dtw47WFWrtryktF4ktFb_yoW8GrWfpr
	sxXw1YyrZxZFyakF4rJF4DZrn0gayFvFn5GFyY93sxJr4qqws3KF1UWF48uFy3Aan7Kay7
	GFsxtFnxX3ZF9aUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j6PfdUUUUU=
X-Originating-IP: [36.111.140.26]
X-CM-SenderInfo: 5zxmxt5qjx0iiqw6il2tof0z/xtbB+AmzkF2MZRlTUQABs8
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

