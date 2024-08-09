Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD32717A5AC
	for <mptcp@lists.linux.dev>; Fri,  9 Aug 2024 11:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723204416; cv=none; b=a3mpF3DMXVNCKZGcrUGtFD+XBSw4xJGOae/pNzkTTSfUAnVxDkjhytLQ8Y1J3bvaJ9AHs+EcdN++CnOu+xUdeuYiARk468YdEkvU5DAXHr7KTxh07+Z1Uc649ZlWbh6YpGCGW5SvG2s+yv03ETa8b+pXiXushGxkhqDbOYLHIZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723204416; c=relaxed/simple;
	bh=C7htEExe9SemQg6zyjEhE1Y9FyhAannjnz9rm7hp6/c=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=LFJp6YfDwYj3kSW8ePRO/MeBlAbckxt44KZqh/+0jJu/bo9e5ABHNEALlzJg2vwZk/U/O9fx2kjRxFH20VvqKFeazYJ6qFWa/264Siog31fuSKhpfto2f2X7pdo9kFDwDVEqVKaoBuIj47ETVIX1BLpiDaPe5VV1IJr6nbCZqI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NEhZqGc3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NEhZqGc3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5C05C32782;
	Fri,  9 Aug 2024 11:53:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723204416;
	bh=C7htEExe9SemQg6zyjEhE1Y9FyhAannjnz9rm7hp6/c=;
	h=From:Subject:Date:To:Cc:From;
	b=NEhZqGc3vPgGgGjRth07NRnWmB88vESZI6RJPOx/yo2IjPOHgDTlts4/EHqBqCvqW
	 iCiFdOym6QagK38CSqh/edul0lzd+wqbqXM8dcGLBGG3NZUD1Kd4iJyOFTvZFL7mTW
	 KIP88BcGlcSgbpi2/asH0/yeXIhlpEnGoXq28bkANJ02uLtSThWXpX4J8a1YwB7BJA
	 OgE2PO+DF2N9g6ieFRfPulB/YXMEiA504W8AYfSbtfZln/c7YpQ6fFUX70SforoPfd
	 ajya3dzRc4tw8hiIhLlGO+L7Ct/o+dSzzzYDfZ6480zrQZo4cZLB5lwID4bgtNC6Ml
	 bTuY7pcwPMyUg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH mptcp-next v4 0/8] mptcp: MIB counters for sent MP_JOIN
Date: Fri, 09 Aug 2024 13:51:18 +0200
Message-Id: <20240809-mptcp-join-tx-mib-v4-0-98b0b0e098c5@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALYCtmYC/23OQQ6CMBAF0KuQrq0pQwXqynsYF6UMUJVCWtJgC
 He3qSZqZPkzf97MQhxajY4ck4VY9NrpwYTAdwlRnTQtUl2HTIABZwVw2o+TGul10IZOM+11RUu
 OkKLkFWQ5CXujxUbP0TyTV93gPJFLmHXaTYN9xHM+jY23nG/IPqWMFg2kXFSS1ao53dAavO8H2
 0bOwzchtggIRCkVFqypQ0n+EdmHKNnmF1kgVFYdeA1MCBQ/xLquT5ltH0tFAQAA
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2707; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=C7htEExe9SemQg6zyjEhE1Y9FyhAannjnz9rm7hp6/c=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmtgM/u1bD/Zit66ZtsgUT3xv3H9dJNxloHhMAq
 8cNY/cic1CJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZrYDPwAKCRD2t4JPQmmg
 czihD/9sVQDt+Z9TGLIC0M5qJvmMFONeUEW9P5fhdIPQ1EkmuVl6x8VBvVmXsiErWyjg6u0vChp
 ZWYxHYshEbSyt/TeEn1nbBkRxGHVtTB/AInG0HTrqDKX1IEZ/B2/MAjPJfw9vcXKfADZ7KSX65K
 rdKwIo/cwLD8SpCKyRTvfjnwtxNjLuAa2nwi1kGq5Xu+Le7b9M8iu5S8qW/JOHnhRCNtOsjpXcj
 8e+gnSb6sceK6iblJF01lj0tc3zoyW5i035ElRJ2J/2zUJhYy59tGXn6h9KZkoBQaeAyg43FII/
 j7OU7Yysag6Yw3O4LVn8kQfjsOE6Hsf+deg8B05StBfKQQuj6+TKcZnz7dIbk3gQlJx6r/oGVot
 8IqSYmN6ElXygv8Udc+aONLRaZJ8zbLdTD9476YH3dZ4du9pysbeBLeHPvCkHOeq4NBjqMZD9d7
 LhlQTbr2j9qZHKeFnuS2P8GCTvXTS0gRg5x4WHPFzOQA2rYBSewliN/T9IWMPv4U2ZhVKGgMkLq
 1Urces36yZOpojOB1cZTrIptZnEUU30VWHPIqyxnHFTGntoWi0YDT90HgXCB80wC2xI3LSDp3sF
 c8ERPkBfmTiKyXno1wt+fkypV8tf/3ZCBpQvJbESbD+2YPD6W4Us/xN3z5e8ztsdEldRtptgkmX
 sVyFqezRX48XGyw==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Recently, a few issues have been discovered around the creation of
