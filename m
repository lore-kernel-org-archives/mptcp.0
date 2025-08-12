Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0532DDC3
	for <mptcp@lists.linux.dev>; Tue, 12 Aug 2025 08:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754986651; cv=none; b=t9EPwpzD9j86+iHLafSP5arD3jl/CWI0YGdgxgIYqf+3tN8v0kAIKMgicGibH5c9cLjLoCj4GHTTYGInbfwD6jp2BMStflXpyE1DsE3yM+xO7SkPXj/yFX2M6pVBJXQnrDGhZHOPKLV6l36TJCrgzIwb23/Y6HzBTzyv63+lCrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754986651; c=relaxed/simple;
	bh=uGALWWNWW9pTEupx/t02tV8AwM2/doiw3+EcLwknvaI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bWtm2oFIYSra12YKPuXCtZsiodnY7y7VxF0plEViiDOx5kHfdEn/OSkqZivaYfujl5gvP/9yn/S+Gg6E3OH4h6dzYFBYKnLChB7uvZf8X8WlJv2z/qDTicjjq5CmW47pCKZOsQYhQ7uV34j1o38HpvZjbfpARGtZZbRoWXI9qjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SDKdsl3T; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SDKdsl3T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 855F2C4CEF4;
	Tue, 12 Aug 2025 08:17:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754986651;
	bh=uGALWWNWW9pTEupx/t02tV8AwM2/doiw3+EcLwknvaI=;
	h=From:To:Cc:Subject:Date:From;
	b=SDKdsl3TG4wS2mlK33VcDAW4UGVjFLBgPrgL3U5gQrtM7UJ7LyopN6XwlL4q/ojdm
	 6z4uHYUf+lyewHiJs3yuPMQfeC1FzmMki8Xtx+HMyAZWkeNznFJRFMdUIo14AR7mtS
	 4IA/5YzDiO4pCBysNUtTyPzPtq770PN4A+HgJxs+tjyspBcX/vt9CKe86CxkbdTt63
	 oKYT1MAYfqlW6YgHvenuYccflrVgX3ZNVViaH999FYi1Ves+3epiUc0DbreGEUq7R/
	 5mY49kny6nRj3yuk3Z9/X0Yy6SQZzJnX/N+80y/KD2WRT4aYOEwXBKxTMAzRqqD6db
	 +MP8ipM7Q21Jw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 0/6] refactor MPTCP socket option handling
Date: Tue, 12 Aug 2025 16:17:15 +0800
Message-ID: <cover.1754986557.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This series restructures MPTCP socket option implementation to improve
maintainability and consistency. We introduce dedicated helper functions
for different option levels (SOL_SOCKET, SOL_IP, SOL_IPV6, SOL_TCP) and
propagation scopes (first subflow vs. all subflows), addressing current
code fragmentation.

Geliang Tang (6):
  mptcp: add helper for setsockopt on first subflow only
  mptcp: handle SOL_SOCKET options on first subflow only
  mptcp: refactor IP socket option handling for first subflow
  mptcp: extract IPv6 socket option handling for first subflow
  mptcp: handle SOL_TCP options on all subflows
  mptcp: handle IP socket options on all subflows

 net/mptcp/sockopt.c | 215 +++++++++++++++++++++++++++++---------------
 1 file changed, 145 insertions(+), 70 deletions(-)

-- 
2.48.1

