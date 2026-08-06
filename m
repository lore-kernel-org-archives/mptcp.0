Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83AE432B123
	for <mptcp@lists.linux.dev>; Thu,  6 Aug 2026 09:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786007450; cv=none; b=ReuQMX/BY2+t7/DUi0isNfROz4m53ktsdT8kzyCg+5KIrha1l4cJbNMk+NhabuS2/wGH9t0Vf7fUoiJpoY1GA46vc4f8UGWjXBa7BRHZK/o52O2bruhjeYHu7ZMWCAreofyQgBPthPChAx4yuwrxUwNqr6TVk23dop+YdnHeINk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786007450; c=relaxed/simple;
	bh=5j3uB7u+VNfKhJzGGliAP3G+HG2XrunEG0PSLs90ejE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qkVnJ0EsWAJB8VT211jnq5QcTlEN4LXZLG4ykKrg3unVgoXULCXSDRiAGcyeWSNBBc6TTlPGocXb9ECi54SXaBFiG3z0MB7STsUKEUGwQy90B7uaZomlxX8n/6r/aoxoIip0XjQlcDLiXYxFPrcIbecmy+xK/mvH7ux0idM2nmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GZoMR6HN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GZoMR6HN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0D041F00A3D;
	Thu,  6 Aug 2026 09:10:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786007449;
	bh=dpf5E4+Uj0437VmP61FkH7rlHxbOrj8rfNyaG6QU2Vk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GZoMR6HNxhTjqPe7A4sQY/hykj7sgBbOlUOyFYu+yk09CyLItDxP5KHMGDfANLoDH
	 W9oYjPD56eStm8Sb9n44fSQ9A9IDmzkZA1kXkF0jl3y7WoGIm3Z2FRIMV52FewWJR6
	 8s3y27cvy0mD5tJyeC0z5pURNGtpUuC1TmUl1W26pnzv4uqjZ7FJVEi0MPMjYmcfRl
	 MXKnCdFTUsPB+GdE4ftDphGyF9Zi+ULB9e/5JL9xpqGKRtmL5R+Brpk+w2864N+mQu
	 tqNx2MkE8TYsc0+nyg5jhu76ZZyGN/4kCBXr2VOyvim1bHARFpaIQl2c2FPVFqp4wX
	 mYCRiCrcUdvSw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 1/2] Squash to "bpf: Export mptcp packet scheduler helpers"
Date: Thu,  6 Aug 2026 17:10:37 +0800
Message-ID: <95588bb2125ecb8a5250f35dd8278e6e1194c0ff.1786007209.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1786007209.git.tanggeliang@kylinos.cn>
References: <cover.1786007209.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

mptcp_pm_subflow_chk_stale() is removed from mptcp_subflow_get_retrans()
in kernel, drop it in bpf_mptcp_common_kfunc_ids.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/bpf.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
index 0845061ddc65..82b0ad25f700 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -322,7 +322,6 @@ BTF_ID_FLAGS(func, mptcp_subflow_active)
 BTF_ID_FLAGS(func, mptcp_set_timeout)
 BTF_ID_FLAGS(func, mptcp_wnd_end)
 BTF_ID_FLAGS(func, bpf_sk_stream_memory_free)
-BTF_ID_FLAGS(func, mptcp_pm_subflow_chk_stale, KF_SLEEPABLE)
 BTF_KFUNCS_END(bpf_mptcp_common_kfunc_ids)
 
 static int bpf_mptcp_common_kfunc_filter(const struct bpf_prog *prog, u32 kfunc_id)
-- 
2.53.0

