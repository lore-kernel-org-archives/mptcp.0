Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795754232;
	b=35ZZjU3xyCc0sapoMfYCylxdAYUfFhRL+ZFJOKjqQYGQ6QVVqPxxevMkO62cTGoNgW3Q
	 nnaZ3776/7pR3XTWtTpAZMuL3bJd3oxf6COJ2F6cMhNonVMoVVEjXh9ZmzaeZ2+Ab6GVC
	 AW/D9DcND6INhGgEaeVw6Jue4Fx5chQVifyc/E5UTjguD7vXpXT7hJJrNSpexP6ZNs0kW
	 SiX+1ihQdWMm7gsfz1kZrYkqmGsJ1A5pFFcG3Bqg+WlIxWhepg0Bn8szEW6VI3CdDCYKb
	 wQowfi1/rgK5OtIFGv6LyTgY20bU8ppTsYgb+1wRT4muCKVXkrbbppUcZ4wVgYpAa1A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795754232;
	h=Received:DKIM-Signature:From:To:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=TpCgXcv2buC/XlXM5isz6CQ+WKX8k3YEw+xp2EmMZ5U=;
	b=nQkAuNImkZdbVe5BS6FVEktnys7paGIclRWVbdrZa9MCGF7BLSEaNlm246sWi4ar7g+1
	 la2o9fBtGJ+sOtzOiYYa1Mv6bJsnrcoW6Euy5gqBwTx7QdtJcmP9N7FHgA3zV9G1+wG5Q
	 QGaNu1wa7g1WI8vpBUp8DXa0HJRZf5NRP3BG4iWcIBUQlGDaOh3sRHUdXSDeUpTY4g8Mx
	 093NJ2SktdsYwWdj8XNM05LSO2PR4MpUNl4omuMnFPuXE/iH1MYyQmHLAMxHTI0JxNE4y
	 3WuugNIgpXYEVdTc5PEf/CRWeW/ULbZA7IM5Zg1MJ3GZgtKPKPPL1e4a1VHxhEo60FA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J34ORlDI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72052606A31C
	for <mptcp@lists.linux.dev>; Fri, 27 Nov 2026 04:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J34ORlDI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD58F1F00893
	for <mptcp@lists.linux.dev>; Fri, 27 Nov 2026 04:37:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795754231;
	bh=TpCgXcv2buC/XlXM5isz6CQ+WKX8k3YEw+xp2EmMZ5U=;
	h=From:To:Subject:Date:In-Reply-To:References;
	b=J34ORlDIRDvV3ZW4+Yo5Fjsp6A7QMyMqC/yA4OdvHqUVTz4CEtIGCU8LydsHJWjnW
	 Sry8xzc9L6PILkCLtRQKVG/YCdyJqlOIGTTi0YkjE8bXsXDWsvO2C7KmToorrTFTo4
	 M3KjIotjRGLdCNBRAOa4oFsjf0ZG2Y4DV0TeeqPp4Va0owODag3t+O7k0Ew4m5erl5
	 wf7cDqzKgAZf9c9OX1oSS/MxlEEt52J4vCPawCPseQHD6cxdp+xtGYBCdNPolxuwOW
	 4Dw/SRjnGX4HuVVQCIzFrSPY/YFq5Tl8CveyE7cZw9TQ6DfATGZrAjox45lfYI0e6Y
	 9JnVrM7KY1Uog==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next v10 6/7] selftests: net: msg_zerocopy: add MPTCP support
Date: Fri, 27 Nov 2026 12:36:19 +0800
Message-ID: <be1e8fd2a6bd2d6a8e634c383ea10dfbdbe8281c.1795753727.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1795753727.git.tanggeliang@kylinos.cn>
References: <cover.1795753727.git.tanggeliang@kylinos.cn>
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

Add support for testing MSG_ZEROCOPY over MPTCP sockets. This enables
the existing msg_zerocopy test to exercise the zerocopy send path on
MPTCP connections by specifying "mptcp" as the test mode.

A fallback definition for IPPROTO_MPTCP (262) is provided for systems
with older headers that do not include it.

Usage example:
    ./msg_zerocopy -4 -t 1 -D 127.0.0.1 mptcp
    ./msg_zerocopy -4 -t 1 -D 127.0.0.1 -z mptcp

