Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04E0238A736
	for <mptcp@lists.linux.dev>; Mon,  1 Jun 2026 08:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780302463; cv=none; b=D7UWYRHcymnFZaJU2dpQBp3RBRnTX7m4yfmr+9pLVbIM2e8MiwS2SgTPOiJwcA2Wh7AmeMiAdIYhCThXJPtP/kT6ihXFkMYrqe4eNhyBZV44De+1JhfkFxjQl6JWlFmXGJP9Izpq9J1wTioxgkbUVmqQk8JpiK98lK+AhhX1yE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780302463; c=relaxed/simple;
	bh=UgnO8vkkPx7HUcxrA0wcnQS/a7sw1yM10ZUfKyCOSnw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=I+2VRvAm2KLoVr/9T6twtP2NvakEkkR7ptq1ARxhcGD1uDO7dvB0f3CJd6d6ca+2Tc4wJJvCWB/3eDTvvj/W6nwhjx3gs9NkYuTJfG4LYb0NdOEj1e62Q/wlHg5X/Ce6HoEl4zV97Rca//Atci2FrK1ZFh6avn93XmLd1jqlqHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A5i+YMhz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A5i+YMhz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C52531F00898;
	Mon,  1 Jun 2026 08:27:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780302462;
	bh=9tU98f5IVrjxHBlQKzQ/ErjOmW7KGfaTHvpaNBeBPEE=;
	h=From:Subject:Date:To:Cc;
	b=A5i+YMhzKB6aU3xgQrkisd5dpyOCJfm8p0HIbHsQMwTywvXbFbxghLD/2wan9XkcN
	 u9afgQtGjJj+k7lisoqa8UOTOla+J2AhUcsHnMstpFzHpk4KljPosbshYs5Y8Cvxbk
	 eOLcUlaa2fcOyY0bpA5Caw6BdL+NSs02EfV1M04x7DrS+kyJRYBpc0pVHmkdsOf3t/
	 CLLhVbycojXBKV015iqfMPCz0bigLLqBegX3fB6f+asDcrui9A6+LFWcpR62DCjZA/
	 bI+6n4v7cYsj4owErIY2qfyQWikFoLR1wlmrdyj1GH8ozqEswl/IFWqc6EgV1B3Pav
	 I2XA7spRkfvmA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH mptcp-next 0/4] Fixes for "mptcp: pm: drop TCP TS with
 ADD_ADDRv6 + port"
Date: Mon, 01 Jun 2026 18:27:27 +1000
Message-Id: <20260601-mptcp-add-addr6-port-ts-fixes-v2-v1-0-d7c842e80446@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWNzQqDMBCEX0X23IUYJP15ldJDTLbtFhpDdhVBf
 HejHubwMcw3CwgVJoFHs0ChiYWHVKG9NBC+Pn0IOVYGa6wzzrT4zxoy+hj3FId5KIoq+OaZBCe
 LfXf31t+cDd0VqiYXOrpqecK5TjQrvM5Oxv5HQfcPWNcNKtvOT5AAAAA=
X-Change-ID: 20260601-mptcp-add-addr6-port-ts-fixes-v2-b49a2a862c47
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1099; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=UgnO8vkkPx7HUcxrA0wcnQS/a7sw1yM10ZUfKyCOSnw=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBqHUJ9LxFDIx1PXBEdfs/WLqlJ/IRaYxsXdt3SY
 I94nQcDx86JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCah1CfQAKCRD2t4JPQmmg
 c5pREADFhKmF0aD5YGD+XENrdDKj3rq5P7POt3IktxGpCeLKJ19iXmxwrToY8YmUnOFmPEDjlSX
 q7aGcf7OsosOa38NLmtfBpk/A0ReYxNjU3UQcOZERx5glaIYHaClPTd1TjF+vJwuzg1ZgtQ2/0m
 tCJ54/FuMYQ3PRtPXmG5b+I1gQCZpq8UUrFZ4h4I94lt7vu7P+n7oEJZQfRE84IYCAJvv0ZYdRN
 YBxLNo9xHeIndXn3AVZXgL5O061zo5J57yape0O1WU+gZlJ9awvbX0qi5GZS+9dT3Kv5B3Ourpp
 PLcZo1+pgaFRKg2rdw7E+SQBHl3k1sD+VPWu6s1kzM00t7eH/Ag5MbmOtsWHsHbRufdwKlskmJa
 kqub8AvBXo4E6ul3q4rSN3yMh1jlKFk34aAp7eu6SGApT14yqzD0dx0Ow77oO6A1AW7UMoQJnWT
 e5IQNbvVAjc5DGTC5HY06mZGdiaiPWEKKE8JhsEJOIrTWuJnJckhF0S/ZQg2ptjaIReDnJM+YTl
 GrSKXm1QxYJhltIxTuxrgy5hsGbvayXYw73axTBkquR/4RXh8/3enG+JUqxx0RWTogvPSEoAV+Q
 6GuRrhNUj3skBjQmfO4DL50MaBSnxy1/IjIAY6lMBkAavEYEBUriDit6qIa1K+7DX2Ai0pCdnL8
 HX8GOSpOPKz6ONw==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

This address Eric's comments from [1].

Note that the CI will complain that not each patch can be built
individually. That's normal: the fix from patch 2 has to be split in
patch 3, to be applied in the right commit.

Link: https://lore.kernel.org/mptcp/20260601-net-next-mptcp-add-addr6-port-ts-v1-0-4fc25dfef62e@kernel.org/T/#u [1]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Matthieu Baerts (NGI0) (4):
      Squash to: "mptcp: introduce add_addr_v6_port_drop_ts sysctl knob"
      Squash to "tcp: allow mptcp to drop TS for some packets"
      Squash to "mptcp: pm: drop TCP TS with ADD_ADDRv6 + port"
      mptcp: use READ_ONCE() over sysctls

 include/net/mptcp.h   |  7 ++++---
 net/ipv4/tcp_output.c | 10 +++++++---
 net/mptcp/ctrl.c      | 18 +++++++++---------
 net/mptcp/options.c   | 13 ++++++-------
 4 files changed, 26 insertions(+), 22 deletions(-)
---
base-commit: 7676d254f320f9cce3ca42d8347334fe334dfe58
change-id: 20260601-mptcp-add-addr6-port-ts-fixes-v2-b49a2a862c47

Best regards,
--  
Matthieu Baerts (NGI0) <matttbe@kernel.org>

