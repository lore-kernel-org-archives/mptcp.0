Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 048A439EF20
	for <mptcp@lists.linux.dev>; Mon, 22 Jun 2026 09:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782121163; cv=none; b=QpJ6czwlr8dSp3wqndVyNBjciplSlUjqlGwc7UFpuwIneiPdCDMb5EbIecRVTnF2QS3niNpntGaB+S82wgORxcweukh68rIApyPqWuvAO4VowUeBIBRrPZjL7YYLVWt2vTXQQJ5R8Jq7YqHUa7GEb9PO0NO2UiDT9cJvOo1ODlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782121163; c=relaxed/simple;
	bh=bCh78dZo2sHquuUBCZaaXydeTmOo5SQeL3E4JgL5T2o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J+Zttoc/Fx2mK5fZO9y36P+xm8fcc+yyKiZJMv3BbJuusc2cqhwsDM5MmQnvBBjdRHQxKROdOJE5it+y9nQAINwzRkqlPdrYa/bEqjbRoM0ypi5h+qCHsdGYA6BffQxfMG853H6+CnC8qwVbqzHaW4S1t5Ps445Q8rOo63jLOEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GMeN5u9b; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GMeN5u9b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B026C1F00A3A;
	Mon, 22 Jun 2026 09:39:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782121161;
	bh=YBj6yhCMlsceLp52pRRElKzmZbd7e0qeJHjKri+Uo3k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GMeN5u9bC5LKfTLR2heIAlBcb8c/Wzsok7daTwoKS0ywQSxoV7WnrJ+BMRiqhQlWL
	 AN/QvMr7OE772VCYIIHsnVo1tV2P1aXCxEDlgws9i+uzA70+uudwLlaz9n7+Qjqoci
	 DWng66wCF0gEz1HOSxAGViCE9UhPajKL7mvMCSoVYXNvac8oF7VxGJyRYyW1wfVhO2
	 WMVfxrd8Rc125mjgAmE04Wk6psf/wWiJBjfSv2UEqIZagx/Ww3IgGIzbARh77rr8sB
	 HcXsnQQib6OOgqoMkREnVj9gNqCDR1gWWPIoQgMns2MeSN8iFHR4bNxHbyZPLBkwYo
	 dL/xhhGA30r9Q==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v3 3/6] Squash to "selftests/bpf: Add bpf_burst scheduler & test"
Date: Mon, 22 Jun 2026 17:39:00 +0800
Message-ID: <3af5e83ca2e41b3003c3db6ef5d16321f2af5699.1782120674.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1782120674.git.tanggeliang@kylinos.cn>
References: <cover.1782120674.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Adapt burst scheduler to use the new bpf_sk_stream_memory_free() signature
(storing subflow pointers instead of sock pointers in send_info array).

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../selftests/bpf/progs/mptcp_bpf_burst.c     | 25 ++++++++++---------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c b/tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c
index 693fab55f7be..48c22f5bce32 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c
@@ -9,6 +9,11 @@ char _license[] SEC("license") = "GPL";
 
 #define MPTCP_SEND_BURST_SIZE	65428
 
+struct bpf_subflow_send_info {
+	struct mptcp_subflow_context *subflow;
+	u64 linger_time;
+};
+
 #define SSK_MODE_ACTIVE	0
 #define SSK_MODE_BACKUP	1
 #define SSK_MODE_MAX	2
@@ -18,7 +23,7 @@ char _license[] SEC("license") = "GPL";
 extern bool mptcp_subflow_active(struct mptcp_subflow_context *subflow) __ksym;
 extern void mptcp_set_timeout(struct sock *sk) __ksym;
 extern __u64 mptcp_wnd_end(const struct mptcp_sock *msk) __ksym;
-extern bool bpf_sk_stream_memory_free(const struct sock *sk) __ksym;
+extern bool bpf_sk_stream_memory_free(const struct mptcp_subflow_context *subflow) __ksym;
 extern bool bpf_mptcp_subflow_queues_empty(struct sock *sk) __ksym;
 extern void mptcp_pm_subflow_chk_stale(const struct mptcp_sock *msk, struct sock *ssk) __ksym;
 
@@ -52,7 +57,7 @@ void BPF_PROG(mptcp_sched_burst_release, struct mptcp_sock *msk)
 SEC("struct_ops")
 int BPF_PROG(bpf_burst_get_send, struct mptcp_sock *msk)
 {
-	struct subflow_send_info send_info[SSK_MODE_MAX];
+	struct bpf_subflow_send_info send_info[SSK_MODE_MAX];
 	struct mptcp_subflow_context *subflow;
 	struct sock *sk = (struct sock *)msk;
 	__u32 pace, burst, wmem;
@@ -62,7 +67,7 @@ int BPF_PROG(bpf_burst_get_send, struct mptcp_sock *msk)
 
 	/* pick the subflow with the lower wmem/wspace ratio */
 	for (i = 0; i < SSK_MODE_MAX; ++i) {
-		send_info[i].ssk = NULL;
+		send_info[i].subflow = NULL;
 		send_info[i].linger_time = -1;
 	}
 
@@ -85,7 +90,7 @@ int BPF_PROG(bpf_burst_get_send, struct mptcp_sock *msk)
 
 		linger_time = div_u64((__u64)ssk->sk_wmem_queued << 32, pace);
 		if (linger_time < send_info[backup].linger_time) {
-			send_info[backup].ssk = ssk;
+			send_info[backup].subflow = subflow;
 			send_info[backup].linger_time = linger_time;
 		}
 	}
@@ -93,18 +98,14 @@ int BPF_PROG(bpf_burst_get_send, struct mptcp_sock *msk)
 
 	/* pick the best backup if no other subflow is active */
 	if (!nr_active)
-		send_info[SSK_MODE_ACTIVE].ssk = send_info[SSK_MODE_BACKUP].ssk;
+		send_info[SSK_MODE_ACTIVE].subflow = send_info[SSK_MODE_BACKUP].subflow;
 
-	ssk = send_info[SSK_MODE_ACTIVE].ssk;
-	if (!ssk || !bpf_sk_stream_memory_free(ssk))
-		return -1;
-
-	subflow = bpf_mptcp_subflow_ctx(ssk);
-	if (!subflow)
+	subflow = send_info[SSK_MODE_ACTIVE].subflow;
+	if (!subflow || !bpf_sk_stream_memory_free(subflow))
 		return -1;
 
 	burst = min(MPTCP_SEND_BURST_SIZE, mptcp_wnd_end(msk) - msk->snd_nxt);
-	ssk = bpf_core_cast(ssk, struct sock);
+	ssk = mptcp_subflow_tcp_sock(subflow);
 	wmem = ssk->sk_wmem_queued;
 	if (!burst)
 		goto out;
-- 
2.53.0

