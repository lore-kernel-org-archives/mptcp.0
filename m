Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3AB2405C55
	for <mptcp@lists.linux.dev>; Tue, 19 May 2026 03:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779161136; cv=none; b=kXke788ZKihmBwm6IAcFXwoKZz/pnuEeza91IL9WXcSIPUcHTMAm95lm8TH1sfA5DlBaN+Se07vOxZwW1kbzun8egHOAHV9RwuI3T4rqoyQZtWI3hSYTUlDtMRXuGeXZQ2D0kfh0Tl2LL5gLnjYH39vBPfsWuWI6JiInuG7/pPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779161136; c=relaxed/simple;
	bh=AccoqBj22VePlwp41PqIhXy5UW8PEYoC+3bNp2ltdew=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RhOGP2eC46kvSRZrIOVai90zaVWjS9Kyuz+gnxYr2iy4wAZayMNbPuHKR0zPc1lFU+vv9Meho77ipbGB6Y7FA7NvDZPREJ+gYD2MvfG8hofaGTLb7pHsa6T+dmMYZLX0WmTU5AJivZTqf7jHZixgWDJtVO0CsCc2QBpgiVZBTzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ST6mOgYB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ST6mOgYB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78440C2BCB3;
	Tue, 19 May 2026 03:25:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779161136;
	bh=AccoqBj22VePlwp41PqIhXy5UW8PEYoC+3bNp2ltdew=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ST6mOgYBjKjugyYu0Oyk2isfx0X0nmqhVHHXa+G5g1R+yXlHIAfXR8mGW/d3XzLvA
	 +AitajAKrrYK9e3SpkWj8qHzsMx3lerwLqAVjWPUz7FgXdvWcb9rmjU+dcUJAi+pwM
	 /br7n5CFFg+T7NviGP+8HFVbVSDO8DR3HsB2ylebOcMxSCWP99y+H+WO/gmfyeQLtl
	 BqRkyGdzOZpk3PuiyC8kQxtB/BZdQnTAhCQCv8OwJEv+KW+/GP+sR92DP94QqwuMa7
	 hc9wQ3jMva8m2KXHTDjzDa4jAGODN4ISS+jKv7sF6xkHO16w+PWGNj+NQPtEw19sWu
	 WJcT/Ip/b127A==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	zhenwei pi <zhenwei.pi@linux.dev>,
	Hui Zhu <zhuhui@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next v14 10/10] nvme-tcp: add RCU protection for host_iface validation
Date: Tue, 19 May 2026 11:25:01 +0800
Message-ID: <2e7153e64471ba05079d5abc799177381fb6f8d6.1779159524.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1779159524.git.tanggeliang@kylinos.cn>
References: <cover.1779159524.git.tanggeliang@kylinos.cn>
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

Cc: zhenwei pi <zhenwei.pi@linux.dev>
Cc: Hui Zhu <zhuhui@kylinos.cn>
Cc: Gang Yan <yangang@kylinos.cn>
Fixes: 3ede8f72a9a2 ("nvme-tcp: allow selecting the network interface for connections")
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 drivers/nvme/host/tcp.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 2388a8c443cc..eafe750a8be8 100644
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

