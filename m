Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B70B321E091
	for <mptcp@lists.linux.dev>; Sat, 11 Apr 2026 03:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775879383; cv=none; b=Uk9mruwcNpFNbI0gI8KXlxKYEVLS8tPV4mSt1ujt9xL61VIQaYvyxyQUFUW2lq9HfUChgJ5uVYRmlSEMjY9YxRUCCOgEY7cTZOEbKaBKj/zr5CK1XhJ3Hxi29N0KCA6ySgay9zT2hIEvJgOta02q2Vu9pEbil1+IkkJcTcyaIaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775879383; c=relaxed/simple;
	bh=Md4HfVEUlUvfJ5xuJObCyxkOlhcnRZa6nqggFQwL0CY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oBIdFU9dg5eoANZ5BqdsJmW05qhIiPanHnmDh1Vdx5IDx4SRgqDjtAOWr0tTem4+gWi/OeX6JdJ+pQ1wSNPMHSeQVAb1xgxQMhvHLLT2Vfk7sFd1dbtM1bPn3YLn1cYLHWFGuaqEHe4lgmUfO60HSneCDaDtbKW3S7um8Xjr+Wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=WKhPihFo; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WKhPihFo"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1775879378;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=+MIuDl7MwiVdjwx2uuc70uNeRl67Z/1QVBmz8Yj3Icg=;
	b=WKhPihFoFLXFFsK9P60bLTYimeETwCleUKaMZk1DqPa/Cv0PYH17/Fr9FiY4MhXIOIEkN3
	2/LzMhnO7Bu3qUlQAuwkHJW+eDA+wjyPbvolgLYg7+7voJWfqz+hdabcJSbPn+JN726rfW
	ctsuhqLQKkWH0l15IAyCAztUXV22qnU=
From: Gang Yan <gang.yan@linux.dev>
To: mptcp@lists.linux.dev
Cc: Gang Yan <yangang@kylinos.cn>
Subject: [PATCH mptcp-net v4 0/2] mptcp: sync the msk->sndbuf at accept() time
Date: Sat, 11 Apr 2026 11:48:58 +0800
Message-ID: <cover.1775878944.git.yangang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Gang Yan <yangang@kylinos.cn>

Changelog:
v4:
  - Update the coomit log to show the root cause.
  - Remove the '__mptcp_propagate_sndbuf' in 'mptcp_sk_clone_init'
    according to Paolo's advice.
  - Replace 'grep' with 'sed' according to AI's suggestions.
  - Crete a packetdrill PR for test:
    https://github.com/multipath-tcp/packetdrill/pull/193
v3:
  - Add a check in diag.sh to check the sndbuf of the server side.

Gang Yan (2):
  mptcp: sync the msk->sndbuf at accept() time
  selftests: mptcp: add a check for sndbuf of S/C

 net/mptcp/protocol.c                      |  2 +-
 tools/testing/selftests/net/mptcp/diag.sh | 28 +++++++++++++++++++++++
 2 files changed, 29 insertions(+), 1 deletion(-)

-- 
2.43.0

