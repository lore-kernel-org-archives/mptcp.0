Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A4882F4A
	for <mptcp@lists.linux.dev>; Wed, 23 Jul 2025 05:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753247799; cv=none; b=A39YkR2n12+i7dLXmP4s7mk/BX/ZAGcfxuShQwQPqGcCCy+jJbXEzC2tZD+gixLMLoXKxRa+HuN95CAt57pJj4/XvopEMUrvDtFk+lIV9gfRA0Dr5uE07zDwvIdFJmZES8IE1KpLLtvD94xTm3RX8H2Zqpi4knnpbqBBw7pAEEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753247799; c=relaxed/simple;
	bh=HKBdxFHd2Fnzdh7om7SCDsCnykJO+LhNS3bPVDbG4dU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dR5KcBHLarPNuaEp5UgfZ50NMXAAw5QfbQ+C3ux4FKpy/J44755ZddDefqJUsO1G9yA1eocdbHJzPn0pkb8ttIU9emTW81gvSgTJibAnHLXiElSu/E4engcZ0qIBDv4psE8KqM34GyxzIg9XVUCsYojqgdO790ZtZOsYXOxY0Rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PklEBof3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PklEBof3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 280BBC4CEE7;
	Wed, 23 Jul 2025 05:16:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753247798;
	bh=HKBdxFHd2Fnzdh7om7SCDsCnykJO+LhNS3bPVDbG4dU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PklEBof3iGvG2I4EQJBCuB9M8qE/pyrO9kzVY49KtOVe7K0DYzve0vTII7knw7ytj
	 8dhQcpWyCwndkgD0WVOsgnfgIplNGA88wMzAHjVlhUcuyG6rtZHJ6g/EFc2J8VPqjc
	 fydpbYuest7Hxy7suVjZ9a3gvOMyaD8kU32w99hQmuGP+zVzxRTkVWIBOO4APN9yF0
	 txQt5JBpCHE5cQw0QwQy26UJtuEYti1O2Ivl79Ko3Fz/APnuWK6xAj4fs9j3DVXgRq
	 cYhVG2SGeAfea+revGkKvq9WJEdLPMIbjohvyv7UCBN6/eq3/Z94IfvRRzlY92yKQx
	 NTmm6IcW7Bc5w==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang@kernel.org>,
	Gang Yan <yangang@kylinos.cn>
Subject: [PATCH mptcp-next 3/7] Add MPTCP client socket creation support
Date: Wed, 23 Jul 2025 13:16:15 +0800
Message-ID: <fde94cb13bec7e6cb22d191b71fe92e5f5a8d957.1753247666.git.geliang@kernel.org>
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

This patch extends the socket creation API to support Multipath TCP
(MPTCP) for client sockets:

1. Added an overloaded 'socket' method that accepts an 'mptcp' parameter
   to explicitly enable/disable MPTCP
2. Introduced a convenience method 'mptcpSocket()' for creating
   MPTCP-enabled client sockets using the unspecified protocol family by
   default

The changes maintain consistency with the existing socket API while
providing first-class support for MPTCP client sockets. The implementation
builds upon the foundation laid in previous patches, utilizing the socket0
infrastructure with MPTCP protocol support.

Co-Developed-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Geliang Tang <geliang@kernel.org>
---
 src/java.base/share/classes/sun/nio/ch/Net.java | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/src/java.base/share/classes/sun/nio/ch/Net.java b/src/java.base/share/classes/sun/nio/ch/Net.java
index aa3ed087d2c..cf5dbddc28c 100644
--- a/src/java.base/share/classes/sun/nio/ch/Net.java
+++ b/src/java.base/share/classes/sun/nio/ch/Net.java
@@ -491,6 +491,16 @@ static FileDescriptor socket(ProtocolFamily family, boolean stream) throws IOExc
         return IOUtil.newFD(socket0(preferIPv6, stream, false, FAST_LOOPBACK, false));
     }
 
+    static FileDescriptor socket(ProtocolFamily family, boolean stream, boolean mptcp) throws IOException {
+        boolean preferIPv6 = isIPv6Available() &&
+            (family != StandardProtocolFamily.INET);
+        return IOUtil.newFD(socket0(preferIPv6, stream, false, FAST_LOOPBACK, mptcp));
+    }
+
+    static FileDescriptor mptcpSocket() throws IOException {
+        return socket(UNSPEC, true, true);
+    }
+
     static FileDescriptor serverSocket() {
         return serverSocket(UNSPEC);
     }
-- 
2.48.1

