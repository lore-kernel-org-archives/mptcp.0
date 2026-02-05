Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 053FA84A35
	for <mptcp@lists.linux.dev>; Thu,  5 Feb 2026 06:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770273729; cv=none; b=oaHW84SeBvedQtMdNIA8O2hsdfK0NCiRZIGf3B4nnYojp3wnu5+qmYLC48W8lJKnqzfsoyuVPBTx4GOznO/lebDvtBni/G/e2KXcc4+CbXtpjIXVHK9XkiGi5N3BUqXv07N83cHlfx7cASuVTHHk/5Jj5GJ88c6+VJHOE3Kao1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770273729; c=relaxed/simple;
	bh=0kAqMgTagocLDxSuo6AeA8JCgdvV6jGui8RBoze2u/8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SnPB7Zuul4ATgzw+pu2igeJlnuRO1MjF3Tze9hTkHYxMpzfExRQ9xxwKNRsZadKpzYGXqxGKFt21s93pAw8XiPwELMnme/ljHoUaUGc2h9x6ue3Hggj16obzYWC868fMPQDXl70OyHC1nubvifdZnNBpuNVIQOKG0Rq/ua8H44g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NIBgQCdB; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NIBgQCdB"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1770273726;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=jY15egL/xqswYHIAe5ZXNLHO6xVaiQLEyOSnN0QWCns=;
	b=NIBgQCdB0TzQ2takDRbTeGtaMbYvQhOmy4AEhcXuvA0ISDi9ey0L7wOTGEqzJXllaRGqkE
	/VytUJvjj9OEvgbphXO7dMjBldv9mKNy5letco9wEu2t85X1OTxSCauvrdwh8G+N2C2R//
	T4IDnUAd2Qy436+83VJA2HqklAPbbww=
From: Gang Yan <gang.yan@linux.dev>
To: mptcp@lists.linux.dev,
	pabeni@redhat.com
Cc: Gang Yan <yangang@kylinos.cn>
Subject: [Patch mptcp-net 0/3] Fix the transmission stall due to backlog
Date: Thu,  5 Feb 2026 14:41:28 +0800
Message-ID: <cover.1770273341.git.yangang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Gang Yan <yangang@kylinos.cn>


Hi Matt, Paolo:

During my testing, I discovered two issues in MPTCP related to the 
backlog_list, both of which can lead to transmission stalls. In this
patchset, I have added a test program to reproduce the issues, along with
two workarounds. Additional details and more specific workarounds are also
included in the notes to help clarify the exact scenarios where the
problems occur.

I would appreciate your feedback and hope we can find a better fix for
these issues.

Gang Yan (3):
  mptcp: add backlog_list bug reproducer test
  mptcp: fix receive stalls when 'ack_seq' in backlog_list
  mptcp: fix stall because of data_ready

 net/mptcp/protocol.c                          |   9 +-
 tools/testing/selftests/net/mptcp/Makefile    |   1 +
 .../testing/selftests/net/mptcp/multi_chunk.c | 148 ++++++++++++++++++
 .../selftests/net/mptcp/multi_chunk.sh        |  37 +++++
 4 files changed, 192 insertions(+), 3 deletions(-)
 create mode 100644 tools/testing/selftests/net/mptcp/multi_chunk.c
 create mode 100755 tools/testing/selftests/net/mptcp/multi_chunk.sh

-- 
2.43.0

