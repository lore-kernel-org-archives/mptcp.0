Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35E7F3BBA09
	for <mptcp@lists.linux.dev>; Thu, 19 Mar 2026 10:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773917899; cv=none; b=GivTI6Ihj7WImy2ay6SHqWNlG6VRXkKdC9IzcSmgCIcWIz7Y5hNmZtWzIKjuxQYLTDUwEJ8OsDP5eSwBhHwgqD+C7ykc1bbreZfgstGPjUsJSRYxPZEV/e8V5nbReF9P4H+BE2jK9unnmlnG8+FadKMrDk2pxe+Apwya6zWt3NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773917899; c=relaxed/simple;
	bh=BWZlB5ieElyQI8GNk8aRWuD6EskIKpAd7O0l6vbF1mE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dnqHlxGMwQN+FMueKFLl3dlNGj6vKVjtc3AzGHjt2IVjVmk0C8dXr2ACXIvFUPs6dgJU9HwbBjFp48t4Io22BMnaNpLGSkNOC5dVYXAV9wn2zlJ8zKqr/pknwrPWnNjxUI6nYaj/TBFPaVTXiWHHzyGnHLjg5X6/NIHiRyYs7Vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=TnzHBWPW; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=TnzHBWPW; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="TnzHBWPW";
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="TnzHBWPW"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=kyEMUQBF2YL05LT+fM2EoA0A+YLnbqzjV4JFMXehIJw=;
	b=TnzHBWPWddCUqhflGb0WRJZADh34kg0JarGUMDH10Kk2rFedQH/xjY9Qn8ZxZiuceN3DqNDIu
	YM0nn3OJ6nNug8RoIr1orLcR2zq46MIqaRWUZX0za3dfYnb3FyQ6l/ZzIyRoKnPthXs7sFgqyhk
	7WQJkth5sFJn3Q1gLk4IfRk=
Received: from canpmsgout03.his.huawei.com (unknown [172.19.92.159])
	by szxga01-in.huawei.com (SkyGuard) with ESMTPS id 4fc2hY5Mqsz1BFRg
	for <mptcp@lists.linux.dev>; Thu, 19 Mar 2026 18:57:17 +0800 (CST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=kyEMUQBF2YL05LT+fM2EoA0A+YLnbqzjV4JFMXehIJw=;
	b=TnzHBWPWddCUqhflGb0WRJZADh34kg0JarGUMDH10Kk2rFedQH/xjY9Qn8ZxZiuceN3DqNDIu
	YM0nn3OJ6nNug8RoIr1orLcR2zq46MIqaRWUZX0za3dfYnb3FyQ6l/ZzIyRoKnPthXs7sFgqyhk
	7WQJkth5sFJn3Q1gLk4IfRk=
Received: from mail.maildlp.com (unknown [172.19.162.197])
	by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4fc2b90vT3zpSvC;
	Thu, 19 Mar 2026 18:52:37 +0800 (CST)
Received: from kwepemj500018.china.huawei.com (unknown [7.202.194.48])
	by mail.maildlp.com (Postfix) with ESMTPS id A0E4840569;
	Thu, 19 Mar 2026 18:58:02 +0800 (CST)
Received: from huawei.com (10.50.85.128) by kwepemj500018.china.huawei.com
 (7.202.194.48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 19 Mar
 2026 18:58:01 +0800
From: Li Xiasong <lixiasong1@huawei.com>
To: Matthieu Baerts <matttbe@kernel.org>, Mat Martineau
	<martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>
CC: <netdev@vger.kernel.org>, <mptcp@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <yuehaibing@huawei.com>,
	<zhangchangzhong@huawei.com>, <weiyongjun1@huawei.com>
Subject: [PATCH net] MPTCP: fix lock class name family in pm_nl_create_listen_socket
Date: Thu, 19 Mar 2026 19:21:59 +0800
Message-ID: <20260319112159.3118874-1-lixiasong1@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemj500018.china.huawei.com (7.202.194.48)

In mptcp_pm_nl_create_listen_socket(), use entry->addr.family
instead of sk->sk_family for lock class setup. The 'sk' parameter
is a netlink socket, not the MPTCP subflow socket being created.

Fixes: cee4034a3db1 ("mptcp: fix lockdep false positive in mptcp_pm_nl_create_listen_socket()")
Signed-off-by: Li Xiasong <lixiasong1@huawei.com>
---
 net/mptcp/pm_kernel.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
index b2b9df43960e..82e59f9c6dd9 100644
--- a/net/mptcp/pm_kernel.c
+++ b/net/mptcp/pm_kernel.c
@@ -838,7 +838,7 @@ static struct lock_class_key mptcp_keys[2];
 static int mptcp_pm_nl_create_listen_socket(struct sock *sk,
 					    struct mptcp_pm_addr_entry *entry)
 {
-	bool is_ipv6 = sk->sk_family == AF_INET6;
+	bool is_ipv6 = entry->addr.family == AF_INET6;
 	int addrlen = sizeof(struct sockaddr_in);
 	struct sockaddr_storage addr;
 	struct sock *newsk, *ssk;
-- 
2.34.1

