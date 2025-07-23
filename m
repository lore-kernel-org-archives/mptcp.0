Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F40842F4A
	for <mptcp@lists.linux.dev>; Wed, 23 Jul 2025 05:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753247813; cv=none; b=r9uatwQWMREIGJSsz5ilM5f/k/1skjQd8NcixKZgXVmRk5NI3uIJVwtEn1vlY2FLrVQxYXGty3/Nrz8Wkfg3aMUVSJS0GD/JKv/YSOJtFITyeOyx1imo4AcqarjPNPRdhA1FYoL4BCUDHsN9h0b0SfSN3AZy7i2EPlI9+nXp4C0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753247813; c=relaxed/simple;
	bh=ob13skpAWkNt5WiJ2tvEnnhPeYn0L51oo4IUCMIXwkw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=STc2zMJzzRz8dbPDjA9G77J4ZQVZIbnAGEODaRHShoX5oOV+lXV6THOENVlihb1pqABR/i21GLTGvG4mVVS9W3UF0l1f8zcLfXi6fLKJoF8kxU3rQqwr79QzJAYxzi2PECMeQIzHvY7+SUPRoZeYF1WckA0BaiWs07ap4YpRsGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GxUCuHwT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GxUCuHwT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4765C4CEF4;
	Wed, 23 Jul 2025 05:16:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753247812;
	bh=ob13skpAWkNt5WiJ2tvEnnhPeYn0L51oo4IUCMIXwkw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GxUCuHwTYci15Wb3DF6D3Gqb+8bLBaOof8RjBl2losaxRuODcEiL51pwYg5iMFVWb
	 K2rIJ4RnKQEQf4Sb7Jyw0R82BDM8viV1GKleBU7Nvl8JEe51OJT702VQjiFw0PJWYJ
	 2P33VXZDzP/tI8H7sn4r1wGNAiQ5LPTGaI7cELbej9g9js5jDITRLoAcPEHU4wF8nv
	 jZYnIQD1qQW6mqPVN5dfHxJ9BZY3mwOw1zdwFjMS5tObl7OwiYErHACt95HWKnp+li
	 +lCug4IafD5RntwMPt1Gl2CT33hnj0xN52SxR9Ho5P81VSGSLa4+au32Yl0QIrFrrs
	 REY75+wYQAkrw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang@kernel.org>,
	Gang Yan <yangang@kylinos.cn>
Subject: [PATCH mptcp-next 5/7] Add MPTCP support to ServerSocket class
Date: Wed, 23 Jul 2025 13:16:17 +0800
Message-ID: <f5c39ac151fc97dd3625f5a48398716a483794d2.1753247666.git.geliang@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1753247666.git.geliang@kernel.org>
References: <cover.1753247666.git.geliang@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch extends ServerSocket to support Multipath TCP (MPTCP) by:

1. Adding a new constructor that accepts an mptcp parameter to enable
   MPTCP
2. Introducing a new createImpl factory method that propagates the MPTCP
   setting to the underlying socket implementation
3. Maintaining all existing functionality while adding MPTCP capabilities

The new constructor follows the same pattern as existing ServerSocket
constructors but adds the mptcp parameter to control protocol selection.
When enabled, the implementation uses the MPTCP-enabled socket creation
path established in previous patches.

Co-Developed-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Geliang Tang <geliang@kernel.org>
---
 .../share/classes/java/net/ServerSocket.java  | 66 +++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/src/java.base/share/classes/java/net/ServerSocket.java b/src/java.base/share/classes/java/net/ServerSocket.java
index 945693ef65e..ba07bc4d721 100644
--- a/src/java.base/share/classes/java/net/ServerSocket.java
+++ b/src/java.base/share/classes/java/net/ServerSocket.java
@@ -226,6 +226,57 @@ public ServerSocket(int port, int backlog, InetAddress bindAddr) throws IOExcept
         }
     }
 
+    /**
+     * Create a server using <i>mptcp</i> (Multipath TCP) or TCP protocol with
+     * the specified port, listen backlog, and local IP address to bind to.
+     * The <i>bindAddr</i> argument can be used on a multi-homed host for a
+     * ServerSocket that will only accept connect requests to one of its addresses.
+     * If <i>bindAddr</i> is null, it will default accepting
+     * connections on any/all local addresses.
+     * The port must be between 0 and 65535, inclusive.
+     * A port number of {@code 0} means that the port number is
+     * automatically allocated, typically from an ephemeral port range.
+     * This port number can then be retrieved by calling
+     * {@link #getLocalPort getLocalPort}.
+     *
+     * The {@code backlog} argument is the requested maximum number of
+     * pending connections on the socket. Its exact semantics are implementation
+     * specific. In particular, an implementation may impose a maximum length
+     * or may choose to ignore the parameter altogether. The value provided
+     * should be greater than {@code 0}. If it is less than or equal to
+     * {@code 0}, then an implementation specific default will be used.
+     *
+     * The {@code mptcp} argument is used to control whether to create a socket
+     * with MPTCP or TCP protocol.
+     *
+     * @param port  the port number, or {@code 0} to use a port
+     *              number that is automatically allocated.
+     * @param backlog requested maximum length of the queue of incoming
+     *                connections.
+     * @param bindAddr the local InetAddress the server will bind to
+     * @param mptcp create a socket with MPTCP or TCP protocol.
+     *
+     * @throws  IOException if an I/O error occurs when opening the socket.
+     * @throws     IllegalArgumentException if the port parameter is outside
+     *             the specified range of valid port values, which is between
+     *             0 and 65535, inclusive.
+     */
+    @SuppressWarnings("this-escape")
+    public ServerSocket(int port, int backlog, InetAddress bindAddr, boolean mptcp) throws IOException {
+        if (port < 0 || port > 0xFFFF)
+            throw new IllegalArgumentException("Port value out of range: " + port);
+        if (backlog < 1)
+            backlog = 50;
+
+        this.impl = createImpl(mptcp);
+        try {
+            bind(new InetSocketAddress(bindAddr, port), backlog);
+        } catch (IOException e) {
+            close();
+            throw e;
+        }
+    }
+
     /**
      * Create a SocketImpl for a server socket. The SocketImpl is created
      * without an underlying socket.
@@ -239,6 +290,21 @@ private static SocketImpl createImpl() {
         }
     }
 
+    /**
+     * Create a SocketImpl for a server socket. The SocketImpl is created
+     * without an underlying socket.
+     *
+     * @param mptcp create a socket with MPTCP or TCP protocol.
+     */
+    private static SocketImpl createImpl(boolean mptcp) {
+        SocketImplFactory factory = ServerSocket.factory;
+        if (factory != null) {
+            return factory.createSocketImpl();
+        } else {
+            return SocketImpl.createPlatformSocketImpl(true, mptcp);
+        }
+    }
+
     /**
      * Returns the {@code SocketImpl} for this ServerSocket, creating the
      * underlying socket if required.
-- 
2.48.1

