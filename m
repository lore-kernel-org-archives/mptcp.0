Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38C1717A30A
	for <mptcp@lists.linux.dev>; Tue,  9 Jun 2026 01:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780969056; cv=none; b=jc1rsV6StCh+5QFztQ2LSYUyDmAAw+4alIbNMuDG0lXLsExN/AmixFCJfXhukWIe3xzsvUWzVczoLgMS/FajLatGV9JvEEX/Qhop3YojJODqn/x55vEdQxZFv/7mX90Y1B82ZQS5qwP5+lWqyNbuKZJVd9TITkV/HuEfvEMKPI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780969056; c=relaxed/simple;
	bh=nbkRodNKvPJX2RI5tB+KUOaHUrpolDS1Mss/HDtL4UE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=h7o7Ro05mMx0ibe3QjgyCH2Me3c2weUjcFTRKlYE2OlRq9zFxCZC348mmsa6Zvm7cbmlsUwWmJcDZZ87O47Nd+rUAcRz/AsTdvpRnwuu5yWuLA+YhpngBFVDtuXwayiCJ048wDA9nVUDiw+Fy/zOcr7ADr/8KNBOBKHVJyr/Nws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=adFQ7PyM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="adFQ7PyM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B3E01F00893;
	Tue,  9 Jun 2026 01:37:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780969054;
	bh=APbV+KRT5H58zH09TslYjrhpI+5qULXxwpchPE0Vw2A=;
	h=From:To:Cc:Subject:Date;
	b=adFQ7PyMUCCPSyrjZzWnjUYA/GD/FioA9Fb9wVgRRPNPv95ZYLOGk4WeqjK/Y/wO/
	 C9op/X0EifS+fsQ6eoTe1z7VILrJlx0GzLtT7kj6Wgnj3i+7HqpYW/kgcFbhJuXZhy
	 obAYFm/eZcgx1it8VGwcjIIh8JK9ie7H+BRGxrfFkka5TjbqgL5aCQ+msAx+j31sRn
	 RaOfu3VJxSUqX7ZNaUf2R1GxfcqjHxivZIgfLt5XsV3nlFIhV52lOq+Zto4hZ2iaxu
	 biR9JSzXdicOSM/nYPx4CoK9z2zBc8faE7nZ7cxtU8f3yF87sXr3ux8OqKzujFfZf8
	 WQWlJvuLaQMmw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v4 0/2] implement .splice_eof
Date: Tue,  9 Jun 2026 09:37:21 +0800
Message-ID: <cover.1780968872.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

v4:
 - patch 2, handle cases where sendfile returns 0 or a value
   larger than the remaining count. In such cases, break out
   of the loop to prevent unsigned integer underflow and
   potential infinite loop.

v3:
 - drop do_tcp_splice_eof helper.
 - invoke __mptcp_push_pending in mptcp_splice_eof.
 - use lock_sock_nested in mptcp_splice_eof.
 - set splice_eof in mptcp_v6_stream_ops too.
 - Link: https://patchwork.kernel.org/project/mptcp/cover/cover.1780909894.git.tanggeliang@kylinos.cn/

RESEND:
 - to trigger ai review.
 - Link: https://patchwork.kernel.org/project/mptcp/cover/cover.1773740361.git.tanggeliang@kylinos.cn/

v2:
 - add sk_state check in mptcp_splice_eof. (Matt)
 - call mptcp_rps_record_subflows in mptcp_splice_eof. (Matt)
 - update commit logs.

This set implements .splice_eof for MPTCP and tests it.

v1:
 - Link: https://patchwork.kernel.org/project/mptcp/cover/cover.1770023932.git.tanggeliang@kylinos.cn/

Geliang Tang (2):
  mptcp: implement .splice_eof
  selftests: mptcp: connect: trigger splice_eof

 net/mptcp/protocol.c                          | 31 +++++++++++++++++++
 .../selftests/net/mptcp/mptcp_connect.c       |  5 ++-
 2 files changed, 35 insertions(+), 1 deletion(-)

-- 
2.43.0

