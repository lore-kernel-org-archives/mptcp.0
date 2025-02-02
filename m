Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94EC31CAA8B
	for <mptcp@lists.linux.dev>; Sun,  2 Feb 2025 04:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738470966; cv=none; b=iTQ7yFcAqCvovt40luWGOL0v2sdUdc0XiIdJ13Ro/i1lQd6cNvtHyfdP22WKZ564IxsPjqetBm2jIcA8/8muE5TNYrz2TfKFCMnbko0CJVM4qJp+3Ok6M4TpHCkDi2jTi+/10ala3iMPWe04v1k7aAgLuwWpDORRUWPtfqdnS78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738470966; c=relaxed/simple;
	bh=Y/nSLpzRC0NZxGyn2KF0Yxwg1I5WdIB6hNFwT4Y3kEw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=scOiQ8NYIft1aihaFGLc1YJ8ogp6REx6BIiIwyzvUkH1c+n94QjI6y1iy/4gX6m+eaOPF2xMcQEnTkjWP/7Oo3vCNlIi6eRXmbaxOH0p47nBHXj3FndElt2vYM0nrAYRqz/elZE6XlUBYe1Gx3+GELWTe+ErGkMykKVw5T99hDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gHmUzBay; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gHmUzBay"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4926C4CED2;
	Sun,  2 Feb 2025 04:36:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738470966;
	bh=Y/nSLpzRC0NZxGyn2KF0Yxwg1I5WdIB6hNFwT4Y3kEw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gHmUzBay+3sFY9hpmzpnM9MU+mYGibNh+7+qI0+cx6SFdNoJt7lqM2vYr09PNJyfT
	 PUKUx73YJ0o/edH7s2N0FsZaq2Tv5jKd5Y2x3eRAXpwqVf1lt9zZjHXVmy53NN1DyR
	 eclle5E+v4DLzV4Ygp6m4w0Y8fO2/7Vm4FWqBaNfwUv2pbm2JDNaw0x8ndR5WskYp3
	 ukM+DzdzBG4N6KaoMI6IasIDSyVVIxUbIVx2lAxrCHpr/wJ9CtnFtT141O0m2Bfg2t
	 fEg/nf4oYHV4qxW3ciEkaM+GZRvO+jOGPBaLwLDkygIR1Reumjd4dApxB9Vohoojqg
	 JvFilHjem/vLA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 2/5] Revert "bpf: Allow use of skc_to_mptcp_sock in cg_sockopt"
Date: Sun,  2 Feb 2025 12:35:08 +0800
Message-ID: <af3a4509bca7ded4444861ec2c9a009f3b4afc7e.1738470660.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1738470660.git.tanggeliang@kylinos.cn>
References: <cover.1738470660.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

bpf_core_cast() can be used in mptcp_subflow bpf_iter selftests to get the
msk, instead of using bpf_skc_to_mptcp_sock(). No need to add this patch
anymore, revert it.

This reverts commit d8d42f5a4542c2dc31e4e00c58508a821c6ab789.
---
 kernel/bpf/cgroup.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index 1ca22e4842cf..46e5db65dbc8 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -2358,8 +2358,6 @@ cg_sockopt_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 #ifdef CONFIG_INET
 	case BPF_FUNC_tcp_sock:
 		return &bpf_tcp_sock_proto;
-	case BPF_FUNC_skc_to_mptcp_sock:
-		return &bpf_skc_to_mptcp_sock_proto;
 #endif
 	case BPF_FUNC_perf_event_output:
 		return &bpf_event_output_data_proto;
-- 
2.43.0

