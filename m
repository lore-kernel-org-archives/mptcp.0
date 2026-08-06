Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7295B41A54B
	for <mptcp@lists.linux.dev>; Thu,  6 Aug 2026 09:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786007447; cv=none; b=GxI9jKtBNHwY+rDFFnKLwgkw81Tun9xj3LkM5DMLqv5auBt+BETZSaAgcGAftfigG3oxIGQEWGEcY2MD6fC69XIX8awCx4opLCbWC/KGn2bzSdpoczcxVc+rA7S9ONJvMaEZ+F5TqZHY87oAXnkq8T263XKHoojYNmZuq8M+kkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786007447; c=relaxed/simple;
	bh=Jheuys1txrDl0O4myp2EJ16Q+9ua4zI4e46579/bmE0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OM3z+DbYEjT3bGe3tEIj9gF0gbiili3sb6y+DFQcE2CmRj2INtdWEBL2595EqNpNpx7ONPAoCTTTf6RK2GLRu+NykMrNytYtNMpAeo0qHtzSv+z8bU6URM5YTh97g65Q1PZx3pzylnlFqdqQPksZse+PISeKdA5X+lVGnzuoIQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HA06EqQC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HA06EqQC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E6A41F000E9;
	Thu,  6 Aug 2026 09:10:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786007446;
	bh=3TD70PJHYvx1jhUfxq6Ckk8Rv4KgTzpO6D8gwuTTURk=;
	h=From:To:Cc:Subject:Date;
	b=HA06EqQCC7rCLoFyxu44+voOCA5voo1qEd0QcvbIqbvv3dULuLhL3RVFzuBFsUBzy
	 PdMOMCvYAWFz3B8QCcL3/j/5+l+4CPx+1wInExUePokdLLGrR364VkLYE6CUvbAYI6
	 Y/6P946TqMWk28DDThWnlGz/nil6Ti831h6byfM5hzjnyUEp1uRsQ1CoIeMzpubGTg
	 +SrZZUTd+zPESAFN+qvz1QwcKS4hIsZqY3ulwYRbnosLuAJLghy6+z67R4PpKNhQdZ
	 D9YKlz5j+j8B6fW9KR1dkt/NJAQLYW4rWCeKjKFIXWUl4aVmK38jcF4Q0k3xk9rue4
	 LZFVdo05M3r9w==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 0/2] Drop mptcp_pm_subflow_chk_stale in bpf
Date: Thu,  6 Aug 2026 17:10:36 +0800
Message-ID: <cover.1786007209.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Since mptcp_pm_subflow_chk_stale is removed in the "mptcp: address stall
under memory pressure" series, this patch drops it from BPF to keep the
BPF tests passing.

Based-on: <cover.1785943854.git.pabeni@redhat.com>

Geliang Tang (2):
  Squash to "bpf: Export mptcp packet scheduler helpers"
  Squash to "selftests/bpf: Add bpf_burst scheduler & test"

 net/mptcp/bpf.c                                     | 1 -
 tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c | 2 --
 2 files changed, 3 deletions(-)

-- 
2.53.0

