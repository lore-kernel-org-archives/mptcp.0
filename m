Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2756818953D
	for <mptcp@lists.linux.dev>; Wed, 23 Oct 2024 09:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729676450; cv=none; b=tSnDK+7uFqxKtJzXqcoRm5xl60vhIcu7MywWDHdY+VTyL9CoPEmXHRTk2EaIz7CAhmXslgZ08Kbav1DAtuEwstOSPsSNFzs+cQHWVtNPyeDdw4lM7fnEtWb7f9S4NpiG/VQ/aY138sNbjEzM4sq+IyMBgRU+3yzVXzSDO0ntDq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729676450; c=relaxed/simple;
	bh=1/XmonfNcS3aYrR3v6jWSV3X9hDxjUcdOYCh1phGiIA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ory423YpTdTW5Wv0EowCRBK9XYJ0KUjhqp25ErFHBy+5ySTw2FTQut713PVk7uVEa4Oo6Luv3gOcrgEOQUe2IIiEukKCrs4gZnYRkDcJ5oBuBdBrMV2Nm1ZIADKMPUHCsbln0iSFG+o6skL9lI47PafkXFgXUMMwF6MdrAunVDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k4E8Tn3t; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k4E8Tn3t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BD76C4CEC6;
	Wed, 23 Oct 2024 09:40:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729676449;
	bh=1/XmonfNcS3aYrR3v6jWSV3X9hDxjUcdOYCh1phGiIA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=k4E8Tn3tWNoIDOToz8JNKkUKYqYAKI0wzTv63kks3TFbheJ/MpAYbkb8YhfgxUkI9
	 ISQMyQEC9bqXeEqRe12NJZjPKLw67UuBzckvlfRHzxf4GH5MH4cABXfd0j0lGUNShV
	 +YzM/9RKaFCXGm3BryjZrfPOOW+7PoFQrDDCWTLfn7AqyRJ+QROd7OoVvHVMnTG5qr
	 l8IVdNsiGWg+vSZdhVq0jcdYLKZ1avYg7oOaZKcpFhC7P3JF2lGJy9jDp3ixh/2rc8
	 AgoAQYk5k8goRA+Nz24Gt/hrT4FpAwYANPTFTc5elUsawypTtM3jnl0bvDAd94d4TH
	 GFmO5nsiD1FhA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v8 11/13] Squash to "bpf: Export mptcp packet scheduler helpers"
Date: Wed, 23 Oct 2024 17:40:21 +0800
Message-ID: <e645eea9acb4a84024bb329b1289fe41cb8969cd.1729676320.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1729676320.git.tanggeliang@kylinos.cn>
References: <cover.1729676320.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Remove mptcp_subflow_set_scheduled and bpf_mptcp_subflow_ctx_by_pos
from BPF kfunc set.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/bpf.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
index c6d2efc6cf0e..4aee81814c82 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -316,8 +316,6 @@ static const struct btf_kfunc_id_set bpf_mptcp_common_kfunc_set = {
 };
 
 BTF_KFUNCS_START(bpf_mptcp_sched_kfunc_ids)
-BTF_ID_FLAGS(func, mptcp_subflow_set_scheduled)
-BTF_ID_FLAGS(func, bpf_mptcp_subflow_ctx_by_pos)
 BTF_ID_FLAGS(func, mptcp_subflow_active)
 BTF_ID_FLAGS(func, mptcp_set_timeout)
 BTF_ID_FLAGS(func, mptcp_wnd_end)
-- 
2.45.2

