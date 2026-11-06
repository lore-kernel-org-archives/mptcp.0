Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793969837;
	b=4ayUDXsW5K+1BI7ZSM4MGArAPVLZMLcmCoU1zFgXjz4wIylIWzwPYcWPQn4zlQfjM9Ix
	 9s4p5+lYgt0uQed9jv1SdSHPLN0HNn/OKFXBDhw+9hyrEqdiMoEIDV76oNje9ijJtmlUf
	 XB+A4ZSaQhAf6WVJGEy1d7HG+pABrCWmlXbS2/o1eBqw2ZB4alQcY9/LSh27PYs8g01tv
	 EWUGdQjn0KbSIkop6oCgWEtYjkXEg9M0/bUTNbaJztPrbpYktj9XcD/6oXn3n2ZSJ0lxW
	 1gdnGkfIv9+Idr6IKhzUkEwvIy+x3mrbJkqyk5WhyYpK/Td67oG5onhK2Pv7TH6SD1Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793969837;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Ay8umlFct+ivs/HD05o6+IC3tynHM9H2SGFaHkW/87Q=;
	b=cXkP6BCLqNd/U5RkJquAbXxB+09jhFDiAWh5NeAYhANNL8DmtBew3hk1gEvXr67mJSUy
	 ClwHsU0Uk5jPA9U/TLpUZ5fdehAT1n6VSB3NaaemZInBkBDZ8QDdl14EZH8fjZgEYd0fz
	 0/GjWPisl/vVpqSbI1vEIkkGRIsc6llsiJz8cj/3FBsVu5b7SCfuSqIOIHe0R0JDHnaCm
	 3Lc1n0+XEVv+81mdBk5IxH8cHrIfbdWVXgeQbd5g4HruJG3GfynYBVqhrnGpz6USoBuN8
	 asjapRQyyALh0uqwwznRx9b17gJqW6CezwwPxdPpbNSMcBizQTFtZktp9NT988UO8Ww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=io2Bobhq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F298606A33D
	for <mptcp@lists.linux.dev>; Fri,  6 Nov 2026 12:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=io2Bobhq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AC851F0089F;
	Fri,  6 Nov 2026 12:57:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793969837;
	bh=Ay8umlFct+ivs/HD05o6+IC3tynHM9H2SGFaHkW/87Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=io2BobhquCX4fH1RCk8NGPgdsqDe+lcegqykD85Ykn6EQhCE1oglOSkKFurmoinyf
	 UJd4HIddRxlJ6OQKc95/SOET6Zs3wrDDEqfYb+Tt00CIV3Z6QqCpIhqWDS2zATpDdh
	 q5owduPIPYdQ6ZMSAN721XE94RU7YbB1qRtREoP0bMgmFOPvcsWpemEmg460PrfpKt
	 jzsPAtS8YKW6Y0MkBSOPJMva6ELddNKG2sw4+Bt4iZu6i0USH91RtG6CT8UxDHmzbZ
	 PhUPF/Fr+H0GciBpn3Cup2o5oi3sfznn8X0rmJxZ7cKJIA+cV/CI//PS73emwXaD3h
	 RKAoxVVmWpemg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v23 2/8] selftests: mptcp: connect: check TFO SIOCINQ overflow
Date: Fri,  6 Nov 2026 20:57:04 +0800
Message-ID: <9705c8c5686aca72e8bbaea893587f92bdd3306d.1793969127.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1793969127.git.tanggeliang@kylinos.cn>
References: <cover.1793969127.git.tanggeliang@kylinos.cn>
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
MPTCP_INFO_FLAG_REMOTE_KEY_RECEIVED flag is set (with 100ms timeout),
ensuring the third ACK has been processed. It then checks if SIOCINQ
returns INT_MAX, which would indicate the regression where mptcp_inq_hint()
incorrectly returns INT_MAX for passive TFO connections.

Add SOL_MPTCP fallback definition for compatibility with older libc
headers. Handle ENOPROTOOPT error from getsockopt() to skip the wait
for TCP sockets or MPTCP sockets that fell back to TCP.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../selftests/net/mptcp/mptcp_connect.c       | 44 +++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c b/tools/testing/selftests/net/mptcp/mptcp_connect.c
index 178d98d91fea..3a72bae43b90 100644
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
 
+static bool wait_for_remote_key(int fd)
+{
+	struct mptcp_info info;
+	int retries = 10;
+	socklen_t olen;
+
+	while (retries > 0) {
+		olen = sizeof(info);
+		if (getsockopt(fd, SOL_MPTCP, MPTCP_INFO, &info, &olen) < 0) {
+			/* Not an MPTCP socket (TCP or fallback), skip wait */
+			if (errno == ENOPROTOOPT)
+				return true;
+			return false;
+		}
+		if (info.mptcpi_flags & MPTCP_INFO_FLAG_REMOTE_KEY_RECEIVED)
+			return true;
+		usleep(10000);
+		retries--;
+	}
+	return false;
+}
+
 int main_loop_s(int listensock)
 {
 	struct sockaddr_storage ss;
@@ -1207,6 +1233,24 @@ int main_loop_s(int listensock)
 		check_sockaddr(pf, &ss, salen);
 		check_getpeername(remotesock, &ss, salen);
 
+		if (cfg_sockopt_types.mptfo) {
+			int avail;
+
+			if (!wait_for_remote_key(remotesock)) {
+				fprintf(stderr,
+					"TFO: timeout waiting for third ACK\n");
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

