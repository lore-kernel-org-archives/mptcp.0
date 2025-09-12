Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A0E0234963
	for <mptcp@lists.linux.dev>; Fri, 12 Sep 2025 03:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757648412; cv=none; b=L4FJN7gLJuJ673aBfzI0pRVPKjcoqLPVRht3T8KSyUImCY9fay5weOhM7RqodLpXg5k30Ww0diQ8mRUgn9msHb+0u8P+zGQ2HUBEk6kxYCo+SFr5QVQxM2OPYJgVyBOTDUCJmWbnnCIhCAsCWhPL6+ucJRT6VUpRDGoAvgkwFEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757648412; c=relaxed/simple;
	bh=RtA5ZvkV/GVCIqDwhcDKqv0OwosB1rQQTl5VHOW5v3k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gGdmh6f3Nn1buiE1JoYC0n8/B6HA92ig8Ie7FrCXjXmsIAxvXcKCvmhTXepjkSBMsFCTuzGSf3vFOXehywEpV1L8361znM9X6dr4GbTKoJZ+gTvR/sRgeBsuG8achC2pyUOLZTneMXyCrA3MgoVIK0QCAYwYWhUX6J9fhksIEdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k4jsgYbO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k4jsgYbO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8E9EC4CEF4;
	Fri, 12 Sep 2025 03:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757648411;
	bh=RtA5ZvkV/GVCIqDwhcDKqv0OwosB1rQQTl5VHOW5v3k=;
	h=From:To:Cc:Subject:Date:From;
	b=k4jsgYbORVY1bujEPPGNsk8MWyMk/aDl4aL7KA0Adg61X43uaOoNttAasfP1fR1P3
	 4pu3eCaIVSkZBuwm23G77+NebehjDoGYgzFIwMASkeqdKbhJTMbsPSKjuvlIn3NPwC
	 itFxETRYeBNL0R0CcxE2P5UVh66PgHJiXnacpxYIYWDc3+pEgjbZgYJcMEOlWvfI+1
	 nd801A1AGo++yTIRj3gFyGpS6t4NI8OJgK0c+zm+OdbhApuhduqSozdvR14UTA7snP
	 0NA+Zv50XSnm1TNiYB1bxJz5hcdYFykEm+YGpXpvxBpjC9nRNXo/Xrio7yVxtur8nq
	 pAd0FIZFblO8g==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v3 0/3] misc fixes for sockopt selftests
Date: Fri, 12 Sep 2025 11:40:02 +0800
Message-ID: <cover.1757647967.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

v3:
 - close(pipefds[1]) in main() instead of process_one_client().
 - close(pipefds[0]) on the server side too.
 - patch 2 and patch 3 for -next

v2:
 - patch 2: we should address this resource leak by adding the missing
   close() calls on the server side, rather than by removing the correct
   existing ones on the client side.
 - patch 3: fix more error messages as Matt suggested.
 - Link: https://patchwork.kernel.org/project/mptcp/cover/cover.1756872050.git.geliang@kernel.org/

This patch series addresses several resource management issues in the MPTCP
sockopt selftests.

Geliang Tang (3):
  selftests: mptcp: sockopt: fix error messages
  selftests: mptcp: close server file descriptors
  selftests: mptcp: close server IPC descriptors

 tools/testing/selftests/net/mptcp/mptcp_inq.c |  9 +++++--
 .../selftests/net/mptcp/mptcp_sockopt.c       | 25 +++++++++++++------
 2 files changed, 24 insertions(+), 10 deletions(-)

-- 
2.48.1

