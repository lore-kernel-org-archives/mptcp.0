Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DB8E3FFD
	for <mptcp@lists.linux.dev>; Wed, 23 Jul 2025 05:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753247791; cv=none; b=TvnMy7V6NkiOqcBDdsVi/oHOUluUSezPUr4clLHX7/jmsWx96miUx7PUL9x3lGGfKO22C8OK3FJOHys7oCsTnyI92TloJKeS5zGqZpeCm0HzxSmNLp9WlzlpiyKuWyiRCFAgGy1do/UvoQ/YpxDRpojScF8YodikkNDiTiBBjqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753247791; c=relaxed/simple;
	bh=vN1oRVs6rLYTvHH93UMykTvDGio10yz09zDOrIj7Lts=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HGRtxaW5DYiJuXcrZl4gTAFV0jVFPFzZReJn+1ebZ5PSMAapA2COOLpaMwA+LI0J73Mhc67KA0ICj+0Y8q0KLO6PWyKjSY18maQ260TQM6oS7NgRPuWWZQ5uhVaJxYCpM26nUyDYLzoKIoiBcVrdd4EXwTzlcPl6zT6BhCjadxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y/Nh0fFA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y/Nh0fFA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65546C4CEE7;
	Wed, 23 Jul 2025 05:16:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753247790;
	bh=vN1oRVs6rLYTvHH93UMykTvDGio10yz09zDOrIj7Lts=;
	h=From:To:Cc:Subject:Date:From;
	b=Y/Nh0fFARhlyFFb+kB53pcUeOnpPZcLRBsPdehe+LW0BYLCB0+hZeraAs7GRQJ1t8
	 CionD5lI/jVgzh9CiyR4Mk3PJUyaDj8VN2xKMc3Gmbl3Ufr16rtr8XoVzvPxtvAaUB
	 VrxJNxY55qABU+XI/i+hxZmmQo4TMlxNP2zZXszOQTHqkTVML3udkYZny1V52NPcdF
	 TEsadz7+Zw/x1P5e6MEbu3OCUMg/fEtIXKPaUgFNGD9E7dxNdzFPL2u341E+8CBNEn
	 a+QHK/ATZktJZIetsnCPiVJv+y6jccEKxWOZ0HC66AJAFkdGk82pdwkfJdIbnq0Ri1
	 iv4ilLczb52uA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang@kernel.org>
Subject: [PATCH mptcp-next 0/7] Add MPTCP support to Java Networking API
Date: Wed, 23 Jul 2025 13:16:12 +0800
Message-ID: <cover.1753247666.git.geliang@kernel.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Multipath TCP (MPTCP) protocol (v1 / RFC 8684) has been added in
the upstream Linux kernel since v5.6.

This patch series introduces comprehensive Multipath TCP (MPTCP) support
to the Java Networking API, enabling applications to leverage MPTCP's
capabilities for improved reliability and throughput.

The implementation provides:
1. Core infrastructure for MPTCP socket creation (Patch 1)
2. Server and client socket creation APIs (Patches 2-3)
3. Integration with NIO socket implementation (Patch 4)
4. High-level Socket and ServerSocket support (Patches 5-6)
5. Comprehensive test cases (Patch 7)

Key features:
- Backward compatible API extensions
- Platform-independent implementation
- Explicit MPTCP enablement through new constructors
- Full integration with existing socket functionality
- Test coverage for basic MPTCP operations

The changes maintain all existing functionality while adding MPTCP
capabilities. When MPTCP is not enabled or not supported by the system, the
implementation gracefully falls back to regular TCP behavior.

This work enables Java applications to benefit from MPTCP's capabilities:
- Seamless handover between network interfaces
- Aggregated bandwidth from multiple paths
- Improved resilience to network failures

The implementation has been tested on Linux systems with MPTCP kernel
support enabled.

https://github.com/openjdk/jdk

Geliang Tang (7):
  Add MPTCP support for socket creation
  Add MPTCP server socket creation support
  Add MPTCP client socket creation support
  Add MPTCP support to NioSocketImpl
  Add MPTCP support to ServerSocket class
  Add MPTCP support to Socket class
  Add test cases for MPTCP socket functionality

 .../share/classes/java/net/ServerSocket.java  | 66 ++++++++++++++
 .../share/classes/java/net/Socket.java        | 88 +++++++++++++++++++
 .../share/classes/java/net/SocketImpl.java    |  8 ++
 .../share/classes/sun/nio/ch/Net.java         | 26 +++++-
 .../classes/sun/nio/ch/NioSocketImpl.java     | 19 +++-
 src/java.base/unix/native/libnio/ch/Net.c     |  5 +-
 src/java.base/windows/native/libnio/ch/Net.c  |  2 +-
 .../java/net/ServerSocket/MPTCPServer.java    | 58 ++++++++++++
 test/jdk/java/net/Socket/MPTCPClient.java     | 62 +++++++++++++
 9 files changed, 326 insertions(+), 8 deletions(-)
 create mode 100644 test/jdk/java/net/ServerSocket/MPTCPServer.java
 create mode 100644 test/jdk/java/net/Socket/MPTCPClient.java

-- 
2.48.1

