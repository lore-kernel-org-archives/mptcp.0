Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8867D143737
	for <mptcp@lists.linux.dev>; Mon, 29 Jul 2024 10:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722248332; cv=none; b=aZ5FIBzyXrlG29b7PCVAl6Rp4Stl5riv5TQYg5TZzYljwrLpXkZzZuWUQFCHJb872zuzoiLMFf8XQJ0PJvNemXKoHG8aRnjVtdYM7foxu/3DiqT0VQiv4M03GARBCznjmAfo0SwUAa8Zn9YzUNjAdumg3fWULrCtM+JUbI6yVbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722248332; c=relaxed/simple;
	bh=IaXpo0/CsoLSqq0FJJHItM1lyh1OGUeg5NZc7OirvWo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=HPjxMOFGuBwo2VbZVqDGKkTpe5aUA0K4FZjRe7AwB9DCbc/wlsqmTe4MJ2S1DJHuaLhLEkwgbDRuscIY3GdEDR16TE6KrKcl1C9W10t2dJ3uEYG6IX2Xaw8vnowPF2DVQ0ExQ0sXm5RFH8X6cMaQTeKgU9EYBk07WA0aqjMHkq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fOo/KkdW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fOo/KkdW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAF59C32786;
	Mon, 29 Jul 2024 10:18:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722248332;
	bh=IaXpo0/CsoLSqq0FJJHItM1lyh1OGUeg5NZc7OirvWo=;
	h=From:Subject:Date:To:Cc:From;
	b=fOo/KkdW9ObB4lj/hAeJNo40G1w0AOHBsbyxfNUP1C1yLbsyfPLbHVGoqL6MA/Odx
	 zfhIdhaFkgqFutzHscvKAGCPACCrdd6uJG5qDE6jJjar9GN0NOs1jblhwJgtLMktMz
	 joD1nLJZJ+4nuA/XJk7wq5KaSnBc3jPJrGWPn6kwcNPGhpn0IPCvGfsl3OsXAH1s3D
	 wxTXUalIqIiVsHcvXZS52vkH52USq7uU/Pb3lnNmUpvWabMoWJKa8DPQuU7F0cTFoi
	 bZfIEPoemUSnZZas0P1Um+i93UL0q1FA545uU8Z+4FGhNgQcxhHfm2FMqksEYwSSeW
	 nYPBL1iAfoM/Q==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH mptcp-next v2 0/2] mptcp: MIB counters for sent MP_JOIN
Date: Mon, 29 Jul 2024 12:18:42 +0200
Message-Id: <20240729-mptcp-join-tx-mib-v2-0-8ace70fd407a@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIJsp2YC/22NzQ6CMBCEX4Xs2TXt2oB68j0MB34WWJWWtA3BE
 N7dBj16nMw336wQ2AsHuGYreJ4liLMp0CGDZqhszyhtykCKjCrI4DjFZsKHE4txwVFqPBsmzZW
 p6ZRD2k2eO1l25x2+uOUlQpm6QUJ0/r3fzXonfub8j3nWqLDoSJtLXam26W5P9pZfR+d7KLdt+
 wAsQzuivwAAAA==
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1215; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=IaXpo0/CsoLSqq0FJJHItM1lyh1OGUeg5NZc7OirvWo=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmp2yLAFBwrxwZw7lge2CWnkvFnIDJyM/phhkac
 BfU1K8xpo2JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZqdsiwAKCRD2t4JPQmmg
 c6U7D/wIqomltzYKgMoK+FHZ0ZFglkRsJhDURyrqgzMszft2oBPMquJUMl5ZfBZyke6j5Sy4LDd
 U64vmfdFdMeLyPTM+x6ozk0MgLlOLaPvhRPLNXHb2ksmkcNSANBGS+8G7QBYi7A7T9zfgZiIQpn
 rq5eav0NpmscjI1h3QJNnIMzMfi8xst8rImG1DqgLw95w5FLSh7EDqwrU3m9+C8WDPMobq8NUxs
 dTTo+yteTEI/f/H613H6ATq4pfR14Nilg1oM65VhrXpe0uvL1CGD6vMACg/9G2GMIr1pi5Yi0MM
 DZq14HGZxq9BLObFY/MF14f6O0n/OBIy0MvVQJA9PN72/e59nSsJhccgBPdGz9L9zHrs3ZMEf5P
 TP3rt8kHAApRMQi1y1C3hsJq3mmWuS1jF5kWOYKzJIx9y8exWBtKQmMMX46E9qhfAYungxr92i6
 1aAShTbG/fq44q/6Cx5qlmws8WjiZcUa9Rx1Prh6eFNK0j0sD7mZpxvvJTsYHjm37r3r4ORW6BT
 XOQ6PBHP+XEXBLovmSR/wHTdcWHlFBk53O7mR76NtXyNdclTbCKrcTw91XU6f3f3GlUuuXk6FPb
 +LMkTPPwsQ+nF6AlBf9J6jyiE/Ai4r3toxEQc6u5+muW2yKbAXbMiT/sghbevSTA1Y3z/+9I3aJ
 5CKV1gcPxmYqG0A==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Recently, a few issues have been discovered around the creation of
additional subflows. Without these counters, it was difficult to point
out the reason why some subflows were not created as expected.

All error paths from __mptcp_subflow_connect() are covered.

These new counters are also verified in the MPTCP Join selftest.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Changes in v2:
- Patch 1/2: Add "ERR" suffix in variable names. (Geliang)
- Link to v1: https://lore.kernel.org/r/20240726-mptcp-join-tx-mib-v1-0-7f2149ba0dcf@kernel.org

---
Matthieu Baerts (NGI0) (2):
      mptcp: MIB counters for sent MP_JOIN
      selftests: mptcp: join: validate MPJ SYN TX MIB counters

 net/mptcp/mib.c                                 |  5 ++
 net/mptcp/mib.h                                 |  5 ++
 net/mptcp/subflow.c                             | 24 ++++++++--
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 63 +++++++++++++++++++++++++
 4 files changed, 93 insertions(+), 4 deletions(-)
---
base-commit: a9a9b3b154d187864b73eb0e86a0ff737d79a10a
change-id: 20240724-mptcp-join-tx-mib-84e21ea4b236

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>

