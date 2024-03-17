Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D705EED9
	for <mptcp@lists.linux.dev>; Sun, 17 Mar 2024 00:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710637137; cv=none; b=sqp/XL9vEzKyTL868A1EPvTJC++769nketZuXUK/dKC0AQLvqLuK6YMTTbMhMy8B7bQPKrMOS85BKnqkC3i03ridTKmVsfyk8ItKIW47MUGHVJ9O1T4cEqQ0Rq30OBHJAKuN8GhI8lRmNATW8TzsGo3XU6EiUJOROORYf+RD7Lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710637137; c=relaxed/simple;
	bh=iEaUziAiGy2t3wUK7bcRiyvymwQKirLIWdD5tu7Lnlk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fwsxDA8VPnR3b27Y7jbYepC/Movlw0cKUUIhB02ieqSYLoSB4QXF/LaSJ6LKqu3ETRpziwhIvAVMND1KelVc8AIg3BGib4Z/Z+xPPT0GqROqaW5zmtPLlEsWIrFMJtLr1/8Jqc1ln9tiZIMQT2UT4OBHu0qvoTbXS+ORbkdIVAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DXuppljQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DXuppljQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 641C9C433C7;
	Sun, 17 Mar 2024 00:58:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710637136;
	bh=iEaUziAiGy2t3wUK7bcRiyvymwQKirLIWdD5tu7Lnlk=;
	h=From:To:Cc:Subject:Date:From;
	b=DXuppljQS/DSLes/x6faMSPQ6af4LC3aht3HXLh8AhlDOqyP3+ShvW53aw4qTsOrB
	 Aux0wxinZix/Bv4jZT7Xm7PGbBg7vXtEU7wRpfqk3+HQ2lrY0WcwujPRX8k+4uGVMA
	 c+NzGFPEubGXYxPE41S/JFadWr8fkbc36KKemkqYuowyePW8BIHRajcKcWHN3xRaIW
	 Mx7J0R6FcXKFbLa0QhYkBO+N0F8mRXqlzlhmPl01X/5SmSf0Qk899G4vAWmkhWhAfy
	 Sovt1suDlJXLQ7LmUMEs9kaSMgxBBXATXfNQlWEPXlhsDwKxjMlWGEOHS65eXwrHTr
	 qZyVrF49SCdXA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v3 00/12] add helpers and vars in mptcp_lib.sh, final
Date: Sun, 17 Mar 2024 08:57:59 +0800
Message-Id: <cover.1710636726.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

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

Geliang Tang (12):
  selftests: mptcp: join: fix dev in check_endpoint
  selftests: mptcp: export ip_mptcp to mptcp_lib
  selftests: mptcp: format limits outputs
  selftests: mptcp: add get_limits helper
  selftests: mptcp: export set_limits helper
  selftests: mptcp: format endpoints outputs
  selftests: mptcp: add get_endpoint helper
  selftests: mptcp: add change_address helper
  selftests: mptcp: join: update endpoint ops
  selftests: mptcp: export more endpoint ops
  selftests: mptcp: ip_mptcp option for more scripts
  selftests: mptcp: netlink: drop disable=SC2086

 .../testing/selftests/net/mptcp/mptcp_join.sh | 149 ++---------
 .../testing/selftests/net/mptcp/mptcp_lib.sh  | 163 ++++++++++++
 .../selftests/net/mptcp/mptcp_sockopt.sh      |  34 ++-
 .../testing/selftests/net/mptcp/pm_netlink.sh | 240 ++++++++++--------
 .../selftests/net/mptcp/simult_flows.sh       |  14 +-
 5 files changed, 349 insertions(+), 251 deletions(-)

-- 
2.40.1

