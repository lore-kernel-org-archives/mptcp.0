Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B560220E717
	for <mptcp@lists.linux.dev>; Fri,  7 Mar 2025 11:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741347432; cv=none; b=rrTRy8XzcSG5Nlto2EdK5athQjIK6N7XKRErw0r7ZAgTtkdnOlnt/mWVNM+B+3tG0eTog08rTZXqpvRcqJkq8ZP/2L3FRtgsa9hqFKFI2kYRg5Gf/OUTg8sqJFGl1+X1OCXahboXrVuYWVPaNmyInB0KGYgJ9G83Ah11h8jVm4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741347432; c=relaxed/simple;
	bh=HKslCYctT5QqivpEi7lFeV//upoEgKJM1NPTc3aKgeU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jx7NYjMzGMh6L1yASGbQ70T53aBbPx/uXvQdiN5R2pVYdrpBVR4pOIOj6rAr/oPiGYb1yiYv6J3nD3/8iVRC/XUYJBTEyKi4j/mg4PokPHgKPsztS++Zg6fdcK9XOjCxCrj3+hCWGQMsc17r2/+U8FjwpiX/5EdO1hBUQlJp5kU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nad/pwYS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nad/pwYS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CC9AC4CEE5;
	Fri,  7 Mar 2025 11:37:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741347432;
	bh=HKslCYctT5QqivpEi7lFeV//upoEgKJM1NPTc3aKgeU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nad/pwYSH6qLIkDG3OGLsTIPfTLbT575dfg+JFUICJUlmTiKdfKR+msBm0yUBlv6o
	 OGGb1Rcb3F185Jz904C+pvs9M0A2zJEzrzv6A80wh2ilkUEAaB5TzufvHznKAUNv7J
	 Oxf9iKk4VUy/xfrnzq96mgjUpGx7/mhVPKvKTmpK79ElW/AhM1pMTN5NCkJsERunC+
	 wwn/mFrqXrrAuRk8HAkVlNKT8w/4h4t6H2t8X8yCpc8rOMhLuLKLkIJ/U9z9ysfLEP
	 6GhRi2mwUS893gj3nDYw67HeiUrG+bpK/K2KND6g0VQcxz8t3mh4I1ZBd+1yaVOgsT
	 tq1Y+4b5uPsQA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 07/11] Squash to "selftests/bpf: Add bpf_bkup scheduler & test"
Date: Fri,  7 Mar 2025 19:36:48 +0800
Message-ID: <60315b82855c6d6f0763aca4162bdfc10657edb3.1741347233.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1741347233.git.tanggeliang@kylinos.cn>
References: <cover.1741347233.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Keep mptcp scheduler API unchanged.
Use mptcp_subflow_sched iter instead of mptcp_subflow.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/bpf/bpf_experimental.h     | 9 +++++++++
 tools/testing/selftests/bpf/progs/mptcp_bpf_bkup.c | 5 +++--
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/bpf_experimental.h b/tools/testing/selftests/bpf/bpf_experimental.h
index 6a96c56f0725..b8edad5c8bf0 100644
--- a/tools/testing/selftests/bpf/bpf_experimental.h
+++ b/tools/testing/selftests/bpf/bpf_experimental.h
@@ -583,6 +583,15 @@ bpf_iter_mptcp_subflow_next(struct bpf_iter_mptcp_subflow *it) __weak __ksym;
 extern void
 bpf_iter_mptcp_subflow_destroy(struct bpf_iter_mptcp_subflow *it) __weak __ksym;
 
+struct bpf_iter_mptcp_subflow_sched;
+extern int bpf_iter_mptcp_subflow_sched_new(struct bpf_iter_mptcp_subflow_sched *it,
+					    struct sock *sk,
+					    struct mptcp_sched_data *data) __weak __ksym;
+extern struct mptcp_subflow_context *
+bpf_iter_mptcp_subflow_sched_next(struct bpf_iter_mptcp_subflow_sched *it) __weak __ksym;
+extern void
+bpf_iter_mptcp_subflow_sched_destroy(struct bpf_iter_mptcp_subflow_sched *it) __weak __ksym;
+
 extern int bpf_wq_init(struct bpf_wq *wq, void *p__map, unsigned int flags) __weak __ksym;
 extern int bpf_wq_start(struct bpf_wq *wq, unsigned int flags) __weak __ksym;
 extern int bpf_wq_set_callback_impl(struct bpf_wq *wq,
diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_bkup.c b/tools/testing/selftests/bpf/progs/mptcp_bpf_bkup.c
index 284cca708de0..1719b0b2a182 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_bpf_bkup.c
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_bkup.c
@@ -17,11 +17,12 @@ void BPF_PROG(mptcp_sched_bkup_release, struct mptcp_sock *msk)
 }
 
 SEC("struct_ops")
-int BPF_PROG(bpf_bkup_get_send, struct mptcp_sock *msk)
+int BPF_PROG(bpf_bkup_get_send, struct mptcp_sock *msk,
+	     struct mptcp_sched_data *data)
 {
 	struct mptcp_subflow_context *subflow;
 
-	bpf_for_each(mptcp_subflow, subflow, (struct sock *)msk) {
+	bpf_for_each(mptcp_subflow_sched, subflow, (struct sock *)msk, data) {
 		if (!BPF_CORE_READ_BITFIELD_PROBED(subflow, backup) ||
 		    !BPF_CORE_READ_BITFIELD_PROBED(subflow, request_bkup)) {
 			mptcp_subflow_set_scheduled(subflow, true);
-- 
2.43.0

