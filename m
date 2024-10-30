Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4EBD1D0E19
	for <mptcp@lists.linux.dev>; Wed, 30 Oct 2024 06:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730268675; cv=none; b=XYkuKRt2noXuHqWEs6Y1KUfkkO0DsW5sKQaJJPYjwEr/J3y6Bkm+jOirzbeGemh3t/XPwIh/dP0+jgfD0BOWxyil/zWcBNYTAGc4gOGDzNfmZSTlYYJ7Y3pwrVgHmYg/fKti+qLSgq4tjIs2KWMEBjPUyoxybWXxiV8OCWaWvc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730268675; c=relaxed/simple;
	bh=6bhndwaaGpAVAk7F3FGG00oCg3g2+1FwNFY5REvMeE4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CAwqviySfIubgQ9+rXipZsgSVr54RCdy2ALgy29uFuye6A39tWpBBd3nOuysl0BYp1jTaxOT5TCTDv/8PlR8t7+tZWwz7jOZeZou6Q8FM7oAQxH4oEGuMVH2haNAmGp6zvvOGGMu0pJeVeiP4jRYPvMRgm7WgKKxnieulo+BUIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dk4DC0y9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dk4DC0y9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 524F1C4CEE5;
	Wed, 30 Oct 2024 06:11:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730268675;
	bh=6bhndwaaGpAVAk7F3FGG00oCg3g2+1FwNFY5REvMeE4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Dk4DC0y9Ao4gRTvX1GwsIVRrhW/JSgHxIGdRIew+E6M7rr6QHofDRFakgUv6Rdmsi
	 3DK7w1fMWxox3GJWd1gDHqIpmuKdtQyDiP8nv/D0xfTAFPHAq9s2FnJI8XRtD9YoeN
	 ZkGUdShiJDMiNi8zzzvUq3+m/QyDkVINB1uISdz5xKsG/TomJR6Kh7f/1v6UersXSt
	 XEJAL3agxVyLdFBvKpF+8UR99WNRexh4qHlJmmkvLyVblyuonTbXJDfMdjOVhCrm8Q
	 hRyyOiTRwA+hx8+R0fqh5FuLXLsMoM7i3URRa70adLLowXBL7PldKKqwLD4cAWs4/p
	 2YtY4MLDFWQQA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v9 13/13] mptcp: drop subflow contexts in mptcp_sched_data
Date: Wed, 30 Oct 2024 14:10:37 +0800
Message-ID: <2c08f84406e607b8c9063470fed70170bbaac615.1730268415.git.tanggeliang@kylinos.cn>
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

