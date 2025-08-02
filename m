Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC4C52CCDB
	for <mptcp@lists.linux.dev>; Sat,  2 Aug 2025 23:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754178752; cv=none; b=T/H+loWCOynEAzkMk3Dv3C3iNAhwItAJMff4ReRJold/2VOJwvu4v+k+YlmmBwB0KmZUst4eu2mLTGjPGTy1MCCxa/o5vRakvUvfzWY2h3pJw7sgveln4KaSOn1BUpR8eteKZO3+iI2GzedysezvblAYfh2iCH7uZC6IhwuHxH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754178752; c=relaxed/simple;
	bh=7wVYYYqU8hSQqetWg1mmRyE9YdNzO1iyrlX3LlU2MSw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Py9lwPNSzDhF6FtGojfiRnAiMXHiwCGNz5Z1hm4pmaYZdCGx++YO3YrvuV/hksJaU34lP6D2pSrb3afon0UsqSI6wFrVDiVdeIPHSffu0WYhv3kv0xF6lKku1ahDmHfA11KZWCwUjRS3GbL74MdS30fibswxSkUdHwEiE7P1sB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A7zsk07s; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A7zsk07s"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6F8A0C4CEEF;
	Sat,  2 Aug 2025 23:52:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754178752;
	bh=7wVYYYqU8hSQqetWg1mmRyE9YdNzO1iyrlX3LlU2MSw=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=A7zsk07sVqoqBysULpkia7OCYN36I5SmOK+pvuduNYe1xtEJ9nU1P54g8hdp5inWl
	 NTu6KylPjhQbFRlAZmU3d0i6ExkOWy7AXZJquK6s6IcFEOVgpbCjZZld4pZAtaNMwP
	 PcoixS46Vgc0kliuW7++AvGR8Gj5Oq5TaMj+imomN3175BCp39CUqn9Uazw74+D0Mf
	 peXDRJ+ceCNWiPSHWewRiVmBhdbTtHTO/5pHH9yj0r+lSHA63PqvDMzzSoU4xBSCEP
	 PKPb8D3t+KOSBJnq1bZRZNTkljkz0lp5hit6SSZJYG1EBrW3Xzaqr/AL4WhsDF4g5J
	 Hz+L/P7W+eUkw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53BDCC87FD3;
	Sat,  2 Aug 2025 23:52:32 +0000 (UTC)
From: Christoph Paasch via B4 Relay <devnull+cpaasch.openai.com@kernel.org>
Subject: [PATCH mptcp-next 0/2] mptcp: Add support for SO_MAX_PACING_RATE
Date: Sat, 02 Aug 2025 16:52:21 -0700
Message-Id: <20250802-b4-mptcp_setsockopt-v1-0-50d4905a4c2b@openai.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALWkjmgC/x2MQQqDMBAAvyJ7diFqS7RfESk22dRFmoRsKIL4d
 0OOAzNzglBiEng1JyT6s3DwBbq2AbOt/kvItjD0qn8qPXT4eeAvZhPfQlmC2UPMaAft3DRaO6k
 RShkTOT7qdYZqo6cjw3JdN61yQuFxAAAA
X-Change-ID: 20250731-b4-mptcp_setsockopt-d37ff98dd908
To: MPTCP Upstream <mptcp@lists.linux.dev>, 
 Matthieu Baerts <matttbe@kernel.org>, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>
Cc: Christoph Paasch <cpaasch@openai.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1754178751; l=610;
 i=cpaasch@openai.com; s=20250712; h=from:subject:message-id;
 bh=7wVYYYqU8hSQqetWg1mmRyE9YdNzO1iyrlX3LlU2MSw=;
 b=Ca2j/JLbxGLv8ata9QbPz48m/ekJWzWctVviGnhOCETcUqW7TjrzR1G5mubeQdHL6NVV1ARYh
 7F1zMDCSXegBCAr1JPnw7fq2smqoyaGUp+5v6u4qVBMP55QdBWgWzrc
X-Developer-Key: i=cpaasch@openai.com; a=ed25519;
 pk=1HRHZlVUZPziMZvsAQFvP7n5+uEosTDAjXmNXykdxdg=
X-Endpoint-Received: by B4 Relay for cpaasch@openai.com/20250712 with
 auth_id=459
X-Original-From: Christoph Paasch <cpaasch@openai.com>
Reply-To: cpaasch@openai.com

Pass it to all subflows. Also, add a selftest.

Signed-off-by: Christoph Paasch <cpaasch@openai.com>
---
Christoph Paasch (2):
      mptcp: Add support for SO_MAX_PACING_RATE
      selftests: Add tests for SO_MAX_PACING_RATE

 net/mptcp/sockopt.c                               | 31 +++++++++-
 tools/testing/selftests/net/mptcp/mptcp_sockopt.c | 74 +++++++++++++++++++++++
 2 files changed, 104 insertions(+), 1 deletion(-)
---
base-commit: 9a3f9440d3f1ba4d323e6dc3f503e453b15a4edc
change-id: 20250731-b4-mptcp_setsockopt-d37ff98dd908

Best regards,
-- 
Christoph Paasch <cpaasch@openai.com>


