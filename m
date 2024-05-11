Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 680AA1C01
	for <mptcp@lists.linux.dev>; Sat, 11 May 2024 08:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715416659; cv=none; b=HDK9bQ5nMzp0vzMzJQeliBHp7sfs1aBqkBexzTV83QjzGQHRgU57qgLGo0qa7374SMkq0VJ+ZkgLOMnFfMIgeK2PieJHgZ7R8hG+ChfKH7qA5Sv+S67h/KFd7u9E4Cv5QkRCZmLRy0HFmWP20n5LlM0dG1QU6I1mLzxhN1P6rNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715416659; c=relaxed/simple;
	bh=2y7BzFZuzpzBgKCd2XSDPBMksjdqriKThwvj3Ol65qM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ccyXHe635GdAotzPdzg6tV6V8cKypUW42HclN02azKrPi8omhWOvTT0IJqPZ21cuFs7GVE+ctPnca+Ws4By4iRisDWGU5YNASJFY0fQY+2ioA1OxJa1KTWrkQYPAUMcDCdHL/aIM4pCJLlv70Uzk6nBfF5ZOl5izIsi+53DBUuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NZLit32I; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NZLit32I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDC6DC2BBFC;
	Sat, 11 May 2024 08:37:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715416658;
	bh=2y7BzFZuzpzBgKCd2XSDPBMksjdqriKThwvj3Ol65qM=;
	h=From:To:Cc:Subject:Date:From;
	b=NZLit32InXSD5X+Rax+oDf+W41lTMbJL3mao2KxYmKrVIGpFVLYRxe7t+1kdBFQJo
	 DGkqL91QjUifejzlY+a5t7TsZjjTWNoIWsfDjNvH7ZqBwCsWj9ZasapvkYNyieCzsB
	 8X6FY1Nog2JyCNDYryfSl0mXrsWC3Se8ZPAYMDLdkbgXdLRrT3l9J0V9V7lr0R2ba5
	 1pIRmLvckrbfl9en4ewnOdYe3Cr7IF++w3wKDWkOKoqBgl0hI0l/h3KikpUPKs5pg+
	 HQ0g3YKKhqdlp3LERLgCrl856isa5dSyqputP8/SKdYCQxlwblSGqzCgGKMflKaGDW
	 ECDHp8mr/cjTQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 0/2] convert helpers for win and space
Date: Sat, 11 May 2024 16:37:29 +0800
Message-ID: <cover.1715416511.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Paired with mptcp_win_from_space(), added an mptcp_space_from_win() helper,
use them in mptcp_rcv_space_adjust() and mptcp_set_rcvlowat().

Geliang Tang (2):
  mptcp: use mptcp_win_from_space helper
  mptcp: add mptcp_space_from_win helper

 net/mptcp/protocol.c | 4 ++--
 net/mptcp/protocol.h | 5 +++++
 net/mptcp/sockopt.c  | 2 +-
 3 files changed, 8 insertions(+), 3 deletions(-)

-- 
2.43.0

