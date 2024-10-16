Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CC191C07E7
	for <mptcp@lists.linux.dev>; Wed, 16 Oct 2024 09:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729071245; cv=none; b=XX4T5ZlJQl21s+RB9lditlO+edhu2Ge4zmDZpGOw415a9hIMckNyouG6P4VRTvQ7fv2jPv1Zj1s7UcRd2x6nCCvxsMAU7g/rGSma8XpeHJWf6qLR3pF45shiNYrl4CM9Cdcb9Ab4r/SC7GZxRli+hvo/bE1wWBpdFoFrjdO4ixU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729071245; c=relaxed/simple;
	bh=u2R+HeIVIPP5vQ9bQJlNHgd4TqYBFJQZ0/PAz1R4RKw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oge1pf9RuVudv/6QcQItb5PmDg5SAxKcRAFmnN05YHLvRwUMkPhapFCtOP0aVixzDx0qaeyco/njrKsw5LjjSQlahtcvgXEmqvZDzNLgpyn9+09uP1apUuRzQmaixlqT8SL9CgCPUvPzFonkuykMUFpb6B9gcA3vKFjocwJxtQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i2DZ83Br; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i2DZ83Br"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 568EFC4CEC5;
	Wed, 16 Oct 2024 09:34:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729071244;
	bh=u2R+HeIVIPP5vQ9bQJlNHgd4TqYBFJQZ0/PAz1R4RKw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=i2DZ83BrilQWRBIQEoT/rWJJdLoDRJO5gTfchMwqUA8LemGTzbFE7PmtGsJgdvHal
	 XbIT4ft1JwMnE10kocHunBGN0jnLfrjc+8/vPZrboTRSSKRtkZn7GVvMoA0czvm5oq
	 FeyU+Qiri809vHx4+nG+J3In10k2IvBoUf9Tky/7N/2I6OS2a2nmYiWIpvnouy1UQH
	 0r2ZxjNm+t/4H52sXDZlB9FdvI6bnzT+MHIi8hw1bqAoGV9CrUrKCjnGoClVeXYZlf
	 tA1W0OSFtTbmf+yJagDlKVdYz0xQr5zogUSgk3l2ZVoz6SfUROb2n4uI6wJQdkz8UL
	 /7MRJXnmSZZlQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v6 03/10] Squash to "bpf: Add bpf_mptcp_sched_kfunc_set"
Date: Wed, 16 Oct 2024 17:33:39 +0800
Message-ID: <dec1ae17427085ae496aec54fa5ee4237b14a045.1729070999.git.tanggeliang@kylinos.cn>
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

Please update the subject to

	"bpf: Export mptcp packet scheduler helpers"

Remove bpf_mptcp_subflow_ctx_by_pos from BPF kfunc set.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/bpf.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
index 9f264b37ca94..ba36d624671d 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -292,7 +292,6 @@ static const struct btf_kfunc_id_set bpf_mptcp_common_kfunc_set = {
 
 BTF_KFUNCS_START(bpf_mptcp_sched_kfunc_ids)
 BTF_ID_FLAGS(func, mptcp_subflow_set_scheduled)
-BTF_ID_FLAGS(func, bpf_mptcp_subflow_ctx_by_pos)
 BTF_ID_FLAGS(func, mptcp_subflow_active)
 BTF_ID_FLAGS(func, mptcp_set_timeout)
 BTF_ID_FLAGS(func, mptcp_wnd_end)
-- 
2.43.0

