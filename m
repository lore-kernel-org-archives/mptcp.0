Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26CD715534D
	for <mptcp@lists.linux.dev>; Tue, 24 Sep 2024 09:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727170132; cv=none; b=f716M+H+rPBi0Z3L26RSKOK3kfhUcHzWyBsb1kAzRxDnCiUD06RJDGBjRZYzDtA0kM06WXyUQE12OMDTNC2q4s1neSZomSEgAU1w0FZXhF78Dng1uFIdXZHBf23eF7zMEQ8zR7VUPlZc+njxRHC/L8Ru8jWDkCgRHg8c/Uw46AM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727170132; c=relaxed/simple;
	bh=vAGk2SNZxJ2K0XaAAadSTnWA8wtWMYR0tx03ZiqDhLQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PUNQQttku0vNEyP32LR013Cg+ivDQDa+43GWT71miqg+ybzYxRiwFdzbqPkchJZwW6jCsNuJoOqckUtpIo3zIt2jHr7RpgNtUZx/iKY9LqKvn8zfqonfDUGC5CFNtIpJknSE1DxanoQRtGQ7ggNmoDaVtbVu6LNqq9fif5tL04U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hXIq6PWn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hXIq6PWn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00FE9C4CEC4;
	Tue, 24 Sep 2024 09:28:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727170132;
	bh=vAGk2SNZxJ2K0XaAAadSTnWA8wtWMYR0tx03ZiqDhLQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hXIq6PWnJKtteiciPw63oEtJtgaeTGoPr5UPLZz7SphAA+5lUwcxd6PzfmmG8avX+
	 RQIy4LPGsGnQg71LH1X+N+9ArrMlgzKa1hLRmMLK0Pz9tlLq5HRWk+x15KRAL+WyhP
	 Ou1SX0i1HHpNIOvR68IjoPkFtpW2PX2ziQgDciZ0RBYak0YSuZp80gNVakP8yn4T4G
	 FpDwh/F7nVGSgfzQP1B+sfIAT7r+9k39lMjCc/azNLDVMMJryvOzKZPHMnDJ6uMrHn
	 1FQWaliv69qLZH7fRJcHGggKCdca1/kAY2gUzO6M1nTQd6fg2TGh5D1AUfzX1cxzzV
	 xkGUJDFseJzRQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 6/8] Squash to "selftests/bpf: Add bpf_red scheduler & test"
Date: Tue, 24 Sep 2024 17:28:34 +0800
Message-ID: <1c0df7423e49d0d636db82591910dd1e04bc8a9a.1727169534.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1727169534.git.tanggeliang@kylinos.cn>
References: <cover.1727169534.git.tanggeliang@kylinos.cn>
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
2.43.0

