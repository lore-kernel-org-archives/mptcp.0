Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AAF453398
	for <mptcp@lists.linux.dev>; Fri,  9 Feb 2024 17:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707499748; cv=none; b=p2Vgj3Wj0s8ve9lE0DG+JD1NM1yMZ2uQWY08HEX+T0/YDN5BwvIg5XvSgpbh6SsD5qfXANr7A6nXCAznU7A9Gf0P2ChieFwhNJY8b4ZUgqxOqvj9KWnoBCaRQ5KI+VDm2SjAYZbHLa+x776vPAQyyQmSjt/MhFXgdYzBKxbqKw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707499748; c=relaxed/simple;
	bh=fZxyQrZG61c3w8Su/EpNiaoWjEohKIweJwMC1X2aZII=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=YzKaJuD6auFOg+ka1G5zMEETejFxIsnRF3SrykPp4y5ryFHkJGVQbK1s/nOPqoaJnjf324b1+q9aIm780qbJSi8ZK/RUBp5LL9kca7N6q+89zL9lgXUUOn7HGQoUmwRHToIJq+gUwYqG9aedblCPIWt31p+/yy6gMgknFquuFDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IAS86gEf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IAS86gEf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81F48C433C7;
	Fri,  9 Feb 2024 17:29:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707499748;
	bh=fZxyQrZG61c3w8Su/EpNiaoWjEohKIweJwMC1X2aZII=;
	h=From:Subject:Date:To:Cc:From;
	b=IAS86gEfOkQk0B2zggueCwdCWjomxcScycrURB00LijkdVYIpLQ72JM8fN8zPmKfh
	 iOhd1B37AVcPYgbyPljiJtaTsuafxMLJTSbls6wLislFbS6zmJZlsJmDIsXU2kMFWq
	 KEVzlNZqaRwNEOyvOkXWWlWIDAfUedTVQZvEY7ctmH+1eu3JLLWxUBwEfsCqaaqoao
	 UqeFHk9TLh2cPgzxFfQ8/9d575fP4n1f8Anl9f/UrbU1QEfE3sk/lTckFifrupRirN
	 BzxdG0AHsQPTsB/0vpKAYcCmSbw5UHw1AE6j+oaqFlu5QxMZY0TxBMJmNgMDUrtRoZ
	 1BMH8BAX9nSxA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH mptcp-net 0/5] selftests: mptcp: unique subtest names
Date: Fri, 09 Feb 2024 18:28:38 +0100
Message-Id: <20240209-selftests-mptcp-uniq-title-v1-0-e4fb3a3b5f66@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMZgxmUC/yXMQQrCMBBG4auUWTuQDlWpVxEXkv7RgRpjZhSh9
 O4Nuvzg8RYyVIXRqVuo4qOmz9zQ7zqK92u+gXVqJgkyBAkjG+bkMDd+FI+F31lf7OozWCBTCrE
 /HsY9tUGpSPr9zc/0rzOcLuu6AWFRw5d3AAAA
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1511; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=fZxyQrZG61c3w8Su/EpNiaoWjEohKIweJwMC1X2aZII=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBlxmDi1nKj1CUaCGQoaiEI117zbIdCMgSi8G4ZT
 KK2jo1Zbd6JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZcZg4gAKCRD2t4JPQmmg
 c9PgD/9mvRyupk6POkrca1UrlbUtTz3KV/v2yf9/2BYPL3U2a1D3jxFVWTLBg6YPq+kZcR+JME7
 az76nJ0cOV14YAcwX9ICxw5pXBNtXk7iurWY1bPRZBWOS2nM1TbBlCxeMOTDcFaza+lEuHIU6hw
 hrFdd+LUK9Fr6cUMJnWcuFItCig8V6kXTO0PyV0jPOjKWONgNlO6rl//O7ys1fRXHIsN8dnV2V5
 J8sZaSckTAgdVPZs6/yE0bBuKu+mvuJmG6BKtn/hlbm0caXpXy2sZgGpcC6YrRZRfCykDSftXkm
 /U9RLGhlR62EciQh7bzdyjGM5uNSL+htB2zIoHfFDuZ5kpr77huKauzTtGHmuQgNnYqfwOiQ0bN
 xjbpnL21p9+nsi8al4/i+EOE+lu1yiCX86eM+OFtZ9j2cA8auQZolT9NyYSb0FEp0stztLHzVbD
 so93TwZeZsah3zFEQtDxPDZulULVKHVWMVOQFkdLJAWMuydbxFfDa1rBt0ulxuKT4id6x+Dcday
 87eLogowlyimGn6Mt+nVYjW01x8MpO6sRjYErfY5FYS/dCie+emIZsRcCgifNXupfRq2wk8wJwT
 ZRbjM4eewA4ohfcNF71GXigYkBD/wxZCbeOnJ79NZxVxZcDUtVxFQ5uVsXtb4o8b8H/few9TgoZ
 MPV8Uhdf2I74AOA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

It is important to have a unique (sub)test name in TAP, because some CI
environments drop tests with duplicated name.

When working on adding subtests support in Netdev's NIPA CI, I found out
some subtests had the same name. The name is used as a key, it should
then be unique, otherwise we don't track duplicated tests.

The fixes have been split in different patches, because it fixes
different commits. But the idea is always the same: make sure subtest
names are unique.

The last patch is not for -net, that's a new feature to make sure we
don't add duplicated names later.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Matthieu Baerts (NGI0) (5):
      selftests: mptcp: simult flows: fix some subtest names
      selftests: mptcp: userspace_pm: unique subtest names
      selftests: mptcp: diag: unique 'in use' subtest names
      selftests: mptcp: diag: unique 'cestab' subtest names
      selftests: mptcp: lib: catch duplicated subtest entries

 tools/testing/selftests/net/mptcp/diag.sh         | 37 ++++++++++++++---------
 tools/testing/selftests/net/mptcp/mptcp_lib.sh    | 21 +++++++++++++
 tools/testing/selftests/net/mptcp/simult_flows.sh |  3 +-
 tools/testing/selftests/net/mptcp/userspace_pm.sh |  4 +--
 4 files changed, 48 insertions(+), 17 deletions(-)
---
base-commit: 0c8d1475f726a95cddb393e45f0b4d8ec0e15785
change-id: 20240209-selftests-mptcp-uniq-title-2e2df0c17695

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>

