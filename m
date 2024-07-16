Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A355355885
	for <mptcp@lists.linux.dev>; Tue, 16 Jul 2024 20:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721163206; cv=none; b=o/3zovzOS+kON+iHSchop8vXwWE1IpG04vdTtdQ43twCGWGz0PChrX6lgl6AnWjWpvrwNJQT9pm0N9vsNSeHuHwapHVb621Cd27JVJrYdZ93pHDbsKqM4ajtzcWjfvp3OU35jeac6eslvN/4BE0kNez47xVBnT3RoAGX9OFLUKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721163206; c=relaxed/simple;
	bh=el4qRlSZNNEra5/72bcgxC16DUkc+vjJu9h9eGeb9RA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UvZgKo34o2tPclgVf+yg3Q66LVpmcAkLPGKxOPHlCrHEwaIJRc3o8KppUh3y9AwwFp+VreqbT3XdmfpucKseqP8Hc3PPRGuB9bOhJ6aGZwnB+ZBj4x756lagmTb8P7SGNrNHI4EjUL5wWoqyJgXmCV4tRXnAGPyDzpaGBJ5YCPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rVoZbErY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rVoZbErY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD31AC4AF10;
	Tue, 16 Jul 2024 20:53:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721163206;
	bh=el4qRlSZNNEra5/72bcgxC16DUkc+vjJu9h9eGeb9RA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=rVoZbErYcpjIfsEwgRfhPIax91V906E0JmtZqEl3pOs5ZzVHQJd/+ugHZEQiRHKkC
	 h4vV+O9BQvSNq5pn27gH6B9hlC0XpUlRbdxgdBId8qpgKdUoNGrJzPCHffXZwrEVdS
	 gLTce3NTOl2PevjkOi5ciVF62RX3Nnu1yyheWSFtvGKtM20WIf8F1UKx7NA4agfI7o
	 nsTr0YQQTJYOVVe6f0zVO4vm99WxXUGvtuaj4CfqjngiqOanlnRYzpXGJ7q4L0qgyg
	 mGiM3qcP6C6Va7NQJVMAzqLZI4OAwKKrq5FPgDi/4+RHzfNFVRATmv1QpZ2FvI6YZT
	 X4vL1JT097UlA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 16 Jul 2024 22:53:15 +0200
Subject: [PATCH mptcp-net v2 3/9] mptcp: pm: only set request_bkup flag
 when sending MP_PRIO
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240716-mptcp-backup-mpj-v2-3-4d50247405fb@kernel.org>
References: <20240716-mptcp-backup-mpj-v2-0-4d50247405fb@kernel.org>
In-Reply-To: <20240716-mptcp-backup-mpj-v2-0-4d50247405fb@kernel.org>
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=780; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=el4qRlSZNNEra5/72bcgxC16DUkc+vjJu9h9eGeb9RA=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmlt3BkoLlj1yAfXH87p3ZBBZgtfrlqbvHysFkj
 c3yEleRxsCJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZpbdwQAKCRD2t4JPQmmg
 c3ceEACDO4oFLZymmfRHGvHjDyoojmZPgQcsWLBZyKiCraPU9HeWrNLAEZEuJ4pHJ6DEb4rlRGx
 3wYAGTTKlcY7uSurkS6MCjgSkgzixFDm2VXpn8WwNA8ca03Vz2D8Y97HoXtBr1bwVfgINQklvPr
 dt7n09qeSJ0ij02wyAdEr0kdZe1glaRVHWrevNGqW2ci4CFDdoTep+qTUHCc7OjjSY1k2qnXUKk
 quuaSqnUyh7AJxFIPe30U274wElwzmfdwR0+DDmK6jpmSIXtKu7+c/l8LRVpBlRe4wWZlZAIKeE
 I+YfzFj0Ky3veMYhZY+SjSeOO+J72ztpqIg0jJnEbwno06K6u36ySHHtcaaZx1aXus9aefgv9sz
 UYB0NORHNGupOkhlwH1BT1A91Xy9PMGOFRf/MgXgz9Q381ppFe4a3yKadyqAZfpxNKyPrQGoIDK
 UPZaba09NhRGhJ53bIbDaqNlvgI//3ZvMgyz4OncdphwtnhCsacgSZQF/K0fMcFauJGIs8Bm1xs
 hqjpTPSfXUmRxe/iwtqx0dwF29Kp8V2cDXqt/3axaK5J2XDqFqmtLrCngtYq69clIOwYkHBVGA+
 RF9uBuXkaWX7Lqx9UoiEWxvueBYzlRmStNCkyC5qtR0LTBWXA0LNhxExX7IJEaIYak001jv0/Am
 CXHWxMrpo+bzagg==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

The 'backup' flag from mptcp_subflow_context structure is supposed to be
set only when the other peer flagged a subflow as backup, not the
opposite.

Fixes: 067065422fcd ("mptcp: add the outgoing MP_PRIO support")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_netlink.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index f65831de5c1a..7635fac91539 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -471,7 +471,6 @@ static void __mptcp_pm_send_ack(struct mptcp_sock *msk, struct mptcp_subflow_con
 	slow = lock_sock_fast(ssk);
 	if (prio) {
 		subflow->send_mp_prio = 1;
-		subflow->backup = backup;
 		subflow->request_bkup = backup;
 	}
 

-- 
2.45.2

