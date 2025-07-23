Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A785A79B
	for <mptcp@lists.linux.dev>; Wed, 23 Jul 2025 05:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753247795; cv=none; b=PMjDN2blf11IKXqrEpqGEG2rzchzQoQqUoN3jl8589Zzm5bYd1qj1o6INnYm3k8ysGwW3xWiZolCmfGsH6bQUWiksFH7QX0kGUpFSRYuo3Sn4iyY1SeAvtM+BOYSwmKlo7hVpSe5pA0jBwILYYg8navx3Rh2SxWSxduAiRONPUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753247795; c=relaxed/simple;
	bh=xc9U11UBnbeSI6fbUP2/mZN476PSQJQAPSySV5iS3uE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pni/iylHqjutXTjxjcxAKyF2gWZhj6Wr+iXtorhFpE23oBfhQAyVBBvHpnzB5XGTZzQY9bTHUfw/H1UJxa0Jk2DmBq1QzafLkIf8vEb/uN/oJSiMTktSIQz7eFc+fai024qHkx9NiN30aRAq8MAq3k/PZ0LOQaVzuWeb/Vfl7t0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=scWBUh5r; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="scWBUh5r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B483BC4CEE7;
	Wed, 23 Jul 2025 05:16:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753247795;
	bh=xc9U11UBnbeSI6fbUP2/mZN476PSQJQAPSySV5iS3uE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=scWBUh5rPn0nqcNev4lTUUch+IPeRLiH5YEikjFM5MnYmUD9MSJZdV0ZuNadDVz2N
	 G21AYKpMJSLsVy/OW1p8J9Wr1SRTSB+5Y/4WJY8xfVyyCj1g70rynQ9jEszGRqBu0Z
	 ryqYJv/J0a4eTmnXPyBeo5+t2wccUdR1/6hURKE55mPoY44l14BKioLC7kkGPeEeck
	 PYDWw9wedjcLlZh6vH9OfH66K5DBN/Q/Qp7q/YoLikbVJpW1YpkkmO9QHycd6eFl3y
	 qYcEgVSPFShLb8ak7TMkCjXghxrJg62QRqDnUcDRYGkUjhp32vPkrK2et59i60XdKW
	 YV3WpyWl+iOyA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang@kernel.org>,
	Gang Yan <yangang@kylinos.cn>
Subject: [PATCH mptcp-next 2/7] Add MPTCP server socket creation support
Date: Wed, 23 Jul 2025 13:16:14 +0800
Message-ID: <931ce3edf07175a81607cfb0c00319c262462bc5.1753247666.git.geliang@kernel.org>
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

This patch introduces new methods to create server sockets with Multipath
TCP (MPTCP) support:

1. Added an overloaded 'serverSocket' method that accepts an 'mptcp'
   parameter to enable MPTCP
2. Added a convenience method 'mptcpServerSocket()' for creating
   MPTCP-enabled server sockets using the unspecified protocol family by
   default

The changes maintain backward compatibility while providing explicit MPTCP
support for server socket creation. The new methods leverage the existing
socket0 infrastructure with the MPTCP flag added in the previous patch.

Co-Developed-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Geliang Tang <geliang@kernel.org>
---
 src/java.base/share/classes/sun/nio/ch/Net.java | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/src/java.base/share/classes/sun/nio/ch/Net.java b/src/java.base/share/classes/sun/nio/ch/Net.java
index c086429380b..aa3ed087d2c 100644
--- a/src/java.base/share/classes/sun/nio/ch/Net.java
+++ b/src/java.base/share/classes/sun/nio/ch/Net.java
@@ -501,6 +501,16 @@ static FileDescriptor serverSocket(ProtocolFamily family) {
         return IOUtil.newFD(socket0(preferIPv6, true, true, FAST_LOOPBACK, false));
     }
 
+    static FileDescriptor serverSocket(ProtocolFamily family, boolean mptcp) {
+        boolean preferIPv6 = isIPv6Available() &&
+            (family != StandardProtocolFamily.INET);
+        return IOUtil.newFD(socket0(preferIPv6, true, true, FAST_LOOPBACK, mptcp));
+    }
+
+    static FileDescriptor mptcpServerSocket() {
+        return serverSocket(UNSPEC, true);
+    }
+
     // Due to oddities SO_REUSEADDR on Windows reuse is ignored
     private static native int socket0(boolean preferIPv6, boolean stream, boolean reuse,
                                       boolean fastLoopback, boolean mptcp);
-- 
2.48.1

