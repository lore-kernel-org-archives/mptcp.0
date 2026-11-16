Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794826673;
	b=3q8LtIk+q6sa5kVSPh/Hd6T3KPyntjKLgU7H8w0dItNZub+ChONrW21KsLlbCd8iJBzx
	 4DFVjRjcUBzEKwLO1OZnSX7at3m6PtY1kFIpoGpdSNlI5ZyAwFdIHe1heK8dMz7LiGw9g
	 B/3tkpSSQzbiFkgU/B8peU+GA0UvqTE9pd5Nfw1ZjyEIN9+QJzoxv7lOfwGyMfWLmy0gP
	 +JQvApFMPcMrHaNDy5k6FBO1JgUCqWkykd8jzrdDZqIWZ0F5y7AmV0nks7QfWwzKGKO1j
	 ZlsnGV+15UEb6Xf6dmiNdryD8e3pRQShH1gvuPepYvzXha+cTvDUZg7ysBvxai1WNlA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794826673;
	h=Received:DKIM-Signature:From:To:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=7LgiBru0mjL0OjE8R3tct2VIqF1RERVCx0c9hHIqr3A=;
	b=PKp64mgPd0RaGyAOZM9+Uwj1jlacR9FrHG4adcgp82VnFV0QNnEJuneFIPEmKhIj0JQi
	 46tdpuhHJFlcZLkrSYjkIx6+tKs7MVwXmHe0UeA+xXqyNFoGTGE3uLdA++G8EA1iTp1qW
	 IWgPVnG/ycjn2d0zyLUFN3XHuqFz0Hh/8BTVm/p4LzJY7Z1AUtVEaj0iOYtBGdhKsPkpS
	 gguWfZ/iUi8BB0ORQ7w8M7KB8gKybDk/KhtXvveDyePAWmER+WpaeiYQIoMR6ZSAO3kNc
	 ECSh5rQuOeNeZVjZtO5J1R0W6ANvpm9dzVpghljU2uRYH60/hVSpfcQyHOewNP6SS9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=azrEcsxi;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86377606A32F
	for <mptcp@lists.linux.dev>; Mon, 16 Nov 2026 10:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=azrEcsxi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61D311F000CD
	for <mptcp@lists.linux.dev>; Mon, 16 Nov 2026 10:57:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794826673;
	bh=7LgiBru0mjL0OjE8R3tct2VIqF1RERVCx0c9hHIqr3A=;
	h=From:To:Subject:Date:In-Reply-To:References;
	b=azrEcsxirFjDXbQ976azwnGCTa5Xi1GrU8N/OuztrFVf9i9JrEij90fivHiJB5ofm
	 iXl1hFvGQO0Cyf/gBmIHpQM/SJnNczX8j7KlDvljnNaAQMWpTle8SINydKsnJeHWYt
	 gHwxRXWDS4Hx+eMPpvh27bvn8p+icomkzwoLTuDyMT7Qx3UZrnTqhSlstjvTGthCdR
	 G3L6CbrK9MJ8HdBAkPLLdeIc8El+7xbrAJ+fgwu5QzJTQxWcsPoINSaGTC6Bud9LT1
	 BxZ5JbZsVCR1EW9tEHG3kpDRSyrfLr+udHxLqnYtaFvaj2W3Ymesq9iT+NIN18enDB
	 iCCSMunpI18eA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next v8 2/7] selftests: mptcp: connect: check TFO SIOCINQ overflow
Date: Mon, 16 Nov 2026 18:57:40 +0800
Message-ID: <297fb247e71d06c3c496de844410be5dd0dd1fd0.1794826541.git.geliang@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1794826541.git.geliang@kernel.org>
References: <cover.1794826541.git.geliang@kernel.org>
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

Add a SIOCINQ check in mptcp_connect's server mode when MPTFO is enabled
to detect TFO SIOCINQ overflow regressions.

Wait for MPTCP_INFO_FLAG_REMOTE_KEY_RECEIVED using poll() bounded by
poll_timeout, then check if SIOCINQ returns INT_MAX. Use poll() instead
of usleep() to detect dead connections via POLLHUP/POLLERR. Add SOL_MPTCP
fallback definition and handle ENOPROTOOPT/EOPNOTSUPP errors to skip the
wait for TCP or fallback sockets. Skip SIOCINQ check on timeout rather
than failing the test.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../selftests/net/mptcp/mptcp_connect.c       | 64 +++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c b/tools/testing/selftests/net/mptcp/mptcp_connect.c
index 178d98d91fea..143d8177b5a3 100644
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
@@ -1176,6 +1180,48 @@ static void maybe_close(int fd)
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
+	fprintf(stderr,
+		"TFO: timeout waiting for remote key, skip SIOCINQ check\n");
+	return 1;
+}
+
 int main_loop_s(int listensock)
 {
 	struct sockaddr_storage ss;
@@ -1207,6 +1253,24 @@ int main_loop_s(int listensock)
 		check_sockaddr(pf, &ss, salen);
 		check_getpeername(remotesock, &ss, salen);
 
+		if (cfg_sockopt_types.mptfo) {
+			int ret, avail;
+
+			ret = wait_for_remote_key(remotesock);
+			if (ret < 0) {
+				close(remotesock);
+				return 1;
+			}
+
+			if (ret == 0 &&
+			    ioctl(remotesock, SIOCINQ, &avail) == 0 &&
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

