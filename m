Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C33D22E0B6D
	for <mptcp@lists.linux.dev>; Tue, 12 Aug 2025 08:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754987182; cv=none; b=SZddTuBGVBMOzQNJL/IrPqQBzqfU8EHQYiwN+bsj5CqAUzBw8rswPorZs7OqQ3FnvJSo0db8Fp/Uy+/bRnOzxm12J4ikVKDGzeICZjg14hvc6HK6RHjJxb1O97txAD0OfUjD6OTsaqYzQYEMcWu7Hix6wu4Ph86evBUm5meTkYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754987182; c=relaxed/simple;
	bh=DP6m2l0kVJcVd/UjaIaaY1JmqE/AaGTdDX9dwW2/xqU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=p0jtDmmUSEg2aYcIIbT2B1rxFXAuBO+8//OrJMi1sF5nFh5JPWxvH812DkYHvkW0NQhXPFXvIlYj1wdGAwJqlC2yW1ValC5CwaSMuQfPFcPLwqEcII0LroLKqSd6IvCB45BAC/GpJ+tI8y3LOA5PAquJeJgSW1/OGhUO4yZy/dU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KCBylrvX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KCBylrvX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C907C4CEF0;
	Tue, 12 Aug 2025 08:26:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754987182;
	bh=DP6m2l0kVJcVd/UjaIaaY1JmqE/AaGTdDX9dwW2/xqU=;
	h=From:To:Cc:Subject:Date:From;
	b=KCBylrvXIzcoz2h5HjZ3Yoq5YNdRaLFTr8gel5VTEeqYASsCOu+Uo0bjneQoFqtWZ
	 UQKlxaVThX7CjiFez7wamT7xhidMqqOl80Imjdm5HgvXyAytwgpdgDBBXXQWjksvTP
	 kitBly+60GDZtpww3Ye5heZ0rYQRlp3mw+4SgwhxkBM9nsOm/2OoLx8Fh4bvoveipS
	 J3qIE/kmQUQL8B+z/Hvr/WCB7ZFVene1fmmqXtuJSC5Cl7AxeQoU7Sl6dMlDmqE8US
	 X+Sm6tpEKWv/igA/tLlDjos4yR+WYPYM+JfCBhoE9UWMXndD9qVjidmpdmdamY6LC3
	 oaPyOXp6ihgrg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 0/3] mptcp: add more sockopts
Date: Tue, 12 Aug 2025 16:26:11 +0800
Message-ID: <cover.1754986785.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

v2:
 - Use and extend mptcp_setsockopt_all_sf to remove duplicate code in v1

Depends on:
 - refactor MPTCP socket option handling

Based-on: <cover.1754986557.git.tanggeliang@kylinos.cn>

v1:
https://patchwork.kernel.org/project/mptcp/cover/cover.1754126092.git.tanggeliang@kylinos.cn/

Add sockopt support for IPV6_TCLASS, IP_TTL and IPV6_UNICAST_HOPS.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/568
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/296

Geliang Tang (3):
  mptcp: add IPV6_TCLASS socket option support
  mptcp: add IP_TTL socket option support
  mptcp: add IPV6_UNICAST_HOPS socket option support

 net/mptcp/sockopt.c | 54 +++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 50 insertions(+), 4 deletions(-)

-- 
2.48.1

