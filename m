Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF7470811
	for <mptcp@lists.linux.dev>; Thu, 21 Nov 2024 02:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732157168; cv=none; b=BnHLq3h3YQspeJ6P44msBLRLiF5SHgb1CJJQSNGP3IRQ3Aw+1XUNCkrRhDJXeaMm5VWw6DINWg0QJYDm8nTTbGSKKotABuguPCtjmaLx8BxPcIELT6tqxgLplADzyQBlZfrE8nqWwv0d90yG1ZsXV+6iZ1sPD7BAVQUZBGb489U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732157168; c=relaxed/simple;
	bh=Yueh5AaWE3t1dM8SXP/W1ewFHErqQKtbSEylD6STjxc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ebYI5/qeas2KG2lXRP+fMK/rs5Fdb3XJDCvo26/dWJ1sPkRyLJZGQPMli7cfxl0WTgnGEsOs/zqiBIwD8nEWjgGB+upqpxFDvqagoBTC/DL2bSpIC/DXBy/Iq1471e7Tot4gnM2TqXyxR7J+IGLUbemcdnrt5fGiHmAPmDTtn9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tjtw/wSS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tjtw/wSS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DF9BC4CECD;
	Thu, 21 Nov 2024 02:46:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732157168;
	bh=Yueh5AaWE3t1dM8SXP/W1ewFHErqQKtbSEylD6STjxc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Tjtw/wSSI0dMaWJ9ild0hdTIJ2pXm1BOvPi5jVbnHDJc9lPpO2LpsiuVf5Zh2xzUX
	 qpDcpDxxyOEXUqtlRtRtW9XvfaByA3k/8VOzY/6L/LK0ggy/KNrhvSMd5CMSQGuUfn
	 aDfmxf6qqOleFhkxEPQVj5y30biaR6iNvWgoBvnZ3IzZ4Ti38DMjBF9N3WZlx8h+D4
	 ax39xnEXczXt4l4PtWpCKURTpgIXTyUOyBR2vZVFgyKEn7/gUsNSbVwpX+DbuN6wHO
	 ElswIUuZ1IjhIg42mEUqRSZFzGAjxVtUFfKXTNfZoPqxtoDwKqkaWMFUvH0AVFEdxX
	 w/GpNIKRsHedA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: baohua@kernel.org,
	Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 6/8] Squash to "selftests/bpf: Add bpf_burst scheduler & test"
Date: Thu, 21 Nov 2024 10:45:45 +0800
Message-ID: <e6ef2584c86bdbd06c67976e92935b8c0ef55d3d.1732153672.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1732153672.git.tanggeliang@kylinos.cn>
References: <cover.1732153672.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Split get_subflow() interface into two: get_send() and get_retrans().

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../selftests/bpf/progs/mptcp_bpf_burst.c     | 32 ++++++++-----------
 1 file changed, 13 insertions(+), 19 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c b/tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c
index eb21119aa8f7..2785ccbc3807 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c
@@ -9,6 +9,10 @@ char _license[] SEC("license") = "GPL";
 
 #define MPTCP_SEND_BURST_SIZE	65428
 
+#define SSK_MODE_ACTIVE	0
+#define SSK_MODE_BACKUP	1
+#define SSK_MODE_MAX	2
+
 #define min(a, b) ((a) < (b) ? (a) : (b))
 
 struct bpf_subflow_send_info {
@@ -23,10 +27,6 @@ extern bool tcp_stream_memory_free(const struct sock *sk, int wake) __ksym;
 extern bool bpf_mptcp_subflow_queues_empty(struct sock *sk) __ksym;
 extern void mptcp_pm_subflow_chk_stale(const struct mptcp_sock *msk, struct sock *ssk) __ksym;
 
-#define SSK_MODE_ACTIVE	0
-#define SSK_MODE_BACKUP	1
-#define SSK_MODE_MAX	2
-
 static __always_inline __u64 div_u64(__u64 dividend, __u32 divisor)
 {
 	return dividend / divisor;
@@ -67,8 +67,9 @@ void BPF_PROG(mptcp_sched_burst_release, struct mptcp_sock *msk)
 {
 }
 
-static int bpf_burst_get_send(struct mptcp_sock *msk,
-			      struct mptcp_sched_data *data)
+SEC("struct_ops")
+int BPF_PROG(bpf_burst_get_send, struct mptcp_sock *msk,
+	     struct mptcp_sched_data *data)
 {
 	struct bpf_subflow_send_info send_info[SSK_MODE_MAX];
 	struct mptcp_subflow_context *subflow;
@@ -141,8 +142,9 @@ static int bpf_burst_get_send(struct mptcp_sock *msk,
 	return 0;
 }
 
-static int bpf_burst_get_retrans(struct mptcp_sock *msk,
-				 struct mptcp_sched_data *data)
+SEC("struct_ops")
+int BPF_PROG(bpf_burst_get_retrans, struct mptcp_sock *msk,
+	     struct mptcp_sched_data *data)
 {
 	int backup = MPTCP_SUBFLOWS_MAX, pick = MPTCP_SUBFLOWS_MAX, subflow_id;
 	struct mptcp_subflow_context *subflow;
@@ -189,19 +191,11 @@ static int bpf_burst_get_retrans(struct mptcp_sock *msk,
 	return 0;
 }
 
-SEC("struct_ops")
-int BPF_PROG(bpf_burst_get_subflow, struct mptcp_sock *msk,
-	     struct mptcp_sched_data *data)
-{
-	if (data->reinject)
-		return bpf_burst_get_retrans(msk, data);
-	return bpf_burst_get_send(msk, data);
-}
-
-SEC(".struct_ops")
+SEC(".struct_ops.link")
 struct mptcp_sched_ops burst = {
 	.init		= (void *)mptcp_sched_burst_init,
 	.release	= (void *)mptcp_sched_burst_release,
-	.get_subflow	= (void *)bpf_burst_get_subflow,
+	.get_send	= (void *)bpf_burst_get_send,
+	.get_retrans	= (void *)bpf_burst_get_retrans,
 	.name		= "bpf_burst",
 };
-- 
2.43.0

