Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3849419D8AC
	for <mptcp@lists.linux.dev>; Fri,  1 Aug 2025 23:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754091784; cv=none; b=fibS6KFtFGevbkDjex8jnb28tBr12fgu+mX9AXlbNvA2p5rVXmzCnshGQZgh3KJA08ZOMlp7FbqVogt8zKfXGa6W9DHWUwfuiW0pFK8LJpIJXqJT14eCEYlqiQ/FXbmXHV0V+R93DqHavxd6iaPkRYJjpwgx5Pll5Y0GoH1/JY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754091784; c=relaxed/simple;
	bh=M+tbvboRhxfzFLY5y0Qz/ZKzH7cDTUP12XSVM3jZKS8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cW8EU8Q2NSefTV1KwXGFDBnMULszQWLQTq35ngBhXNeoPwcfMBBL++v+frBKGKda/gz41iGUrRuCv1D50Qb+kWL8fGGHEI94ysI6KrRGUwtk8lD8Vl4hENLl9Amqo7gCogkyRlxDm83xGCtf2LGuTO6PV/MUslPhw4nfKJbyLFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZJSYJrfK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZJSYJrfK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9733C4CEE7;
	Fri,  1 Aug 2025 23:43:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754091783;
	bh=M+tbvboRhxfzFLY5y0Qz/ZKzH7cDTUP12XSVM3jZKS8=;
	h=From:To:Cc:Subject:Date:From;
	b=ZJSYJrfKGJ10dZaGQAVH6OI4wYQezGFxg5HWuCv/8l0X4iasqEChx03xN5cZ3r8rF
	 DTk1qkW9oVoxNvAlf9LqXEHc+Y/uHXq8nD2fS3kWFwHuo0EM/iArdJkDplc8IWnhf6
	 9VO4i4mnPS11LNjxxoHwyW6DhKI3TnkztO+srMGE2ba4GQLKjsdgeG7vSkrLLz0RoW
	 IdJinyhh3QnmEQ4XE0hDw6mHyQH76q6v4vOz2YXcEk0SaR9dbAQj5w57CsrQybM8CT
	 FYAIHYEZ/AULymtUUUMUZ/YvvZ67mt8+RCyJcnIjzWHo6gbK10UriFxOcAzmnSricw
	 6VI1LevDhorlA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v3 0/2] mptcp: TCP_MD5SIG support
Date: Sat,  2 Aug 2025 07:42:54 +0800
Message-ID: <cover.1754091681.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

v3:
 - limit the use of these options for listened and closed state.
 - check the return value of __mptcp_try_fallback().

v2:
 - trigger fallback to TCP.
 - check CONFIG_TCP_MD5SIG.
 - update MD5 comment.
 - drop selftests, packetdrill tests will be added later.

This series introduces support for TCP_MD5SIG socket options in MPTCP along
with code improvements:

Patch 1: Refactors TCP_MAXSEG getsockopt handling to improve code
consistency
Patch 2: Adds setsockopt support for TCP_MD5SIG/TCP_MD5SIG_EXT (first
subflow only)

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/575

Geliang Tang (2):
  mptcp: Handle TCP_MAXSEG getsockopt in common case
  mptcp: setsockopt support for TCP_MD5SIG

 net/mptcp/sockopt.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

-- 
2.48.1

