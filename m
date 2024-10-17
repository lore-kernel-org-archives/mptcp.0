Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 519E35478E
	for <mptcp@lists.linux.dev>; Thu, 17 Oct 2024 10:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729162554; cv=none; b=s7hoVuw1y3rJ2UQaEe2c583Cjr0LtcmYQS+lMETFPl6UwlMz5rjKc2WocwmLamvKIJw2S+fcMO8FhCoEjGhXJtSNA1FVH8vULhYDLr5DFjl4jymkH0oqIn2oxM2CA+eCuZTnXSsone9JnNP8EHTPh8FdeiyjCx5qqPX4/0wryKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729162554; c=relaxed/simple;
	bh=PfB1yZw9mAsYcFrfCWKV3G1mUHHCMm+98nIELBImSJQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hLgLMgI9UywyqldLmkAb7rfLnRD3urIgxmurPZyuElu71lUkxwx1zvOcC4rov2dsqyeVanm2xQEHpcPsF6y+w5fpLZ3JpVOrcRUhpMJ/v7jL4xR7RR7Zz+fEWHJctbebrkH4rFZj/uv9UlJYaQ/GkdqdbQpQ2Vb+z1GwLxzGv/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dI0Ydkc2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dI0Ydkc2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F43EC4CEC3;
	Thu, 17 Oct 2024 10:55:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729162554;
	bh=PfB1yZw9mAsYcFrfCWKV3G1mUHHCMm+98nIELBImSJQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dI0Ydkc20HerOIqsURq4QkYYmij7h4xreZWKGr7TNMMtZCekUtXVffhPX+oEWqZmG
	 5CWkQYEtR5cx8BwxIFqS6vxwyKqn55vOuFMqdKzPqvhHZ0OGktaeSq2yMWXfrCx0Ow
	 QjvY+34uPvK/R6TFCZHzuslnDjpn+uBOs8MFIh52fTl5n1sbADqwLpzUA/+wPNoTp9
	 AyrJbEtHt41XTk0orWUO3JTcQZnG/MhIT85H0U62gIKbYeOCc6f0ureVj1IANlZMXM
	 vv6McwByR5Lv4dkFpnR0dIeCSmRD1d6jyoSqwkj6U647oMTwr9jmivdiNnsEff1atF
	 wm/H9nomVNSBQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 1/3] Squash to "bpf: Register mptcp common kfunc set"
Date: Thu, 17 Oct 2024 18:55:30 +0800
Message-ID: <41f7542b3fce0903d12f05dbdbd884b7bf0b9797.1729162349.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1729162349.git.tanggeliang@kylinos.cn>
References: <cover.1729162349.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

bpf_mptcp_sk() definition is missing. It will be used in patch 4.

Please update the commit log:

'''
MPTCP helper mptcp_sk() is used to convert struct sock to mptcp_sock.
Helpers mptcp_subflow_ctx() and mptcp_subflow_tcp_sock() are used to
convert between struct mptcp_subflow_context and sock. They all will
be used in MPTCP BPF programs too. This patch defines corresponding
wrappers of them, and put the wrappers into mptcp common kfunc set
and register the set with the flag BPF_PROG_TYPE_UNSPEC to let them
accessible to all types of BPF programs.
'''

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/bpf.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
index a2fd62c2777a..1ad7f703abb2 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -216,6 +216,11 @@ struct bpf_iter_mptcp_subflow_kern {
 
 __bpf_kfunc_start_defs();
 
+__bpf_kfunc static struct mptcp_sock *bpf_mptcp_sk(struct sock *sk)
+{
+	return mptcp_sk(sk);
+}
+
 __bpf_kfunc static struct mptcp_subflow_context *
 bpf_mptcp_subflow_ctx(const struct sock *sk)
 {
@@ -291,6 +296,7 @@ __bpf_kfunc static bool bpf_mptcp_subflow_queues_empty(struct sock *sk)
 __bpf_kfunc_end_defs();
 
 BTF_KFUNCS_START(bpf_mptcp_common_kfunc_ids)
+BTF_ID_FLAGS(func, bpf_mptcp_sk)
 BTF_ID_FLAGS(func, bpf_mptcp_subflow_ctx)
 BTF_ID_FLAGS(func, bpf_mptcp_subflow_tcp_sock)
 BTF_ID_FLAGS(func, bpf_iter_mptcp_subflow_new, KF_ITER_NEW | KF_TRUSTED_ARGS)
-- 
2.43.0

