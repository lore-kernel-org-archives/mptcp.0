Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0A96225A23
	for <mptcp@lists.linux.dev>; Thu,  6 Feb 2025 09:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738832720; cv=none; b=I+B0f+DkkL2g7B9l1h+agXLUhxs0MOwlKRXZdfsNzAOQKJl9mnOOle9Xey/KUop3+rb0r7hVrgV2odRotYYkP5oTgTk3b8nlvsd3Mt37nnCHE0z1d/zy8WbbEc0xxk1UDgDXCmUj8xMPhVvnKp9VmNtlddrD782RLSIirwj9jQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738832720; c=relaxed/simple;
	bh=PvRlww9oxwxOA+huQBk1xHRyv5mmqZH7amLe1b0bbxw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ty2kecqUB+2JFzcWANaSj5Dih6Cs1a+up5cQQkYtn0q/nKqzIdKK2BZ5yKZ03s7KEBJ49A82Y56rzNQOvS86mnFPUv1IU4iUIOV98XNre2qEH4ZhPOtIIHTmTi02eEY/sqqTd7Q8tTCpCyhqd8JpeSSra7QL/fFOqVGQHOXD40A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nsXWy58u; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nsXWy58u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39DF5C4CEDD;
	Thu,  6 Feb 2025 09:05:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738832719;
	bh=PvRlww9oxwxOA+huQBk1xHRyv5mmqZH7amLe1b0bbxw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nsXWy58u6xs4eDr++EpYhxEmPEY8HH1TDapcooQVkwT7hKsR07YTy+3uLgeDdTGc1
	 EIwy5z9Mtb2JZ8KU/HBf5/42okkje1VLLGhnEnq6GuMoMJpyoQKvdjSbNPJwbHdM+8
	 PhLPnwr5eRNjJ36xCfwVFOnBxN14RXwLYbQpVAmSueGNs5EP81DuCiTOxw5XwZfFIL
	 HqxV06uhgTxhxe2OFExg7MoQq4jT+9SIwdSOU0uHef9JJt7wAiYpKbu9acBojLNZ/Y
	 K6piPYg1GdpnGEH36HqolfApw6J3o94OrS3/2YevVi83Wl0013Ez+FNNWm8oZtUsbw
	 zL1z1zu9Usxhw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v13 7/9] Squash to "selftests/bpf: Add bpf_red scheduler & test"
Date: Thu,  6 Feb 2025 17:04:57 +0800
Message-ID: <9d7a68667502d02b73d2ca922f9664da44ec9380.1738832147.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1738832147.git.tanggeliang@kylinos.cn>
References: <cover.1738832147.git.tanggeliang@kylinos.cn>
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

