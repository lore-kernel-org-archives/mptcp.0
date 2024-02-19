Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEB9779D1
	for <mptcp@lists.linux.dev>; Mon, 19 Feb 2024 09:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708334987; cv=none; b=VTHb8ZAlzyhZGTldXpFKUF7QPsonP94aXPRY9BSWKoXF4QJNNkabA5S+6xbT9gFVPiSC6criBGNjR7DbXUqxB4BmoMUjmLupSsrYlUPsAMGl4oxTcNzs9cV/s9iYLge74ZksGuSbaVe/MI/1jsN+NTPEE9hDDpakmoESEC1Zx0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708334987; c=relaxed/simple;
	bh=C/nI4XCQBba+hpj9xHL+HwX+YGB9rWluiPIJN+KipXQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NAK2DJUF5BWtFAKkkQUa1YfpCecQytZfBKTvO8HtqARoNLDe4IKacEWyhz0ipQAjOCe1ctlkYjzDz7mOEtkyFPgU+dAITLvee4Zuc7J7kTklFgXrebZEvEP52C/w45tSA+HRwdyviuAJBHSPUqGzi9oFZemSKVkqToeobR5+vl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hb1ra06E; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hb1ra06E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37F4DC433F1;
	Mon, 19 Feb 2024 09:29:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708334987;
	bh=C/nI4XCQBba+hpj9xHL+HwX+YGB9rWluiPIJN+KipXQ=;
	h=From:To:Cc:Subject:Date:From;
	b=Hb1ra06EHV0Z9dD/7Bt2mH68uLtZd6tv0hXmJCPmDf3kXianZqnJf/98sav9UK4qS
	 Fa1f9NPdmBWHV6IE1qbUXwyBlEbAO8IkORRujV9lSMnIMJiJoXL114yF2zCsrLmWxQ
	 uHKiRXYLTZAWwG8wftBZS/U6ZbIe4q7Y9HcdzTwBmk20XD97VJ4cmTzPU1YEiPKmwH
	 C8iuTqo4MTu6Iz5ZRC6Q1tVyKNkr9gDga9eZRP8cuhb2JHhaDjQaOtXLqIhbzLO07p
	 pZK8Xh8pMDA/Jw07Tu1c23NlgbV1Y5EEs5SAp20kVAXjlJvSAKFNVP8Dt0FFk3coqN
	 /Q4iFbqGdYdgw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 0/5] add helpers and vars in mptcp_lib.sh, part 2
Date: Mon, 19 Feb 2024 17:29:30 +0800
Message-Id: <cover.1708334850.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Depends on:
 - dump for userspace pm
 - add helpers and vars in mptcp_lib.sh, part 1

Geliang Tang (5):
  selftests: mptcp: unify namespace names to ns1/2/3/4
  selftests: mptcp: add mptcp_lib_ns_* helpers
  selftests: mptcp: add mptcp_lib_cleanup helper
  selftests: mptcp: add mptcp_lib_check_output helper
  selftests: mptcp: add mptcp_lib_evts_* helpers

 tools/testing/selftests/net/mptcp/diag.sh     |  49 +++---
 .../selftests/net/mptcp/mptcp_connect.sh      |  21 +--
 .../testing/selftests/net/mptcp/mptcp_join.sh | 103 +++---------
 .../testing/selftests/net/mptcp/mptcp_lib.sh  | 158 ++++++++++++++++++
 .../selftests/net/mptcp/mptcp_sockopt.sh      |  24 +--
 .../testing/selftests/net/mptcp/pm_netlink.sh |  33 ++--
 .../selftests/net/mptcp/simult_flows.sh       |  19 +--
 .../selftests/net/mptcp/userspace_pm.sh       |  44 +----
 8 files changed, 242 insertions(+), 209 deletions(-)

-- 
2.40.1

