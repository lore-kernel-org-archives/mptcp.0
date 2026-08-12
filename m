Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14C7F46D2A9;
	Wed, 12 Aug 2026 14:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786546594; cv=none; b=qgIT/bMJ7u4j2gWkS4PFQSfviym/H2dTtnyLzFvqydPTf/oTfxy78wpSoGWiSoZbpA8fdjZyq5APwhzTRAdfvOezz4avnUk72WOFSVtuebWhAaMGj3CxGCNAEBnMg1lpMS89dhLqsHkBP3ah8X11hLXp6T6+DA0aUgiIW8UPlRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786546594; c=relaxed/simple;
	bh=nKeL6zR0FvSkwqt1XKsxG9dC4ZW7w7ssB4opyx4q8S4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PagXulZs237U2wBPrAWLdMBOtr8uxxlOZ1EfckfM7/3aG3RdfC0/fQJVXyaxOUpbbyYoEGN7zEIY5U/Mah78Tnz/qSAd8H+/grSedipBzHH2BSMQ3DjE4vZ8/kAYFHQ0wJEQ3Wb8l8FSbEFREMTX82U3DgskSjMOejoEUhbcZew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GLBujH1n; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GLBujH1n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 501F31F00AC4;
	Wed, 12 Aug 2026 14:56:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786546582;
	bh=YcxL9EIjig3QodKUmDaete2bH5tnLyqpAVf3cFMscWE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=GLBujH1nVNFdokgBLe2Mx/5WB/hV1FHF4E6kWuUAw4Kf/k7IkOAlJ271xOn/gpG6r
	 0EiXpRU5tUvo3Kfu3Ge9ToAUBEeIRBev3B2CPslZBGhhhSghnw0Q1O+GhYV0vvInPT
	 A4cNVoZ9OoUMjKwVGSOuiTUtZD2eJmCkiqdXeztkKqE7UfJH+EVJ044Ir/3IlG4jiB
	 WUxzHpgUuANfOOJO+L/FAEMhHox+lQOTCsLMPmOyiV9RYYrwS88Qqmo9xwX88See0D
	 LGdLcVyOQBB2VJPE93rp3sW1Bq3ktgWbcJsKJIrVcaYqvCPmhh3ZZbKKbfXzjzls2L
	 Jei8O7n1VvbnA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 12 Aug 2026 16:55:45 +0200
Subject: [PATCH net-next 10/11] selftests: mptcp: fix const qualifier
 warnings in strchr usage
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260812-net-next-mptcp-misc-feat-7-3-v1-10-1905a818f6cb@kernel.org>
References: <20260812-net-next-mptcp-misc-feat-7-3-v1-0-1905a818f6cb@kernel.org>
In-Reply-To: <20260812-net-next-mptcp-misc-feat-7-3-v1-0-1905a818f6cb@kernel.org>
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org, 
 Geliang Tang <geliang@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2244; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=4LSthEUfeknPiuCGNZFRTmg5QwSZ53sxQ5j6RTKzcBY=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLJqOiuVNzlLODkXCvzQlQzcY3d6z/81umuZTYVEvxgfl
 WV03MjSUcrCIMbFICumyCLdFpk/83kVb4mXnwXMHFYmkCEMXJwCMJHL4gx/eC90np5h2fv3RtAC
 Jp6qzPhqoWqGY/v+9X2dv2bnaXVHb0aGXnYFH+l5L87P0GhLaXz5/eW6hsasibsW6c3JUTKIZpz
 HDQA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

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
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
To: Shuah Khan <shuah@kernel.org>
Cc: linux-kselftest@vger.kernel.org
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

