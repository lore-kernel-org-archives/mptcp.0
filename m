Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84154397342
	for <mptcp@lists.linux.dev>; Thu, 11 Jun 2026 17:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781197706; cv=none; b=KzEFk7OG4PRjE3S/elnXsV2iTisFZzcFkEbHZntoN09IHJYEcEGG1vndKsbe8q567ydM85jqnGZ5ViQ4sQqoNYRkrFhFH9mIH3iO1wpVvB9+J7bp7sXTdV3w8aF2WRCgKc0uLU4hXxAXj8tS88FvgoF61XxQnRKIM1oKUeDYyL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781197706; c=relaxed/simple;
	bh=KWb2JQk5EFkysNAREoJt8zHVoaRkclnVuU3n8IGiqaw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mk7zSBENWSaNfK6TIsYEYA2kV2H7xbTmRqdWT6sxIsTVCJg0QXFW1H0gi3qm0Jk04n/25yZyIOSpJiyZB6gzwQCZwSAPUBOpQoFnbuksPN6aijIA3O6My32QX/dBrz0GuMpPZbIIRUCvLMj4KTGb0+NUv1sKJCnfF95eaH7LMcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pxqydYMs; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pxqydYMs"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781197702;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=znAyoSmtjwInbXZhUuS96a8SBg46sFtEoPBd6T7itWk=;
	b=pxqydYMs7tqvxNZHIbt0xa3DW1UmhfBw7UoRfDrqXdMgcGYu2EFJe/IW+S/a7OSIeEvN+p
	s6aU7GGN3A82qFYHQNI0JIY+SDgJcyZCZbj3ExK1Rgd7abyTixh6s/lVy3sT9p4wMyMwVj
	xhUPkXBOM1qARbLMy4lNQWkeUVwzy/U=
From: Gang Yan <gang.yan@linux.dev>
To: mptcp@lists.linux.dev
Cc: Gang Yan <yangang@kylinos.cn>
Subject: [PATCH, mptcp-next 1/9] DO-NOT-MERGE: mptcp: test IPV6=m in docker-virtme
Date: Fri, 12 Jun 2026 01:07:51 +0800
Message-ID: <e15efa7eb17f58d178e4b3e59e106ce0e735ba6a.1781196828.git.yangang@kylinos.cn>
In-Reply-To: <cover.1781196828.git.yangang@kylinos.cn>
References: <cover.1781196828.git.yangang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Gang Yan <yangang@kylinos.cn>

This is a helper commit for maintainer review of the preceding MPTCP
selftests patches that teach the test scripts to gracefully skip IPv6
subtests when the running kernel has no CONFIG_MPTCP_IPV6.

Signed-off-by: Gang Yan <yangang@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/config | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/config b/tools/testing/selftests/net/mptcp/config
index 59051ee2a986..616fee329e22 100644
--- a/tools/testing/selftests/net/mptcp/config
+++ b/tools/testing/selftests/net/mptcp/config
@@ -7,11 +7,10 @@ CONFIG_IP_MULTIPLE_TABLES=y
 CONFIG_IP_NF_FILTER=m
 CONFIG_IP_NF_MANGLE=m
 CONFIG_IP_NF_TARGET_REJECT=m
-CONFIG_IPV6=y
+CONFIG_IPV6=m
 CONFIG_IPV6_MULTIPLE_TABLES=y
 CONFIG_KALLSYMS=y
 CONFIG_MPTCP=y
-CONFIG_MPTCP_IPV6=y
 CONFIG_NET_ACT_CSUM=m
 CONFIG_NET_ACT_PEDIT=m
 CONFIG_NET_CLS_ACT=y
@@ -34,3 +33,5 @@ CONFIG_NFT_SOCKET=m
 CONFIG_NFT_TPROXY=m
 CONFIG_SYN_COOKIES=y
 CONFIG_VETH=y
+
+CONFIG_NF_TABLES_IPV4=y
-- 
2.43.0

