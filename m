Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21C2A3438B6
	for <mptcp@lists.linux.dev>; Wed, 20 May 2026 04:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779250712; cv=none; b=lpgWGyoGOPchK3p3L4fXkX3FhMKyGEhH2YFrvtAzzVLgu3pKEjbI3bTTqGJdukpoCCW+h+veq8NNQLFQ+JbqkUluX5Lw3le/uY7qoRxEnncxXl1XE9QqLOw6y50GpAMZzMjvlGvNfG4X+KU0Abf7vb1w8VeVPE3ceqQrmsxQ7FQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779250712; c=relaxed/simple;
	bh=VG3Djbfy7MFhSfeQr4z5bN/4d7xtyVL43AF2qVCZk1o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=svHUAEdysAhvx1sgTHR0R82CLPhS8rcbzzlons+okjHo+8nuuBjOtsUWbMu0zg4W1hKAbzk8OKRcKaUKYg8Tw0PwzPBqCeaQHn0LAsM4vp0on5GVUuNihq5xjCeYhObymtcfFtq8/MbERPU9xAjS3sGH4Q1V0nMXU79Xi10SWh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j6hvzBet; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j6hvzBet"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80B1A1F000E9;
	Wed, 20 May 2026 04:18:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779250710;
	bh=Zdd9O1IpVn7Ba9prJgBgQ62Gt14l7XZarlq4QoKTnqs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=j6hvzBetF+2+gubGF8rou/DVsknfsEOvZA3KAkkXYRA7mdcQeQO8i1KLPuc1x+3Ed
	 CxB/pj13pE9Njg77yfvHj79rtDFsvRNOzt5McVfOswuSwO7KKqLSwWY+m4kxCFU/bB
	 NH9JqIUm5I0b2xKwtC/U3MS4L16luCDfo6Fd24GsMNKlCaF3XOpjGod3qgn9T+Xron
	 T0HuvK4n+QWgjvm6/O57o4zyFENHmQRf04wosToI8ff4TFHv/eQ3RPhNiXq3R+T6zP
	 BmzRoItUnCEwPTeevNGtuRc2palX7QDvg7jDhDHII/auBGgtzAJCbd/nNB0mzhhBEG
	 oVzQV4NS5JG3g==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	zhenwei pi <zhenwei.pi@linux.dev>,
	Hui Zhu <zhuhui@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next v15 10/10] nvme-tcp: add RCU protection for host_iface validation
Date: Wed, 20 May 2026 12:17:43 +0800
Message-ID: <edc0e99ff92bae44b179da469c566b72dd5cdc98.1779249906.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1779249906.git.tanggeliang@kylinos.cn>
References: <cover.1779249906.git.tanggeliang@kylinos.cn>
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
Fixes: 8b43ced64d2b ("nvme-tcp: use __dev_get_by_name instead dev_get_by_name for OPT_HOST_IFACE")
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

