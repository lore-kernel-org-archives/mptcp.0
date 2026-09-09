Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08ACB326951
	for <mptcp@lists.linux.dev>; Wed,  9 Sep 2026 02:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788921671; cv=none; b=mo1GsMK4BOR4vP4zxSyE9t+f9+JNOy3OkGtB8G4Q+aka6wzZpn5gAaraAmUZa7QTRr6LgkVX6ZYEzJjTYx00sSFxH6ZdO0Ue5OjO5simZ2E6/1+0Nv8KgIx/+owLErUBVDl72nPXeY32IoS4mb6Tfaj7Z8umMeOe0uiBrWvIJe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788921671; c=relaxed/simple;
	bh=u69Q3KBJiQT6+6lKtpAHt4MuYy4KovW6xZ2SKD9e0a8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=tuOUxOYCeV/rnXC2DhaCwukXJk07dCkp2R6fMzv2KX99FbZIgl2LEInNiKgyN3ZV426+VAu3u4p+DJvtremcrkHPkzEloCW5LieXmOHRht4Jnvt77Sd6REm5iUO+VpORrVj0WnUAzmdeAF4kiewqYbaa8C9rAlxQ8h6n3IaBVFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=copjBeU9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="copjBeU9"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9B657C2BCB8;
	Wed,  9 Sep 2026 02:41:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1788921670;
	bh=u69Q3KBJiQT6+6lKtpAHt4MuYy4KovW6xZ2SKD9e0a8=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=copjBeU9dDrGrvxrt8WhR0CdU5f3ZSl6kHedXiYnxFGdp0EzxGNAUciFYYFoj17xe
	 jEnIDBr+QSVEfJ5/d1pHJLOv8vZwH/erRBwVrFPnZ3KZLaIA+FLD9R0Vbep6bP/tQ/
	 iBf2ygBygYVlUUtUTFhY4boIAGhhiok4sN0B6nbig3oyiPp92ioY860K7GVx0WU1LR
	 oz2In0exkn9B2J2AD+cl5l6Qz6SzYZCsaBnOpTNodcXk11Lv2U2E9BpQbvZbz8U61h
	 XwpCkO6xqI5nYujX11fhiTWHmJsP8b/9tOuohfwdZKecuAWn97h7n3cQdF45oHmV/v
	 ZjeycL0rhBXWg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A5BCC79FA1;
	Wed,  9 Sep 2026 02:41:10 +0000 (UTC)
From: Quanye Yang via B4 Relay <devnull+quanyeyang.proton.me@kernel.org>
Subject: [PATCH mptcp-next v3 0/2] mptcp: shrink struct
 mptcp_options_received
Date: Wed, 09 Sep 2026 10:40:47 +0800
Message-Id: <20260909-mptcp-shrink-opt-rx-v2-v3-0-92bb3009a665@proton.me>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/42OwQ6CMBBEf4X07Jp2hQqe/A/jgcIi1dg2bSUYw
 r9b4OLJmOxlsjNvZmKBvKbATtnEPA06aGuSOOwy1vS1uRHoNmmGHCWveA5PFxsHoffaPMC6CH6
 EAaEtiTeyKgRWOUth56nT4wq+sC1jaIzsuv3CS92piQt5cfc6ROvf64pBrJnfhQIEYFsea1UVv
 Oi6s/M2WrN/0tow4B8MXE6k5VKiUqKkDr8x8zx/AMI5g14eAQAA
X-Change-ID: 20260904-mptcp-shrink-opt-rx-v2-d8e0c6951294
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: Quanye Yang <quanyeyang@proton.me>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788921669; l=1462;
 i=quanyeyang@proton.me; s=20260801; h=from:subject:message-id;
 bh=u69Q3KBJiQT6+6lKtpAHt4MuYy4KovW6xZ2SKD9e0a8=;
 b=O7/b6aMyNGC+AAaaP3z7HafLooxtlFp412neNlvLMSC8kmS0lnuzxTIilFtM1auaJu4uJnJ4l
 j/Ri/UDawUcC+eR+4b2UQlTbGGg1y4YmfjGil7xriQnj+nztyaqJGvB
X-Developer-Key: i=quanyeyang@proton.me; a=ed25519;
 pk=9L9FrcvzMgxPaBRU6XV0EnqTgjDqVO596rQKSZ9qZoY=
X-Endpoint-Received: by B4 Relay for quanyeyang@proton.me/20260801 with
 auth_id=963
X-Original-From: Quanye Yang <quanyeyang@proton.me>
Reply-To: quanyeyang@proton.me

struct mptcp_options_received is the per-packet decode buffer used while
parsing incoming MPTCP options. It is larger than needed because several
suboptions cannot be combined.

This series splits the FASTCLOSE key from rcvr_key, then overlaps the
remaining mutually exclusive payloads in an anonymous union. DSS and
rm_list stay outside the union. On x86_64 the structure shrinks from
136 to 72 bytes.

---
Changes in v3:
- Split the FASTCLOSE key change into its own commit
- Add comments linking union members to their suboptions
- Link to v2: https://patch.msgid.link/20260904-mptcp-shrink-opt-rx-v2-v2-1-d8662bb18ef2@proton.me

Changes in v2:
- Group fields by suboption and move join_id into the MP_JOIN group
- Split rcvr_key into rcvr_key (MP_CAPABLE) and fc_recv_key (MP_FASTCLOSE)
- Overlap MP_JOIN token, thmac and hmac
- Drop the dependency on the invalid-option series
- Link to v1: https://patch.msgid.link/20260904-mptcp-shrink-opt-rx-v1-1-2d87ab9505ff@proton.me

---
Quanye Yang (2):
      mptcp: split FASTCLOSE key from rcvr_key
      mptcp: shrink struct mptcp_options_received

 net/mptcp/options.c  |  6 +++---
 net/mptcp/protocol.h | 44 +++++++++++++++++++++++++++++---------------
 2 files changed, 32 insertions(+), 18 deletions(-)
---
base-commit: d5a4e55ccfb893614646d0f0e5c440daa92b7467
change-id: 20260904-mptcp-shrink-opt-rx-v2-d8e0c6951294

Best regards,
--  
Quanye Yang <quanyeyang@proton.me>


