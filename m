Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDE7A1C07D1
	for <mptcp@lists.linux.dev>; Mon, 16 Dec 2024 10:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734345600; cv=none; b=vDqtkWH9W9GSRgqyKu5DwOaS+cGCfiCQQ5LMO5j8Y3uerEwmBabmUVtV1d3oG0fO0J+ebot9vLM91hdJ2OXWOVBXUlwySU9Tln0OBSHRLzeq1oppx/xh8UgC/o564QZTs8eerd9ze2ybvH/0+CUiFZoFIlij83OhQivTpighJC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734345600; c=relaxed/simple;
	bh=FixsQWlZJG6Z5BSRQpmgwqVEjV4jQbAvDT2ucxf/hl4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ZMRK/yZhpQW3Cy0ZnFC+H3eopdsCOGLldBdAGQiPt4iup2XlIQodrmNGluR58VJ4Hz7HAkmqEUMUwkLmHhDII5FV0YQZmsA19oKoM5aTWR1tuAMJwzycVkRTxCeAaXYh5HVIwDpuLdexdhr3D33aErK3G7b7DeFiwFGIiTbJoMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X6I+DLBq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X6I+DLBq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F00FEC4CED0;
	Mon, 16 Dec 2024 10:39:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734345600;
	bh=FixsQWlZJG6Z5BSRQpmgwqVEjV4jQbAvDT2ucxf/hl4=;
	h=From:Subject:Date:To:Cc:From;
	b=X6I+DLBq7O0/2LPHIFgodo3jAYUbK33Q9//1laSLsr2y48OpkpUnvR+15njnm+Adh
	 CynBBzJqXzkXyHLwdhKGps9aZNazZ53oCG9Pqmu6alTHJZYAJS73n/WC1/m+wm+hkO
	 EMLL7RNp0Ecx3vni4ca1/QI4BAMH/eJwDvBZUtDPS3HEqe2ZOtrjkddbgykIFZzrFZ
	 HjdddEM/GrBSH71JkZwcIxOeuEd+6EHANRyq5my8V/5AhNZq9Yx1ihsMMPx4vJ4idQ
	 bHLrytZKjFYMwCK7/bZBY9rflPRb6g/f/OeC1LS25tvr2RqW/GFy9V73/RdQ/53wNT
	 gL2jxEg/N/ncg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH mptcp-net v2 0/3] netlink: specs: mptcp: events: missing
 and clearer attr
Date: Mon, 16 Dec 2024 11:39:55 +0100
Message-Id: <20241216-mptcp-pm-nl-spec-doc-attr-v2-0-68807f55d42c@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHsDYGcC/42NTQ6CMBCFr0Jm7Rj6IwIr72FYkGGARmibtiEaw
 t1t8AIuX9773rdD5GA4QlvsEHgz0Tibg7wUQHNvJ0Yz5AyylFpIoXD1iTz6Fe2C0TPh4Aj7lAJ
 WlSK6N7VWNELmfeDRvM/vJ/wwywm6XM0mJhc+p3UT5+APwSawRNZKVDdqNNfi8eJgebm6MEF3H
 McXQIQ1Ws4AAAA=
X-Change-ID: 20241213-mptcp-pm-nl-spec-doc-attr-663cc79843cf
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1033; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=FixsQWlZJG6Z5BSRQpmgwqVEjV4jQbAvDT2ucxf/hl4=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnYAN/rbIQEdRTAgYME8rwJaQC2eYqVFaUQNB0k
 BT5BOHC0CGJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ2ADfwAKCRD2t4JPQmmg
 c7HVD/95GHBKiI1o7Gd1rpueDFwhIbkbWB3ZLyD91YoYB41ERb0QqGzygRt/lbGzX4dRTQFGHKJ
 jzmPx7y0IKd7E/nAlW7Fco4CvPa5MQf3aCg0uyKi/42qC9QtajjvqqA9D7Rl/QSCbI/LPCMO0Ef
 kTBJq5RQTEGf8yQ8XpvUfRGUXbEP4KjPgCs/BXwrFnzsRHy9EsNEHo63NhJkeRycC3pB17u1h4v
 dEzqSK8z494RoxKn6m9Yvh6XaJOURRpO8Cy88B81GlV7CYkC6QvoaVig14IH7TC30cilFJHzkOR
 98QriDcdCkYp5jZmefN4NhyHpmQ3Lf6MjuDb0WAPqgxuEdsqL51QP/yanUz7UZHkq/59ICXnCFQ
 VHbv6KYTZcQyinitXwcDOxhnydEzECzR2vBdCks45+9RucRIunnlXN4yZWbDSJx9Ub2rTtUFvNb
 dtqNcS6QhWlhLf3Tbd8WkGOj9TWB2gyLCcAiCAwIQlOFwX14EwANMkBmSxJalnB90NnIMW9Tzt7
 WQM2v7qzeKIbJWKXqPu1ZYTdvQA8BQM+tR3QEq8q1Js1mKN6q/lG3FrBvRYshcTrbM46JAjQive
 Wkh/kYZIYHA+G4iY6WYKqdPxejAVMAxPRgdp1/9C+ouywWlheKFi9e9aC5NT7WG03rbiHCkpj77
 xZlL2XaehFqyz/w==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Three small fixes for the documentation:

- The 'server-side' attribute was missing for two events

- Attributes were written at the beginning, but without explaining what
  they were.

- Replace two "todo".

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Changes in v2:
- Patch 2: shorter prefix: "Attributes:" instead of "The defined
  attributes are"
- Patch 3: new patch
- Link to v1: https://lore.kernel.org/r/20241213-mptcp-pm-nl-spec-doc-attr-v1-0-e43165c94e81@kernel.org

---
Matthieu Baerts (NGI0) (3):
      netlink: specs: mptcp: add missing 'server-side' attr
      netlink: specs: mptcp: clearly mention attributes
      netlink: specs: mptcp: fix missing doc

 Documentation/netlink/specs/mptcp_pm.yaml | 52 ++++++++++++++++---------------
 1 file changed, 27 insertions(+), 25 deletions(-)
---
base-commit: abd143d0ceebde7465127242f5eeef1e9ea4e253
change-id: 20241213-mptcp-pm-nl-spec-doc-attr-663cc79843cf

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>

