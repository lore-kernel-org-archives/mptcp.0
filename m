Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1057F2207A
	for <mptcp@lists.linux.dev>; Mon, 23 Dec 2024 10:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734948376; cv=none; b=ZwJJv/mzr9uWZ94Ztg2z4/e5jsXX9sqVCw28lGobIPwZcdJ2m9vWM/h4Q0KmxyBO2+jTcDOupVlPE8gxhXu1Tn7EZHFoHtsXNcgEyCwHiWI+n9CnpmHY+/1+qiO8qg0/Iwf7rtKnzdeil0aJ36v2omMg0cIz9MoSQ8jvikfApKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734948376; c=relaxed/simple;
	bh=LJhaTlZ5GsjCDXTz1dPDa7TeCGrkb38zGlBFJkhX+3Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mSKYlQqVZqclsBXmJkjMO+xVrwQyIdrvf/D33/Qs9+sFvvSO167YW6L9zImzGbu1XoMIp7Hm2Xk9pRZKsWYZljbOEY6AYUo0v8v/0K+6IuUlKwafuqw+nV+XHpRVGtmw1osXUVEDoQ2HSa29xQMBvOIPk5wbDzuU1nPYnk6Ns0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PNWOdeVp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PNWOdeVp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AF70C4CED3;
	Mon, 23 Dec 2024 10:06:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734948375;
	bh=LJhaTlZ5GsjCDXTz1dPDa7TeCGrkb38zGlBFJkhX+3Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PNWOdeVpWFfv4QHXRwwqWxw1Vz3F81qQkEwyWZfczBzqVCe7zjUn9OQV3gozAoEZW
	 ltXlsHKJcwRCVOq0UdkwdMnt508uNCvajw/Kyjudv7lOTFHvAjn7+Bmzhyta4I86ce
	 ZUHTcC5RSQ9v/7jJhGkoOFNU5ZnIvGgTtsYrpUm4Dtk0Co1YxCJpx1zRMxgeS2KKI2
	 LrA5F2dJFeO2F4YIBupuJmmpAA96kNmkSrjmmWOUPffR1qy6nOi2okZQ/a6foPPVRL
	 F6mgmoN4EZPvcczHWvA87Fms/CJgca4xU6DY20SQ8CUI7sy9vJDw5k54z+SzhlvRPH
	 HdHS/4uMRd7PA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v12 06/10] Squash to "selftests/bpf: Add bpf_first scheduler & test"
Date: Mon, 23 Dec 2024 18:05:48 +0800
Message-ID: <79255b64a33bda9a5caeab0156f9b2dc760c16fe.1734947922.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1734947922.git.tanggeliang@kylinos.cn>
References: <cover.1734947922.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Use the newly added bpf_for_each() helper to walk the conn_list.

Drop bpf_mptcp_subflow_ctx_by_pos declaration.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/bpf/progs/mptcp_bpf.h       |  3 ---
 tools/testing/selftests/bpf/progs/mptcp_bpf_first.c | 11 ++++++++---
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf.h b/tools/testing/selftests/bpf/progs/mptcp_bpf.h
index b1f6e1fb467e..72516ba10ea2 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_bpf.h
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf.h
@@ -54,7 +54,4 @@ bpf_mptcp_subflow_tcp_sock(const struct mptcp_subflow_context *subflow) __ksym;
 extern void mptcp_subflow_set_scheduled(struct mptcp_subflow_context *subflow,
 					bool scheduled) __ksym;
 
-extern struct mptcp_subflow_context *
-bpf_mptcp_subflow_ctx_by_pos(const struct mptcp_sched_data *data, unsigned int pos) __ksym;
-
 #endif
diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_first.c b/tools/testing/selftests/bpf/progs/mptcp_bpf_first.c
index ab71ae3c6506..d71c50c7f441 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_bpf_first.c
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_first.c
@@ -17,10 +17,15 @@ void BPF_PROG(mptcp_sched_first_release, struct mptcp_sock *msk)
 }
 
 SEC("struct_ops")
-int BPF_PROG(bpf_first_get_send, struct mptcp_sock *msk,
-	     struct mptcp_sched_data *data)
+int BPF_PROG(bpf_first_get_send, struct mptcp_sock *msk)
 {
-	mptcp_subflow_set_scheduled(bpf_mptcp_subflow_ctx_by_pos(data, 0), true);
+	struct mptcp_subflow_context *subflow;
+
+	subflow = bpf_mptcp_subflow_ctx(msk->first);
+	if (!subflow)
+		return -1;
+
+	mptcp_subflow_set_scheduled(subflow, true);
 	return 0;
 }
 
-- 
2.45.2

