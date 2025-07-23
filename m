Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 973042F4A
	for <mptcp@lists.linux.dev>; Wed, 23 Jul 2025 05:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753247815; cv=none; b=HKc7nGSki//B9Z95S46hMPrvnm5E/RsoYhCHCsWyz+bWdP9JrQqXZsOCv+LEjYnAWciuJiwIp5Ifq8LEwn2oyCJHtG5i2kAzEcK5qAZSv/vFypeQ2BjZOvTt8E2z2vn87kq3l/9yqiV+kzK6+6n6w6tu7MmffgYJIYJNxi12hYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753247815; c=relaxed/simple;
	bh=gGcQsA8s1mzj17IIURPrilfJDY/qqL/XDJC5Urxcngg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j3ZFT3ujK8K4p2d/s0D9/qmjdWFwKI3N8Y0TMSD74Aum7BPi2wKTgfrZs+J+eHfbWCwapUxubI1S4JKERPp2vwTJZrzFdKxNKJ0w22RGCK63jWvbj1nx8A6MkcBZ+5AmVD/OUANAqZzerTK/qnLB0TOYJLwcwkexND4gVux+pBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iXmyqjmA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iXmyqjmA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C960C4CEE7;
	Wed, 23 Jul 2025 05:16:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753247815;
	bh=gGcQsA8s1mzj17IIURPrilfJDY/qqL/XDJC5Urxcngg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iXmyqjmAoeazriOm3P2f8kKPGPsF/PZ8LucBsqsdxpjGnXego5UP0gcmmqT8iGBmN
	 WQyE+s/h1MgGJuM+o9H0BAUMH9jJryLvsugCLDrM/uWwtZRvm6ydKNAqYntoeaAC7i
	 04C0R+Eo2VImeYebgg3+7Vq+eaYScFZJ91OcBVrOSFSZQgIu2BLCAOyK/9VALIJi8B
	 TNDIZRY82CZeiin27bVzDJZMlzoibSgY4eAXiOu5rBtgeALPfiimRXpndhg3LadsFL
	 WBn8qBMe2uftdlk7rrAnEPsevMuQcwbqSzI+h6ZBgHR7tRPw+mvt3oV8B4EvGA4IqX
	 +kEuowAnpDj0A==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang@kernel.org>,
	Gang Yan <yangang@kylinos.cn>
Subject: [PATCH mptcp-next 6/7] Add MPTCP support to Socket class
Date: Wed, 23 Jul 2025 13:16:18 +0800
Message-ID: <b70623fa81d0d269f407cdd890d48668d1b4c443.1753247666.git.geliang@kernel.org>
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

This patch extends the Socket class to support Multipath TCP (MPTCP) by:

1. Adding a new constructor that accepts an mptcp parameter to enable MPTCP
2. Introducing a new private Socket constructor variant that handles MPTCP
   connections
3. Adding a createImpl factory method that propagates the MPTCP setting
   to the underlying socket implementation
4. Maintaining backward compatibility while adding MPTCP capabilities

The implementation ensures MPTCP support is properly integrated with:
- Address resolution
- Socket binding
- Connection establishment
- Error handling

When MPTCP is enabled, the socket uses the MPTCP-enabled creation path
established in previous patches, while maintaining all existing socket
functionality for non-MPTCP cases.

Co-Developed-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Geliang Tang <geliang@kernel.org>
---
 .../share/classes/java/net/Socket.java        | 88 +++++++++++++++++++
 1 file changed, 88 insertions(+)

diff --git a/src/java.base/share/classes/java/net/Socket.java b/src/java.base/share/classes/java/net/Socket.java
index 692c3395f78..fc7bd5b98c0 100644
--- a/src/java.base/share/classes/java/net/Socket.java
+++ b/src/java.base/share/classes/java/net/Socket.java
@@ -403,6 +403,39 @@ public Socket(String host, int port, boolean stream) throws IOException {
              (SocketAddress) null, stream);
     }
 
