Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E23AB3C1980
	for <mptcp@lists.linux.dev>; Wed, 22 Apr 2026 09:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776849582; cv=none; b=kdhSIHdoq9izJTEPDvcogfrQ/bFOmgiLvfs6o8P29gt5kxPdA0LSWMObQ6V2vnujltSpoOMYiX2Z3sS7gXcB5+vSuJbvMlltWtgjC1otFfDSCjVcB22XKRz+kXam99jHBdb3T/aTGXkWfqCpal+9hzQuaJUiO9Wl38jkbH5kyLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776849582; c=relaxed/simple;
	bh=vEyguZ/0nWImqpcWaJ/11WnbWOLrYtuYHZgz3YtsuoE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GSVXiovkbnbdUbvNwTya5yGxrksIEcJ1inT2KFBmKrVf+JGIvuPAhKUrfdJcnIIbUgiqX9axyzSkf9iyIulEp7J5j9vGIdV5s4GUe+5IhUTwwdkLgciz+LzP3j3zzb7Qz83LfSCblxho+8bb2DMjWZD4tIL7TuC2Bn+9hmkRtSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gpxt0Yoi; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gpxt0Yoi"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776849577;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=EhVp/W0jHleKSpqoWSharQYpk++k1oZjDxdNvIQ8eG8=;
	b=gpxt0Yoi3EXFx6zmoFP0yV3EXviP/raIsAlO++dQqk+/oZszRFRPjIaKnPnFmuIbA2C7Gm
	TBCRGAbo921jfG70gL9R01EXN6zCA1FGDaGlWpZpvLjGcPaCS7We1r+bir85KA8FEi/Ew0
	WScwpdpQREZ1vefcntqeOScRmidiq9c=
From: Gang Yan <gang.yan@linux.dev>
To: mptcp@lists.linux.dev
Cc: Gang Yan <yangang@kylinos.cn>
Subject: [PATCH mptcp-net 0/2] mptcp: replace lock_sock_fast with sleepable lock
Date: Wed, 22 Apr 2026 17:19:20 +0800
Message-ID: <20260422091927.77770-1-gang.yan@linux.dev>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Gang Yan <yangang@kylinos.cn>

Hi Matt,

I make some progress about the issue sashiko mentioned in:
https://sashiko.dev/#/patchset/20260420093343.16443-1-gang.yan@linux.dev

The problem does exist,though the trigger conditions seem quite strict.

asdasda shjaksdjh askjd hjklajsdhfj klasjd aklshd kljasldkj akjlsd klklk

I’ve checked how TCP and core socket handle similar sockopt operations,
and found they almost always use sockopt_lock_sock() in 
setsockopt/getsockopt paths — a variant of lock_sock() that also
considers BPF cases.

I think we can align MPTCP with a similar approach to fix this properly.
This will come as a two-patch series, split for easier review and
backporting to stable branches:

    - 0001: The first patch replaces lock_sock_fast() with lock_sock()
      to fix the potential sleeping issue in timestamp and timestamping
      sockopt handlers.

    - 0002: The second patch converts all lock operations in MPTCP
      setsockopt / getsockopt to use sockopt_lock_sock(), preventing
      similar issues from being accidentally introduced in the future.
      And I think it should use 'mptcp-next' tag.

Gang Yan (2):
  mptcp: fix scheduling with atomic in timestamp sockopt
  mptcp: use sockopt_lock(release)_sock in sockopt

 net/mptcp/sockopt.c | 121 ++++++++++++++++++++++----------------------
 1 file changed, 60 insertions(+), 61 deletions(-)

-- 
2.43.0

