Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE2A4523E
	for <mptcp@lists.linux.dev>; Sat,  6 Jan 2024 08:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qROlZ4yK"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1704530499;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=0kOQCfSo9gihHF000eHUWfFNYq4xSMqCsHl6f8rf5oc=;
	b=qROlZ4yKEGwElUMjP0+wcnRpsPI0aVo6nGYw1IosN/6fX7WyYYzzf9WYiuQhjigEdNoVTM
	W9jisAzXSD8igqF45T71Rxnhpb9R3xCNpZZINGGBblAmajj+cgiptSEigQFM4Jn55Rsrio
	kg7xYVi1xtz28PJpTUOHR8sD1Vh3bbE=
From: Geliang Tang <geliang.tang@linux.dev>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@linux.dev>
Subject: [PATCH mptcp-next] bpf: Add mptcp_sched_ops CFI
Date: Sat,  6 Jan 2024 16:40:48 +0800
Message-Id: <9e2fbdc6e5a9c59d4b8eded4bfb2ae71a768afad.1704530434.git.geliang.tang@linux.dev>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

'''
The cfi_stubs pointer is added in the commit 2cd3e3772e41 ("x86/cfi,bpf:
Fix bpf_struct_ops CFI"), this patch initializes it as dummy stubs
__bpf_mptcp_sched_ops.
'''

Note:

BPF tests on export branch fail with this error:

 BUG: kernel NULL pointer dereference, address: 0000000000000000
 #PF: supervisor read access in kernel mode
 #PF: error_code(0x0000) - not-present page
 PGD 0 P4D 0
 Oops: 0000 [#1] PREEMPT SMP PTI
 CPU: 3 PID: 1512 Comm: test_progs Tainted: G        W IOE      6.7.0-rc5 #37
 Hardware name: LENOVO 4180PG2/4180PG2, BIOS 83ET76WW (1.46 ) 07/05/2013
 RIP: 0010:bpf_struct_ops_map_update_elem+0x4ee/0x610

This patch fixes this error. It can be applied after the commit
"bpf: Add bpf_mptcp_sched_ops"

Signed-off-by: Geliang Tang <geliang.tang@linux.dev>
---
 net/mptcp/bpf.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
index b92c9014ac2c..fb67768aa07d 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -147,6 +147,19 @@ static int bpf_mptcp_sched_init(struct btf *btf)
 	return 0;
 }
 
+static void __bpf_mptcp_sched_init(struct mptcp_sock *msk)
+{
+}
+
+static void __bpf_mptcp_sched_release(struct mptcp_sock *msk)
+{
+}
+
+static struct mptcp_sched_ops __bpf_mptcp_sched_ops = {
+	.init		= __bpf_mptcp_sched_init,
+	.release	= __bpf_mptcp_sched_release,
+};
+
 struct bpf_struct_ops bpf_mptcp_sched_ops = {
 	.verifier_ops	= &bpf_mptcp_sched_verifier_ops,
 	.reg		= bpf_mptcp_sched_reg,
@@ -155,6 +168,7 @@ struct bpf_struct_ops bpf_mptcp_sched_ops = {
 	.init_member	= bpf_mptcp_sched_init_member,
 	.init		= bpf_mptcp_sched_init,
 	.name		= "mptcp_sched_ops",
+	.cfi_stubs	= &__bpf_mptcp_sched_ops,
 };
 #endif /* CONFIG_BPF_JIT */
 
-- 
2.39.2

