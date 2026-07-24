Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73AAE39A079
	for <mptcp@lists.linux.dev>; Fri, 24 Jul 2026 06:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784876043; cv=none; b=nRilVk0eMfPR4NgGy/36Bi3drMlEHxfbNeA8sExU57blpQ/5cGQRaycMlFznm17zilME9SZJDjxRnrTvesk77LcNDahExqy8pewAVn8ADfeFJRmp0m0ksuwOl9wqYbyuGDedkZGUrWmyJhSLLA/7cGdGuMcJWG8dmHssPNLJMYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784876043; c=relaxed/simple;
	bh=SIL+pmojdobVkXZkeQIYtzUSGxV/VukCPADyNDmjWLw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TmyeGr6qgzSR7pIX3O8TfuxMMaxYHdqajr1mStsHfcPe6IojEqvXK6S1s79e/2GZN2/tgQeZCK12kT9YXr6Z0m4m2Sl+dqM/DuxlIcQNCFkP7DBWevGCov0IWoNu722J7mZLYztEHNrmsq18mfeMbO9r0pKuzgSTldgnY1OeRvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=WQ06n1C9; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WQ06n1C9"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784876037;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PcaO/6pE+/43l4Y22qTDyoxMc8SNVF311cn5uKvhAvM=;
	b=WQ06n1C98sgmpZDZq93eDwweVtKEsQPflBkUWz8Dk1cjo6TY5Lf8b2WQIOTFgfEX5S+Q+Z
	7MCieGRS0S8qYaJZbrvLGLw8wyqlRy9QJzIU7zXKCtf4DT8O8zVoeA0dDonnw4wXkZRzsH
	oq2wr4vKJ7D9Q+5vmBgHlutqEbEXwq0=
From: Gang Yan <gang.yan@linux.dev>
To: mptcp@lists.linux.dev
Cc: Gang Yan <yangang@kylinos.cn>
Subject: [PATCH mptcp-next 2/2] selftests: mptcp: simult_flows: set EXIT trap earlier
Date: Fri, 24 Jul 2026 14:52:29 +0800
Message-ID: <20260724065229.36736-3-gang.yan@linux.dev>
In-Reply-To: <20260724065229.36736-1-gang.yan@linux.dev>
References: <20260724065229.36736-1-gang.yan@linux.dev>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Gang Yan <yangang@kylinos.cn>

Set the EXIT trap for cleanup immediately after creating the temporary
file variables, before the dd commands that fill them and the namespace
init, to ensure cleanup runs on any failure or interruption during the
early setup phase. If either dd fails (e.g. ENOSPC), the temp files
already created are not cleaned up.

Assisted-by: Codex: GLM-5.2
Signed-off-by: Gang Yan <yangang@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/simult_flows.sh | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/simult_flows.sh b/tools/testing/selftests/net/mptcp/simult_flows.sh
index 3ea3d1efe32e..b40dea5f9b30 100755
--- a/tools/testing/selftests/net/mptcp/simult_flows.sh
+++ b/tools/testing/selftests/net/mptcp/simult_flows.sh
@@ -62,13 +62,12 @@ setup()
 	sout=$(mktemp)
 	cout=$(mktemp)
 	capout=$(mktemp)
+	trap cleanup EXIT
 	size=$((2 * 2048 * 4096))
 
 	dd if=/dev/zero of=$small bs=4096 count=20 >/dev/null 2>&1
 	dd if=/dev/zero of=$large bs=4096 count=$((size / 4096)) >/dev/null 2>&1
 
-	trap cleanup EXIT
-
 	mptcp_lib_ns_init ns1 ns2 ns3
 
 	if $capture; then
-- 
2.43.0

