Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793486699;
	b=4Km2iL8KdZOduiQ7GDWrgvOt+59yGVaeP60zVI25q2UNOuFKqNrYmQvXhrQopUFCaijS
	 LJjnwzCh+rKgZ0ig3/PdwOT7YlRKHC6EZs/upt71shpUhw6k8e8xmapA7ERa46mMKYcm/
	 0kFjd74CCD8p/TosrUCwkPs9xfjuCVBefdivkbdBNji7GmpzsrztJ9kMPc1mZDei7Ftqk
	 rQVJDdUNlRrzhwr8cAcm6eDWEUwFqBh1lGi/k1QQNq5e2nL1KoEY/jyxb7dM9DVwyDvXg
	 FrQgk5T0v4YO4l+w3VtxeDGxIS9qFJAk7vF7RYUtCIyZWGpKAjLuqb3rM/wlZtpn5hg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793486699;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=5hUBN6+1jDOWJ0vdcV75i1F+TIrOX66n/UiAFZSwlvs=;
	b=yfH8MzsxclbEqx4ckHEXfn+rtchcyJlCnxIX+hBBmoL7Vo9oW+Sc5g4LmCtDCNj1r4bE
	 aWyzNgsjA2xD0YuwoSOOmAondkZn+kHY0KvaIw/gg74cjw/9QTGl2FypWQCfD5+9Zyd4G
	 qXv6f6bKizVY7MKED8J5jv2GIFcPbeAmbL80rufuZzhx4dH0ipNHW/ZMEHk/8jSchyf2l
	 ojmlNvm8CSVwEjEDr0MJ2dPD05lDFFScHy8SHpRMvux+27AHcwaZXmd1dgFNHhzlEN67q
	 7XfUW/lqbCVhedMn1wZ1Zmr9H88cDwGcHKhM6rQlhQyemwMlmpLjoZ08HshcqZV9msA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Jhog6En7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF9E606A31A
	for <mptcp@lists.linux.dev>; Sat, 31 Oct 2026 22:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Jhog6En7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BF0A1F00919;
	Sat, 31 Oct 2026 22:44:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793486698;
	bh=5hUBN6+1jDOWJ0vdcV75i1F+TIrOX66n/UiAFZSwlvs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Jhog6En7HRwIOm0rPvv1ei0rGkggz/z5STKUBLYyGn6+nnSNBT7nCvy08gMUQaBlA
	 hhXj2gCZ6M1DO2ZudmUJwONlm8T0DU9elPPaH5MxArFsY5OPuJthYPm1UTk1UzLQI4
	 v0iou5Vzi7PEedjlIOfj2WI6S6+kTvZiDjUN3E3aIvt5TDm4c/DHM/AE7oGEGdHg5B
	 ddMKOZtEmEbnl1n/eY2J1FCeqfF2cG+lhNsA2LvymBvM+scXxb7e//BmhBsIkURIjo
	 zkPP/lZpeM2Rwh9LU9ChdBzaU900+f6ORS/bS1OIWtlgNcKe3Cqs2retxrmvJncVhe
	 WVbqOCcY+E8ew==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Sat, 31 Oct 2026 23:44:40 +0100
Subject: [PATCH mptcp-next v2 8/8] selftests: bpf: mptcp: test a scheduler
 reinjecting on an idle subflow
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261031-mptcp-sched-opp-retrans-v2-8-e9c4a30f6841@kernel.org>
References: <20261031-mptcp-sched-opp-retrans-v2-0-e9c4a30f6841@kernel.org>
In-Reply-To: <20261031-mptcp-sched-opp-retrans-v2-0-e9c4a30f6841@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: Abdul Wasey <w453y.me@gmail.com>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4408; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=YAnRGy+eXCA9l/+DMAAHPkfjni1AGhmQqQqDjDWMwAk=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLKe5Sec2jjX7lqBmPWsRQY5dmfi/rLsLmtxnppwcCbDe
 dac9CaTjlIWBjEuBlkxRRbptsj8mc+reEu8/Cxg5rAygQxh4OIUgIksfMfwv4DBV63YynUvw7wX
 ibcfzwsI+mAcPO2Lf+6V46nadx/yHmdkeLKZ/Z8k04Nvu8WKk2dzpBtJRHPaimY8iK7iuWp08bk
 FIwA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Abdul Wasey <w453y.me@gmail.com>

Add bpf_reinject, a scheduler that sends new data on the first subflow
only, and on an IDLE reason of get_retrans marks the other subflow with a
reinject_limit of 64 KB. The second address then only carries data
resent by the core. The test checks that it did, and that get_retrans
was called with an IDLE reason; the scheduler counts its calls by reason.

