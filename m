Received: from mta0.migadu.com (out-233.mta0.migadu.com [91.218.175.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1457F4E50CA
	for <mptcp@lists.linux.dev>; Thu, 17 Sep 2026 08:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789632767; cv=none; b=JUY7KTHm7QJ08ED/iw71eKreS7w8jfpT/GzaA6SCl0vCanL10LjKxM6GvhG9L7D9ewLPSccv9htN3ZX1dxpbU8SdVlU1eJZ3XBWPp09bi10IBftRJy8L7d9hkjgc+IYq3VsRo0XnKnVansGJLSmpv4ubvvX5DvPzg1uzp+ENQfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789632767; c=relaxed/simple;
	bh=oreBxrf8GAK3VaUUt1/2GRlQeYjOscRYT33XUXX05ic=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nPqZjRLvI6KRe5gm+UGJ/klni36FmjkVRm2ebImBI+Un6dUYLDxJ/VFP0JCqHSY3yglM6r3iE2A7i5X9uPgrTAv3jbPNtzrnhSPdTg/hBfb+cL4HIIm9NCf5jUUFG2XljmtZxyemO6DF0EluiLOI9DyCiOkVJ6db56E6qZrcwC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=GkBfuqu+; arc=none smtp.client-ip=91.218.175.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="GkBfuqu+"
X-Envelope-To: mptcp@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=oreBxrf8GAK3VaUUt1/2GRlQeYjOscRYT33XUXX05ic=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789632762; v=1; x=1790237562;
 b=GkBfuqu+HmpmAPXzXIaL3X+2x7ostVTmSqAmpdOgdDip/g/DCiAdE8/7DhjGGBwx5CNQVvV4
 mReYgXvvQe7cf6BK8Wx8XKblnZmMAPMlTiBciuixubCIuFZ+V7WOBfBDQ8USC1DKWH9Hotkq3q+
 VSyoxZm0PI4k7MInJZK+pIU0=
X-Envelope-To: mptcp@lists.linux.dev
Received: by smtp.migadu.com with ESMTPS id d096a69812a48edf;
	Thu, 17 Sep 2026 08:12:42 +0000
X-Mizu-Trace-ID: d096a69812a48edf
X-Migadu-Flow: FLOW_OUT
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: bpf@vger.kernel.org,
	mptcp@lists.linux.dev
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Shuah Khan <shuah@kernel.org>,
	Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	Yazhou Tang <tangyazhou518@outlook.com>,
	Tejun Heo <tj@kernel.org>,
	Matt Bobrowski <mattbobrowski@google.com>,
	Nicolas Rybowski <nicolas.rybowski@tessares.net>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH bpf v1 2/2] selftests/bpf: add verifier tests for bpf_skc_to_mptcp_sock
Date: Thu, 17 Sep 2026 16:11:58 +0800
Message-ID: <20260917081209.361367-2-jiayuan.chen@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260917081209.361367-1-jiayuan.chen@linux.dev>
References: <20260917081209.361367-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Cover what the verifier has to get right for the msk returned by
bpf_skc_to_mptcp_sock(): it must not be accepted by bpf_sk_release(), it
must go away with the subflow it was derived from, and the subflow
reference still has to be released.

  # ./test_progs -t verifier_mptcp
  #658/1   verifier_mptcp/bpf_skc_to_mptcp_sock: release the acquired subflow:OK
  #658/2   verifier_mptcp/bpf_skc_to_mptcp_sock: msk is not the acquired subflow:OK
  #658/3   verifier_mptcp/bpf_skc_to_mptcp_sock: msk dies with the subflow it came from:OK
  #658/4   verifier_mptcp/bpf_skc_to_mptcp_sock: subflow is still owned after the cast:OK
  #658     verifier_mptcp:OK
  Summary: 1/4 PASSED, 0 SKIPPED, 0/0 FAILED

Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
---
 .../selftests/bpf/prog_tests/verifier.c       |   2 +
 .../selftests/bpf/progs/verifier_mptcp.c      | 101 ++++++++++++++++++
 2 files changed, 103 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_mptcp.c

diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
index f7f94ccebce2..63316e4be6bb 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -74,6 +74,7 @@
 #include "verifier_mem_size_reg.skel.h"
 #include "verifier_meta_access.skel.h"
 #include "verifier_movsx.skel.h"
+#include "verifier_mptcp.skel.h"
 #include "verifier_mtu.skel.h"
 #include "verifier_mul.skel.h"
 #include "verifier_netfilter_ctx.skel.h"
@@ -238,6 +239,7 @@ void test_verifier_may_goto_2(void)           { RUN(verifier_may_goto_2); }
 void test_verifier_mem_size_reg(void)         { RUN(verifier_mem_size_reg); }
 void test_verifier_meta_access(void)          { RUN(verifier_meta_access); }
 void test_verifier_movsx(void)                 { RUN(verifier_movsx); }
+void test_verifier_mptcp(void)                { RUN(verifier_mptcp); }
 void test_verifier_mul(void)                  { RUN(verifier_mul); }
 void test_verifier_netfilter_ctx(void)        { RUN(verifier_netfilter_ctx); }
 void test_verifier_netfilter_retcode(void)    { RUN(verifier_netfilter_retcode); }
diff --git a/tools/testing/selftests/bpf/progs/verifier_mptcp.c b/tools/testing/selftests/bpf/progs/verifier_mptcp.c
new file mode 100644
index 000000000000..1f679265e043
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_mptcp.c
@@ -0,0 +1,101 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include "bpf_tracing_net.h"
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+
+char _license[] SEC("license") = "GPL";
+
+__u32 token;
+
+static __always_inline struct bpf_sock *lookup_subflow(struct __sk_buff *skb)
+{
+	struct bpf_sock_tuple tuple = {};
+
+	return bpf_skc_lookup_tcp(skb, &tuple, sizeof(tuple.ipv4),
+				  BPF_F_CURRENT_NETNS, 0);
+}
+
+SEC("tc")
+__description("bpf_skc_to_mptcp_sock: release the acquired subflow")
+__success
+int mptcp_cast_release_subflow(struct __sk_buff *skb)
+{
+	struct mptcp_sock *msk;
+	struct bpf_sock *sk;
+
+	sk = lookup_subflow(skb);
+	if (!sk)
+		return 0;
+
+	msk = bpf_skc_to_mptcp_sock(sk);
+	if (msk)
+		token = msk->token;
+
+	bpf_sk_release(sk);
+	return 0;
+}
+
+SEC("tc")
+__description("bpf_skc_to_mptcp_sock: msk is not the acquired subflow")
+__failure __msg("release helper bpf_sk_release expects referenced PTR_TO_BTF_ID")
+int mptcp_cast_release_msk(struct __sk_buff *skb)
+{
+	struct mptcp_sock *msk;
+	struct bpf_sock *sk;
+
+	sk = lookup_subflow(skb);
+	if (!sk)
+		return 0;
+
+	msk = bpf_skc_to_mptcp_sock(sk);
+	if (!msk) {
+		bpf_sk_release(sk);
+		return 0;
+	}
+
+	bpf_sk_release((struct bpf_sock *)msk);
+	return 0;
+}
+
+SEC("tc")
+__description("bpf_skc_to_mptcp_sock: msk dies with the subflow it came from")
+__failure __msg("invalid mem access 'scalar'")
+int mptcp_cast_use_after_release(struct __sk_buff *skb)
+{
+	struct mptcp_sock *msk;
+	struct bpf_sock *sk;
+
+	sk = lookup_subflow(skb);
+	if (!sk)
+		return 0;
+
+	msk = bpf_skc_to_mptcp_sock(sk);
+	if (!msk) {
+		bpf_sk_release(sk);
+		return 0;
+	}
+
+	bpf_sk_release(sk);
+	token = msk->token;
+	return 0;
+}
+
+SEC("tc")
+__description("bpf_skc_to_mptcp_sock: subflow is still owned after the cast")
+__failure __msg("Unreleased reference")
+int mptcp_cast_leak_subflow(struct __sk_buff *skb)
+{
+	struct mptcp_sock *msk;
+	struct bpf_sock *sk;
+
+	sk = lookup_subflow(skb);
+	if (!sk)
+		return 0;
+
+	msk = bpf_skc_to_mptcp_sock(sk);
+	if (msk)
+		token = msk->token;
+
+	return 0;
+}
-- 
2.43.0

