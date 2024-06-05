Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35DB0153BC7
	for <mptcp@lists.linux.dev>; Wed,  5 Jun 2024 20:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717619904; cv=none; b=p5NmqOXW/6anvbMh1YmomMPd8XBTeJP0j15X3jRkdL2S6SIIU5mYz7X8YuLLLNUxV3PaTjJNUyTukbDTwcaS7SlfX6iHjGsO83ws1ZiO8wRWbFtW6wwgRD1QQhlm8pXzdj9Ft/DA8atvsgSRJcv7DzM9uP2lA2PRHIZm9s9rJ88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717619904; c=relaxed/simple;
	bh=Bs3j58opDkRedLZeWed97gBvqvVcYioQeebI/ZBD6IE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=fCSGik5nXxqgYj3ZOK77VmvjNr9NYXMtasCwxXb2INRapStd81RHUGlIpuL7qqaXgSPyLCPtgJkpirW3cJwdywjA8+DFlq88ghAIp2MuKtVnkt2755UWu2JWzUZj8x3ePF5brMrzi6e7N/EEJO4+ldWYIti1FYao69Vtf8DdVAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LQwY5Ox4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LQwY5Ox4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8A14C2BD11;
	Wed,  5 Jun 2024 20:38:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717619903;
	bh=Bs3j58opDkRedLZeWed97gBvqvVcYioQeebI/ZBD6IE=;
	h=From:Subject:Date:To:Cc:From;
	b=LQwY5Ox4BP5j6tEFZNUkb8xJ1flIrEDJk7+/uDwRgt3uMu9OZo1xIkO12LwK9GxpT
	 3rumD30V+UdSX5ORI8iOI04D3HOIf/lF4DYGH8O61S5L2LRXowq0mKHXlTvm3sAKMG
	 N53QKW7pB8y9pHLwjmz76aeyBrqg5uXTgD4fqm9cM/G8PmEbSDUKsIKOcbU7xmtsh/
	 QfFuZ9igYn6bApcjeTGOxaipIWByI3tkrhhdqJPQYqGaWub/pb0qJ1xv3vURw6Tfpj
	 rnsm73tACPJAcMV4KSKiPn9ivJ0cPUoAA/ekPntXS0yqurjhfjQGNV6vHA/QayVWMt
	 oP9n47TScnCfw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH mptcp-iproute 0/4] mptcp: guide the user to avoid mistakes
Date: Wed, 05 Jun 2024 22:38:11 +0200
Message-Id: <20240605-mptcp-user-feedback-v1-0-d2dc3b399643@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALPMYGYC/yXMQQ5AMBBA0avIrE0yGq1wFbGgBhNB0yIScXcNy
 794/4bAXjhAldzg+ZQg2xojSxOwU7uOjNLHBkUqJ0MaF7dbh0dkODD3XWtnJFOYMtNKk+0gSud
 5kOu71vADcX47dobmeV5H5HAOdAAAAA==
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1102; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=Bs3j58opDkRedLZeWed97gBvqvVcYioQeebI/ZBD6IE=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmYMy94zU1xrJBtUdCkYzxt4ldIoPGdIkYXrsAD
 iQbfBG+80+JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZmDMvQAKCRD2t4JPQmmg
 cxP9D/9wzP79iboQyLGVXMSJ8uSylAqT9ycSe2znHAHl5oH5TC0wyybHQ69JS3ANvEv1VIg6cQM
 8Nee9UlSVBUF0w3AJdcQCuVS3OOK+zKeYBNX1EIFBgkPn5Rjd4roLKL28wdP1HtQpxxLHrwKi95
 m84PDNMtbJvgDF79XuOEO9gtnkEh1gvp5fLx8yPEmtirwHkmYo/8EZoGRpZotIgxEGVXs2HsknB
 qAuDV1P/Kn4A56jG7VwaE21Bydmn4H9ony6dMD9Rt10WivCL149vOGZokhVkJJMfYDTXiRT0zIb
 ve/8RQBhQXOPBs55++S8qj6Byn6nErG4Lm62PYJmAOGtq9aEfvNYmf5TivULQXxzJjX9yUtuB+t
 LJ1HVai4NI0c+78LYGhNlJbvfLCXjJbwDvm5doqEiA/rv1sPK/hKx/MxElIMeUQ09H+ATM8L5Rx
 6AsWgqfKLDJBgnTCERGtNurA/Y7Lw6aln77nSD9N0BbDNkJHb04Hhsx+2HfDDYXIMVD4zqNdetf
 fgSU+Z95cERnMn9c7ziwZcGp9GPX79xrNZaszPg93kIEqlsR8nxi8LLFbUz3ulrOZSUE31jmqQp
 ut7L4rYkmPkibyGn7ABsavxc/IJIiKTZ5dk0yyagNInB7IjmqDt86ERc1pNMBWsBM+pINSBTGY3
 y7QNz7UntHmlquQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

According to some bug reports we had in the past, setting the MPTCP
endpoints might be confusing, and the wrong flags might be set.

Adding missing info for the 'dev' parameter, and clarifying 'signal' and
'subflow' flags in the manual is a first step. But because people might
surprisingly not (fully) read the manual, printing warnings to stderr if
the 'signal' and 'subflow' flags are wrongly used is a second step to
prevent frustration, and bug reports.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Matthieu Baerts (NGI0) (4):
      man: mptcp: document 'dev IFNAME'
      man: mptcp: clarify 'signal' and 'subflow' flags
      mptcp: warn if 'signal' and 'subflow' flags are set
      mptcp: warn if 'signal' or 'subflow' flag is not set

 ip/ipmptcp.c        | 18 ++++++++++++++++++
 man/man8/ip-mptcp.8 | 14 ++++++++++++--
 2 files changed, 30 insertions(+), 2 deletions(-)
---
base-commit: f9601b10c21145f76c3d46c163bac39515ed2061
change-id: 20240605-mptcp-user-feedback-0676915250cb

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>

