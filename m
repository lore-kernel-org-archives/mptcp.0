Received: from sender4-of-o54.zoho.com (sender4-of-o54.zoho.com [136.143.188.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5558F2F25F0
	for <mptcp@lists.linux.dev>; Fri,  3 Jul 2026 16:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783097889; cv=pass; b=bjznEVtMAz3+3TkFIeMzYb1YMZqyeOvWu2ANx11RZeSw/kglTCPE2R/dKe48na3+izGcHr35di+Fcb4Abf+GSoqy4um+ZM7CVrdjMlNYcDRoKkOD/JZcseer7/hc6zlcCoPyM4lV8SmSiReJY7fYSwSZKgSnDmULSRHR0wSvz7A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783097889; c=relaxed/simple;
	bh=z04UbkS9plFhwokOUxl1KJmA8b0O4M45RmMbS0qTF+0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uULilFOUxe3ZTjLMW38l1yGhCVx7dG4AL9DrvMj9TYAZsnzwCtrPjxFI27zFOV0vmvwsTcHPW1ZCCXIsJO+zgIernoglsd6lHokJ72ZhH9KQtEPuIedlNIts08Q/+p0JJuVkPIWTTggGW4M5jafRzaPoIG5LCu7wgTPt2KLbfTk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com; spf=pass smtp.mailfrom=mpiricsoftware.com; dkim=fail (0-bit key) header.d=mpiricsoftware.com header.i=shardul.b@mpiricsoftware.com header.b=pwHaf79L reason="key not found in DNS"; arc=pass smtp.client-ip=136.143.188.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mpiricsoftware.com header.i=shardul.b@mpiricsoftware.com header.b="pwHaf79L"
ARC-Seal: i=1; a=rsa-sha256; t=1783097859; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=ZuQOlGfRJ46UqF3ZHH6vvaNCUbwuNnYVQiUXFT54Afo6vLkJcALlvwz3SV76yQg0pRFsler2Hx2It6GsBunBmf6OH2icL4MC8dMqGU/e+aadcxNJA1OdTQE3a4mWCG0XcdgUoGtS3xOGlYGjulchDeczOfumvC0GutG7yLTMXG8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1783097859; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Xxl9xK6Vh21e7AFjWb+3zKxiqLq6a0rRaNckSfXr0Z0=; 
	b=gjaxrSr/j0Jh79TJFxJ0aHSQYhJzmT+OxTgZ4p+SauOmrxCtW0lKE9EwsC9JKs9iJGlMr2u1qNV9AXA+PjSl7xX8URfvuFGndrVHFu2EFYLj/vxWxQkEGp6gOcE7Ph3It0MjK6w6vEMsqncjZNZTqo9vqEeuLceRGYeTNYaerzM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=mpiricsoftware.com;
	spf=pass  smtp.mailfrom=shardul.b@mpiricsoftware.com;
	dmarc=pass header.from=<shardul.b@mpiricsoftware.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1783097859;
	s=mpiric; d=mpiricsoftware.com; i=shardul.b@mpiricsoftware.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=Xxl9xK6Vh21e7AFjWb+3zKxiqLq6a0rRaNckSfXr0Z0=;
	b=pwHaf79LLD24XRMHcQqi7//RNWx3jjD1ZQEt+dAdY7UFCfMOw/ZVPKV/vjQZZKa0
	owIQfpIdOJrx/Ohcs1qrlNxohM9QwZDxvFrbDx2LKUIiwF7jqmhwSxV3fbRQYFSf2FE
	Uz9T57aS2CvoXgBdL2Qb6EzbBuVBs4BzwEDPhQ3Y=
Received: by mx.zohomail.com with SMTPS id 1783097857181592.5619918238758;
	Fri, 3 Jul 2026 09:57:37 -0700 (PDT)
From: Shardul Bankar <shardul.b@mpiricsoftware.com>
Date: Fri, 03 Jul 2026 22:27:12 +0530
Subject: [PATCH mptcp-next v2 4/5] DO-NOT-MERGE: selftests/bpf: mptcp:
 verify scheduler rejects non-msk socket to set_timeout
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260703-mptcp_bpf_kfunc_fixes-v2-4-87ae3c64dc7e@mpiricsoftware.com>
References: <20260703-mptcp_bpf_kfunc_fixes-v2-0-87ae3c64dc7e@mpiricsoftware.com>
In-Reply-To: <20260703-mptcp_bpf_kfunc_fixes-v2-0-87ae3c64dc7e@mpiricsoftware.com>
To: mptcp@lists.linux.dev, Geliang Tang <geliang@kernel.org>
Cc: Matthieu Baerts <matttbe@kernel.org>, 
 Mat Martineau <martineau@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 kalpan.jani@mpiricsoftware.com, janak@mpiric.us, shardulsb08@gmail.com, 
 Shardul Bankar <shardul.b@mpiricsoftware.com>
X-Mailer: b4 0.15.2
X-ZohoMailClient: External

Add a negative test for the bpf_mptcp_set_timeout() kfunc: a BPF MPTCP
scheduler whose get_send() passes a subflow TCP socket to it, where the
kfunc takes a struct mptcp_sock *, must be rejected by the verifier at
program load time. This guards against widening the kfunc argument back
to a generic struct sock *, which would reintroduce the socket type
confusion between an MPTCP-level socket and a subflow TCP socket.

Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Shardul Bankar <shardul.b@mpiricsoftware.com>
---
 tools/testing/selftests/bpf/prog_tests/mptcp.c     | 32 +++++++++++++
 .../selftests/bpf/progs/mptcp_bpf_bad_sched.c      | 56 ++++++++++++++++++++++
 2 files changed, 88 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index 7f48fd9e94e1e..177e5318029d4 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -18,6 +18,7 @@
 #include "mptcp_bpf_rr.skel.h"
 #include "mptcp_bpf_red.skel.h"
 #include "mptcp_bpf_burst.skel.h"
+#include "mptcp_bpf_bad_sched.skel.h"
 
 #define NS_TEST "mptcp_ns"
 #define ADDR_1	"10.0.1.1"
@@ -813,6 +814,35 @@ static void test_burst(void)
 	mptcp_bpf_burst__destroy(skel);
 }
 
+static void test_bad_sched(void)
+{
+	struct mptcp_bpf_bad_sched *skel;
+	char *log = NULL;
+	int err;
+
+	/*
+	 * bad_sched_get_send() passes a subflow TCP socket to
+	 * bpf_mptcp_set_timeout(), which takes a struct mptcp_sock *. The
+	 * verifier must reject this socket type confusion at load time, and
+	 * for the right reason: assert the specific verifier message.
+	 */
+	skel = mptcp_bpf_bad_sched__open();
+	if (!ASSERT_OK_PTR(skel, "open: bad_sched"))
+		return;
+
+	if (start_libbpf_log_capture())
+		goto destroy;
+
+	err = mptcp_bpf_bad_sched__load(skel);
+	log = stop_libbpf_log_capture();
+	ASSERT_ERR(err, "load: bad_sched must be rejected");
+	ASSERT_HAS_SUBSTR(log, "expected pointer to STRUCT mptcp_sock",
+			  "verifier rejects subflow sock to bpf_mptcp_set_timeout");
+	free(log);
+destroy:
+	mptcp_bpf_bad_sched__destroy(skel);
+}
+
 void test_mptcp(void)
 {
 	if (test__start_subtest("base"))
@@ -835,4 +865,6 @@ void test_mptcp(void)
 		test_red();
 	if (test__start_subtest("burst"))
 		test_burst();
+	if (test__start_subtest("bad_sched"))
+		test_bad_sched();
 }
diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_bad_sched.c b/tools/testing/selftests/bpf/progs/mptcp_bpf_bad_sched.c
new file mode 100644
index 0000000000000..70e7da42f13a9
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_bad_sched.c
@@ -0,0 +1,56 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026, Mpiric Software. */
+
+/*
+ * A scheduler that passes a subflow TCP socket to bpf_mptcp_set_timeout(),
+ * which takes a struct mptcp_sock *. The verifier must reject this at load
+ * time; see the bad_sched subtest in prog_tests/mptcp.c.
+ */
+#include "mptcp_bpf.h"
+#include <bpf/bpf_tracing.h>
+
+char _license[] SEC("license") = "GPL";
+
+extern void bpf_mptcp_set_timeout(struct mptcp_sock *msk) __ksym;
+
+SEC("struct_ops")
+void BPF_PROG(bad_sched_init, struct mptcp_sock *msk)
+{
+}
+
+SEC("struct_ops")
+void BPF_PROG(bad_sched_release, struct mptcp_sock *msk)
+{
+}
+
+SEC("struct_ops")
+int BPF_PROG(bad_sched_get_send, struct mptcp_sock *msk)
+{
+	struct mptcp_subflow_context *subflow;
+	struct sock *ssk;
+
+	bpf_for_each(mptcp_subflow, subflow, (struct sock *)msk) {
+		ssk = bpf_mptcp_subflow_tcp_sock(subflow);
+		if (!ssk)
+			return -1;
+		/*
+		 * ssk is a subflow TCP socket (struct sock *), not an msk.
+		 * Passing it to bpf_mptcp_set_timeout(), which takes a
+		 * struct mptcp_sock *, is a socket type confusion that the
+		 * verifier must reject at load time ("expected pointer to
+		 * STRUCT mptcp_sock").
+		 */
+		bpf_mptcp_set_timeout((struct mptcp_sock *)ssk);
+		mptcp_subflow_set_scheduled(subflow, true);
+		return 0;
+	}
+	return -1;
+}
+
+SEC(".struct_ops.link")
+struct mptcp_sched_ops bad_sched = {
+	.init		= (void *)bad_sched_init,
+	.release	= (void *)bad_sched_release,
+	.get_send	= (void *)bad_sched_get_send,
+	.name		= "bpf_bad_sched",
+};

-- 
2.34.1

