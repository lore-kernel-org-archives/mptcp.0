Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 118C21C07E7
	for <mptcp@lists.linux.dev>; Wed, 16 Oct 2024 09:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729071265; cv=none; b=i3kEjq/YfJKEeqJyKX1aGGXf3j7oJP6sLeMG7v0omBHP/rhMIj3Pj93DsTjWluR0E8hX75XECvIfuebQlnjqUzWVWMHWtlAEMyKHiEmRhQ2vLOBLZ5ttSyRyeT6tfp1C0ZCLnKbp/q8DV3NBDMHEggZEfliAGNyjymWHAusyG8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729071265; c=relaxed/simple;
	bh=R9abq5MrN5JgwgyXDWpWO92k7yl2m/bHYSJvLML+GSo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jWH8YZpsB3LGGhjkv81J0cU5VTKoztNgnUan8/itRAHt/9T90cFrbVOcuTUcr/kWXHMQWNnQZmy05inLWR3v2hnvg6rnly95Wn+rmBgkXD0aAJzCLx4gUtVGVXPV8m6DayL80DYKOwiP6TH7fVSCD78UCOfEQeJjAAN66HAWkgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jg58SpPG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jg58SpPG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAC15C4CECE;
	Wed, 16 Oct 2024 09:34:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729071264;
	bh=R9abq5MrN5JgwgyXDWpWO92k7yl2m/bHYSJvLML+GSo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jg58SpPGeSnbTMEogK5QFt49OR6CAx/b5G0wRm06hAU00wDrZXhxvSm+fnzsVqipV
	 +e8y4GISW+ZP2zPJLvirCsedwKU09tUrdsWmG6gNXK2TutrymAiPMM2B7992aD6+lc
	 uECj+eweFp4wgv6xEKMhJIOiBqmOiSgpZ1i3ZRmaYFnjfg830WBYn7ZqFzmeZpCaTE
	 cToBnDjygMGSBLEDc6PdMAgBX/ndDQI9meT50hZnwIEvRp3NBIDtQjA8JnryfHQGts
	 /jjsxciMFybKx6ACMLF3rgIzm4pGhdyWf8QL7jEJOkx5W2ZqgEfJRgi/9k4Vf24+Au
	 PEfsRgfNOIsAw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v6 09/10] mptcp: drop subflow contexts in mptcp_sched_data
Date: Wed, 16 Oct 2024 17:33:45 +0800
Message-ID: <59944b2b9b03fb211cfadf3b4e0a6ec7082ba508.1729070999.git.tanggeliang@kylinos.cn>
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
index 38b5862f6d98..b00ad7665d71 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -106,8 +106,6 @@ struct mptcp_out_options {
 
 struct mptcp_sched_data {
 	bool	reinject;
-	u8	subflows;
-	struct mptcp_subflow_context *contexts[MPTCP_SUBFLOWS_MAX];
 };
 
 struct mptcp_sched_ops {
-- 
2.43.0

