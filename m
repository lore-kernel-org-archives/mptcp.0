Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56D6770811
	for <mptcp@lists.linux.dev>; Thu, 21 Nov 2024 02:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732157164; cv=none; b=LF9rVn+Ckcs1jn6c+i2JeUDLaE1wTRzcM0ww4CB0YTTJrTOsS/3/oeL/7yr1zlnBQoeu/xPniiA+dG6AE8NLankldBv5GxOGVPXjedRia4PrWegu5Lj4TM9gkfWhykTmm7ty5fPsEooLUCoKpjCe+XhAzKgfhsJSMVfc5IOqvLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732157164; c=relaxed/simple;
	bh=AeWZtJ5U7Ugzbhy2UmQVa5y4LFmY0aV3WatqrX5zEsc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JWoU656MAiSiYtx4PxQ8p8rWiLqGOPNjUrUbH9PggAhtSAgXVV2YrJG9dK7q/b9em9MYA2K34Nt0VBDi6ooKWUKWrI60fCzNN1Ew0Sw+CkxPOl5PY8FdzTnLFEHrytNj9RwfeVpvFr1bk8Ll2LgBJR1Z5s/2746QYgpxk1th6qQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MhDsxwyO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MhDsxwyO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55EF8C4CECD;
	Thu, 21 Nov 2024 02:46:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732157163;
	bh=AeWZtJ5U7Ugzbhy2UmQVa5y4LFmY0aV3WatqrX5zEsc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MhDsxwyO8v9XUhuu62CH3sJ3hUp2gME7jYXoHFQ46iRu8lzwF5UhP7fJQWgiLPWgk
	 1xK3KuqkvE4rbasyq+OOHW3hm/c/orbivLiB0fYchE99Ya3g2yHr4ATET0rHFygSj8
	 H2ZvPAoGCyfC2mBZjKwmvIM+KHw2cHoNI68WrlPpemI9TVTcrpaac9jM/MQekehQuR
	 L+7EQNhGhR+8wDZewR4dN/RAssZYByHlrJO6r8B+iFhTazlE6Ewo533M1Jqc14UJsh
	 Kxm9qYD8ukfD4DxoWKg8uKFKrmxsGZZN2JGm89WUId0Q1yQV7I8BY4F/ZbEvGuNInh
	 Q67hMPCHsyLpA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: baohua@kernel.org,
	Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 4/8] Squash to "selftests/bpf: Add bpf_rr scheduler & test"
Date: Thu, 21 Nov 2024 10:45:43 +0800
Message-ID: <9f2ffc12379e38ec5f9b5dde113b9cbd57855f0d.1732153672.git.tanggeliang@kylinos.cn>
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
 .../selftests/bpf/progs/mptcp_bpf_rr.c        | 24 +++++++++++++++----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c b/tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c
index 638ea6aa63b7..ec7853a9716c 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c
@@ -30,9 +30,8 @@ void BPF_PROG(mptcp_sched_rr_release, struct mptcp_sock *msk)
 	bpf_sk_storage_delete(&mptcp_rr_map, msk);
 }
 
-SEC("struct_ops")
-int BPF_PROG(bpf_rr_get_subflow, struct mptcp_sock *msk,
-	     struct mptcp_sched_data *data)
+static int bpf_rr_get_subflow(struct mptcp_sock *msk,
+			      struct mptcp_sched_data *data)
 {
 	struct mptcp_subflow_context *subflow;
 	struct mptcp_rr_storage *ptr;
@@ -69,10 +68,25 @@ int BPF_PROG(bpf_rr_get_subflow, struct mptcp_sock *msk,
 	return 0;
 }
 
-SEC(".struct_ops")
+SEC("struct_ops")
+int BPF_PROG(bpf_rr_get_send, struct mptcp_sock *msk,
+	     struct mptcp_sched_data *data)
+{
+	return bpf_rr_get_subflow(msk, data);
+}
+
+SEC("struct_ops")
+int BPF_PROG(bpf_rr_get_retrans, struct mptcp_sock *msk,
+	     struct mptcp_sched_data *data)
+{
+	return bpf_rr_get_subflow(msk, data);
+}
+
+SEC(".struct_ops.link")
 struct mptcp_sched_ops rr = {
 	.init		= (void *)mptcp_sched_rr_init,
 	.release	= (void *)mptcp_sched_rr_release,
-	.get_subflow	= (void *)bpf_rr_get_subflow,
+	.get_send	= (void *)bpf_rr_get_send,
+	.get_retrans	= (void *)bpf_rr_get_retrans,
 	.name		= "bpf_rr",
 };
-- 
2.43.0

