Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79E483E3DAB
	for <mptcp@lists.linux.dev>; Tue, 13 Oct 2026 06:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791874618; cv=none; b=gZbxtcUj5XE4Sq+DwbbjMVDJM9+eCPtnV7y3xMZNtTrJVonuv3yk1AXoNH8KYUKWKvMXqx4hxuyNDOZ8rdeQVoyYGKCnM1dwabBSu56UH9DwrklzukELEMGdU3XWoU9pUcxYO9TVzqzqdNJPsVBFc8nRPZexZZIdgPfzQji8hJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791874618; c=relaxed/simple;
	bh=wPQWLafufffqqgK2uKBCXob0aRkxtWhihzraCsKFIv8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fZRahZ1P/KO2lAcTp9sRwtdC+1Wc+irVxWSqo3tE5KFVXjgASpLobC0p+jAIKIVYiw/wYZx+z4d8Ch67LpAb3js4kQECsERfkfJmrkGUP6t/6qyBXio8wGiSJDpEfFrOIolKerFAJXXuDSfu/7xyVrvC5eHn9A4B+xfV/Q1om3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J6NEUqMF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J6NEUqMF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D8B31F000FF;
	Tue, 13 Oct 2026 06:56:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791874616;
	bh=h+k4tsj0XaRsBATj06mPx3piP5RW+FafuhYSK3rak7Y=;
	h=From:To:Cc:Subject:Date;
	b=J6NEUqMF54xfssffQzleOiHi/4VS72oRnVSuyAzgEehJWakDWglllEgPmm6u0V/gA
	 4PyqAawIkDMdafZ+6o2h7wvAHxKhbxVn8URVC0xBmu2oaWE6xFnxrYg4E+Zc37waRs
	 KmBXjKSDQGrpDGvRGFfsrUKg0kNhhd7wD7ZeiNc+7k/H6fG9O+OGKo/keYenEOE41S
	 15g2PpgiAOOCCclnooChf5vj1usA9viSdhuqkylXsUb5d1vVwF5sBR9ta9kIQ0d2yK
	 mVyJsKdb+hPzrjXWY0vV1Nl9gbPkgiKHWJ56ZrxAgUWmDEXf5QVk34khXHPPKI2c0Y
	 CMjtJ9YM2d8oA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>
Subject: [PATCH mptcp-next 0/2] introduce msk_is_mptcp() helper
Date: Tue, 13 Oct 2026 14:56:45 +0800
Message-ID: <cover.1791873760.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This series introduces the msk_is_mptcp() helper function to check
whether a socket is an MPTCP parent socket (IPPROTO_MPTCP on SOCK_STREAM).

This helper is useful for adding MPTCP support in various subsystems,
such as MPTCP sockmap support [1] and landlock MPTCP access rights [2].

Naming rationale:
- Initially considered "sk_is_msk", but as Günther pointed out, "msk"
  is already used as an abbreviation in net/mctp, which could cause
  confusion
- "sk_is_mptcp()" is already taken and used to check whether a socket
  is an MPTCP subflow (tcp_sk(sk)->is_mptcp)
- Following the convention of rsk_is_mptcp(), settled on msk_is_mptcp()
  to clearly distinguish MPTCP parent socket checks from subflow checks

[1] mptcp: add sk_is_msk() helper and use it in sockmap
https://patchwork.kernel.org/project/mptcp/patch/29ec7b3fc7febc1c8946add34f859c8253d9714f.1789294365.git.tanggeliang@kylinos.cn/
[2] landlock: Add MPTCP bind and connect access rights
https://patchwork.kernel.org/project/mptcp/patch/20260830201650.67050-4-gnoack3000@gmail.com/

Geliang Tang (2):
  mptcp: add msk_is_mptcp() helper
  Squash to "bpf: Add mptcp_subflow bpf_iter"

 include/net/mptcp.h | 12 ++++++++++++
 net/mptcp/bpf.c     |  9 +--------
 2 files changed, 13 insertions(+), 8 deletions(-)

-- 
2.55.0

