Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 178EB30CD89
	for <mptcp@lists.linux.dev>; Thu, 28 Aug 2025 08:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756370850; cv=none; b=E3BhHIT/cgLzv2S4T5RC8KNYD42DWTMF9u1tDXeShoTxkDFVeI1/7mFFbRXXJu86otpUb9kvsjaI8ABH2F6lMBIYOmrixglPzISnX2b5GWDTrcnsE1r71XSG387wNwH8KmjakZbHb7OfT3GgfL+OK0iYi1Nj4qv66j1cidGc2Ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756370850; c=relaxed/simple;
	bh=6A+RfvBwp+D+o6xjRzYPJsOrZd6D1xBmPUoJStqa3vE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YigH8TytFkR7lhueqphkcHW4XArqROHg8tC87qkZD4htF7UmUatWxwkZIlydG8ozwsI5lnB1FV+LWzVwbYYprkb1grr4T/QT05mZmu5JBQ6Tss5HH+pVMmhdguB/4+pOKI56hwwfRDXpMH9xlv9pMbRte6hZqMo/tCCZtCSAuqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QhSrih69; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QhSrih69"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24318C4CEEB;
	Thu, 28 Aug 2025 08:47:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756370849;
	bh=6A+RfvBwp+D+o6xjRzYPJsOrZd6D1xBmPUoJStqa3vE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QhSrih694H2Pq4LqeZKD1z1vSfvZHYm9fqZWlaI7d3rrCsRuaZoE1+MsUaqZujd9q
	 z+8z87RYiLG8DUVa9J02FnM6KnoyrYOhERWR06ehGKZ5RrSL/orBy+QpC238IhXrrG
	 Us3ZRW64n809eqfNBnPDPNLXIThIjBI3xHpfHD28QTj8+7ylxzvL5HUOksBF3ze8w3
	 8m78cnkclb1BSoS7Be6A/cB+I426sFQ9yJTkMxesjtsZ3f4e3jMJWqQqfVdgOJxn2D
	 8u5qwcqDZeroIlgNKDWBvaVCIRJv6q3gKAGKeNTLC2jMBB1OVvBiVbvEeOWW/Fggmn
	 d4lY5Fv205DYg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang@kernel.org>,
	Gang Yan <yangang@kylinos.cn>
Subject: [PATCH mptcp-next v2 2/3] Add MPTCP support to Java Socket/ServerSocket APIs
Date: Thu, 28 Aug 2025 16:47:14 +0800
Message-ID: <f400e94fe4dc7c9859ad54c47bf506df6ca0d833.1756369940.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1756369940.git.tanggeliang@kylinos.cn>
References: <cover.1756369940.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch integrates MPTCP support into the Java socket API by:

1. Adding new constructors in Socket and ServerSocket that accept an mptcp
   parameter to enable MPTCP explicitly
2. Extending NioSocketImpl to track the MPTCP state and use the appropriate
   native methods for socket creation
3. Propagating the MPTCP flag through the socket creation chain via new
   createImpl() factory methods
4. Ensuring backward compatibility by keeping existing constructors
   unchanged

The implementation allows Java applications to use MPTCP seamlessly while
maintaining full compatibility with existing TCP-based code.

Co-Developed-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Geliang Tang <geliang@kernel.org>
---
 .../share/classes/java/net/ServerSocket.java  | 52 +++++++++++++--
 .../share/classes/java/net/Socket.java        | 65 +++++++++++++++++--
 .../share/classes/java/net/SocketImpl.java    |  4 +-
 .../classes/sun/nio/ch/NioSocketImpl.java     | 11 +++-
 4 files changed, 115 insertions(+), 17 deletions(-)

