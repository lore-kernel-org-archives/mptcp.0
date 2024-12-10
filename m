Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2B201C242C
	for <mptcp@lists.linux.dev>; Tue, 10 Dec 2024 03:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733801541; cv=none; b=eTNhL3lIAm0FMG1eX+lgEzphpFLDVBp1b7mYxkxZSV1ZmfZ5mB8vQDuN/OGmxe7EV/DdTDenLgwm84A1CjSPpokip1xf7HvrjQoexe8cRVtHIuOXOV1BMn/dO+yToDAKBKfBarX2AeOCKRTqqWj+Vtqn7+6rNb0et3qMjsS70bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733801541; c=relaxed/simple;
	bh=6bhndwaaGpAVAk7F3FGG00oCg3g2+1FwNFY5REvMeE4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Im6HiJCEW+up2EdpIGeaRfHG8KpAgZJzgwhoum9ukYaFEDKyJBVnpE6K2llsA+m3yC5aVXnm6bjqh4AWLIm/WuZLjMEuXEBGmiHyNC2mSJQBj6RcxnJplsk1aQu6UIjFCxlKT86AsR5ZR+IfEulEYyDtmyJuShJ/KWN8MI2H6Ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cHMtlgZw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cHMtlgZw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00136C4CEDE;
	Tue, 10 Dec 2024 03:32:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733801541;
	bh=6bhndwaaGpAVAk7F3FGG00oCg3g2+1FwNFY5REvMeE4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cHMtlgZwjuLTde6KwnxXl5HF2dcXUEypM5cSDldN5Xc+Fa+bujQna+ipeYsUy5pDk
	 sIOQQ+bvYPyfhegftWP+2z7Me+mdwZvK71ECfEDJNTAx6xpUh/Ararva3eoYahmxLL
	 WnEZlmHhSazKzUg+U4EcxwLoSa8xGdAHiWmDE2BMVHfwPJvp2kqVR5wWsP9qhXsBUa
	 sjCHY5UtnPgURzq0v2HKLhC5tL2sin5AGIEqLFIPOaZ6VhoJ+CT72PPUDnV3MNDLLd
	 3rnhe+D4HxOBztahdK3qCUu1nnPjPQl1v2SSKKtsR827QEtm5iKuBa69x1BSET5XXq
	 Nq4hhP/tDDl6g==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v11 9/9] mptcp: drop subflow contexts in mptcp_sched_data
Date: Tue, 10 Dec 2024 11:31:46 +0800
Message-ID: <471aac979f039d00e8bd0334e7b5a3ab8223b5a7.1733800335.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1733800334.git.tanggeliang@kylinos.cn>
References: <cover.1733800334.git.tanggeliang@kylinos.cn>
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

