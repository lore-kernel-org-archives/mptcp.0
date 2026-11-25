Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795591400;
	b=yNr7jGon3Adq9rMafY/LLolwDfmcE3rYFcsFS04pDyXDNeZdSGo7sRkHuU7KQkCkoqCQ
	 wABbVrNLV00kTfg5utixLy+T3S2ASgHiXrlaRlFOl7dLAYITYEf2cLZ9rOyvUO5VePM8y
	 Uf2EizvVKhS5sleW7VGolznyq/hVRa0Rsz5Uvv3PwTBTgJve3V10HAZW7rnyxEv0EvSfy
	 mPuhfY9fh7QMja65ojag5drovgpcUNSUptH8vynPOcrrA7hJuduWiqNY8C/dqq90S7xdS
	 3pIQU/0Vcol5E5uuKOXYnqF7fe2K+w0CYOaI6g1y9U2KdZThKrjvLts5XQiDN0T89bg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795591400;
	h=Received:DKIM-Signature:From:To:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=b1F4oS/9/exHRaymS8w8p0aV3xtEE/2doKFZDURiMn8=;
	b=FMV0aPLORH72V7b/CpIbJwEiDK//fpwf7TA+SIf8MhWQmE3ahZ1pRgnMTbUOhNOmINK5
	 OtrtRw+Ot9ErR20FtMSXLqP9gEAayQqLfFWBpjwl75vkqgim6XJYPThlcqT9bJlR9b94X
	 Ex9JD4kmNjvsn0uXNl77NqOtc6HzQBua4jiFCL/gnfn/hhclU//EDsn6PTHvZo6rDIsH0
	 UzVxE8TjwIDv/OewrXv7vASWUpgs2GqVsH5AIa2KcWIH1xT846IziJiTdmKFfVquyBKvj
	 A3W52D+RBcCh1l2Tu4oONQ/wB5gq8xQfPGy0g34quA3UavwaRb3BdEWfEhV7zOq5i8w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ilvEQzvX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58FEE606A31E
	for <mptcp@lists.linux.dev>; Wed, 25 Nov 2026 07:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ilvEQzvX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 081101F000CA
	for <mptcp@lists.linux.dev>; Wed, 25 Nov 2026 07:23:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795591399;
	bh=b1F4oS/9/exHRaymS8w8p0aV3xtEE/2doKFZDURiMn8=;
	h=From:To:Subject:Date:In-Reply-To:References;
	b=ilvEQzvXmIDLAE/lISghlovZQSDFXWcFIorICIshAcV+8RbZ85X0xvAQpv81O2zaO
	 oW1PQTKawmS/D/GJMaXcjaNfdV2OZzDIYBOpGJV/XoZmxIpDT5I8Hr9Gn7hEDNXTDS
	 WxmwWUhxHpTNjJFlXwjlKq+/toBBRefngCyDjO12LZ6WPSNVKrXHT2jTD36bytmJwa
	 cUQGnI1VRD7JKAh0DWBo1M8HJxAwwWATpuqNt5nexySl7ec3/yeWhj6m8Ye9Ypeemv
	 Ij2PmvW7GZm9V2Ja810tC6yvPjjj/z1IUu9TrgGLwqD55ZvBrbvAoALTy2b2H344BT
	 VUiC435EpP6yA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next v9 6/7] selftests: net: msg_zerocopy: add MPTCP support
Date: Wed, 25 Nov 2026 15:23:04 +0800
Message-ID: <89bb061e82fa0cf48cf44697041947bf9c99b110.1795591278.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1795591278.git.tanggeliang@kylinos.cn>
References: <cover.1795591278.git.tanggeliang@kylinos.cn>
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
 tools/testing/selftests/net/msg_zerocopy.c  | 6 ++++++
 tools/testing/selftests/net/msg_zerocopy.sh | 8 +++++---
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/msg_zerocopy.c b/tools/testing/selftests/net/msg_zerocopy.c
index 1d5d3c4e7e87..3a130f80d662 100644
--- a/tools/testing/selftests/net/msg_zerocopy.c
+++ b/tools/testing/selftests/net/msg_zerocopy.c
@@ -74,6 +74,10 @@
 #define MSG_ZEROCOPY	0x4000000
 #endif
 
+#ifndef IPPROTO_MPTCP
+#define IPPROTO_MPTCP	262
+#endif
+
 static int  cfg_cork;
 static bool cfg_cork_mixed;
 static int  cfg_cpu		= -1;		/* default: pin to last cpu */
@@ -816,6 +820,8 @@ int main(int argc, char **argv)
 		do_test(cfg_family, SOCK_RAW, IPPROTO_RAW);
 	else if (!strcmp(cfg_test, "tcp"))
 		do_test(cfg_family, SOCK_STREAM, 0);
+	else if (!strcmp(cfg_test, "mptcp"))
+		do_test(cfg_family, SOCK_STREAM, IPPROTO_MPTCP);
 	else if (!strcmp(cfg_test, "udp"))
 		do_test(cfg_family, SOCK_DGRAM, 0);
 	else if (!strcmp(cfg_test, "rds"))
diff --git a/tools/testing/selftests/net/msg_zerocopy.sh b/tools/testing/selftests/net/msg_zerocopy.sh
index 28178a38a4e7..83424758c452 100755
--- a/tools/testing/selftests/net/msg_zerocopy.sh
+++ b/tools/testing/selftests/net/msg_zerocopy.sh
@@ -31,6 +31,8 @@ if [[ "$#" -eq "0" ]]; then
 	$0 6 tcp -t 1 || ret=1
 	$0 4 udp -t 1 || ret=1
 	$0 6 udp -t 1 || ret=1
+	$0 4 mptcp -t 1 || ret=1
+	$0 6 mptcp -t 1 || ret=1
 
 	[[ "$ret" == "0" ]] && echo "OK. All tests passed"
 	exit $ret
@@ -38,7 +40,7 @@ fi
 
 # Argument parsing
 if [[ "$#" -lt "2" ]]; then
-	echo "Usage: $0 [4|6] [tcp|udp|raw|raw_hdrincl|packet|packet_dgram] <args>"
+	echo "Usage: $0 [4|6] [tcp|udp|mptcp|raw|raw_hdrincl|packet|packet_dgram] <args>"
 	exit 1
 fi
 
@@ -143,8 +145,8 @@ do_test() {
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

