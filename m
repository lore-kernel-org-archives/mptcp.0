Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC14C30DD2F
	for <mptcp@lists.linux.dev>; Sun, 17 May 2026 06:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778997979; cv=none; b=fqDaeDqhPtuh+IjKmzbebo8UXiHaE1OiT3+Gsbg68bppQQbW8Lq5WzPMZevJI/17VhhGxNB/VQ1KuecV0PvKCODtBaTrDr2U0qA8nGkzsTGMwgwTMnyFnSnl4WK0SQeDbDpROQSkuiIpon9EOXHKJ/faxTEXhW2nnlMoRIFWv24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778997979; c=relaxed/simple;
	bh=0/1qDpnrEASKTyamgrZq3hiktwpNCegwlvl5LllEwVY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y66W2iBO73Q+8Y7ezP+APBGrrKtaOUq7qIv0pz+M4uUDTR1gCawz4WFv/WWTvB5oFCHQSsbTj7tKbSBZhcVDTy9nPjC6rxu8O9673RabFaM1/RKhK2VeK9TLA/STNe5BPREbLP5Ng5bjqiRPHkG3KDVbauX/mf9NyD4GXW2JBnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AOnh59CI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AOnh59CI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20A7BC2BCB3;
	Sun, 17 May 2026 06:06:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778997978;
	bh=0/1qDpnrEASKTyamgrZq3hiktwpNCegwlvl5LllEwVY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AOnh59CILpr7Akcfzk7nJz0jMoqtBZq0Zxn9zWjQ+XwMX/Mwtw7UbgcWa6FfgfbP/
	 c0+pXRNX0rCD1bFZV2nUPJt10R0Yp7HWqdcuoqOiBf1nLZlYXEjorPvCuZ2nQQ3KaN
	 b2+DTWa73/QAEN0VL5ZQC6eckvk4WYDBtlTHpfDxUzyANo+yZAFUFuJ8lftswIbRt6
	 4Ma6Cvu/JBbXgdKAoAdCl5IzEp9iAEblNZGStOCY8PQw32pTWGhNPJ+ZOCRsaKwXpW
	 YeyNS0nS9hKtfLcJJpi8iF32oAdqMDS/0uukU6Fi6HYBOFb4el2NO+XAaxClTXeTPv
	 PyoKmuByUYmzQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Hannes Reinecke <hare@suse.de>,
	zhenwei pi <zhenwei.pi@linux.dev>,
	Hui Zhu <zhuhui@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next v11 02/10] nvme-tcp: add RCU protection for host_iface validation
Date: Sun, 17 May 2026 14:05:06 +0800
Message-ID: <b5eb56ba1d08892243c307ca6c52bc5ba120cab8.1778997507.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1778997507.git.tanggeliang@kylinos.cn>
References: <cover.1778997507.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

When the host_iface option is specified, nvme_tcp_alloc_ctrl() calls
__dev_get_by_name() to validate the network interface exists. However,
__dev_get_by_name() requires RCU read lock protection as it traverses
the RCU-protected device hash table.

Without RCU read lock, the thread can be preempted during traversal.
If a concurrent device unregistration occurs, the hash node can be
freed via kfree_rcu() and the RCU grace period could end before the
thread resumes, leading to a use-after-free when the freed memory is
dereferenced.

Fix this by using dev_get_by_name_rcu() instead of __dev_get_by_name()
and wrapping the lookup with rcu_read_lock()/rcu_read_unlock().

Cc: Hannes Reinecke <hare@suse.de>
Cc: zhenwei pi <zhenwei.pi@linux.dev>
Cc: Hui Zhu <zhuhui@kylinos.cn>
Cc: Gang Yan <yangang@kylinos.cn>
Fixes: 3ede8f72a9a2 ("nvme-tcp: allow selecting the network interface for connections")
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 drivers/nvme/host/tcp.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 15d36d6a728e..d1654a630897 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -2951,12 +2951,15 @@ static struct nvme_tcp_ctrl *nvme_tcp_alloc_ctrl(struct device *dev,
 	}
 
 	if (opts->mask & NVMF_OPT_HOST_IFACE) {
-		if (!__dev_get_by_name(&init_net, opts->host_iface)) {
+		rcu_read_lock();
+		if (!dev_get_by_name_rcu(&init_net, opts->host_iface)) {
+			rcu_read_unlock();
 			pr_err("invalid interface passed: %s\n",
 			       opts->host_iface);
 			ret = -ENODEV;
 			goto out_free_ctrl;
 		}
+		rcu_read_unlock();
 	}
 
 	if (!opts->duplicate_connect && nvme_tcp_existing_controller(opts)) {
-- 
2.53.0

