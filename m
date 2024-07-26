Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CFD91F951
	for <mptcp@lists.linux.dev>; Fri, 26 Jul 2024 09:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721984515; cv=none; b=gojriJJDFuQi4/C5F02QOe4/O863CN2YkVrnBXoPOR/hDSmt3Cv0KyCwAttz6z60dk1Lku4ChSIPB5BsZESYWAEWA+GRSiDPqllnMDMGQMgVPR2J9T27IRHTZ7IR/nboIYI0UrRl7XDuQ9LRX0Hfzcb0i97rK2dqF9Z8xlMQ3Yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721984515; c=relaxed/simple;
	bh=yEPcMmCeaqg3o1UyMTKaVpLPYrPv+RpiuhU93uIWic0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ovxxxoLTwlDzSbgF9O8GSAIc9xpxxfs+yDeZp6vnSM/mvwz5US2Zz3xqRe8GQjWa+CP864XU1BDIaS2xHCH+CIjVAjQppQTowd/PGeqFf42panJu7/ZhDLnFT16QU35YuxkwpO4p9JBc5Y9kaDmBzWBBgbi5nuH9Lx+IB1OyrT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CqOqjDIi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CqOqjDIi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 657B9C4AF0A;
	Fri, 26 Jul 2024 09:01:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721984515;
	bh=yEPcMmCeaqg3o1UyMTKaVpLPYrPv+RpiuhU93uIWic0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=CqOqjDIi1vPEW5ojN/+2Um12O1J9ckicE9j2rwHYEmjBFMK6qv2Ehw+bhdAP9sv8U
	 7VvPYTzsM8kaUgrHnzVGlbUZH+UsUPUjpeJQ24g2/Omxc6hSug8NtzijUpqWmpFgDg
	 IaWReMg8BSjmLqMZBEKPmfLVEDe13vi2OiXWD2OUzQ5oYTri1S0vQ4yMcP9Pm10fqN
	 rhcIZjRKOx7EHRq7oFGsnIy7fQCHfNGJaol20foMQ3Fr85J2pyZOhWVZLTp43FJnlg
	 auqP/lFXTTLPhWqwrzfWlUnkR8MCaz2aROV5B2YVixoUfF5Y0zGQfHOWx5TJ9YGwXg
	 /D843t8TOD3qw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 26 Jul 2024 11:01:41 +0200
Subject: [PATCH mptcp-iproute v3 6/7] man: mptcp: clarify the 'ID'
 parameter
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240726-mptcp-user-feedback-v3-6-c6ba1f5fa13e@kernel.org>
References: <20240726-mptcp-user-feedback-v3-0-c6ba1f5fa13e@kernel.org>
In-Reply-To: <20240726-mptcp-user-feedback-v3-0-c6ba1f5fa13e@kernel.org>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: Mat Martineau <martineau@kernel.org>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1058; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=yEPcMmCeaqg3o1UyMTKaVpLPYrPv+RpiuhU93uIWic0=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmo2X6nd+JDpzqmyWDJT2DioxQP2ObidjZ/KK2g
 7f2v9ikpJuJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZqNl+gAKCRD2t4JPQmmg
 cx5bD/0aL669xJCiVKj9VjZiQesWA1/UZCwjMBuSUpVG6CmTP7Dzv5jPAE2Qrle2nV/K6j6Ajll
 +1zEPeotTIafoEs1kruIEhC0q7FYYl3LNggx5wXQrEMdk0Z5XyYXkQiL4jvYxORP1OPplWdSQ3o
 QHFF4R1wi1FWUclBNWK6QThDtu4rjpPFCoXKLPYJcczk2DJWrcfPQFmYAxSXItkc3wS2GvGxa5u
 8FoSFTxrqf7ejrq8XYBKMk0QZfElo8lonbo561T8H9z2ocB6bdnBZwMr7AQPLGaiYvrLrbAgfMW
 jPPeH77VyootlZgh1gHsIJNSmdRf8crZ8fMAFtoPJMz/oHXyqrg84tZ33ZcfUOa7Y8UJaedHV68
 Clgsz03xhLH8NVUQcaeQsC/t9WFhJ3/XYGFwsW+9S64igNr7moC3K3HEI7syadJ4hPi5mjwvXM4
 Z+YouyDvCvS0II1DEpio5KYWtEAaFy993wdtpSSMnYRW5bW+D/6ygb12rfSSQMOXAsgKG/xHY3p
 RxpPZDnMZwrJjeuj2HpI757gZIXn+mQklIeLw5pdCCD89eLCpxIWWjAUPfDvGH6ku7jC+6TCc4e
 wUlcaGDzZUXi5hP0X0zjWCQtVBA1ioHUUCvUnr2KZi89u7pOfIEVueg/xQvcI6n9BSK1+NUMGFI
 DTw5tmwe41Zm6Nw==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Explain the range (u8), and the special case for ID 0.

The endpoints here are for all the connections, while the ID 0 is a
special case per connection, depending on the source address used by the
initial subflow. This ID 0 can then not be used for the global
endpoints.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 man/man8/ip-mptcp.8 | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/man/man8/ip-mptcp.8 b/man/man8/ip-mptcp.8
index 4c1161fe..e4a55f6c 100644
--- a/man/man8/ip-mptcp.8
+++ b/man/man8/ip-mptcp.8
@@ -148,7 +148,11 @@ expected behavior.
 
 .TP
 .IR ID
-is a unique numeric identifier for the given endpoint
+is a unique numeric identifier, between 0 and 255, for the given endpoint. It is
+not possible to add endpoints with ID 0, because this special ID is reserved for
+the initial subflow. For rules linked to the initial subflow, the path-manager
+will look at endpoints matching the same address, and port if set, ignoring the
+ID.
 
 .TP
 .BR signal

-- 
2.45.2

