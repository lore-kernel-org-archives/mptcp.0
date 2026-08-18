Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29E8845FFAC
	for <mptcp@lists.linux.dev>; Tue, 18 Aug 2026 17:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787075742; cv=none; b=IY1hVYvjgsa9MfyJSLz6HtOrzvT2MMxG4B2aKI3scIkcv3DTQxmmWt6TowRA3lJhRVqZhrPOiVhaTyiLmaLxq4N7neGB2yY1sZC3UJTKPFcbKhLQL2JRJlpot6Kf3L4EQ3lYxXYT1KsDbuJE9DzJc9DhnJLqCJ71pqzVnSVw2jA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787075742; c=relaxed/simple;
	bh=OhzKu+ce3ABcPXOslWQsYcLs+2tBmJ3N14UsrQbmQSI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=vGppYZLinh8JCtoGXY6qrG4EtRXV6ajFwGguiSUWPgAWiMtK2r7T6I/imhpJfM5un+ueQjI//Qz4mcaQU4jK7HGHsfkw6vyFak9tKyt6E1IezTJTxoxAyntUeAXWl7NXQuEux18USAuz/8V8dJQXodA1Gn1JJU2eYRbxYDfPb/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ly+coEdX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ly+coEdX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 866341F000E9;
	Tue, 18 Aug 2026 17:55:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787075741;
	bh=GvdwYT+huUTK9OXt97SaGYJAD00J0ecG3t27USHi8SA=;
	h=From:Subject:Date:To:Cc;
	b=Ly+coEdX5cX5+V/grotvy3bjXwXVszoacG2YtDNqT7h3Um0JStdfnVw0sz5B8aJ0/
	 IOChFULOQIO7NMQhzk7Nm0dLV5HdHm+IMvqiXQChyYW4APTdHm2xbO5EE/77UjjXo3
	 Mz5SzkLUsE2mzte9DKX1UmOVzfPMd4cQdF3PiF8t22t9yg0qVM4mTK/HVKWp/3rL0n
	 C307Hr+3xDlrYJhJFMP+Pri7RLwSkRjUNP+kxGvajm/VPo22YxOYYIKtTaU2dJoCaZ
	 D36k/twPl011j2e63jLP/f4jJUhcI+6RM3X2EbZ56NCWUULIgxL4oOt7pY6BG5zNAs
	 LDO4KylhVZ6Ew==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH mptcp-net 0/3] mptcp: avoid uninitialised read with MPJ
 with SYN cookies
Date: Tue, 18 Aug 2026 19:55:24 +0200
Message-Id: <20260818-mptcp-cook-reqb-v1-0-052dea9a7f20@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWMQQ6CMBBFr0Jm7SRtDcV4FeNCpgMMxra21ZAQ7
 k6V5cv/762QOQlnuDYrJP5KluAr6FMDND38yCiuMhhlrLpoi69YKCKF8MTE7x7tcG6dMh053UK
 1YuJBln/xBsfZc4H7MeVPPzOVXxG2bQeT7aA9fgAAAA==
X-Change-ID: 20260816-mptcp-cook-reqb-6f35d027cd15
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=913; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=OhzKu+ce3ABcPXOslWQsYcLs+2tBmJ3N14UsrQbmQSI=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLJa5szadovF/ht3ymqTrAq5HfeapWS0Jn/afn2xVBW/f
 fFtcxnDjlIWBjEuBlkxRRbptsj8mc+reEu8/Cxg5rAygQxh4OIUgIl4cDMydP+LKI/6mZGyT2TF
 a9P9DfHSt7ZPOXV644mp/O1b/gnPq2f4xXRS5YCDm2bWyzRG9vxvAuzzft99vZk5jI+1UshqQfR
 cbgA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

This is a follow-up of [1], but addressing even less problematic
entries.

The first patch saves request_bkup, the second one avoids a possible
(harmless) KMSAN warning, and the 3rd one is a cleanup for next.

Link: https://lore.kernel.org/20260815115205.197151-1-harshitvaru666@gmail.com
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Matthieu Baerts (NGI0) (3):
      mptcp: syncookies: remember the request backup flag
      mptcp: subflow: no need to copy thmac during ulp_clone
      [next] mptcp: remove thmac from subflow ctx

 net/mptcp/protocol.h   |  1 -
 net/mptcp/subflow.c    | 19 +++++++++----------
 net/mptcp/syncookies.c |  5 ++++-
 3 files changed, 13 insertions(+), 12 deletions(-)
---
base-commit: 61862bf50d532e8a538221643cd75d25a6f4f0f4
change-id: 20260816-mptcp-cook-reqb-6f35d027cd15

Best regards,
--  
Matthieu Baerts (NGI0) <matttbe@kernel.org>

