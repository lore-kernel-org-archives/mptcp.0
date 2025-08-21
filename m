Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7118E1B3925
	for <mptcp@lists.linux.dev>; Thu, 21 Aug 2025 08:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755766521; cv=none; b=LvywRVXOwvXbxtAxxhHCHWN74ZHWVATQom3+/RJ8p9lt2GalTHIs1V06cyzwsHSij+ry//ZD2zq7zfg1qC1QF9UUz6fGOqu0eXzNHs4xnY6A9VPSfXC1prYUlNJY8pUIHNBK5Xv8I0tmfJtM7j3WJmWt56ZGAhtkTdf5Pe1QCqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755766521; c=relaxed/simple;
	bh=w4wL+ZJNblzrihk0du9/LUFQDruRChcQhka2dD2JN3k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DbGfm0Ak0wJaSltHRqmBVMc6kQtX3509UA+eMzW9gaiGiLDB1YddjLCT/zPnBgoXdW0lRYkZ5PmqtGGSF9D1KrW2hiVeBhXlzZjWoAwy7vAPsXmH3hP2zc+Qnu9R8r4LPJ8yEmey3JjU2cNPBXMfKa/+ahmY2wpNbkk3yBBS8s8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M0pBFDml; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M0pBFDml"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76754C4CEEB;
	Thu, 21 Aug 2025 08:55:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755766521;
	bh=w4wL+ZJNblzrihk0du9/LUFQDruRChcQhka2dD2JN3k=;
	h=From:To:Cc:Subject:Date:From;
	b=M0pBFDmlqipj3iYKOEAm9KAGpROopLRyTgmR2rIoi3GFYPzknCOWCmB//u8RsUZ03
	 Sh2CiJ02vSr9YKjXem/o/6THY8H3iyU17K+LRN9y2wsD3Z9GOIl6nV0SzUVUaQvLNw
	 DGlvAIVHpOnIhPenHX+tMjnLaD+CaOu/2H3YJgGJEmeLscITjw949oxyaQThxHf+Ch
	 tlNoSSOJkK4UgbTj4F99Najbndfk3VGwDQ5RFh99W3sDe0AGioO/E478ngWV08G7ys
	 IjZ/Icj4ZNpiI61cCLK9W+A3iqPr+4yrIZIDKe0j2gsxPnAwGR79DAQ2gNbeqBVMMH
	 FYxpfxEEF25JQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 00/10] selftests: cover more MPTCP socket options
Date: Thu, 21 Aug 2025 16:54:48 +0800
Message-ID: <cover.1755680616.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

v2:
 - IP_FREEBIND/IPV6_FREEBIND are set in do_getsockopt_transparent, fix
   it.
 - Use "for" loops in mptcp_sockopt.sh.
 - Move "add IP_TOS socket option test" out of this set.
 - some cleanups.

This series significantly expands MPTCP socket option test coverage
by adding validation for 10 more socket options:

1. SO_REUSEADDR/SO_REUSEPORT - Test socket reuse capabilities
2. SO_BINDTODEVICE/SO_BINDTOIFINDEX - Validate interface binding
3. IP_TOS - Verify Type of Service handling
4. IP_FREEBIND - Test free address binding
5. IP_TRANSPARENT - Validate transparent proxying
6. IP_BIND_ADDRESS_NO_PORT - Test deferred port binding
7. IP_LOCAL_PORT_RANGE - Check local port range restriction
8. IPV6_V6ONLY - Verify IPv6-only sockets

Each commit systematically adds:
- Setsockopt/getsockopt operations in mptcp_sockopt.c
- Dedicated test cases in mptcp_sockopt.sh
- IPv4 and IPv6 coverage
- Error handling and edge case validation

The new tests verify that MPTCP correctly propagates socket options to
subflows and maintains consistent behavior across address families.

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/525

Geliang Tang (10):
  selftests: mptcp: sockopt: improve test output clarity
  selftests: mptcp: sockopt: add SO_REUSEADDR test helper
  selftests: mptcp: sockopt: add SO_REUSEPORT test
  selftests: mptcp: sockopt: add SO_BINDTODEVICE test
  selftests: mptcp: sockopt: add SO_BINDTOIFINDEX test
  selftests: mptcp: sockopt: add IP_FREEBIND tests
  selftests: mptcp: sockopt: add IP_TRANSPARENT tests
  selftests: mptcp: sockopt: add IP_BIND_ADDRESS_NO_PORT test
  selftests: mptcp: sockopt: add IP_LOCAL_PORT_RANGE test
  selftests: mptcp: sockopt: add IPV6_V6ONLY test

 .../selftests/net/mptcp/mptcp_sockopt.c       | 257 +++++++++++++++++-
 .../selftests/net/mptcp/mptcp_sockopt.sh      |  37 ++-
 2 files changed, 282 insertions(+), 12 deletions(-)

-- 
2.48.1

