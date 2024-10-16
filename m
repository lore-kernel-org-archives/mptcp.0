Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 262A21C07E7
	for <mptcp@lists.linux.dev>; Wed, 16 Oct 2024 09:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729071260; cv=none; b=dObbSem789WryJL4clBCMu52sS8yo3VoGfPlPjGoygi29YR6FcSGKUkdK+nToQu+nLu118yske/tJA+W3kLo4d/K0Lmcr2qEGoH7Ueq2rNgOqNVY9oMZkcbqWMAtPK9BPVNDemOIazfdERLAbcRUfUxX83MRkeS3B7JEVV2si/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729071260; c=relaxed/simple;
	bh=vAGk2SNZxJ2K0XaAAadSTnWA8wtWMYR0tx03ZiqDhLQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jflLVob81Nb/z/BnsYVGgN1/PFI8S9pX3zbJyeXs0wOcWVXxSA8qK2MiRTkJrp/2DpOUnUVzdiWQ83qEKdbUwLUyF455k6h23QhdAVoB83MeVakrBwui6Y8OOs33Xv1DJWGf1H+s0PwH2wxj46IEV4yWXP4D2LWuFcYxbg6rf6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PADZr10J; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PADZr10J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA5C1C4CEC5;
	Wed, 16 Oct 2024 09:34:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729071259;
	bh=vAGk2SNZxJ2K0XaAAadSTnWA8wtWMYR0tx03ZiqDhLQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PADZr10JOdeV2qUk4jETB2AE7kwtDiC6CjHwdqtzkU/aIGSMR27gua8pCMFsr7rhr
	 mZ5dLMw7jVWX8c2S2q5bLy3ujUiB/DzyjYbO1lNlcxji9RE3Wvi2eLvmkF2k0SM+FQ
	 ETDYylzih8n0bRTzrwtyr2okSoCSM4i6YIdgmjYrJUsf5cFwSr33ndUpJENRXPr5SC
	 XWtD0D0LClaRO0ozqcfPsMruJEzsYhBh+VJ7zOHATtFvO1UqAZBNznRc5XyD08llUT
	 0ksz/8YINTm4UalriOj+z9sq76pqe8Nu0agy5pZw8/ufmJZ5SwVZrdL9UzNKVz9WuF
	 7cbPE9Xpo203g==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v6 07/10] Squash to "selftests/bpf: Add bpf_red scheduler & test"
Date: Wed, 16 Oct 2024 17:33:43 +0800
Message-ID: <5759901a2d71c40328253911dd9827d80c7c5c9a.1729070999.git.tanggeliang@kylinos.cn>
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

