Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794216262;
	b=utSPuB8YdC+YoDlJZEOlSgD98CE0aJbi/yMO7/l0S/RqDWZHmlNHPz0dSg6D/a2BKU0k
	 yc432rvk0CHLa9bfjgB/iKge0bNOl4ehBOLe8GN7seKoGrCO6SzH0XSeMrWFiNj4mmtVB
	 PkbsuE9aoFqlxgjN2qwo2+D/pauS+rOQ6xivYmrXh3TnWo+1toix2kAxdgWqFXMGdGehx
	 cG55XKafqj+suDUab+EHOJJ1i4PUG/EqwHsRi3EMWGDMATTlKBrzJ5xZEwEzTjoeBqs36
	 TmYj18+hSBMVJNLARBRpXSmu45OVcoNryKcFz2ttrVpaB9g5ZYz0imx3HObZuxHtgLw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794216262;
	h=Received:DKIM-Signature:From:To:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=G08kbPvIyf7eqm25qFFDIscdysBw9bpxI/7rJVk/EY8=;
	b=2AJzT3ze6ccLnK4dZxOyMbR44faye5swiHYUvEizBk9AmTVJlEf9NohtShHxTNQIRh1j
	 WIceElhvkqwIXq2wgPNnZL8jlxGCSSvuCkB63dSyNs0bhKDb8VCEUNSlPfsHWZvap6E6Q
	 IILTeeBWKvCwYER3GpnBJEwnll4l1VG1inVkwCchqWFNmSrDspovBZCHvrmntzePinVsR
	 cAASHbMohTY2a8wQvbDeMA0qMffQEptefuFPBfp6kF9fUUDB1zEpn6UucoMwdwXtGhoD/
	 a/AvhjjYaXEh6AF10L/55sah9B+LnFva0mA7e31SBWVPZ5hDSM/sacutJJo8foA0/+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QJCxqCqr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 568B3606D807
	for <mptcp@lists.linux.dev>; Mon,  9 Nov 2026 09:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QJCxqCqr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BDC91F008A7
	for <mptcp@lists.linux.dev>; Mon,  9 Nov 2026 09:24:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794216262;
	bh=G08kbPvIyf7eqm25qFFDIscdysBw9bpxI/7rJVk/EY8=;
	h=From:To:Subject:Date:In-Reply-To:References;
	b=QJCxqCqrSniPkFX/Jni5GhiygPOIjwemkH5bmd2mBX8Pso2cIsTkqyJzexXvBOEST
	 016kAu5HxjNyEFRxAUeSPh+lTXrYzGLT8IVpPuSed8T/aWOyh1d88Ga96DcfLXCg4e
	 g6AKtJrGiRrMRQfX26H/LDFG4azoA8+g3SOH0dUeTwr1BQvLGFwxbJUhv3qOReezQs
	 56eqKyO5zI2YKKTQZVpacos283t/LqoOf4DNjHwMg4WyhGi5lQkfOcokNINf7d5VcX
	 VQciZQ6LoEjdKIeLLTUz25NHN/WLdt3LLkpldK8XXRKQEQ7amPxzxV/L/bb5TQ3cs4
	 bgHMumCBcpf/Q==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next v24 2/8] selftests: mptcp: connect: check TFO SIOCINQ overflow
Date: Mon,  9 Nov 2026 17:24:04 +0800
Message-ID: <7062643d703b5143ba7bd56bc819d7e7854fdc9b.1794215614.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1794215614.git.tanggeliang@kylinos.cn>
References: <cover.1794215614.git.tanggeliang@kylinos.cn>
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

When a TFO connection is accepted, the test polls MPTCP_INFO until the
MPTCP_INFO_FLAG_REMOTE_KEY_RECEIVED flag is set (using poll_timeout,
default 10s), ensuring the third ACK has been processed. It then checks
if SIOCINQ returns INT_MAX, which would indicate the regression where
mptcp_inq_hint() incorrectly returns INT_MAX for passive TFO connections.

Add SOL_MPTCP fallback definition for compatibility with older libc
headers. Handle ENOPROTOOPT and EOPNOTSUPP errors from getsockopt() to
skip the wait for TCP sockets or MPTCP sockets that fell back to TCP.
Print a warning if the remote key does not arrive within the timeout, but
continue with the SIOCINQ check rather than failing the test.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../selftests/net/mptcp/mptcp_connect.c       | 47 +++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c b/tools/testing/selftests/net/mptcp/mptcp_connect.c
index 178d98d91fea..da35a5ce1541 100644
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
@@ -1176,6 +1180,28 @@ static void maybe_close(int fd)
 		close(fd);
 }
 
+static int wait_for_remote_key(int fd)
+{
+	struct mptcp_info info;
+	socklen_t olen;
+	int elapsed = 0;
+
+	while (elapsed < poll_timeout || poll_timeout < 0) {
+		olen = sizeof(info);
+		if (getsockopt(fd, SOL_MPTCP, MPTCP_INFO, &info, &olen) < 0) {
+			/* Not an MPTCP socket (TCP or fallback), skip wait */
+			if (errno == ENOPROTOOPT || errno == EOPNOTSUPP)
+				return 0;
+			return -1;
+		}
+		if (info.mptcpi_flags & MPTCP_INFO_FLAG_REMOTE_KEY_RECEIVED)
+			return 0;
+		usleep(10000);
+		elapsed += 10;
+	}
+	return 1;
+}
+
 int main_loop_s(int listensock)
 {
 	struct sockaddr_storage ss;
@@ -1207,6 +1233,27 @@ int main_loop_s(int listensock)
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

