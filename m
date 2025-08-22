Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6216731283B;
	Fri, 22 Aug 2025 14:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755872310; cv=none; b=sqomGO79OoNC2uiclKXUxiUi6bcFVmoJAYQC2/EgP/oY450IPO7uDV3PTseSp03hrgCCpvVrlgoNYUmhmVVWDFzGa2pReGGckj6T+6Vjzd521AuoAX0wDlLXIDR3nvQkTASm/il2isHIpsDhNc2gglgJltVmSbWpnbk0uDScnAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755872310; c=relaxed/simple;
	bh=YPHXDD9oTZ7YqUQcqBqzUk/QY6MAFjCqpYNcHsVGKJg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SFbHYkKBiFwTMqjlLEK/MUU6X1okrHQfJK9/V1m4hyRW6NVypgKI9Nux4TEosWYLgJ1Z58ChCHWrLpgVIrRdjTaxoCqtd+kS07IgGggrf1BkhNLtBXEUAHuzybGcQfTi5zeMMTbod/ZYskl0m9r3F6xV9joCKu/5+1pbKikQFnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XhrGcV8N; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XhrGcV8N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCB98C113CF;
	Fri, 22 Aug 2025 14:18:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755872309;
	bh=YPHXDD9oTZ7YqUQcqBqzUk/QY6MAFjCqpYNcHsVGKJg=;
	h=From:To:Cc:Subject:Date:From;
	b=XhrGcV8NJtEN4taRM5lAwcaYXzkiAEn0nqDqw0sG/+tsH5vPJVHg/JX46LNiXlLbv
	 kPp5TNRHqsqzOAsrqrqdiya41ks5g1PEjtXmsDw8cb2PWFHBGsY13wa9b514rKpCa4
	 OT7vfz5XaiNSBKLf+rM/IUqoulXaXU7QaAaQvaJsA9a9Cb58AlJfujX0mwf+qojUBK
	 /lTYTg4IByuXynJvswkllfkFZbfS+fCrrm9u9EUZN12K3bGTCQAuJTt6eVoely7P1o
	 flxm9FBOWrFLotysmhCHbZZ/6PfDcCZu8ke2SqQlyseQiBQM2xEDOH5KX8IYkJQY53
	 HNjd3B5QCPm+g==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: mptcp@lists.linux.dev,
	stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	sashal@kernel.org
Subject: [PATCH 5.15.y 0/2] mptcp: fix recent failed backports (20250822)
Date: Fri, 22 Aug 2025 16:18:17 +0200
Message-ID: <20250822141816.61599-4-matttbe@kernel.org>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=742; i=matttbe@kernel.org; h=from:subject; bh=YPHXDD9oTZ7YqUQcqBqzUk/QY6MAFjCqpYNcHsVGKJg=; b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDJW1GhWuqd/njRtyt583as/prgY5h7j0tdcGZxwsErz0 mnDtItvOkpZGMS4GGTFFFmk2yLzZz6v4i3x8rOAmcPKBDKEgYtTACYiIsTwv6xjXVTSj+cn4r+y HRG4E1h1bW3YMrkXQZPKTs3Z+/F1Qggjw4xd4RVHnkx0ik239vgtWfXwvHmNugCvgJHv2iPFYhY 1jAA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

Greg recently reported the following patches could not be applied
without conflicts in this tree:

 - f5ce0714623c ("mptcp: disable add_addr retransmission when timeout is 0")
 - 452690be7de2 ("selftests: mptcp: pm: check flush doesn't reset limits")

Conflicts have been resolved, and documented in each patch.

Geliang Tang (1):
  mptcp: disable add_addr retransmission when timeout is 0

Matthieu Baerts (NGI0) (1):
  selftests: mptcp: pm: check flush doesn't reset limits

 Documentation/networking/mptcp-sysctl.rst       |  2 ++
 net/mptcp/pm_netlink.c                          | 13 ++++++++++---
 tools/testing/selftests/net/mptcp/pm_netlink.sh |  1 +
 3 files changed, 13 insertions(+), 3 deletions(-)

-- 
2.50.0

