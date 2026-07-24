Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BE12395AFA
	for <mptcp@lists.linux.dev>; Fri, 24 Jul 2026 06:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784876041; cv=none; b=D/VnligEO7X67GYkAkyU+ie2xg6rSrcW3SyE81yao9rJiJ7k2vOhgTVKQd3REaRqPextBhQHjYaaew9j/OClQrKPLKHgXjCU+qtC0aX91s7x4fn7KfU1sCag8aNOJOBrhutIzQIxGSi/8wc3ZwNvZQ6eG3Ueh8xCa+qvDgMzy0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784876041; c=relaxed/simple;
	bh=Cmfv+GAfyQ88rUoWYdI5wiG5hgfP6NJzI9W+0gb5f+0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=i2T3TklnEY6dZmj6CZl5lnuURO6mdSg9FO/0MUoSa5EwtA92UGjh0WK9zGEYcf6wkvZ3WrNiAjGH3KrJ4PW30F7tj1HBdiA9TBD9xTcbF3QPPUpzCqZH4gpp83swm3ZOBAn1BjtFGnyGoRSt+LxU0qOTX2doO2S97oHB6a1jsZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rY9DcAjO; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rY9DcAjO"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784876033;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=9cvi1G7rPuh7KTq171P5m95pPo1vFpAgd+n0U7yXY8E=;
	b=rY9DcAjOxjxXypHB8O4K+GQL7Fuz6KvZ2NmN4rS421cyFVNbAjrTjSKC09kdMFw1vHmbPk
	EKlLd0wyltE6cZj9JVHyeHQvA58kYK9pig8GAG6R+E5JfRPR6K7Z7vSjp4pdl2BAqRan0e
	sPzfPGMTb3wX45PjwDm9WLNVTe65Lgk=
From: Gang Yan <gang.yan@linux.dev>
To: mptcp@lists.linux.dev
Cc: Gang Yan <yangang@kylinos.cn>
Subject: [PATCH mptcp-next 0/2] selftests: mptcp: some improvement for selftests
Date: Fri, 24 Jul 2026 14:52:27 +0800
Message-ID: <20260724065229.36736-1-gang.yan@linux.dev>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Gang Yan <yangang@kylinos.cn>

This series contains two independent selftest fixes. Both are about
making failures correctly handled instead of being silently masked or
leaving resources behind. They are unrelated and can be applied/merged
independently.

Gang Yan (2):
  selftests: mptcp: run fail_test in main shell during join test
  selftests: mptcp: simult_flows: set EXIT trap earlier

 tools/testing/selftests/net/mptcp/mptcp_join.sh   | 4 ++--
 tools/testing/selftests/net/mptcp/simult_flows.sh | 3 +--
 2 files changed, 3 insertions(+), 4 deletions(-)

-- 
2.43.0

