Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 627E0190468
	for <mptcp@lists.linux.dev>; Wed,  6 Nov 2024 03:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730864615; cv=none; b=MiLpdyXa+L0BgLPxeoVePuqASD3dsu0xk+cKdHpOfI4nfYMIwk5+uexGQzs/LwtY7N8Yl09GdrwebCpuFNnf9R0MYzbuaHtzhyKwNWw/+gm9AFspgY7b+L2IEKbTViRS4LV9H/T1ln2x4yLWtqpk0ntD1q6DMkNg55mSxiiYbfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730864615; c=relaxed/simple;
	bh=12B/kSKT9v/2W4uBG1Kk2eyRptZvMxDqzFZoj+9kxw0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=O/xMwDtfAhY7rUBxoRIS12cTZSaARvw4eWw28LFHsG06NZSWOGkVQfPAoW9/8MQhOsTmCALmtks5dSThN9SGNpcp7veY09lsDh9T9nccNtTaJkZVo2B3CuJjnC2J/qXlGquqfHXcR9sYPnlym1D+raDdex3dKOy9o4cdZczHr3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WmxSIVXA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WmxSIVXA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B906DC4CECD;
	Wed,  6 Nov 2024 03:43:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730864613;
	bh=12B/kSKT9v/2W4uBG1Kk2eyRptZvMxDqzFZoj+9kxw0=;
	h=From:To:Cc:Subject:Date:From;
	b=WmxSIVXA5d7O8QlXE2eL7KdYWlouGXrKp3is2zIV0CKVnbqNbGxWCgVHPsZuJEQto
	 nKQc6URP7zvSm6nZvRUHfO+xIy3kL1tIdGHWgDNzBCcjkaXHtCNdwmDUm6+RInvBSO
	 PMdqXlQbBa7H9beXCQcbm9QVbs9hXxwgtOO6CfDXLQDoInX+y+SM7Z+16fcbQ9nR2q
	 zRqq+tRrSN3V+3yCqhWG/phTCJsBbDLLzElkyjmxQd75Kv4YMAPacs6gx3YTRLEDGW
	 oVd/7bYTwwFV9e5g+qY+71bMDVY2ws87dA2/olbarA+68wqlC/Bi6jOK7WiGiX9uvt
	 e41+ZyBbIwmyQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-net v2 0/2] fixes for userspace pm
Date: Wed,  6 Nov 2024 11:43:22 +0800
Message-ID: <cover.1730864444.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

v2:
 - move "add lookup_addr for userspace pm" out of this set.

Two fixes for userspace pm extract from "BPF path manager" series.

Geliang Tang (2):
  mptcp: update local address flags when setting it
  mptcp: hold pm lock when deleting entry

 net/mptcp/pm_userspace.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

-- 
2.45.2

