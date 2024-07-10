Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E9712C491
	for <mptcp@lists.linux.dev>; Wed, 10 Jul 2024 13:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720619176; cv=none; b=CTZ5PQUdQgV3voO0xBCE61d7MdYJBgWR2Y0B3v2SM5AYbtVrVayIMAHz9iaBbh4woC2KHaMImNBt6y/j/wzi8tstRcMjuECqxZwXpxCUmdZQvX2UscCFUAHBCk6VaEPhZOcuk7E4tgeT9le5hg4N3P8BMfMKimcuUw16HjkcKjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720619176; c=relaxed/simple;
	bh=DcVLRlnMtX+xlbrEIBx7qjh2+dN8br6Aua+ygnlFRik=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Dn29KWHJX1wl0FIjXV13KBwvc0Wz2DOOWdvNK2GNKLa41qcTjd8remkuFEmeUnj27e2xleaN9MuXqHgmuZhMZf4UvnMyo5/vNnz95lAyV4juZmxbpy+PppfYBJ2sQRHPIqdF5//5VYMvhUG/DGoFDNzfuseZrBaMPZZGdVgvOJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oGqzZLoS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oGqzZLoS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15980C32781;
	Wed, 10 Jul 2024 13:46:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720619175;
	bh=DcVLRlnMtX+xlbrEIBx7qjh2+dN8br6Aua+ygnlFRik=;
	h=From:To:Cc:Subject:Date:From;
	b=oGqzZLoSJQP5P2lm4PJN8PC4PewaG5mGJ1mlpzbILQLf5ENfYS8D9zdlpP3BMDHG5
	 /szTOa4XtoYwADAl4T3fU5bLlppAnrgqS20979CbeP8uR3e/0W+3d5mnvckx1yBJ9a
	 95OgGd/3I0xyUp5BRW2GKSgovKdCi8XRADPwE4oWwn8EZQZJZK8y4Kp12pagWeFmsV
	 b89HT4ks7Rl+YRQyQ6M/fUW4Gz6r1vZtKWOgBmlZ/mKyPLq4qmfZHWGXa0E6eHbkq5
	 DOi00VzBLas+hSyIYrgFQBmSmCNt5kZM5cxHdKsXiPtyA/nk1ibV4xT909Zp7QLrKN
	 j18iXeSPCx87w==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 0/3] get msk->snd_nxt with READ_ONCE
Date: Wed, 10 Jul 2024 21:46:08 +0800
Message-ID: <cover.1720618186.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Get msk->snd_nxt with READ_ONCE() in get_subflow() of the burst schedulers.

Geliang Tang (3):
  mptcp: add mptcp_snd_nxt helper
  Squash to "bpf: Export more bpf_burst related functions"
  Squash to "selftests/bpf: Add bpf_burst scheduler"

 net/mptcp/bpf.c                                     | 1 +
 net/mptcp/protocol.c                                | 7 ++++++-
 net/mptcp/protocol.h                                | 1 +
 tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c | 3 ++-
 4 files changed, 10 insertions(+), 2 deletions(-)

-- 
2.43.0

