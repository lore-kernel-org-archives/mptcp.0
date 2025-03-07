Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CABD20764E
	for <mptcp@lists.linux.dev>; Fri,  7 Mar 2025 11:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741347436; cv=none; b=d1RTKyDKhDjc6gMnOwgeEJdbAneJgLXzax8Y+Uscwr9qPQ5aybW6vLIgI676iZMHBD/3/VmfgJFKzOnxIDquIGgbJq4ibZL/hE1wX6QZrF1eKXZN+gWhgLX97Zf9fhydDQQLd7YpUyLuIetHheVBQ0I7ANyCkojgH8e9Y8/bp7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741347436; c=relaxed/simple;
	bh=Jf3swzHMNlelms5dwP07gBh3SoI0GP/HB2I7Wzx9tNU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kBYCTTwO8EguJn/stTl+LtNoqLYs7zxhWcc8e9d7N6bcoM7G7e4IapJeVGuf+sTpef0+TEV/GkV6g+vU3D6b0ULHGt70PDcIVdwkzmx4BZybpUY9IUGY1+Ij4vFx1VWw2NA5c/zr3L/UXChfUPYKnOreHy8f8RHF17nKo3tBRP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gdBDfcKC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gdBDfcKC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18F62C4CEE5;
	Fri,  7 Mar 2025 11:37:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741347436;
	bh=Jf3swzHMNlelms5dwP07gBh3SoI0GP/HB2I7Wzx9tNU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gdBDfcKCJIlT0kpIBs7+eJW7DeDzJ4CBJxAzlN7rqnhrY68hN0oLOL2EixqVuNlWu
	 +D0TcHHNRr4J4YY0QLku+uJ0yxQj1dDiHNrzBuJZlkdBwmGxoiUZLm0CoIU6oqRDLS
	 7MgRfKD+Uyw+EujbSLM/ZODNVynHuj59CL7DqMPg4afRAz5MpLxX1tWALhUIkxXaVK
	 fRBCzZuAb2u9G3QEoBB0/FSkXYxp8S5MZQYtNZhfYblawSQ4g4AlemOBaDxfRR69Q8
	 n+TGznxYqsgcaOsnbDrdZvNS5RO5Ccqpa5BA3P8YmXXgU8Ub4MGPgojzCmL4nGTSyP
	 vyzSnScDGzueQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 09/11] Squash to "selftests/bpf: Add bpf_red scheduler & test"
Date: Fri,  7 Mar 2025 19:36:50 +0800
Message-ID: <4be1e6de325f6088f80af729b3237bcee450d9f2.1741347233.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1741347233.git.tanggeliang@kylinos.cn>
References: <cover.1741347233.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Keep mptcp scheduler API unchanged.
Use mptcp_subflow_sched iter instead of mptcp_subflow.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/bpf/progs/mptcp_bpf_red.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_red.c b/tools/testing/selftests/bpf/progs/mptcp_bpf_red.c
index b2efd6db7f8b..64bf3c48cc82 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_bpf_red.c
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_red.c
@@ -17,11 +17,12 @@ void BPF_PROG(mptcp_sched_red_release, struct mptcp_sock *msk)
 }
 
 SEC("struct_ops")
-int BPF_PROG(bpf_red_get_send, struct mptcp_sock *msk)
+int BPF_PROG(bpf_red_get_send, struct mptcp_sock *msk,
+	     struct mptcp_sched_data *data)
 {
 	struct mptcp_subflow_context *subflow;
 
-	bpf_for_each(mptcp_subflow, subflow, (struct sock *)msk)
+	bpf_for_each(mptcp_subflow_sched, subflow, (struct sock *)msk, data)
 		mptcp_subflow_set_scheduled(subflow, true);
 
 	return 0;
-- 
2.43.0

