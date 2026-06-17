Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92DF7449EC2
	for <mptcp@lists.linux.dev>; Wed, 17 Jun 2026 14:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781707617; cv=none; b=j5C/5d4v68m6+hqJ0RUAbaBfvbKR2qx9o5I9mil6B3hiIU2Mbexp3FN8nUB5bgWJ8fijUewT9mkFqTL8KTZAwTvJ/Hr1TNF3Weh0N+CV0zbkx36E5lsUBtFUVvVj8aXDMkz9f+eB3LMHc0IC8lwOQqv2lgaCgOSNg9IGPj2qLk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781707617; c=relaxed/simple;
	bh=aQoKz+CskS08sa9eYpWRhiJYleQKVb6RQ4Lcvlv7DBU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KlLUOitx3Bc8yL0X4KBQREi9TXkoYEdj/+0QKly2O3p5sic1Xf1UUZ/mRdd0VxY18ikQyDppbWtTpxxqVitEGVNP83BkTUqFE136EAcg3ZkcozkF18CNcD9HVX9usuaspQNZ+hL8ASiYQsUYvrd8259UFcc+Q3OryfMevykSNjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=KcihYzsj; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="KcihYzsj"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781707612;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4pZLxsmq+aJt6EP95KFc25HA6t9bAu1d+8Dpc+32FMY=;
	b=KcihYzsj/VEmI6aoEXZKVLIOnbAYcUcEsN9iwNOZ/ZmKg7cNRNAaIigTcSs6EerlQET8Ky
	LkAr/RndBKK25Z88olAi3NQ55T2lIF38a8S/Oun6pxEkB9jxpkghdt6bLKzlWwu5ykVXFj
	j27mzDRzn/D0Krjz/9vITZVUzt1zJGs=
From: Gang Yan <gang.yan@linux.dev>
To: mptcp@lists.linux.dev
Cc: Gang Yan <yangang@kylinos.cn>
Subject: [PATCH mptcp-next v2 7/9] selftests: mptcp: mptcp_join.sh: pick v4 bind default when MPTCP IPv6 is missing
Date: Wed, 17 Jun 2026 22:46:14 +0800
Message-ID: <728b4ff36484969dcc969178db304af1f6111796.1781707101.git.yangang@kylinos.cn>
In-Reply-To: <cover.1781707101.git.yangang@kylinos.cn>
References: <cover.1781707101.git.yangang@kylinos.cn>
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

