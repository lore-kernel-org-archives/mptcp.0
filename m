Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0F001DFDB8
	for <mptcp@lists.linux.dev>; Fri, 26 Dec 2025 06:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766731239; cv=none; b=EVWuepOTlGdQ+4CLDGE1nBqFex/MlmEZVDYg9gP5N6MnZD73Lydx5Y6G4x8Dr0/9tYIMUTQbxC854xTH5NUrsRKC6upAfIZlCMrvAubSdCVQGhQvm4qx6dSfO9vmQd8BUZYUlJaKoHzDhrQJQOzgz0B2OTRZ3CN7/N1JPRFew1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766731239; c=relaxed/simple;
	bh=Qraa+t6rJPZ+4nMSWiWCDFDkvGT+LbudCM71qhohYbM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gRNwhfzO1W/SvQZ4CqcPTe/A1D6joMdV14LfCBM/lyy1S39Zv2jEY6ItUYn2Df6PDt+oenR27zohTOWfUZve+HpfApcgJcI6WzNsoPlmdPr2/tWNLHFOQnOAKHAp8vMVXlySRYpftbekdOoylbaXo4QYD2pAWBg8hnUf26azFTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YwvCESFG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YwvCESFG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1517DC113D0;
	Fri, 26 Dec 2025 06:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766731238;
	bh=Qraa+t6rJPZ+4nMSWiWCDFDkvGT+LbudCM71qhohYbM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=YwvCESFGdfd3DymB/p8zvE+ngdQDACDwkw5lS/B2bLg7sYBgmL1hqHSmjFbBtqSWT
	 ZJqirAiQvF0vEyoFtijL5spUwPGzEKv3x+iuP1jTUMhMrTYwwDVZXkRgPuvB1fGNRU
	 6QehYMxQUhHwuyTlZ/8NQqQXhuiaCfd9F+LLEFA74YvfnTLfq0/Lmj5NFrS7d9bCaf
	 xIPtb0Jq0hYaEaLF2KoBApRFUY6CMloo5mGO+3rYdaD7jVNlvQYj4wlGh2mIQRQb2O
	 It4dXHBaJ2EZpepgOnK2C6I4XVHz131l9QtAQgOXwQ6qcdVFPS8FxtgRbxbPiOTYDt
	 JKLEbMI8Ihhfg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 26 Dec 2025 07:40:15 +0100
Subject: [PATCH mptcp-next 01/11] mptcp: avoid dup SUB_CLOSED events after
 disconnect
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251226-mptcp-issue-603-v1-1-bb30e331b839@kernel.org>
References: <20251226-mptcp-issue-603-v1-0-bb30e331b839@kernel.org>
In-Reply-To: <20251226-mptcp-issue-603-v1-0-bb30e331b839@kernel.org>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Marco Angaroni <marco.angaroni@italtel.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1738; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=Qraa+t6rJPZ+4nMSWiWCDFDkvGT+LbudCM71qhohYbM=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDL9dG9d0D6Qw3S1eH7OsZT0G9lt33eenPDnxJFFGiy78
 ovqvtn+6ChlYRDjYpAVU2SRbovMn/m8irfEy88CZg4rE8gQBi5OAZhI1neGv3L2d/7OuuYlstvk
 e21sb+C3jD9zL1+dbcDfb2bt/3BlxDVGhgnLrqxovbFlz+Up2i8iAhakzTtr/VN5k63BpH/6Adz
 tivwA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

In case of subflow disconnect(), which can also happen with the first
subflow in case of errors like timeout or reset, mptcp_subflow_ctx_reset
will reset most fields from the mptcp_subflow_context structure,
including close_event_done. Then, when another subflow is closed, yet
another SUB_CLOSED event for the disconnected initial subflow is sent.
Because of the previous reset, there are no source address and
destination port.

A solution is then to also check the subflow's local id: it shouldn't be
negative anyway.

Another solution would be not to reset subflow->close_event_done at
disconnect time, but when reused. But then, probably the whole reset
could be done when being reused. Let's not change this logic, similar
to TCP with tcp_disconnect().

Fixes: d82809b6c5f2 ("mptcp: avoid duplicated SUB_CLOSED events")
Reported-by: Marco Angaroni <marco.angaroni@italtel.com>
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/603
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/protocol.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 900f26e21acd..1d68648b5194 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2622,8 +2622,8 @@ void mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 	struct mptcp_sock *msk = mptcp_sk(sk);
 	struct sk_buff *skb;
 
-	/* The first subflow can already be closed and still in the list */
-	if (subflow->close_event_done)
+	/* The 1st subflow can already be closed/disco and still in the list */
+	if (subflow->close_event_done || READ_ONCE(subflow->local_id) < 0)
 		return;
 
 	subflow->close_event_done = true;

-- 
2.51.0

