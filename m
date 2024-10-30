Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CB321D0E19
	for <mptcp@lists.linux.dev>; Wed, 30 Oct 2024 06:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730268672; cv=none; b=OS6ltOl47rQcU1tMYf4NTu41gNmubKCzXwkCtxVACiCs5Z7qB9V2+XCCaewIYGJF+OJYZpm/FlkvLimorDDkps3UQtQEQmht+NcVPw6TFV3SgWH9Kt40fWB+Xf72/8PJGAQsduhpDV3aO/pk8j2XBMsoIQhB79QMymqonbL0fmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730268672; c=relaxed/simple;
	bh=1/XmonfNcS3aYrR3v6jWSV3X9hDxjUcdOYCh1phGiIA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dEo9hUslrXJ6uraLG1hV/G1BaXvhYoZ+YgPptFXutYWIiuxMH0niyCi5bb7bBTmClgfoBCEfY6q1op0V1EaXj/TQmMyoHcbBAa44E+2bSxi9fwULm/+jEQYiEYACh+U0QwTawjrJYoitPu8F9NwJG/7RpwrnZ/6i+j0MZFNpQhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qgECu6Z6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qgECu6Z6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 272E4C4CEE6;
	Wed, 30 Oct 2024 06:11:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730268672;
	bh=1/XmonfNcS3aYrR3v6jWSV3X9hDxjUcdOYCh1phGiIA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qgECu6Z6KvmoCLG/Al/GCNLbOv7aGfsfEHIofphEZuwtMXi2ZPtrLMrfAMNtXriYr
	 VmT86sQVm1wUdLJZCNs7DgBO83w4NrdaajoVkQ4CxRCmRHG6meQH+c//70HJsTYVwJ
	 1X2647DjF8zJaL/KKGFJG24O65kY8efz/vQJHRLybMbJqfjrrwJcet+BXnuuXrY7JZ
	 TPpyx+eI6nBHGaVdiMUpWrNNsd4Hs1gYgaMpx081YrEiQpeYqTZygRWf0qCYRifxtx
	 DfahXEmIrL9jWwT723ufrs8H2hmuExhiP9MiOJ0RgVAFnBuCJavofT4n4nRBHBe6ui
	 ByTEiKckVOn6A==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v9 11/13] Squash to "bpf: Export mptcp packet scheduler helpers"
Date: Wed, 30 Oct 2024 14:10:35 +0800
Message-ID: <f8389f4b7e48203cd296e79fb9192bdee2bace45.1730268415.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1730268415.git.tanggeliang@kylinos.cn>
References: <cover.1730268415.git.tanggeliang@kylinos.cn>
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

