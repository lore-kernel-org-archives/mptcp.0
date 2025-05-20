Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A57DD264FA1
	for <mptcp@lists.linux.dev>; Tue, 20 May 2025 08:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747730947; cv=none; b=D4fZrTXiDsCJGKNjKg6m9FXMOMSVjdtX3olD5/bmAYlueaqfXlooSMMMbiL9SEzZY7fUCU+aEft0nlHL1JFh71O3eiezyiSFmAzAc+E52mYwqRWGmklOLM5OHEfPn87ycy0emTTLmmMwQ/7GrP9rx+2qNPT/EkNTnXi3w0/rdzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747730947; c=relaxed/simple;
	bh=UBHN8aYpKMiiLu5t/dNV0QfeMZMRSayhsB7ibzU8uxw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OK+uyAC1kMXgG/yc+LwkGYgnB2XvLmPCqB88O5LhhTjpM5uHtFJSPpI24XCnXILW/0eemwC93dAkOrqVwN+o+AEQeCga1IFc2dPHVlM/XX35AR02QTjjWMb8iukDo49rpyTgtHU7/kMOAg4KernGjzBtZe5N97HT2iWgOXgtgx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fB3Wbw7c; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fB3Wbw7c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 240ADC4CEE9;
	Tue, 20 May 2025 08:49:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747730947;
	bh=UBHN8aYpKMiiLu5t/dNV0QfeMZMRSayhsB7ibzU8uxw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fB3Wbw7cQp8+b19gMmfwRt736gKtfD3/rXz/8T4nKQhUZktlbprtAReCtUW4aGVg1
	 1lV/M/VrzIaUQ7CGSJhVD48mtN1P9Ej+bVBl6NjdYYkLBK+JCe7SWy/HsFEiW8OUCw
	 LRBu0t4MJ36QgIQrNJYjfxTUA36wy5tH57j3MMQxDd1QrppI0xdUJzkQvAtTEl1JGM
	 eKj4VmNpd14/cl+y4I8IB29MkkS9867rhXYPdSzX5wDBt3RBCYBgCXe+5fFhufTPi6
	 NC0TpJZFE8wRdPEbxXkHnBtZK7wyVW1qpk/s0uL7ghJ0EfQP3qjIYVYUZDzvdhisdL
	 zuwM6JlPaoAiQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 2/2] Squash to "bpf: Export mptcp packet scheduler helpers"
Date: Tue, 20 May 2025 16:48:56 +0800
Message-ID: <9c089a245833c43d55ec240be1b880909af849ce.1747730598.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1747730598.git.tanggeliang@kylinos.cn>
References: <cover.1747730598.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Define .filter as Martin suggested.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/bpf.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
index 2b0cfb57df8c..4044a8f2c477 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -317,9 +317,22 @@ BTF_ID_FLAGS(func, bpf_mptcp_subflow_queues_empty)
 BTF_ID_FLAGS(func, mptcp_pm_subflow_chk_stale, KF_SLEEPABLE)
 BTF_KFUNCS_END(bpf_mptcp_common_kfunc_ids)
 
+static int bpf_mptcp_common_kfunc_filter(const struct bpf_prog *prog, u32 kfunc_id)
+{
+	if (!btf_id_set8_contains(&bpf_mptcp_common_kfunc_ids, kfunc_id))
+		return 0;
+
+	if (prog->aux->st_ops &&
+	    prog->aux->st_ops != &bpf_mptcp_sched_ops)
+		return -EACCES;
+
+	return 0;
+}
+
 static const struct btf_kfunc_id_set bpf_mptcp_common_kfunc_set = {
 	.owner	= THIS_MODULE,
 	.set	= &bpf_mptcp_common_kfunc_ids,
+	.filter	= bpf_mptcp_common_kfunc_filter,
 };
 
 static int __init bpf_mptcp_kfunc_init(void)
-- 
2.43.0

