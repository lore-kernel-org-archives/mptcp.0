Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794305512;
	b=jDenxJcYaDg2a9IM0VJQiN6KimFy2d9KN1J/dL02gR5oMyi4tsxcIaCLyjFaDi1Xl9r7
	 iv17w++zcTICuESqhG59buh+HP25R4gepiq6nG95m1TwzORlu9ysE9ic5ynoCDsR+OUnz
	 QqD8oUVL7d29+7mwzzkFquFRhX90jsEqgxhgYkpTbiXTw6TQ2ORKw1F4QvGq4etmtYAvE
	 Y8jadN2bheXN3r5Zt4CkPEoVGZSSnt5R7dyR4iiuwvjjdp8uh+YGbWQYGyZBiE878ckTo
	 jFFIvq/271XP/azyuziFV8BWYvhbVocMoci2OCmLA8LfDPM3h6rwFYRz9Pjye8MBh9w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794305512;
	h=Received:DKIM-Signature:From:To:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=P3rVcv0f6ipvWmWRcOlC9OQYmBwG+XFf5XCqB/ypUGY=;
	b=CGNUvWr4p1WT1/f5mwIabx1ov3FFam5dhFdN2aTv7QKbYOcP6pkJlsAgzgBUtC57JViu
	 JynC4YmF+PukYcuFGMPOCZGrVdA1u0+GRinfOt4N0rAhW6nYh1WoxQoSSoSiyNKR8Bj0r
	 CKMbG7FdzGP8ZGXHoudY3Yercp4T3JhR7epAIB2RjdccIA0Skvj4uJuK88tYwCDcFqseq
	 i+gRhCuSA3LSIXyEyR2NjUDPSoBdQkqe1KljdSG45jbe98NUmU63eektECOB1O88fP/bB
	 H1Z82t6Hg21tVd0PwxBjfzZSzS4hc7RSlvgnbJ3Ify32WQk2SGdnylt0MgF5UXy6+PQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c85KuYPb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45010606A33C
	for <mptcp@lists.linux.dev>; Tue, 10 Nov 2026 10:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c85KuYPb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91F7C1F0089F
	for <mptcp@lists.linux.dev>; Tue, 10 Nov 2026 10:11:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794305512;
	bh=P3rVcv0f6ipvWmWRcOlC9OQYmBwG+XFf5XCqB/ypUGY=;
	h=From:To:Subject:Date:In-Reply-To:References;
	b=c85KuYPbbYK0Uv2ytk5/vRejtfvh/wLfmfG9EXgQ0ls82lh38HvkxrfCLNmx1zMKE
	 UqWQQ2hUPsvIpN2Fsf1VQOmjd/f4pxp7mEHxjam0r2c6WACjYsoMozGlqVKrlLhBqi
	 AdvKucXN6o0yL6U/iJ5aboF6+hW8LgpAMTrypAt5chZ4Be88Bizh/spd2MAj0lNfcT
	 q6zIKqOwYriWjSMA1wXlbzwxK8d4/qatBuwqOJP5fpYqEdg9O/bPtSy7jahGEX59MV
	 CDPnGKZW/QLIUYS/MomZwAPH3MxGClJpa1l0knrQcFI8p1H1Zt8sZJc5gUQbyo6QdS
	 tkBE4Jz/et/Wg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next v25 2/8] selftests: mptcp: connect: check TFO SIOCINQ overflow
Date: Tue, 10 Nov 2026 18:11:41 +0800
Message-ID: <58a7c022d24c1fcbcba1dcafc62182ada49f5f35.1794304840.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1794304840.git.tanggeliang@kylinos.cn>
References: <cover.1794304840.git.tanggeliang@kylinos.cn>
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

Add a SIOCINQ check in mptcp_connect's server mode when the MPTFO socket
option is enabled to detect TFO SIOCINQ overflow regressions.

