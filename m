Received: from sender4-of-o54.zoho.com (sender4-of-o54.zoho.com [136.143.188.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2F3D43C05C
	for <mptcp@lists.linux.dev>; Wed, 15 Jul 2026 10:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784110348; cv=pass; b=VcJ/+f4Hz7ea24XvNGphfeeCR24SMqA52Mn9aSs067x2r5m214NoXfGUFUpGLcday5K1LIBJ7eamKBl+SMfJvS+6SrVwkKV8S9d7G4KK++iUD0PU6uOoJJsCZyQxYLhD/5OFZPXqvBWwXCIImr7P4/2Acs0IVW5tsNsjh29a+/M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784110348; c=relaxed/simple;
	bh=dFrRjVkZILMjot8qM85CT16bIODOee03C0604vL3jXA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FVuMoUC00VpjvGZsYdgzy0/nDRV4h0UkQud/QZUNcxtiAt2BIGooklwek0/tlupZGez9qxWMmsANEAKWouX4ofbjUplz8LdrrkTZWCHrR9f6xm8ECPbGSSYJMYDInXr8wQe2Vwp5p0jioIttll5Lw4jEp4tLtB6aWcV2TX+63M4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com; spf=pass smtp.mailfrom=mpiricsoftware.com; dkim=fail (0-bit key) header.d=mpiricsoftware.com header.i=kalpan.jani@mpiricsoftware.com header.b=G57iG0z+ reason="key not found in DNS"; arc=pass smtp.client-ip=136.143.188.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mpiricsoftware.com header.i=kalpan.jani@mpiricsoftware.com header.b="G57iG0z+"
ARC-Seal: i=1; a=rsa-sha256; t=1784110329; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Kd38xewy279gJH9WcfruhoGfv0u/lqYxVT5H+bHuyH95R4s1GJ+JIoHPsMMoJaSLrebvMkTnpjrU1ixJmppdyT7FFC33b/PRxv+i9tS6a7f2RAnHo6ZgoYDRg2nNEXgitFh9+z5kGWn8D+wRU2/kbOAOW3vyiXpRph34I1BJEvY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1784110329; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=yJ/9zBmpzEg3UnueOe1BYVlDazqPAZ5NECaXzojnB2g=; 
	b=Kmiln8bue+TfxyAEz2BIv4hWyq3NCfXeMwPbGVN997OTVK0H8Ed4Ly1LOl5pb4y4LauSx1xsOdhdgyWrjbes/06yCdHlqxS6wWAZ52bwn6gSZujBAglvlbzk6l1cqnAVj2PwY5rWkjwFFCMJGc9EQuAVZMln2C56qhWUc0bBq2s=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=mpiricsoftware.com;
	spf=pass  smtp.mailfrom=kalpan.jani@mpiricsoftware.com;
	dmarc=pass header.from=<kalpan.jani@mpiricsoftware.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1784110328;
	s=mpiric; d=mpiricsoftware.com; i=kalpan.jani@mpiricsoftware.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=yJ/9zBmpzEg3UnueOe1BYVlDazqPAZ5NECaXzojnB2g=;
	b=G57iG0z+hU84t7PszNZov6Asm2on5cDo9exxdX0bgHTZoCEb2pTMNl7wD+GMNYyB
	dxgLL9tNQk9kEB/xRs4We6vcZCZPI+C2D11H9qt7OecVZRZe+CCU6LAZiTZm4luW/c1
	BZWnaqu8UMrkCg74KEONAU+4pAtxefkomXtsvDPY=
Received: by mx.zohomail.com with SMTPS id 1784110327128824.119895923827;
	Wed, 15 Jul 2026 03:12:07 -0700 (PDT)
From: Kalpan Jani <kalpan.jani@mpiricsoftware.com>
To: mptcp@lists.linux.dev
Cc: matttbe@kernel.org,
	martineau@kernel.org,
	pabeni@redhat.com,
	shardul.b@mpiricsoftware.com,
	janak@mpiric.us,
	kalpanjani009@gmail.com,
	akshit@mpiricsoftware.com
Subject: [PATCH mptcp-next 2/2] selftests: mptcp: bpf: exercise the subflow avoid flag
Date: Wed, 15 Jul 2026 15:41:48 +0530
Message-ID: <20260715101148.2601045-3-kalpan.jani@mpiricsoftware.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260715101148.2601045-1-kalpan.jani@mpiricsoftware.com>
References: <20260715101148.2601045-1-kalpan.jani@mpiricsoftware.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Add a BPF struct_ops scheduler selftest for the new
mptcp_subflow_set_avoid() kfunc. The scheduler marks every subflow except
the first as "avoid", then schedules only a subflow whose avoid flag is
clear. The existing send_data_and_verify() harness confirms the avoided
path carried no data, exercising the kfunc round-trip from eBPF: set the
flag, read it back, and honour it.

This also adds the BPF-side extern declaration for
mptcp_subflow_set_avoid(); without it a BPF program cannot compile a call
to the kfunc, as the kernel-side BTF registration alone is not enough.

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/349
Signed-off-by: Kalpan Jani <kalpan.jani@mpiricsoftware.com>
---
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 15 ++++++
 tools/testing/selftests/bpf/progs/mptcp_bpf.h |  2 +
 .../selftests/bpf/progs/mptcp_bpf_avoid.c     | 49 +++++++++++++++++++
 3 files changed, 66 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/mptcp_bpf_avoid.c

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index 7f48fd9e94e1..1b88806a7a86 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -17,6 +17,7 @@
 #include "mptcp_bpf_bkup.skel.h"
 #include "mptcp_bpf_rr.skel.h"
 #include "mptcp_bpf_red.skel.h"
+#include "mptcp_bpf_avoid.skel.h"
 #include "mptcp_bpf_burst.skel.h"
 
 #define NS_TEST "mptcp_ns"
@@ -813,6 +814,18 @@ static void test_burst(void)
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
@@ -835,4 +848,6 @@ void test_mptcp(void)
 		test_red();
 	if (test__start_subtest("burst"))
 		test_burst();
+	if (test__start_subtest("avoid"))
+		test_avoid();
 }
diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf.h b/tools/testing/selftests/bpf/progs/mptcp_bpf.h
index de450b2eaf0f..a60b66762274 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_bpf.h
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf.h
@@ -48,5 +48,7 @@ bpf_mptcp_subflow_tcp_sock(const struct mptcp_subflow_context *subflow) __ksym;
 
 extern void mptcp_subflow_set_scheduled(struct mptcp_subflow_context *subflow,
 					bool scheduled) __ksym;
+extern void mptcp_subflow_set_avoid(struct mptcp_subflow_context *subflow,
+				    bool avoid) __ksym;
 
 #endif
diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_avoid.c b/tools/testing/selftests/bpf/progs/mptcp_bpf_avoid.c
new file mode 100644
index 000000000000..3678781f346a
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_avoid.c
@@ -0,0 +1,49 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026, MPTCP. */
+
+#include "mptcp_bpf.h"
+#include <bpf/bpf_tracing.h>
+
+char _license[] SEC("license") = "GPL";
+
+SEC("struct_ops")
+void BPF_PROG(mptcp_sched_avoid_init, struct mptcp_sock *msk)
+{
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
+	int i = 0;
+
+	/* bench every subflow except the first one */
+	bpf_for_each(mptcp_subflow, subflow, (struct sock *)msk) {
+		if (i++ > 0)
+			mptcp_subflow_set_avoid(subflow, true);
+	}
+
+	/* only schedule a subflow that is NOT avoided */
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

