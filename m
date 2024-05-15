Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B124644C61
	for <mptcp@lists.linux.dev>; Wed, 15 May 2024 06:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715755472; cv=none; b=nag2HjUdduyxbRcLTIjcDRWFU+rWRpJ8gg7KOhVSbIXxdznb7c5LqZNXF5AwA3voxlPzPsIN6X0/p1D2DLFlsq9dLn7vE4chD5Yr9H5vIhGDZV9i+wJGTja6LuQK7egIRi3EvRhFFLKeri9yAJMD/u0aNuOfJS8/YSji3n8OzPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715755472; c=relaxed/simple;
	bh=RYx+3aOeKeVhgF7HH8TgtffCaBy43KcW0LdnUgh8VL8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lbSvGTuwJmfmiUlm1LwhrGHu4O+SRf070q04iH0cDrZI7H8ZpN3ICxkHOgSuQW06ZIjBCACSqGc9+S3H9bL1NU+p4sDcG/+iWReMvld1eWFYh/Xc6U8wV8GgB6XwR9D0UEZX99HrSQ/bWl3bQSrIVeZiQ75hTHPL8/WPuvWADhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y8txCTIw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y8txCTIw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C33FC116B1;
	Wed, 15 May 2024 06:44:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715755471;
	bh=RYx+3aOeKeVhgF7HH8TgtffCaBy43KcW0LdnUgh8VL8=;
	h=From:To:Cc:Subject:Date:From;
	b=Y8txCTIwSmKCN6AP9r8zyeEWYgLl8rpn/9XnrRoX1QlNBGCJlIqZnijiDZQ94KyJE
	 ceFQcGW2lWjEEHm8/4nKrUXHsihMZmpraHjiYeVc1sYQpOPiL7XR6J94Ev+MIErDC6
	 5a8vK0q0RoetTKnUTGjrKoEezNh6eV6RBXFB+Fww+CTYivEl/+Yf8z49r4Aanx1nAb
	 pMOuILIyPkX6e4afpFF6LQXbB+VeDcE5VvhNGqwdm8DimzCiXGW+dBJWZwHvfzfYry
	 K9V4P1cizV+sAEhrcvU5V3h33XjNuCdt523aULypR3xCVz5KXCUEgwvg2DC4h3G0jK
	 eXCmaoeCh+DJw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 0/3] fixes for create_netns
Date: Wed, 15 May 2024 14:44:20 +0800
Message-ID: <cover.1715755275.git.tanggeliang@kylinos.cn>
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

Geliang Tang (3):
  selftests/bpf: Handle SIGINT when creating netns
  Squash to "selftests/bpf: Add mptcp subflow subtest"
  Squash to "selftests/bpf: Add bpf scheduler test"

 tools/testing/selftests/bpf/network_helpers.c  | 12 ++++++++++++
 tools/testing/selftests/bpf/prog_tests/mptcp.c |  4 ++--
 2 files changed, 14 insertions(+), 2 deletions(-)

-- 
2.43.0

