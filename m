Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.221.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDBBA7C
	for <mptcp@lists.linux.dev>; Sat, 22 Oct 2022 07:08:28 +0000 (UTC)
X-QQ-mid: bizesmtp66t1666422335tdg4ve7k
Received: from localhost.localdomain ( [182.148.15.254])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sat, 22 Oct 2022 15:05:33 +0800 (CST)
X-QQ-SSF: 01000000000000C0E000000A0000000
X-QQ-FEAT: RFp2QSjOiS4sGX3HAs81Q2QTczxO4ZkgFMtpFaapn6fA4oCND6P3j/fp47kxt
	291qxxZRtD6dXgOXME4Q55/OSn2dEnfAGHIZVhafF8eBihENSLcXZWgY31Ytvh3y4ZqoWU5
	/5lLxsIYiwDqhrdwI1OiLgYMp6JQRhqfYDGspBZbY0A5/AtzaZVxSZDcMyKimastzpWi65m
	XppZM/NakT3q2vnFNOU+obvh9UmubpNV+17Kv/Wc2CTpuLuvsNdzMtN+nZzuE8jagX9TvsE
	Ltu/klACCgwo7MQhb4VRvnxbcv1StnfAgz2JRyhH6qTciXhSfWMSjbqVrjYURrvg7AOVpVK
	JofZOV8+kJ9UDXgh5ranmpgcRVkO0OCH+i6J9Zix8x8xnioTYFLfjfL67coiw==
X-QQ-GoodBg: 0
From: wangjianli <wangjianli@cdjrlc.com>
To: mathew.j.martineau@linux.intel.com,
	matthieu.baerts@tessares.net,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	mptcp@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	wangjianli <wangjianli@cdjrlc.com>
Subject: [PATCH] net/mptcp: fix repeated words in comments
Date: Sat, 22 Oct 2022 15:05:27 +0800
Message-Id: <20221022070527.55960-1-wangjianli@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr7

Delete the redundant word 'the'.

Signed-off-by: wangjianli <wangjianli@cdjrlc.com>
---
 net/mptcp/token.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mptcp/token.c b/net/mptcp/token.c
index f52ee7b26aed..b817c2564300 100644
--- a/net/mptcp/token.c
+++ b/net/mptcp/token.c
@@ -287,7 +287,7 @@ EXPORT_SYMBOL_GPL(mptcp_token_get_sock);
  * This function returns the first mptcp connection structure found inside the
  * token container starting from the specified position, or NULL.
  *
- * On successful iteration, the iterator is move to the next position and the
+ * On successful iteration, the iterator is move to the next position and
  * the acquires a reference to the returned socket.
  */
 struct mptcp_sock *mptcp_token_iter_next(const struct net *net, long *s_slot,
-- 
2.36.1

