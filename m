Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795515771;
	b=Q+pXIdoVAoPYJicWflpVFOCNyjscXggY6EhlFKlXfT6XlDfADVZC/cVOT2VZyMpYsctd
	 Qpf7xDbe19xL899pEZQo84xrxoabkcQgb7cK/Dwu6Ish7Oxu8uoC8gzN9Cc5kFHzTHjqM
	 3gtlwmtxPoyJtUDmqW481KWDG/8PzLIjY5j8lMrxs9nmi0IRAF0H/UNLbzCrCG41jdrgM
	 opVUbnOtzPfyZ3OdeH/207dUyw81DEC8kLAJDr3YenP8Xsm17tLLlBHbZYtXQIz849ao6
	 hP/todaFHl38rzWjbaRJjTdGdjO6tr0PcApHXWO8pApA3Fws3JVvmhlRM9JT0SdVd7g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795515771;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-ZohoMailClient;
	bh=N4lrEpcd8et+a52ywMc+lslexeF9JYaw/RIUcy3J5EM=;
	b=QVssVzI73CMQuMAu/t6Urob104m3+RF5c6iaKLD85QH05eDvrli4LBzW+Ebz3XZP1qA9
	 QOl3V1RRbFk0SYmSYe3RoST9N6ugqQAyvWRNxDe+3uCxbhEFS+AMxgFlmAXzbLa4KAYTC
	 ucVADWUbzWRyQnZ59lbapNWns50xYife2to56dNSCXNA9BTJ72Acg4amEojFZAOFp4Zuj
	 YFuHHcRUEPD6ys91xTpMhfFMAN/FhNaLKmNyp9Z7B31GnVIp8xzEXPT6cRtZQxPjxqF1R
	 Fwl6R7TWb57XNuppGlO3fHU+BfpiWvAvcdJIBc4ujbMjwMb+4qwWRJwxpgMX49P/9Ag==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mpiricsoftware.com;
	spf=pass smtp.mailfrom=mpiricsoftware.com;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.54
Received: from sender6-of-o54.zoho.com (sender6-of-o54.zoho.com [165.173.180.54])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AC46606A32A
	for <mptcp@lists.linux.dev>; Tue, 24 Nov 2026 10:22:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1AC46606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mpiricsoftware.com
ARC-Seal: i=1; a=rsa-sha256; t=1795515756; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=mJIVKlvKvI9etoo/d13oFiYNAtJuglpMG4CljGPH3NeEPeibdUwSaCRphjITJLAFSw8BG1y5qhyaGldV2ytt4gOtHD8O/ckdVY6PvyfK8D5wMq6URXVIjSCIGBzyv243BXrg4pzq3lTrHq48rXzkBVK+gjbkTGCcsJu+eeCAopk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1795515756; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=N4lrEpcd8et+a52ywMc+lslexeF9JYaw/RIUcy3J5EM=; 
	b=mBiv0f24RAuq5Ax0U5zqyO2M3ZPAUlhx+7AGvijlR3QxPfW0ClJfVhPVrDEE/xrRnbYzh2y4t8bGcVpLRDgtS470TePOL0MhSlZt37KccPTimCk29VLENoYXozftZk9jIdZ2PmHCfLqZ0fwEaPsv7OYvRjJi6IZSrooP7owKGkE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=mpiricsoftware.com;
	spf=pass  smtp.mailfrom=kalpan.jani@mpiricsoftware.com;
	dmarc=pass header.from=<kalpan.jani@mpiricsoftware.com>
DKIM-Signature: a=rsa-sha256; b=LPNjaW8uZmZBrt6cHHtFeMI69J2kH5b5aWSC9Qi2qVyO2TyszsfV5F6KeaZ8/ElJ6ZsbXAoXub92gwiJ6FvcmHnst7QE5bzUumTHs2Ebn5o2f41TI/HAKKM+xpKU1rN1++BfTdmlC6lCMqF3kx8n7VCQVXSn4289HP9mevWWikQ=; c=relaxed/relaxed; s=mpiric; d=mpiricsoftware.com; v=1; bh=N4lrEpcd8et+a52ywMc+lslexeF9JYaw/RIUcy3J5EM=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1795515753172581.1298773355794;
	Tue, 24 Nov 2026 02:22:33 -0800 (PST)
