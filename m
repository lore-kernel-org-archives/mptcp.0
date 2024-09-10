Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4230B17C9B9
	for <mptcp@lists.linux.dev>; Tue, 10 Sep 2024 08:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725958433; cv=none; b=dF428t7evUbP5DbR0LFH2AX3468SFZJ+Ggi8oYy0CXQ3UDfvU/twuWie7rAVvCqbjyDvnZ2WmnZhnP9VEnwr8fGYOIJFUtVpvphs3VJSToBv5q1Jytd0s5kj9S70XJ6V/xyLV/hGXsRVnVnVkpzgu3K16A5HsKRCOxZcqz1NQDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725958433; c=relaxed/simple;
	bh=8dFflihUbaoQhPjhpfk4MZ3S4/M049CBjSriZHJhHIo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=otqz6opOFH6ptfLjB/ajE7ePBZ88znCOI7DjV43vze5qIKAivzP6BoX3O/CQzjH7r/7780YqGb0xHnqtNare8lfiuwRsk49l/nntCPorrbsMoTEDngR4G+SklTe5xcslp11vIrMuQq/6LrcZrDqWY0ZG9i5sqLVYuh1lO7em2i0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TP9Yn4E7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TP9Yn4E7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F171CC4CEC6;
	Tue, 10 Sep 2024 08:53:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725958433;
	bh=8dFflihUbaoQhPjhpfk4MZ3S4/M049CBjSriZHJhHIo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TP9Yn4E76HiBnWGqROM9HbXZ94wrzpcbL5i6NnpZzAVIIfrOu4FgrCnReoYRj2aR7
	 EpEQCbvnDdUUko12X/8QfLT+gQsbQHWqefID1NPqvomhQEvZxaIEFDnVZGI9WzlAq9
	 SHK4hzt1bzgQzyo2zCsCGX6RCa0SsG219gNB4AZO2TGmsnf+P3dJicJCaJFpDCx8Rx
	 0VEbat729mk7Ay7l+acvSi6IvQlj2K/qSgLKeM8F8A1Elh3AvaL7juaiATCCMl91wf
	 Qag/lPBs6JzjBjHj5OHWn43hiodjM6FdpByoUAu/2Bqt9P61QaiT14TbzQCWPqoHjp
	 z3ljIqFRXbWnQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 1/2] Squash to "bpf: Add mptcp_subflow bpf_iter"
Date: Tue, 10 Sep 2024 16:53:41 +0800
Message-ID: <cb7ca604cdc487d1f9a2f03a3a14904b003227fd.1725958296.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1725958296.git.tanggeliang@kylinos.cn>
References: <cover.1725958296.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Register mptcp_subflow bpf_iter helpers in common_btf_ids in
kernel/bpf/helpers.c, then they can be used on a larger scale,
not only in types BPF_PROG_TYPE_TRACING and BPF_PROG_TYPE_STRUCT_OPS.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 kernel/bpf/helpers.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index b5f0adae8293..649ec8305b3f 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -3023,6 +3023,11 @@ BTF_ID_FLAGS(func, bpf_preempt_enable)
 BTF_ID_FLAGS(func, bpf_iter_bits_new, KF_ITER_NEW)
 BTF_ID_FLAGS(func, bpf_iter_bits_next, KF_ITER_NEXT | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_iter_bits_destroy, KF_ITER_DESTROY)
+#ifdef CONFIG_MPTCP
+BTF_ID_FLAGS(func, bpf_iter_mptcp_subflow_new)
+BTF_ID_FLAGS(func, bpf_iter_mptcp_subflow_next)
+BTF_ID_FLAGS(func, bpf_iter_mptcp_subflow_destroy)
+#endif
 BTF_KFUNCS_END(common_btf_ids)
 
 static const struct btf_kfunc_id_set common_kfunc_set = {
-- 
2.43.0