When a TFO connection is accepted, the test waits for the
MPTCP_INFO_FLAG_REMOTE_KEY_RECEIVED flag using poll(), ensuring the third
ACK has been processed. Using poll() instead of usleep() allows immediate
detection of dead connections via POLLHUP/POLLERR, preventing infinite
loops when the connection is reset or the client exits early. The wait
is bounded by poll_timeout (default 10s). It then checks if SIOCINQ
returns INT_MAX, which would indicate the regression where mptcp_inq_hint()
incorrectly returns INT_MAX for passive TFO connections.

Add SOL_MPTCP fallback definition for compatibility with older libc
headers. Handle ENOPROTOOPT and EOPNOTSUPP errors from getsockopt() to
skip the wait for TCP sockets or MPTCP sockets that fell back to TCP.
Print a warning if the remote key does not arrive within the timeout, but
continue with the SIOCINQ check rather than failing the test.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../selftests/net/mptcp/mptcp_connect.c       | 60 +++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c b/tools/testing/selftests/net/mptcp/mptcp_connect.c
index 178d98d91fea..5b002dad25d7 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
@@ -34,6 +34,7 @@
 #include <linux/time_types.h>
 #include <linux/sockios.h>
 #include <linux/compiler.h>
+#include <linux/mptcp.h>
 
 extern int optind;
 
@@ -43,6 +44,9 @@ extern int optind;
 #ifndef TCP_ULP
 #define TCP_ULP 31
 #endif
+#ifndef SOL_MPTCP
+#define SOL_MPTCP 284
+#endif
 
 static int  poll_timeout = 10 * 1000;
 static bool listen_mode;
@@ -1176,6 +1180,41 @@ static void maybe_close(int fd)
 		close(fd);
 }
 
+static int wait_for_remote_key(int fd)
+{
+	struct mptcp_info info;
+	int timeout_ms = 10;
+	struct pollfd pfd;
+	int elapsed = 0;
+	socklen_t olen;
+	int ret;
+
+	pfd.fd = fd;
+	pfd.events = 0;
+
+	while (elapsed < poll_timeout || poll_timeout < 0) {
+		ret = poll(&pfd, 1, timeout_ms);
+		if (ret < 0)
+			return -1;
+
+		if (pfd.revents & (POLLHUP | POLLERR))
+			return -1;
+
+		olen = sizeof(info);
+		if (getsockopt(fd, SOL_MPTCP, MPTCP_INFO, &info, &olen) < 0) {
+			/* Not an MPTCP socket (TCP or fallback), skip wait */
+			if (errno == ENOPROTOOPT || errno == EOPNOTSUPP)
+				return 0;
+			return -1;
+		}
+		if (info.mptcpi_flags & MPTCP_INFO_FLAG_REMOTE_KEY_RECEIVED)
+			return 0;
+
+		elapsed += timeout_ms;
+	}
+	return 1;
+}
+
 int main_loop_s(int listensock)
 {
 	struct sockaddr_storage ss;
@@ -1207,6 +1246,27 @@ int main_loop_s(int listensock)
 		check_sockaddr(pf, &ss, salen);
 		check_getpeername(remotesock, &ss, salen);
 
+		if (cfg_sockopt_types.mptfo) {
+			int ret = wait_for_remote_key(remotesock);
+			int avail;
+
+			if (ret < 0) {
+				perror("TFO: getsockopt(MPTCP_INFO)");
+				close(remotesock);
+				return 1;
+			}
+			if (ret > 0)
+				fprintf(stderr,
+					"TFO: timeout waiting for remote key\n");
+
+			if (ioctl(remotesock, SIOCINQ, &avail) == 0 &&
+			    avail == INT_MAX) {
+				fprintf(stderr, "TFO SIOCINQ overflow\n");
+				close(remotesock);
+				return 1;
+			}
+		}
+
 		if (cfg_input) {
 			fd = open(cfg_input, O_RDONLY);
 			if (fd < 0)
-- 
2.55.0

