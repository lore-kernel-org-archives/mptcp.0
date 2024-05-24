Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ACE184FB0
	for <mptcp@lists.linux.dev>; Fri, 24 May 2024 15:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716563637; cv=none; b=fc++j77vsiGueA9BYVzTAYcc86SaDxENsPoBk8Xu4CoO4K/bj0cd1Oa2CatIOrdIKbGofDUF0xotKEyXmF41f2RtNiaL7HAfvM0FLYrubJKAov786erfHZNEJABdYmMO4a+JMcba/BhKhF2OkKpYAxbsoiy2GcKV+glOTO8hEas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716563637; c=relaxed/simple;
	bh=UpmF42rzB+l29P4/lnEqG0714MfNrsbQNxRuPcMOzaY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=oWtuyy3w3y/qnhkH8xSjg5HmS3arnpOpexPfIyUBuPrAT0NyrOrerPrGVPO0g0AW5c2F9wl2K9/cxHDVliDqguO4UNVjyFzlecWaPX/SbU3KRwVn3KX0g3CLI2f+bEINhgqyu+LM+5GogJ1OA7JlBRDole2HfmlXDGZd9PohXRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JxMYZLkX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JxMYZLkX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0ADD1C2BBFC;
	Fri, 24 May 2024 15:13:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716563637;
	bh=UpmF42rzB+l29P4/lnEqG0714MfNrsbQNxRuPcMOzaY=;
	h=From:Subject:Date:To:Cc:From;
	b=JxMYZLkXB0SF8ujbDDRq2i7DYpMhRsBQk9GifnAZnLHhnvTbzyy2D4WBwX0rsgBdA
	 WxMjN1FOn1dz/fGIdf+EMa6oxBADnq9c/3Yixyh8BT5/l4a3O4UCb4H6R222axT8/w
	 WmhSY1km85jK/jwnLg8cv3ve5/9zYWAS76Oyvvn79RD/f51ConwnEM6TaBbcKmbdy0
	 N3P/UEuL725FLemtewFlffx1LYjzo8L+sT+TQQglSV8CtYrzoaNo5lMM04gDcwHUtU
	 nkkVdf5ZHSnZ8gR1Hq2PaPMhA2vnmeXOH8Hmoq6FNi7nYKz1mTxMRa5rQSkYiqwKvg
	 319Po//xMBRFQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH mptcp-next v5 0/9] use helpers in lib.sh and net_helpers.sh
Date: Fri, 24 May 2024 17:13:23 +0200
Message-Id: <20240524-selftests-net-lib-fixes-v5-0-b9e0968571a3@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJOuUGYC/x3LQQqEMAxA0atI1gZKtVjmKuLCanQCTqc0QQTx7
 hNm+fm8G4Qqk8CruaHSycLfbBHaBpb3nHdCXq3BO9+74HsUOjYlUcFMigcn3PgiwTAPLsW1S9F
 HMF0q/YfhET5Fl2LgUpie5wesjUtrdQAAAA==
To: mptcp@lists.linux.dev
Cc: geliang@kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Geliang Tang <tanggeliang@kylinos.cn>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2281; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=UpmF42rzB+l29P4/lnEqG0714MfNrsbQNxRuPcMOzaY=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmUK6yCBwMPCnTPJP5Sl5gOFbTUDhcyGVjx0uKJ
 y2E0m8wI6eJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZlCusgAKCRD2t4JPQmmg
 c6C5D/4nZTp3bUCZ96+Y9v+0UVZLEDE1qX9EPeDIxYhC2FV5aFOdOwm75fP6VwnUWk6X57ImA8u
 XwVGmCXLrtzfZZZD2NG8dPW3secRZCL/AGyZ1vpV/KODzpwPSyMZcqSJ769DrpHeDEtCw8aSjVZ
 nnszgIkdUG/21Oulo5mqYktxaHJvlqAGqeMNLF/YGgzI6Ob+I7LNKM91cbWDDClwvubxgi9H07a
 WE2P67Qup/OP61m9CG6LSeGXYZNyxKGAPaUAgvWzYxy9XmYeYFTkX+lriBU/CO7QEJ+/xqDfc72
 hdqYr3YXaxFVokf0CCSc6sheg5kU9sMgMcYasWSfIHBeMzJ21a6vHNmMQu6UDvIoJqrdb560Agx
 e913m0jl4XtUFWECpct2wlK0+P1LrecGYPFTHcItKw8EWeaWiNFTpJlY6yVnDON5FcSdQUpHVGd
 7oW8MVNU6080q8wt7EFDtKCFW0jHrOGjtyh5pAKgJw+V+06l3ZMW3FDOwFBCCdidWyKn9dbePiC
 Y7HAg35457ygTSScBYj5cnEmMtSEgb0pV57V3XM1PcTS7DHPDN85iSa1rMZMEuJnAZJxOm1qk+s
 6Zc5j4CbkTrnW7YueAff5mkZDLiB71U+wkgMsNTHGd+MGZh7J9QtTxyhEznG848hnDhZaUw+Rky
 L+kTx069P3iyFEA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

(This is a new version for the series created by Geliang. @Geliang: I
 hope that's OK for you like that, it was easier to describing the
 modifications by email. I validated my changes by running MPTCP
 selftests only)

This set uses the public helpers defined in net selftests to replace
helpers in mptcp_lib.sh.

v5: (Matt)
 - New patches: 1-6: some unrelated fixes, some modifications to avoid
   adding workaround on our side (changing variable names, trap, etc.)
 - "rename ns in setup_ns": drop the modifications in cleanup_ns, exit
   in case of error, and updated commit message.
 - Drop patches 2, 4, 5/6 from v4.

v4:
 - two more fixes added
 - exit when setup_ns fails in mptcp_lib_ns_init

v3:
 - address Matt's comments in v2 (thanks, it's very useful.)
 - don't rename ns in diag.sh, but in lib.sh
 - ns in get_counter needs to be renamed too
 - add a ns_name valid check in setup_ns
 - drop $NS_LIST in mptcp_lib_ns_init
 - don't drop mptcp_lib_ns_init, use cleanup_ns in it
 - don't use cleanup_all_ns, still use mptcp_lib_ns_init

v2:
 - only patch 3 updated, mptcp_join.sh, move cleanup_all_ns from
   cleanup_partial to cleanup, setup_ns will delete existing
   namespaces automatically.
 - update commit logs.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Geliang Tang (3):
      selftests: net: lib: rename ns in setup_ns
      selftests: mptcp: lib: use setup/cleanup_ns helpers
      selftests: mptcp: lib: use wait_local_port_listen helper

Matthieu Baerts (NGI0) (6):
      selftests: net: lib: set 'i' as local
      selftests: net: lib: support errexit with busywait
      selftests: net: lib: avoid error removing empty netns name
      selftests: net: lib: ignore possible error
      selftests: net: lib: remove ns from list after clean-up
      selftests: net: lib: do not set ns var as readonly

 tools/testing/selftests/net/lib.sh             | 73 +++++++++++++++-----------
 tools/testing/selftests/net/mptcp/mptcp_lib.sh | 33 ++++--------
 2 files changed, 52 insertions(+), 54 deletions(-)
---
base-commit: 958cd231864867eb931c4ed55db7945fb4e5af43
change-id: 20240524-selftests-net-lib-fixes-5a70b8d3b828

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>

