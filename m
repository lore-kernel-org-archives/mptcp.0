Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A501843C05E
	for <mptcp@lists.linux.dev>; Thu, 27 Aug 2026 10:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787828290; cv=none; b=eP8vSm6Y+AXSG672vVh5BFloLqRcgykEawyUZJem1ygLsfDZa6wTqyyzP003xN3+casFH1QAD9P80832nlSdsMbpJ0okcXbu+XIFPIdIVdfyD94UjNmAfw9jK3KKMUaHZ5IEkLPaK3huegmRUXHptfj7IJme7l4zs4DWUPvaVGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787828290; c=relaxed/simple;
	bh=sABakLxQbUEcKg2rxQjjNh927s0aRRIBwJGd27JHknY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LT3XK0lcdwnkyz0lzcAkqCdEN6+AfrCEfsUozejJoC+DcV8xpqZfPdiDc3/81w78NFLBnCIuKDztGa4fvCkuLvU2DqiATFEFA//ELmxHEthTKDLRXXaOOedl+wxYQR14yGgLCwYIytPq+0GqXHgQG3n6bynJjAaR29v3Dc1lgfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NAuaJ9Dy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NAuaJ9Dy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 647151F00A3D;
	Thu, 27 Aug 2026 10:58:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787828286;
	bh=5+gN4VNEayXzHnVZOGpyoigB74UWLRtRyv1yFgYDVrI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NAuaJ9DyR3bwjiSbGHJ1uUoCcq6Rj0EpJfLnZZN3fTZzqhYakxaAoce+zr+eaROqf
	 LWLEOkj9ONT9U1XnbjU2r5Z6bQSnYtcGZW/Ryeipeql7dmj3Y1EuZeOj0NkyXsTc6z
	 FT2RQdb9Pxxcfbecr8COcTU33IkLvw9NqsXLrm6NsRsc5F337tQJPGcJPdA7aDUnCG
	 DxeZDQ2YG5pq4TCyPptL7jr3Y+uTSbJdKqY+S60DzjBNXaWcJPAXDlX+Dttv2+B4fs
	 gSMHRTS8qsjUKw/MRs96EvBjuDrJp83SVfNZcvmMrpeq6+Np2RyEkYBSXJy4E7ogSb
	 k9WwxzbRvrpWg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v9 11/11] Squash to "selftests/bpf: Add bpf_burst scheduler & test"
Date: Thu, 27 Aug 2026 18:57:35 +0800
Message-ID: <056ee1d2d313b38d6dfa20d44517ddeed34a63db.1787827525.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1787827525.git.tanggeliang@kylinos.cn>
References: <cover.1787827525.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

msk->snd_nxt was converted to atomic64_t. Use READ_ONCE on the .counter
field to read it safely in BPF context.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c b/tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c
index 3d512b0efe6f..a391f6563a61 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c
@@ -108,7 +108,8 @@ int BPF_PROG(bpf_burst_get_send, struct mptcp_sock *msk)
 	if (!subflow || !bpf_sk_stream_memory_free(subflow))
 		return -1;
 
-	burst = min(MPTCP_SEND_BURST_SIZE, mptcp_wnd_end(msk) - msk->snd_nxt);
+	burst = min(MPTCP_SEND_BURST_SIZE,
+		    mptcp_wnd_end(msk) - READ_ONCE(msk->snd_nxt.counter));
 	ssk = mptcp_subflow_tcp_sock(subflow);
 	wmem = ssk->sk_wmem_queued;
 	if (!burst)
-- 
2.53.0

