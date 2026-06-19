Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FAD6324B1F
	for <mptcp@lists.linux.dev>; Fri, 19 Jun 2026 23:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781911946; cv=none; b=D4xQ2J7ul/dp7HQPXmcKmHH6hv1BLer9DGTunsxtwOkYTdmUTcjPuJ7Q+cKDtoyTETSWFuYhIYNrpbVok7/t1x8Tdbfk09lDI9YShe/AQ17vUA5mpBpW3u8NQLnxjwAKH5brEDRUP7vJu57jlQP3bEnBG2A2K80K/XIQjhlpb8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781911946; c=relaxed/simple;
	bh=PU3XVpoWFikMfUwpdBJ3JWfE1K85M91/eyYIuBNmuQs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EBZGWIxN6QDqQeZ/zkYcQajZjvlZfPbVKcgQhzxSCrucQ3awQrjK/DlKshFG54TDmvMsrSNTARemtbDzKop2IReGeVAaUNp8yAUlPSVN7MVcXYEAV9hO1DrWFfKrC3Ja+ytog21c94jiFKjUv65bvTxEObFY3LkPPN0PiNQhak4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MoT3tUER; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MoT3tUER"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03E491F00A3F;
	Fri, 19 Jun 2026 23:32:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781911945;
	bh=jMwRlo+GmzU/fpFo2Q5f6CZMp3syvr4qvKFo+U32Oo0=;
	h=From:To:Cc:Subject:Date;
	b=MoT3tUERKoUg2gAG7i30Sq2d3JthETvhbbu4bF81H+ozBdqkqHvCIg+zU3fcF5rLl
	 k8cEZudYu9JfIHUuEdIhYZNXZNs61HcMLTurTxkGjlc+iCCGxAY0WtYtC/UIIL4QvO
	 PzGUD5HE0IwDoti1tW7cApYYFDGnWBt5dSqrLC9qRXSSfNWfyuLJ3h4K2nMwnphuIX
	 3Mt92F4eWovRU1nlEUuJp//HdJLfjeCNNw4TokVtMtclu6eSGzN0dbCSFE8FAiBHsO
	 jA8V/LbTJ6CjhcG0KOzcoeTxTvjRPhXHoFaPcAjfcuhiR2Mo/agvxlxqb37plY5e3w
	 gcumXzEK3sTkQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next] selftests: mptcp: fix const qualifier warnings in strchr usage
Date: Sat, 20 Jun 2026 07:32:00 +0800
Message-ID: <3b746802bcc4b08e9a6d2f2fb2f7622197a2d25a.1781911900.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

In mptcp_connect.c, strchr() returns a pointer to a character within
the input string, which is declared as const char *. Assigning this
return value to a non-const char * discards the const qualifier,
triggering compiler warnings:

 make: Entering directory 'tools/testing/selftests/net/mptcp'
   CC       mptcp_connect
 mptcp_connect.c: In function 'parse_cmsg_types':
 mptcp_connect.c:1267:22: warning: initialization discards 'const'
	qualifier from pointer target type [-Wdiscarded-qualifiers]
  1267 |         char *next = strchr(type, ',');
       |                      ^~~~~~
 mptcp_connect.c: In function 'parse_setsock_options':
 mptcp_connect.c:1295:22: warning: initialization discards 'const'
	qualifier from pointer target type [-Wdiscarded-qualifiers]
  1295 |         char *next = strchr(name, ',');
       |                      ^~~~~~
 make: Leaving directory 'tools/testing/selftests/net/mptcp'

Fix these warnings by declaring the 'next' variable as const char *,
as it is only used for read-only parsing.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/mptcp_connect.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c b/tools/testing/selftests/net/mptcp/mptcp_connect.c
index cbe573c4ab3a..ea4cb6c1bd5e 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
@@ -1264,7 +1264,7 @@ static void apply_cmsg_types(int fd, const struct cfg_cmsg_types *cmsg)
 
 static void parse_cmsg_types(const char *type)
 {
-	char *next = strchr(type, ',');
+	const char *next = strchr(type, ',');
 	unsigned int len = 0;
 
 	cfg_cmsg_types.cmsg_enabled = 1;
@@ -1292,7 +1292,7 @@ static void parse_cmsg_types(const char *type)
 
 static void parse_setsock_options(const char *name)
 {
-	char *next = strchr(name, ',');
+	const char *next = strchr(name, ',');
 	unsigned int len = 0;
 
 	if (next) {
-- 
2.53.0

