Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A87337FF78
	for <mptcp@lists.linux.dev>; Tue, 17 Mar 2026 08:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773736673; cv=none; b=p0DIE6c3BQqImLTTEoQbiQOuW++7l8aH5CeAyhoTbgojytpzQx/cBlns6ob6xviI67FX5GQMiNiDb0D76nWaVZPwK61Ehzu8kePUq+KgnSQZFYmFgqICGL3sLANI/OkGNk2k8yoQekudGg4Cljk/1SmXxSOhqensgCwl5Iw8/Tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773736673; c=relaxed/simple;
	bh=GyHparyXIRiSwfGoHQQSYtrMfYE5HWMYLQqH6EcT2jg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k12EDYdnNh6zPhSoxlzihd1TeS6CEEHysRNGpf5ull/Q6Ty+nyY5A64Hz2/CujjYBBUaD3281TpS387Fc4J8Qykvz3HTMIN4aOiCrxpyuCdN+DqmEcwlmUjbxAtyH9CUnbuOzWSBqjVmyBP+h1U6a32DUcnaed6JGPoPwSTzCIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=L5+QGiIJ; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="L5+QGiIJ"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1773736670;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=mSQ+Cwf+IVisGgPIoDFLlthGbhvSUtMshOlYLilb9BQ=;
	b=L5+QGiIJHGZbdv830LYN2WjKq+c/m/NEhG77t+/nYSEJqalERNXC5GLZ4hU5GYHZz7a3fs
	uIN9BqfQ8EipbyFP+l8QGE4fo1l0vxijfI1lpY9bKedA7A54ikPREJhuZ0Vxko69fJFPqS
	fJgkG3iH4p8ch51MmNsSd/To0cneq/M=
From: Gang Yan <gang.yan@linux.dev>
To: mptcp@lists.linux.dev
Cc: pabeni@redhat.com,
	Gang Yan <yangang@kylinos.cn>
Subject: [PATCH mptcp-net v3 0/3] mptcp: fix stall because of data_ready
Date: Tue, 17 Mar 2026 16:36:54 +0800
Message-ID: <cover.1773735950.git.yangang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Gang Yan <yangang@kylinos.cn>

Hi Paolo,Matt:

The patches have replaced the original backlog_list with an rb-tree based
'backlog_queue', and resolved the existing transmission stall issues by using
the new backlog_queue infrastructure.

Looking forward to your comments and feedback.

Thanks
Gang

Gang Yan (3):
  mptcp: replace backlog_list with backlog_queue
  mptcp: fix the stall problems using backlog_queue
  mptcp: fix the stall problems with data_ready

 net/mptcp/protocol.c | 93 +++++++++++++++++++++++++++++++++++++-------
 net/mptcp/protocol.h |  2 +-
 2 files changed, 81 insertions(+), 14 deletions(-)

-- 
2.43.0

