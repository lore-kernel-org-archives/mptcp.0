Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A376C15853B
	for <mptcp@lists.linux.dev>; Thu, 24 Oct 2024 02:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729738342; cv=none; b=NAk6FOkjtcxa1bFzkxKCU/E8tKqcczOCC1gD1Ocypy6CU9nDCLN8JIK6pegzuHCElmIykwNjss0CpXGIuCpKkWBG5JrPt0fOPQVUdy2FH3GkiztbapZLh5Y4a4NZsicCpgEaHfjmeob7yEcoE0R4y1iTMeAgKtY8yXs2nUr4+To=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729738342; c=relaxed/simple;
	bh=85z6BSQOpMzPwRwXu1b26KxE1ymRCWf2Ontu5u/c3GQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NpzJyO8VA7Xm5Jb3S0Zh/4sv7Ie+wjPMlRjzfjQrepxhQPzX3dVHejsjlvVR/osy2KHCCN5jp/sk+ERc2AnOhk5acQf/mlzpdtFPySnxrdUCs+5pZP6SNhLQ/TVW8huUMKkk+++7QghHIyiXJzCnQ++3aG3HYk+TAvUAURyc5hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qpYD1fUc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qpYD1fUc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B406C4CEE6;
	Thu, 24 Oct 2024 02:52:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729738342;
	bh=85z6BSQOpMzPwRwXu1b26KxE1ymRCWf2Ontu5u/c3GQ=;
	h=From:To:Cc:Subject:Date:From;
	b=qpYD1fUc6ayTyxPo0LgNn4mbFR/cVmFdNSDC8qGiP9y9458I931c56BouZvu+qMRT
	 oVyC8Ihztqn5xWgLD9x2wr2HtGIFBSWWpO93GPIePDyFyms8NVPqegkpz0BtiE1FXQ
	 QnM9HAio2zf72kiDEY6rmg1BPGbT+12zQNQhk3+qWv5+w54LqX/S7Ev/aq89x1pktb
	 3PCjNh0G0en78Ui7SDfBdk4NdLqNY6xEjdM6Dg7xx2SReSXC2HkKPjK6X2alWxHypJ
	 +g5kg9rHoY+EFZTKpS/SjvawfeAiQLbarUcLMy14gOi3eYAdrAeKoQUKaqhOFmQ5T2
	 W/FEj5ATVa2yg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 0/2] Fixes for "use bpf_iter in bpf schedulers" v8
Date: Thu, 24 Oct 2024 10:52:13 +0800
Message-ID: <cover.1729738008.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Fix mptcp_join.sh (22) and packetdrill errors in "use bpf_iter in bpf
schedulers" (v8) reported by CI.

Depends on:
 - "use bpf_iter in bpf schedulers" v8

Based-on: <cover.1729676320.git.tanggeliang@kylinos.cn>

Geliang Tang (2):
  Squash to "mptcp: check sk_stream_memory_free in loop"
  Squash to "selftests/bpf: Add bpf_burst scheduler & test"

 net/mptcp/protocol.c                                | 5 +++--
 tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c | 5 +++--
 2 files changed, 6 insertions(+), 4 deletions(-)

-- 
2.45.2

