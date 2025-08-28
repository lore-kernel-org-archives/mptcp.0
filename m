Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2E5930CD89
	for <mptcp@lists.linux.dev>; Thu, 28 Aug 2025 08:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756370848; cv=none; b=FUxS/k6TsYDkhqXpQTDv91wu56gynx3uYebdfQWD5Lth3fv3OQR6sogCZpwkR2K3I6mXQLPPSkq78vs2uEzYAptFa7qLQqhNvuymJ4OpoI9nOTAnKz/5QhjtWmAk+hsqUdEITkeKaxZjVXCNRWKU/2GaLJ9venOhbKdHTS5ZD1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756370848; c=relaxed/simple;
	bh=nN6QL+A0/4wikzDdc81khLs4EMZYmnihmFxCsKOtjDU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jAkSgEyKwgdUn/44IXOHvAwAKm6fmf5xZZ2fz1/dNeWnc0c+yNrVjLVtOSj+6h2oe1Q2HthFKTDdvYynYJxOcbd8jHz+LrAHOQdME//YqJ9tLJebPdv9FHGHzTWdQMJLj2YBXaaW4Ssflgc/5qsYLElRdYunXJXQPiYykH+l+qE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S2N0ANmF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S2N0ANmF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E326C4CEF4;
	Thu, 28 Aug 2025 08:47:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756370847;
	bh=nN6QL+A0/4wikzDdc81khLs4EMZYmnihmFxCsKOtjDU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=S2N0ANmFHoqwK+qat8WI7gNHAe9sXdVCoau4f60DB+5GscKJOdRjzsD/1ZEjWUbdj
	 ZA3jL0+SMwp3JwHDSPrtNbemotO3IRb/5UR+ab6GkVhsjQCPBDXDfQWZjwHwP/x2/2
	 1JQm+TIE7vIdcGN0lFcQI5UQZpZNtl1BUr5YVSkqcTfz4oJMZ5Gs6xUaK5uzSm2v7b
	 lIj2VxUm8ajj/83AdsqrDjhNuhbcPw/HrfJxxju+YgcHXZwtk5xDhR7F1BPEpRp5Q5
	 gnPnaPnCtYo+7aaRmk1y5wxAfBsRx0gTGEoRRH1HjcKcXbPWsnxEValayJKcW8u82A
	 w1/MFdJRpubIg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang@kernel.org>,
	Gang Yan <yangang@kylinos.cn>,
	Xiang Gao <gaoxiang@kylinos.cn>
Subject: [PATCH mptcp-next v2 1/3] Add native MPTCP socket creation support
Date: Thu, 28 Aug 2025 16:47:13 +0800
Message-ID: <4c3e6afca9f3cc88264c6d5d8e542c23ab99184d.1756369940.git.tanggeliang@kylinos.cn>
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

This patch introduces native-level support for creating MPTCP sockets by:

1. Extending the socket0 native method in both Unix and Windows
   implementations to accept an mptcp parameter
2. Adding new overloaded socket() and serverSocket() methods in
   Net.java that support explicit MPTCP enabling
3. Introducing convenience methods mptcpSocket() and mptcpServerSocket()
   for easier MPTCP socket creation

When MPTCP is enabled and supported by the OS, the socket is created with
the IPPROTO_MPTCP protocol for stream sockets. All existing call sites
are updated to pass 'false' for the mptcp parameter to maintain backward
compatibility.

Co-Developed-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Gang Yan <yangang@kylinos.cn>
Co-Developed-by: Xiang Gao <gaoxiang@kylinos.cn>
Signed-off-by: Xiang Gao <gaoxiang@kylinos.cn>
Signed-off-by: Geliang Tang <geliang@kernel.org>
---
 .../share/classes/sun/nio/ch/Net.java         | 19 ++++++++++++++-----
 src/java.base/unix/native/libnio/ch/Net.c     | 14 ++++++++++++--
 src/java.base/windows/native/libnio/ch/Net.c  |  4 +++-
 3 files changed, 29 insertions(+), 8 deletions(-)

diff --git a/src/java.base/share/classes/sun/nio/ch/Net.java b/src/java.base/share/classes/sun/nio/ch/Net.java
index 9ec7975a35c..20caa62859f 100644
--- a/src/java.base/share/classes/sun/nio/ch/Net.java
+++ b/src/java.base/share/classes/sun/nio/ch/Net.java
@@ -485,25 +485,34 @@ static FileDescriptor socket() throws IOException {
         return socket(UNSPEC, true);
     }
 
