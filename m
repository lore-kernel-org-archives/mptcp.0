Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C86019CD1D
	for <mptcp@lists.linux.dev>; Tue, 26 Aug 2025 04:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756182641; cv=none; b=cbIo604BWefHjDancP7pELdl3AU8dNSJ7qOLFGOMn5s52ysBrD3mdTjXa1lHTeVIV1dseaCuHjozJd1hlJGKMZCqtUvzc/FSu2DfaKtUciCSzFqEjjNM9of4kBQT3/p2aaHbGGEaIFlqESGZXTKf87ZBgyI4aURoip3uPglgyHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756182641; c=relaxed/simple;
	bh=NCR85LW8x3ywKiTlYP0IA/UKL7gCwuBKg3zZGiVJNwQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Zxy+fgZ1ejI9btuuVPdVGHC968luWI5USn7JE50Lzkppq0W8OXYw4IxW8xK1D0mXbmhptwHd8XQ7dZ910i5XGNl6rAOV8z275T7CDWZ6daAToh75/dopk9gfWxAyADcJdtP8IEHYU0KBePeJWbtwpL175PZXo3SQfa69MFH646k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k1C1VUZA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k1C1VUZA"
Received: by smtp.kernel.org (Postfix) with ESMTPS id F156AC4CEF1;
	Tue, 26 Aug 2025 04:30:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756182641;
	bh=NCR85LW8x3ywKiTlYP0IA/UKL7gCwuBKg3zZGiVJNwQ=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=k1C1VUZAJe5aOHk9YlOIuDSiHb5/9AdYxjsHSI+ufCFIZmvO7KSTaRYelyH+RSC24
	 yfA5cv+rQeW6CZLLtdohShfGOluBczhrLRjKXhyUESHuCzmca1e0vPDqqnuz7N2HB3
	 sO2/FOpERuRnWpcMx84sl+bpXsA1sW2OhOGklSRUEbQJP6EI8Qiz/P2QfIreVtIg3x
	 RPIBo5edFcSERHEF+mU04/ZEAiBavAiaYk6El9wa/YR6VD0390nNclgltkusnzqKDc
	 tGTGkbg0MM6DN+hZyojkB9oJ8sBjtyRWXm6ACdC00LkjnnaCpnX79rnJZWtSYcwV1y
	 mtYQsnExXncdA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E29A7CA0FF0;
	Tue, 26 Aug 2025 04:30:40 +0000 (UTC)
From: Christoph Paasch via B4 Relay <devnull+cpaasch.openai.com@kernel.org>
Subject: [PATCH mptcp-next v2 0/2] mptcp: Support recording MPTCP subflows
 in RPS table
Date: Mon, 25 Aug 2025 21:30:34 -0700
Message-Id: <20250825-b4-mptcp_perf-v2-0-5d2d68dfa8af@openai.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGs4rWgC/12NwQqDMBBEf0X23C3ZVKv21P8oUjSudQ8mIRGxi
 P/ekGNPwzAzbw6IHIQjPIoDAm8Sxdlk9KUAM/f2wyhj8qCVrlR9IxxKXPxq/NtzmFDplvQ4ltO
 9GiBtfOBJ9sx7Qe6h5X2FLmWzxNWFb77aKDcytVH1H3UjJOSmNYZKqpM8nWfby9W4BbrzPH9m7
 qV0twAAAA==
X-Change-ID: 20250731-b4-mptcp_perf-02912dd4f65b
To: MPTCP Upstream <mptcp@lists.linux.dev>, 
 Matthieu Baerts <matttbe@kernel.org>, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>
Cc: Christoph Paasch <cpaasch@openai.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756182640; l=1351;
 i=cpaasch@openai.com; s=20250712; h=from:subject:message-id;
 bh=NCR85LW8x3ywKiTlYP0IA/UKL7gCwuBKg3zZGiVJNwQ=;
 b=rtsg7SdZ3RR5jcvTSERnreBvq0BfpTiJWhzvtQLkCqDJZO406mLsDo4DLfrZ97BvjAB9OH+mc
 wmZzyjaeBQMBMPoLCS6Oq5WIl+R2N5OOmbCCJoKrSmWwAvSzEKOk6Br
X-Developer-Key: i=cpaasch@openai.com; a=ed25519;
 pk=1HRHZlVUZPziMZvsAQFvP7n5+uEosTDAjXmNXykdxdg=
X-Endpoint-Received: by B4 Relay for cpaasch@openai.com/20250712 with
 auth_id=459
X-Original-From: Christoph Paasch <cpaasch@openai.com>
Reply-To: cpaasch@openai.com

If we want to steer interrupts to the right CPU-core with aRFS, we need
to record the subflows in the RPS-table.

This patchset achieves this by iterating over the subflows and calling
sock_rps_record_flow().

Patch 1/2 adds a helper (rfs_is_needed()) to allow checking whether RFS
is enabled before iterating over the subflows. The helper allows to
rework the code in rps.h to make it more streamlined.

Signed-off-by: Christoph Paasch <cpaasch@openai.com>
---
Changes in v2:
- Introduce patch 1/2 which adds rfs_is_needed (Matthieu Baerts <matttbe@kernel.org>)
- Use helper rfs_is_needed() to decide whether or not to iterate over
  subflows (Matthieu Baerts <matttbe@kernel.org>)
- Also call mptcp_rps_record_subflows() in mptcp_stream_accept (Matthieu Baerts <matttbe@kernel.org>)
- Link to v1: https://lore.kernel.org/r/20250807-b4-mptcp_perf-v1-1-e89cc14179cc@openai.com

---
Christoph Paasch (2):
      net: Add rfs_needed() helper
      mptcp: record subflows in RPS table

 include/net/rps.h    | 85 ++++++++++++++++++++++++++++++++++------------------
 net/mptcp/protocol.c | 21 +++++++++++++
 2 files changed, 77 insertions(+), 29 deletions(-)
---
base-commit: 4a7f79b50b675c068ff94cd750d5a9f03fd3a0fa
change-id: 20250731-b4-mptcp_perf-02912dd4f65b

Best regards,
-- 
Christoph Paasch <cpaasch@openai.com>


