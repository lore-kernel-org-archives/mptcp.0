Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795783561;
	b=fHpQjt88h8lFOT7RWQ8bWen60Gunx4/PoFfAh1+IVdXToxK7zVO9ZA2Dnk4pjros07Nl
	 aiMZZqMLi25hNzNAYs9CCZnVH9O7Lew/VWwBUd/43PHmwd/ZyeSDzek2tuSrB15q1YFq1
	 THBX8vz+h/ume+qQYFQ2f/UoUJ9jRO4INY1J8R1hS7mF1Ks9eLMEwHMGYdxko8ZfSH2oM
	 bvuzczdAP3K7BRUBP7f+jOSSt1KF6bEC8pVQH4o2xo30ywnj7D4tWPNKHSAPPO5LeOTqw
	 NcmdKQyMcuHdDYY16Xb3cyKbwobmvj/piiWAitMfY4VfdZJNQao7XPzyYXqrCYgQJMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795783561;
	h=Received:DKIM-Signature:From:To:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=d9sp1bmXb1HBqgVShqnbCi7xlyxusRrhl8qj7nUiYsw=;
	b=yE3u47DMn1zAGeTPJ+wkFA9vXNWiLCH/nJBbIAMi162dfmWbEyZRW+PId8ZhDnDQVncK
	 sHF6XUzqN+SxylR2dcfYsoO5VmrCigThts/Btg6ozKtZnQ9KLYY/KJ7csn2foiyA959nc
	 AdFG74Roc+wKhZdQT7yCJoE1HG0fADco65d/EOBvz+EndsGVEFu5khlUac78MMPzdzCcX
	 eCBy1xblHy+xrvHK0KxsUsIm7SWjW6VcEjmepMiSGyX0TYbo/j/jgBu6OgbtJHcdMTCdK
	 xOnXnG2jkTZK62K2e7dfneS0cAZ5TeHk67v1ItNa1W3Ziih78R7cga/AiptTSkD6bHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eL3+1xFJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D686606A335
	for <mptcp@lists.linux.dev>; Fri, 27 Nov 2026 12:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eL3+1xFJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15AF11F00893
	for <mptcp@lists.linux.dev>; Fri, 27 Nov 2026 12:45:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795783560;
	bh=d9sp1bmXb1HBqgVShqnbCi7xlyxusRrhl8qj7nUiYsw=;
	h=From:To:Subject:Date:In-Reply-To:References;
	b=eL3+1xFJ/GELfyVW1LsxD1LWdiSSudUqEK1QzD91h4xgLGYpujsreZ4+STLzUUbv/
	 eEZ4kgWRvQn16Bsp79tMQD1KLm/y9OcwifT03aUFiaouEg+lgV2NBXz2vnDPTuj5gw
	 w5VDyN0sc/DjyMqcdMcgcB6DYeOEnFmsQzQ/6sQ+ro3coelWHjscO/HN6O1ktZ1fRo
	 oUh4tTPhnm1tgbAtMBTrV5MJdOnWFDrs/vUhKVP6MvXc3ITmLSSj2d4a4NAP5Qt3aj
	 Dw5PatOuMFN2oOznEpGSDQqVNxXIqCItVlp1eEgWcizRC+lErS294zEGQmYYbqdvqw
	 k1IcPefu6vZVQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next v11 6/7] selftests: net: msg_zerocopy: add MPTCP support
Date: Fri, 27 Nov 2026 20:45:26 +0800
Message-ID: <3c4914ba16cf7712f0cda60f9d8ca1bc7d8e49ca.1795783388.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1795783388.git.tanggeliang@kylinos.cn>
References: <cover.1795783388.git.tanggeliang@kylinos.cn>
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
MPTCP connections by specifying "mptcp" as the test mode. A new
"check" mode is also added to verify that MPTCP and its zerocopy
support are available before running the tests.

A fallback definition for IPPROTO_MPTCP (262) is provided for systems
with older headers that do not include it.

Usage example:
    ./msg_zerocopy -4 -t 1 -D 127.0.0.1 mptcp
    ./msg_zerocopy -4 -t 1 -D 127.0.0.1 -z mptcp

msg_zerocopy.sh is updated to run IPv4 and IPv6 MPTCP tests in the
default test suite, skipping them if MPTCP is not supported.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/msg_zerocopy.c  | 27 +++++++++++++++++++++
 tools/testing/selftests/net/msg_zerocopy.sh | 13 +++++++---
 2 files changed, 37 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/msg_zerocopy.c b/tools/testing/selftests/net/msg_zerocopy.c
index 1d5d3c4e7e87..8c7567c79198 100644
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
@@ -798,6 +803,24 @@ static void parse_opts(int argc, char **argv)
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
+		if (setsockopt(fd, SOL_SOCKET, SO_ZEROCOPY,
+			       &val, sizeof(val))) {
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
@@ -820,6 +843,10 @@ int main(int argc, char **argv)
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

