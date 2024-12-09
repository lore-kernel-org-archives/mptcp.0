Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA9D3216E35
	for <mptcp@lists.linux.dev>; Mon,  9 Dec 2024 09:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733737780; cv=none; b=clKjP9zemk4qF6jJwsQRMeTidsl0FnHthmX2AokvztbT0OQR4+JWzRqrdoYPdwkPgnlb7aR09rK/bksiAHUfJ9XYwwo6Urx03H0zoHbI0CGatBD3Wbj3c2UGTr/KtiFFPjih9pgPH16xOPI7QvoaJWo0zYQLVBmUbwh3GKdSzP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733737780; c=relaxed/simple;
	bh=ddTfnLgEZoI1Cw8aheiOu4s52mnraFeRRqdqvon/4/s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UuDAsnvt5lKwS5qpVTYaVsJ5MU4z4XnI2zriUOLgAgRr62CkPWOcJWF4cGOKnUnXajiHwRYqMkzDJAanqHkPf5m3p6wqZJnP+9AwMaFRocCB2x4BVeEec4uRn2u1QyzbtmtWtLZzUDzQGN6KglAKm8nZ2vE+/f1jX7yyXSTaZF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kPXO6QVK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kPXO6QVK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A06C6C4CEE1;
	Mon,  9 Dec 2024 09:49:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733737779;
	bh=ddTfnLgEZoI1Cw8aheiOu4s52mnraFeRRqdqvon/4/s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kPXO6QVKtGZ67IxGEr2LJBktZedx9MFEejPX3YkqqRJhKmy5360bQ+4WVnyDz6KPa
	 6a9UjGnwL1h6zmKILn0lqJVcz3q1x2SlrtjDzrmoflYGTrI81Bt6THdHlE0ecC/atK
	 znicXmdKzc4qBet94fxKrQecuFme/XLXe0v2u72SB9PbGsafiY8aefG/wYvcFCbAqt
	 WrulmwvRuteYBN0+ViBWwD8QO87aH/ERjB6MJmkSGRmf8VyhHFGB38DQOp0jReCDbJ
	 /DNKJ9NEMWB8dDDuFjz6H/TikAxTWtEJ4ws3M4o2uwxx+zg2a3j3Na8pyzqU4OAVI3
	 kkH43xy+A3A0A==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v10 4/9] Squash to "selftests/bpf: Add bpf_red scheduler & test"
Date: Mon,  9 Dec 2024 17:49:20 +0800
Message-ID: <99b8ac9c5018ea16c70df18b93862a8fc5776fde.1733737459.git.tanggeliang@kylinos.cn>
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

Use the newly added bpf_for_each() helper to walk the conn_list.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/bpf/progs/mptcp_bpf_red.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_red.c b/tools/testing/selftests/bpf/progs/mptcp_bpf_red.c
index cc0aab732fc4..ce19d604b898 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_bpf_red.c
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_red.c
@@ -20,12 +20,10 @@ SEC("struct_ops")
 int BPF_PROG(bpf_red_get_subflow, struct mptcp_sock *msk,
 	     struct mptcp_sched_data *data)
 {
-	for (int i = 0; i < data->subflows && i < MPTCP_SUBFLOWS_MAX; i++) {
-		if (!bpf_mptcp_subflow_ctx_by_pos(data, i))
-			break;
+	struct mptcp_subflow_context *subflow;
 
-		mptcp_subflow_set_scheduled(bpf_mptcp_subflow_ctx_by_pos(data, i), true);
-	}
+	bpf_for_each(mptcp_subflow, subflow, msk)
+		mptcp_subflow_set_scheduled(subflow, true);
 
 	return 0;
 }
-- 
2.45.2

