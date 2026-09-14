Received: from sender4-of-o54.zoho.com (sender4-of-o54.zoho.com [136.143.188.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D43F9463
	for <mptcp@lists.linux.dev>; Mon, 14 Sep 2026 09:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789377643; cv=pass; b=YSw5Tn2GGypIdpyYUYiVoOMd6dCZzUPnZag9A7kxHiHGlzQCf1/3TXDcu7FDBa4lXKPswmALegxsp/Rf6XWQZW5LOlk0uVrdGTX2kKlyR6Ce9o2mOxhhAprb0lFZFEaTiDWwEsQ420RVZF5VoCfWL7/qpNk+ZdXy/4h16f4C02Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789377643; c=relaxed/simple;
	bh=Nq0TkRQMtpSHt3bht/O9PyRC1Au8Go0AJacQrqXqilw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fL8pl1oomzQ2OHIcEqyNe9+ppN3dTLphhT6cZR2PPmEDgOVIwbl/uuQYBVWxQo8UD0PCKmrhoE/HGmly862g/+NVrPMJlPFZAiPIVD/GGcPEx658QdHLh8oK6srlhSBNXz178hQLjrB7XZd6/J9D1a11CEm04TPK3ua7JCla0aI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com; spf=pass smtp.mailfrom=mpiricsoftware.com; dkim=fail (0-bit key) header.d=mpiricsoftware.com header.i=kalpan.jani@mpiricsoftware.com header.b=A349L2QO reason="key not found in DNS"; arc=pass smtp.client-ip=136.143.188.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mpiricsoftware.com header.i=kalpan.jani@mpiricsoftware.com header.b="A349L2QO"
ARC-Seal: i=1; a=rsa-sha256; t=1789377625; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=DAYCvqhgW7t3b9oksdM7cmYdi7A5NeoTXWFobh1rM7Ox60fk4/g1xARG7SXYrkTZpFoUZrrvq93tYYtIa0xLYJaelYDo+vQsr3Uu3HlqQZou2eefFiOksqltq0GB4eux+ocWbFz4foTivru7rrp6IWnGjEXfhfgBxza9sjhhsTk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1789377625; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=yLiZIAIe/97oL8SelMwuRXvFQM8gP5Paa47AcfUXRu4=; 
	b=VVZnOxjUairgw+bc7gKvzwv4iN9/JVi46x2nlFlxhT9m4BU6tC2XtmKLCpnThY8KiaMlwybQZITal0T+iZY++0RgTE+WHaVehsI09gSi+TX/E/M36Z76l3UxPAEKhsaLdG9LLDtTrrkJL6vlL4cyqthMjbDpVfUdqLpPe44Wn0s=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=mpiricsoftware.com;
	spf=pass  smtp.mailfrom=kalpan.jani@mpiricsoftware.com;
	dmarc=pass header.from=<kalpan.jani@mpiricsoftware.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1789377625;
	s=mpiric; d=mpiricsoftware.com; i=kalpan.jani@mpiricsoftware.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=yLiZIAIe/97oL8SelMwuRXvFQM8gP5Paa47AcfUXRu4=;
	b=A349L2QOJn+G63hEJsgRlj+h/mh+2mJdpw4zV3tLRUvcAgBfdhIog5ozDjygqJL0
	yhnpJw5a1KM5qDA1MkmC1p52fVbkGW6pt1iSTvJNipdbGys3DfJ4mRy++g/by5ik1wx
	WS4NXAXgtGh05mMW1Jbwd2D2bg23IneDzmYqedbc=
Received: by smtp.zohomail.com with SMTPS id 1789377623395219.09538900257155;
	Mon, 14 Sep 2026 02:20:23 -0700 (PDT)
From: Kalpan Jani <kalpan.jani@mpiricsoftware.com>
To: mptcp@lists.linux.dev
Cc: matttbe@kernel.org,
	martineau@kernel.org,
	pabeni@redhat.com,
	shardul.b@mpiricsoftware.com,
	janak@mpiric.us,
	kalpanjani009@gmail.com
Subject: [PATCH mptcp-next v4 2/2] selftests: mptcp: bpf: exercise the subflow avoid flag across rounds
Date: Mon, 14 Sep 2026 14:50:00 +0530
Message-ID: <20260914092000.1306968-3-kalpan.jani@mpiricsoftware.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260914092000.1306968-1-kalpan.jani@mpiricsoftware.com>
References: <20260914092000.1306968-1-kalpan.jani@mpiricsoftware.com>
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
subflow purely by reading back state set earlier, and the harness's
own byte-count checks confirm the avoided path carried no data across
the whole transfer.

Per-msk state (whether avoid has been asserted yet) is kept in
BPF_MAP_TYPE_SK_STORAGE keyed on msk, the same pattern
mptcp_bpf_rr.c already uses, rather than in BPF global variables:
globals are process-wide, not per-socket, so they would be shared
and reset across any concurrent connections attached to this
scheduler.

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/349
Suggested-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Kalpan Jani <kalpan.jani@mpiricsoftware.com>

Changes since v3:
- moved the avoid_marked flag from a BPF global variable into
  per-msk BPF_MAP_TYPE_SK_STORAGE, mirroring mptcp_bpf_rr.c. Sashiko
  flagged that globals are shared across every socket the scheduler
  attaches to, so concurrent connections could reset each other's
  state.
- dropped the get_send_calls counter and its assertion: it lived in
  the same global state and can't be read back from userspace once
  the counted storage is per-socket and freed on release. The test
  still exercises multiple scheduling rounds implicitly -- the
  harness's data-transfer size requires several send calls, and the
  addr1/addr2 byte-count checks already confirm the avoided path
  carried no data throughout.
- reformatted the two multi-line comments to put the opening /* on
  its own line, per BPF subsystem comment style.

Changes since v2:
- rebased onto the current export tree, no functional change from v2.

Changes since v1:
- reworked the scheduler to set avoid once, on the first get_send()
  call, and rely on reading it back on every later call rather than
  re-asserting it: the previous version set and read the flag within
  the same call, which doesn't exercise standing state across
  scheduling rounds.
- added the missing extern __ksym declaration for
  mptcp_subflow_active(), matching the existing pattern in
  mptcp_bpf_burst.c.
- declared the mptcp_subflow_set_avoid() extern in this file instead
  of mptcp_bpf.h: checkpatch flags new externs in shared headers, and
  this kfunc has only one caller.

v3: https://lore.kernel.org/all/20260831094651.2682660-3-kalpan.jani@mpiricsoftware.com/
v2: https://lore.kernel.org/all/20260824102741.347492-3-kalpan.jani@mpiricsoftware.com/
v1: https://lore.kernel.org/all/20260715101148.2601045-3-kalpan.jani@mpiricsoftware.com/
---
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 15 ++++
 .../selftests/bpf/progs/mptcp_bpf_avoid.c     | 86 +++++++++++++++++++
 2 files changed, 101 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/mptcp_bpf_avoid.c

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index d77c9f8c53c7..3bff30d0d530 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -18,6 +18,7 @@
 #include "mptcp_bpf_rr.skel.h"
 #include "mptcp_bpf_red.skel.h"
 #include "mptcp_bpf_burst.skel.h"
+#include "mptcp_bpf_avoid.skel.h"
 
 #define NS_TEST "mptcp_ns"
 #define ADDR_1	"10.0.1.1"
@@ -820,6 +821,18 @@ static void test_burst(void)
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
+	mptcp_bpf_avoid__destroy(skel);
+}
+
 void test_mptcp(void)
 {
 	if (test__start_subtest("base"))
@@ -842,4 +855,6 @@ void test_mptcp(void)
 		test_red();
 	if (test__start_subtest("burst"))
 		test_burst();
+	if (test__start_subtest("avoid"))
+		test_avoid();
 }
diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_avoid.c b/tools/testing/selftests/bpf/progs/mptcp_bpf_avoid.c
new file mode 100644
index 000000000000..359b51580087
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_avoid.c
@@ -0,0 +1,86 @@
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
+struct mptcp_avoid_storage {
+	bool avoid_marked;
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_SK_STORAGE);
+	__uint(map_flags, BPF_F_NO_PREALLOC);
+	__type(key, int);
+	__type(value, struct mptcp_avoid_storage);
+} mptcp_avoid_map SEC(".maps");
+
+SEC("struct_ops")
+void BPF_PROG(mptcp_sched_avoid_init, struct mptcp_sock *msk)
+{
+	bpf_sk_storage_get(&mptcp_avoid_map, msk, 0,
+			   BPF_LOCAL_STORAGE_GET_F_CREATE);
+}
+
+SEC("struct_ops")
+void BPF_PROG(mptcp_sched_avoid_release, struct mptcp_sock *msk)
+{
+	bpf_sk_storage_delete(&mptcp_avoid_map, msk);
+}
+
+SEC("struct_ops")
+int BPF_PROG(bpf_avoid_get_send, struct mptcp_sock *msk)
+{
+	struct mptcp_subflow_context *subflow;
+	struct mptcp_avoid_storage *ptr;
+
+	ptr = bpf_sk_storage_get(&mptcp_avoid_map, msk, 0,
+				 BPF_LOCAL_STORAGE_GET_F_CREATE);
+	if (!ptr)
+		return -1;
+
+	/*
+	 * set once, on the first scheduling round, never touched again --
+	 * this is what makes "avoid" different from "scheduled": nothing
+	 * here re-asserts the decision, and the core doesn't clear it
+	 * either.
+	 */
+	if (!ptr->avoid_marked) {
+		int i = 0;
+
+		/* bench every subflow but the first, once */
+		bpf_for_each(mptcp_subflow, subflow, (struct sock *)msk) {
+			if (i++ > 0)
+				mptcp_subflow_set_avoid(subflow, true);
+		}
+		ptr->avoid_marked = true;
+	}
+
+	/*
+	 * every round -- including this one -- just reads back state set
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