From: Kalpan Jani <kalpan.jani@mpiricsoftware.com>
To: mptcp@lists.linux.dev
Cc: shardul.b@mpiricsoftware.com,
	janak@mpiric.us,
	kalpanjani009@gmail.com,
	Kalpan Jani <kalpan.jani@mpiricsoftware.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH mptcp-next v8 2/2] selftests: mptcp: bpf: exercise the subflow avoid flag across rounds
Date: Tue, 24 Nov 2026 15:52:14 +0530
Message-ID: <20261124102214.3930527-3-kalpan.jani@mpiricsoftware.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261124102214.3930527-1-kalpan.jani@mpiricsoftware.com>
References: <20261124102214.3930527-1-kalpan.jani@mpiricsoftware.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Add a BPF struct_ops scheduler selftest for
mptcp_subflow_set_avoid(), and add the required extern declarations
for it and for mptcp_subflow_active().

The test marks the second subflow as avoided once it becomes
available. Unlike a scheduler that filters avoided subflows itself,
the test deliberately schedules both avoided and non-avoided
subflows when they are active.

This exercises the MPTCP core enforcement: when both kinds are
scheduled, the core must discard the avoided selection and retain
the eligible one. When only avoided subflows are selected, the
core falls back to its default selector.

The test also verifies that the avoid state persists across
subsequent scheduling rounds without calling set_avoid() again.
Per-msk state is kept in BPF_MAP_TYPE_SK_STORAGE, following the
pattern used by mptcp_bpf_rr.c.

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/349
Suggested-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Kalpan Jani <kalpan.jani@mpiricsoftware.com>
---
Changes since v7:
- Deliberately schedule both avoided and non-avoided active
  subflows to exercise MPTCP core filtering.
- Verify that the avoid state persists across scheduling rounds
  without setting the flag again.
- Keep per-MPTCP-socket test state in BPF_MAP_TYPE_SK_STORAGE.

v7: https://lore.kernel.org/all/20261123123730.3265284-3-kalpan.jani@mpiricsoftware.com/
---
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 15 ++++
 .../selftests/bpf/progs/mptcp_bpf_avoid.c     | 86 +++++++++++++++++++
 2 files changed, 101 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/mptcp_bpf_avoid.c

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index d77c9f8c53c75..3bff30d0d5300 100644
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
index 0000000000000..4152f9d04a0df
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
+	struct mptcp_subflow_context *first = NULL;
+	struct mptcp_avoid_storage *ptr;
+	bool scheduled = false;
+
+	ptr = bpf_sk_storage_get(&mptcp_avoid_map, msk, 0,
+				 BPF_LOCAL_STORAGE_GET_F_CREATE);
+	if (!ptr)
+		return -1;
+
+	/*
+	 * Mark the second subflow as avoided once, but deliberately
+	 * schedule it when active. Core should filter it when another
+	 * non-avoided subflow is scheduled.
+	 */
+	bpf_for_each(mptcp_subflow, subflow, (struct sock *)msk) {
+		if (!first) {
+			first = subflow;
+			continue;
+		}
+
+		if (!ptr->avoid_marked) {
+			mptcp_subflow_set_avoid(subflow, true);
+			ptr->avoid_marked = true;
+		}
+
+		if (mptcp_subflow_active(subflow)) {
+			mptcp_subflow_set_scheduled(subflow, true);
+			scheduled = true;
+		}
+	}
+
+	if (first && mptcp_subflow_active(first)) {
+		mptcp_subflow_set_scheduled(first, true);
+		scheduled = true;
+	}
+
+	return scheduled ? 0 : -1;
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

