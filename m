Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F364C3D68
	for <mptcp@lists.linux.dev>; Mon, 17 Feb 2025 08:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739781479; cv=none; b=DaAgo5K6PlGzqdw25YJiO4lKYOfoQGW/S9KY0nEBFWwPIF2IaETOhIGY0lGEI1wysJxLXpeU5MXV8dYynMp4KS8sofCuTIs4wqT87pgIVMTSQmN//EDn9BGunlZ6G/P2p/2uBZSR9DGz70x4MiCkC+sXTmRIBwLg5KhfBGN17VE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739781479; c=relaxed/simple;
	bh=xS2bUt6fBHVc61WQkV7K4TJBNmaKqC7RFVPkneT+T0A=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=VNDe1YpwGw5ghbRi6+W06t2aPKt8JJAU14iC+hGuOnGGKXAHmKChGqsA/RbPOvhT3aE3cTD8ZOZ0BNSO9X406fz5uf3Gej3JRKZEpwdKQee1TV/M2sM9CGDFPNQBlWCCXcY2dn4YoRmZd/JXwfkkoRNMCvvEiuObNpDuaAzDgIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jmGelxKQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jmGelxKQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94E93C4CED1;
	Mon, 17 Feb 2025 08:37:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739781478;
	bh=xS2bUt6fBHVc61WQkV7K4TJBNmaKqC7RFVPkneT+T0A=;
	h=From:Subject:Date:To:Cc:From;
	b=jmGelxKQdBJv7DWr0e0F6JwFg52ME3FTPTggYc8DmdgiFq8NH/tzJNu5PR+zKF9kz
	 iXVx+5XXrJcOwI0mRPGk/JJtMX7sq57HcCOxx+nWee0GdRPnGX7QoeuQlIAYJz+ycC
	 mBpvXJzrRABm05bm1nHe79jAHg/DIbgtxVg4KiW739614Edb9hAVl8fgSLb5hWrhmj
	 r8NYrXXOUZ3QgIkwVvhiAf0lOzwINQ+/Y1EMJrlm+wJcGKCEhH3tBWBApLof3rO55w
	 JKoTOmOR9onK9SGQfWpIyeqIE5SJLB5ploxq2sgW6GrPEJC1IambxTZrZ4UYOfjWNI
	 VfANANmG8wNfg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH mptcp-net 0/3] mptcp: reset when MPTCP opts are dropped
 after MPJ
Date: Mon, 17 Feb 2025 09:37:40 +0100
Message-Id: <20250217-mptcp-dss-drop-mpj-v1-0-d671d6b9a153@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFT1smcC/yXMQQqAMAxE0atI1gZqqIheRVxIGzWCtTQignh3i
 y4f/JkblJOwQlfckPgUlT1kVGUBbhnDzCg+G8hQbcjUuMXDRfSq6NMeM1dkR9RMln1rCfIwJp7
 k+k57+PvABwzP8wKNclKtbwAAAA==
X-Change-ID: 20250205-mptcp-dss-drop-mpj-ec227f4ed942
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 "Chester A. Unal" <chester.a.unal@xpedite-tech.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1228; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=xS2bUt6fBHVc61WQkV7K4TJBNmaKqC7RFVPkneT+T0A=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnsvVkcJnW71v13BFxVIfJSO2ghOM2r9ex+xVs7
 9T9+/fy/5yJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ7L1ZAAKCRD2t4JPQmmg
 c0hLEAC4mYEBkdsbXQbfh5qtNBFdC9kAop4+ge68cibXkWcJr4OXSAUHrRvIRGY91cPRmBwHOkd
 yJInNpL7eY4FgPYQGuO1wJih8EZq2AgnkZRYEcMKGrIkGUCC/WkChnErKUERQaJO1JbK72lx3s/
 iBIxl3uqosK/21q+1FlXnz7PgOsyH84CLMzIjHbekWdN1go8DAe+RK2L3jaT3X4zgfcbVbtzVuP
 pPaTTEVACdJSqCyOC9sSwDIWnU03Z4jJ91EQk7GcWbnmFrYK3Iuy3AacGiHTlAywX3nFsMXmKan
 WL1cFdCRoiwjQof//9xjtLRM6DboRDUsZkAlCGLpoNgT+KVe7IupnZo2tGFMnlPolTn1M/9GvA4
 AXSiwDpjnRB9lxA517A9zmaS907+GsnicLQ7e5rBr5de8BnhN73kmp+oNMv2DUTwWiCQOm4V99d
 APwBnpoZH/1yGOJMi17cXi5HBzS0Dlk7P8icy7e6Q9LIZnwqAhp2JC13dCpkLL/ZcmeTki+e0g+
 ZovLOVQYlzDQrQLftA2Cfs5bSknAvAUX6EorVoHrwJgXkG8BUOapAc6nfQt8mxfZRPtXYQ9Tm6g
 Fd5DI25nv/rJvWd3DcqWqq/jRLWHzZo9ch419G0JwGPUn2kyJu15ycCU9OfOUfk9SjMVQB+IVvo
 EzKVRiUChumZ+sg==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

This series fixes the issue #544 where a middlebox drops MPTCP options
after a 3WHS on the additional subflow.

Two additional patches have been added:

- Patch 2: for an issue seen when debugging the previous one: there
  should be a fallback after the reception of an infinite mapping, only
  if allowed.

- Patch 3: to avoid the issues fixed by the two patches above, a safety
  check is added when asking to do a fallback if it is not possible to
  do so. A warning will be emitted in this case.

Note that two new packetdrill tests have been added in a PR to cover
this case:

  https://github.com/multipath-tcp/packetdrill/pull/160

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Matthieu Baerts (NGI0) (3):
      mptcp: reset when MPTCP opts are dropped after join
      mptcp: only fallback due to inf mapping if allowed
      mptcp: safety check before fallback

 net/mptcp/protocol.h |  2 ++
 net/mptcp/subflow.c  | 23 ++++++++++++++---------
 2 files changed, 16 insertions(+), 9 deletions(-)
---
base-commit: 3a7786db65e8f361a8fc8abcd3cfbe17411b8b7f
change-id: 20250205-mptcp-dss-drop-mpj-ec227f4ed942

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>

