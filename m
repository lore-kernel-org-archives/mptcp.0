Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795754230;
	b=X3WCkuY+7sIS/+RTycWkKOliYO8JHugUuWYE1whN24C4hk2pXv4/4xO6mSq5UssMit1F
	 OMxPPZTvuX+vtChXGsEmb81eP7Q5vC2O03Ku8+dTpI8U6kR7QHU/KleebwcxY3eTtC79b
	 OE/FjBzHjiG/nn6N6B+aCWQJxMz7FecD0BzompcRFSROO5m7N/j92ww6l3m2QnufNCNix
	 twev/9g1NLxqWosVYwph9vmaSYpU3raTR6hB2pccwcPPBlogLJDdGuPyLiQtBFcKl/nnt
	 QmSPoFqJk0S/XpKz8Id6DhGg4ZIJmmaz5iFRB2QOh/t4PUpt/d5X/6AT7kGRCne++Mg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795754230;
	h=Received:DKIM-Signature:From:To:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Lat+8gqBNfjVs40HLxWyiEjk7y4AwFqNn4PVrvIP7n8=;
	b=naiL3Y5XGNrhcTFUD3p4xYWSZ9VZTbiipPkHEecWtiokZb7k3TEJwXNLazqbm9wMRiTa
	 c/glKX5v1FTY8rP0QJnEs5U8lK3yzgAnYSQUv+zqMKC2/NomRi10xyR0c2SU4cTVJcYlA
	 eOsVb6kiNNcVhHJ6KZxjuQv8+K4JO9P1A3+RmORgGmLcmLkWdkkH82CYPMZQAlEVNVH3z
	 Wf3IwbhGgsdcl3kmCxj420+987sCdIJNS9U+nNR+ZusTXjaAEFf43C+RlFh9WePM9qA8/
	 IUKTJoskuB6wuq6I1YUuB7B2v6qldzl5CHOwzMrx0ie8MrQMui+qM1pTbB/PKEEdW5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YaBcfsfe;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF62606A31C
	for <mptcp@lists.linux.dev>; Fri, 27 Nov 2026 04:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YaBcfsfe
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D6FF1F00893
	for <mptcp@lists.linux.dev>; Fri, 27 Nov 2026 04:37:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795754230;
	bh=Lat+8gqBNfjVs40HLxWyiEjk7y4AwFqNn4PVrvIP7n8=;
	h=From:To:Subject:Date:In-Reply-To:References;
	b=YaBcfsfeln/TsEg7G9nRuCpubdfwHkxCZGvS3FFwTumfAALI15Nd4bIrgSf7Wv50D
	 +QMIV4rEHwPQcBUVilhHhrl4eamfcAzULASyQTHIdSXCDBSn1V0jev9XZ0U0oM2zjr
	 wvyCkTkGtuVuTVa4RmCwSOmZkTQDoyB4LEF1K5jIcdNu/wJD2o7SwplBmeuzS+ortP
	 xRwARm704OozD0njaOH/xe4rHOzWWy+9NihKnGCleLnCVlD68TqhbTNxV7q2IuYj0t
	 3yoyMJbyd9am5JtfEx4CLVH9LQ+JI+plx0tx5sffg9qmrlWU3QvVuVBDY7x85kAfsL
	 h9/78DVlpCHbQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next v10 5/7] Documentation: msg_zerocopy: add MPTCP support
Date: Fri, 27 Nov 2026 12:36:18 +0800
Message-ID: <77633a8f6660b9a83d5aadccc82fd0ce8baefa15.1795753727.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1795753727.git.tanggeliang@kylinos.cn>
References: <cover.1795753727.git.tanggeliang@kylinos.cn>
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

