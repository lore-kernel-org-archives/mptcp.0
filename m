Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E125051026
	for <mptcp@lists.linux.dev>; Tue, 19 Mar 2024 07:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710832582; cv=none; b=QLMlm1vlRFHlvzNbYafa9KodwZ1LnHFgxtuCeK5ZXj3Tdj8vOsSDgcAIyIAddoT2j4kmjSMSlC5tD3OuZJd01k0vXhFVEadSRwkKhb36WqPocOS9y/ge9R0Ag8i40Q885ErTVOFxnfibF0kXh5+dv/IW/D2PHVni9srcSceQDTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710832582; c=relaxed/simple;
	bh=qdJkvHrhGPJO1FPgq3huUdF/jCap+ujSbg5dTPeplFM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TgxNPL034A/7s4QICf6B1oFo8MpWaqKrDtgx7KNqhv2YkH1LThAXBRu/H1ZHfdpmWr3NJYJ4aNuqOpk6LZ9J/hoXcXkSI197oV8iHCvgFaRr54ZPS6dOgAsX9fgHubM4lvbl0s1A0SV/lSBiU2t2LLXnLPdUsJ0m+EK61Sun1No=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KPObjBTO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KPObjBTO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DEF9C433C7;
	Tue, 19 Mar 2024 07:16:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710832581;
	bh=qdJkvHrhGPJO1FPgq3huUdF/jCap+ujSbg5dTPeplFM=;
	h=From:To:Cc:Subject:Date:From;
	b=KPObjBTOuLPCWn017hDHoM6t129dGCZY6xc2Z2ImkhLUf15BLNzq1mNMqg8VtAdG7
	 k0QfePK2K0lqI5Sji3iGbH0vEHgqEyCd9M8tqe6p4PHm43jiUMtlIfNRxCcdH1WuJ1
	 9/wZlMxdxtcKqCHRCcUwtYWcFXUpX1UTERkCIRk4ZnNaiffXwKzUcks/tamQe97h4R
	 K2/RIK0drDaK/thHTzzQE1OxcIx7rs4vBMSuhkO/BBo4+5xJXSGvZJnIcSQCf3RWm7
	 la9GZJ1n0DVTzi97c87t34RAghper4dnKoJ9jYzvFQUcCsp12Lo87nPxR5S1CFDQtR
	 h9w8d9mOkn+QA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v4 0/9] add helpers and vars in mptcp_lib.sh, final
Date: Tue, 19 Mar 2024 15:16:06 +0800
Message-Id: <cover.1710832493.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

v4:
 - address every Matt's commends in v3.

v3:
 - use check_output in pm_nl_check_endpoint.
 - split #2 and #7 patches in v2.
 - put "selftests: mptcp: join: fix dev in check_endpoint" into this
   series too.

v2:
 - address every Matt's commends in v1.
 - depends on "selftests: mptcp: join: fix dev in check_endpoint"

This is the last part for "add helpers and vars in mptcp_lib.sh" series,
add endpoint operation helpers into mptcp_lib.sh.

Geliang Tang (9):
  selftests: mptcp: export ip_mptcp to mptcp_lib
  selftests: mptcp: add get_limits helper
  selftests: mptcp: add get_endpoint helper
  selftests: mptcp: add change_address helper
  selftests: mptcp: join: update endpoint ops
  selftests: mptcp: export pm_nl endpoint ops
  selftests: mptcp: use pm_nl endpoint ops
  selftests: mptcp: ip_mptcp option for more scripts
  selftests: mptcp: netlink: drop disable=SC2086

 .../testing/selftests/net/mptcp/mptcp_join.sh | 147 ++-------
 .../testing/selftests/net/mptcp/mptcp_lib.sh  | 128 ++++++++
 .../selftests/net/mptcp/mptcp_sockopt.sh      |  34 +-
 .../testing/selftests/net/mptcp/pm_netlink.sh | 294 +++++++++++-------
 .../selftests/net/mptcp/simult_flows.sh       |  14 +-
 5 files changed, 366 insertions(+), 251 deletions(-)

-- 
2.40.1

