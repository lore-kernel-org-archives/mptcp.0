Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 858E31C07E7
	for <mptcp@lists.linux.dev>; Wed, 16 Oct 2024 09:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729071248; cv=none; b=jzAOrlzLZ2YoIyM+vOgMcrqOLIeh2VXzKgbTCBGfTlFxzaD8VCyjnXwnnn6IH26fRj8O6Zo02Tr8i/WaXkQac5egl+oW5vgt8XRj+TNxtMB9h4kCYVfGN6y/4oJrfD6JN0O6NwPlEeOU91J+cTm6XVRYcSmJMexn7s+1dDAvw/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729071248; c=relaxed/simple;
	bh=y5brf6Qmo4gol2jcfhDBgHOkERtdBFQuNuYp6mvq1AE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EtHiyNi97VtiteePOKFY1wtvFDZF8usAAT027o/LNOilTAzFbfzxq4pu+4AOlnto4qphmeOE1Ypxb4qNlCtKz458PfGCYppNzWpvcL47RxTuHsn+NHmRGcSJ3AwnVzvMkpOIsSfO5y058y+ZKkv3hKFmRPi9u+nGIpkLcb61uHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cxqMziMa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cxqMziMa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF908C4CEC5;
	Wed, 16 Oct 2024 09:34:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729071248;
	bh=y5brf6Qmo4gol2jcfhDBgHOkERtdBFQuNuYp6mvq1AE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cxqMziMaZP/mn9801IEMl28La0WfbGPBtl6RuR0yVZdAqo/pfWEQ65KMwyEhXkwFc
	 A2ziCmfS8CBsJE1QDbPUdMHM7yj9s73gEcVuetZY15B0Cp92lq64SZKByn17fi+sDX
	 G2AtLRnNPW8fbZ/QACwhgcrYOzGPLBFWYkIcJVfSgv4EXHqBmoMpvrRbB0n7LZFn+1
	 v/JB9XzY16ZntqjAP1NrQfzm0h/xxaVyCmL5HxWirUB9MmDiY2/P8Ou02jgT/UJj+b
	 UaXwxAq7T0U5skN240a2ewUHPE972FV/uE9E2LNZr8M7r/rWG/r0fjgjqCphWjAPhB
	 03CiqZAcGDjyg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v6 04/10] Squash to "selftests/bpf: Add bpf_first scheduler & test"
Date: Wed, 16 Oct 2024 17:33:40 +0800
Message-ID: <a6387b02dc8b32d8d2e47b324d578498c9045a12.1729070999.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1729070999.git.tanggeliang@kylinos.cn>
References: <cover.1729070999.git.tanggeliang@kylinos.cn>
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
 tools/testing/selftests/bpf/progs/mptcp_bpf.h       | 3 ---
 tools/testing/selftests/bpf/progs/mptcp_bpf_first.c | 8 +++++++-
 2 files changed, 7 insertions(+), 4 deletions(-)

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
index d57399b407a7..807685b3ab97 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_bpf_first.c
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_first.c
@@ -20,7 +20,13 @@ SEC("struct_ops")
 int BPF_PROG(bpf_first_get_subflow, struct mptcp_sock *msk,
 	     struct mptcp_sched_data *data)
 {
-	mptcp_subflow_set_scheduled(bpf_mptcp_subflow_ctx_by_pos(data, 0), true);
+	struct mptcp_subflow_context *subflow;
+
+	bpf_for_each(mptcp_subflow, subflow, msk) {
+		mptcp_subflow_set_scheduled(subflow, true);
+		break;
+	}
+
 	return 0;
 }
 
-- 
2.43.0

