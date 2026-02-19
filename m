Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA91A2F0C7E
	for <mptcp@lists.linux.dev>; Thu, 19 Feb 2026 19:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771527685; cv=none; b=EIm4vLVusOhqVDj/c4ZMQ43wivYAnukO/gKmDBTtpfbHCkguGP0aciwR5XkbZLkQm66RZ7Tw6n/BIE8Kj9AGHBNfS8OLzAosZAtrNf4jULYmvccOR3+6ZFjDMtKdLMFSj6xBkd0axeYfMuCTkRUX9mXazKwZvl69kxjjJ+LiUFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771527685; c=relaxed/simple;
	bh=uJKXa3DhEpbpcHmqAm+83ZBeGOFdrl7/kFdLTct8eYE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=K/uE9ZzO1F9BsC8dMuMcOkc6eHmVICfOL/mmIyJHzzObcekTh2lUzBag3jdkQ83jdQWpSuKenDPOOIrFFsiLbu1CPNlbLn97dF1XXpKki7kwktPWruLr8zbYDFcMYsM6W2+KACwGVF9rd1n0e+hkYIOaenBazwwV8O/x8v8CIQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fFSWj2J9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fFSWj2J9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE42FC4CEF7;
	Thu, 19 Feb 2026 19:01:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771527684;
	bh=uJKXa3DhEpbpcHmqAm+83ZBeGOFdrl7/kFdLTct8eYE=;
	h=From:Subject:Date:To:Cc:From;
	b=fFSWj2J94IrNrbkL7KYhkuJyOwGUbX6GgtGKk6ghCEeSXBR0f4fhq4xonjje7Hp5z
	 DLIjsGM6EyEb6SCCd8P3LT/iaZqFd/GXJPFGrtZhs0yWOzwlmpzU2LyGaKJVce3Ae5
	 Nwr/56kru1DkS6rjxQiuNcb+Ht1ietsTPq/2zjvhVuCj0Fi+ClSREoAjpDdeIjxscr
	 FexI/Iwz5Plj1ojoVggLasNSUL4Z08Vsn378DnJXmVjsEwyQgz0BQk9aXpP/CJQKR/
	 I5u1X9lXGL3PNZUasz+QfDpzaMgztMZ5OE0cJY6GqTvMMwWTShXFlp42QLI0nOwQ1z
	 o10kcR6PONaXA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH mptcp-net 0/2] mptcp: pm: avoid sending RM_ADDR over the
 same subflow
Date: Thu, 19 Feb 2026 20:01:14 +0100
Message-Id: <20260219-mptcp-issue-612-v1-0-839e20d96fe7@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPtdl2kC/yWMQQqAMAzAviI9W1iHCvMr4kFc1R6cY1URxL879
 BhIcoNyElZoixsSn6KyhQxUFjAuQ5gZxWcGa2xjLDlc4z5GFNWDsSGL3lXG1RORNwy5ioknub5
 jB78ceIf+eV495sTlbAAAAA==
X-Change-ID: 20260219-mptcp-issue-612-d94095f11d0e
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=806; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=uJKXa3DhEpbpcHmqAm+83ZBeGOFdrl7/kFdLTct8eYE=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDKnxzHmWfScm7k2o/7g7sN20pZtJ9rrjx5mO3PmKrOQu
 2czl+HWjlIWBjEuBlkxRRbptsj8mc+reEu8/Cxg5rAygQxh4OIUgIlE7WJkWJ7osFO6Ok1t23KW
 /Wu8dtxh+2zl/8Qr49D1CUzyz2Y3GTAynHZZIfOY23rypwrfvpoZ3x/5Jl31vTq1v+uVyCF+B0t
 LNgA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

This should close the issue 612 reported by Frank Lorenz:

- Patch 1: avoid sending RM_ADDR over the same subflow as the one going
  to be removed.

- Patch 2: validate that in the MPTCP Join selftest.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Matthieu Baerts (NGI0) (2):
      mptcp: pm: avoid sending RM_ADDR over same subflow
      mptcp: pm: avoid sending RM_ADDR over same subflow

 net/mptcp/pm.c                                  | 52 +++++++++++++++++++------
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 36 +++++++++++++++++
 2 files changed, 77 insertions(+), 11 deletions(-)
---
base-commit: 9bf535999bf8e23b5f38fffb1a7ae7ee73115e98
change-id: 20260219-mptcp-issue-612-d94095f11d0e

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>

