Received: from mta0.migadu.com (out-102.mta0.migadu.com [91.218.175.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 134E03C4174
	for <mptcp@lists.linux.dev>; Thu,  8 Oct 2026 09:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791451700; cv=none; b=Znc2f2yvgfiblgor9+t2AI0w3rrdQJMOp6V4QnMYptvPaiIt+XT8Vnm/4xntoHFbMqoDl2jMnnh7eMZzBfivXF8XadRdZXDm/x2kHtD3jk6wQUgYcSd+sHT5a/bD3Dtxe4rQlr8VrxROwMgjvXv69V/H2UxES/xl8bCHuNHOEYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791451700; c=relaxed/simple;
	bh=xo4WHArZ2kK8VAu7+hBmYu46EFqUB+fRvgBgjDQYQnI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=g2fcG5NU0f82TAL1g1eAfyhMNzV95hBLaTJz+hTkBunK2FrMfe9KeZ8Y5sw+S8kHFCea6Xa8Xn8zhMtWKym2ymIEQxAwyMAElJwJGIaddq7XNRwDNMLxFHCrw67diseBZy0tUWE3SG+FgZtMD6KmMm3hGqBb/cve+5+AppSBYso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=er6Oz4e+; arc=none smtp.client-ip=91.218.175.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="er6Oz4e+"
X-Envelope-To: mptcp@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=xo4WHArZ2kK8VAu7+hBmYu46EFqUB+fRvgBgjDQYQnI=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791451696; v=1; x=1792056496;
 b=er6Oz4e+Bldnnz+zjfuoOnj6ktP0OaLxqvuYfmLhigoWkkRFf1bERFEVqp33E65EAYSB3rHX
 yzx7iy+bsfQavQW00YhP2Dc2h7alYHfiP+M7skNWWXskODmy4Sc/yvBgET2AZZ7TVDXb5ZYvxrk
 ilWqGiKE3/b40nW5dM30H1Kw=
X-Envelope-To: mptcp@lists.linux.dev
Received: by mta12.migadu.com with ESMTPS id a5d0ad41086fa676;
	Thu, 08 Oct 2026 09:28:16 +0000
X-Mizu-Trace-ID: a5d0ad41086fa676
X-Migadu-Flow: FLOW_OUT
From: Hangbin Liu <hangbin.liu@linux.dev>
Date: Thu, 08 Oct 2026 17:28:01 +0800
Subject: [PATCH mptcp-next] selftests: mptcp: remove unused configs
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261008-mptcp_config-v1-1-269d05f7e6be@kylinos.cn>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2MQQqAIBAAvxJ7TtAKk74SEaKr7SETjQikvyceB
 2amQMZEmGHpCiR8KNMVKoi+A3Po4JGRrQwDH6TgXLEz3ibu5gqOPBtnLdFanLRQUJOY0NHbdis
 0kwV8b9i+7wcF5nGqagAAAA==
X-Change-ID: 20261008-mptcp_config-37a6edde4a18
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: Hangbin Liu <hangbin.liu@linux.dev>, 
 Hangbin Liu <liuhangbin@kylinos.cn>
X-Mailer: b4 0.14.3

From: Hangbin Liu <liuhangbin@kylinos.cn>

After converting the mptcp selftests from iptables to nftables,
the xtables-only options are no longer needed.

Signed-off-by: Hangbin Liu <liuhangbin@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/config | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/config b/tools/testing/selftests/net/mptcp/config
index 61057a066719..6a96cfbbc461 100644
--- a/tools/testing/selftests/net/mptcp/config
+++ b/tools/testing/selftests/net/mptcp/config
@@ -1,12 +1,7 @@
 CONFIG_INET_DIAG=m
 CONFIG_INET_MPTCP_DIAG=m
-CONFIG_IP6_NF_FILTER=m
-CONFIG_IP6_NF_TARGET_REJECT=m
 CONFIG_IP_ADVANCED_ROUTER=y
 CONFIG_IP_MULTIPLE_TABLES=y
-CONFIG_IP_NF_FILTER=m
-CONFIG_IP_NF_MANGLE=m
-CONFIG_IP_NF_TARGET_REJECT=m
 CONFIG_IPV6=y
 CONFIG_IPV6_MULTIPLE_TABLES=y
 CONFIG_KALLSYMS=y
@@ -19,12 +14,6 @@ CONFIG_NET_CLS_FW=m
 CONFIG_NETFILTER=y
 CONFIG_NETFILTER_ADVANCED=y
 CONFIG_NETFILTER_NETLINK=y
-CONFIG_NETFILTER_XTABLES=m
-CONFIG_NETFILTER_XTABLES_LEGACY=y
-CONFIG_NETFILTER_XT_MATCH_BPF=m
-CONFIG_NETFILTER_XT_MATCH_LENGTH=m
-CONFIG_NETFILTER_XT_MATCH_STATISTIC=m
-CONFIG_NETFILTER_XT_TARGET_MARK=m
 CONFIG_NET_SCH_INGRESS=m
 CONFIG_NET_SCH_NETEM=m
 CONFIG_NF_TABLES=m

---
base-commit: 9651c766735c19e7a6b90d731bab53ef7959def8
change-id: 20261008-mptcp_config-37a6edde4a18

Best regards,
-- 
Hangbin Liu <liuhangbin@kylinos.cn>

