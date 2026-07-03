Received: from sender4-of-o54.zoho.com (sender4-of-o54.zoho.com [136.143.188.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35869279917
	for <mptcp@lists.linux.dev>; Fri,  3 Jul 2026 16:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783097898; cv=pass; b=R8snNwPfAvJTe6Uy2NSvUDBHBWqZkf2lJSUV6Wa3lUj314Yy/+vMBVa6p4FncGPfKMzgAt6vT3o4oq6wuGPeHZQGyFjk9434kmSAiujtJtD1YNig1139PoeSx+MYMIt5EIxgbAnvzBgzDyckhJ8oCiD2SGyRsxZBjHNyZzICrEI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783097898; c=relaxed/simple;
	bh=PBZk+X+zay5nYmuEXtIoToO+sxPsG/PhuKBW/BwG42Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BC8IARrUg3db5Wz7D1xpLcjCEqg8OJabe5daUO3ohVjeklemx9pG0bFEiENiqA1hdQy5q6O4KaDvhlniBC/od+ODvMdN4ZSsiOGQ9W5/RbVhF+NBHwPjBKmrIIMJZfp1zjwO3xyD8wP0kLaekbuEMBI/M9EDfwQSXCzSycoXOpY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com; spf=pass smtp.mailfrom=mpiricsoftware.com; dkim=fail (0-bit key) header.d=mpiricsoftware.com header.i=shardul.b@mpiricsoftware.com header.b=FE93siVw reason="key not found in DNS"; arc=pass smtp.client-ip=136.143.188.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mpiricsoftware.com header.i=shardul.b@mpiricsoftware.com header.b="FE93siVw"
ARC-Seal: i=1; a=rsa-sha256; t=1783097863; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=nRL4uIdM22oPBMCGfAKpskR2wlkROxqnb9vQg0y4C181RCgULU+eLpt6rbX2ikJQxIdBg2MchPIJ8dFur/nkkeyUWCa8bPfeZuMNXwuxAK1XyxjHNA04cUatn9y32R/mxxGV/h/yQovwj93vy8C+4RSSU1yvCdAXlo1qceti8Zw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1783097863; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=WAQWMWIzY8OIcUEjR7NG7A7tTUa0mOmLqY1I2BAmeDU=; 
	b=kuW49CyTe7ahRQcZ4D4YZETj3dACcI0NT6Vq86XfYNhxp0O3QC0Q73wueNIgiqjFY0+JUPoRfyeKSpvDohkwgnGtEvm+UIQYhrbLJrUqYHXwf35IRzmbEG0ww+y4Tt6T8R8HGiXP6kcGXPMe0UNncsSGbMYKyzfVevS6Nqh6aP0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=mpiricsoftware.com;
	spf=pass  smtp.mailfrom=shardul.b@mpiricsoftware.com;
	dmarc=pass header.from=<shardul.b@mpiricsoftware.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1783097863;
	s=mpiric; d=mpiricsoftware.com; i=shardul.b@mpiricsoftware.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=WAQWMWIzY8OIcUEjR7NG7A7tTUa0mOmLqY1I2BAmeDU=;
	b=FE93siVwdZSHAr6x6YqPXeKl0CNSXyFIQPakjpfnXJg0y5xP/rrly3jAne/5tXMB
	fnbS7vUf1/g3o2MyR7L2ngqwzZgXBpSv6gESrZSHMOjIGcwkeE/K+uRBuwMDTf2sZC5
	JuwesFwlDMF4Ku1JGYADF6x9tM80UftwESYFZIMc=
Received: by mx.zohomail.com with SMTPS id 1783097860844788.9807823215981;
	Fri, 3 Jul 2026 09:57:40 -0700 (PDT)
From: Shardul Bankar <shardul.b@mpiricsoftware.com>
Date: Fri, 03 Jul 2026 22:27:13 +0530
Subject: [PATCH mptcp-next v2 5/5] DO-NOT-MERGE: selftests/bpf: mptcp:
 extend bad scheduler test to the kfunc type contract
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260703-mptcp_bpf_kfunc_fixes-v2-5-87ae3c64dc7e@mpiricsoftware.com>
References: <20260703-mptcp_bpf_kfunc_fixes-v2-0-87ae3c64dc7e@mpiricsoftware.com>
In-Reply-To: <20260703-mptcp_bpf_kfunc_fixes-v2-0-87ae3c64dc7e@mpiricsoftware.com>
To: mptcp@lists.linux.dev, Geliang Tang <geliang@kernel.org>
Cc: Matthieu Baerts <matttbe@kernel.org>, 
 Mat Martineau <martineau@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 kalpan.jani@mpiricsoftware.com, janak@mpiric.us, shardulsb08@gmail.com, 
 Shardul Bankar <shardul.b@mpiricsoftware.com>
X-Mailer: b4 0.15.2
X-ZohoMailClient: External

The bad_sched test covers one socket type confusion: a subflow TCP
socket passed to bpf_mptcp_set_timeout(), which takes a struct
mptcp_sock *. Extend it into a small suite that guards the narrow-typed
scheduler kfunc surface against that bug class, covering both confusion
directions:

  - a subflow sock passed to mptcp_wnd_end() (struct mptcp_sock *), the
    same direction as the set_timeout case;
  - the msk passed to mptcp_subflow_set_scheduled() (struct
    mptcp_subflow_context *), the inverse direction.

Each malicious scheduler is its own struct_ops map. They are loaded one
at a time via bpf_map__set_autocreate(), so each load failure is checked
against its own verifier type-mismatch message.

Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Shardul Bankar <shardul.b@mpiricsoftware.com>
---
 tools/testing/selftests/bpf/prog_tests/mptcp.c     | 56 ++++++++++++++++------
 .../selftests/bpf/progs/mptcp_bpf_bad_sched.c      | 48 +++++++++++++++++++
 2 files changed, 89 insertions(+), 15 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index 177e5318029d4..6f5d8f3ac784f 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -814,32 +814,58 @@ static void test_burst(void)
 	mptcp_bpf_burst__destroy(skel);
 }
 
-static void test_bad_sched(void)
+static void load_bad_sched(struct mptcp_bpf_bad_sched *skel, const char *msg)
 {
-	struct mptcp_bpf_bad_sched *skel;
 	char *log = NULL;
 	int err;
 
+	if (start_libbpf_log_capture())
+		return;
+
+	err = mptcp_bpf_bad_sched__load(skel);
+	log = stop_libbpf_log_capture();
+	ASSERT_ERR(err, "load: bad scheduler must be rejected");
+	ASSERT_HAS_SUBSTR(log, msg, "verifier type-mismatch message");
+	free(log);
+}
+
+static void test_bad_sched(void)
+{
+	struct mptcp_bpf_bad_sched *skel;
+
 	/*
-	 * bad_sched_get_send() passes a subflow TCP socket to
-	 * bpf_mptcp_set_timeout(), which takes a struct mptcp_sock *. The
-	 * verifier must reject this socket type confusion at load time, and
-	 * for the right reason: assert the specific verifier message.
+	 * Each scheduler in mptcp_bpf_bad_sched passes a wrong-subtype socket
+	 * to a narrow-typed scheduler kfunc; the verifier must reject each at
+	 * load time with the specific type-mismatch message. The skel holds
+	 * several such schedulers, so enable one struct_ops map at a time;
+	 * loading them together would fail atomically.
 	 */
+
+	/* subflow sock -> bpf_mptcp_set_timeout(struct mptcp_sock *) */
 	skel = mptcp_bpf_bad_sched__open();
 	if (!ASSERT_OK_PTR(skel, "open: bad_sched"))
 		return;
+	bpf_map__set_autocreate(skel->maps.bad_wnd_end, false);
+	bpf_map__set_autocreate(skel->maps.bad_set_sched, false);
+	load_bad_sched(skel, "expected pointer to STRUCT mptcp_sock");
+	mptcp_bpf_bad_sched__destroy(skel);
 
-	if (start_libbpf_log_capture())
-		goto destroy;
+	/* subflow sock -> mptcp_wnd_end(struct mptcp_sock *) */
+	skel = mptcp_bpf_bad_sched__open();
+	if (!ASSERT_OK_PTR(skel, "open: bad_wnd_end"))
+		return;
+	bpf_map__set_autocreate(skel->maps.bad_sched, false);
+	bpf_map__set_autocreate(skel->maps.bad_set_sched, false);
+	load_bad_sched(skel, "expected pointer to STRUCT mptcp_sock");
+	mptcp_bpf_bad_sched__destroy(skel);
 
-	err = mptcp_bpf_bad_sched__load(skel);
-	log = stop_libbpf_log_capture();
-	ASSERT_ERR(err, "load: bad_sched must be rejected");
-	ASSERT_HAS_SUBSTR(log, "expected pointer to STRUCT mptcp_sock",
-			  "verifier rejects subflow sock to bpf_mptcp_set_timeout");
-	free(log);
-destroy:
+	/* msk -> mptcp_subflow_set_scheduled(struct mptcp_subflow_context *) */
+	skel = mptcp_bpf_bad_sched__open();
+	if (!ASSERT_OK_PTR(skel, "open: bad_set_sched"))
+		return;
+	bpf_map__set_autocreate(skel->maps.bad_sched, false);
+	bpf_map__set_autocreate(skel->maps.bad_wnd_end, false);
+	load_bad_sched(skel, "expected pointer to STRUCT mptcp_subflow_context");
 	mptcp_bpf_bad_sched__destroy(skel);
 }
 
diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_bad_sched.c b/tools/testing/selftests/bpf/progs/mptcp_bpf_bad_sched.c
index 70e7da42f13a9..a744de8b82859 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_bpf_bad_sched.c
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_bad_sched.c
@@ -12,6 +12,7 @@
 char _license[] SEC("license") = "GPL";
 
 extern void bpf_mptcp_set_timeout(struct mptcp_sock *msk) __ksym;
+extern __u64 mptcp_wnd_end(const struct mptcp_sock *msk) __ksym;
 
 SEC("struct_ops")
 void BPF_PROG(bad_sched_init, struct mptcp_sock *msk)
@@ -54,3 +55,50 @@ struct mptcp_sched_ops bad_sched = {
 	.get_send	= (void *)bad_sched_get_send,
 	.name		= "bpf_bad_sched",
 };
+
+/*
+ * Same confusion class as bad_sched, on another struct mptcp_sock * kfunc:
+ * feed a subflow TCP socket to mptcp_wnd_end(). The verifier must reject it
+ * ("expected pointer to STRUCT mptcp_sock"). get_send is the only required
+ * scheduler op, so the rest are omitted.
+ */
+SEC("struct_ops")
+int BPF_PROG(bad_wnd_end_get_send, struct mptcp_sock *msk)
+{
+	struct mptcp_subflow_context *subflow;
+	struct sock *ssk;
+
+	bpf_for_each(mptcp_subflow, subflow, (struct sock *)msk) {
+		ssk = bpf_mptcp_subflow_tcp_sock(subflow);
+		if (!ssk)
+			return -1;
+		if (mptcp_wnd_end((struct mptcp_sock *)ssk))
+			return 0;
+		return -1;
+	}
+	return -1;
+}
+
+SEC(".struct_ops.link")
+struct mptcp_sched_ops bad_wnd_end = {
+	.get_send	= (void *)bad_wnd_end_get_send,
+	.name		= "bpf_bad_wnd_end",
+};
+
+/*
+ * Inverse confusion: feed the msk to mptcp_subflow_set_scheduled(), which
+ * takes a struct mptcp_subflow_context *. The verifier must reject it
+ * ("expected pointer to STRUCT mptcp_subflow_context").
+ */
+SEC("struct_ops")
+int BPF_PROG(bad_set_sched_get_send, struct mptcp_sock *msk)
+{
+	mptcp_subflow_set_scheduled((struct mptcp_subflow_context *)msk, true);
+	return 0;
+}
+
+SEC(".struct_ops.link")
+struct mptcp_sched_ops bad_set_sched = {
+	.get_send	= (void *)bad_set_sched_get_send,
+	.name		= "bpf_bad_set_sch",
+};

-- 
2.34.1

