Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06EFE17BB21
	for <mptcp@lists.linux.dev>; Mon, 22 Dec 2025 03:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766373351; cv=none; b=ep+lJCaBk3a89KoL3Nc/v9WWZJUvj8UkEXyNPzuzq5knd5t0iBLKvRmFS7XOLikw2pOyVTIr+OKOE5/CWAA7HcmHb+Bp6beb/06AhCKxSoCfrweQXQ6Dip8UA93LjGeHVm9wGABl1F+wcjNP8wYpX4UzMGJpZ/MNminFH6Gstq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766373351; c=relaxed/simple;
	bh=hqLrRvDMMJZpcjPlLzs8coyVAA3Qtzh4tJWAoYmZnyg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B7oUK3o7HkWRD+VYlV9Ns2IvRPO/4sNfJBpdGFVUF0A6yM2ThqVvsF5nLttO9gA9W6ZLvs6Aviz3CWNoDYDg5YRetCM5weXvbCeEYQLjfLwXp8mA6ilf+YA28hKyluWKQqNAsnjXNNh9Fgt3pDtKcrpNRO1ME5cyoKNAb50mlRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dWx12UwB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dWx12UwB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABD85C4CEFB;
	Mon, 22 Dec 2025 03:15:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766373350;
	bh=hqLrRvDMMJZpcjPlLzs8coyVAA3Qtzh4tJWAoYmZnyg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dWx12UwBLn/XxT1sH78+vxaA9p/x9Ttc22vztbbYyezQGa8Z6cA4KepmaZYihRd//
	 DrIWF0Fs+qSWO93p4VtkfSG+4lK+mMJb53eB2U7s4dzOzJhHVGsLiuTLJYJqqd8xGO
	 QU/Ikm1P/i0YF1aIhm1Uip9X+hh244hjeMi+uDozehhrNaOnNSi0p17tflknvh0gCY
	 b7SVmARKBzg3oTcpovWyTItpEmiFsSEU82CAFrAo+NvL2C2X4dFnzduO2d4bQbhlNL
	 Vz2NRG71VlNFZBtvSLGweWDqSjbeP0Nhkufb9YnxH9uMBpCqlAGF7IBqV8TpAgq4M4
	 2ElFM56OijEiw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next v5 8/8] selftests: tls: add a '--mptcp' test mode
Date: Mon, 22 Dec 2025 11:15:27 +0800
Message-ID: <d068c478192bc0ca8040f51dcb948eb93eb0e617.1766372799.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1766372799.git.tanggeliang@kylinos.cn>
References: <cover.1766372799.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Gang Yan <yangang@kylinos.cn>

Add a command-line parameter `--mptcp` that allows the TLS test program
to switch between using MPTCP and standard TCP. When the `--mptcp` flag
is provided, the test suite will utilize MPTCP connections; otherwise,
it defaults to standard TCP.

Signed-off-by: Gang Yan <yangang@kylinos.cn>
---
 tools/testing/selftests/net/tls.c | 56 +++++++++++++++++++++++++------
 1 file changed, 45 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/net/tls.c b/tools/testing/selftests/net/tls.c
index a4d16a460fbe..2570722d01cb 100644
--- a/tools/testing/selftests/net/tls.c
+++ b/tools/testing/selftests/net/tls.c
@@ -26,7 +26,12 @@
 #define TLS_PAYLOAD_MAX_LEN 16384
 #define SOL_TLS 282
 
+#ifndef IPPROTO_MPTCP
+#define IPPROTO_MPTCP 262
+#endif
+
 static int fips_enabled;
