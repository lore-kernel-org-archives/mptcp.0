Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44E953987D
	for <mptcp@lists.linux.dev>; Sat, 29 Mar 2025 16:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743265589; cv=none; b=Nn8HY66mDBwzPW5z6KyM5/SDkTyX2RQ6DdD3+RBu8vjv2OtcX1eId5gVRjUnRIEUK8WR6am3PgyCuj5dDSZ8peX10QYmmYe/Hp0zpSNsTe3+A/38hGjVrizovxm+nSidZvmPRtVfIufO4ZOyRQ/Inr5U1TJ6YLWTrilhV2ui8x8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743265589; c=relaxed/simple;
	bh=3+2qDcOrTt9fAvOmYbRTiold+Dbs4mqEmjzwQSSOXzo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=bT8i55BOb6MfdjCSLbvFbVHzJJdGwz7OlZFeSKMHfubO+Sn5gmsnbs73qxYXUIfdbek4i+v8U9ekzRijUaHFiEtjjINsJNnjHcFIYo52c9vV2ibHdpIujCCohC9Dm8lgPnKEiOH7jyr5stZ7WuKN9b4AVp+b6Zxpdv5wDuy/2Y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iVXLJNLC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iVXLJNLC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32601C4CEE2;
	Sat, 29 Mar 2025 16:26:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743265588;
	bh=3+2qDcOrTt9fAvOmYbRTiold+Dbs4mqEmjzwQSSOXzo=;
	h=From:Subject:Date:To:Cc:From;
	b=iVXLJNLCNzrw4gON2hzdy8ADt5Xe18JY0sAL3TnhgcNxrN8K2vCVLfVw19riY980B
	 dcOHw/U3WcVJMBar5OfKzRXoBFTbcg4iOSVOlVtmWbAhoZJ8Z4R6RoG+KA6dKqEyVj
	 qcW45bPPhxEgujUXdee4As0zS011bVt5UHTSGEnhL7a4ILJ52EsiiKpapYkw/SuwJK
	 ERF0Q/0eekcHQhNbyWsQOCLx6anAnOYW5H0ceo7QJCQ04Jdk6IwZLE3jSqUOEQw84o
	 NxrQYA/bvoxqVLlQzI38ikuZcgY4Ssppmlu38YwTC9Pn+G+JPmoqUqA2q2+dxqng4t
	 obKwvbA2ijCmA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH mptcp-next 0/5] mptcp: fix MPJoinAckHMacFailure, add
 MPJoinRejected
Date: Sat, 29 Mar 2025 17:26:13 +0100
Message-Id: <20250329-mptcp-mpj-reject-v1-0-2396d5666e8f@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACUf6GcC/yWMwQqAIBAFfyX2nKCGEP1KdBBda4VMVCIQ/z2py
 8DAvFchYyLMsAwVEt6U6QpdxDiAOXTYkZHtDpJLxSc5szMWEzs9S+jRFKattXwWSk1OQZ/FhI6
 e73KFvw74FNhaewH3Pn17bgAAAA==
X-Change-ID: 20250328-mptcp-mpj-reject-addd081553f5
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1337; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=3+2qDcOrTt9fAvOmYbRTiold+Dbs4mqEmjzwQSSOXzo=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBn6B8z2xBWlJaKxn20IhbUisEYoy2BSeGwWpN7T
 UzNlbPvCt2JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ+gfMwAKCRD2t4JPQmmg
 c+18D/0Y1vaNrdL4lzbRijSj/PiM91Qxmx9J4hnrXti+8CKrrMm6zyZPoFYMCX/PinOwZoaCCc8
 /ZwVIPBC23RaQ7EaCPa5q15owIt3abLI76MeRm7a70V7urHpDBfOqSCzx3/l4ljyu/2Cll5SsSl
 Q5B7VAlObVvayHPrGxkTFDWxPl44pjyYdYKfGFVae7n8fR4GApeiMbK3Kl9YVlKEg3gkGBZwj6I
 u45ZbLTVyB6BGCgwE+L38d0tZBrUxakpsNATbC8RSi7U5IViY++JbyXV/06A/4TsBGDPfIvd9+6
 QFOO1BODOuIGeZiWBaUKWL6S4kqiH06WM8Zgrpmg+fRASAUDKt7MkVAnZhiz93EbUaw6L7/6+AP
 22toZNNQdx1wRxJ5XZK2JXMf0cnfjinW1+jPs7TXb3hFx9hyuxUU7srchHXlR8djM+rM0q0VLrd
 Yl28B93n9FsGR3BBdGR8dtB32gBnCjuFusretKim0Je341nMlekGOQ5A4jCTC1/Qk7I7gFcv70N
 5ss2kwd0YMiz1++g8Tv4OYmqjCpiF+wBzDbsCS6laPsq81zluc9/jWuOYwm1TW6DlbRh3cHbCan
 dD9EoF1qt2JjJei03ZFVvuyhGFqO9Q6eTR3Lx/0JFCA17YIPk7ljefckHqUoQwaIg2CCuaGHyaL
 4tTyw7UNLxNtNvg==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Recently, during a debugging session using local MPTCP connections, I
noticed MPJoinAckHMacFailure was strangely not zero on the server side.

The first patch fixes this issue, and the second one validates it. These
two patches can be applied in mptcp-net.

There is a small refactoring in the 3rd patch.

Patch 4 adds MPJoinRejected to track when the PM rejects patches, and
patch 5 validates it.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Matthieu Baerts (NGI0) (5):
      mptcp: only inc MPJoinAckHMacFailure for HMAC failures
      selftests: mptcp: validate MPJoin HMacFailure counters
      mptcp: pass right struct to subflow_hmac_valid
      mptcp: add MPJoinRejected MIB counter
      selftests: mptcp: validate MPJoinRejected counter

 net/mptcp/mib.c                                 |  1 +
 net/mptcp/mib.h                                 |  1 +
 net/mptcp/protocol.c                            |  4 ++-
 net/mptcp/subflow.c                             | 18 +++++-----
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 44 ++++++++++++++++++++++---
 5 files changed, 54 insertions(+), 14 deletions(-)
---
base-commit: aca18798220853f0d7a8d01c28213e0d3fccfbfc
change-id: 20250328-mptcp-mpj-reject-addd081553f5

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>

