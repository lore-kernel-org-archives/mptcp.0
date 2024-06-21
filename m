Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 066A1171E41
	for <mptcp@lists.linux.dev>; Fri, 21 Jun 2024 11:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718969966; cv=none; b=rfSs3DMBQKboTMvfzUN2VECwRK6K/R35OdZ4f19fo/BvvuA5LAevKQ54j9Hg7LmhuGMoo+3Z/IxUoPMXnPAj1YD61PQMg7ZtUcFtS02NWxwGQTlrDHGGj1afskGm4ExxtlDuiR6Zpc3LZDgndKAkiUNjyQd1KS7XXICfvClP210=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718969966; c=relaxed/simple;
	bh=UCPl3BKuDDaZArIS+SUGeCKOXHJ8lQ5FzEMz/uOnisM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=RS3Y3E1QZbEf7Pq9vFY161N9vXarvXI0xbwwLj5194+oZN5AT4/G7NHa5XxqXimrjs1T2g+Gtuk/Nlunap5AbfyEngLdKmdDfBaDOx0pHRYteZgYgHZ6XdViwlXsZ+2QyIcCbKDSn6/ZEc3kF69oAI+hg5DvH9vLOqxP2y3XPFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UJFCuZcM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UJFCuZcM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5ED4C2BBFC;
	Fri, 21 Jun 2024 11:39:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718969965;
	bh=UCPl3BKuDDaZArIS+SUGeCKOXHJ8lQ5FzEMz/uOnisM=;
	h=From:Subject:Date:To:Cc:From;
	b=UJFCuZcMyanFahDOYrORbbF8f0v8TrE6MBmcliNWZOuuypj+Ogp5Bq6TojPoAMkkZ
	 R0gsAXfHHNfheyrxIZNhmroizT0m0X/e+mt6lBiIqPlZ8ee0prlaIW9Ow0TGcTIcnf
	 MUbOx5basXN0m1gihlMO/Kg2sv7Wm3kxhiM2OAHG0AtEiYmHFZtkV0Ed/5WiOD815I
	 7/S6M19R5KnlHZkrgIWhlAL5X7epgYLCoVel/ioA3z1oTmRIFhbnRu+a2EpLD+1BzR
	 Jxu9KowY5NjgpyagHhHrW1Cy6r7DzJzRFHhZVzxLOGi7A2anUTvNECbFBDolNmYzox
	 HbJ6Y4nOVhtsQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH mptcp-next 0/4] mptcp: fix endpoints with 'signal' and
 'subflow' flags
Date: Fri, 21 Jun 2024 13:39:06 +0200
Message-Id: <20240621-mptcp-pm-avail-v1-0-b692d5eb89b5@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFpmdWYC/yWM0QpAMBRAf0X32a2ZIX5FHmbuuMWsTVLy7xaPp
 845N0QKTBG67IZAJ0feXYIiz8As2s2EPCUGKaQStRS4+cN49BvqU/OKtqKyrZqRlCogRT6Q5es
 b9vC7jq4Dhud5AWQG/fZsAAAA
To: mptcp@lists.linux.dev
Cc: Paolo Abeni <pabeni@redhat.com>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2319; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=UCPl3BKuDDaZArIS+SUGeCKOXHJ8lQ5FzEMz/uOnisM=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmdWZsc/bcoaWqkdZLeIXarnfqcbsX8Q17ZJ9mQ
 JtssDYAHqqJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZnVmbAAKCRD2t4JPQmmg
 cy8sD/4/2NrtJknJMYUlri4M7r9ACuTkPXv7sJt9IzrWjFYlT3Ir/hPkyOudoyl3spTgLOUNpUf
 /GNop3E5TtNZSJkjgJtF1vG2aLZuES+6qddYGCVkMdwCmzPNLsF8mSGQpSUPNPKSnEm+KDJp54X
 R8vuy2S3+UzVMcE6O6JJ6NzdwCu7H9vVOBluYtpgQMky8l2MUnDIHFBlFrPQ9Lag6ZIJf7PaKb2
 Ejef80el6GC5sKQSnVWeNCZ4y+kW0gJ6og5yI+lugJC02rCFPPorYgLzA3GEDJvgZV7Rq2v8H3+
 h60ae1dtI4voubRK9zCYklQDzhofuAOk00+1bFa2/YC3THuZkGZtvv8KpRdV5WN/VZgIGBS1MrE
 cDUic2Dz5Akh2r+J6ybuO/XoBLfAS+GulBWo6O3QLVi7g1KnNJ1qVtmdnKpmSgiQvV2Ntt5TE0/
 vtZxJYOhFY55FxaiZLoS5R/7p+QHxukB6AfVzU9dr9vduRTaPIlSsfOsIikTHnIuVFBBxK6BI3F
 HQoa6iaavYyi2uZM6HC0qdnTRdgUiFzV3sB4gkN9bv5oh90jfaIpNmdXf/EDdVOD7iacGoxP+1e
 WQqNjfzzCdAhV5a5x4wv3IF0hciHcCIZdFr8yvw8Zfn5GFXwu6rsrqP7XHhXSRuuDvZBKxXYy/j
 QDtACgGDSpWugQw==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

When looking at improving the user experience around the MPTCP endpoints
setup, I noticed that setting an endpoint with both the 'signal' and the
'subflow' flags -- as it has been done in the past by users according to
bug reports we got -- were resulting on only announcing the endpoint,
but not using it to create subflows: the 'subflow' flag was then
ignored.

My initial thought was to modify IPRoute2 to warn the user when the two
flags were set, but it doesn't sound normal to ignore one of them. I
then looked at modifying the kernel not to allow having the two flags
set, but when discussing about that with Mat, we thought it was maybe
not ideal to do that, as there might be use-cases, we might break some
configs, and it was working before apparently. So instead, I fixed the
support by splitting the previously shared 'available IDs' bitmap.

While at it, I added a new selftest (patch 4) to validate this case --
including a modification of the chk_add_nr helper to inverse the sides
were the counters are checked (patch 3) -- and allowed ADD_ADDR echo
just after the MP_JOIN 3WHS.

The selftests modification don't have a Fixes tag, because backporting
will not be easy: on some versions, the backport will not generate
conflicts, but the test will fail because some helpers are not
available. That's OK, many CIs will use the selftests from the last
stable version to validate previous stable releases.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Matthieu Baerts (NGI0) (4):
      mptcp: fully established after ADD_ADDR echo on MPJ
      mptcp: split id_avail_bitmap per target
      selftests: mptcp: join: ability to invert ADD_ADDR check
      selftests: mptcp: join: test both signal & subflow

 net/mptcp/options.c                             |  3 +-
 net/mptcp/pm.c                                  |  3 +-
 net/mptcp/pm_netlink.c                          | 20 +++++----
 net/mptcp/protocol.h                            |  5 ++-
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 55 ++++++++++++++++++-------
 5 files changed, 60 insertions(+), 26 deletions(-)
---
base-commit: e6b62d29168e1aef6aa328f8956e5e0aadffe3d5
change-id: 20240620-mptcp-pm-avail-f5e3957be441

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>

