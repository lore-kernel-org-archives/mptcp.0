Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA279D517
	for <mptcp@lists.linux.dev>; Sat, 18 May 2024 15:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716047575; cv=none; b=j9zVVF8u50BY6OvkFFkfVRstoDmEuJGoQe0bVbp6Fg77Jk/ZPNWJSF/DRaSWeYRTP5CmwD6wdo8S1jsr9I6BO11hXmHsdU4FwQLxQxE2r+MZQtyu8cadiSRTwoUl+ujnG/gTHz4zDiuOk9WKdVK2G97ZQXPrbuYYboE9uF6SF2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716047575; c=relaxed/simple;
	bh=KyYQrkMdyci/rHU1cRHxAMxvRWgmsQo9J0ZBXwoTJus=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=pfq91uxZDSSQMBSuNSCJ+DucFcfnBXS20s4Wf7Kv9GN+PJv4p9cSLcS5vJ6CaKJYBcJz5cHquKrAGa7jU53IgCvRZJ7qcs9tJXz75hLT7UI9rJumA7cwLey1udCWAn3SlqI1h6G2nbGIloXGxjTGWL8uVaMmCrbIr8lNyS30yew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Niex4cEl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Niex4cEl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C6E2C113CC;
	Sat, 18 May 2024 15:52:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716047575;
	bh=KyYQrkMdyci/rHU1cRHxAMxvRWgmsQo9J0ZBXwoTJus=;
	h=From:Subject:Date:To:Cc:From;
	b=Niex4cElX+w99f56IIcJ1eGdUxcyK+nzsYpb7LpcfmBAKybGwD9YBAL3CnLFTnU+4
	 GNvZqmnNtycqyBHDgF8/aj+XH9bq2INtZLHCQJKZO6RMZfo9mgV/w5VAkmWxSLqprk
	 opCTkAlpVksm2uXgSO9o9J2a70/laU6NpgWRG6NUGGlfEaFhUjsFjubzYIm94yrlEi
	 zDxKIyL3ePn4JfGrZ3Dsk+dv6M+UVYYxNyqp4Jv5g+z8TvqRJBTffSc16FAZWUCjK9
	 lUsqLM9belRb65qklwOdJ5i5wWw8FTXPMTX8vKo5QAxVN2OP4PKMXO+RXn1HnYNtwT
	 LIk2izd7zn55Q==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH mptcp-next v2 0/3] doc: introduce MPTCP global doc
Date: Sat, 18 May 2024 17:52:40 +0200
Message-Id: <20240518-mptcp-doc-v2-0-68304a17cd7d@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMnOSGYC/22NQQ7CIBQFr9L8tRigoLYr72G6aOinJSoQIKSm4
 e4S3LqcvMm8AyIGgxHG7oCA2UTjbAV+6kBts12RmKUycMoFlexK3j4pTxanSM+kHugwM64EVN8
 H1GZvrQf8NIt7gqlum4nJhU+7yawZf4qZEUq0YqjppZc3gfcnBouvswsrTKWUL+MiEHOvAAAA
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Mat Martineau <martineau@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1208; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=KyYQrkMdyci/rHU1cRHxAMxvRWgmsQo9J0ZBXwoTJus=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmSM7THfNB442HCH/N51lqwVit1oBoggQtpMmsq
 gjrMBko8K2JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZkjO0wAKCRD2t4JPQmmg
 c6RJEAC0uMV1HUFCNh/NWvX8hbPfFy0d1l6nY7F2p6tad8r3McSwEcA3a2KUYS7nvOP9PMxPJ9j
 g/QBtfk09T39wd/pPZbnVGkMojYSnvo6rQiJwJQGAAkZimwcnsyoUyg7BFZjmsNTVm7Dbq2jD3S
 w21xh/naiKUpteHWM4jImsTpl9szuOZvutwpgY7OdQxaNkxRrNyzhut0Ss0iX97lISruQNgwITx
 O1Ec/y2+yD0NfMGFHYbqrAFcsEk52YEvTbiDiI6cJEkU+WTKohKDbWyohXIHiJMLXcEBHpAfB3P
 6FCk/sDB8DOFxJ3DeKUbjieYLxBep0Ga/VvWlrC1XdXMgojdQra5bl7H+nxXXPYuMxrdPfYxo4L
 AK7agB+AGv+dfP8WuyeqPTmLB/Ko13vcNC8saPd+hh7QjPYzhKy/wSloB0DpOD8SGiaRLcK1V/c
 UDij4hTgC0BjsCX5hpyWYkYBhf44v5GvReyIa8k8Jl245wFlCCvaSGUqXYnaI44KKzFVb5ZdsdK
 RFhxhJUNySlB/MROOC01XQwYHPLP4AZ19V6VcqR3xS+Ib+XAbX6qbDtZzFc9qGTVju7LDy7x54q
 7ZIqcFEodu0ckKY5CIGW8x1EmhcVU8MmrNtBuLffFmYG8G/koZ3XDpSCNJ+6T/Y7pMzYIDBnnJh
 UBXY1YvIccU9fow==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

The most interesting bit is in the last patch: a new 'mptcp' page in
'networking' documentation.

The first patch is a fix (missing sysctl entry), and the second one
reorder the sysctl entries.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Changes in v2:
- patch 2/3: make it clearer it is OK to do such modifications for the
  backports by adding a note about that in the commit message (Mat).
- patch 3/3: applied Mat's comments.
- Link to v1: https://lore.kernel.org/r/20240517-mptcp-doc-v1-0-fc1ef063584e@kernel.org

---
Matthieu Baerts (NGI0) (3):
      doc: mptcp: add missing 'available_schedulers' entry
      doc: mptcp: alphabetical order
      doc: new 'mptcp' page in 'networking'

 Documentation/networking/index.rst        |   1 +
 Documentation/networking/mptcp-sysctl.rst |  74 +++++++-------
 Documentation/networking/mptcp.rst        | 156 ++++++++++++++++++++++++++++++
 MAINTAINERS                               |   2 +-
 4 files changed, 197 insertions(+), 36 deletions(-)
---
base-commit: 2ccd59d4df6aef3f553caf11e00af66300448e63
change-id: 20240517-mptcp-doc-315f909a12c4

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>

