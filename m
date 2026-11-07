Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794053872;
	b=Bm9Yr4Dlwtc9OfEH3Z5FcuUpmSrq9+LdwpE6Pl3ZFoVOgHwPjVW7DcDCzJn3E9395Kbg
	 vVoX4rsPhPFPkDd7IvMnkNvLnczzxX6BNOJ1ptY5t+lJAZosuvGrwr6WaLeiKnKrjpCTU
	 EefEC95Wjc4m1AG41vOEo3I8PCHch5x7fNpUc7rqdiijS2NSyHu9hCwxraTBmZeoPucAF
	 KdJ2XN1KtAEf7tFsxh/QcGaRCnPC0LlaKqfKeEg34SgV5Kgv8bjVIZi/uBAGosvWkh79/
	 3byFCetp159e+W3+1ZvrgM5VudisodL633qvcgaPHY2nZGLtMJ8TI7EBpjOCMLaiSWw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794053872;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=3F0kmq67PoD39ijmTXZ0QbY+i7YfktR67JJcROh4SfA=;
	b=dj2KaAEytkQgHfOdsDM7IMVtPUbNM87Okk3SzJBLXYEYVVMk6hSIBU8VN3W7GX+T8ObM
	 tR/7MaXQXFA/fyuGH8bz4d61pioYlpM6N3i4Aih4JGr8Lw0ODJSZyEzwfF5nw0rHH81st
	 Ygsps6+g9APzMiSSYQR4U8irjuy4vw/HCnUZ5KMA7DYJjIjQ6Iz5Pyshuv28OiqjUC2Ns
	 8tsAzfwoQivBeJ1Q0r0/roRcqBvcel90ChMDsfltjukCVnipak8bu3d4blsOC7BX/lWpX
	 q4DE4MNRo8pZ7+Jqhb2B8mUBB9kt4xFq/JtH2gDcLsUV3fjJNmVMbzE6jTvpCpa8ovg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OYT2tPEb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 927BB606A331
	for <mptcp@lists.linux.dev>; Sat,  7 Nov 2026 12:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OYT2tPEb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72A441F008BD;
	Sat,  7 Nov 2026 12:17:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794053872;
	bh=3F0kmq67PoD39ijmTXZ0QbY+i7YfktR67JJcROh4SfA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OYT2tPEbu598B9q0Z1u4E/GUYSNc7THG6LnDGZIz0TTSt/ufj17FiQs8fTXXOJb7R
	 rqU6ZVrZxGxB5/q/qdAgrrh5XVonwXGeD/bHCkIwayPkLqnrmfplnPUiXghOSkwpYF
	 BPDlvR4d5naUbPL9io9JcysKWnXZBYd60V3G0V1q1HoujYUyZ6tyM3Dvc8WIoIwntC
	 7h4nyjLVENAkpTFFn9Vc+x9d/I/oj66J28PN3lqpnYbaF6fmSn1S6KJoXu8UGR3DXo
	 sY6jUlhY244sZHK8Pt+3ulrvjuUGGa/hG3TAwGCQuyxMCBWugONhUVvRwlIxUF9DVQ
	 vvOk1x9vWOb7w==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v7 2/7] selftests: mptcp: connect: check TFO SIOCINQ overflow
Date: Sat,  7 Nov 2026 20:17:15 +0800
Message-ID: <e09a65432d53e0ba14816efdd83b075b9681044f.1794053683.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1794053683.git.tanggeliang@kylinos.cn>
References: <cover.1794053683.git.tanggeliang@kylinos.cn>
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
headers. Handle ENOPROTOOPT and EOPNOTSUPP errors from getsockopt() to
skip the wait for TCP sockets or MPTCP sockets that fell back to TCP.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../selftests/net/mptcp/mptcp_connect.c       | 44 +++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c b/tools/testing/selftests/net/mptcp/mptcp_connect.c
index 178d98d91fea..f9f9c0201687 100644
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
+			if (errno == ENOPROTOOPT || errno == EOPNOTSUPP)
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

