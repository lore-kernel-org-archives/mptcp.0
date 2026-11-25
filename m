Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795591398;
	b=KsVxIwtuhbGxCpT/wWBt4j9XAz35pqCFdBSpLVfysxKdTE1UnQ+dGWFDPzxzGX1/M7zW
	 WKvPybS9P5hbrBEaoonhEyM9LiBVI1Najg37qmud7yX0qFDenHHbj+OwUWtLVHWKKjoHx
	 kKl0CLLeJ2hdC4sM+BL0hI7DZ95swYVVsERBX4vvCQtF2To3z81G33TkwBJRtIPSIkNOa
	 EoiGPXV7leGj6gbYqLs+xm/bGubWwKmzHzNA2YRValLdb9iiuFK1cEMIpNaK28BsY/oWw
	 Y8Y/IXxfUNBDpvBkYnoXki9OVwOPysf87kkB7HhQpAStgpO40/yS6j772ydsN5Wacqg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795591398;
	h=Received:DKIM-Signature:From:To:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=XadJ9vAFI1rCOAKh+P/BuP01VN5XbJrU7xd+YcPsUd8=;
	b=VE/55pNjCJsWao1sjvoAkjaUMIWUXWS6jedoxZY96PDdsUK4QawSC/OrDr/ZQ7lP1LYO
	 g8YwUD95Q21dcrbRrk2JpDebSHh0+O/XiM/hJHbLQBK9o2k6GIeCmR/rH9/bfDOw1C6KJ
	 r/2Sc4Yt0X+KJROzDOByDDH5+JIQyzlc4tz6ekgrvoeQjGgDeGXItaX9EwDFszJ+r+kiR
	 TDGRi/9/xyNJlByWQ+lvWxuhsUppxAQRH8vEageEE4UVuRbMymzVjJwmS9eDNPao60UmZ
	 TQZrjeCki3uyflkWLmmMEwsT7aavApObMHiLB6J9lpcnJzyr8CqzB8CmUPDUK044ACw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=igTT3jQ3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6F67606A326
	for <mptcp@lists.linux.dev>; Wed, 25 Nov 2026 07:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=igTT3jQ3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71A3E1F000EB
	for <mptcp@lists.linux.dev>; Wed, 25 Nov 2026 07:23:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795591398;
	bh=XadJ9vAFI1rCOAKh+P/BuP01VN5XbJrU7xd+YcPsUd8=;
	h=From:To:Subject:Date:In-Reply-To:References;
	b=igTT3jQ3QmXf0/fkTwvbvzWaupXq3DNk8Xw4wuka9H1StYTow4GB25E8yW8YrPyKx
	 wl+AV1qhB1Bwokd3CXCzWd1pmZ8nWHJvhdG7drvJFIGu0Usm9AbP2KZpLz1l+F4xY5
	 OVR/qj9XRGHNgNhHnuJF4M8hdvGZ0Oxi1qUDEdaL7ZKwq58fNx+uWvf8Yp9fgnzdkM
	 ++mV1Z/A4BTdQ3lLOuxSN/Oee/7qt3iIm2sEqMtTOcRectkTyr2lydMRbZ+uxS+wN1
	 lStgd8ZJAXf6ZJJCAV/WhA4m2YF/akNrr7Wz3zm/Fvn4Dn91nhsgB48qV6mKurBamj
	 rY/t+EJv7jqlw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next v9 5/7] Documentation: msg_zerocopy: add MPTCP support
Date: Wed, 25 Nov 2026 15:23:03 +0800
Message-ID: <f3aa500269ed8fd0a8c219cf245e93682370ca1c.1795591278.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1795591278.git.tanggeliang@kylinos.cn>
References: <cover.1795591278.git.tanggeliang@kylinos.cn>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Update the MSG_ZEROCOPY documentation to list MPTCP as one of the
protocols that support this feature, alongside TCP, UDP and VSOCK.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 Documentation/networking/msg_zerocopy.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/networking/msg_zerocopy.rst b/Documentation/networking/msg_zerocopy.rst
index 78fb70e748b7..0b91beb2f5be 100644
--- a/Documentation/networking/msg_zerocopy.rst
+++ b/Documentation/networking/msg_zerocopy.rst
@@ -7,8 +7,8 @@ Intro
 =====
 
 The MSG_ZEROCOPY flag enables copy avoidance for socket send calls.
-The feature is currently implemented for TCP, UDP and VSOCK (with
-virtio transport) sockets.
+The feature is currently implemented for TCP, MPTCP, UDP and VSOCK
+(with virtio transport) sockets.
 
 
 Opportunity and Caveats
-- 
2.55.0

