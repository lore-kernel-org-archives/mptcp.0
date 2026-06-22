Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD0A39EF0F
	for <mptcp@lists.linux.dev>; Mon, 22 Jun 2026 09:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782121159; cv=none; b=DdJf6RtQqOvDke2rSwUOR2xiZ/aZRhRPc+vDI0Kd2/h9krfvKy+0AW02kz1YwnOGjzXYYGo5t36fgPb45LqDK2hQuKVQFXtcRkOs7qt1dCX5C9GFvZ3CNHv3vyd8wyvdtKi0xz7JByEEiW1Cy6Fp/n7nPHSZAw3vxO6kJB2qscA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782121159; c=relaxed/simple;
	bh=IErpFUPr4F0Wg4DT70wFdFLClTSczriFqwGywlHWx4k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nj7m6chI3cTpWo7YH6lVzYMc9Fs19RWzSWjQeurTWcoD15xPyaOCiTHj/Tt9ZlcnrS+9ZzgGNimMZ5EEsLd1LaH2+ajKCuIIGFOGMnhK+3IHAD22ainFgpTjc62gGeI9YjPKiwoQ1Wg8/uL+X0FDMnE7Njp9qQFLVJspydvuCjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L9xxiWWF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L9xxiWWF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 084311F00A3A;
	Mon, 22 Jun 2026 09:39:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782121158;
	bh=xPjQnFtjHyJFDw1ksBOha8hhRPCso1Lg4TAxQ0/QqOE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=L9xxiWWFLFUM1EFNKwppm/7Kc5rfPHlknHLfg8j9Kdqu6f2jcOnZPf1Q2Izdo/QSF
	 j4b8sE80u6w8NgbJHPrrrNsSymRvMZFv2muifW/la05c8pY2sYusVQ2o5mU9+Kjs5C
	 /3GqdxJ12p8JXvrD+DKCx5OEYJXfzFuPqS7xO3rE+4+tRU8+SG+91mdqB2zvJJ/kXh
	 ueh9z1tgksrdtkAhOlFDg/rV1cR/TcUrTKOxKmSO2TpDKxLRfPx2Z5XYMcE/ahFgii
	 XmFiqxWdiTAIyu282AYT4X4vFWGd2TeE2Xr5TgaJ2FyHcNZ7bz3vekID1BdrD1PMnm
	 OSQW++Q1sgKjQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v3 1/6] Squash to "bpf: Add mptcp_subflow bpf_iter"
Date: Mon, 22 Jun 2026 17:38:58 +0800
Message-ID: <9fa1b234bb66304014259d057fff2d1cd52faaad.1782120674.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1782120674.git.tanggeliang@kylinos.cn>
References: <cover.1782120674.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Zero iterator state on error paths and add sk_type == SOCK_STREAM check to
prevent raw sockets from bypassing validation.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/bpf.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
index 08bb037f0951..cb2dddb7c3a6 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -252,11 +252,18 @@ bpf_iter_mptcp_subflow_new(struct bpf_iter_mptcp_subflow *it,
 	BUILD_BUG_ON(__alignof__(struct bpf_iter_mptcp_subflow_kern) !=
 		     __alignof__(struct bpf_iter_mptcp_subflow));
 
-	if (unlikely(!sk || !sk_fullsock(sk)))
+	if (unlikely(!sk || !sk_fullsock(sk))) {
+		kit->msk = NULL;
+		kit->pos = NULL;
 		return -EINVAL;
+	}
 
-	if (sk->sk_protocol != IPPROTO_MPTCP)
+	if (sk->sk_type != SOCK_STREAM ||
+	    sk->sk_protocol != IPPROTO_MPTCP) {
+		kit->msk = NULL;
+		kit->pos = NULL;
 		return -EINVAL;
+	}
 
 	msk = mptcp_sk(sk);
 
-- 
2.53.0

