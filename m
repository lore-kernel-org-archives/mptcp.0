Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E73FB28EB
	for <mptcp@lists.linux.dev>; Wed, 30 Oct 2024 04:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730261024; cv=none; b=QK3iy8Vgp6djZ4X0xe0efS+WTnSitjU8X4+Q3QwfssoyBJau9CABhdmuJIipcdbfTW/70u/vP2SrKMJ/dnB9cHBdRP/XVw/TS9m4yQ1SDGMpnCioHnZIH5/evB+Fy1Uz9fc5zvyygrW0DxUKTBeoSso0YACeKKk2LAz4aZdLF2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730261024; c=relaxed/simple;
	bh=GoBgKNHbX8OJtOfkS5aeIfA3rBBnzf87lm2dx0Io/9Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kpy1EHzL7OhG2XiH6xrwfrc2xTOyRG1BeIXD6lQJ2E4XUPsOYStQewSwA45dGd9JXhor0tc/2l923mBPkGxpI1B+iPyet5l+DXiwF4S+LTn+5wTGMGUUR1d/9SYcshHYu6fp6WZ8Wu0p5GU2ujLk2GwjTxw5uwg52jH03avwjHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sRPw+soA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sRPw+soA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C8FBC4CEC7;
	Wed, 30 Oct 2024 04:03:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730261023;
	bh=GoBgKNHbX8OJtOfkS5aeIfA3rBBnzf87lm2dx0Io/9Y=;
	h=From:To:Cc:Subject:Date:From;
	b=sRPw+soADDimSgtdkhUaFZSu2hxNUUfT6fPNCOTOW7/D2lW7Tnfb3XGhitmPiWMHi
	 htgEezOqGLIVjGRU+6OZspP5fHuyhScY26/kiyZrJx/v9+C/cHA5eEIitdDvCzsT1M
	 DZ7JjWzunFg4WtYVuGe1c1hpR9dRkfRtiS7CknEwmycPfN90TSP+4cSBKzvcAhe7eo
	 lBTnSUc3rqsi2xTkYVLQXkpCFbBHRoBHjaOKYnXC9JGy1LG7A9yznjQixc7+zvHOQc
	 D2BO5y+v+zJahCpfm3Eq6UWnm9E+oSAe45m8tLwkASRwKQBCkJR/jAlGBT0kCoLEAT
	 OHJEJVB3zVs4g==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v4 0/4] add netns helpers
Date: Wed, 30 Oct 2024 12:03:34 +0800
Message-ID: <cover.1730260715.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

v4:
 - Use netns_new/netns_free instead of create_netns/cleanup_netns as
Martin suggested.

The commit 1e115a58be0ff ("selftests/bpf: netns_new() and netns_free()
helpers.") now in bpf-next makes v2 of this set useless. v3 only uses
these new helpers in mptcp selftests and drops other patches.

v3:
https://patchwork.kernel.org/project/mptcp/cover/cover.1728530836.git.tanggeliang@kylinos.cn/

v2:
https://patchwork.kernel.org/project/mptcp/cover/cover.1715821541.git.tanggeliang@kylinos.cn/

Geliang Tang (4):
  selftests/bpf: Drop netns helpers in mptcp
  Squash to "selftests/bpf: Add mptcp_subflow bpf_iter subtest"
  Squash to "selftests/bpf: Add bpf scheduler test"
  Squash to "selftests/bpf: Add bpf_first scheduler & test"

 .../testing/selftests/bpf/prog_tests/mptcp.c  | 78 +++++++------------
 1 file changed, 30 insertions(+), 48 deletions(-)

-- 
2.45.2

