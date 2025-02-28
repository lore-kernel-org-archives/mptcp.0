Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B7882571A9
	for <mptcp@lists.linux.dev>; Fri, 28 Feb 2025 09:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740735629; cv=none; b=B2sATnr6lJc7UEJsLID8+C2fpOWXspd/uAh8t+g4NSunkNB4EH9d2OzwRuB8MMkluRQ0R1TT4L0Zdb+SA+1feczXXDWcoJU4hRs6Ukl9G93p/Ska0Dib2RsczoAY5CpgwIW1nqObt8lrHhWX3a7YwfSkWIZBwSdAjevclRvEmWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740735629; c=relaxed/simple;
	bh=TXS83j3sidAU5F7wfqIv04eKJOdCNNgLmo42LlF5t5Q=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LmLkW4jvqSCAsS2y4s+4Pb8ziYDSQX0E4qYulBgcaqreusPMlJfzFe9ULznrW1ylhk3y8Wwx13Ha2HysG0opAPNsgfDlhBlivMoDV8uUODM/unUdGCtkYgI5c3A79vV8pouC1TZIjOwhp2dEcnyXaPS7FBP+a/85pG+ZRzdaRl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Z437D65t8z1R5ss;
	Fri, 28 Feb 2025 17:38:48 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
	by mail.maildlp.com (Postfix) with ESMTPS id AAA061A016C;
	Fri, 28 Feb 2025 17:40:24 +0800 (CST)
Received: from huawei.com (10.175.101.6) by dggpemf500002.china.huawei.com
 (7.185.36.57) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 28 Feb
 2025 17:40:24 +0800
From: Yue Haibing <yuehaibing@huawei.com>
To: <matttbe@kernel.org>, <martineau@kernel.org>, <geliang@kernel.org>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>
CC: <netdev@vger.kernel.org>, <mptcp@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <yuehaibing@huawei.com>
Subject: [PATCH net-next] mptcp: Remove unused declaration mptcp_set_owner_r()
Date: Fri, 28 Feb 2025 17:51:48 +0800
Message-ID: <20250228095148.4003065-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemf500002.china.huawei.com (7.185.36.57)

Commit 6639498ed85f ("mptcp: cleanup mem accounting")
removed the implementation but leave declaration.

Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
---
 net/mptcp/protocol.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 256677c43ca6..bd2992776d8a 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -720,7 +720,6 @@ struct sock *__mptcp_nmpc_sk(struct mptcp_sock *msk);
 bool __mptcp_close(struct sock *sk, long timeout);
 void mptcp_cancel_work(struct sock *sk);
 void __mptcp_unaccepted_force_close(struct sock *sk);
-void mptcp_set_owner_r(struct sk_buff *skb, struct sock *sk);
 void mptcp_set_state(struct sock *sk, int state);
 
 bool mptcp_addresses_equal(const struct mptcp_addr_info *a,
-- 
2.34.1

