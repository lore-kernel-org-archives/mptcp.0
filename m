Received: from sender4-of-o54.zoho.com (sender4-of-o54.zoho.com [136.143.188.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B4B3FFFA9
	for <mptcp@lists.linux.dev>; Mon, 29 Jun 2026 12:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782734948; cv=pass; b=YGwIeyiT8qmfaPgSwea7w3v3AzDSoB9r+RJFrGtyoVlHim1jzJ8wYYC1DkcXSISzZXHQBYF9TRr+RKKuQ/kYdEu6uf+dAR+KHp/Y+bPKNkdG1+dVb7VYros79lnSdqHX/SP91Ttk8rijsgx1lq7LjzLVRU/bopuluwUC6vUE9d4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782734948; c=relaxed/simple;
	bh=EttVtN54NpoGL7JfXlrlA4qAUNyNqkIw/Bu0aeGrzfY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=J9qgSgEFAWYXKPPpiS5tPnbuL14G9kln1YkBCGzyI3G83Zs+uLHhwzvkBvInZQDrjMuanHjYLLMAjAZrFMwbuZ/76y/aaahsAerMQ/wNBRxWJZNby0OAYdnBHkIyqfLbY7zsvIkHvtX7D+WOoX3zDFc8JhLYyK9pXTOxHfLIOCo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com; spf=pass smtp.mailfrom=mpiricsoftware.com; dkim=fail (0-bit key) header.d=mpiricsoftware.com header.i=shardul.b@mpiricsoftware.com header.b=FRvH69if reason="key not found in DNS"; arc=pass smtp.client-ip=136.143.188.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mpiricsoftware.com header.i=shardul.b@mpiricsoftware.com header.b="FRvH69if"
ARC-Seal: i=1; a=rsa-sha256; t=1782734904; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=PtukDSFkcRP9Gfpk/A0LIm8v0UkSdRjBBCx5GAcGug1HWTzS0OgdCUKxxXBTEc1dg3toTit6N2fQHsW+lY6snnmDGcDs4Vnf+ME/SihcnG909lw+RIhRjmZ+DWVvMIrNEeyE+KSj1oi8Uk8BqLASHU/XglJlKccekeD9nLO+ZJ0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1782734904; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=ph5R66zjCHV6C8PjS/H7PwukS1lyNzE3pnl9UKB78Jc=; 
	b=A8hABng3QedY+r43wWAMD8fgqJY2gzweGwdzeHEsV47k0YaJGbm6rfwfMXSU6H9ZvvzM1CfSkSwcafL3KPMC6jNefNHd9grxoN5FZvIE4cUzBDNmLgdtDwExZDPu09BAnqSXp35rfZ/JcSoHAvQe1G+jzinPz8ao1AwrqfsSS8c=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=mpiricsoftware.com;
	spf=pass  smtp.mailfrom=shardul.b@mpiricsoftware.com;
	dmarc=pass header.from=<shardul.b@mpiricsoftware.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1782734904;
	s=mpiric; d=mpiricsoftware.com; i=shardul.b@mpiricsoftware.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=ph5R66zjCHV6C8PjS/H7PwukS1lyNzE3pnl9UKB78Jc=;
	b=FRvH69if6FyKUP8yDlKbfdle9AWk/27f5kROraU4qShTZdLzBTfjW+iA01g9r1RF
	iDaa4vLhm7sjOGgTcPfS1yU9fTmTEdadcYeO6fsXOhfnBmOLs1k1YKeTup0Nt28B3Zz
	ssVoma2u1+hUT/tefoUwOs8m6bJWbSsHcVDyiwPI=
Received: by mx.zohomail.com with SMTPS id 1782734902250143.41331820486255;
	Mon, 29 Jun 2026 05:08:22 -0700 (PDT)
From: Shardul Bankar <shardul.b@mpiricsoftware.com>
Date: Mon, 29 Jun 2026 17:37:37 +0530
Subject: [PATCH mptcp-next 4/4] selftests/bpf: mptcp: extend bad scheduler
 test to the kfunc type contract
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260629-mptcp_bpf_kfunc_fixes-v1-4-8cc875f36f53@mpiricsoftware.com>
References: <20260629-mptcp_bpf_kfunc_fixes-v1-0-8cc875f36f53@mpiricsoftware.com>
In-Reply-To: <20260629-mptcp_bpf_kfunc_fixes-v1-0-8cc875f36f53@mpiricsoftware.com>
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
 .../selftests/bpf/progs/mptcp_bpf_bad_sched.c      | 46 ++++++++++++++++++
 2 files changed, 87 insertions(+), 15 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index ff8209ebc8388..76a112d56f358 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -814,31 +814,57 @@ static void test_burst(void)
 	mptcp_bpf_burst__destroy(skel);
 }
 
-static void test_bad_sched(void)
+static void load_bad_sched(struct mptcp_bpf_bad_sched *skel, const char *msg)
 {
-	struct mptcp_bpf_bad_sched *skel;
 	char *log = NULL;
 	int err;
 
-	/* bad_sched_get_send() passes a subflow TCP socket to
-	 * bpf_mptcp_set_timeout(), which takes a struct mptcp_sock *. The
-	 * verifier must reject this socket type confusion at load time, and
-	 * for the right reason -- assert the specific verifier message.
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
+	/* Each scheduler in mptcp_bpf_bad_sched passes a wrong-subtype socket
+	 * to a narrow-typed scheduler kfunc; the verifier must reject each at
+	 * load time with the specific type-mismatch message. The skel holds
+	 * several such schedulers, so enable one struct_ops map at a time --
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
index 14041c1e5ffd7..ce853ec6d73da 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_bpf_bad_sched.c
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_bad_sched.c
@@ -11,6 +11,7 @@
 char _license[] SEC("license") = "GPL";
 
 extern void bpf_mptcp_set_timeout(struct mptcp_sock *msk) __ksym;
+extern __u64 mptcp_wnd_end(const struct mptcp_sock *msk) __ksym;
 
 SEC("struct_ops")
 void BPF_PROG(bad_sched_init, struct mptcp_sock *msk)
@@ -52,3 +53,48 @@ struct mptcp_sched_ops bad_sched = {
 	.get_send	= (void *)bad_sched_get_send,
 	.name		= "bpf_bad_sched",
 };
+
+/* Same confusion class as bad_sched, on another struct mptcp_sock * kfunc:
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
+/* Inverse confusion: feed the msk to mptcp_subflow_set_scheduled(), which
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

