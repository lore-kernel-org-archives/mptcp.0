Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 083913F44FD
	for <mptcp@lists.linux.dev>; Mon, 18 May 2026 12:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779106101; cv=none; b=WDx/snzNS/pyrC0yRj39m1LgTWlBcJfDMRHy91+Qeo6RzBBKAx6vf+B2EYNa/QyB1YNSiboBDBlDFhWX3WrDz6sjnHnliIMJtQ6APhK0txu0QbJcrO8aPOcR2Wx9MtU7ZswccPW6OM41fhssyKLYCTXlm0Sk8IwsPvlv9kaporA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779106101; c=relaxed/simple;
	bh=AccoqBj22VePlwp41PqIhXy5UW8PEYoC+3bNp2ltdew=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u16CycF1VzgHGBsH9N7xKjBtP59LBpwMGl4Mo1iuEASrvt3EkP00nn7KJ1yuyGKpIyp9la1bcTRV0rnFydxbhlmhv8JYW4Dw2Jm+J/dFYJMlsClfHkUeGJ5sAwxWXkKFjnXrkD9CQIwKZBhCKzoAsSUSPSUmumnOGHkRWDOr9+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CxN9DOJi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CxN9DOJi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F2B3C2BCB7;
	Mon, 18 May 2026 12:08:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779106100;
	bh=AccoqBj22VePlwp41PqIhXy5UW8PEYoC+3bNp2ltdew=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CxN9DOJiW17aJArv6VpMFGw1dumvc2Z/BVOoE790iitceNOFRboh3Ib/c2junNg0Z
	 W+s2e7+qIyVjrwf6be2V8irfOjsAwhYzcNpNz4yDuJkQhmoWjIvFhUmyOU8gzn5w5U
	 xdZ5L5SYUDqKjuUEPWpayIUqv17GsacdyeawA6SpTieK6tc8VMORtYSU1gqAIrg53s
	 nkp46eQTTPgcHovdEzbpdKFFDXT3fOXfN7UZ2IuHy8urYUNC8HNx3uwf1f83A0/TB8
	 bntij0ePWbL8EWaLkixDk5svn6/g9WUo55jn1t28IKPcc4OiOTM+7O2fV5RjdATCiQ
	 UpEtyTa4jjaxQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	zhenwei pi <zhenwei.pi@linux.dev>,
	Hui Zhu <zhuhui@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next v13 11/12] nvme-tcp: add RCU protection for host_iface validation
Date: Mon, 18 May 2026 20:07:36 +0800
Message-ID: <3dd32a6ac7d7bb8629408255f28014468cbffdea.1779104752.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1779104752.git.tanggeliang@kylinos.cn>
References: <cover.1779104752.git.tanggeliang@kylinos.cn>
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

