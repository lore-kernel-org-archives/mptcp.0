Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 568C52F4A
	for <mptcp@lists.linux.dev>; Wed, 23 Jul 2025 05:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753247809; cv=none; b=m2GN1Lyd4iota8BFNoh0m2jUOV3oZ8V41Dhu/oHaznCgU7NlN7i6X8rfCurZenCWOkhv0odZZJJSrkX2AhrQCIPvlJGqj3ppCU+7ghg66S2aIO9p+i00zn7OsueM0uoKz/iGR5fho5q2ikCklnUwNDr/1nYHMmdfKY+i4dlyKr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753247809; c=relaxed/simple;
	bh=1QKrxnh5mU272uXKqZRtN/w8HziJDQ5gzYI62h1gj0I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lCmFU7eaXhoUxR1N+sIP3+5VOBGHn2jLoPbNWh6IP9z164XDFrFZR+8AH2ixzcQSPD0Sr8LfdArmfePLxfNjVwWWShVJabBEypyPxBQGK/34F8VzEXyG+uikJyyNXoKSPuZsQ3xTxoYvyJkKtPcR2A2dE4v8/D67vrZze27W0eU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eTnsbo3S; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eTnsbo3S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB170C4CEF4;
	Wed, 23 Jul 2025 05:16:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753247808;
	bh=1QKrxnh5mU272uXKqZRtN/w8HziJDQ5gzYI62h1gj0I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eTnsbo3S9BHuEGBk5VR2pWimYs/ywq2kOWx2AcVtnXMpfGvITyMUeW4Qg0mlTdSL/
	 nbPV6/2suZvDgba2PJDNAVDtJUdsasiAm7/BLdiTj5hDXXjIhfEXV1spLmGA8Nudc7
	 hiAsWa+/cQ0k29Lw4xBJMcrJyzJuqqUF/X5b1KYjrLVQ5tfIU7DInH1Cr1BfupCo2f
	 S6ZyQYA1/0TNbt946VmqKHFuUuprRIp7zZtuIBw4OxUvgyoJYlAu6qVqjiGSqRGsPo
	 wodnsAlHGAHD3/w6RsZFB2KU6665ZycINqvax/QlbQ/6RyiLwgYky+GHfXloOWpEMd
	 pn07oSx4CGjWg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang@kernel.org>,
	Gang Yan <yangang@kylinos.cn>
Subject: [PATCH mptcp-next 4/7] Add MPTCP support to NioSocketImpl
Date: Wed, 23 Jul 2025 13:16:16 +0800
Message-ID: <3f213a7f6a1508108638ecc814314c156e0e0019.1753247666.git.geliang@kernel.org>
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

This patch integrates MPTCP support into the core socket implementation
by:

1. Adding a new createPlatformSocketImpl factory method that accepts an
   mptcp parameter
2. Extending NioSocketImpl to track MPTCP state with a new mptcp field
3. Modifying socket creation logic to use the appropriate MPTCP-enabled
   methods:
   - Uses Net.mptcpServerSocket() for server sockets when MPTCP is enabled
   - Uses Net.mptcpSocket() for client sockets when MPTCP is enabled

The changes maintain backward compatibility while adding first-class MPTCP
support to the socket implementation layer. The implementation builds upon
the MPTCP infrastructure added in previous patches.

Co-Developed-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Geliang Tang <geliang@kernel.org>
---
 .../share/classes/java/net/SocketImpl.java    |  8 ++++++++
 .../classes/sun/nio/ch/NioSocketImpl.java     | 19 +++++++++++++++++--
 2 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/src/java.base/share/classes/java/net/SocketImpl.java b/src/java.base/share/classes/java/net/SocketImpl.java
index 15c12457aac..9d07366350c 100644
--- a/src/java.base/share/classes/java/net/SocketImpl.java
+++ b/src/java.base/share/classes/java/net/SocketImpl.java
@@ -52,6 +52,14 @@ static <S extends SocketImpl & PlatformSocketImpl> S createPlatformSocketImpl(bo
         return (S) new NioSocketImpl(server);
     }
 
+    /**
+     * Creates an instance of platform's SocketImpl
+     */
+    @SuppressWarnings("unchecked")
+    static <S extends SocketImpl & PlatformSocketImpl> S createPlatformSocketImpl(boolean server, boolean mptcp) {
+        return (S) new NioSocketImpl(server, mptcp);
+    }
+
     /**
      * The file descriptor object for this socket.
      */
diff --git a/src/java.base/share/classes/sun/nio/ch/NioSocketImpl.java b/src/java.base/share/classes/sun/nio/ch/NioSocketImpl.java
index dd81b356738..cf95a4e466e 100644
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
 
@@ -131,6 +134,18 @@ public final class NioSocketImpl extends SocketImpl implements PlatformSocketImp
      */
     public NioSocketImpl(boolean server) {
         this.server = server;
+        this.mptcp = false;
+    }
+
+    /**
+     * @param mptcp enable MPTCP
+     *
+     * Creates an instance of this SocketImpl.
+     * @param server true if this is a SocketImpl for a ServerSocket
+     */
+    public NioSocketImpl(boolean server, boolean mptcp) {
+        this.server = server;
+        this.mptcp = mptcp;
     }
 
     /**
@@ -468,9 +483,9 @@ protected void create(boolean stream) throws IOException {
                 throw new IOException("Already created");
             FileDescriptor fd;
             if (server) {
-                fd = Net.serverSocket();
+                fd = mptcp ? Net.mptcpServerSocket() : Net.serverSocket();
             } else {
-                fd = Net.socket();
+                fd = mptcp ? Net.mptcpSocket() : Net.socket();
             }
             Runnable closer = closerFor(fd);
             this.fd = fd;
-- 
2.48.1

