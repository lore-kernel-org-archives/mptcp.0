Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DFAB34751D;
	Thu, 21 May 2026 03:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779333015; cv=none; b=JNLCVVrvPknWU8ZymrNVmPF3qdmnJ4eth4yb+EZ6nbsnK3FCtw64DGewKj+3ZCVuVngdentK3gMy8/e+xjRyenb8idvkU6Nxu1kaYlQrCpwMDpNMrKMBxkZX2/9BPF2XxQJrmJDjTq3zkkczXS/FRSNoDDSiplNYoq9W5dqKoZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779333015; c=relaxed/simple;
	bh=XnBdZmpfxwLa+jDeESXDedyEqB5bg+1rl8o33X+EU6M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AmdAIGoHjbT20T3HNd0GPzTMSMOl4cZ7Hk5wIj2IYTRtS4lYqJIXbN8JXqIKjTLl0MeDSg4WSxRUazT/05oTVfqXd+CI/DVuYH9M0zLahkjUP6rwABOTE/RKqIxwQvsYTulVydTWMdsaLNuFqS1W6KjZx5AipGos2nLiuA2pERo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W5H642vU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W5H642vU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A53941F000E9;
	Thu, 21 May 2026 03:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779333013;
	bh=OIk4dRGfFvsN3/kmc3RXYxUfYb/eAKjQvNSlKXbCBcM=;
	h=From:To:Cc:Subject:Date;
	b=W5H642vUDZuNh3G23PtC8Fn+qTqIxbNenpuQFznYiNQHC2WcpaIZuJzx4oZyK31Vr
	 3Qlp3Ab3fObVlL6+i8OMVzCU20Ft0yokYYAqtIqUmdIGbenpte+7GAj8/V2AQdEMYA
	 jEYnRUW27+uTl2jQ7Q+tVtvg/fvZ4OWq3osd+/oBFeYBGfvmT9qAb/lCfcEq814nnu
	 ZuJXchgx8S5J8zTsKa2UNdUyh1ZfIH+5mXh4xDVIAIYy7I+HRYcUlWNlZDsvCgajog
	 6S2enx7MQJMvRIZhjcakf+5bzVQWG/GeDjd5RPnhKscyt+lEkpHQUlQe2UNqpYUkYS
	 J0d2poMpJS4+g==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: mptcp@lists.linux.dev,
	stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	sashal@kernel.org
Subject: [PATCH 6.12.y 0/4] mptcp: fix recent failed backports (20260521)
Date: Thu, 21 May 2026 05:08:46 +0200
Message-ID: <20260521030845.723267-6-matttbe@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=802; i=matttbe@kernel.org; h=from:subject; bh=XnBdZmpfxwLa+jDeESXDedyEqB5bg+1rl8o33X+EU6M=; b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLL4yl3rcu9pP/bp79gRuK+Jl4eviO39roiKidsvxEXd1 GsvOSXVUcrCIMbFICumyCLdFpk/83kVb4mXnwXMHFYmkCEMXJwCMJFVRxgZVhuGMPAuKu58HpyT fH+l5s2olk0VmZYWRzJuuRZwZq+WZ/grLOGZucDx5LFzNQputWUBszX7T3JJHFHcsfugTNiMqm1 cAA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

The following patches could not be applied without conflicts in this
tree:

- fcf04b143346 ("mptcp: sync the msk->sndbuf at accept() time")
- 03f324f3f1f7 ("mptcp: pm: ADD_ADDR rtx: allow ID 0")
- 9634cb35af17 ("mptcp: pm: ADD_ADDR rtx: always decrease sk refcount")
- b7b9a4615697 ("mptcp: pm: ADD_ADDR rtx: free sk if last")

Conflicts have been resolved, and documented in each patch.

Gang Yan (1):
  mptcp: sync the msk->sndbuf at accept() time

Matthieu Baerts (NGI0) (3):
  mptcp: pm: ADD_ADDR rtx: allow ID 0
  mptcp: pm: ADD_ADDR rtx: always decrease sk refcount
  mptcp: pm: ADD_ADDR rtx: free sk if last

 net/mptcp/pm_netlink.c | 35 ++++++++++++++++++-----------------
 net/mptcp/protocol.c   |  3 ++-
 2 files changed, 20 insertions(+), 18 deletions(-)

-- 
2.53.0

