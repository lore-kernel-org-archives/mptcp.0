Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A90311C3F
	for <mptcp@lists.linux.dev>; Wed, 12 Nov 2025 16:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762964720; cv=none; b=gr75L1GmUTe2tDeGJwgb4+6w6ARuL1C0cm9gMppiXeivxsynPmqxO72QcGlFnjjNmuQGPR36VFPX4NVWT0Q5bjYJvcsarlQ9LeFDFvhMvOOPtkZVLeTiAy5a1zloKxlItqPk6w6o11XlnoePYud2WdsE0myPzL1S/Hx6OeKP37A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762964720; c=relaxed/simple;
	bh=eD7Z0vDjovfsXqPgQXCCtRLsT3hjzQzbBBaIkdazoB0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=jR387dWjx4HnPgV5SGzXhjrRQ+5gJTSU13EeIRxJl/sZXOrrAAtqMiu4oVY7yvTqjbYU/tg2xpX+C7ASK7JTPpY6JhGNcL1BJ0LCqdxHzdPRmUEZlkIrFWVqSLr5Dw+cjRR0koZf/TcS31EgfuIfL4WkFJTVKWhvWZR8JaclN14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nv49rzCV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nv49rzCV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB483C113D0;
	Wed, 12 Nov 2025 16:25:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762964720;
	bh=eD7Z0vDjovfsXqPgQXCCtRLsT3hjzQzbBBaIkdazoB0=;
	h=From:Subject:Date:To:Cc:From;
	b=nv49rzCVHT9/vQgnqOyEiusCu+KHFiOE6vcRvfGy0fyKN0y2NGDNAjRdqzEie7gnT
	 HcZqgsWItxgqpmMIRJfN5LGaFZ9WdN3PcyXccViAaq2e/BFa7FiS89Ina8Tm5csQDC
	 RFI0FwkkLp7IRpkgEoD8FlxrvlxWMPXAO6JmrKdAWRPcQ3jZkva2Y4qaihwVecvrG4
	 e6nRaIcxBaumE9/eJq3pJEBSvddyo90UkKkc667OnBm+BqjjPUrFPvTBrNPrcdu9/l
	 FxkcUiA9gYsy//6kqMcAX50jG1cCmqQgK9v5IOg7sx4qggxcsB0SHXo+DDjBPtVkgV
	 tMc2hvQJ6IOVA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH iproute-mptcp 0/6] mptcp: new endpoint type and info flags
Date: Wed, 12 Nov 2025 17:24:43 +0100
Message-Id: <20251112-laminar-v1-0-e23dbf584aa4@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMu0FGkC/x3MSwqAMAwA0atI1hZs8X8VcVE00YDWklYRxLtbX
 D4Y5oGAwhigzx4QvDjw4RJ0nsG0Wreg4jkZTGEqXRijNruzs6JsS22jO6KSaki1FyS+/9MA7OU
 4I6rdx8nD+L4fBoYLxmgAAAA=
X-Change-ID: 20251022-laminar-a8f8719ff4f6
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1213; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=eD7Z0vDjovfsXqPgQXCCtRLsT3hjzQzbBBaIkdazoB0=;
 b=kA0DAAoWfCLwwvNHCpcByyZiAGkUtOehQo+yHBjUjg49csHojzo9odB8o7YUfNt59AzhPrAvJ
 oh1BAAWCgAdFiEEG4ZZb5nneg10Sk44fCLwwvNHCpcFAmkUtOcACgkQfCLwwvNHCpcmdAD7BNbi
 pSf9GfPzGhG7z6a0z2ryAvTtG37DDvnavzC3nZUA/jL3FLd1ZYzw/KQUIIukdzeai1Gv5UMYkvQ
 GjWvYxLcB
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Here is a series for iproute2 I'm planning to send to netdev. If nobody
has time to check them, I'm sure it is fine if I send them directly.

- Patch 1: add an entry in the MAINTAINERS file for MPTCP.
  Note: There is usually one person and one ML per entry, but I can add
  more if preferred.

- Patch 2: fix two minor typos in the man page.

- Patch 3: add laminar endpoint support

- Patches 4-6: display missing attributes and flags in the 'monitor'.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Matthieu Baerts (NGI0) (6):
      MAINTAINERS: add entry for mptcp
      man: mptcp: fix minor typos
      mptcp: add 'laminar' endpoint support
      mptcp: monitor: add 'server side' info
      mptcp: monitor: add 'deny join id0' info
      mptcp: monitor: support 'server side' as a flag

 MAINTAINERS         |  7 +++++++
 ip/ipmptcp.c        | 20 +++++++++++++++++---
 man/man8/ip-mptcp.8 | 17 +++++++++++++++--
 misc/ss.c           |  2 ++
 4 files changed, 41 insertions(+), 5 deletions(-)
---
base-commit: ca756f36a0c6d24ab60657f8d14312c17443e5f0
change-id: 20251022-laminar-a8f8719ff4f6

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>