Signed-off-by: Abdul Wasey <w453y.me@gmail.com>
---
 tools/testing/selftests/bpf/prog_tests/mptcp.c     | 24 ++++++++
 .../selftests/bpf/progs/mptcp_bpf_reinject.c       | 70 ++++++++++++++++++++++
 2 files changed, 94 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index 4302c16cb6bb..723f42b45827 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -18,6 +18,7 @@
 #include "mptcp_bpf_rr.skel.h"
 #include "mptcp_bpf_red.skel.h"
 #include "mptcp_bpf_burst.skel.h"
+#include "mptcp_bpf_reinject.skel.h"
 #include "mptcp_bpf_limit.skel.h"
 
 #define NS_TEST "mptcp_ns"
@@ -821,6 +822,27 @@ static void test_burst(void)
 	mptcp_bpf_burst__destroy(skel);
 }
 
+/* New data only goes on the first subflow, so the second one only carries
+ * what the scheduler asks the core to reinject when it goes idle.
+ */
+static void test_reinject(void)
+{
+	struct mptcp_bpf_reinject *skel;
+	__u64 idle;
+
+	skel = mptcp_bpf_reinject__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "open_and_load: reinject"))
+		return;
+
+	test_bpf_sched(skel->maps.reinject, "reinject", WITH_DATA, WITH_DATA);
+
+	/* calls[0] counts the MPTCP RTOs, the others the idle reasons */
+	idle = skel->bss->calls[1] + skel->bss->calls[2] + skel->bss->calls[3];
+	ASSERT_GT(idle, 0, "get_retrans called on an idle subflow");
+
+	mptcp_bpf_reinject__destroy(skel);
+}
+
 struct big_send_arg {
 	int lfd;
 	int err;
@@ -946,6 +968,8 @@ void test_mptcp(void)
 		test_red();
 	if (test__start_subtest("burst"))
 		test_burst();
+	if (test__start_subtest("reinject"))
+		test_reinject();
 	if (test__start_subtest("limit"))
 		test_limit();
 }
diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_reinject.c b/tools/testing/selftests/bpf/progs/mptcp_bpf_reinject.c
new file mode 100644
index 000000000000..3e315c7ead67
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_reinject.c
@@ -0,0 +1,70 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include "mptcp_bpf.h"
+#include <bpf/bpf_tracing.h>
+
+char _license[] SEC("license") = "GPL";
+
+/* get_retrans calls, by msk->sched_retrans */
+__u64 calls[4] = {};
+
+SEC("struct_ops")
+void BPF_PROG(mptcp_sched_reinject_init, struct mptcp_sock *msk)
+{
+}
+
+SEC("struct_ops")
+void BPF_PROG(mptcp_sched_reinject_release, struct mptcp_sock *msk)
+{
+}
+
+/* new data only on the first subflow, as bpf_first */
+SEC("struct_ops")
+int BPF_PROG(bpf_reinject_get_send, struct mptcp_sock *msk)
+{
+	struct mptcp_subflow_context *subflow;
+
+	bpf_for_each(mptcp_subflow, subflow, (struct sock *)msk) {
+		if (bpf_mptcp_subflow_tcp_sock(subflow) == msk->first) {
+			mptcp_subflow_set_scheduled(subflow, true);
+			return 0;
+		}
+	}
+	return -1;
+}
+
+/* On an MPTCP RTO, resend on the first subflow. When the core asks because
+ * a subflow is idle, resend up to 64 KB of what the first subflow holds on
+ * another one, so the second address only carries reinjected data.
+ */
+SEC("struct_ops")
+int BPF_PROG(bpf_reinject_get_retrans, struct mptcp_sock *msk)
+{
+	struct mptcp_subflow_context *subflow;
+	__u8 reason = msk->sched_retrans;
+	bool idle = reason != MPTCP_SCHED_RETRANS_RTO;
+
+	if (reason < 4)
+		__sync_fetch_and_add(&calls[reason], 1);
+
+	bpf_for_each(mptcp_subflow, subflow, (struct sock *)msk) {
+		bool first = bpf_mptcp_subflow_tcp_sock(subflow) == msk->first;
+
+		if (first == idle)
+			continue;
+		if (idle)
+			subflow->reinject_limit = 64 * 1024;
+		mptcp_subflow_set_scheduled(subflow, true);
+		return 0;
+	}
+	return -1;
+}
+
+SEC(".struct_ops.link")
+struct mptcp_sched_ops reinject = {
+	.init		= (void *)mptcp_sched_reinject_init,
+	.release	= (void *)mptcp_sched_reinject_release,
+	.get_send	= (void *)bpf_reinject_get_send,
+	.get_retrans	= (void *)bpf_reinject_get_retrans,
+	.name		= "bpf_reinject",
+};

-- 
2.55.0

