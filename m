Received: from sender4-of-o54.zoho.com (sender4-of-o54.zoho.com [136.143.188.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 521873FFF9B
	for <mptcp@lists.linux.dev>; Mon, 29 Jun 2026 12:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782734938; cv=pass; b=SDr84cP/LkPnNmV0EEY+6rVUlweG+P5Y4qP3H0f+Y32f6N5dxtZaUOs+JJwFzhuGdTqRNFZ8lZ6bHBbL6o4Rjt6QD863tXymWuODrE3uVmkVye+xu3gUQen7eYWHMu83dbnFkwZ8RCktnMjDQnc/XwPbl7MWaUl2oYVtsnxY2yo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782734938; c=relaxed/simple;
	bh=QXV4rMsLXwskUUDUkDiE7569uoQ7A8ycu/EnXxHwUIU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=J7bxwCm3QLBtmCOSRnvehnjKNJaBWZjaeB8FLjCNaDipfAsPK88kZdb+zbm3Se/cAGj+w/Q08AEG2+ApGVPCeNPm+8Q7rvyfx+5czldu7idzHtOApDuwLwilxhGYlvFYyKW1vrOAOb9FJb3n6gwuSomdymFHMXHtln061Z15DEQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com; spf=pass smtp.mailfrom=mpiricsoftware.com; dkim=fail (0-bit key) header.d=mpiricsoftware.com header.i=shardul.b@mpiricsoftware.com header.b=Nen65Kx3 reason="key not found in DNS"; arc=pass smtp.client-ip=136.143.188.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mpiricsoftware.com header.i=shardul.b@mpiricsoftware.com header.b="Nen65Kx3"
ARC-Seal: i=1; a=rsa-sha256; t=1782734900; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=IyFje8sKLxJ1n+sMV8btIDzDneU2mNcd3y6G6OgN9gbxrOfQuY4+/dCMj4f+Hq+rCiVoWVS74C8wx7TQkc3o0AHZ0lS60I6O72ElhLJHr+N8PT9g3mPLvf0uBT/paHb/PgIpnyCmb9jRm6AuDPVgenp4fBihWnsxJi2OE+alv/0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1782734900; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=2Og1XzI6rzxWO6z7+CakZEkwmnxHyX9Og19BJ4EcMGs=; 
	b=AUExO/vSHI+UtRnaLXqgBsl7Ym52Cjd9YEK0nJrdxJhXnQHcpgxYwRK3GQ14BAG1wpcTue+r8nLifVCGQcWYTfU6tUbpN6ILkCsNKzPDWgxsST6p09RFH6MNY1a56KDNBjPSewJoRw+7Y5dbEe8LVXhzbGy+QN4CO1eALkS/TPg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=mpiricsoftware.com;
	spf=pass  smtp.mailfrom=shardul.b@mpiricsoftware.com;
	dmarc=pass header.from=<shardul.b@mpiricsoftware.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1782734900;
	s=mpiric; d=mpiricsoftware.com; i=shardul.b@mpiricsoftware.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=2Og1XzI6rzxWO6z7+CakZEkwmnxHyX9Og19BJ4EcMGs=;
	b=Nen65Kx3wizR2YXzpMQryJxGeDD6VU0bBGGSb2EfpyB3cjc9IY5mbE/prd+v2WSE
	OX/QIdAWysVeQChywVanj0i8we6wZxJh5LeDytvcHIacFJMBZs0zXLdRHOea2uOo/3z
	HOP38zMwqJnsjTp8h8Kd/J9TxQW24wl4lZB6TIU8=
Received: by mx.zohomail.com with SMTPS id 1782734898475724.6580826874817;
	Mon, 29 Jun 2026 05:08:18 -0700 (PDT)
From: Shardul Bankar <shardul.b@mpiricsoftware.com>
Date: Mon, 29 Jun 2026 17:37:36 +0530
Subject: [PATCH mptcp-next 3/4] selftests/bpf: mptcp: verify scheduler
 rejects non-msk socket to set_timeout
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260629-mptcp_bpf_kfunc_fixes-v1-3-8cc875f36f53@mpiricsoftware.com>
References: <20260629-mptcp_bpf_kfunc_fixes-v1-0-8cc875f36f53@mpiricsoftware.com>
In-Reply-To: <20260629-mptcp_bpf_kfunc_fixes-v1-0-8cc875f36f53@mpiricsoftware.com>
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
 tools/testing/selftests/bpf/prog_tests/mptcp.c     | 31 +++++++++++++
 .../selftests/bpf/progs/mptcp_bpf_bad_sched.c      | 54 ++++++++++++++++++++++
 2 files changed, 85 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index 7f48fd9e94e1e..ff8209ebc8388 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -18,6 +18,7 @@
 #include "mptcp_bpf_rr.skel.h"
 #include "mptcp_bpf_red.skel.h"
 #include "mptcp_bpf_burst.skel.h"
+#include "mptcp_bpf_bad_sched.skel.h"
 
 #define NS_TEST "mptcp_ns"
 #define ADDR_1	"10.0.1.1"
@@ -813,6 +814,34 @@ static void test_burst(void)
 	mptcp_bpf_burst__destroy(skel);
 }
 
+static void test_bad_sched(void)
+{
+	struct mptcp_bpf_bad_sched *skel;
+	char *log = NULL;
+	int err;
+
+	/* bad_sched_get_send() passes a subflow TCP socket to
+	 * bpf_mptcp_set_timeout(), which takes a struct mptcp_sock *. The
+	 * verifier must reject this socket type confusion at load time, and
+	 * for the right reason -- assert the specific verifier message.
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
@@ -835,4 +864,6 @@ void test_mptcp(void)
 		test_red();
 	if (test__start_subtest("burst"))
 		test_burst();
+	if (test__start_subtest("bad_sched"))
+		test_bad_sched();
 }
diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_bad_sched.c b/tools/testing/selftests/bpf/progs/mptcp_bpf_bad_sched.c
new file mode 100644
index 0000000000000..14041c1e5ffd7
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_bad_sched.c
@@ -0,0 +1,54 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026, Mpiric Software. */
+
+/* A scheduler that passes a subflow TCP socket to bpf_mptcp_set_timeout(),
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
+		/* ssk is a subflow TCP socket (struct sock *), not an msk.
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

