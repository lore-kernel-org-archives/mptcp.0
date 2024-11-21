Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9187413B59E
	for <mptcp@lists.linux.dev>; Thu, 21 Nov 2024 07:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732173023; cv=none; b=IztwfM8iOhqxdOyno+U3wFuCQj+P0mY2tpD2HaYn5ca6isTD2d5I2w+A85wC70vR87fQ//O6wX1bzXBTt3s04x/cySzmYvyulZ3/fszOfSgDTsukwCw6PGgzsmwXRp6TinSM2yaEpkur8I4kAnKYqilkXbpwGLXyZJs5IBqpWfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732173023; c=relaxed/simple;
	bh=Z80Em1LXC74gTO8luaiWWcYj1dk16nhMEJn7GNFHdW8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ciUftbMe9XugqQYDgIBlJuUQrotaVK6AEgdNFjQSTwY4Ih91pKh8YVUFYfVORIqD8rBCX9aZfyVhQdUzTBw56pK2uFt3YUIo96WDjkQELafxu9cGWqxBpYQ7dyzoFq7g6VcTBf5guy7pmxU6POSl1cO/XQvgHrfU+BJ2wPIrXA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ILtehQJn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ILtehQJn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2CB8C4CECC;
	Thu, 21 Nov 2024 07:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732173023;
	bh=Z80Em1LXC74gTO8luaiWWcYj1dk16nhMEJn7GNFHdW8=;
	h=From:To:Cc:Subject:Date:From;
	b=ILtehQJns3v1EcVfxcAMW2/X/SNZHGo7ECn8wceNV7e3NhGIVSoUF4SsjEMltJMS7
	 7mQp28zwba/WYI45gcO0AOFWiVzLoO5k5EMIyypf+eiT07UYeAHBr+bMTNJkM/aG+u
	 Zo87X+yWB5sGeDnltaKJbT8qhkw9w9ZV3OLeVyEUaBc91anu3+BYYjBTe/VhUPv0wR
	 q40SVd6RYY25spopObHaftBc8lBDlacBPgo4xu69oVIE3gYVctzCnSW8tn6Jxbf5Zr
	 iM73wTid9x7ItKdRibgevXaoocQ4txO1elTMIXb51OidpdjCz+qO3NJwslAoArl2Vt
	 lg9Ci7kaoB8Kg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 0/3] Squash to "Add mptcp_subflow bpf_iter support"
Date: Thu, 21 Nov 2024 15:10:05 +0800
Message-ID: <cover.1732172851.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Address Martin's comments in v1.

Geliang Tang (3):
  Squash to "bpf: Register mptcp common kfunc set"
  Squash to "bpf: Add mptcp_subflow bpf_iter"
  Squash to "selftests/bpf: Add mptcp_subflow bpf_iter subtest"

 net/mptcp/bpf.c                               | 20 ++++++++++++++-----
 .../selftests/bpf/progs/mptcp_bpf_iters.c     |  7 +++----
 2 files changed, 18 insertions(+), 9 deletions(-)

-- 
2.45.2

