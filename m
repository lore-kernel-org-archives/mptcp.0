Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D2811E511
	for <mptcp@lists.linux.dev>; Sat, 12 Oct 2024 13:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728740564; cv=none; b=qt/HBY7vlfIfTB3PrONhua32M113nqYVRXEQLAsRujkwB2OGIQ0MBI9WQCBloKk5+aSDnwMxsBoMpvvVROVFrLY+symg/reBYBMLK/Uqcuw/nSKM5B2sR6m3Un3DXnPkkMCJzYwFue9nmdgXi0G1AQZ3Z4SUJMec0WLpotksEjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728740564; c=relaxed/simple;
	bh=vAGk2SNZxJ2K0XaAAadSTnWA8wtWMYR0tx03ZiqDhLQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ny6glvo+yvlH3Z6OWNQWkTggNnSi6INsF2Y2TVIJ+wgyXmPJ/3zIO0Euu1T5GicoIEDvqMcynHCpGeEnJvUhFz0uifHjmJDNVRsjetVpBSUydKgy233EmJQEmYevc0UnX3++8UEMa/Rg/T3e5rapvPYkZeerz6Xe0L8i+DtguUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a9aUr6cI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a9aUr6cI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 520FEC4CEC6;
	Sat, 12 Oct 2024 13:42:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728740564;
	bh=vAGk2SNZxJ2K0XaAAadSTnWA8wtWMYR0tx03ZiqDhLQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=a9aUr6cI/alKhbWYFL1O8HMCIjIjr/C2eKJlBkv+mWOdK6viQQluvh0IGfddNxZFQ
	 +O0TfM15knpy/8w//37IAGLrMIq/j+XCWDs+RStQVaEOxMKkINqhZU9Cyrifq3VpL1
	 rh6wGo4w/uiL+qNxgfyexMe61wUmMt1QDDXGQZSWtKNKE1F6/tdzPcPDtFkXO4WFsW
	 /p6WfjnE0eax5iodyp96l/Jt70axdksHF8raMXbGWYn7fMcw9DooR8i30ncXTldQBj
	 F7pjf8vwAUWhxPWjU8/USLZKsUyPwSUPArTq8z5pcWKfRSTlKevUW3H+Clg3jo9FLJ
	 h0ZaRI8HshxZQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v5 08/11] Squash to "selftests/bpf: Add bpf_red scheduler & test"
Date: Sat, 12 Oct 2024 21:42:13 +0800
Message-ID: <5099187f3e53ca11d81f3ce0d59a657d8ad52bf1.1728738220.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1728738219.git.tanggeliang@kylinos.cn>
References: <cover.1728738219.git.tanggeliang@kylinos.cn>
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
index cc0aab732fc4..ce19d604b898 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_bpf_red.c
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_red.c
@@ -20,12 +20,10 @@ SEC("struct_ops")
 int BPF_PROG(bpf_red_get_subflow, struct mptcp_sock *msk,
 	     struct mptcp_sched_data *data)
 {
-	for (int i = 0; i < data->subflows && i < MPTCP_SUBFLOWS_MAX; i++) {
-		if (!bpf_mptcp_subflow_ctx_by_pos(data, i))
-			break;
+	struct mptcp_subflow_context *subflow;
 
-		mptcp_subflow_set_scheduled(bpf_mptcp_subflow_ctx_by_pos(data, i), true);
-	}
+	bpf_for_each(mptcp_subflow, subflow, msk)
+		mptcp_subflow_set_scheduled(subflow, true);
 
 	return 0;
 }
-- 
2.43.0