+static int protocol;
 
 struct tls_crypto_info_keys {
 	union {
@@ -122,8 +127,8 @@ static void ulp_sock_pair(struct __test_metadata *_metadata,
 	addr.sin_addr.s_addr = htonl(INADDR_ANY);
 	addr.sin_port = 0;
 
-	*fd = socket(AF_INET, SOCK_STREAM, 0);
-	sfd = socket(AF_INET, SOCK_STREAM, 0);
+	*fd = socket(AF_INET, SOCK_STREAM, protocol);
+	sfd = socket(AF_INET, SOCK_STREAM, protocol);
 
 	ret = bind(sfd, &addr, sizeof(addr));
 	ASSERT_EQ(ret, 0);
@@ -3013,8 +3018,8 @@ TEST(non_established) {
 	addr.sin_addr.s_addr = htonl(INADDR_ANY);
 	addr.sin_port = 0;
 
-	fd = socket(AF_INET, SOCK_STREAM, 0);
-	sfd = socket(AF_INET, SOCK_STREAM, 0);
+	fd = socket(AF_INET, SOCK_STREAM, protocol);
+	sfd = socket(AF_INET, SOCK_STREAM, protocol);
 
 	ret = bind(sfd, &addr, sizeof(addr));
 	ASSERT_EQ(ret, 0);
@@ -3137,8 +3142,8 @@ TEST(tls_v6ops) {
 	addr.sin6_addr = in6addr_any;
 	addr.sin6_port = 0;
 
-	fd = socket(AF_INET6, SOCK_STREAM, 0);
-	sfd = socket(AF_INET6, SOCK_STREAM, 0);
+	fd = socket(AF_INET6, SOCK_STREAM, protocol);
+	sfd = socket(AF_INET6, SOCK_STREAM, protocol);
 
 	ret = bind(sfd, &addr, sizeof(addr));
 	ASSERT_EQ(ret, 0);
@@ -3196,8 +3201,8 @@ TEST(prequeue) {
 	addr.sin_addr.s_addr = htonl(INADDR_ANY);
 	addr.sin_port = 0;
 
-	fd = socket(AF_INET, SOCK_STREAM, 0);
-	sfd = socket(AF_INET, SOCK_STREAM, 0);
+	fd = socket(AF_INET, SOCK_STREAM, protocol);
+	sfd = socket(AF_INET, SOCK_STREAM, protocol);
 
 	ASSERT_EQ(bind(sfd, &addr, sizeof(addr)), 0);
 	ASSERT_EQ(listen(sfd, 10), 0);
@@ -3242,8 +3247,8 @@ TEST(data_steal) {
 	addr.sin_addr.s_addr = htonl(INADDR_ANY);
 	addr.sin_port = 0;
 
-	fd = socket(AF_INET, SOCK_STREAM, 0);
-	sfd = socket(AF_INET, SOCK_STREAM, 0);
+	fd = socket(AF_INET, SOCK_STREAM, protocol);
+	sfd = socket(AF_INET, SOCK_STREAM, protocol);
 
 	ASSERT_EQ(bind(sfd, &addr, sizeof(addr)), 0);
 	ASSERT_EQ(listen(sfd, 10), 0);
@@ -3299,4 +3304,33 @@ static void __attribute__((constructor)) fips_check(void) {
 	}
 }
 
-TEST_HARNESS_MAIN
+static void print_usage(const char* program_name) {
+	printf("Usage: ./mptcp_tls [--mptcp]\n");
+	printf("\t--mptcp  using MPTCP instead of TCP\n\n");
+}
+
+static int parse_arguments(int argc, char** argv) {
+	for (int i = 1; i < argc; i++) {
+		if (!strcmp(argv[i], "-h")) {
+			print_usage(argv[0]);
+			return i;
+		}
+		if (!strcmp(argv[i], "--mptcp")) {
+			protocol = IPPROTO_MPTCP;
+			return i;
+		}
+	}
+	return 0;
+}
+
+int main(int argc, char **argv) {
+	int index = parse_arguments(argc, argv);
+
+	if (protocol == IPPROTO_MPTCP) {
+		for (int i = index; i < argc; i++)
+			argv[i] = argv[i + 1];
+		argc--;
+	}
+
+	return test_harness_run(argc, argv);
+}
-- 
2.51.0

