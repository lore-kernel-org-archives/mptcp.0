Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBE913CCFB6
	for <mptcp@lists.linux.dev>; Mon, 13 Apr 2026 14:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776089532; cv=none; b=u4UIb8cpm2+SeKlfB1Hxr6tuPI57PSq3cunfomJLfe6jGKEIj/vlY1RRzJv81AWV5h+MWvp+1+X9ck8Ca+5C5mF736CuUSEXH0TGCh1f37W0quiPLNfFojzTA89g/wGjVvfbhiLgD4xMU5OJNYIOtmvk9WN5lm4tKo8zSbxxz/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776089532; c=relaxed/simple;
	bh=CsvRWitzZn6GxqMqgzfxKxMcX9py9XEG9S6Y+8biWXc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lKVhoy4rELnXWy1ONvOyXgr3sXN/NKA2yZQ4GKtPstWuJYKXMTG2UgU7ZcAL0hVfzLZUswaKFWoprqOkoC9cfzZxDYPSZdLTbl1PhWJ3qCQWOGhymaj+zS6or8dsYpzBJcHwPUTthA1MFNZCo+E8lsmUK/19CCAeh4MtW//3w7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TpaBK+Ar; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TpaBK+Ar"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30C9DC2BCB6;
	Mon, 13 Apr 2026 14:12:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776089532;
	bh=CsvRWitzZn6GxqMqgzfxKxMcX9py9XEG9S6Y+8biWXc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=TpaBK+ArGYR8uIkJDSgAkiJvAvooyxFUYhd3SQGsnPdOUTijB8zr9OGza04mWxxtg
	 TjuyqbKD8gnMCN0wS/eDehGUU8NGUmCYH0UO5fSa4VO8u0oJ9t3JNRkPsK7MbViBuT
	 pNUx6y/hjzPhmpdrme3gcY5JOWYPnYWPWDLh8jyKDRMSGBdr8aqLUvf4wHx/q0tRdJ
	 LIZiaq+gvzLwVKnewX6qmiGw5Z1SPg24LK1ZeLL0H4jngfg+TdF4Sm1WxjZ8wJtNwK
	 WI3h1SAk2vXSnV5Anw/+QhGOemV1L4z7PjRPqx8bZujjslrQ6NdGYWnMjK2R4V7x7w
	 s5NUWbwullv1Q==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 13 Apr 2026 16:11:54 +0200
Subject: [PATCH mptcp-net v3 08/19] mptcp: pm: retrans ADD_ADDR: return
 early if no retrans
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260413-mptcp-inc-limits-v3-8-dd36c9360432@kernel.org>
References: <20260413-mptcp-inc-limits-v3-0-dd36c9360432@kernel.org>
In-Reply-To: <20260413-mptcp-inc-limits-v3-0-dd36c9360432@kernel.org>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=747; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=CsvRWitzZn6GxqMqgzfxKxMcX9py9XEG9S6Y+8biWXc=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDLv/FxbL++7LuCGoFMQU4n5DJfP7vqPqp3Td2nebZs5w
 TOkM8umo5SFQYyLQVZMkUW6LTJ/5vMq3hIvPwuYOaxMIEMYuDgFYCIvPRj+Cn8LWn2r4vnKl6uO
 XVptpHjm8OHu7Z/sRMLU3Q8cvSfReIXhf8KhxxuWNP0JLbx99w1nlK6IwWVlWbVmiYt8jK+Ob/s
 4kw8A
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

No need to iterate over all subflows if there is no retransmission
needed.

Exit early in this case then.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index e2d62131023c..b3c4a6c75c27 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -308,6 +308,9 @@ static unsigned int mptcp_adjust_add_addr_timeout(struct mptcp_sock *msk)
 	struct mptcp_subflow_context *subflow;
 	unsigned int max = 0, max_stale = 0;
 
+	if (!rto)
+		return 0;
+
 	mptcp_for_each_subflow(msk, subflow) {
 		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
 		struct inet_connection_sock *icsk = inet_csk(ssk);

-- 
2.53.0

