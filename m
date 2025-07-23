Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D8192F4A
	for <mptcp@lists.linux.dev>; Wed, 23 Jul 2025 05:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753247793; cv=none; b=djACq54BiP5sE46fGTdIgL0B4PozR2S7k3iPs0NcpgbrjNLgR/w5x6EufxVTgt7tJnCgZwO/QSZPaPKJrOp4VySVMXZqCKyOz0a/zUKwGKIW5il06eVAkJ3DOJiyXHPSHDRon7OmyyivJp7vfzVRw4haHcU/Nbo/vyBMsyq9RPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753247793; c=relaxed/simple;
	bh=yFFdsAFimvo32xUf0z6klzZnfpqJJGMUgrm9ftdg3yA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JwxYi2hBwUPkQLlQfz1UzWTcg4ZCS6pUPcWT1WXlIJGXONnpjJB1OLZucG34FqamDi95BayVRziVKaGuf0tkJuYaHHbZZN5pR/WNTzzpQn1YeWbZnbIMbY9sqYF40UXhlfSEn0D4/r6PaYSlouicqVQpaStla54a96PNpP5b3IE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ewP7tfxB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ewP7tfxB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B67C3C4CEE7;
	Wed, 23 Jul 2025 05:16:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753247793;
	bh=yFFdsAFimvo32xUf0z6klzZnfpqJJGMUgrm9ftdg3yA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ewP7tfxBJ3SKMJeTQYhscX8Ab9K8Nm6lkSD3YpfoJHIChmmproT6zgLVVuJ8lkv2p
	 EaiWGVCvNG8JKi8I3G1K7tg4db+dPBL2AMkVF+OnKsnIjpHTR3HHa5PoyOCLY9PTQf
	 5+jHpFm9fxv5BdHoq+MmyswD82ocAf220+RzByZa8uY4Mg6E4Ar8T1wGmjENQc4Yz/
	 XhcDcs4pT14EhOTNR3ix7SaH3X/gAZeyxDZ7udb2yGYCWgtRsVVK+H/4LQT3w7EQ8Y
	 iVJ+mBG961HGyvQ/wAiVVlTBpZ8NApReApby+5P/rhVTv3ANyNn8ZwF7XFC0d0Z2bY
	 NP7JKhbrEHnTw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang@kernel.org>,
	Gang Yan <yangang@kylinos.cn>
Subject: [PATCH mptcp-next 1/7] Add MPTCP support for socket creation
Date: Wed, 23 Jul 2025 13:16:13 +0800
Message-ID: <d97fe07c2fb587f1672bcfa73524daab035ed61c.1753247666.git.geliang@kernel.org>
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

This patch extends the socket creation functionality to support Multipath
TCP (MPTCP) by adding a new 'mptcp' parameter to the native socket0 method.
When enabled, the socket will be created with the IPPROTO_MPTCP protocol
for stream sockets.

The changes include:
1. Added the 'mptcp' parameter to socket0 method declarations in Net.java
2. Modified the native implementations in both Unix and Windows Net.c files
   to handle the new parameter and set the appropriate protocol
3. Updated all call sites to pass 'false' for the new parameter to maintain
   existing behavior (MPTCP disabled by default)

Co-Developed-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Geliang Tang <geliang@kernel.org>
---
 src/java.base/share/classes/sun/nio/ch/Net.java | 6 +++---
 src/java.base/unix/native/libnio/ch/Net.c       | 5 +++--
 src/java.base/windows/native/libnio/ch/Net.c    | 2 +-
 3 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/src/java.base/share/classes/sun/nio/ch/Net.java b/src/java.base/share/classes/sun/nio/ch/Net.java
index 9ec7975a35c..c086429380b 100644
--- a/src/java.base/share/classes/sun/nio/ch/Net.java
+++ b/src/java.base/share/classes/sun/nio/ch/Net.java
@@ -488,7 +488,7 @@ static FileDescriptor socket() throws IOException {
     static FileDescriptor socket(ProtocolFamily family, boolean stream) throws IOException {
         boolean preferIPv6 = isIPv6Available() &&
             (family != StandardProtocolFamily.INET);
-        return IOUtil.newFD(socket0(preferIPv6, stream, false, FAST_LOOPBACK));
+        return IOUtil.newFD(socket0(preferIPv6, stream, false, FAST_LOOPBACK, false));
     }
 
     static FileDescriptor serverSocket() {
@@ -498,12 +498,12 @@ static FileDescriptor serverSocket() {
     static FileDescriptor serverSocket(ProtocolFamily family) {
         boolean preferIPv6 = isIPv6Available() &&
             (family != StandardProtocolFamily.INET);
-        return IOUtil.newFD(socket0(preferIPv6, true, true, FAST_LOOPBACK));
+        return IOUtil.newFD(socket0(preferIPv6, true, true, FAST_LOOPBACK, false));
     }
 
     // Due to oddities SO_REUSEADDR on Windows reuse is ignored
     private static native int socket0(boolean preferIPv6, boolean stream, boolean reuse,
-                                      boolean fastLoopback);
+                                      boolean fastLoopback, boolean mptcp);
 
     public static void bind(FileDescriptor fd, InetAddress addr, int port)
         throws IOException
diff --git a/src/java.base/unix/native/libnio/ch/Net.c b/src/java.base/unix/native/libnio/ch/Net.c
index 28c1814f422..1b08539873f 100644
--- a/src/java.base/unix/native/libnio/ch/Net.c
+++ b/src/java.base/unix/native/libnio/ch/Net.c
@@ -255,13 +255,14 @@ Java_sun_nio_ch_Net_canUseIPv6OptionsWithIPv4LocalAddress0(JNIEnv* env, jclass c
 
 JNIEXPORT jint JNICALL
 Java_sun_nio_ch_Net_socket0(JNIEnv *env, jclass cl, jboolean preferIPv6,
-                            jboolean stream, jboolean reuse, jboolean ignored)
+                            jboolean stream, jboolean reuse, jboolean ignored, jboolean mptcp)
 {
     int fd;
     int type = (stream ? SOCK_STREAM : SOCK_DGRAM);
     int domain = (ipv6_available() && preferIPv6) ? AF_INET6 : AF_INET;
+    int protocol = (stream && mptcp) ? IPPROTO_MPTCP : 0;
 
-    fd = socket(domain, type, 0);
+    fd = socket(domain, type, protocol);
     if (fd < 0) {
         return handleSocketError(env, errno);
     }
diff --git a/src/java.base/windows/native/libnio/ch/Net.c b/src/java.base/windows/native/libnio/ch/Net.c
index 814f502c48a..c563aa9f031 100644
--- a/src/java.base/windows/native/libnio/ch/Net.c
+++ b/src/java.base/windows/native/libnio/ch/Net.c
@@ -152,7 +152,7 @@ Java_sun_nio_ch_Net_canUseIPv6OptionsWithIPv4LocalAddress0(JNIEnv* env, jclass c
 
 JNIEXPORT jint JNICALL
 Java_sun_nio_ch_Net_socket0(JNIEnv *env, jclass cl, jboolean preferIPv6,
-                            jboolean stream, jboolean reuse, jboolean fastLoopback)
+                            jboolean stream, jboolean reuse, jboolean fastLoopback, jboolean mptcp)
 {
     SOCKET s;
     int domain = (preferIPv6) ? AF_INET6 : AF_INET;
-- 
2.48.1

