Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A7C113EFE3
	for <mptcp@lists.linux.dev>; Mon, 23 Dec 2024 08:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734942637; cv=none; b=FzplvGCMOyStU4JcRXOh8GHWHNGjxfAzhy2MfsqNS9H9MDD7+/bCfJWLEcc3YPyAZCT7J9THg3IS1z6Judzbl8l1MF/dMFIKiODSWAPpts7lfPcKVm9VLz7JzO7Zp47zzH4klG4dmYcVo1dDHikACigd4GbwrXjnPNVIuU09J10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734942637; c=relaxed/simple;
	bh=LUQuTzxkBX5sfuJitn7NkP2npiQELMruqS5lyeJRIIo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MOYnnXh9JZkA5VOKcDxr5mO/Dz13qJR+1bRZl9h3SypDrpGp37GJICLMMbm95STY5GASjV2DJsBU97HMZjucAmdwWD1rIZCczzAwUKDNiRtJjcgwD5oduD2ae4hAfY6+GSBi7Xr0zVT8IDsqrA9MDK9TPppBh1iBia2QfPG8xXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o/zaZOqt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o/zaZOqt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E717C4CED3;
	Mon, 23 Dec 2024 08:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734942637;
	bh=LUQuTzxkBX5sfuJitn7NkP2npiQELMruqS5lyeJRIIo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=o/zaZOqts2PsxQCYvlfRBY8pv+NgO1LIVfhzAj9i9KdWrjF0sUkINYQ+PimETYhId
	 DkeuZCLYccyXxADXFEXr5u2Cvec/7i6JnWZnNvr012pFiqrGfu6XHa+vqv1OURHUgj
	 6BBhnnwZ+jAAMBiEUxEqS/kHADIl1LdVy8n+qmxUznWrrxo347d3B3Nno8CCoHSoty
	 IpoqMOky05wlWZCViifNR5Cq4xu8Q7otU3/tU/hZdN3V04eqruD0p+U2ITg+3nY+eQ
	 V7ABsYLmrdpcLkj6LTnthgF33YSzPsoOUPaou1OSRqpPdjgkqdi02XvOR31Y6IxWaF
	 +XbXWFDpgWOLA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 8/9] Squash to "bpf: Export mptcp packet scheduler helpers"
Date: Mon, 23 Dec 2024 16:30:14 +0800
Message-ID: <e963bf9299e45bc3d8b6c138bae7763d76168d45.1734942318.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1734942318.git.tanggeliang@kylinos.cn>
References: <cover.1734942318.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Set KF_SLEEPABLE flag for mptcp_pm_subflow_chk_stale.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/bpf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
index 8d4865177037..be222fa5f308 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -334,7 +334,7 @@ BTF_ID_FLAGS(func, mptcp_set_timeout)
 BTF_ID_FLAGS(func, mptcp_wnd_end)
 BTF_ID_FLAGS(func, tcp_stream_memory_free)
 BTF_ID_FLAGS(func, bpf_mptcp_subflow_queues_empty)
-BTF_ID_FLAGS(func, mptcp_pm_subflow_chk_stale)
+BTF_ID_FLAGS(func, mptcp_pm_subflow_chk_stale, KF_SLEEPABLE)
 BTF_KFUNCS_END(bpf_mptcp_sched_kfunc_ids)
 
 static const struct btf_kfunc_id_set bpf_mptcp_sched_kfunc_set = {
-- 
2.45.2

