Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 783A516FF2A
	for <mptcp@lists.linux.dev>; Thu,  2 May 2024 17:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714670598; cv=none; b=qyH0qX1YqcL8B96x/TFQJfmsQ4ZwIVW1tRQeOFukEUU5IIGAqP9t1LkuUa3N6WET8Sol3g6AVph7QboqX31f/HUDdZIeJaBwe8igxrlld3foUv/jijkAX5n4D3LqYgM+Plg8U8nqxYkjIwecGMySrvrjBfM3zUiZOsKY408R16k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714670598; c=relaxed/simple;
	bh=irMueMVZvfx3GOB/2N34IVYDkbZSJX583KaXq7xovhY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=PsfiDPW8aRhtdFNvaEyd44akQcmZR1iHuQ2c9cePhmA+Y3JkMwdsdZlzILzs0A/nZiVy4lp1PtcJV88dfXKWqqMlvSGInLQNOZdz62dt0/sj/IZtgoLtK2qgE8ksHEboZWqxPsVYvGUuihQpIlg2EDmhMsusgttz1SpM+zLOW8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nHU2hhM4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nHU2hhM4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81743C113CC;
	Thu,  2 May 2024 17:23:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714670598;
	bh=irMueMVZvfx3GOB/2N34IVYDkbZSJX583KaXq7xovhY=;
	h=From:Subject:Date:To:Cc:From;
	b=nHU2hhM4Kp73Uxy1SzR/1z3lDqrQ35uM5LXoIKdDNMZbTD/Zk7CiQK255OQSle8j7
	 JpUW2Qqo9DQsxmHzAjEE2sfTDNz1/p4D8AyQ0vGFX8jJ+SNRPdpqR6LFoXgy1JaekB
	 1P0lGe6vHmiGb0YZLhmUQb8H2YqfbT++N0H3LQaDXCwYkh5c2Je/4jCIj9gm9qkkGM
	 1oCfsqedqPnm8dNDbXtDSgADpEUAo9petBocBydN9iEvsntszYFkYsfWkiBruF9OWx
	 6mgQ1qFZUNukqbaqJsmLg/xcI1Q3Mhkfyi2mh3rJgnPBtqPw9fHoKB0I3/iHKoNTdy
	 A1BsHbdrRic0w==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH mptcp-next 0/4] mptcp: Spring cleaning
Date: Thu, 02 May 2024 19:23:03 +0200
Message-Id: <20240502-mptcp-cleanup-clang-checkpatch-v1-0-a2b46c0a6bec@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPfLM2YC/yWNwQrCMBBEf6Xs2YUYoxR/RTzEdWIWNYYklULpv
 xv1NDyYN7NQRVFUOg4LFby16it12G4GkujTDazXzmSNdWZvLD9zk8zygE/TN3uHJULu2TeJPOL
 ivBvdLoQD9ZFcEHT+HZzo7ybMjc7r+gEU0n/lfAAAAA==
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=971; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=irMueMVZvfx3GOB/2N34IVYDkbZSJX583KaXq7xovhY=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmM8wEC0ayjsKpSOuyvRa9Mu9crZbK5084OJ1CO
 wgwCImaVxSJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZjPMBAAKCRD2t4JPQmmg
 cyIqEADulINj7m+OWFABFozuTvGVkARwC1YsPzo4ddJmtWATCTa4gXxUbDfLFdzuH2OJr9xm9XY
 WUPSFMY1mXvDa3wJRaWwF5hrGtcLcIhfrUEXiEKpYyptYnguOT4FgyOXscPDYW6HveMklErvzBt
 h7nl8RqePIdPcLmf0TSJOsCCEj4p8gMlfSrHqQ3rdeAfx9USCbBWyKUaLcO+jwba7wU1Axq/DEc
 hE6bFLtqFSLmOhkkKZpFIiAERFlCury5YWml+ag/Jdi9QU3ie8GCEhNfE36Vh9/jSJjY1sVYD4B
 0rmd5FbmrKUM+kr8qsfBPGGMtyhcXIJISXH6XrWwTKzPIC45QCx9BECFBgz8jZm0DD2VsPeMjHj
 0iTWLTNm7J+sUJUEP/pvp9x/hT4b5DWR8dXfvi0q+Xo3RTHzMGGkIfshHthE4wu6FFJQAb1wf+o
 g6CQraAZKolK1Fdocf8L+fOf9Btk+zlDpY1VAW2ND7StUvBsri65sVOP/MHE9RoJ6uh18YZqI6o
 JscMCcoLDKKdBfdURUILp0ydE2y4WSV8zBiw6AyTixKgXfjtoQJRtIbCgrTduRk3RahIWjZEMD4
 Vz0c06IdIX/R7bHBNtxgh7c947e9LmNM6IY0AMGcYDaPY0I5wolgFJuqZxYd2tuDfQ6fTNoU61h
 96pTQmixihMMXeA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

This series fixes some warnings reported by CheckPatch and CLang.

The behaviour is not supposed to be modified, just some simple fixes.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Matthieu Baerts (NGI0) (4):
      mptcp: prefer strscpy over strcpy
      mptcp: move mptcp_pm_gen.h's include
      mptcp: remove unnecessary else statements
      mptcp: include inet_common in mib.h

 net/mptcp/ctrl.c         |  2 +-
 net/mptcp/mib.h          |  2 ++
 net/mptcp/pm_netlink.c   |  1 +
 net/mptcp/pm_userspace.c |  1 +
 net/mptcp/protocol.c     |  5 +++--
 net/mptcp/protocol.h     |  2 --
 net/mptcp/sockopt.c      |  2 +-
 net/mptcp/subflow.c      | 32 +++++++++++++++++---------------
 8 files changed, 26 insertions(+), 21 deletions(-)
---
base-commit: c3c3514169a8e548fba51d0694b86a72f89acce0
change-id: 20240502-mptcp-cleanup-clang-checkpatch-8eb4a4843ff6

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>

