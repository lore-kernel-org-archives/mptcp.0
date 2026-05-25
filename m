Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 829C43E3DB8
	for <mptcp@lists.linux.dev>; Mon, 25 May 2026 09:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779701654; cv=none; b=PcNZ6WqZM8Gubp5U8dTiGSzkgM8F0YrWD9enLnD5243tlMoj6fuYscRafcFGJhH0ytVdzepBO+muMyRraIU9jdvp+Utr2/f7iT7H8t89Fr2lvOLG107frz1nA+6LGVEh5zbAQg+48SlRuYxypS7MEX7TPNRURN2Ij2u572C8Axk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779701654; c=relaxed/simple;
	bh=Vk22Xl9WEDtsqiVP3W/98LneQ5j71Y7CNTPMxMRjysA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i28UO+Q3o3QzGpzCnyMTrl3AwLniQz+KLWBwIipYOKolW7sis2nzn9Uc1SFPtpkrr9C1VjEbbiQjr9Euf0azLF+s76WfLz3se0YLFkgPGrKKnMNCXFRcpmzSa2AhrTnp1E8OWOhPKEsNexMeyHiUzT0sX7V0bciUZSPpuJGvaVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N+VJOAoC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N+VJOAoC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DEF11F000E9;
	Mon, 25 May 2026 09:34:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779701653;
	bh=JwpmLWzrcZiTQG7mv2NOc+FB61GC3uj+q2Noe/Sk/Pw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=N+VJOAoC291ivhi8N/nlOxaCEMlEXcRm7xiphm4lp4oJ3hETHRNuTMJOYhbpKfXwa
	 Cu3agLqN8bab2sRCA6zZjsT+iZSTSd3T5VWDyR1bPApJqgqjcOE3SHxmNSflPgJDeo
	 +KPPsi4HNWB0HKu+9F7uIRm3pvBsMd81Fm0FC5WZjIb9lRqQYGS4tnYLve6pt4nBO5
	 bjraI5HgW6UzQDhul80IwAKZSnaXhoJKZhs21v+RMtHfzWFhvThfHjXzvJD9NQISzl
	 gTfgJbye81/U53LI5PgEGpH1XlXyieVm7TnyVqugF2KnVMLfT94AO/xLV1jm+F1aOm
	 INCkjFxcAn52Q==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Hannes Reinecke <hare@suse.de>,
	zhenwei pi <zhenwei.pi@linux.dev>,
	Hui Zhu <zhuhui@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next v17 14/14] nvme-tcp: add RCU protection for host_iface validation
Date: Mon, 25 May 2026 17:33:09 +0800
Message-ID: <9f89cc6c87d4b65603b686df0c6f339c745f249f.1779701391.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1779701391.git.tanggeliang@kylinos.cn>
References: <cover.1779701391.git.tanggeliang@kylinos.cn>
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

Fix by using dev_get_by_name_rcu() with current->nsproxy->net_ns and
wrapping the lookup with rcu_read_lock()/rcu_read_unlock().

Cc: Hannes Reinecke <hare@suse.de>
Cc: zhenwei pi <zhenwei.pi@linux.dev>
Cc: Hui Zhu <zhuhui@kylinos.cn>
Cc: Gang Yan <yangang@kylinos.cn>
Fixes: 8b43ced64d2b ("nvme-tcp: use __dev_get_by_name instead dev_get_by_name for OPT_HOST_IFACE")
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 drivers/nvme/host/tcp.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 2388a8c443cc..a600fa3f9caa 100644
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
@@ -3004,12 +3005,16 @@ static struct nvme_tcp_ctrl *nvme_tcp_alloc_ctrl(struct device *dev,
 	}
 
 	if (opts->mask & NVMF_OPT_HOST_IFACE) {
-		if (!__dev_get_by_name(&init_net, opts->host_iface)) {
+		rcu_read_lock();
+		if (!dev_get_by_name_rcu(current->nsproxy->net_ns,
+					 opts->host_iface)) {
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