+    /**
+     * Creates a stream socket and connects it to the specified port
+     * number on the named host using Multipath TCP (MPTCP) or TCP
+     * protocol.
+     * <p>
+     * If the specified host is {@code null} it is the equivalent of
+     * specifying the address as
+     * {@link java.net.InetAddress#getByName InetAddress.getByName}{@code (null)}.
+     * In other words, it is equivalent to specifying an address of the
+     * loopback interface. </p>
+     * <p>
+     * If the application has specified a {@linkplain SocketImplFactory client
+     * socket implementation factory}, that factory's
+     * {@linkplain SocketImplFactory#createSocketImpl() createSocketImpl}
+     * method is called to create the actual socket implementation. Otherwise
+     * a system-default socket implementation is created.
+     *
+     * @param      host     the host name, or {@code null} for the loopback address.
+     * @param      port     the port number.
+     * @param      stream   must be true, false is not allowed.
+     * @param      mptcp    create a socket with MPTCP or TCP protocol.
+     * @throws     IOException  if an I/O error occurs when creating the socket.
+     * @throws     IllegalArgumentException if the stream parameter is {@code false}
+     *             or if the port parameter is outside the specified range of valid
+     *             port values, which is between 0 and 65535, inclusive.
+     */
+    @SuppressWarnings("this-escape")
+    public Socket(String host, int port, boolean stream, boolean mptcp) throws IOException {
+        this(host != null ? new InetSocketAddress(host, port) :
+               new InetSocketAddress(InetAddress.getByName(null), port),
+             (SocketAddress) null, stream, mptcp);
+    }
+
     /**
      * Creates a socket and connects it to the specified port number at
      * the specified IP address.
@@ -483,6 +516,61 @@ private static SocketImpl createImpl() {
         }
     }
 
+    /**
+     * Initialize a new Socket that is connected to the given remote address.
+     * The MPTCP or TCP protocol socket is optionally bound to a local address
+     * before connecting.
+     *
+     * @param address the remote address to connect to
+     * @param localAddr the local address to bind to, can be null
+     * @param stream true for a stream socket, false for a datagram socket
+     * @param mptcp create a socket with MPTCP or TCP protocol
+     */
+    private Socket(SocketAddress address, SocketAddress localAddr, boolean stream, boolean mptcp)
+        throws IOException
+    {
+        Objects.requireNonNull(address);
+        if (!stream) {
+            throw new IllegalArgumentException(
+                    "Socket constructor does not support creation of datagram sockets");
+        }
+        assert address instanceof InetSocketAddress;
+
+        // create the SocketImpl and the underlying socket
+        SocketImpl impl = createImpl(mptcp);
+        impl.create(stream);
+
+        this.impl = impl;
+        this.state = SOCKET_CREATED;
+
+        try {
+            if (localAddr != null) {
+                bind(localAddr);
+            }
+            connect(address);
+        } catch (Throwable throwable) {
+            closeSuppressingExceptions(throwable);
+            throw throwable;
+        }
+    }
+
+    /**
+     * Create a new SocketImpl for a connecting/client socket. The SocketImpl
+     * is created without an underlying socket.
+     *
+     * @param mptcp create a socket with MPTCP or TCP protocol.
+     */
+    private static SocketImpl createImpl(boolean mptcp) {
+        SocketImplFactory factory = Socket.factory;
+        if (factory != null) {
+            return factory.createSocketImpl();
+        } else {
+            // create a SOCKS SocketImpl that delegates to a platform SocketImpl
+            SocketImpl delegate = SocketImpl.createPlatformSocketImpl(false, mptcp);
+            return new SocksSocketImpl(delegate);
+        }
+    }
+
     /**
      * Returns the {@code SocketImpl} for this Socket, creating it, and the
      * underlying socket, if required.
-- 
2.48.1

