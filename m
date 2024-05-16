Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C151311AE
	for <mptcp@lists.linux.dev>; Thu, 16 May 2024 08:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715848744; cv=none; b=F5eoB/kbRmwGox/Zl66YX1M1j4I+F6i3uWZsPjyjwTUuBjPT6SHODx5qZHYRelyEp+W1nRnxnnaRBEl71H6AKp4sM8aUbTTDW5uZo6xohI/0QgIpuadZiQfAo7cEJevFC49x5PhqnIOBC15tkrqNjlmicehGI8TLz8UuQJwYuFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715848744; c=relaxed/simple;
	bh=ss0UohwsVxJk5+8aPvsrw2EdWBK3NgBuqLY3ruBOvqc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=B6EkRaB0xWPOaaem5II0XQGfpPpyB9ZdiPkmiCdOOmLRjBrVGAfv4NM29xF6eDlR/8BSAScB/cBr1Vc6OF/zzXwg0fspiN3mf7CYIvCGqDSHmPJwE+Jn5Wx8UwtErea+luj2p3Oy0gcMubV4nKj+ivWjdAZpEDszBiaUFgPxyi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JrDuQ/au; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JrDuQ/au"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8358AC113CC;
	Thu, 16 May 2024 08:39:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715848743;
	bh=ss0UohwsVxJk5+8aPvsrw2EdWBK3NgBuqLY3ruBOvqc=;
	h=From:To:Cc:Subject:Date:From;
	b=JrDuQ/aucZt641Dli381I/BY6uzFaLOrOshdfSRPlnU/npm7C4Jvy52ovDqLGH8hq
	 VZ/hXz8lCPKuFQ8ClACPJ2H16p+zcfxZqO/cvtGO7MwO4bOKakmKHSe4wDLShgQ3lX
	 s5iWKah4hD6PGrcITw64ppGqHUJrEmJSfNeQu8Wi3xPhHLbzHuXbhXyRE2ZNyEReIT
	 f+9iM5JGvch9JOO33fwiJAP5bmIbZQSVXpeWB3b4RGYTxyyBjquYD2KMHCVDpG7DuR
	 GsAgJI/+PKK+XrgInM6D7oO8FyadMAnKsYL8uIpx01yzADi8NDiYvwVoibVnfOhp+n
	 E63vgVsx1gmgg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v3 0/2] fixes for create_netns
Date: Thu, 16 May 2024 16:38:55 +0800
Message-ID: <cover.1715848543.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Since create_netns() is updated in "bpf-next add netns helpers" series,
some mptcp bpf patches need to be updated.

This series epends on "bpf-next add netns helpers" series.

Based-on: <cover.1715821541.git.tanggeliang@kylinos.cn>

v3:
 - add based-on tag.

v2:
 - drop patch 1. Now netns is deleted first before adding it in
"selftests/bpf: Export create_netns helper", no need to use SIGINT
to delete it anymore.

Geliang Tang (2):
  Squash to "selftests/bpf: Add mptcp subflow subtest"
  Squash to "selftests/bpf: Add bpf scheduler test"

 tools/testing/selftests/bpf/prog_tests/mptcp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

-- 
2.43.0

