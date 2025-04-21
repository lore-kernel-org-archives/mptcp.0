Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 969631ADC93
	for <mptcp@lists.linux.dev>; Mon, 21 Apr 2025 02:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745203226; cv=none; b=FQYXvDeHH03L8b7ks/6KdNdoYaoDWOwBcNyxm0H7r/Zvj3zBGln93da/yVoDO57HE/EzLIjC1XTTKgDISepfwGHIm5jq1oTaLxtd/0gx/qY8kC4/4eo+KTVI/FQK1UIMRah9d4JMhg4vwFSIUNmYI5HIvAPyh7lRSDG8+r0L43U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745203226; c=relaxed/simple;
	bh=jYNKJ0W6Q0HCGJ0o+XbCg/WH0580izo6Y09dY9nZLzk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fJZxv+zjOQBK/zdfzH4hRWAVyFW3vE5A0IbGvOtakkIO0G+9pW1UOvnvuyQwkR+ME95xvqJi60e7L/hA+i1E8sQrIYJYoeGczkQ8NuIQNEPmXHLsaM1lgB9BOajcgOXPdHCvHK4H6C2QUeds+VvEWQo6BWqzWaf1NWx95qlqsVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S9+mf5uF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S9+mf5uF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C39AC4CEE2;
	Mon, 21 Apr 2025 02:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745203226;
	bh=jYNKJ0W6Q0HCGJ0o+XbCg/WH0580izo6Y09dY9nZLzk=;
	h=From:To:Cc:Subject:Date:From;
	b=S9+mf5uF86BXSgv8EcqKw9snCVE9bwwMnZKlqi9sAgz/4dIbWwmP9O3sDDliNKwJv
	 R5Z0OHMSkVh9w/eQa7cu853gZzlKMvqC5JPSlb6yjnYE8k9hADkL6Y+uvb9y1YgFBJ
	 Nl0HmSJyYB8HGqqwJ1HIHQ/na6FTkait3mUMbIAnejn0JJgJJIX3QKV7UJ8EOm59SN
	 cXTCWs/Au+zCCQtv+DcXEJjG1qAug8CEd37ymp/oCTi1PCsmmG7DcwWMHSfkTOsRF0
	 Qle1H/GWdBNlKTI8kRabmvUopOr1Li5jwQZYMaCQl349oFHzUzjIwi2EQULUf4tTjp
	 aLnBNaAmD6Jig==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next] selftests: mptcp: sockopt: use IPPROTO_MPTCP for getaddrinfo
Date: Mon, 21 Apr 2025 10:40:19 +0800
Message-ID: <4bdd7056ddd882061c56c0eee3a7121908c0bb89.1745203199.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

getaddrinfo MPTCP is recently supported in glibc and IPPROTO_MPTCP for
getaddrinfo is used in mptcp_connect.c. But in mptcp_sockopt.c and
mptcp_inq.c, IPPROTO_TCP are still used for getaddrinfo, So this patch
updates them.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/mptcp_inq.c    | 16 ++++++++++++----
 .../testing/selftests/net/mptcp/mptcp_sockopt.c  | 16 ++++++++++++----
 2 files changed, 24 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_inq.c b/tools/testing/selftests/net/mptcp/mptcp_inq.c
index 218aac467321..3cf1e2a612ce 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_inq.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_inq.c
@@ -72,13 +72,21 @@ static const char *getxinfo_strerr(int err)
 }
 
 static void xgetaddrinfo(const char *node, const char *service,
-			 const struct addrinfo *hints,
+			 struct addrinfo *hints,
 			 struct addrinfo **res)
 {
+again:
 	int err = getaddrinfo(node, service, hints, res);
 
 	if (err) {
-		const char *errstr = getxinfo_strerr(err);
+		const char *errstr;
+
+		if (err == EAI_SOCKTYPE) {
+			hints->ai_protocol = IPPROTO_TCP;
+			goto again;
+		}
+
+		errstr = getxinfo_strerr(err);
 
 		fprintf(stderr, "Fatal: getaddrinfo(%s:%s): %s\n",
 			node ? node : "", service ? service : "", errstr);
@@ -91,7 +99,7 @@ static int sock_listen_mptcp(const char * const listenaddr,
 {
 	int sock = -1;
 	struct addrinfo hints = {
-		.ai_protocol = IPPROTO_TCP,
+		.ai_protocol = IPPROTO_MPTCP,
 		.ai_socktype = SOCK_STREAM,
 		.ai_flags = AI_PASSIVE | AI_NUMERICHOST
 	};
@@ -136,7 +144,7 @@ static int sock_connect_mptcp(const char * const remoteaddr,
 			      const char * const port, int proto)
 {
 	struct addrinfo hints = {
-		.ai_protocol = IPPROTO_TCP,
+		.ai_protocol = IPPROTO_MPTCP,
 		.ai_socktype = SOCK_STREAM,
 	};
 	struct addrinfo *a, *addr;
diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
index 926b0be87c99..9934a68df237 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
@@ -159,13 +159,21 @@ static const char *getxinfo_strerr(int err)
 }
 
 static void xgetaddrinfo(const char *node, const char *service,
-			 const struct addrinfo *hints,
+			 struct addrinfo *hints,
 			 struct addrinfo **res)
 {
+again:
 	int err = getaddrinfo(node, service, hints, res);
 
 	if (err) {
-		const char *errstr = getxinfo_strerr(err);
+		const char *errstr;
+
+		if (err == EAI_SOCKTYPE) {
+			hints->ai_protocol = IPPROTO_TCP;
+			goto again;
+		}
+
+		errstr = getxinfo_strerr(err);
 
 		fprintf(stderr, "Fatal: getaddrinfo(%s:%s): %s\n",
 			node ? node : "", service ? service : "", errstr);
@@ -178,7 +186,7 @@ static int sock_listen_mptcp(const char * const listenaddr,
 {
 	int sock = -1;
 	struct addrinfo hints = {
-		.ai_protocol = IPPROTO_TCP,
+		.ai_protocol = IPPROTO_MPTCP,
 		.ai_socktype = SOCK_STREAM,
 		.ai_flags = AI_PASSIVE | AI_NUMERICHOST
 	};
@@ -223,7 +231,7 @@ static int sock_connect_mptcp(const char * const remoteaddr,
 			      const char * const port, int proto)
 {
 	struct addrinfo hints = {
-		.ai_protocol = IPPROTO_TCP,
+		.ai_protocol = IPPROTO_MPTCP,
 		.ai_socktype = SOCK_STREAM,
 	};
 	struct addrinfo *a, *addr;
-- 
2.43.0

