Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDCF727877D
	for <mptcp@lists.linux.dev>; Mon, 26 Jan 2026 19:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769455490; cv=none; b=f0HL2ECmeo8r6K9yeJYmGghHByr/CSrjkC1tBzhQL0M9k2MHnH87qwZREgCrhsnXVwd3xlLyuc7V6kEpcFkbuWglILCG4LuAlTiywRCY1+f2NjzZCdnbS9v4UHahlYdHfWat7Sl5TJBtLf58PXHfqxSojrQ3veTVW9bU3z9viZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769455490; c=relaxed/simple;
	bh=cgQfp6q0YozSh4yXrM6GTQAGJfIOMetJ1A/1KU7GNOM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nG56Fj8Rkj1AwGxAtPmkYW7Awyhfq4r9HXmLp8P52Ssn/1gQ85fXkj5OrAJDICq7iobVp3m/PdW8h+ov7+cAW2nyAi0sJWaXOEqWhry0OWDuG6T/oreXMqK9IOpRRD+c0ACoCnoiCtt7unw9B8lG55cjplkvzGGkX7xzEqVwD60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CC2ZOcKe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CC2ZOcKe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 010E5C19425;
	Mon, 26 Jan 2026 19:24:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769455489;
	bh=cgQfp6q0YozSh4yXrM6GTQAGJfIOMetJ1A/1KU7GNOM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=CC2ZOcKeJCHxVH7V9nORyU6D8wx2xpfMA3vcf/BaeL0RY3ZYWHo65dEiTRP55HGcX
	 guQo5OdHSgBRuK8p4e9nSg/voP9XbonT6rdBvYJMMaAuPNp6YiDVmnfhWz/RnXx+J8
	 mCGws1ii1Dhe6ARO+V7po3kny+AQl235rfFhvKX9Pq5b/7Yi7AQpxjZ8zrUKoHxn1O
	 hd2lfFHdwQiFl7Xm7zzWyCxeILJjIKfZjSw/u7DuBRZMq6MLWDQ7+uvYtpDWTWlDb3
	 e5g7Iu95YD9HrxUZnJCPRD80nzfwUcJ+JpDMsyW2G7EQC9W8rIpM8BdbdBoLsu4cFN
	 VZV9eAIgFlG9w==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 26 Jan 2026 20:18:38 +0100
Subject: [PATCH mptcp-net v2 01/11] mptcp: avoid dup SUB_CLOSED events
 after disconnect
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260126-mptcp-issue-603-v2-1-8393e7840b9e@kernel.org>
References: <20260126-mptcp-issue-603-v2-0-8393e7840b9e@kernel.org>
In-Reply-To: <20260126-mptcp-issue-603-v2-0-8393e7840b9e@kernel.org>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Marco Angaroni <marco.angaroni@italtel.com>, 
 Geliang Tang <geliang@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1811; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=cgQfp6q0YozSh4yXrM6GTQAGJfIOMetJ1A/1KU7GNOM=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDLL91euTlWaYxx3497c3wvUd775Vx2X/29CatxaWb2ko
 3vvMD+T6ChlYRDjYpAVU2SRbovMn/m8irfEy88CZg4rE8gQBi5OAbhIJiPDee70eXuEJ029teH0
 v397nUt/Mdmdz753tDGjaZHCX47+RkaGmUbmRwNDNhWFNc7ZIaDnqFV4I2C3id6m/OfyXxjtprz
 kAgA=
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
Reviewed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
v2: rework comment (Geliang)
---
 net/mptcp/protocol.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 900f26e21acd..335a1723c1dc 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2622,8 +2622,8 @@ void mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 	struct mptcp_sock *msk = mptcp_sk(sk);
 	struct sk_buff *skb;
 
-	/* The first subflow can already be closed and still in the list */
-	if (subflow->close_event_done)
+	/* The first subflow can already be closed or disconnected */
+	if (subflow->close_event_done || READ_ONCE(subflow->local_id) < 0)
 		return;
 
 	subflow->close_event_done = true;

-- 
2.51.0

