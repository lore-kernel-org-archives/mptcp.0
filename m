Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C879282FA
	for <mptcp@lists.linux.dev>; Fri,  8 Aug 2025 14:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754664226; cv=none; b=F+5sR12sZLEti8pPzC/7sRy6VJaqc5w2eRIZ2zerZpulz/kh36nRZbjauONYlJDFA8NvZPYvu/xExckqHoUiAXn8JNjJ10h3kYjW94BMU2Zaf34F+8ZUF6RwzW2QGLt7VafITkvbtzqmA4wJMbqq0gnV0W4GHHeupjW+Sm7U0XU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754664226; c=relaxed/simple;
	bh=YW1cNRplX0PGLIvjIHxQvdH8aABk1d5ritNQWv3qM+8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TlR9d27ugDOwTwbJdvsWXeB+NFn752c6czwwHCTHC55r8B0QGZLgsWeoRrkHhwz6r4Y1XGyY8MDvxO/85h6EAFNv2hOu65cEX+HQsCgp2L2xi5YtPmPbVAultLkJdbX1FFOkmVOEmkyLDq4gVPg7ClffHmD0/PfuFCRr6awzY9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kFz5G3Wf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kFz5G3Wf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32730C4CEED;
	Fri,  8 Aug 2025 14:43:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754664226;
	bh=YW1cNRplX0PGLIvjIHxQvdH8aABk1d5ritNQWv3qM+8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kFz5G3WfVNjgbpaNparK3mevRvPu74dtCF3UtGYNI8VoMzQw/A0PuN0e56OmUvpT+
	 HtXi16WzMZNOnEPk6Eh1zQ+q+os79la7yf9zdDLPngc3/1kNnA3up+DxCEBUddJbLZ
	 2b7HDrfkJjVcUKHPfRJNnqtPmhledUsgT1Twc1u7nkX9nq+HbeJyib8gA1x+gGfYyE
	 2IVVrJwj79SFGo7ntunPglTb+dvDOLxvjBox+CgCl4u3coJpsPke2/mSv3lHn+br1u
	 HYUnfmCT+kh3n5rdabSD6JSc60XSYUTp9OiPRePaVtxq31aV5vzktL9smEVsRbSZaV
	 96+VNnNKp5XjA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 3/9] selftests: mptcp: sockopt: add inq argument
Date: Fri,  8 Aug 2025 22:42:48 +0800
Message-ID: <b771de4338a6f7a9040ca8f08080fafac07a93f1.1754664106.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1754664106.git.tanggeliang@kylinos.cn>
References: <cover.1754664106.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Introduce -i option to enable TCP_INQ testing. This prepares for
consolidating TCP_INQ tests into a single binary by adding the necessary
command-line interface.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/mptcp_sockopt.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
index 02470997d7b8..5ed8287a10e3 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
@@ -30,6 +30,7 @@
 static int pf = AF_INET;
 static int proto_tx = IPPROTO_MPTCP;
 static int proto_rx = IPPROTO_MPTCP;
+static bool inq;
 
 #ifndef IPPROTO_MPTCP
 #define IPPROTO_MPTCP 262
@@ -138,7 +139,7 @@ static void die_perror(const char *msg)
 
 static void die_usage(int r)
 {
-	fprintf(stderr, "Usage: mptcp_sockopt [-6] [-t tcp|mptcp] [-r tcp|mptcp]\n");
+	fprintf(stderr, "Usage: mptcp_sockopt [-6] [-t tcp|mptcp] [-r tcp|mptcp] [-i]\n");
 	exit(r);
 }
 
@@ -277,7 +278,7 @@ static void parse_opts(int argc, char **argv)
 {
 	int c;
 
-	while ((c = getopt(argc, argv, "h6t:r:")) != -1) {
+	while ((c = getopt(argc, argv, "h6t:r:i")) != -1) {
 		switch (c) {
 		case 'h':
 			die_usage(0);
@@ -291,6 +292,9 @@ static void parse_opts(int argc, char **argv)
 		case 'r':
 			proto_rx = protostr_to_num(optarg);
 			break;
+		case 'i':
+			inq = true;
+			break;
 		default:
 			die_usage(1);
 			break;
-- 
2.48.1

