Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D02CF86AC5
	for <mptcp@lists.linux.dev>; Wed, 31 Jan 2024 15:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706715354; cv=none; b=QuX0yR/5cG3tS7lWmhgD0vEMmouCtXyR8gTSvA2F/GOk8I5TJK7pIUmN9HIijlyT3q9NpmWKDU2lc5t1rnO8kscyQh+w23Q38HcT/6Eh6EAgFPNU4hxCas4yfUiqZLBAwR4ikeDI03w9dSSxwMxXxRm7sUOn4shG53BClRm/f5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706715354; c=relaxed/simple;
	bh=oLFVOzibIyYZKmwjYxgmcUOcgBh2DdplWUosxoEbeBY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=QNR0txaVA25h2wfPTtApx+83AGmQv0dvLmGri/qlD7OOXFpdPQP6OiONRoWfGUNSQgKqVXrTUbHjNuetgmj8F9IDaXN3uNOSgDW7DcXNW9wggLVWteuJIFoQzmC+kZsIK4OgoHzINiatTcrJR9idUbARPapt7nWl2LIoTyYKpJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XdIwyhsz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XdIwyhsz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95F6DC433C7;
	Wed, 31 Jan 2024 15:35:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706715354;
	bh=oLFVOzibIyYZKmwjYxgmcUOcgBh2DdplWUosxoEbeBY=;
	h=From:Subject:Date:To:Cc:From;
	b=XdIwyhszoOkbgTizN6ffcINCmJ1Wk9UC59tdS4kfH3qfpRTZ+moV5zhsSj9jrTyEv
	 JKUa81FubTh0ul4sjQ60r9hqKEaDLhHu7o3y76M/A3w0Z5Jl8KYm+c+LhCrmOcAl18
	 7xoSggMcP50JsJrOPQJVHLJafx2x11EKMn8lBeSojTGMEv3jFj0Mol7NMrji48mrMx
	 PDOr2izrHjor2ttQy9a0S68FFCE64rJce8hD6YeRYiPj8HaUUFlY5l2NbJLzyQWGwc
	 PfPGomuEdSlzvP0Ggtu7PiT43VmueUWJLuVMSV28+IR9/jLLb5EptrE5bboj+d55HX
	 z0WKVLBUWeeEw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH mptcp-next 0/3] mptcp: check the protocol with DEBUG_NET
Date: Wed, 31 Jan 2024 16:35:49 +0100
Message-Id: <20240131-mptcp-check-protocol-v1-0-a06067f0bd08@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANZoumUC/yXMywqDMBBG4VeRWXcgF6XQVyldyPi3DtUkJKEI4
 rs36PIsvrNTQVYUenQ7Zfy0aAwt7K0jmcfwAevUmpxxvbHe8pqqJJYZ8uWUY40SF4Z3GPxk+vE
 +UKMp463buX3SJQK2Sq/j+AM0qQr5cgAAAA==
To: mptcp@lists.linux.dev
Cc: Paolo Abeni <pabeni@redhat.com>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1564; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=oLFVOzibIyYZKmwjYxgmcUOcgBh2DdplWUosxoEbeBY=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBlumjZsczpzp536l3OfW3hidSDxMsjG4KUyYB8W
 I36gSBhTWuJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZbpo2QAKCRD2t4JPQmmg
 c8KhEACG9G9bMMeyA44hGXvHiEfzsPSuRcLo27tFxLKEzIlEMWdAL40ZiMF7HW7EUcrkrR1aT08
 1yZyNTqE8FtNwSkghozNSsXDnVzrbuDhxio2u6gJMfGLP7We1U2Yr14oMDrElXLpTPnD60JL1KT
 NkB595Wpym3m6MqHT+SPr+TzrWDnXImuqz4OQp+WcMy0W9QTJfRVdIAtHgV1qLQaC6tjj7ApNEm
 ZyxgpUVNTdI+N1ArPLZtK4iZyFtsSwpUdx5BMep7HI52qiYQfXrEORPZ4gJBxEso9Qf+46qZygO
 0KT2jfS6+ixSNBRMDnLy/ca0eDCMK+1R/1xTgEW2vjFpl6irIjHl2sVY8w0q5/tG7Zct01bPRUl
 QOPy7iFiOZ0TeegI0Qkf8UE2FXh5KoXPhd+sTW9/s22jmqLWZw5XpaKHslU/KsITCytetVbB+Iu
 5U/YLXEjmdldccpOYYly1nG8pqjMTVujwuGNACtG1dIorD2TS6TCZJyyBWFYadp5bKTvacp6roW
 QBuyX1MJn2qC1HGfbJCPBcfZdnRX0VO1tGhcCaMZbZrAPxmU36QLfnpBRLcFiYi7P1RrBrWVU7J
 EENkcXTZMLrLHoyUlZrBWFaLIlSU6vYMEM7B35TKREcSZTNFwuNJyVJ/UGvAcoXeDB5ffiaYV4u
 FbgoV7V+phFSOUA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Recently, Paolo fixed a bug where a TCP-specific helper was used with an
MPTCP socket [1]. The bug was not detected by fuzzer or static analysis.

Following this, it has been suggested to add a check, only in debug
mode. This is what this series is doing.

The series has been split to be upstreamed: a preparation patch for
MPTCP, the modification for TCP, then for MPTCP. It is not clear if it
would be OK to add that upstream. If not, we can squash these three
patches in "DO-NOT-MERGE: mptcp: improve code coverage for CI" commit we
have in our export tree.

Note that the MPTCP Token kUnit test needs to be adapted for this new
check. This is what is done in patch 1/3.

Currently, 'WARN_ON()' helper is used. Maybe we want to use the '_ONCE'
version? I didn't use it because this is a DEBUG check, but I can if we
prefer. Or something similar.

Link: https://lore.kernel.org/mptcp/35875ef9cb7194563b580e14c71cc8cb065f846c.1706043786.git.pabeni@redhat.com/ [1]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Matthieu Baerts (NGI0) (3):
      mptcp: token kunit: set protocol
      tcp: check the protocol with DEBUG_NET
      mptcp: check the protocol with DEBUG_NET

 include/linux/tcp.h    | 9 +++++++++
 net/mptcp/protocol.h   | 9 +++++++++
 net/mptcp/token_test.c | 7 ++++++-
 3 files changed, 24 insertions(+), 1 deletion(-)
---
base-commit: 12837771007b672717901b90aa9eb97a0a8c31fa
change-id: 20240131-mptcp-check-protocol-e32e53d04a75

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>

