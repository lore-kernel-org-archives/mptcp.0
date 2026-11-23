Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795437515;
	b=VwiFMNIaWq7o7/wvYYeID8YKR4zj5rvcBYnb/ZMQ4oUk04sr0vIT0lKDELF6vaqrZHwg
	 Ck1IpCEgQsoBN5Me2E8rPH9jC4/fAbtetD3lSw38jA1TU4hAGGo9xUKXKtiC4ADecRPGh
	 0nS8DIJohT1yd6Xebqs22XnlQzHFDrWuJu0DLwB6eLzT6T0LQkmgXBiY9tgBdAQT4W3gR
	 6h9qwhGpQPpF0wydKrh0L+PYqR77fxLYVm2A15/X7jrl5pTP8TtWAfN1KNKVkf0lSO0vD
	 tici4MItND/1VxGkjQgzuQlDymWnlHUXjNHjADtTfAR68LdpHBkAmnMRSD9X8fUMEag==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795437515;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-ZohoMailClient;
	bh=dDJ86tOBRnsW9dFh+36OPAHgLKR0yh0qbfy6/F+hbKM=;
	b=K/fMQYUcAM2glK9hMEzSNpuTecA/Z1r3Qkq48OCuCRUfx9ofDfKwgO8qBhJSulnvZmcB
	 3srXgEze3eplSXvsQsT21sxJ5Qmu0f8OcnRobDutPzXJVC742ifiEMaHqma68kTphysVE
	 0dzKWg0E1tFnkVdLedTriRxYtJa3MKCOYKeWu56nO1YVbbacnsPp2aSEEH+x6+ZD4pNRZ
	 JerwrMwU6IouLPMx7RB25FefjT0Ev7MC9RXLcIKsIY33U1z6lxASd5pUmkHwhEnzV3l78
	 ICfU+1mPK0BJ94Dmi+6LNTlSeA9eqIF8qiIHAY4Hmge96Z4n4luCBF10SqdsomtRfrg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mpiricsoftware.com;
	spf=pass smtp.mailfrom=mpiricsoftware.com;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.54
Received: from sender5-of-o54.zoho.com (sender5-of-o54.zoho.com [165.173.182.54])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C128F606A31E
	for <mptcp@lists.linux.dev>; Mon, 23 Nov 2026 12:38:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C128F606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mpiricsoftware.com
ARC-Seal: i=1; a=rsa-sha256; t=1795437475; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=c79UE46YOFqh//Rm2wSoegMWUgRmsxvyCGisFf60X1Dm3K6Oy7EU1i7le8aiKzTnZ1OkAt/P/1BnEOpflDYOoICGdykXX12zJJR6JF+Mtw5qwod0S9fingpzQYlutN9nKpA4CUSys8jJ08YnSJfNXvxR3oO3lYU2eaJWB/eayIU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1795437475; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=dDJ86tOBRnsW9dFh+36OPAHgLKR0yh0qbfy6/F+hbKM=; 
	b=l3xDd/SAL4h4jgsYvwcEoVeDzVZ8BUR1KaoAVGkideV14PoTmRzUGL3FXJiqiTdmP6j2QwFTuiy1iP5MntUJEcufK8VnhEV8in5ZvSabTbgrfmzKqXPG+f89TLD59Xb9BogLc1r//2A9Dh5kKBybtKKlwTlq+Km/mcSEUndObGY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=mpiricsoftware.com;
	spf=pass  smtp.mailfrom=kalpan.jani@mpiricsoftware.com;
	dmarc=pass header.from=<kalpan.jani@mpiricsoftware.com>
DKIM-Signature: a=rsa-sha256; b=i8Ds4mvvDPOJYZiKepuUY7QcN2ZNBsjU+3ZP0kkBQM3dkrvOjqCAPwKH8ZvWGgnpGcStkOkNsE1me2DZzN0y/4UnEUKPhQ1eD40la5kLoq3Bk13qBEdGGqQPd3wNUTbi5BNJg7fRKHqm6h2eZs2H+br0dQsTzGPiI8Ol8LfDhu4=; c=relaxed/relaxed; s=mpiric; d=mpiricsoftware.com; v=1; bh=dDJ86tOBRnsW9dFh+36OPAHgLKR0yh0qbfy6/F+hbKM=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1795437473234871.2473021885332;
	Mon, 23 Nov 2026 04:37:53 -0800 (PST)
From: Kalpan Jani <kalpan.jani@mpiricsoftware.com>
To: mptcp@lists.linux.dev
Cc: shardul.b@mpiricsoftware.com,
	janak@mpiric.us,
	kalpanjani009@gmail.com,
	Kalpan Jani <kalpan.jani@mpiricsoftware.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH mptcp-next v7 2/2] selftests: mptcp: bpf: exercise the subflow avoid flag across rounds
Date: Mon, 23 Nov 2026 18:07:30 +0530
Message-ID: <20261123123730.3265284-3-kalpan.jani@mpiricsoftware.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261123123730.3265284-1-kalpan.jani@mpiricsoftware.com>
References: <20261123123730.3265284-1-kalpan.jani@mpiricsoftware.com>
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

Add a BPF struct_ops scheduler selftest for mptcp_subflow_set_avoid(),
and add the required extern declarations for it and for
mptcp_subflow_active(), both declared locally in this file rather
than in the shared mptcp_bpf.h. mptcp_subflow_active()'s extern was
missing here even though the other BPF scheduler progs already have
it (see mptcp_bpf_burst.c).

"scheduled" gets cleared by the core after every single send/retrans
pass, so a scheduler has to set it again every round. This test's
scheduler does the opposite on purpose: it marks a subflow avoided
exactly once, once a second subflow is available, and never calls
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
---
v6: https://lore.kernel.org/all/20261123100821.2228839-3-kalpan.jani@mpiricsoftware.com/
---
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 15 ++++
 .../selftests/bpf/progs/mptcp_bpf_avoid.c     | 87 +++++++++++++++++++
 2 files changed, 102 insertions(+)
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
index 0000000000000..8276ceb0e5397
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_avoid.c
@@ -0,0 +1,87 @@
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
+
+	ptr = bpf_sk_storage_get(&mptcp_avoid_map, msk, 0,
+				 BPF_LOCAL_STORAGE_GET_F_CREATE);
+	if (!ptr)
+		return -1;
+
+	/*
+	 * Wait until a second subflow exists before marking it avoided.
+	 * This keeps the state unset until there is actually a subflow
+	 * to exercise.
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
+			continue;
+		}
+
+		if (subflow->avoid)
+			continue;
+
+		if (mptcp_subflow_active(subflow)) {
+			mptcp_subflow_set_scheduled(subflow, true);
+			return 0;
+		}
+	}
+
+	if (first && mptcp_subflow_active(first) && !first->avoid)
+		mptcp_subflow_set_scheduled(first, true);
+
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

