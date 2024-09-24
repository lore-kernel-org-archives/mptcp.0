Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC5B43F9D5
	for <mptcp@lists.linux.dev>; Tue, 24 Sep 2024 12:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727180852; cv=none; b=Xy+b2mjU2jS7xmzYlkxArUY+SDeu75pfcVyyAITQiy8DBsaevIJSzkKw4mi0grGNac26niRQVJ5Lt8v4xmIu7sTjSGJE35KT4D46if1QHFcBH9skmOzYyejHUUkoDOiO7G8eUjj53CGpzjw+5eQLM6z5IzJaHXSoPbHfVnamGFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727180852; c=relaxed/simple;
	bh=7F2S3O/oQD39TG24eqNEowBAgimecgOF5uRYhG4LfMM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CTsUYtem2NvmIWHXp9f59OkUZEBO8nIKxUxpNwhMZEF8vgU981ZgBddIS9AA3P2k6kJPBPb5ymS5In8G6uMl8SAWtGfLAmXjRDSNNAdHAeam5/njpyKshGGZhv2NWo+Re1Q2tG3RD8tI9XTGqc/BKvTVG4TrYANF/GW0EsuWPJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tPCoD+T5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tPCoD+T5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30C88C4CEC4;
	Tue, 24 Sep 2024 12:27:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727180851;
	bh=7F2S3O/oQD39TG24eqNEowBAgimecgOF5uRYhG4LfMM=;
	h=From:To:Cc:Subject:Date:From;
	b=tPCoD+T5EskmCvq52CYPBomGmUOkEh9YtdtZaTGCLWOvZpnVQ5aARynxdOGt+fLuR
	 6u2gqGKegvNt4d5nOklMaLgp/w6opHeUsML1lanoy7B+XkBdU0x9Va60sFMJS+i6Rz
	 H+4N2oboRjiinUP9QzeGI3SuO8k+jODCG1GHZT6TJa0Y4Y4ebUNx8skIugoJQFt5S+
	 IpUeDZwVtMz4lMAPNJD2wHziGmh9Gmlo+DAE0qeAGg9sX1RY90l9c1QB5+ib2XHo4n
	 zGP1m5DVXyMT5tfIXtlp5buxkFC2yLZ+PaEFxCNAaRLeGghqg6zQxJwBvWE0Oezp8f
	 vmjr4jA3ICOKw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 0/2] drop skb parameters in pm interfaces
Date: Tue, 24 Sep 2024 20:27:23 +0800
Message-ID: <cover.1727180731.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Drop useless parameters "skb" in get_addr() and set_flags() interfaces.

Geliang Tang (2):
  mptcp: drop skb parameters in get_addr interfaces
  mptcp: drop skb parameters in set_flags interfaces

 net/mptcp/pm.c           | 12 ++++++------
 net/mptcp/pm_netlink.c   | 10 +++++-----
 net/mptcp/pm_userspace.c |  9 ++++-----
 net/mptcp/protocol.h     | 13 ++++++-------
 4 files changed, 21 insertions(+), 23 deletions(-)

-- 
2.43.0

