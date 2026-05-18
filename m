Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 466FC3C76A0
	for <mptcp@lists.linux.dev>; Mon, 18 May 2026 07:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779087730; cv=none; b=fikEHUzFFusl5n/DpXWOJNDmavF9UmbkBNOvsJRfF3bx+DX6yPMG2+J3JthPIlnuPlrdw70VvaahBGpImI+5XAMhSc+soOk1kvggw8mAZsoQkjR7XKof6hV0U4ICU60mtt50/ioCLSsWyhT3po8X9nAa5MmDFuoPVCTrhJtUnlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779087730; c=relaxed/simple;
	bh=luxA/o3wJAhLv3r13hvUhK0hRhdT9n4Zba7jE298N5s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hrBMFkb9e3+Pq7DRZdigchb6yrmtpv0eQMCnDMFxgBnOtjDuyDlKaevp0217JABzavMMZONO8EfXOCVobGRrpfBYJWOGKpXE5FCfwAwmQigQEVdx68W9sostaCGA0QXUtZz4r3PH86dBlJy2p6o1YbG/C+XT83Yimk3QAwJ1Z6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B39hYLFg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B39hYLFg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F144C2BCB7;
	Mon, 18 May 2026 07:02:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779087729;
	bh=luxA/o3wJAhLv3r13hvUhK0hRhdT9n4Zba7jE298N5s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=B39hYLFgi48QKb5ovuD6PxgYZQ/nQml+mUqR0YSSv/PKg/BHiS6CoIgadG/UJ5d4J
	 LwHzGBTsj5QslC00Eqr/7pc8ZL6XQkXc1N/9fx632SAUVPUdYoceuyNpvm0lKvXpLn
	 8/YlOR/QVklWFhnJVHwapUdPDAepbyY+vRBd2jc5OWKeWWTAf0IlkFhkQgDFwM7qY2
	 mM04T7bWNQoJPpO7tfbAflk5lxETrF9mzaXsjo6YQQyIgRLVDRaBTFGf+v8QRMZR6x
	 IPlEr9ceIQqI3SgmIbExJOsqFsXgaxcLGdrVIkkd+MPZdcQat3pdg56tmtTYRcVaJb
	 dVPNPgXCPmwGA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Hannes Reinecke <hare@suse.de>,
	zhenwei pi <zhenwei.pi@linux.dev>,
	Hui Zhu <zhuhui@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next v12 11/11] nvme-tcp: add RCU protection for host_iface validation
Date: Mon, 18 May 2026 15:01:30 +0800
Message-ID: <b32bf6743493ecc45f3af79b4f1fa6caf9f5042b.1779087443.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1779087443.git.tanggeliang@kylinos.cn>
References: <cover.1779087443.git.tanggeliang@kylinos.cn>
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
 drivers/nvme/host/tcp.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 8816e98f4282..08ba99f1a3a8 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -11,6 +11,7 @@
 #include <linux/crc32.h>
 #include <linux/nvme-tcp.h>
 #include <linux/nvme-keyring.h>
+#include <linux/rcupdate.h>
 #include <net/sock.h>
 #include <net/tcp.h>
 #include <net/tls.h>
@@ -3004,12 +3005,15 @@ static struct nvme_tcp_ctrl *nvme_tcp_alloc_ctrl(struct device *dev,
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