additional subflows. Without these counters, it was difficult to point
out the reason why some subflows were not created as expected.

In patch 2, all error paths from __mptcp_subflow_connect() are covered,
except the one related to the 'fully established mode', because it
should only happen with the userspace PM, which will propagate the error
in this  case (ENOTCONN).

These new counters are also verified in the MPTCP Join selftest in patch
5.

While at it, a few other patches are improving the MPJoin selftests:

 - Patch 1: a fix when using an old kernel
 - Patch 3: reduce the number of positional parameters
 - Patch 4: only one line for the 'join' checks, instead of 3
 - Patch 6: more explicit check names, instead of sometimes too cryptic
            ones: rtx, ptx, ftx, ctx, fclzrx, sum
 - Patch 7: specify client/server instead of 'invert' for some checks
            not suggesting one direction
 - Patch 8: mute errors of mptcp_connect when ran in the background

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Changes in v4:
- Applied Geliang's comments, see patches 2, 4, 5, 6
- Link to v3: https://lore.kernel.org/r/20240806-mptcp-join-tx-mib-v3-0-c3b54d2099e9@kernel.org

Changes in v3:
- Patch 2: remove fully estab error
- Patch 5: force bind error + always validate join tx
- New patches: 1, 3, 4, 6, 7, 8.
- Link to v2: https://lore.kernel.org/r/20240729-mptcp-join-tx-mib-v2-0-8ace70fd407a@kernel.org

Changes in v2:
- Patch 1/2: Add "ERR" suffix in variable names. (Geliang)
- Link to v1: https://lore.kernel.org/r/20240726-mptcp-join-tx-mib-v1-0-7f2149ba0dcf@kernel.org

---
Matthieu Baerts (NGI0) (8):
      selftests: mptcp: join: no extra msg if no counter
      mptcp: MIB counters for sent MP_JOIN
      selftests: mptcp: join: reduce join_nr params
      selftests: mptcp: join: one line for join check
      selftests: mptcp: join: validate MPJ SYN TX MIB counters
      selftests: mptcp: join: more explicit check name
      selftests: mptcp: join: specify host being checked
      selftests: mptcp: join: mute errors when ran in the background

 net/mptcp/mib.c                                 |   4 +
 net/mptcp/mib.h                                 |   4 +
 net/mptcp/subflow.c                             |  21 +-
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 319 +++++++++++++++---------
 4 files changed, 234 insertions(+), 114 deletions(-)
---
base-commit: e4105976662ef3faa6520c2c5da3d40505430761
change-id: 20240724-mptcp-join-tx-mib-84e21ea4b236

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>