diff --git a/src/java.base/share/classes/java/net/ServerSocket.java b/src/java.base/share/classes/java/net/ServerSocket.java
index 945693ef65e..bc3c81a3663 100644
--- a/src/java.base/share/classes/java/net/ServerSocket.java
+++ b/src/java.base/share/classes/java/net/ServerSocket.java
@@ -107,7 +107,7 @@ protected ServerSocket(SocketImpl impl) {
      * @throws    IOException IO error when opening the socket.
      */
     public ServerSocket() throws IOException {
-        this.impl = createImpl();
+        this.impl = createImpl(false);
     }
 
     /**
@@ -212,12 +212,52 @@ public ServerSocket(int port, int backlog) throws IOException {
      */
     @SuppressWarnings("this-escape")
     public ServerSocket(int port, int backlog, InetAddress bindAddr) throws IOException {
+        this(port, backlog, bindAddr, false);
+    }
+
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
         if (port < 0 || port > 0xFFFF)
             throw new IllegalArgumentException("Port value out of range: " + port);
         if (backlog < 1)
             backlog = 50;
 
-        this.impl = createImpl();
+        this.impl = createImpl(mptcp);
         try {
             bind(new InetSocketAddress(bindAddr, port), backlog);
         } catch (IOException e) {
@@ -229,13 +269,15 @@ public ServerSocket(int port, int backlog, InetAddress bindAddr) throws IOExcept
     /**
      * Create a SocketImpl for a server socket. The SocketImpl is created
      * without an underlying socket.
+     *
+     * @param mptcp create a socket with MPTCP or TCP protocol.
      */
-    private static SocketImpl createImpl() {
+    private static SocketImpl createImpl(boolean mptcp) {
         SocketImplFactory factory = ServerSocket.factory;
         if (factory != null) {
             return factory.createSocketImpl();
         } else {
-            return SocketImpl.createPlatformSocketImpl(true);
+            return SocketImpl.createPlatformSocketImpl(true, mptcp);
         }
     }
 
@@ -556,7 +598,7 @@ private SocketImpl platformImplAccept() throws IOException {
         assert impl instanceof PlatformSocketImpl;
 
         // create a new platform SocketImpl and accept the connection
-        SocketImpl psi = SocketImpl.createPlatformSocketImpl(false);
+        SocketImpl psi = SocketImpl.createPlatformSocketImpl(false, false);
         implAccept(psi);
         return psi;
     }
diff --git a/src/java.base/share/classes/java/net/Socket.java b/src/java.base/share/classes/java/net/Socket.java
index 692c3395f78..c58ad348fd6 100644
--- a/src/java.base/share/classes/java/net/Socket.java
+++ b/src/java.base/share/classes/java/net/Socket.java
@@ -168,7 +168,7 @@ private static boolean isOutputShutdown(int s) {
      * @since   1.1
      */
     public Socket() {
-        this.impl = createImpl();
+        this.impl = createImpl(false);
     }
 
     /**
@@ -207,7 +207,7 @@ public Socket(Proxy proxy) {
                 checkAddress (epoint.getAddress(), "Socket");
             }
             // create a SOCKS or HTTP SocketImpl that delegates to a platform SocketImpl
-            SocketImpl delegate = SocketImpl.createPlatformSocketImpl(false);
+            SocketImpl delegate = SocketImpl.createPlatformSocketImpl(false, false);
             impl = (type == Proxy.Type.SOCKS) ? new SocksSocketImpl(p, delegate)
                                               : new HttpConnectSocketImpl(p, delegate, this);
         } else {
@@ -215,7 +215,7 @@ public Socket(Proxy proxy) {
                 // create a platform or custom SocketImpl for the DIRECT case
                 SocketImplFactory factory = Socket.factory;
                 if (factory == null) {
-                    impl = SocketImpl.createPlatformSocketImpl(false);
+                    impl = SocketImpl.createPlatformSocketImpl(false, false);
                 } else {
                     impl = factory.createSocketImpl();
                 }
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
@@ -442,6 +475,22 @@ public Socket(InetAddress host, int port, boolean stream) throws IOException {
      */
     private Socket(SocketAddress address, SocketAddress localAddr, boolean stream)
         throws IOException
+    {
+        this(address, localAddr, stream, false);
+    }
+
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
     {
         Objects.requireNonNull(address);
         if (!stream) {
@@ -451,7 +500,7 @@ private Socket(SocketAddress address, SocketAddress localAddr, boolean stream)
         assert address instanceof InetSocketAddress;
 
         // create the SocketImpl and the underlying socket
-        SocketImpl impl = createImpl();
+        SocketImpl impl = createImpl(mptcp);
         impl.create(stream);
 
         this.impl = impl;
@@ -471,14 +520,16 @@ private Socket(SocketAddress address, SocketAddress localAddr, boolean stream)
     /**
      * Create a new SocketImpl for a connecting/client socket. The SocketImpl
      * is created without an underlying socket.
+     *
+     * @param mptcp create a socket with MPTCP or TCP protocol.
      */
-    private static SocketImpl createImpl() {
+    private static SocketImpl createImpl(boolean mptcp) {
         SocketImplFactory factory = Socket.factory;
         if (factory != null) {
             return factory.createSocketImpl();
         } else {
             // create a SOCKS SocketImpl that delegates to a platform SocketImpl
-            SocketImpl delegate = SocketImpl.createPlatformSocketImpl(false);
+            SocketImpl delegate = SocketImpl.createPlatformSocketImpl(false, mptcp);
             return new SocksSocketImpl(delegate);
         }
     }
@@ -498,7 +549,7 @@ private SocketImpl getImpl() throws SocketException {
                     }
                     SocketImpl impl = this.impl;
                     if (impl == null) {
-                        this.impl = impl = createImpl();
+                        this.impl = impl = createImpl(false);
                     }
                     try {
                         impl.create(true);
diff --git a/src/java.base/share/classes/java/net/SocketImpl.java b/src/java.base/share/classes/java/net/SocketImpl.java
index 15c12457aac..f55034fb720 100644
--- a/src/java.base/share/classes/java/net/SocketImpl.java
+++ b/src/java.base/share/classes/java/net/SocketImpl.java
@@ -48,8 +48,8 @@ public abstract class SocketImpl implements SocketOptions {
      * Creates an instance of platform's SocketImpl
      */
     @SuppressWarnings("unchecked")
-    static <S extends SocketImpl & PlatformSocketImpl> S createPlatformSocketImpl(boolean server) {
-        return (S) new NioSocketImpl(server);
+    static <S extends SocketImpl & PlatformSocketImpl> S createPlatformSocketImpl(boolean server, boolean mptcp) {
+        return (S) new NioSocketImpl(server, mptcp);
     }
 
     /**
diff --git a/src/java.base/share/classes/sun/nio/ch/NioSocketImpl.java b/src/java.base/share/classes/sun/nio/ch/NioSocketImpl.java
index dd81b356738..2916560f1b6 100644
--- a/src/java.base/share/classes/sun/nio/ch/NioSocketImpl.java
+++ b/src/java.base/share/classes/sun/nio/ch/NioSocketImpl.java
@@ -86,6 +86,9 @@ public final class NioSocketImpl extends SocketImpl implements PlatformSocketImp
     // true if this is a SocketImpl for a ServerSocket
     private final boolean server;
 
+    // true if this is a SocketImpl for a MptcpServerSocket
+    private final boolean mptcp;
+
     // Lock held when reading (also used when accepting or connecting)
     private final ReentrantLock readLock = new ReentrantLock();
 
@@ -128,9 +131,11 @@ public final class NioSocketImpl extends SocketImpl implements PlatformSocketImp
     /**
      * Creates an instance of this SocketImpl.
      * @param server true if this is a SocketImpl for a ServerSocket
+     * @param mptcp enable MPTCP
      */
-    public NioSocketImpl(boolean server) {
+    public NioSocketImpl(boolean server, boolean mptcp) {
         this.server = server;
+        this.mptcp = mptcp;
     }
 
     /**
@@ -468,9 +473,9 @@ protected void create(boolean stream) throws IOException {
                 throw new IOException("Already created");
             FileDescriptor fd;
             if (server) {
-                fd = Net.serverSocket();
+                fd = Net.serverSocket(Net.UNSPEC, mptcp);
             } else {
-                fd = Net.socket();
+                fd = Net.socket(Net.UNSPEC, true, mptcp);
             }
             Runnable closer = closerFor(fd);
             this.fd = fd;
-- 
2.48.1

