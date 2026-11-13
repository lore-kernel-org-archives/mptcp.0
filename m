Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794563936;
	b=BwAkUfp/RM7nu1YcPuqdyenGyF3BKMV7f0dMcwpqXVPJSUpNGZTqj19h5PNJ+l/AUfFy
	 7rhQ7mtWrm6V/OliL5VoDd6ndTYEUYRtgkRoprqVUQP8irFqw9qzxPXoTiuq6pweCNkr7
	 h4SpXbirqXNZF/tOc+USbjyWHcSQVL8KjS8KqmaJm4N12PhGRMr8lch+jbp4XOPpofKG+
	 /RCAFSVgq0qNWNbcvAv+R31UJ8RbEi72nRrnVxTN8IrFhFFZoMaecqgYFchkwC8CdPRQt
	 sCXtHjTySTZN3M5npkRitdLY6W8pupMNLnG3INEyfS6UtyuFSYQfo41U/PfIVRhS/Dw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794563936;
	h=Received:DKIM-Signature:From:To:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=xE4S3cTlve8RX7XJCkdjvgdnj0+PjTmwVj3DJPkuYJE=;
	b=fhSxKp8GMJ18vAGewafYyEfZyWFlVP1bOS+lnC1aPVlLXM/AHx+qHozeYqcKLDdlxV2G
	 VIdKvE2pQlTa9c1bFBIq9Wy/hXz7Ffn0wF8Gl+jGAgMdDh2woozE61TRwOXJIOhKrt81A
	 tQ01sahMd1THaBMAVF7Qig6DxrbeBKZ9girRVL9T1ksLNjwyDOT04isO9atw1s131Q6+p
	 BEtg8PFRt7JjO2v0e1+qIi5R8rbfe+U/Lo8lyuh4TN736VZbKxaii03nvE7mbuPaMzFuG
	 AZHJAHfUSVBJS/QV54YzCmzzGDR5kuUbzEP/g30EmWFValnvK/aJtOcvPiAOsdMJk1Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QdpzuzM0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF3DF606A32A
	for <mptcp@lists.linux.dev>; Fri, 13 Nov 2026 09:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QdpzuzM0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C3E81F000C5
	for <mptcp@lists.linux.dev>; Fri, 13 Nov 2026 09:58:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794563936;
	bh=xE4S3cTlve8RX7XJCkdjvgdnj0+PjTmwVj3DJPkuYJE=;
	h=From:To:Subject:Date:In-Reply-To:References;
	b=QdpzuzM0D4QPsIN41p6eLKPHkQmpY4H9KO/AylGcNPlXKdP2rXFxMra5Nnaumkc5Y
	 Cb8zVJdLzLr+BewosFywPC1rRJIvzg0YZn+b6Y3CkhTpbNWKfdywDwT40HrDfpu19o
	 NlVN8Dac9fy8KfcotXavOfFuE+gB4L7lMrgII88XxJj7FgNkt1RkAxrULgLOGu/TlC
	 z1+cO6evS0NE10+IK/LwN6+rba4b81Q8ZmKQnSV6h0fd6iy8uEM55ngY0opmN9cC8J
	 Y/s0cxTEaBc6QYZADW5itcUnKYSMMcRExoGQSWLiq4eyX9PErTZKyJUK6y7mFCU6Gt
	 94jCIkdx6U4Eg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next v26 2/8] selftests: mptcp: connect: check TFO SIOCINQ overflow
Date: Fri, 13 Nov 2026 17:58:41 +0800
Message-ID: <4b9d85bac42429d8d566497d0f8f2c76ebb7e663.1794563432.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1794563432.git.tanggeliang@kylinos.cn>
References: <cover.1794563432.git.tanggeliang@kylinos.cn>
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
 .../selftests/net/mptcp/mptcp_connect.c       | 61 +++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c b/tools/testing/selftests/net/mptcp/mptcp_connect.c
index 178d98d91fea..152976d39d46 100644
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
@@ -1176,6 +1180,47 @@ static void maybe_close(int fd)
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
+		if (ret < 0) {
+			perror("TFO: poll");
+			return -1;
+		}
+
+		if (pfd.revents & (POLLHUP | POLLERR)) {
+			fprintf(stderr, "TFO: connection closed or reset\n");
+			return -1;
+		}
+
+		olen = sizeof(info);
+		if (getsockopt(fd, SOL_MPTCP, MPTCP_INFO, &info, &olen) < 0) {
+			/* Not an MPTCP socket (TCP or fallback), skip wait */
+			if (errno == ENOPROTOOPT || errno == EOPNOTSUPP)
+				return 0;
+			perror("TFO: getsockopt(MPTCP_INFO)");
+			return -1;
+		}
+		if (info.mptcpi_flags & MPTCP_INFO_FLAG_REMOTE_KEY_RECEIVED)
+			return 0;
+
+		elapsed += timeout_ms;
+	}
+	fprintf(stderr, "TFO: timeout waiting for remote key\n");
+	return 0;
+}
+
 int main_loop_s(int listensock)
 {
 	struct sockaddr_storage ss;
@@ -1207,6 +1252,22 @@ int main_loop_s(int listensock)
 		check_sockaddr(pf, &ss, salen);
 		check_getpeername(remotesock, &ss, salen);
 
+		if (cfg_sockopt_types.mptfo) {
+			int avail;
+
+			if (wait_for_remote_key(remotesock) < 0) {
+				close(remotesock);
+				return 1;
+			}
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

