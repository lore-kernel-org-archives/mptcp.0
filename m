Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2719115A85E
	for <mptcp@lists.linux.dev>; Wed,  9 Apr 2025 06:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744179518; cv=none; b=rYkTep6bty07StxtELWN536zQ5yzUbEyBtGTHeY6X5N/wBCep+UtUF6EIbKLfY5gluOshHNjxKNWg5ngzk7/vkvwVoYqRV0cn7XtSgthRerWy71t76bYtSFMqvfRv8Cetid7VZZOpBPehB2NTHRUibFSkQ8UDWnQwnS0V70OjsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744179518; c=relaxed/simple;
	bh=PFcLzymuVfiMWIJz7nq8qY4jnsGm0LqUUBjO6GaS73E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RVm5/juZ3/y8cVLwMYUijsihpIhPDYopyTCCDx3aEOyBOcIUM4s4VSAyl4h9eHRVuAX9a0lW/7lkAiTLOHmhJXi9kPG8ai1faFTVCvbpzsKX0q6cDRjlKDUjm2xEhICD+DhzLIT5C03xuuDDqR/sl6VOuxv72CBIwTXKlPDW5pU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YmRsTDAs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YmRsTDAs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAADDC4CEE3;
	Wed,  9 Apr 2025 06:18:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744179517;
	bh=PFcLzymuVfiMWIJz7nq8qY4jnsGm0LqUUBjO6GaS73E=;
	h=From:To:Cc:Subject:Date:From;
	b=YmRsTDAsgiE96ur45BMLlC2+arz14ujSY0YkX60B8qIEGSrkIgP/c+ManEfCaANgI
	 A86KJegK6MFagktRLTVMRMKkzkZsuDuSxYodTeD0OP8RzjrtPq1bJWk7UeuamOx2mD
	 rqb625GZUd+9L2APjLUrs5MiRE0kbWJUtBRZZOSSOy5puQTD9TJBC+FsWgvE8tU4Gy
	 6ipqPMMHbiXqAr5hTaQpLcmIIydXR/+waZWZK/jYXCPS3h1AEaXhcX+I0iIkVfrpXY
	 Va+DWs/xO4Rzqr7wHc8PrQchCWNKXg8a5gsK7kzFwH2dg2tkE0jATMga2OGO+pbrMT
	 dGbKjjA6cnkeg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: zhenwei pi <pizhenwei@bytedance.com>,
	Geliang Tang <geliang@kernel.org>
Subject: [PATCH mptcp-next v2] selftests: mptcp: use IPPROTO_MPTCP for getaddrinfo
Date: Wed,  9 Apr 2025 14:18:31 +0800
Message-ID: <77efff47e3cace7d2dd9a1394d3ece4e234a5e74.1744178165.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: zhenwei pi <pizhenwei@bytedance.com>

mptcp_connect.c is a startup tutorial of MPTCP programming, however
there is a lack of ai_protocol(IPPROTO_MPTCP) usage. Add comment for
getaddrinfo MPTCP support.

This patch first uses IPPROTO_MPTCP to get addrinfo, and if glibc
version is too old, it falls back to using IPPROTO_TCP.

v2:
 - use IPPROTO_MPTCP for getaddrinfo

Co-developed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
---
I verified the correctness of getaddrinfo IPPROTO_MPTCP on Fedora 41
using the following steps:

 - Use 'yumdownloader' to download glibc src.rpm and install it.
 - Modify glibc.spec and add the patch "getaddrinfo.c: support
   MPTCP (BZ #29609)" in it.
 - Regenerate the glibc src.rpm package using 'rpm -bs'.
 - Use 'mock' to compile a new glibc src.rpm.
 - Use 'dnf update' to install the newly compiled glibc.rpm.
 - Compile and run mptcp_connect on the the system with new glibc.
---
 .../selftests/net/mptcp/mptcp_connect.c       | 21 +++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c b/tools/testing/selftests/net/mptcp/mptcp_connect.c
index c83a8b47bbdf..ac1349c4b9e5 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
@@ -180,13 +180,26 @@ static void xgetnameinfo(const struct sockaddr *addr, socklen_t addrlen,
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
+		/* glibc starts to support MPTCP since v2.42.
+		 * For older versions, use IPPROTO_TCP to resolve,
+		 * and use TCP/MPTCP to create socket.
+		 * Link: https://sourceware.org/git/?p=glibc.git;a=commit;h=a8e9022e0f82
+		 */
+		if (err == EAI_SOCKTYPE) {
+			hints->ai_protocol = IPPROTO_TCP;
+			goto again;
+		}
+
+		errstr = getxinfo_strerr(err);
 
 		fprintf(stderr, "Fatal: getaddrinfo(%s:%s): %s\n",
 			node ? node : "", service ? service : "", errstr);
@@ -292,7 +305,7 @@ static int sock_listen_mptcp(const char * const listenaddr,
 {
 	int sock = -1;
 	struct addrinfo hints = {
-		.ai_protocol = IPPROTO_TCP,
+		.ai_protocol = IPPROTO_MPTCP,
 		.ai_socktype = SOCK_STREAM,
 		.ai_flags = AI_PASSIVE | AI_NUMERICHOST
 	};
@@ -356,7 +369,7 @@ static int sock_connect_mptcp(const char * const remoteaddr,
 			      int infd, struct wstate *winfo)
 {
 	struct addrinfo hints = {
-		.ai_protocol = IPPROTO_TCP,
+		.ai_protocol = IPPROTO_MPTCP,
 		.ai_socktype = SOCK_STREAM,
 	};
 	struct addrinfo *a, *addr;
-- 
2.43.0

