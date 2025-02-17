Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA56F216E1B
	for <mptcp@lists.linux.dev>; Mon, 17 Feb 2025 10:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739788892; cv=none; b=uOlOXon2mNoaOMk+DtwehH2yfoUqN1Cn9/duoT73dsM1+vQ0/cPXjZrDpJq6goudR07NuyPX6UhTUjRbzmhME/dRHvmKuiWRMI9hhb0+JgrVYEtns2b051cTAQR2e2TbAujHAQhjo5VbtdjO9YStKNRc4KChMJotg9HWAtWsgR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739788892; c=relaxed/simple;
	bh=PvRlww9oxwxOA+huQBk1xHRyv5mmqZH7amLe1b0bbxw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XJr8Rmv+liydhw0XwKSUVW20svENVwLIXJJareWQGNUrTOb9VZ8nrc1c1OybzfhXmLw/vMsOMT3ecIqgtWvRSF4+W4jFjoWGqToNqUyx6kFWmoCBWjcIYhgwb7G/wnG3B+QNd3dbcNmf72W8cf8YkVVkyDg3DjaXm9MjqzlPB24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kM29NWlL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kM29NWlL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A02C1C4CEE8;
	Mon, 17 Feb 2025 10:41:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739788892;
	bh=PvRlww9oxwxOA+huQBk1xHRyv5mmqZH7amLe1b0bbxw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kM29NWlLViKI9VroFDvd08WhYtFA/A9zdVsEfvlMuJxEiQDS8VZsAorowBrN0sjuX
	 pG29z2JPAvPK9xF09sFZ75PaoujEi6MxmXUaNbLLS+bpav1KA2TPoGXsoIBbBT6eym
	 N/EluCcwqLB9NuMFUuFiX5Rib4yHejD71QLUqoT4qYewjpB8i/v+RgZwBRIDD/d4/0
	 2Nz4yd6updEUNjlng/lbMI8vEuaa1nHDjeIQPWttCA4KY6XP6Zlb1759w7Mfoq/Vm8
	 b13YJebscD7kHtMVEcD2l+MJABswmHNg5lUJrdhI2w9AT26i5cVJ0yQlQGZcDfL7mu
	 ioSUe4asuG33w==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v15 6/8] Squash to "selftests/bpf: Add bpf_red scheduler & test"
Date: Mon, 17 Feb 2025 18:41:16 +0800
Message-ID: <b4a5e5ef2a42e5ce520703810812b903924e2ccb.1739788598.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1739788598.git.tanggeliang@kylinos.cn>
References: <cover.1739788598.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Use the newly added bpf_for_each() helper to walk the conn_list.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/bpf/progs/mptcp_bpf_red.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_red.c b/tools/testing/selftests/bpf/progs/mptcp_bpf_red.c
index 627502e3c851..9f2cab4ba3f7 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_bpf_red.c
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_red.c
@@ -20,12 +20,10 @@ SEC("struct_ops")
 int BPF_PROG(bpf_red_get_send, struct mptcp_sock *msk,
 	     struct mptcp_sched_data *data)
 {
-	for (int i = 0; i < data->subflows && i < MPTCP_SUBFLOWS_MAX; i++) {
-		if (!bpf_mptcp_subflow_ctx_by_pos(data, i))
-			break;
+	struct mptcp_subflow_context *subflow;
 
-		mptcp_subflow_set_scheduled(bpf_mptcp_subflow_ctx_by_pos(data, i), true);
-	}
+	bpf_for_each(mptcp_subflow, subflow, (struct sock *)msk)
+		mptcp_subflow_set_scheduled(subflow, true);
 
 	return 0;
 }
-- 
2.43.0

