Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7968383BF
	for <mptcp@lists.linux.dev>; Fri, 26 Jul 2024 17:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722016107; cv=none; b=lYixy17ktJwOE5qoXb26EL8GvZSXNaixO9kDo09fzh/T7eAeA4lFJmqz/GxReQ3cIDbS7ZneyI6K1vZafrmpVihG/DylLvCMkDVW4Moa2z8ve6+vxjJMt/VB3e6GwMZ0U0iBbxqajyPSbUMv9Peru5QoXjxrs83DN8W+fyt8Wec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722016107; c=relaxed/simple;
	bh=fvzMcAPJPolDh9UDPf+fR9z5dd1gDQh8gV7xLLIHTsU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=KE1hm+hTtt/Lv72bpqBcOLZvO53UFrFsXRJVr8huhaYdtGRm0NA3PyvEp84k/8o2EdlfzJXRYMBFaf7Kf2ibO+nvi8nv5cF1SeVG4k1Ok9ZEhpdkFxmeit1Twmcc4BC57uyLuy/e0KOAXSCffjYz2sgSLWQKla9ZnGx72mjDl4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZrRN9nTZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZrRN9nTZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B375DC4AF09;
	Fri, 26 Jul 2024 17:48:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722016107;
	bh=fvzMcAPJPolDh9UDPf+fR9z5dd1gDQh8gV7xLLIHTsU=;
	h=From:Subject:Date:To:Cc:From;
	b=ZrRN9nTZv82Xjvf0YYAiWeitxXAn3GYc1wCYtPBSsh0HTgg469jz1w/acnJobcJtf
	 nboiCJIGbloFp6h1M7d+QzNLq63k/+D7fmgYgrK5DS+mNxPwSTWpfb3/loi9asOn3B
	 FCemF2JurUsxgZ61uyg9tGBmIpFZ77mbG1dtdEbLTCZlGmDX921VzufM7feG9Pf6FS
	 Z/kM+M6xs3lYi+ys3Gd7Q/X0xTjKTOfSuUwYWu2XjdlrskPOrpeZy5f9T/SLIVPZM9
	 yjBEFNbv1WaaEtkm8raiJjSKZnHw0IDU9Vdb2U1RZlwX27bIGy8YBi9PBc3fGAg6ZM
	 m/UdMYi+hDE0A==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH mptcp-next 0/2] mptcp: MIB counters for sent MP_JOIN
Date: Fri, 26 Jul 2024 19:48:20 +0200
Message-Id: <20240726-mptcp-join-tx-mib-v1-0-7f2149ba0dcf@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGTho2YC/yWM0QpAQBAAf0X7bIt1Ib8iD4fFKue6u3Ql/+7ic
 WpmbvDshD102Q2OL/FymgRlnsG0abMyypwYqCBVNKTwsGGyuJ9iMEQ8ZMRWMZWs1UhVDamzjhe
 J37OHXzccAwzP8wICm0dnbwAAAA==
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1035; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=fvzMcAPJPolDh9UDPf+fR9z5dd1gDQh8gV7xLLIHTsU=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmo+FqI3xVDTA+w934VIyA4l2fFrDkvVEO8rdCD
 3/IvnElW5KJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZqPhagAKCRD2t4JPQmmg
 c652EACl90JeMMVTK1ZQOGNXPpM11dsuhnYgXCUpQ1ybdVt4t7xdqsuARSeQ5GMlkfd3Co4mHev
 /70fKy0jIraOm01HDRymtThycIPGyDnDjIdXK85Rd83JA4Lf5v9jYwPVDx0TRMvCevLNVsev48k
 jbyWtfroBU1VyetWCBZ4BnN39umunfYfwK2aNmevf+4E7gIC/yPjDlf6Pw9pnfwGAsegJj9f8b1
 zS2h3+LPHuPb0WG71xU6azR3yx9Npw8DKEL8rje8kQSfyCwLRHiHxNm63ysguKWazKOhIhYhYwG
 aT+FQdPYkoRqPdDwLMiD3aI8fG4olVY3uco0Ffp5d2+RkT1yGpEfqsxmTOnfZBhRWxjv3oEhJtw
 hlsrEyBauOnkfvRJiZcKxyPfxbijrFO6MZmpKpwZi5eRdpAxmfQOFVOrPsWms6fg07vbo1iOO4e
 4WWFu6Y7Y44lE5In7hg++aN4X+EK/P1FXzgNOCtBl+ByPX7wG6cm2g1xxK/Yt0P6T0GtbgQrTqh
 zCIoWx6arDDL3Zl8BnxI+MF9F4CyS2E8pw0X/NtfErRvp248m+ckjo0h/tleTEQcYU1dayyCy+v
 cqD3OfRgKSYy5WLYrjjurSv1dtOVFdhHcZHPIyzkCM7HiP8K+rNRPrGZw9vpv6lrIxxUDtYuefm
 dukr/7H/EXXPb6g==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Recently, a few issues have been discovered around the creation of
additional subflows. Without these counters, it was difficult to point
out the reason why some subflows were not created as expected.

All error paths from __mptcp_subflow_connect() are covered.

These new counters are also verified in the MPTCP Join selftest.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
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

