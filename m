Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 163B01CD1F
	for <mptcp@lists.linux.dev>; Thu,  3 Jul 2025 08:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751532434; cv=none; b=QAeicYYPxRdLB6UDUU+wF0noq75kM0qg7h+YUXhBjvlHFldtt8GGJNZcKv7HfSvCFhaMpKpZq7GZ7CedSCO5DEqyy7QpXDBLQj0df5X2cVWOkGY64MqmUL05qsFgZf+JyOWU+mr+cEoTPArbfky7yduCzHj1Fva2i/UbpNzoqnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751532434; c=relaxed/simple;
	bh=8LZR1n+b8WDwa5Wd/DV0Uar1lMe2XrXTz9Cb4x0kaow=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EQrqOtpFUW1osmetzBddIloV0LYei5lYXrUXiMLC6kprDaH82uH6hfdSXtQ2jT4rlRI0wBBRmI1pDxV5/uQCYqd21ysawH4uaX/HPp47fjdAInri+kzIafkEUnrcmdOTn+0pQmiiyyeISr19AaN6wuBuyNJeBrAEHBf8yElPJRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jzIb/S9i; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jzIb/S9i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DFAEC4CEE3;
	Thu,  3 Jul 2025 08:47:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751532433;
	bh=8LZR1n+b8WDwa5Wd/DV0Uar1lMe2XrXTz9Cb4x0kaow=;
	h=From:To:Cc:Subject:Date:From;
	b=jzIb/S9i9PvTCZiJ1JdxcSHsdJ+p1oxbmfHZLnoZuofq4Gd7s3CPR4fPdvZaYF6br
	 U+pT78uUfXPBvb6pfNOeA9qt8aoPVNAHOFdhuOwt+X6t+p6waFbsJfaawS+nqi1c09
	 6paiYlRwtGzgqdWW4fHqfqJVKI7Vqufmrg5NB5GwiO/Iqp9N2Vqj9Awl4h1Z9jxiuG
	 nPcYBo9a/c3i42LU+Y2sSQrRVIk0nVQtYK4MXDnpH30dB9Uo3UNLimpPTmzw/kUVvg
	 DgqkKvajk6r+aCJ6+eLjmlmJUyELIACN/FFgrgDk70sRk6aGkXmmrLx8Z0Ct68tTVq
	 CvTcRKrLYf5Rw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 0/2] Squash to "implement mptcp read_sock"
Date: Thu,  3 Jul 2025 16:47:05 +0800
Message-ID: <cover.1751532205.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Two small cleanups for "implement mptcp read_sock" v5.

Based-on: <cover.1751093346.git.tanggeliang@kylinos.cn>

Geliang Tang (2):
  Squash to "mptcp: implement .read_sock"
  Squash to "mptcp: set .splice_read"

 net/ipv4/tcp.c       | 2 ++
 net/mptcp/protocol.c | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

-- 
2.48.1

