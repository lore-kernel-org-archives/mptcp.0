Received: from chinatelecom.cn (prt-mail.chinatelecom.cn [42.123.76.220])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0F9670
	for <mptcp@lists.linux.dev>; Thu,  1 Apr 2021 06:45:19 +0000 (UTC)
HMM_SOURCE_IP:172.18.8.23:60600.343737735
HMM_ATTACHE_NUM:0000
HMM_SOURCE_TYPE:SMTP
Received: from clientip-36.111.140.9?logid-54d39e1ed3d7438aba7e37abb794d748 (unknown [172.18.8.23])
	by chinatelecom.cn (HERMES) with SMTP id 361C32800AA;
	Thu,  1 Apr 2021 14:35:31 +0800 (CST)
X-189-SAVE-TO-SEND: +liyonglong@chinatelecom.cn
Received: from  ([172.18.0.35])
	by filter001 with ESMTP id 54d39e1ed3d7438aba7e37abb794d748 for mptcp@lists.linux.dev;
	Thu Apr  1 14:35:45 2021
X-Transaction-ID: 54d39e1ed3d7438aba7e37abb794d748
X-filter-score:  filter<0>
X-Real-From: liyonglong@chinatelecom.cn
X-Receive-IP: 172.18.0.35
X-MEDUSA-Status: 0
Sender: liyonglong@chinatelecom.cn
From: Yonglong Li <liyonglong@chinatelecom.cn>
To: mptcp@lists.linux.dev,
	mptcp@lists.01.org
Cc: mathew.j.martineau@linux.intel.com,
	matthieu.baerts@tessares.net,
	fw@strlen.de,
	pabeni@redhat.com,
	Yonglong Li <liyonglong@chinatelecom.cn>
Subject: [PATCH v2] mptcp: ensure there is unacked data at all subflow
Date: Thu,  1 Apr 2021 14:34:50 +0800
Message-Id: <1617258890-11776-1-git-send-email-liyonglong@chinatelecom.cn>
X-Mailer: git-send-email 1.8.3.1
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

MPTCP-level retransmit may take place if first subflow
without data in its write queue and second subflow is likely to
have unacked data left in its write queue. In this condition data
maybe double retransmited.

Signed-off-by: Yonglong Li <liyonglong@chinatelecom.cn>
---
 net/mptcp/protocol.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 9d7e7e1..66707ab 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2072,6 +2072,7 @@ static struct sock *mptcp_subflow_get_retrans(const struct mptcp_sock *msk)
 {
 	struct mptcp_subflow_context *subflow;
 	struct sock *backup = NULL;
+	struct sock *idle = NULL;
 
 	sock_owned_by_me((const struct sock *)msk);
 
@@ -2097,10 +2098,11 @@ static struct sock *mptcp_subflow_get_retrans(const struct mptcp_sock *msk)
 			continue;
 		}
 
-		return ssk;
+		if (!idle)
+			idle = ssk;
 	}
 
-	return backup;
+	return idle ? : backup;
 }
 
 static void mptcp_dispose_initial_subflow(struct mptcp_sock *msk)
-- 
1.8.3.1

