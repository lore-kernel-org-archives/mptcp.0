Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96063397342
	for <mptcp@lists.linux.dev>; Thu, 11 Jun 2026 17:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781197716; cv=none; b=KWjzw+/Gg0acuwYElswlS7Y2Ie1ihAtkKglmY747zOn010qNRP7uppNsveHieVQNbliuLhdZ9WaBerI2471nhJ+Zi4wY/PTytKm+5g9B5Eb5qMcvnwbrPv7JAdLC+LslA6gDYXZxR3NZBLkiKybdq6hUxTBQJ8K6Y7SXjByY91c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781197716; c=relaxed/simple;
	bh=aQoKz+CskS08sa9eYpWRhiJYleQKVb6RQ4Lcvlv7DBU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jd1Duypy3C7b1yfbpACLLk88q1ud8hrci9rLixT/ys60L8SgjdWIRANtIPIR+oNdE6qYlvSAux6CtFWWIn1diUXf78LIbmw3b9ypcH993jjHrMCP5ZqmTOX67wp0xVnWAZG27X2t/CMQvxqL7tU42v3XIJ4Vt71YFw5NhC5lnjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=sso+5Z2J; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="sso+5Z2J"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781197714;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4pZLxsmq+aJt6EP95KFc25HA6t9bAu1d+8Dpc+32FMY=;
	b=sso+5Z2JQFn0zYlZJkKf0FGrXu5+R2zfDpAOqxHpUacZxVzwC1OAf77g9dVNwE1HzzvX6h
	1LiWGQRIp5uHu0PhvmuCffdhOIYLuaF069JdpN6CU4qVMGV+67k2lce218tuW1Tl9kfp8N
	eHjafPQIywEDLX89TMXi7NwyQwUfg6o=
From: Gang Yan <gang.yan@linux.dev>
To: mptcp@lists.linux.dev
Cc: Gang Yan <yangang@kylinos.cn>
Subject: [PATCH, mptcp-next 7/9] selftests: mptcp: mptcp_join.sh: pick v4 bind default when MPTCP IPv6 is missing
Date: Fri, 12 Jun 2026 01:07:57 +0800
Message-ID: <a1970eafb8ca3cd3908fc8d2b4cccd8cad3b861c.1781196828.git.yangang@kylinos.cn>
In-Reply-To: <cover.1781196828.git.yangang@kylinos.cn>
References: <cover.1781196828.git.yangang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Gang Yan <yangang@kylinos.cn>

do_transfer() defaults bind_addr to "::", and mptcp_connect.c
auto-selects the protocol family from the bind string (a ':' forces
AF_INET6). On a kernel without CONFIG_MPTCP_IPV6 the listener becomes
socket(AF_INET6, SOCK_STREAM, IPPROTO_MPTCP), which the kernel rejects
with -EAFNOSUPPORT and every subtest that does not override bind_addr
reports "client exit code 2, server 1" — starting with "001 no JOIN" —
even though nothing v6-specific is being tested.

Pick the default from the mptcp_lib_is_v6_enabled flag when v6 is
available, "0.0.0.0" otherwise. Callers that explicitly set bind_addr
are unaffected.

Assisted-by: GLM:5.1 Z.ai
Signed-off-by: Gang Yan <yangang@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 550a6b6117a9..26fb5e433384 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -1004,7 +1004,14 @@ do_transfer()
 	local FAILING_LINKS=${FAILING_LINKS:-""}
 	local fastclose=${fastclose:-""}
 	local speed=${speed:-"fast"}
-	local bind_addr=${bind_addr:-"::"}
+	local bind_addr=${bind_addr:-}
+	if [ -z "${bind_addr}" ]; then
+		if mptcp_lib_is_v6_enabled; then
+			bind_addr="::"
+		else
+			bind_addr="0.0.0.0"
+		fi
+	fi
 	local listener_in="${sin}"
 	local connector_in="${cin}"
 	port=$(get_port)
-- 
2.43.0

