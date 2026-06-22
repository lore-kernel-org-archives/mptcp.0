Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7759035DA55
	for <mptcp@lists.linux.dev>; Mon, 22 Jun 2026 05:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782107119; cv=none; b=bhQxmlnX77CxEQmL7tP9hTzUm7r7/GSSGgpUW1FRCNhiZmpm1x3Tvzvvh1tKraGeV8iQfz3I17Z6+//Gp2AR1eun3nirTBSriy8RepA2Y6rMgFa2uZRLYRaDdrgA0ftGepTc+nF2KXZuruXVe/yMYSD7bjdGgEmlrSQWk2K5h/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782107119; c=relaxed/simple;
	bh=oGoZmHTnPOSoFASTgyeTDs85JOsE6y8rQ7/fs9c1ipA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SRXz35TtGTNF92JPNOdgsFr6n87VBRJ/Ib4FoGLS9DrXlzBOIBt2U2Rb7GJ+1uRR1Sjp6ncz/WHHMhili0M3+7uXfyNRWs4AdfDcJvOABJwhDNeHp/ptsye8ZfFnvoIXNJVjy2PRu0pF/kvCA9VshjcV+tKczh7M1MwrOlNWjUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a/qhLUrB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a/qhLUrB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CA731F00A3E;
	Mon, 22 Jun 2026 05:45:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782107118;
	bh=WRz9IpWItXlrxHRY0Hz5Hutp4C0tMMgzMgN9XLfhouo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=a/qhLUrBX13FmOoguxH5Vg1j9+P822h8hyr5TN/Cdmy7cv37TsoMAcUlNUgQcExAt
	 2Z36MBVlDSFYh40WiVt8ep7wf7nZuOXTQQcurLfTY3GWUd1OMQinE7pwmjAqxWE8kA
	 hFsqnusr4CqCl6XrSUXYF+o8mowESMMQFtl0NefnRbYm5DKz+i2uHOG6W9QH/4GrPb
	 QsFLal9LVv49fMgtxatDx0pd4cmEOL25xzQK3xzkJSo+ZFVm/A34FItIGnhwSXQLdy
	 MYesFLVB8VRsnySp/ea81qeMnBLoyqOUrn2e8XyzPAaA4MAnNGrLnFkHmRozKueyYx
	 SG5gWMQhkauMA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 2/7] Squash to "bpf: Export mptcp packet scheduler helpers" 2
Date: Mon, 22 Jun 2026 13:45:02 +0800
Message-ID: <bc9ee2377bc0a53872566fc8c17aca4bac85a248.1782106180.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1782106180.git.tanggeliang@kylinos.cn>
References: <cover.1782106180.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Remove bpf_sk_stream_memory_free() kfunc entirely. The function is no
longer used by any BPF scheduler, and its implementation will be moved
inline into the burst scheduler to avoid verifier trust issues.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/bpf.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
index 259a2ca4fb0b..938aa6399608 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -289,17 +289,6 @@ __bpf_kfunc static bool bpf_mptcp_subflow_queues_empty(struct sock *sk)
 	return tcp_rtx_queue_empty(sk);
 }
 
-__bpf_kfunc static bool bpf_sk_stream_memory_free(const struct sock *sk__ign)
-{
-	const struct sock *sk = sk__ign;
-
-	if (sk && sk_fullsock(sk) &&
-	    sk->sk_protocol == IPPROTO_TCP && sk_is_mptcp(sk))
-		return sk_stream_memory_free(sk);
-
-	return false;
-}
-
 __bpf_kfunc_end_defs();
 
 BTF_KFUNCS_START(bpf_mptcp_iter_kfunc_ids)
@@ -320,7 +309,6 @@ BTF_ID_FLAGS(func, mptcp_subflow_set_scheduled)
 BTF_ID_FLAGS(func, mptcp_subflow_active)
 BTF_ID_FLAGS(func, mptcp_set_timeout)
 BTF_ID_FLAGS(func, mptcp_wnd_end)
-BTF_ID_FLAGS(func, bpf_sk_stream_memory_free)
 BTF_ID_FLAGS(func, bpf_mptcp_subflow_queues_empty)
 BTF_ID_FLAGS(func, mptcp_pm_subflow_chk_stale, KF_SLEEPABLE)
 BTF_KFUNCS_END(bpf_mptcp_common_kfunc_ids)
-- 
2.53.0

