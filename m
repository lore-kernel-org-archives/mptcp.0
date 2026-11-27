Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795783559;
	b=E+IIXnRlT/1PTNryQgWIVDyyyz26kjHDE3toIoub2pM3MynIqQ2TJYkgcNXOdP3PXTz7
	 kH6yJyUbzgCgduyWbVze3bDxE3J5V3NP5qupxpoUe18H78MVABpTNbT7kCBJZmzCQKMhG
	 hdXKt3Tey6k593DP5e/1I9G6nmfNxqi6pZH7047oq9LZjOXtQoUSTJAVREewIB96FzTOf
	 JYBUo5eQnYqL2/ckXhSkGjIwL4m8BZ00vXquEyGyN9qwMnejTTRGSg5Kku7vaRrzVahvZ
	 494h2KEewyLwzq6D1Q1mfOh/ioFWfRc6ZyD2hkA3a8/JeAa85XMf5qMRfXgRzkL9Orw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795783559;
	h=Received:DKIM-Signature:From:To:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Uvx3V+cYsj7D8+s+WhqvTp6ybQYMgrjTwhE4XEmfor8=;
	b=feuR/oFp6ew/kwvC9MhMvuGtkDqOJFfkCrvQPBJcX/qGyXLR8X1FgNNcndN/Mz3F4QMQ
	 11/vClRIQoUMbpwNt28vBvD2AXOdKX3BILGzbRN8mUKthpa55tHuKOVFGJjfrpka+fSnt
	 3AOl3gpX77DADU1XOF6ITsHLaXnLk6+RXsNDcoFNYqN5sU9sHqen/licpbQz0FbQE+ajT
	 vub6U0GY59XFLTEdk24Rf9Vf2tQGX4et76YulvVo7vnkjWsv6qLJLGMG9R/qIC7UIEr71
	 M+/XVgcAs+R32aCCh6ju8CZz9xvd+3MJrIDyW6CBE+WTZQwO1Aau8slsub3ji28UrjQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="NU7LD8W/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4FAF606A32D
	for <mptcp@lists.linux.dev>; Fri, 27 Nov 2026 12:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NU7LD8W/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B42D31F00893
	for <mptcp@lists.linux.dev>; Fri, 27 Nov 2026 12:45:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795783559;
	bh=Uvx3V+cYsj7D8+s+WhqvTp6ybQYMgrjTwhE4XEmfor8=;
	h=From:To:Subject:Date:In-Reply-To:References;
	b=NU7LD8W/0ZL0rCLpNtH0GSlGkkKGfRAkoIvEgvqwBqgQu+u4yVu/nG6s2nBCqbfnU
	 gdC2rd10nnRsgXXOV1jPoXujToU7dMrHjdTnFShtln6vvgfpj849cy8z4VfIN3NCAB
	 g/dKR1LDH3MbDjuMrJtJ1Jovuxvigtq66XzsTh1pzqCDPVvxBWpWkVKBO+rsjbAPFK
	 j8D8hfIsXJXa2m2DDZXZAUYDVJt9ml89w0dtfFhnzUofDMp1yvJPdSHGFLOBXH0SJe
	 FKuzvI3ZoTmeO6hYF95VdsJp7Ezxvw5eRX4m7jQVqgujJyU/91be24BO9ZBOUx5js1
	 Gg9s/S4WWTcjQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next v11 5/7] Documentation: msg_zerocopy: add MPTCP support
Date: Fri, 27 Nov 2026 20:45:25 +0800
Message-ID: <7706bf0aac6bea0b5b389bbeb38805f214c5953c.1795783388.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1795783388.git.tanggeliang@kylinos.cn>
References: <cover.1795783388.git.tanggeliang@kylinos.cn>
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
Also mention MPTCP in the notification error queue and Loopback
sections.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 Documentation/networking/msg_zerocopy.rst | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/networking/msg_zerocopy.rst b/Documentation/networking/msg_zerocopy.rst
index 78fb70e748b7..a06055f1243a 100644
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
@@ -175,7 +175,7 @@ read_notification() call in the previous snippet. A notification
 is encoded in the standard error format, sock_extended_err.
 
 The level and type fields in the control data are protocol family
-specific, IP_RECVERR or IPV6_RECVERR (for TCP or UDP socket).
+specific, IP_RECVERR or IPV6_RECVERR (for TCP, MPTCP or UDP socket).
 For VSOCK socket, cmsg_level will be SOL_VSOCK and cmsg_type will be
 VSOCK_RECVERR.
 
@@ -238,7 +238,7 @@ Implementation
 Loopback
 --------
 
-For TCP and UDP:
+For TCP, MPTCP and UDP:
 Data sent to local sockets can be queued indefinitely if the receive
 process does not read its socket. Unbound notification latency is not
 acceptable. For this reason all packets generated with MSG_ZEROCOPY
-- 
2.55.0

