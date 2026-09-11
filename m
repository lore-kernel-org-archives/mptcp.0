Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30E58471437
	for <mptcp@lists.linux.dev>; Fri, 11 Sep 2026 15:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789141334; cv=none; b=HnnYjbFBSmAokwx3eLViYncRirdWa/7BL6XUVfG38PRv8dZMvvJL7Tyc2y+iLJo4mUya4abxk8bkMaA4Ouxp9UfCt2gw2qkSHWa+mUy8P1krDAHEIxYMtFQ+JIqY20tf5+Q5y7V//PDMdQTrG4CNtQbikaSkx/CARxassHPg4ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789141334; c=relaxed/simple;
	bh=UaSkOzfR/aYP/kzb/C1pqEvi8lsHEKH84b3uUs8YwZA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=qIBU0eItUeBzRAsSpNh179lYWNNp5xDIKmXuAOmxgOfgWlxIIfEiON8HQpSkcOJenGvSZ8+b9r396IdByHFSa5TEXpHvBt9JjEwNZd+/J5WYXgolvz/c0jkAKmSgUmQg/f/SWjdT/VNBO/y+4+Bk3I+Ws8Z/e+x0D4UMwZ5TxWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cxKobhDJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cxKobhDJ"
Received: by smtp.kernel.org (Postfix) with ESMTPS id BAF23C2BCB8
	for <mptcp@lists.linux.dev>; Fri, 11 Sep 2026 15:42:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1789141333;
	bh=UaSkOzfR/aYP/kzb/C1pqEvi8lsHEKH84b3uUs8YwZA=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=cxKobhDJVe4QNFPJ8JIuBx+1KwlGxI4lkt49lRgKRVBXHuOwXnuvPfSp7UMBnSSW6
	 npngFpZMm0N5Lqc2Bq9agFI3KJ/0PCxc+/a1JYKLdxHYl+6rZ/GFDIPaLzYQGf+dqR
	 yTQj5t0tjr/kUfV1qPqUJ0N7sdw/659IaWTf9F58YBhad5/iAF+nMcBSEUTx+epuek
	 6D+tvh1Ggy/O/y64x2L39ctD8c9K1oEesGIQm0py/Z9vKNA/8Jy5kdQj0FsI5Y5so0
	 FibtgAgRmRs2vrsHd/LxPCtCPFz5XSilHu5AY4E22EvMQZgswSmTRjkilA2i1bdzlU
	 hSGczbCTUGljw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6DD0C88E4D
	for <mptcp@lists.linux.dev>; Fri, 11 Sep 2026 15:42:13 +0000 (UTC)
From: Quanye Yang via B4 Relay <devnull+quanyeyang.proton.me@kernel.org>
Subject: [PATCH mptcp-net v2 0/2] mptcp: fix leftover fallback after failed
 connect
Date: Fri, 11 Sep 2026 23:42:06 +0800
Message-Id: <20260911-mptcp-connect-undo-net-v2-0-54224cea2238@proton.me>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4WOzQ6CMBCEX4Xs2TVtbfDn5HsYDqUsUhO2TVuIx
 vDuFngAj5OZb2a+kCg6SnCrvhBpdsl5LkIdKrCD4Seh64oGJVQtrlLgGLINaD0z2YwTdx6ZMrY
 XQVIbkr1RUOAQqXfvrfgBO1Ni0OxWmtpXwdfiNTy4lH38bCdmuSH/9maJArWuSZuyeqLzPUSfP
 R9HgmZZlh8CtEmx2QAAAA==
X-Change-ID: 20260910-mptcp-connect-undo-net-b80e14ae1fa2
To: mptcp@lists.linux.dev
Cc: 
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789141332; l=1398;
 i=quanyeyang@proton.me; s=20260801; h=from:subject:message-id;
 bh=UaSkOzfR/aYP/kzb/C1pqEvi8lsHEKH84b3uUs8YwZA=;
 b=jaGVp2UDWKpbsFq7CSDshgi3GD3Dy4R6pJ6nwaiZZ4UNFdQG3/onduUSpYDwvr8VX1emRg9Ti
 SsE8/febCA8B0q6Bm1gBH9ORzjB/hHUHIEQlTLUEZYAK4xIg81r9Cxk
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
Changes in v2:
- remove the helper function and open code the function
- also drop the NULL check on the ssk; __mptcp_nmpc_sk() already
  guarantees it
- Link to v1: https://patch.msgid.link/20260910-mptcp-connect-undo-net-v1-0-446e4a4ae3e7@proton.me

---
Quanye Yang (2):
      mptcp: reset msk state on early connect failure
      selftests: mptcp: join: retry connect after early fallback

 net/mptcp/protocol.c                               |   9 +-
 tools/testing/selftests/net/mptcp/.gitignore       |   1 +
 tools/testing/selftests/net/mptcp/Makefile         |   1 +
 .../selftests/net/mptcp/mptcp_connect_retry.c      | 216 +++++++++++++++++++++
 tools/testing/selftests/net/mptcp/mptcp_join.sh    | 108 +++++++++++
 5 files changed, 334 insertions(+), 1 deletion(-)
---
base-commit: 38b6be101006d3e7af972999f45d4f1e8250587a
change-id: 20260910-mptcp-connect-undo-net-b80e14ae1fa2

Best regards,
--  
Quanye Yang <quanyeyang@proton.me>


