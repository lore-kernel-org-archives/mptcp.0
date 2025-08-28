Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EBE430CD89
	for <mptcp@lists.linux.dev>; Thu, 28 Aug 2025 08:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756370845; cv=none; b=BgUWWoEE4/Ao91iSKyZ+UfL/f+hYh/oI0WWp3Jqh1KB0BDn/rw5U05mM5zD2bmJJTgWypbuzl+W10Ci/E0iKwh1rAZWyQHRvEpr4JRMYfQCNxdJqKzZTO6RSSv+I/BcR+FbpRa8kObKw3A0B0Mx3J2e6ilNpZuxFhxjKZfqVob0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756370845; c=relaxed/simple;
	bh=1Rnn6y24R0NW0qNJWi5/cEx9rmefxU50+ZxTeTmLyhA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GnICynjU9jeFsQFBQ/iAJN2dNc8EaB0G8umSiTc6MNQbNWV0KcszmgQSmv/4IKXmo0AWR/Kq885GIBNTii+BLEY/v+zzrOZ7U88C8FF3uJCwKz9STq8T6spkXmXYbHeeqxf85/lQIsfokjXXpNx4NS5TSmQiGyGQGl0RMM+p+fU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Iot58g8q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Iot58g8q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C60FC4CEEB;
	Thu, 28 Aug 2025 08:47:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756370844;
	bh=1Rnn6y24R0NW0qNJWi5/cEx9rmefxU50+ZxTeTmLyhA=;
	h=From:To:Cc:Subject:Date:From;
	b=Iot58g8qZ21Vl016DUwbBrPaj1DvXet/Z3XJasTHCbrLv4OoZVhRgcnY+6zGWHITM
	 i0NiX7W5jJvmugEgwHywA43UcKFCe5v+rxJzDOd7d5BRc3MmbYvk+Ep/s7cfEuLFBc
	 gvhxyyDz7QkmvqC6uJrQW3Yu+cfpeDHFroqOYMRskDvPf8odrkmCsuQ5C+2NtyMDWO
	 sOFeUPXwWZntGw6NGW0V/Kq1Mvfr1uBXZbcD9hjmcifYCCNvNDfyUAAAHHtFyq7/s9
	 NMbSFmpdrx3rhpssmh0L02CQKMMC1sInWWTCXykiXHU0absyzaxMqoD8/MuA/46iCD
	 qdQvTaFvDtKcQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 0/3] Add MPTCP support to Java Networking API
Date: Thu, 28 Aug 2025 16:47:12 +0800
Message-ID: <cover.1756369940.git.tanggeliang@kylinos.cn>
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
 - drop redundant helpers as Matt suggested.
 - squash into fewer patches.
 - use "JNI_TRUE" and "(void)mptcp" in Java_sun_nio_ch_Net_socket0 as
   Xiang Gao suggested.

The Multipath TCP (MPTCP) protocol (v1 / RFC 8684) has been added in
the upstream Linux kernel since v5.6. See https://mptcp.dev.

This patch series introduces comprehensive Multipath TCP (MPTCP)
support to the Java Networking API, enabling applications to leverage
MPTCP's capabilities for improved reliability and throughput.

Geliang Tang (3):
  Add native MPTCP socket creation support
  Add MPTCP support to Java Socket/ServerSocket APIs
  Add test cases for MPTCP socket functionality

 .../share/classes/java/net/ServerSocket.java  | 52 +++++++++++++--
 .../share/classes/java/net/Socket.java        | 65 +++++++++++++++++--
 .../share/classes/java/net/SocketImpl.java    |  4 +-
 .../share/classes/sun/nio/ch/Net.java         | 19 ++++--
 .../classes/sun/nio/ch/NioSocketImpl.java     | 11 +++-
 src/java.base/unix/native/libnio/ch/Net.c     | 14 +++-
 src/java.base/windows/native/libnio/ch/Net.c  |  4 +-
 .../java/net/ServerSocket/MPTCPServer.java    | 58 +++++++++++++++++
 test/jdk/java/net/Socket/MPTCPClient.java     | 62 ++++++++++++++++++
 9 files changed, 264 insertions(+), 25 deletions(-)
 create mode 100644 test/jdk/java/net/ServerSocket/MPTCPServer.java
 create mode 100644 test/jdk/java/net/Socket/MPTCPClient.java

-- 
2.48.1

