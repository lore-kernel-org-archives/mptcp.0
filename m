Received: from sender5-of-o54.zoho.com (sender5-of-o54.zoho.com [165.173.182.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29839404BC8
	for <mptcp@lists.linux.dev>; Mon, 24 Aug 2026 10:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=165.173.182.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787567300; cv=pass; b=rPZrsXHatX4UwDd0PnqgnktVw/mdZ7gScl6nZdZTU/utvX0eDGDRMs+VXObWjQ4MxO+5wgcNsB4fmxVp19Pu/dCiuLt08C9ff27d5m+6x0ONBoZIK9kA6jPFuTkYPaQaD34A3gg/JsjAE/XVxQGcjyqUUqWNLxg6ptPERq8lQ+Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787567300; c=relaxed/simple;
	bh=1Z5+xxcnoJcC32azKn3P0nuFZZAAVcWuD9CVatLywWY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kLzqo2hmNb8oRh16xP3EiOkoYuV13xuNgrerWanA/cCBUHJ/NijR7ndtOB6s1xbM0QPn7bp7prSIfptqc7ir5ooQ34A6JqReaSwVGYpyiU2rv8Zs5j7IIC5WjFgBytG/NdP5wmlMtkTS97UCFQmtyqt2ydRGH4RceyjqG5U4tGg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com; spf=pass smtp.mailfrom=mpiricsoftware.com; dkim=fail (0-bit key) header.d=mpiricsoftware.com header.i=kalpan.jani@mpiricsoftware.com header.b=mWSUE50j reason="key not found in DNS"; arc=pass smtp.client-ip=165.173.182.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mpiricsoftware.com header.i=kalpan.jani@mpiricsoftware.com header.b="mWSUE50j"
ARC-Seal: i=1; a=rsa-sha256; t=1787567281; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=lt0bInv4TubSfzrFnkRUaC8t9M0uYxmZJZU5R9ISxvLLPDd8R4TGvepmA0ZdR+A837BeNB56izPxfTLPdKsMiDx5yhcaLhNbCQGvVMKw0o1Lr1tqthuv8GcMkXtCZJq6Y0FYXvnIm/XorjO8Y74/iECtyfel9xWErz85uAKQls8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1787567281; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=j92S/EE1GFFkJM9Jc4mdetdIYeBSMBwiydkkH3Kj1Nw=; 
	b=nQnb0S+W6f0xae1kD+/WsFGBk5FfosOeQ67QoDaBrq3fAOPJ9YFb2wDEUL1Rl/hMv6QL6tTGRRrtaI8FSijcNb+jnoTsiS0oJjv+zph6dXWyE+RWRX2CTt0ykeiZYMV9LTpw32gBvj5IBFVPjQLhTKSk7r0Wxxai8DBpwfCfiDo=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=mpiricsoftware.com;
	spf=pass  smtp.mailfrom=kalpan.jani@mpiricsoftware.com;
	dmarc=pass header.from=<kalpan.jani@mpiricsoftware.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1787567281;
	s=mpiric; d=mpiricsoftware.com; i=kalpan.jani@mpiricsoftware.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=j92S/EE1GFFkJM9Jc4mdetdIYeBSMBwiydkkH3Kj1Nw=;
	b=mWSUE50jdxPp31nP4PuznXNeVdv0Z3rpg57mZ6U+w5hgArnYcdkP+7F4ZsPpKL5N
	llmgDz7vJ8i1xjtlopiTwKHj+aSlTEwSq2ZPAyg0kp91etnoItzW5ylvDCcAmCop8XK
	kZfN9a+UKmgy+6D0ycCbxT8mQ4xAFrkHFz91UU1E=
Received: by mx.zohomail.com with SMTPS id 1787567278504810.7279472492908;
	Mon, 24 Aug 2026 03:27:58 -0700 (PDT)
From: Kalpan Jani <kalpan.jani@mpiricsoftware.com>
To: mptcp@lists.linux.dev
Cc: matttbe@kernel.org,
	martineau@kernel.org,
	pabeni@redhat.com,
	shardul.b@mpiricsoftware.com,
	janak@mpiric.us,
	kalpanjani009@gmail.com
Subject: [PATCH mptcp-next v2 2/2] selftests: mptcp: bpf: exercise the subflow avoid flag across rounds
Date: Mon, 24 Aug 2026 15:57:41 +0530
Message-ID: <20260824102741.347492-3-kalpan.jani@mpiricsoftware.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260824102741.347492-1-kalpan.jani@mpiricsoftware.com>
References: <20260824102741.347492-1-kalpan.jani@mpiricsoftware.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Add a BPF struct_ops scheduler selftest for mptcp_subflow_set_avoid(),
and add the required extern declarations for it and for
mptcp_subflow_active(), both declared locally in this file rather
than in the shared mptcp_bpf.h. mptcp_subflow_active()'s extern was
missing here even though the other BPF scheduler progs already have
it (see mptcp_bpf_burst.c).

"scheduled" gets cleared by the core after every single send/retrans
pass, so a scheduler has to set it again every round. This test's
scheduler does the opposite on purpose: it marks a subflow avoided
exactly once, the first time get_send() runs, and never calls
set_avoid() again after that. Every later round skips the marked
subflow purely by reading back state set earlier. A counter of
get_send() invocations, asserted greater than one once the transfer
is done, makes sure the test actually ran more than one round instead
of just assuming it from how much data got sent.

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/349
Suggested-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Kalpan Jani <kalpan.jani@mpiricsoftware.com>

---

Changes since v1:
- reworked the scheduler to set avoid once, on the first get_send()
  call, and rely on reading it back on every later call rather than
  re-asserting it: the previous version set and read the flag within
  the same call, which doesn't exercise standing state across
  scheduling rounds. Added a get_send_calls counter, asserted >1, so
  the test enforces multiple rounds actually occurred.
- added the missing extern __ksym declaration for
  mptcp_subflow_active(), matching the existing pattern in
  mptcp_bpf_burst.c.
- declared the mptcp_subflow_set_avoid() extern in this file instead
  of mptcp_bpf.h: checkpatch flags new externs in shared headers, and
  this kfunc has only one caller.

v1: https://lore.kernel.org/all/20260715101148.2601045-3-kalpan.jani@mpiricsoftware.com/
---
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 16 +++++
 .../selftests/bpf/progs/mptcp_bpf_avoid.c     | 70 +++++++++++++++++++
 2 files changed, 86 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/mptcp_bpf_avoid.c

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index 7f48fd9e94e1..8ad09e94335a 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -17,6 +17,7 @@
 #include "mptcp_bpf_bkup.skel.h"
 #include "mptcp_bpf_rr.skel.h"
 #include "mptcp_bpf_red.skel.h"
+#include "mptcp_bpf_avoid.skel.h"
 #include "mptcp_bpf_burst.skel.h"
 
 #define NS_TEST "mptcp_ns"
@@ -813,6 +814,19 @@ static void test_burst(void)
 	mptcp_bpf_burst__destroy(skel);
 }
 
+static void test_avoid(void)
+{
+	struct mptcp_bpf_avoid *skel;
+
+	skel = mptcp_bpf_avoid__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "open_and_load: avoid"))
+		return;
+
+	test_bpf_sched(skel->maps.avoid, "avoid", WITH_DATA, WITHOUT_DATA);
+	ASSERT_GT(skel->bss->get_send_calls, 1, "get_send_calls");
+	mptcp_bpf_avoid__destroy(skel);
+}
+
 void test_mptcp(void)
 {
 	if (test__start_subtest("base"))
@@ -835,4 +849,6 @@ void test_mptcp(void)
 		test_red();
 	if (test__start_subtest("burst"))
 		test_burst();
+	if (test__start_subtest("avoid"))
+		test_avoid();
 }
diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_avoid.c b/tools/testing/selftests/bpf/progs/mptcp_bpf_avoid.c
new file mode 100644
index 000000000000..2c2553195d7f
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_avoid.c
@@ -0,0 +1,68 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026, MPTCP. */
+
+#include "mptcp_bpf.h"
+#include <bpf/bpf_tracing.h>
+
+extern bool mptcp_subflow_active(struct mptcp_subflow_context *subflow) __ksym;
+extern void mptcp_subflow_set_avoid(struct mptcp_subflow_context *subflow,
+				    bool avoid) __ksym;
+
+char _license[] SEC("license") = "GPL";
+
+/* set once, on the first scheduling round, never touched again -- this
+ * is what makes "avoid" different from "scheduled": nothing here
+ * re-asserts the decision, and the core doesn't clear it either.
+ */
+bool avoid_marked;
+__u32 get_send_calls;
+
+SEC("struct_ops")
+void BPF_PROG(mptcp_sched_avoid_init, struct mptcp_sock *msk)
+{
+	avoid_marked = false;
+	get_send_calls = 0;
+}
+
+SEC("struct_ops")
+void BPF_PROG(mptcp_sched_avoid_release, struct mptcp_sock *msk)
+{
+}
+
+SEC("struct_ops")
+int BPF_PROG(bpf_avoid_get_send, struct mptcp_sock *msk)
+{
+	struct mptcp_subflow_context *subflow;
+
+	get_send_calls++;
+
+	if (!avoid_marked) {
+		int i = 0;
+
+		/* bench every subflow but the first, once */
+		bpf_for_each(mptcp_subflow, subflow, (struct sock *)msk) {
+			if (i++ > 0)
+				mptcp_subflow_set_avoid(subflow, true);
+		}
+		avoid_marked = true;
+	}
+
+	/* every round -- including this one -- just reads back state set
+	 * at most once above. no re-assertion, ever.
+	 */
+	bpf_for_each(mptcp_subflow, subflow, (struct sock *)msk) {
+		if (subflow->avoid)
+			continue;
+		if (mptcp_subflow_active(subflow)) {
+			mptcp_subflow_set_scheduled(subflow, true);
+			break;
+		}
+	}
+	return 0;
+}
+
+SEC(".struct_ops.link")
+struct mptcp_sched_ops avoid = {
+	.init		= (void *)mptcp_sched_avoid_init,
+	.release	= (void *)mptcp_sched_avoid_release,
+	.get_send	= (void *)bpf_avoid_get_send,
+	.name		= "bpf_avoid",
+};
-- 
2.43.0
