Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE0AB804
	for <mptcp@lists.linux.dev>; Fri, 11 Oct 2024 09:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728638853; cv=none; b=fIMJp2I/9ZwhOFp2Zi8hU9zJUrOOgGi2TTomw+/PZj8AHBhhtmj61t1r3Zb2FIDk4PBjidNRInY/BlOcg+HffCrvT/33NTIeZuNTrITe3enNXRI4WTj5zYyDDtLCxmH4QuQRKj5Kpay40WgbqZSUHizX1GvLGB+UwO6HK/omwxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728638853; c=relaxed/simple;
	bh=MPz5NGp6KSHo+FNsG1J/2SvyUNxvLsebcp3fNO2e0Hs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DO2DL8J54fCvyEMy9zEyE+25jzkLCL2yqbiWVRSWsEJSgHycSxwWWQ1N0tR+nBCTxvN5XhsW3oGaZpFNO5GCfuyGMwybkjuQQQvM5Z2nlcUSljgXyOaD8znCHXNBuOMuCrPddjLeFatRWW5773mT6FWpPtcCgfw3Zv+vVmc5UAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SQBiM9Xl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SQBiM9Xl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F40AC4CEC3;
	Fri, 11 Oct 2024 09:27:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728638852;
	bh=MPz5NGp6KSHo+FNsG1J/2SvyUNxvLsebcp3fNO2e0Hs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SQBiM9XlMOYbuQf49/npFSlvAprEHOQzWumE+187h7E54mwj4KpyIXDANEutyWK8e
	 UhHsm6WagB01cWHtEzoz8w8gme/Sg+MBaHzafr0omXY75KkHay0iZBfvwZOqziVjxW
	 DahxDRufUFB3dxEl5rLeiTEsy+EAVNCGJzuEasNg1rqw3igX7WmbLH3U34w0sRVWGg
	 BiuluJ8l07//U0ZpSc5OiK1w5uNrEivdF+jt+ff1zNuM5Oq/ffjThEIT5ylE+jJ0+c
	 HRUJRNUADgduSdwhK2iXXUJ+roDPYCgJ9LGBPwJg6rNSkNrrSCkVQ6boIRDivPZkgh
	 1J/4hAet6U+Ow==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v4 02/11] Squash to "bpf: Add bpf_mptcp_sched_ops"
Date: Fri, 11 Oct 2024 17:27:14 +0800
Message-ID: <80944f1737be11dede7bd842f5121c6a0e14dd69.1728638310.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1728638310.git.tanggeliang@kylinos.cn>
References: <cover.1728638310.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Please update the subject to

	bpf: Add mptcp packet scheduler struct_ops

A small cleanup.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/bpf.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
index 681a76f7c6a8..d0758479318c 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -18,9 +18,12 @@
 
 #ifdef CONFIG_BPF_JIT
 static struct bpf_struct_ops bpf_mptcp_sched_ops;
-static const struct btf_type *mptcp_sock_type, *mptcp_subflow_type __read_mostly;
+static const struct btf_type *mptcp_sock_type,
+			     *mptcp_subflow_type __read_mostly;
 static u32 mptcp_sock_id, mptcp_subflow_id;
 
+/* MPTCP BPF packet scheduler */
+
 static const struct bpf_func_proto *
 bpf_mptcp_sched_get_func_proto(enum bpf_func_id func_id,
 			       const struct bpf_prog *prog)
-- 
2.43.0

