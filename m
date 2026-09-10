Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAE20485950
	for <mptcp@lists.linux.dev>; Thu, 10 Sep 2026 12:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789043024; cv=none; b=UiK1iu93/9tzLk4x4J7YY70NHrCskHPIC/fg6TRSD4ZGB5ieaqOefu+B0RqPqQDP4t7Ryn70A8jsvZIRPAbsgnVbstf17wSqOtKgl2D2hKyeHaTsXJZJ2DcJ9W60U9GlEQzx/bvrh1pZv1oQxUGPIk6coUHyRhKepCpO1HDYrvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789043024; c=relaxed/simple;
	bh=hyqw+vpPYqG3dvXwyA2jHKTeyV8RlLXzxWlPosmWqrA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=IdMuYPLqP1Y6e4oFiPqF9WdKdxy4/7vsjP1gasQlbimOqo6pxfTks3RlHKZ3WnhBCarS+A9g7g4nJ9wgKIajWWYNVd9Q7Z5Gop5APTaltyNffiuujZeph/Wb3WsSKnt78WOgOnHfdWlrP7BjVz3L8FHbAc/dM8U2AHcdTEOH1Dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=shNH7Pqf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="shNH7Pqf"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 64A14C2BCF4
	for <mptcp@lists.linux.dev>; Thu, 10 Sep 2026 12:23:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1789043023;
	bh=hyqw+vpPYqG3dvXwyA2jHKTeyV8RlLXzxWlPosmWqrA=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=shNH7PqfJg5Z/8mRZgtBzo5CXn1e9NSMYHC8iVmj28UPzryZz5gPhCvdMRM7fCo1o
	 s1/KeS1+xMqJSmFOMJxS4vrecYMufiNbrDx78267NrOpYaQ4ct6BC8aOvxkNPje25F
	 2vGwsVVvdew4eTylOHWp+6ph1No+dRQfCEIsj6BIVcGUp06ub7uVV3c+dK5MgJoyPF
	 dLM0dxUWWXjv4PeF1+JollBQJakPORpmw8E2yhssimSKi09+qEZFXT/lb/cOzZ7/eK
	 g03POM5hB2ed4RGo5WNQjRglxAEKJTYFTRpDIVKMCY39dEC1RCTu6MB4jzDiqzov1O
	 kbS7rZuz6fIew==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4398DC79FBB
	for <mptcp@lists.linux.dev>; Thu, 10 Sep 2026 12:23:43 +0000 (UTC)
From: Quanye Yang via B4 Relay <devnull+quanyeyang.proton.me@kernel.org>
Subject: [PATCH mptcp-net 0/2] mptcp: fix leftover fallback after failed
 connect
Date: Thu, 10 Sep 2026 20:23:32 +0800
Message-Id: <20260910-mptcp-connect-undo-net-v1-0-446e4a4ae3e7@proton.me>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWMQQqDMBBFryKz7kASpNRepXQR41in0ElIogji3
 R3r8vH/exsUykwFns0GmRYuHEXB3hoIk5cPIQ/K4Iy7m84a/KUaEoYoQqHiLENEoYr9w5BtPdn
 RO1A5ZRp5/YdfcDl6g/c1lbn/qn6GYd8PpsnRxYUAAAA=
X-Change-ID: 20260910-mptcp-connect-undo-net-b80e14ae1fa2
To: mptcp@lists.linux.dev
Cc: 
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789043021; l=1137;
 i=quanyeyang@proton.me; s=20260801; h=from:subject:message-id;
 bh=hyqw+vpPYqG3dvXwyA2jHKTeyV8RlLXzxWlPosmWqrA=;
 b=0UKogYq/G5bI0jp0JFBukiF0izbXipJ/qAixj+oy7bRdMbqbYWKND3lUwRe/hq5NtGBfMCsNG
 mXFZx48mwsoATBBM+x91xd5s7DxpUQHcr2IxbZkkzYGe72W6PZwRzvu
X-Developer-Key: i=quanyeyang@proton.me; a=ed25519;
 pk=9L9FrcvzMgxPaBRU6XV0EnqTgjDqVO596rQKSZ9qZoY=
X-Endpoint-Received: by B4 Relay for quanyeyang@proton.me/20260801 with
 auth_id=963
X-Original-From: Quanye Yang <quanyeyang@proton.me>
Reply-To: quanyeyang@proton.me

When mptcp_connect() fails before the socket reaches SS_CONNECTING,
->disconnect() is not called. Early fallback may already have set
MPTCP_FALLBACK_DONE and cleared request_mptcp, so a later connect()
on the same fd stays TCP-only.

Patch 1 undoes that state on the connect error path.
Patch 2 adds a mptcp_join.sh coverage for the same-fd retry.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/633
---
Quanye Yang (2):
      mptcp: reset msk state on early connect failure
      selftests: mptcp: join: retry connect after early fallback

 net/mptcp/protocol.c                               |  22 ++-
 tools/testing/selftests/net/mptcp/.gitignore       |   1 +
 tools/testing/selftests/net/mptcp/Makefile         |   1 +
 .../selftests/net/mptcp/mptcp_connect_retry.c      | 216 +++++++++++++++++++++
 tools/testing/selftests/net/mptcp/mptcp_join.sh    | 108 +++++++++++
 5 files changed, 345 insertions(+), 3 deletions(-)
---
base-commit: 38b6be101006d3e7af972999f45d4f1e8250587a
change-id: 20260910-mptcp-connect-undo-net-b80e14ae1fa2

Best regards,
--  
Quanye Yang <quanyeyang@proton.me>


