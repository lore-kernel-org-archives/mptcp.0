Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1743B84D2C
	for <mptcp@lists.linux.dev>; Fri, 13 Sep 2024 09:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726218272; cv=none; b=JahMw+sukFtV8sd+qwlxB889wBgRahBVaWjTvSlvPh89/xUpYEIZPe0pgNc9gkiWaRWQN4BDSSbKEXgVW2UGJfmpyGRuWd0Y4FMoOZmK+iqHUyN7HYFGXVgcidTQDol7+0+tWVexF63OaoH6Dh3SvioiVRu5roCuNqaZsERIadk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726218272; c=relaxed/simple;
	bh=uCbjJOxxAGUw+C1Ru8xV6LbbCKPIr6eCiL/ewFoV924=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bywq3jLu8kjY2iSBZxc2yOfOwbMnnyDfUgH3O+740pBgQ3lfnG9GfA1FD6U69FoU5Bfv5sMzG5bJa1eBGM769EOM+sk6nB1BrCvK9vrWgNtouwmYK6cVSREjd/URrNqOyJP8TCa+0aQTSrauCVjahStkZsULALZdzzUTBY00r18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ba52yt0y; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ba52yt0y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82AC2C4CEC0;
	Fri, 13 Sep 2024 09:04:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726218271;
	bh=uCbjJOxxAGUw+C1Ru8xV6LbbCKPIr6eCiL/ewFoV924=;
	h=From:To:Cc:Subject:Date:From;
	b=Ba52yt0y3gOIxLIIBCw+ZywLmG6lEduXu/qN66/8LGL+VLjG//tBWhOJVbGY2VDJm
	 F7BoYVHwKGmogjXnqKRTj/4soRXcONCud9WteOMwuqeb4TinvPjoExHIFAzbY6ebU7
	 xOdHmTnVBd2SV7tvcev++9bEUN3mH9u0Io9Ne0PNeNUrcC0oJKQLGF9XROBS+KpG+q
	 7gf9FbS8nVTcZaqsGSQai2ngICyOuhDCRMHfqsLz6FoVrBqdxv6yJYxV0TC9HOWB32
	 gm/Fc6xVfKpDlw4lqiSZLEgu18A6dj6rpqOEcVSZGI3vdf+z85mfhdUg/pSJCZ6/Ys
	 BSaV0G2dtsg4A==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 0/2] cleanups for endpoint_init
Date: Fri, 13 Sep 2024 17:04:23 +0800
Message-ID: <cover.1726217806.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Patch 1 adds a new parameter "subflows" for endpoint_init() to make it
more flexible.

I'm not sure if patch 1 should be as a squash-to patch for
"selftests/bpf: Add mptcp subflow subtest" which is under review.

Geliang Tang (2):
  selftests/bpf: More subflows for endpoint_init
  Squash to "selftests/bpf: Add bpf scheduler test"

 .../testing/selftests/bpf/prog_tests/mptcp.c  | 27 ++++++++++++++++---
 1 file changed, 23 insertions(+), 4 deletions(-)

-- 
2.43.0

