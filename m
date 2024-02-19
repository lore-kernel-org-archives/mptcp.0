Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E267E210E1
	for <mptcp@lists.linux.dev>; Mon, 19 Feb 2024 08:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708330940; cv=none; b=FUvEO36ZCjLfDsj/6hQ0FMg57JbGp5jwMC/AtANLpzYI7TE16YVn/i1Lyke4ORquZiY2+XYN+0sLbnqrYx2KQ/g32zh+lDuuPOt6Ja17SvkGDG0c4zqX9C8NZl1b/4ZLnDsdezyrwJGkjKzFE0rJobccFet1BhrxluBIDCcXIi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708330940; c=relaxed/simple;
	bh=XtWeWx526jfTKYXLx/Q8nlGR98iAZ5UnFRbVtw6hIAc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=q+9ssomSrJiLTCieBGQkuImbT0byx0tX/v497KFLZngE19GttOufy/vJMjEyAd7+KV9OHS6IebBHvo8EZ+kxePfAFYSmIyUaj95EkuG9NrvcvfPH/EW6FVvGyw+C6J0ZNMmsSsl6766jxmWq6yYSCMq2RGOOTtQHQ6eXGct4Qmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YLGvD1/F; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YLGvD1/F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B009C433C7;
	Mon, 19 Feb 2024 08:22:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708330939;
	bh=XtWeWx526jfTKYXLx/Q8nlGR98iAZ5UnFRbVtw6hIAc=;
	h=From:To:Cc:Subject:Date:From;
	b=YLGvD1/F6rhPwXsmxzZR9VdLzoEzNwTZvd49sXUn23QGisqVyXaF5+JVibuorXQHH
	 bofcY/BAAXP2PD1rjRTE540pjMbuLpdjvsgBEFGFlccEcRNqHW91cE7Asm4uI9OakM
	 yo638ibt8w3eIgGDii0n3y0lvZ0UOsKkFAvx/RzvG5Uso9tU5pJA3485PUAoV4/Xk7
	 h1a2cnj1gnSYel3ceiNeGBvZSZod6KpdQv2EkNe6p5qjF0yy1iGFyzU5cYvMPh5DgV
	 vZfahU63ji3l3+Kz/qzLmwyzkKfrJE3KJO4mxH3eLpE+/LRODuUEbqZw0ypfoEMn2s
	 z0igIDo7aViUw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v3 0/2] add helpers and vars in mptcp_lib.sh, part 1
Date: Mon, 19 Feb 2024 16:22:10 +0800
Message-Id: <cover.1708330720.git.tanggeliang@kylinos.cn>
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
 - only check ss mptcp support in mptcp_join.sh.
 - use 'switch... case' in mptcp_lib_check_tools.

v2:
 - address Matt's comments in v1.
 - all for -next, not -net.
 - add two more patches.

Part 1 of "add helpers and vars in mptcp_lib.sh", some fixes.

Geliang Tang (2):
  selftests: mptcp: join: add ss mptcp support check
  selftests: mptcp: add mptcp_lib_check_tools helper

 tools/testing/selftests/net/mptcp/diag.sh     | 12 +------
 .../selftests/net/mptcp/mptcp_connect.sh      |  7 +----
 .../testing/selftests/net/mptcp/mptcp_join.sh | 23 ++------------
 .../testing/selftests/net/mptcp/mptcp_lib.sh  | 31 +++++++++++++++++++
 .../selftests/net/mptcp/mptcp_sockopt.sh      | 15 +--------
 .../testing/selftests/net/mptcp/pm_netlink.sh |  7 +----
 .../selftests/net/mptcp/simult_flows.sh       |  7 +----
 .../selftests/net/mptcp/userspace_pm.sh       |  6 +---
 8 files changed, 40 insertions(+), 68 deletions(-)

-- 
2.40.1

