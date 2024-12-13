Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 145E81DFE29
	for <mptcp@lists.linux.dev>; Fri, 13 Dec 2024 17:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734112527; cv=none; b=dw1Ugq8cTLQApzFY2h9+tPqktpvbPn4Fh4FYwnroN1nRVVbtU2EeoP+g2ltEmtHw65Jwodw39NqItMB29fTO8QVPJ/cBExaoCHwIdEfhZQXhJGmqZq8MHX1K2kGj5oPV1VkZHtiUFgfbKqXZV0AKiMNxJJxQyNZx+4ONkTlbvC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734112527; c=relaxed/simple;
	bh=Dd1FACokDMBbW+30zaKlNXYWsmffBUIGHRug3y/gLzY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OUfdudmk+Zz+qEaKll3UKH/TmP+0hZpXB46Xk3MQ2yE6R86iIxqBLqu1MlRD5+UxmXbrQA4cKdwrnOR41bw60VIAxEGgCHILkAfvYevrWu1aOph5aUy7FMwpQMWjdsv8I9fgZLhDYtT+cvVnRnF3Mznry8Ea7iZMboVrWQ6u8u0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j1hfh0Rp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j1hfh0Rp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AEEAC4CED1;
	Fri, 13 Dec 2024 17:55:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734112526;
	bh=Dd1FACokDMBbW+30zaKlNXYWsmffBUIGHRug3y/gLzY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=j1hfh0RpuKjE0/cLDC5yIr8JgzvyJFg+yzxSuWDh2/DDwyEDEX1n8DmaTlRq01fDj
	 8QcdmwyQbG99aGkI4TQlzqfxW1S4nlY4mREWPkB4JXMcfBrJLxbk9Tj47w2K+NuM5t
	 bKWZQ0jtThaFUAQYdHGpj2uYStiokAsF/R/7oKweTstFgorIfj2vmlIv1mFvxyBECv
	 yGD/94bLEbFJzp2PUBo87LMuYstfOK5qmwXflb4gpmJPpIS4VyfobLTmGBfyPLVLVt
	 z9ik8meXnqD3lh2Gr/KoCSmyOAbP1Qf4XO7VoQ+B9OXV2DWKJCC0F3avmDBgJgTuiW
	 QtOcAMAg1C1kQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 13 Dec 2024 18:55:06 +0100
Subject: [PATCH mptcp-net 1/2] netlink: specs: mptcp: add missing
 'server-side' attr
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241213-mptcp-pm-nl-spec-doc-attr-v1-1-e43165c94e81@kernel.org>
References: <20241213-mptcp-pm-nl-spec-doc-attr-v1-0-e43165c94e81@kernel.org>
In-Reply-To: <20241213-mptcp-pm-nl-spec-doc-attr-v1-0-e43165c94e81@kernel.org>
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1478; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=Dd1FACokDMBbW+30zaKlNXYWsmffBUIGHRug3y/gLzY=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnXHUMdNMvbJ6H0OtzpSxhkKrydqRWMUcd8WQVE
 peuVd8TRxOJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ1x1DAAKCRD2t4JPQmmg
 c+PFD/wIPTU66TqJEaLmLuy13xh0P+NUix5Hk6d4Llx5d+81aF6L3A+Ld8x4/25uRCfu1sFTVyr
 8J6SqtlBG4zaF9V5Yc1wNvFi1q6N4IdXppUplRAT4gpkhqDruvaov6MjuabAjYPw1Vokz8GHAGb
 SkQV2CdgYe2gExakjmoxncOcLkjUFEQgYpeL3OS0UqokCtCPKjl3Q3znMSuQwneLoY/32n3kIUf
 KqmKBK2Xm4Tgee3HJc14CtByQBef6T/2hd930x2U4t75hEyPSv7DpMLUKrXmiHIvFa1qXtxh3yU
 MmK4dR2I1j2ewZzPqMwNQQCUqAOPyv9pFOpcCnbSgp/EZGdSAyFWdnnk6FdTP0BNQak4KA5Rdtu
 N0Dey2g9PkTLUBP4AGIEhprwJ694RwfjkUrhOMtcp1qMLOYsFoV5pNXYvY7SkTvk/e13h7/3OjS
 Y5OBhVEjROJdi+m989I6ag+LCmbj8TLZKsQNjCxJdafA2Wf4NV8S7qAoXIUMAI8rorNliWM8iby
 oZ4boNsnE0i/kfMJAnEEYZrK+4q6ciz3QLXmR8tKP4YN0Ullzgj9r651OEGOFwA0iciREUkNcKQ
 r4z6V7nPIeZxWyVxPCQVjWemQsiX0m/6WB3c4A1voWXV4qub3Ajf5FebrFF/+VX0j4Ot6zRFdO8
 4K7L94IdGawFwpA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

This attribute is added with the 'created' and 'established' events, but
the documentation didn't mention it.

Fixes: 41b3c69bf941 ("mptcp: expose server_side attribute in MPTCP netlink events")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 Documentation/netlink/specs/mptcp_pm.yaml | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/netlink/specs/mptcp_pm.yaml b/Documentation/netlink/specs/mptcp_pm.yaml
index dc190bf838fec6add28b61e5e2cac8dee601b012..fc0603f51665a6260fb4dc78bc641c4175a8577e 100644
--- a/Documentation/netlink/specs/mptcp_pm.yaml
+++ b/Documentation/netlink/specs/mptcp_pm.yaml
@@ -23,7 +23,8 @@ definitions:
      -
       name: created
       doc:
-        token, family, saddr4 | saddr6, daddr4 | daddr6, sport, dport
+        token, family, saddr4 | saddr6, daddr4 | daddr6, sport, dport,
+        server-side
         A new MPTCP connection has been created. It is the good time to
         allocate memory and send ADD_ADDR if needed. Depending on the
         traffic-patterns it can take a long time until the
@@ -31,7 +32,8 @@ definitions:
      -
       name: established
       doc:
-        token, family, saddr4 | saddr6, daddr4 | daddr6, sport, dport
+        token, family, saddr4 | saddr6, daddr4 | daddr6, sport, dport,
+        server-side
         A MPTCP connection is established (can start new subflows).
      -
       name: closed

-- 
2.45.2