-    static FileDescriptor socket(ProtocolFamily family, boolean stream) throws IOException {
+    static FileDescriptor socket(ProtocolFamily family, boolean stream, boolean mptcp)
+	throws IOException {
         boolean preferIPv6 = isIPv6Available() &&
             (family != StandardProtocolFamily.INET);
-        return IOUtil.newFD(socket0(preferIPv6, stream, false, FAST_LOOPBACK));
+        return IOUtil.newFD(socket0(preferIPv6, stream, false, FAST_LOOPBACK, mptcp));
+    }
+
+    static FileDescriptor socket(ProtocolFamily family, boolean stream) throws IOException {
+        return socket(family, stream, false);
     }
 
     static FileDescriptor serverSocket() {
         return serverSocket(UNSPEC);
     }
 
-    static FileDescriptor serverSocket(ProtocolFamily family) {
+    static FileDescriptor serverSocket(ProtocolFamily family, boolean mptcp) {
         boolean preferIPv6 = isIPv6Available() &&
             (family != StandardProtocolFamily.INET);
-        return IOUtil.newFD(socket0(preferIPv6, true, true, FAST_LOOPBACK));
+        return IOUtil.newFD(socket0(preferIPv6, true, true, FAST_LOOPBACK, mptcp));
+    }
+
+    static FileDescriptor serverSocket(ProtocolFamily family) {
+        return serverSocket(family, false);
     }
 
     // Due to oddities SO_REUSEADDR on Windows reuse is ignored
     private static native int socket0(boolean preferIPv6, boolean stream, boolean reuse,
-                                      boolean fastLoopback);
+                                      boolean fastLoopback, boolean mptcp);
 
     public static void bind(FileDescriptor fd, InetAddress addr, int port)
         throws IOException
diff --git a/src/java.base/unix/native/libnio/ch/Net.c b/src/java.base/unix/native/libnio/ch/Net.c
index 28c1814f422..1c53c197fd8 100644
--- a/src/java.base/unix/native/libnio/ch/Net.c
+++ b/src/java.base/unix/native/libnio/ch/Net.c
@@ -255,13 +255,23 @@ Java_sun_nio_ch_Net_canUseIPv6OptionsWithIPv4LocalAddress0(JNIEnv* env, jclass c
 
 JNIEXPORT jint JNICALL
 Java_sun_nio_ch_Net_socket0(JNIEnv *env, jclass cl, jboolean preferIPv6,
-                            jboolean stream, jboolean reuse, jboolean ignored)
+                            jboolean stream, jboolean reuse, jboolean ignored,
+                            jboolean mptcp)
 {
     int fd;
     int type = (stream ? SOCK_STREAM : SOCK_DGRAM);
     int domain = (ipv6_available() && preferIPv6) ? AF_INET6 : AF_INET;
+    int protocol = 0;
 
-    fd = socket(domain, type, 0);
+#if defined(__linux__) && defined(IPPROTO_MPTCP)
+    if (stream == JNI_TRUE && mptcp == JNI_TRUE) {
+        protocol = IPPROTO_MPTCP;
+    }
+#else
+    (void)mptcp; /* Avoid compile warning when MPTCP is not supported */
+#endif
+
+    fd = socket(domain, type, protocol);
     if (fd < 0) {
         return handleSocketError(env, errno);
     }
diff --git a/src/java.base/windows/native/libnio/ch/Net.c b/src/java.base/windows/native/libnio/ch/Net.c
index 814f502c48a..5b9ecdd2c77 100644
--- a/src/java.base/windows/native/libnio/ch/Net.c
+++ b/src/java.base/windows/native/libnio/ch/Net.c
@@ -152,11 +152,13 @@ Java_sun_nio_ch_Net_canUseIPv6OptionsWithIPv4LocalAddress0(JNIEnv* env, jclass c
 
 JNIEXPORT jint JNICALL
 Java_sun_nio_ch_Net_socket0(JNIEnv *env, jclass cl, jboolean preferIPv6,
-                            jboolean stream, jboolean reuse, jboolean fastLoopback)
+                            jboolean stream, jboolean reuse, jboolean fastLoopback,
+                            jboolean mptcp)
 {
     SOCKET s;
     int domain = (preferIPv6) ? AF_INET6 : AF_INET;
 
+    (void)mptcp; /* not support MPTCP yet */
     s = socket(domain, (stream ? SOCK_STREAM : SOCK_DGRAM), 0);
     if (s != INVALID_SOCKET) {
         SetHandleInformation((HANDLE)s, HANDLE_FLAG_INHERIT, 0);
-- 
2.48.1

