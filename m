Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E7819006B
	for <mptcp@lists.linux.dev>; Mon, 23 Dec 2024 08:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734942628; cv=none; b=CB/d6goyiJVjpTX1dIwcuoGB1Tq6PFJapmb0wMwMDTcjBn2ukgyhodMnFml6Ue3Wjcvp9b25mnC6e3j93KHVMuJ4wzO/SB02GBTXQzL1p/k1eZLkUc8dCIJsWEyzuDkpMvyaNk3eeaVAkoXjiObgKzyIRICQcavoDuQiFrGjoKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734942628; c=relaxed/simple;
	bh=W4wLhdV6SVB3Zm49Q3kdDFdiJYEuZLkT8leQz+0HI9w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IKVw16TltVagNP+gho3DwKS61fkhX+EzD1b5Nq8OFw4lI8rUyXN2cX4zSuK13CTKNWI4cruVKhg8oThnOje9cGEYI0Vg9cL5cUsq7g4QCI3K2unoYkt0rvUeLedPetSNc5RAqvdloj4KzdSc4UIe3qZ9hniMUUPG5YGDXTNnnoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BqBwLktW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BqBwLktW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0137BC4CED3;
	Mon, 23 Dec 2024 08:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734942628;
	bh=W4wLhdV6SVB3Zm49Q3kdDFdiJYEuZLkT8leQz+0HI9w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BqBwLktW26BMDrLj+6ESDu0A/V+sceLa34d272pTFILx3770A9bJ5dy7kchAjNZE/
	 W//LPle3ZE3vBvlJJ+RPjVTj2lw+DtS4Ja1eY9D3G0Xwl9aJSf4qeww1wxS4WlcMGg
	 RBXRTh7hoZqljysmt8/HZfct6A7huqvM+fxmQJwGfpmqvaqp/2ByVK0SbVkjp9VIRc
	 xNXPmu/TrJhDLvPm1zjQA9NA6fLEjGcRIfHWyQ/2Kkc6sS0pXNCrq8Il48VFhBcupK
	 0ulpEqouhaUKwB95XSNCCS550qNtV9vKYTG747fzdvSn/nBbSgjqO0F69FNqje77Q2
	 xDIzgFpnO6hgg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 3/9] Squash to "selftests/bpf: Add bpf_first scheduler & test"
Date: Mon, 23 Dec 2024 16:30:09 +0800
Message-ID: <c4d649fd2e914ea1bc63b5307ff1b17a15414ad5.1734942318.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1734942318.git.tanggeliang@kylinos.cn>
References: <cover.1734942318.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Use new interface get_send() instead of get_subflow().

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/bpf/progs/mptcp_bpf_first.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_first.c b/tools/testing/selftests/bpf/progs/mptcp_bpf_first.c
index d57399b407a7..ab71ae3c6506 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_bpf_first.c
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_first.c
@@ -17,7 +17,7 @@ void BPF_PROG(mptcp_sched_first_release, struct mptcp_sock *msk)
 }
 
 SEC("struct_ops")
-int BPF_PROG(bpf_first_get_subflow, struct mptcp_sock *msk,
+int BPF_PROG(bpf_first_get_send, struct mptcp_sock *msk,
 	     struct mptcp_sched_data *data)
 {
 	mptcp_subflow_set_scheduled(bpf_mptcp_subflow_ctx_by_pos(data, 0), true);
@@ -28,6 +28,6 @@ SEC(".struct_ops")
 struct mptcp_sched_ops first = {
 	.init		= (void *)mptcp_sched_first_init,
 	.release	= (void *)mptcp_sched_first_release,
-	.get_subflow	= (void *)bpf_first_get_subflow,
+	.get_send	= (void *)bpf_first_get_send,
 	.name		= "bpf_first",
 };
-- 
2.45.2

