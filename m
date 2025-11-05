Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53603245020
	for <mptcp@lists.linux.dev>; Wed,  5 Nov 2025 09:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762334976; cv=none; b=fpchHreCbYkDTuhPt3dts7hE5LzW0AD8umQQ4ZYJFwTak6YuZ6LXRfe3O3isZNF3J3bdcgMO6A43xTfKrkNcFiPB81rI06ur2G0IsxBHgmaHbQbglwW0apPOYxyJYCZYbRGyc2mn/QW5wBhusRRj7CiqKm5v4udJbRehOq3LZ88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762334976; c=relaxed/simple;
	bh=bRtR0gG4V3vr9PqBorCod4xaXduV6qAAV0FVmYqFYe0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gpp3NNEtspeMNSnsxGL1eFEHsgwWsQDUatQv0XNrTKTcX3ydsw1iXkTo5CYgwXlS3OWGToiaCFKhHUD5c407jV5d0Ttf+gXIUEBe+l7+QdJEtnyZdy9HkNwuVUqVzXLV7mzS/a5eFvHQ6v0+++8rNUN0CF/tVallkba54SRNiJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=twPRd6N2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="twPRd6N2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB243C4CEFB;
	Wed,  5 Nov 2025 09:29:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762334975;
	bh=bRtR0gG4V3vr9PqBorCod4xaXduV6qAAV0FVmYqFYe0=;
	h=From:To:Cc:Subject:Date:From;
	b=twPRd6N2ptBzfVne1na14Dje45feLEGfrWGMFlwGuDMBy33bcvMWA/r/dW2LIJaD+
	 Ps/UZVMb9w79R2CFBX9Ce3OVAswBDgOBHJxyW/Q79HolqNtUI05pCW/Mz9MXDW0HKw
	 GFcq17o7qIYERztb1gnPh/ooIkPfVozL250ZPSLrG2HdYzFC7DHUK4kCBi90YxdvYH
	 3pDeDTDKmJPA5T0LnB9Z4iW+4LMg1YTU2i/pHU54CsSmnM38uSxw1040sl2KzoJ/ZN
	 tzf/1xLc0GJNsAbC9MSKw1CJlwczAhTyrlwbnRZ1r12ThqNXG9RBbQyYXIQqd9a2M4
	 uC7v9513IUN+w==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v6 0/7] mptcp: TCP_MD5SIG support
Date: Wed,  5 Nov 2025 17:29:23 +0800
Message-ID: <cover.1762334694.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

v6:
 - update selftests.
 - move "tcp: md5: remove redundant l3flag variable" into this set.

v5:
 - new selftests for MD5.
Link: https://patchwork.kernel.org/project/mptcp/cover/cover.1754837808.git.tanggeliang@kylinos.cn/

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

Geliang Tang (7):
  tcp: md5: remove redundant l3flag variable
  mptcp: handle TCP_MAXSEG getsockopt in common case
  mptcp: setsockopt support for TCP_MD5SIG
  selftests: mptcp: sockopt: add md5 argument
  selftests: mptcp: sockopt: implement TCP_MD5SIG support
  selftests: mptcp: sockopt: skip getsockopt for MD5 tests
  selftests: mptcp: sockopt: add TCP_MD5SIG test cases

 net/ipv4/tcp_ipv4.c                           |  7 +-
 net/ipv6/tcp_ipv6.c                           |  9 +-
 net/mptcp/sockopt.c                           | 18 ++--
 net/mptcp/subflow.c                           |  3 +
 tools/testing/selftests/net/mptcp/config      |  3 +
 .../selftests/net/mptcp/mptcp_sockopt.c       | 86 ++++++++++++++++---
 .../selftests/net/mptcp/mptcp_sockopt.sh      | 51 +++++++++++
 7 files changed, 147 insertions(+), 30 deletions(-)

-- 
2.43.0

