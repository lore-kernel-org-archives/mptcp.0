Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A252B3399F
	for <mptcp@lists.linux.dev>; Thu, 24 Oct 2024 10:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729765366; cv=none; b=II9lwQan38OkmqCnSK+ZghvN/hviF90agDlwZO6SXxEQwUoNGsX7HGPNVGAIwEbzJ0psTfnaZfaywh7LcWJiLL+vwTourkLiythaM+NllR1aR6iOF29/gQJo+EDlHIcJRLNix9r6CGsX9YFshydTsQGeR5uwyLoGnzw6MGCyEmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729765366; c=relaxed/simple;
	bh=l2++P5PUUqMIawJy28MPJ+a//FqWvSe2fLexA0WvD5A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=t8dnC+cUcl4I06JyYMnGAKi95VPacZo8w/elmpbT6xZLxF9NZnk9VeNKEQpDfF5uec5eRz+FLrMuXfXIvgL0Lq/zv0TFrr3ieo21M+lhY1Slacglhe3n+q5IO8jsE0yhlXxsBm2rHLDWhnYAvMaD/MmflrRa3xY15fj1tuHyOQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SLDBFhju; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SLDBFhju"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69E87C4CEC7;
	Thu, 24 Oct 2024 10:22:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729765366;
	bh=l2++P5PUUqMIawJy28MPJ+a//FqWvSe2fLexA0WvD5A=;
	h=From:To:Cc:Subject:Date:From;
	b=SLDBFhjuDiyaOFyb8NUhQg4TJdZKJQF/oJZidygaBz3bKsdflIpl4DAbZOqEhUEEg
	 UCsEHv1P2JETNnxxfUYCGVh17Q7Q9uq4mZhxOb9BxF08ROCKWh1aiLCW4aSh+QWsOO
	 wur4EcoA5N4clblFNF9cheRSdHqoKg/ayVlLinQh7fN3Gd7OBoGJBDU4nLe6nz14ys
	 QkdvUeIDdJVHtn/PSIcTgIeXmPYQJy+FMjdpdhhf/BvP3peUIaGEqG+c4Bdd50UH3j
	 6U7QKIqCHcToFTAyCiaAbMq73F3giiQqrylEnuOYKX/1H8ej1nVOg8Nm7+FeYuxcXP
	 Lp/IYIVATzcog==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 0/3] Fixes for "use bpf_iter in bpf schedulers" v8
Date: Thu, 24 Oct 2024 18:22:01 +0800
Message-ID: <cover.1729765157.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

v2:
 - Use mptcp_stream_memory_free instead of using tcp_stream_memory_free.

Fix mptcp_join.sh (22) and packetdrill errors in "use bpf_iter in bpf
schedulers" (v8) reported by CI.

Depends on:
 - "use bpf_iter in bpf schedulers" v8

Based-on: <cover.1729676320.git.tanggeliang@kylinos.cn>

Geliang Tang (3):
  Squash to "mptcp: check sk_stream_memory_free in loop"
  Squash to "bpf: Export mptcp packet scheduler helpers"
  Squash to "selftests/bpf: Add bpf_burst scheduler & test"

 net/mptcp/bpf.c                                     | 7 ++++++-
 net/mptcp/protocol.c                                | 5 +++--
 tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c | 9 +++++----
 3 files changed, 14 insertions(+), 7 deletions(-)

-- 
2.45.2

