Received: from smtp-fw-9105.amazon.com (smtp-fw-9105.amazon.com [207.171.188.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EE3E2452C
	for <mptcp@lists.linux.dev>; Wed,  9 Aug 2023 22:59:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1691621977; x=1723157977;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=RyuI2BMZUzAh7hCpj+khG0s4VEHQfqKZkLnllwgYkW4=;
  b=cXbh/zp9MKlkyUR/GhCOpkL+raT8m+YLFROKZyWWjamxzjVvbBMoKIOi
   dXSGm523N0/hVK6SEEOquKlGcIqM1WHkfbr4eE8+AQJP8kDgV31Mz39fA
   sdZ/2rz7hFnIO/XTEOy4Txd16wxGRb8wBAzDtaLZ2ryNT/xrCW9EAdvfI
   g=;
X-IronPort-AV: E=Sophos;i="6.01,160,1684800000"; 
   d="scan'208";a="665491557"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-pdx-2b-m6i4x-f323d91c.us-west-2.amazon.com) ([10.25.36.214])
  by smtp-border-fw-9105.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2023 22:59:31 +0000
Received: from EX19MTAUWA002.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
	by email-inbound-relay-pdx-2b-m6i4x-f323d91c.us-west-2.amazon.com (Postfix) with ESMTPS id 171BD40DB6;
	Wed,  9 Aug 2023 22:59:31 +0000 (UTC)
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Wed, 9 Aug 2023 22:59:30 +0000
Received: from 88665a182662.ant.amazon.com (10.106.100.32) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Wed, 9 Aug 2023 22:59:28 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>, Mat Martineau
	<martineau@kernel.org>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <mptcp@lists.linux.dev>, <netdev@vger.kernel.org>
Subject: [PATCH v1 mptcp-next] mptcp: Remove unnecessary test for __mptcp_init_sock().
Date: Wed, 9 Aug 2023 15:59:18 -0700
Message-ID: <20230809225918.21523-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.106.100.32]
X-ClientProxiedBy: EX19D032UWB002.ant.amazon.com (10.13.139.190) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk

__mptcp_init_sock() always returns 0 because mptcp_init_sock() used
to return the value directly.

But after commit 18b683bff89d ("mptcp: queue data for mptcp level
retransmission"), __mptcp_init_sock() need not return value anymore.

Let's remove the unnecessary test for __mptcp_init_sock() and make
it return void.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/mptcp/protocol.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 65ee949a8a44..ddafb095fc3d 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2662,7 +2662,7 @@ static void mptcp_worker(struct work_struct *work)
 	sock_put(sk);
 }
 
-static int __mptcp_init_sock(struct sock *sk)
+static void __mptcp_init_sock(struct sock *sk)
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
 
@@ -2689,8 +2689,6 @@ static int __mptcp_init_sock(struct sock *sk)
 	/* re-use the csk retrans timer for MPTCP-level retrans */
 	timer_setup(&msk->sk.icsk_retransmit_timer, mptcp_retransmit_timer, 0);
 	timer_setup(&sk->sk_timer, mptcp_timeout_timer, 0);
-
-	return 0;
 }
 
 static void mptcp_ca_reset(struct sock *sk)
@@ -2708,11 +2706,8 @@ static void mptcp_ca_reset(struct sock *sk)
 static int mptcp_init_sock(struct sock *sk)
 {
 	struct net *net = sock_net(sk);
-	int ret;
 
-	ret = __mptcp_init_sock(sk);
-	if (ret)
-		return ret;
+	__mptcp_init_sock(sk);
 
 	if (!mptcp_is_enabled(net))
 		return -ENOPROTOOPT;
-- 
2.30.2

