Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3399113C3EE
	for <mptcp@lists.linux.dev>; Tue, 23 Jul 2024 16:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721752294; cv=none; b=OeHVS2EQj+5BV/4qDkxAS0VJFlXcljWIG4dBlnZ9HGtA/TZZi46rAyug0A7hcea4MUlJdQmbMkx5uKj+tCbnMq1gE/Ia7rkUdA/dEZGMDIXqCxMqq1vGsM/EVhg9/wUKqMvH3bVd/yuNlyBeFihCbymnCOPkfImP1I+4TgJeAig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721752294; c=relaxed/simple;
	bh=6LK+vWpXvXMPJCfqIGEmLGG1ZGT7sOEi4Qt/ngfpWWo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=d+Xtbz/W2Id59TIDXB9EOJgB5nG3piGtz2rGv0+ZM+L+w9IKH0dsLEwHepGNlLumwAtHx8JBXvbvrbG67D3IXzH1LgRI1veAPTO/C1Yu9YSGtnUCBO5o2r9ZQrQS1rQkRRP1RXnMx1OEbd8tt6UUZ/+s8kPVDKP+XkrZq26b/4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fju//gBd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fju//gBd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8541C4AF09;
	Tue, 23 Jul 2024 16:31:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721752293;
	bh=6LK+vWpXvXMPJCfqIGEmLGG1ZGT7sOEi4Qt/ngfpWWo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=fju//gBdNcQ4CS85yKUQrjA6TXSQpWsthPWIUDy0K25fZ12yNz+OtLD8oQZXwZbmw
	 TE/3YZU1ZhrphdC+1piIyjQb8rRspvauscPQLfI/1UTv6FCT6v8V2OUBx4wH1aJhBD
	 xQZCZDpUU3820HVxlo4NedJPWGlhsRPiCZmtBETkHtFkpVAAkQNDJLCVRVZGldNUxF
	 GYZTRavL0ra6rO7tXxlkNU6HzI+4fc95bXUeRN/oWGQ9ZgoUAEn3M066sQjy4Tg928
	 5iLirt8H+NAojE6iZwvc4zNCyXhSgz7ED6s1cTIF1mTR86FOfhKQJiMaDadO9EEFQx
	 mQuVHXAs1i38g==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 23 Jul 2024 18:31:06 +0200
Subject: [PATCH mptcp-iproute v2 3/7] man: mptcp: 'port' has to be used
 with 'signal'
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240723-mptcp-user-feedback-v2-3-59f18975401c@kernel.org>
References: <20240723-mptcp-user-feedback-v2-0-59f18975401c@kernel.org>
In-Reply-To: <20240723-mptcp-user-feedback-v2-0-59f18975401c@kernel.org>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: Mat Martineau <martineau@kernel.org>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=937; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=6LK+vWpXvXMPJCfqIGEmLGG1ZGT7sOEi4Qt/ngfpWWo=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmn9rgWRpyy6J1akJmPU71gohplzbp/CGcQ8FcW
 gBnjpqIWK6JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZp/a4AAKCRD2t4JPQmmg
 c+QrEACnTfJMv3vXCY1B0vrVY3P2fBpXPsFHoTEQNXDqA7GK6C5ArZy4IrtzRqWPwKadqyCTWXl
 KJEWCQwR+8e6fA9sfq9ULIjWJTbxL3X71sgbim9fkWOhtR6ABYC3Bfwhc9NeMreFkyWmRs1HbNN
 OnrPrGsS2QHWrcHC/5HjHfTBJdYVtDtB+hvqYNBlS7cq9b4YIYqtxmW8572M7K7tuIyt6cPIm6m
 7O25zG5DLluea166DcBH/YovenfpHNXJJSpLW8fWEyrK4X7eDD6zWR5lsG83iQgsO4k44tmGLcq
 QZ0fqrMCgm0zs4Ab0xYn+XpAu+IcCD2G334TfBs1+fY6dS6GL1RmdFCSAnmd8qnfmpLhvzG3GyT
 R0yHOmJlAylmsrrZn87GUZU2XaIQW1CcWa6YOHuOC05GwV0qp9ZzGu+mKRxq+U44vqx+sNmbKKs
 2mSP4VaMPQYFi2CRQIS2xv6A5v6dNRQQquIR2KIIawxRF+a2IheRmCTPaeaEpYeanM5dN/4NoP6
 HzFAU51X9u11/A5iE7UF1vAsDSEbi0VFyrMFnMGQyblewf7w+6OT2T5qzQFhqPC7CHDxlP67cLu
 f0VGa2OZeJptThf0Z96RJuT3GRBvzIUJULHY5HfoFbjiQ7zuHuKtvlhO7PyMxNXkj3PjbhiAydk
 IVVX9yNvsKwsM1Q==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

That's what is enforced by the kernel: the 'port' is used to create a
new listening socket on that port, not to create a new subflow from/to
that port. It then requires the 'signal' flag.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 man/man8/ip-mptcp.8 | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/man/man8/ip-mptcp.8 b/man/man8/ip-mptcp.8
index 2b693564..11df43ce 100644
--- a/man/man8/ip-mptcp.8
+++ b/man/man8/ip-mptcp.8
@@ -133,7 +133,10 @@ is 0.
 When a port number is specified, incoming MPTCP subflows for already
 established MPTCP sockets will be accepted on the specified port, regardless
 the original listener port accepting the first MPTCP subflow and/or
-this peer being actually on the client side.
+this peer being actually on the client side. This option has to be used in
+combination with the
+.BR signal
+flag.
 
 .TP
 .IR IFNAME

-- 
2.45.2

