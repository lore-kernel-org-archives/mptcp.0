Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10CB618953D
	for <mptcp@lists.linux.dev>; Wed, 23 Oct 2024 09:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729676453; cv=none; b=gebDrcjKLrpm2iaQ30Qo6/X6HiUUgeBfHFXmTSfLkWLBHkwRUq/cWRkcLstitoVUopaS/rGQKYMvWVaA06//bXoqwQX80cBEgfr3lA8ROt3Ayb5Aa9h958WnYgNX5HTchnNU3zHmOcnj6h2JJbuuBYjOu1RSgV00KTsDTwg0jwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729676453; c=relaxed/simple;
	bh=6bhndwaaGpAVAk7F3FGG00oCg3g2+1FwNFY5REvMeE4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZFwrs8hWp7OKliJLv1pLrXWC84hLCsS2+MS2ejec63lRCoLaPnHnTUfFM2WX0ybyHP5rEz7ohkXF2Ew6/yeAxRgjpO1Mp1kGAv2vTdj1Bezz1X99FckgNWOk1ZQo3ZYtjZhfk1DB7JptlTvxyEaFDW09y5jtsSuP//1y7zpik48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uRJnQ9XL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uRJnQ9XL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D61DEC4CEC6;
	Wed, 23 Oct 2024 09:40:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729676452;
	bh=6bhndwaaGpAVAk7F3FGG00oCg3g2+1FwNFY5REvMeE4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uRJnQ9XLVjWoIoPKiGgdrNdCVqChWhblxjS5//B2GLU5xtlDx7YP1GHDqiEBaNmWw
	 Xv2jTJBElOpg3Nos8dlXWf82+k3kLMPDL4/p2yuRbhoO50P3dUNOpBxyrg6phFqhER
	 zlwNnap83fwmxG9nFQlXqREItyIDcGEWRea7uEN7uUslPitvLFuaLlm6XUglMTbJ2x
	 WYfH8Vc/JOMu2K+T//MbsyjsXHS0MBFUPaKTAfDPqEEqRwAxIdUUgePQN42sIViZzE
	 Pzb1MNUomj6svl9ow2wa4AgbJRLQ1zf/cKG/IyPYSMPpQ5uKfdjosXWvH1BBjAa1eJ
	 vaDZvxsGYXgGA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v8 13/13] mptcp: drop subflow contexts in mptcp_sched_data
Date: Wed, 23 Oct 2024 17:40:23 +0800
Message-ID: <88ab66c999b73b58f7de60e560adf9eefaf66959.1729676320.git.tanggeliang@kylinos.cn>
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

