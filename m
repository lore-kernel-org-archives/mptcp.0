Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1DF322094
	for <mptcp@lists.linux.dev>; Wed, 19 Mar 2025 06:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742364490; cv=none; b=CqpWfjSJJ1ap9X12cxcM+uewXax5TJDFY5KYI1YE8uMHDL3MigaURDO6PhihXb90gcXb1w9sVPOb6qvuLhihyBt9gGT+Wr+tzZS16TuLcp6t6jsBOml08HIh7AKk0ySZoXv1KwQYKEX8q1BAD0QOrCjMiNX67ph3Vm3K/uWZygo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742364490; c=relaxed/simple;
	bh=BJHrS0HqlZqg1Wx0S3i9dyMCFwT67xSaocQ254w/1+M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YF3ArMFol8FGHo4dXt1kshMAUcUkI9o8dqHUnXq4YDuNJeyJ5qK93aw9p92Ks3CQz5Mc/RWUZ9gL44pXprQFqoUaXiWCBpfejr+fWdJedMwpWpp6TTR9uOEfPz1i52tLZR4WIAPibklCcwIleIk15qs1PBvfepn7Mgrv9cqewrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=haP6J98m; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="haP6J98m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D52DC4CEEA;
	Wed, 19 Mar 2025 06:08:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742364489;
	bh=BJHrS0HqlZqg1Wx0S3i9dyMCFwT67xSaocQ254w/1+M=;
	h=From:To:Cc:Subject:Date:From;
	b=haP6J98mvgd/fH/rUcR0TnqLqmnN1TIi6iBTtPOZzU6o1DCzYQH09kYeqgCL34BlM
	 3/5MiQQiKnCa37XZqe3zGOkdpogTh8V41kfHWPqUs1QYHcLxW2x8MUjycLJ4+R5OeM
	 ufIImhtWV2DV2D2OGe9nEO0stDJYJegoFWemx3h+kyQY3UUM/SxQ+j/3QlEz4lZ+65
	 Y1Ner5GiIv5KWHMgzaYDAXWLGz87CgPAHFJFlc5E0I8R+uOOvwRuN2/IN5aC3DTEaE
	 h/pQ9dM1yk7iD6OV27/6d/FwpzGXDDhUjJx7tf1UQ4u3lcXSVtQo/D+Hp37oufWDjC
	 K0M3sLMlV0UgQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v3 0/1] cleanups for main_loop
Date: Wed, 19 Mar 2025 14:08:03 +0800
Message-ID: <cover.1742364129.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

v3:
 - don't remove the second "open(cfg_input)", it breaks the disconnect
   tests.
 - no need to "close(fd)" when copyfd_io fails.

Based-on: <59caf78b9d67a0a61a19a46f7820456f6ced3d6e.1742296236.git.tanggeliang@kylinos.cn>

v2:
 - update the pending patches from Cong Liu, he said to me that he has
   no time to deal with this recently.
 - delete the second "open(cfg_input)" instead of the first one as Matt
   suggested.
 - drop freeaddrinfo, no need to do this.
 - https://patchwork.kernel.org/project/mptcp/cover/cover.1742355162.git.tanggeliang@kylinos.cn/

v1:
 - https://patchwork.kernel.org/project/mptcp/cover/20250113085228.121778-1-liucong2@kylinos.cn/

Geliang Tang (1):
  selftests: mptcp: close fd_in before returning in main_loop

 tools/testing/selftests/net/mptcp/mptcp_connect.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

-- 
2.43.0

