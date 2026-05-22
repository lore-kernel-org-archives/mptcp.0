Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CED5C23395F
	for <mptcp@lists.linux.dev>; Fri, 22 May 2026 02:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779418145; cv=none; b=XN7zSNyp93iLxJwN+TiGB48ZcVFodU9QX+K9l781P2WD5gF3V+V5hVEjcsKgjJc9vkuEW9NuYPAPE0QdeWDkmGv+WLAg/OWOCrwG/xBrFWu6DOvZ0isT+xOnfVXN5MxY6CfmRNeVWdjhHxrh/M3JSdsnEfBBR36+DaE3N/MQGmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779418145; c=relaxed/simple;
	bh=De+OrxRj+YZV/A+zrsE1Ri6V568Fp5NN5qxZKsjNlas=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vCV+qdDZth8Aq55/ZyWWT5kG7vBrUr+DI7rEPahekPCoJU/Muy8YXJw/GkPIudWIH6cu+2LwnvJLPpS2l6pJm5XDTJ8NwoWoNWXMPI5RBJfairTFM4VkRImAwDBbOM1Fj7fYC+41LqkqgrbotTifJbOdSoNHE0l1zinIoOr/OEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UqCm/oRe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UqCm/oRe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5E9A1F000E9;
	Fri, 22 May 2026 02:49:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779418144;
	bh=Lhx8GllVG4InKsHTGUuMhdm/QTZ9D7Bdrm3S8Mtjq1M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UqCm/oRea5zsNdQLtna98IPvKzhvAfGOMfmAXgTylimWEsdpeYrgDnWcP7KQyQ398
	 GEouK3t0ianpMXjmq0kORRzEuXu7YwIGRlsNiRhiIYye70BHz9v2MgcWiOqMmYnQtM
	 oVUU7HwFDF81fUD2GYuj4xUXF8uKqMb98qLoHyFBdaOIBmc2LgEpOuouMXX20oCJyT
	 PKXcLRcMBxUpy7TGjb16BwQG1DiqYQkexcf4vzYR5BfnmxInHNPtqGwqhnHQNUByC/
	 7BmnC3eoL7wkp1dphwdePmY/I6kbnRGd6n+PtUmCdKWEq3tOfEuHg7qTbceQgXyN5H
	 ncSsroO3aEePA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Hannes Reinecke <hare@suse.de>,
	zhenwei pi <zhenwei.pi@linux.dev>,
	Hui Zhu <zhuhui@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next v16 12/12] nvme-tcp: use netdev_name_in_use for host_iface validation
Date: Fri, 22 May 2026 10:48:10 +0800
Message-ID: <191789c3365a98fa27ec2e534f4a0d6a1834425d.1779416980.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1779416980.git.tanggeliang@kylinos.cn>
References: <cover.1779416980.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

When the host_iface option is specified, nvme_tcp_alloc_ctrl() uses
__dev_get_by_name(&init_net, opts->host_iface) to validate the interface.
This has two issues: it hardcodes init_net instead of using the caller's
network namespace, and it lacks RCU protection required by __dev_get_by_name().

Fix by using netdev_name_in_use() with current->nsproxy->net_ns, which
handles both namespace correctness and locking internally.

Cc: Hannes Reinecke <hare@suse.de>
Cc: zhenwei pi <zhenwei.pi@linux.dev>
Cc: Hui Zhu <zhuhui@kylinos.cn>
Cc: Gang Yan <yangang@kylinos.cn>
Fixes: 8b43ced64d2b ("nvme-tcp: use __dev_get_by_name instead dev_get_by_name for OPT_HOST_IFACE")
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 drivers/nvme/host/tcp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 2388a8c443cc..b3ca1ba06641 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -3004,7 +3004,8 @@ static struct nvme_tcp_ctrl *nvme_tcp_alloc_ctrl(struct device *dev,
 	}
 
 	if (opts->mask & NVMF_OPT_HOST_IFACE) {
-		if (!__dev_get_by_name(&init_net, opts->host_iface)) {
+		if (netdev_name_in_use(current->nsproxy->net_ns,
+				       opts->host_iface)) {
 			pr_err("invalid interface passed: %s\n",
 			       opts->host_iface);
 			ret = -ENODEV;
-- 
2.53.0

