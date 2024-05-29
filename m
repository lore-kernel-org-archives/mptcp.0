Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E60C515B14A;
	Wed, 29 May 2024 10:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716976830; cv=none; b=YLclHQnwh1atjWl9yiosIzKnUUbvRlcuWyMUqWmBSCRuBNEAit2VCAP666l/4cwOTyl3Ez85F2iNmdzpdZ0Ou/tSn2vy75TqCnDU3TqvHdlo+yxpHA6Op/7VOw6Ly29e5phHVfEEhE8VWS0QIqGtJQzyLCwBKrbOYYdnGpAsYnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716976830; c=relaxed/simple;
	bh=y7QqrNzoBAPO6VO69rxxzwfOILOLeF3xhA8ORTu29Ek=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uets61kQeqj1DsdXETgq0zyToXSXngDkVinaeI93TwFzucDyV2WoKFo+Hz9Lc6MTp8/OcGCDK9RqK9KfPHeiFemcaV9rsL6VY3T69A32BJbw0eG7mec0N0AilsimJEBLoeYWA6kMWPPTNxsO+Ot8H77qkAy8NmFiSJHf2JXMD48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MKcKMAr2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MKcKMAr2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23C13C2BD10;
	Wed, 29 May 2024 10:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716976829;
	bh=y7QqrNzoBAPO6VO69rxxzwfOILOLeF3xhA8ORTu29Ek=;
	h=From:To:Cc:Subject:Date:From;
	b=MKcKMAr20nA3dCBdbT51/P0euB0b5CRSRDGQI5PmrdCTVe26GeKRGdZ9AKCV9y3oq
	 fJGagdFIKsHctEb5uP8uhB+ryy/DFOa0UfaZLeAwYhN5qwHNLpje7C6G+m9OOmVz10
	 GsuKe5tMtI+27a3VCKLsRGhS0UIiPU6ESxwzmwZYXOkzWeN1BeRf6+qKjzqLrhDYJa
	 0ofdGeo15+I77OrBmhOltQSRwPWtIXab5WXopwwR7WCXIkvfOd1V7u7rmAjluwnv1y
	 Z4RQMFq2mUEkR8agy5H2ZcdKjr1FwDtS11Nc9HYAE8ogW5AZT2t7yrEU6SLa82Oh6n
	 Jax7fLbym5DKg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: mptcp@lists.linux.dev,
	stable@vger.kernel.org,
	gregkh@linuxfoundation.org,
	sashal@kernel.org
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH 6.1.y 0/3] Backport of "mptcp: fix full TCP keep-alive support"
Date: Wed, 29 May 2024 12:00:23 +0200
Message-ID: <20240529100022.3373664-5-matttbe@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=769; i=matttbe@kernel.org; h=from:subject; bh=y7QqrNzoBAPO6VO69rxxzwfOILOLeF3xhA8ORTu29Ek=; b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmVvy2OUtJktQxLPfUNJbADxO6Y8R9OJTJsE6gH VgGhI39B1yJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZlb8tgAKCRD2t4JPQmmg c8cfD/9se0FRG48x6esv2j+oaAICTqHLi3kMuz4QoR8J1jT18kFkn6y6WSAnRRNRONHdJB0j4GW 1Rmj37SKqOmMrqW0GmfPqiQNbFWe+RrNlXJFTGeJ1N54DuoBlxF7KQlArYLJfK56sMuHTNu8YUd UC/RSObgi6JssmaZ04sYWLxogLB3/SF+hEcJ8MvONcqmw/Ld9TLDLpCLeJrg5bx61c8z6e9CZEH ihRGkXi+Ko/iW7J4OYgyLMVAKbFhkJLg+ppSGo/IS796Vt7jWGTJG0Q0XgmDOyirJIvhROei7cM lbjTwM9eqZuu2ouxauqWfv5mONhY+Veu7DFmpmUmoNR4B1qXLjc65JMDlgQPQgRMvJUW8BDx5Xw qvF7PaduehLgcvVf/M+TcSvELLMAp65bA8pdsaRn/WL7bIJOSQYx8yX9NzwCUkc4o71c/cx527F PUBi3Dpslaa4osnzrDEkOpzpYQEmAu2WimdRvrIstBJXwi+VECS50BQMAGnJzgwuJUsUL5VjxaN 4Lp8CSfdnn7Vz/L0XVAf37s4Vr5yh4ZA8K9Ssgg+QBp0b3Dqwmhn6CCVrBx++TvtSY1jky/T2Sj UIKmoeh+P2HlXH+9yO4vFt+hmzcMO91fDdLcHjyq1LGUMAx1q2iPErkp7FNRGqdbXTKyoz00mYr wQP7bhltfj7pk2A==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

It looks like the patch "mptcp: fix full TCP keep-alive support" has
been backported up to v6.8 recently (thanks!), but not before due to
conflicts.

I had to adapt a bit the code not to backport new features, but the
modifications were simple, and isolated from the rest. Conflicts have
been described in each patch.

MPTCP sockopts tests have been executed, and no issues have been
reported.

Matthieu Baerts (NGI0) (1):
  mptcp: fix full TCP keep-alive support

Paolo Abeni (2):
  mptcp: avoid some duplicate code in socket option handling
  mptcp: cleanup SOL_TCP handling

 net/mptcp/protocol.h |   3 +
 net/mptcp/sockopt.c  | 144 +++++++++++++++++++++++++++++++------------
 2 files changed, 108 insertions(+), 39 deletions(-)

-- 
2.43.0

