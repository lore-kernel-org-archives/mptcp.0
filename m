Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BC5F1FE471
	for <mptcp@lists.linux.dev>; Tue,  4 Mar 2025 11:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741087978; cv=none; b=KCR+uYY2qG/w+FAwKsaqKcr2WvUwjmgn1WqdLhpLs8WTOmEYv8f57I4KgTw6N7pxKe1WFFvZ90H09o1HO/6qeqtk0zbdtv1ZTuIbxqXGy3M0Y0rEipKsgv4nVKlYFEiEmxlSSUVsun8r5rCoK4u/fAChXY1VSeOH3ZA7ESGUSyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741087978; c=relaxed/simple;
	bh=8XmOgr7LI251F+0FaFgaOoVmXauDwDTOL1lYYRqXFck=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=LoQzyZDuUhq2Nv7Eaea2BFYKKjc1jbKiCa8VWcpeSbtSKYeAEVkbdsFGXJk21zBcDI+GZV4gOX5DbzEFc+6mDfETNO4kFsuC5enG8g/9n3ekx6BOvvktge24JyVtEgeNrMTkQF+eQCdeKbu38DGPyYKxjp2BPVvKZlaE2JN3NVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K/x6NTfC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K/x6NTfC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2BB0C4CEE5;
	Tue,  4 Mar 2025 11:32:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741087977;
	bh=8XmOgr7LI251F+0FaFgaOoVmXauDwDTOL1lYYRqXFck=;
	h=From:Subject:Date:To:Cc:From;
	b=K/x6NTfCARrgW8n+MNU0NGbizPxoPK0VqexA2dCP5duoNlQGfga2E86UbUrPZ5XJ1
	 /oPYvLlj1DFElN5Mjdba5oDN8By5wawhc/0fxG7pYZQ5lMyn9pNh76FcFOAulA/DMc
	 a+nxWGOqSJREH3Y3O6E36OopobJpcupJaRpP/7UZkEwOotfwJjH9Ri+Z1WeAzDTYqz
	 x8QhvTblbZ9ai90r9Lr4xO3lM+kONM2gIlySL6462BB2S+dFQOE9ug3N7M0Ficu2h+
	 W6K5Riww3tT6V/5dtBUr1LOkBA+FqmpvtmO7O4jr7VvpaMBWIu/y0agodJhZgnxDpk
	 drSD/rykOqnYQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH mptcp-net 0/2] mptcp: sockopt: fix missing get options
Date: Tue, 04 Mar 2025 12:32:49 +0100
Message-Id: <20250304-mptcp-sockopt-missing-get-v1-0-6d306d0384be@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOHkxmcC/yXMwQqEIBCA4VeJOe+AqyjUqywdFptsiFQciSB69
 6SO/+H7TxAqTAJDd0KhnYVTbPH9dOCXfwyEPLUGrbRVRhnccvUZJfk15Yobi3AMGKiisY60m7z
 rrYXmc6GZj+f9g5dFqjBe1w318WY3dgAAAA==
X-Change-ID: 20250303-mptcp-sockopt-missing-get-356e26dc6955
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=878; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=8XmOgr7LI251F+0FaFgaOoVmXauDwDTOL1lYYRqXFck=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnxuToBktDIIFg7MBj3BZ6OHdOjwayI8wk8sAsR
 9eCTXk4j8+JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ8bk6AAKCRD2t4JPQmmg
 c44ZEADkdxh9u/m81O5TvfwOUjfS8uLIbcCdLX8qh7BQBT601T93flpaABqrdFwzqnnGhLoM+2Z
 VUYcvtC2MyOzYYwax6j59gk6HDhYulghRPA2Ct5yu6JExTflNKPNW46cZjWwaTbNMYv5bwxdnt4
 2K7IxjHXGE0R61giC0F1Bvro1aPf42e/ovtCNx/B0YGtAU26HL5SFtbE5aHPUxtJlrpG9g5kn64
 LXeQL2fQS5/O9RWDDkeeqnqOtjCVMIMUMauSfBfEnejNxCf8juFEgJ7acxW90PwtTyITzoeCYao
 JS/LkCVwwhFKyHT22cdwV8C1IEOPE+vciwJ7BLOa3xtr6jfhdBmxOx6A8On2kk6TT2uc3xVDYlv
 eVXSXNaOhM0qN9COOKp0P/3blCkrufPuf5SfDamssR/1rD4G2bRcf3Ae9frTq/j7d8cSCR9QRTc
 llzap/0lL/sDOQfqvPH0ntb3eqI0ovG87VMK/2/X70kX68177r0T4GNa9+/7N2HUkQXhbUdHrrZ
 v7sJLfKo6u48B2C4DGXu37WL0zvne76jT7oCJ+f/L5nGvm5WE0tpGZdXUIIo7M5OaHZeL29rZgL
 SBN1443QtJlD7M8LH6eY8hcRS29qtBOoI2fqOg0ZKW3i+gs9YYPlX5CBjSAuwQHaMm3OZ169lbN
 N3fogfABi/OjBrg==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

When adding a socket option support in MPTCP, both the get and set parts
are supposed to be implemented.

A few socket options had the 'set' part implemented, but not the 'get'
part, while everything was in place to expose it, just the last step was
missing. It looks like this was not intentional, and the 'get' support
should have been present from the beginning, hence the 'Fixes' tags.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Matthieu Baerts (NGI0) (2):
      mptcp: sockopt: fix getting IPV6_V6ONLY
      mptcp: sockopt: fix getting freebind & transparent

 net/mptcp/sockopt.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)
---
base-commit: b084c48057bbf45fbedc06d7a9d4ec417992fb1e
change-id: 20250303-mptcp-sockopt-missing-get-356e26dc6955

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>

