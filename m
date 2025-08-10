Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 090F638FA3
	for <mptcp@lists.linux.dev>; Sun, 10 Aug 2025 15:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754838193; cv=none; b=uV42urweqqy/xic6Ul4PABKQJ7+PmfDHcBc5f7v3DUO4XtZYUCLIUi8fFJHaQQ0HEfKNI1JaiThCddEyDc/GUksw0hxTtgXnmSQeDJWiGqf268HTnfVlIfinFjWOdRogPlFk3PL8i9rFVYVwvLYaJ2h9zKYlEoROO5wup3qbXsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754838193; c=relaxed/simple;
	bh=ll5nGl82Vjm1JOI4pVS4mRuOQGlnRTRbJrrhJEqoC+8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=r7M9PQ4zObgLLfKNUoYgpqRJU62V1wBjrcc4LmmRW/Jqm3oGtSo96ZaMv0xNAbcA9qE4g+QJ9I0Q37wLhTbXGs69e6428g3haGL+yANQ9onzpFwUMQWxcITLVcUO4/QX5nHFE6x/FIE+nbrQU9OFhWnZWgeX2j0Tx51CcJLomjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BVmfhcI6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BVmfhcI6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 823BCC4CEEB;
	Sun, 10 Aug 2025 15:03:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754838192;
	bh=ll5nGl82Vjm1JOI4pVS4mRuOQGlnRTRbJrrhJEqoC+8=;
	h=From:To:Cc:Subject:Date:From;
	b=BVmfhcI64zYm5er9Gv32X7PSf+BFfXykQfuYCgcBikPDBWpFmG1g3TJTlemfv/N5y
	 v8QPae7cB43gyfbRoKjanjPN8M2Kb7LebEevcHPw9VY1DI4eXFqSiDHCw8NOBPXmJ0
	 ha7skUZ6jLlVju914eoimkCfdFUiWKGvpYC9ld6Udj3xOhTZG/TfnmblonVKWRDumU
	 1NQR1lWzFterkpb409Nu2Ng9OwXYbd3LCMfX3+f5t9k5ITOUl+i7XUPkS4iKuyFxBy
	 ZvSwWU8+aJcXVU3ZC1b+KEgfiur3Jm2GJesFwfgJ/1n4zwPpV4WUf5dztOItzzjXny
	 dJjwPh5QqtI4A==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v5 0/8] mptcp: TCP_MD5SIG support
Date: Sun, 10 Aug 2025 23:02:19 +0800
Message-ID: <cover.1754837808.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

v5:
 - new selftests for MD5.

Depends on: selftests: consolidate TCP_INQ testing into sockopt, v2
Based-on: <cover.1754664106.git.tanggeliang@kylinos.cn>

v4:
 - drop CONFIG_TCP_MD5SIG check.
 - drop sk_state check.
 - use WARN_ON_ONCE for __mptcp_try_fallback().

v3:
 - limit the use of these options for listened and closed state.
 - check the return value of __mptcp_try_fallback().

v2:
 - trigger fallback to TCP.
 - check CONFIG_TCP_MD5SIG.
 - update MD5 comment.
 - drop selftests, packetdrill tests will be added later.

This series introduces support for TCP_MD5SIG socket options in MPTCP along
with code improvements:

Patch 1: Refactors TCP_MAXSEG getsockopt handling to improve code
consistency
Patch 2: Adds setsockopt support for TCP_MD5SIG/TCP_MD5SIG_EXT (first
subflow only)

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/575

Geliang Tang (8):
  mptcp: handle TCP_MAXSEG getsockopt in common case
  mptcp: setsockopt support for TCP_MD5SIG
  selftests: mptcp: sockopt: set REUSEADDR opt helper
  selftests: mptcp: sockopt: add md5 argument
  selftests: mptcp: sockopt: implement TCP_MD5SIG support
  selftests: mptcp: sockopt: extend MD5 support for TCP_MD5SIG_EXT
  selftests: mptcp: sockopt: handle MD5 in connection processing
  selftests: mptcp: sockopt: add TCP_MD5SIG test cases

 net/mptcp/sockopt.c                           | 18 ++--
 net/mptcp/subflow.c                           |  3 +
 tools/testing/selftests/net/mptcp/config      |  3 +
 .../selftests/net/mptcp/mptcp_sockopt.c       | 87 +++++++++++++++++--
 .../selftests/net/mptcp/mptcp_sockopt.sh      | 49 +++++++++++
 5 files changed, 147 insertions(+), 13 deletions(-)

-- 
2.48.1

