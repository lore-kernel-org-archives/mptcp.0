Received: from chinatelecom.cn (prt-mail.chinatelecom.cn [42.123.76.223])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2B4D6F
	for <mptcp@lists.linux.dev>; Wed, 31 Mar 2021 09:06:05 +0000 (UTC)
HMM_SOURCE_IP:172.18.8.23:46646.1704381463
HMM_ATTACHE_NUM:0000
HMM_SOURCE_TYPE:SMTP
Received: from clientip-36.111.140.9?logid-922acda26c344908bb2d98ea6f97fad9 (unknown [172.18.8.23])
	by chinatelecom.cn (HERMES) with SMTP id E12622800B4;
	Wed, 31 Mar 2021 16:57:27 +0800 (CST)
X-189-SAVE-TO-SEND: +liyonglong@chinatelecom.cn
Received: from  ([172.18.0.35])
	by filter001 with ESMTP id 922acda26c344908bb2d98ea6f97fad9 for mptcp@lists.linux.dev;
	Wed Mar 31 16:57:35 2021
X-Transaction-ID: 922acda26c344908bb2d98ea6f97fad9
X-filter-score:  filter<0>
X-Real-From: liyonglong@chinatelecom.cn
X-Receive-IP: 172.18.0.35
X-MEDUSA-Status: 0
Sender: liyonglong@chinatelecom.cn
From: lyl <liyonglong@chinatelecom.cn>
To: mptcp@lists.linux.dev,
	mptcp@lists.01.org
Cc: mathew.j.martineau@linux.intel.com,
	matthieu.baerts@tessares.net,
	fw@strlen.de,
	pabeni@redhat.com,
	lyl <liyonglong@chinatelecom.cn>
Subject: [PATCH] mptcp: ensure there is unacked data at all subflow
Date: Wed, 31 Mar 2021 16:57:18 +0800
Message-Id: <1617181038-185283-1-git-send-email-liyonglong@chinatelecom.cn>
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

Signed-off-by: lyl <liyonglong@chinatelecom.cn>
---
 net/mptcp/protocol.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 9d7e7e1..40a6703 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2072,6 +2072,7 @@ static struct sock *mptcp_subflow_get_retrans(const struct mptcp_sock *msk)
 {
 	struct mptcp_subflow_context *subflow;
 	struct sock *backup = NULL;
+	struct sock *idle = NULL;
 
 	sock_owned_by_me((const struct sock *)msk);
 
@@ -2097,10 +2098,10 @@ static struct sock *mptcp_subflow_get_retrans(const struct mptcp_sock *msk)
 			continue;
 		}
 
-		return ssk;
+		idle = ssk;
 	}
 
-	return backup;
+	return idle ? : backup;
 }
 
 static void mptcp_dispose_initial_subflow(struct mptcp_sock *msk)
-- 
1.8.3.1

