Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBD5125DB0C
	for <mptcp@lists.linux.dev>; Tue, 20 May 2025 08:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747730944; cv=none; b=Y5Q987k39/oxx9ZWgS6JfFltLLg7CYJdM61c3hm+Ubq17wh+gmnRj+AlFU+O+uVyVpBxOGGV2duu9/MZE4vPglGD6twLyUMB14+dEkV0f6Ubu8KdP7FzaMiif0UEH7m/rNlsdVj8zht+xscTFwn0dNJU7ZAHh26VJi+awniHV2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747730944; c=relaxed/simple;
	bh=vehwtZiPBpUSUE0x7va5Op3AlowROOYuTzLRomxD//Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iXzDxGmVf0g48mJqAoOjarGYAd7FFuZPsghMpMNlgk5p8Tv1eo4ZC6sk7HASnyTS+qUobUQmHm3/32pbTxFNFNqvds72bSI8Ht3esBfxc79ZoAkW2c/vYyaOi6DeInPKyAIxk3Pr8Nv2TJFIIouN00FCHDu3OFSmWtSXKeO96/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cffbcAYu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cffbcAYu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44ED6C4CEE9;
	Tue, 20 May 2025 08:49:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747730944;
	bh=vehwtZiPBpUSUE0x7va5Op3AlowROOYuTzLRomxD//Q=;
	h=From:To:Cc:Subject:Date:From;
	b=cffbcAYuxvpED7Yb8k4GaWPs+nrWbOsrR/6txiSseVN15rbEDRq6j56gqKZHYOyVK
	 o10xdOLaV4w/5r+0KDHhOyCxN5FwZkouMsPqL8/SoAsobAljfgXq/ZOCAwXefB60VU
	 n+nnoyFrsobg8ue4dlAiZ1X4Dwvqcc6NTQmD6z7yH1sY2a7I+oT/gf5A7fvPcds33j
	 Z85ouPnj52ZMHLoL+2Ct3sz8+dbTSeZ0MUsj1gzhHbV1wrLUJ7o1pmsH4KaiswTbGU
	 HgRctngvESnncXLiU49Coxeb5l2kgdCYRnKpkVsN1OFRTfhigX8RfrQTM/kKp0UWzd
	 4G3WRKQkWaX8A==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 0/2] Squash to "BPF packet scheduler"
Date: Tue, 20 May 2025 16:48:54 +0800
Message-ID: <cover.1747730598.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Two squash-to patches based on Martin's feedback for "bpf: Add
mptcp_subflow bpf_iter support" v3.

Geliang Tang (2):
  Squash to "selftests/bpf: Add mptcp_subflow bpf_iter subtest"
  Squash to "bpf: Export mptcp packet scheduler helpers"

 net/mptcp/bpf.c                                     | 13 +++++++++++++
 tools/testing/selftests/bpf/progs/mptcp_bpf.h       | 10 ++++++++++
 tools/testing/selftests/bpf/progs/mptcp_bpf_iters.c |  2 +-
 3 files changed, 24 insertions(+), 1 deletion(-)

-- 
2.43.0

