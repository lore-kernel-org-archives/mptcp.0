Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D38272877E8
	for <mptcp@lists.linux.dev>; Tue, 21 Apr 2026 15:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776784797; cv=none; b=QaymJB7icRrRv2AiPd2bL7dTlcJA7D2PgBgJ9rZNRu6t0G5Un5SSTP+dC70houabU29+c28b1/R1ptLOCn/unIamK8+99AN8/06PKKnRvZKjpIOO9JgDXoa3X5DFRiCApu6B9SH7PtJiR0SFEqzQ6pkGAoSsO6PSHIHutHPhhuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776784797; c=relaxed/simple;
	bh=exSQ6R35rvGwiDBFJtNX2ZMdkSTb86TkGXOrpM/94Dg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=UxaIw4d/FqfXPTQ6yOqtBv3sEMqLhVKTYP0hZWvSA+sUOQsyjmgT/ivaS9Jug3bynAGv6dkQnn9AcP09j7cJJlJYA7P9vaj8+1XKsECJFgdnBIwAgLFumokip179qbkotVQBEm28Xwh551WVrgacUzkbTLzlSAsanBI+xdwzFfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LmY57ptD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LmY57ptD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05E64C2BCB3;
	Tue, 21 Apr 2026 15:19:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776784797;
	bh=exSQ6R35rvGwiDBFJtNX2ZMdkSTb86TkGXOrpM/94Dg=;
	h=From:Date:Subject:To:Cc:From;
	b=LmY57ptDEn73xmLb6nOTxiMH/4VszpMEVb7+3bBlkyy9sjfQmxCOyaL5r1BqIzj2I
	 nan4kWnu+j8coBknrKKoipm40R8+z+SV3CunDKimtCVbgWJ798xiopYmCPBLJKFZJk
	 YTa1c39oTIAOU7ac7TvUg9FrDAatOd6rNTyxdGk+clum54O3gta5/xGSSjA9sX5PnZ
	 1sCk/dI7Si4kic0awEIahCa0t/lg71JbExAiVSmfd5PZT8XYLvHo8ouY+Ew1h+EMCH
	 cXUQte5FNjJeOTTXBjTvRnQPmQFKXOtBHJxxxu58AnbfB3XYyWRmqdHTlpEHhuie1M
	 o5GT9EPi+L6zA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 21 Apr 2026 17:16:01 +0200
Subject: [PATCH mptcp-net] mptcp: fastclose msk when linger time is 0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260421-mptcp-fastclose-linger-v1-1-de94d7bffc0a@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWMQQ6CMBBFr0JmzSRtpS68imEBw1THYGk6hZgQ7
 m6V5cv/7+2gnIUVbs0OmTdRWWIF2zZAzyE+GGWqDM64q+mcxXcqlDAMWmhelHGWesoYTGcv3tH
 k2UOVU+Ygn3/4DqcTuUB/TrqOL6byC8NxfAH171jChQAAAA==
X-Change-ID: 20260421-mptcp-fastclose-linger-f041352cd5e5
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: Lance Tuller <lance@lance0.com>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1857; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=exSQ6R35rvGwiDBFJtNX2ZMdkSTb86TkGXOrpM/94Dg=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDKfT51zryl7ScyCg3M1ZXq93KRmpb9siXDn4C/+7ud6f
 07a2+oJHaUsDGJcDLJiiizSbZH5M59X8ZZ4+VnAzGFlAhnCwMUpABOZwsHwz6pOI3Nq4t+6v1bX
 PixY3jmr4KN6reUP95y1CX9UpLsVNzD8d+Fa35Vf8sk3ZJ3vuYy+ABlW8wr3XQdDJZP2M3EeFFr
 BBwA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

The SO_LINGER socket option has been supported for a while with MPTCP
sockets [1], but it didn't cause the equivalent of a TCP reset as
expected when enabled and its time was set to 0. This was causing some
behavioural differences with TCP where some connections were not
promptly stopped as expected.

To fix that, an extra condition is checked at close() time before
sending an MP_FASTCLOSE, the MPTCP equivalent of a TCP reset.

Note that backporting up to [1] will be difficult as more changes are
needed to be able to send MP_FASTCLOSE. It seems better to stop at [2],
which was supposed to already imitate TCP.

Validated with MPTCP packetdrill tests [3].

Fixes: 268b12387460 ("mptcp: setsockopt: support SO_LINGER") [1]
Fixes: d21f83485518 ("mptcp: use fastclose on more edge scenarios") [2]
Reported-by: Lance Tuller <lance@lance0.com>
Closes: https://github.com/lance0/xfr/pull/67
Link: https://github.com/multipath-tcp/packetdrill/pull/196 [3]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/protocol.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 6b486fc94c16..0db50e3715c3 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3302,7 +3302,8 @@ bool __mptcp_close(struct sock *sk, long timeout)
 		goto cleanup;
 	}
 
-	if (mptcp_data_avail(msk) || timeout < 0) {
+	if (mptcp_data_avail(msk) || timeout < 0 ||
+	    (sock_flag(sk, SOCK_LINGER) && !sk->sk_lingertime)) {
 		/* If the msk has read data, or the caller explicitly ask it,
 		 * do the MPTCP equivalent of TCP reset, aka MPTCP fastclose
 		 */

---
base-commit: 3662f0d0a0b4cdc50193718dd64af57d671ebd59
change-id: 20260421-mptcp-fastclose-linger-f041352cd5e5

Best regards,
--  
Matthieu Baerts (NGI0) <matttbe@kernel.org>