msg_zerocopy.sh script is also updated to automatically run IPv4 and IPv6
MPTCP tests in the default test suite.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/msg_zerocopy.c  | 26 +++++++++++++++++++++
 tools/testing/selftests/net/msg_zerocopy.sh | 13 ++++++++---
 2 files changed, 36 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/msg_zerocopy.c b/tools/testing/selftests/net/msg_zerocopy.c
index 1d5d3c4e7e87..c48804592ef2 100644
--- a/tools/testing/selftests/net/msg_zerocopy.c
+++ b/tools/testing/selftests/net/msg_zerocopy.c
@@ -5,6 +5,7 @@
  *
  * PF_INET/PF_INET6
  * - SOCK_STREAM
+ * - SOCK_STREAM with IPPROTO_MPTCP
  * - SOCK_DGRAM
  * - SOCK_DGRAM with UDP_CORK
  * - SOCK_RAW
@@ -74,6 +75,10 @@
 #define MSG_ZEROCOPY	0x4000000
 #endif
 
+#ifndef IPPROTO_MPTCP
+#define IPPROTO_MPTCP	262
+#endif
+
 static int  cfg_cork;
 static bool cfg_cork_mixed;
 static int  cfg_cpu		= -1;		/* default: pin to last cpu */
@@ -798,6 +803,23 @@ static void parse_opts(int argc, char **argv)
 		usage(argv[0]);
 }
 
+static void check_mptcp_support(int family, bool zerocopy)
+{
+	int fd = socket(family, SOCK_STREAM, IPPROTO_MPTCP);
+	int val = 1;
+
+	if (fd == -1)
+		exit(1);
+	if (zerocopy) {
+		if (setsockopt(fd, SOL_SOCKET, SO_ZEROCOPY, &val, sizeof(val))) {
+			close(fd);
+			exit(1);
+		}
+	}
+	close(fd);
+	exit(0);
+}
+
 int main(int argc, char **argv)
 {
 	const char *cfg_test;
@@ -820,6 +842,10 @@ int main(int argc, char **argv)
 		do_test(cfg_family, SOCK_DGRAM, 0);
 	else if (!strcmp(cfg_test, "rds"))
 		do_test(PF_RDS, SOCK_SEQPACKET, 0);
+	else if (!strcmp(cfg_test, "check"))
+		check_mptcp_support(cfg_family, cfg_zerocopy);
+	else if (!strcmp(cfg_test, "mptcp"))
+		do_test(cfg_family, SOCK_STREAM, IPPROTO_MPTCP);
 	else
 		error(1, 0, "unknown cfg_test %s", cfg_test);
 
diff --git a/tools/testing/selftests/net/msg_zerocopy.sh b/tools/testing/selftests/net/msg_zerocopy.sh
index 28178a38a4e7..a9cb6b449f34 100755
--- a/tools/testing/selftests/net/msg_zerocopy.sh
+++ b/tools/testing/selftests/net/msg_zerocopy.sh
@@ -32,13 +32,20 @@ if [[ "$#" -eq "0" ]]; then
 	$0 4 udp -t 1 || ret=1
 	$0 6 udp -t 1 || ret=1
 
+	if ${BIN} -4 -t 1 check && ${BIN} -4 -t 1 check -z; then
+		$0 4 mptcp -t 1 || ret=1
+		$0 6 mptcp -t 1 || ret=1
+	else
+		echo "SKIP: MPTCP tests (not supported)"
+	fi
+
 	[[ "$ret" == "0" ]] && echo "OK. All tests passed"
 	exit $ret
 fi
 
 # Argument parsing
 if [[ "$#" -lt "2" ]]; then
-	echo "Usage: $0 [4|6] [tcp|udp|raw|raw_hdrincl|packet|packet_dgram] <args>"
+	echo "Usage: $0 [4|6] [tcp|mptcp|udp|raw|raw_hdrincl|packet|packet_dgram] <args>"
 	exit 1
 fi
 
@@ -143,8 +150,8 @@ do_test() {
 		-S "${SADDR}" -D "${DADDR}" ${ARGS} "${TXMODE}" -Z 0 || ret=1
 	wait
 
-	# next test is unconnected tx to dummy0, cannot exercise with tcp
-	[[ "${TXMODE}" == "tcp" ]] && return
+	# next test is unconnected tx to dummy0, cannot exercise with tcp/mptcp
+	[[ "${TXMODE}" == "tcp" || "${TXMODE}" == "mptcp" ]] && return
 
 	# tx-only test: send out dummy0
 	# packets leaving the host are not copied,
-- 
2.55.0

