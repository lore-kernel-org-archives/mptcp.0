Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 144B72163B8
	for <mptcp@lists.linux.dev>; Mon,  9 Dec 2024 09:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733737789; cv=none; b=cvs3+x0GUD6N1RD2ZsC4g37r0SIO0q3hUjLA+TCUi1ev15EOgSpkAR62s+uMPb0kG4PYb+xufIblJo1RHyWknxiOTVMmRLLcfoK4+1P5Xpu7NDCjHxmcYqoe6gbjUvUmrHfTQ+5wCiIktuI0hUkLwz6BqvB/x+pUD46+zMZRHK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733737789; c=relaxed/simple;
	bh=6bhndwaaGpAVAk7F3FGG00oCg3g2+1FwNFY5REvMeE4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KrKXAoSoDdb94kd9Z1CfrOhVKOpu1t5Uc2jg2er7vtU9FV3/OYiIk0SRoyJbDuW9bZH3R3EKYMl56szaCyrjnWy6ornQEHjvJLEiprMCDSXswL22jDXSL+1+Lmj2A+GhxjfpUSgks+df9+WHuGYfnxAjVoNfHlFOmqC5b8h1jFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wwrr+9ku; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wwrr+9ku"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAE5AC4CED1;
	Mon,  9 Dec 2024 09:49:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733737788;
	bh=6bhndwaaGpAVAk7F3FGG00oCg3g2+1FwNFY5REvMeE4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Wwrr+9kuCYseGeCoRVKnTvyfuWUR9jJETnjaRBEDprhTCqbZ8E8KcDINvjN8e+ZZb
	 1iRaK51ecktD/BLbJ18GLsPfe8wZG4MSp/YVWPijzAG4ke4ujMxW+zeU5H888PEvWD
	 LpO84qjRcp1ScVrKIvkptx9TW+DpckJ7FZxIH6RQabcIiqVhUdOhYS/V2aAgaFzN64
	 UinDDiZrpDlijkNvunC6Fm+jZUvU+rUwhvsvpeVB6ufEMzLJvv/iBNMVzNmlFZApXD
	 FBgXv07ztdXDyAg1gkk4UZBVYu1I//Z/PN7T+KtKN8tVri+QN9pA/C0V1LN/6Zu3Zx
	 k70ePD4PleohA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v10 9/9] mptcp: drop subflow contexts in mptcp_sched_data
Date: Mon,  9 Dec 2024 17:49:25 +0800
Message-ID: <eb159e61a1d28c9a3fea01b515927e73fc6b62af.1733737459.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1733737459.git.tanggeliang@kylinos.cn>
References: <cover.1733737459.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

The mptcp_subflow bpf_iter is added now, it's better to use the helper
bpf_for_each(mptcp_subflow) to traverse all subflows on the conn_list of
an MPTCP socket and then call kfunc to modify the fields of each subflow
in the WIP MPTCP BPF packet scheduler examples, instead of converting them
to a fixed array. With this helper, we can get rid of this subflow array
"contexts" and the size of it "subflows" in struct mptcp_sched_data.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 include/net/mptcp.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index 814b5f2e3ed5..84d67947a517 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -104,8 +104,6 @@ struct mptcp_out_options {
 
 struct mptcp_sched_data {
 	bool	reinject;
-	u8	subflows;
-	struct mptcp_subflow_context *contexts[MPTCP_SUBFLOWS_MAX];
 };
 
 struct mptcp_sched_ops {
-- 
2.45.2

