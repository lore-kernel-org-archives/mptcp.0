Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EEDD15C120
	for <mptcp@lists.linux.dev>; Thu, 21 Nov 2024 09:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732181801; cv=none; b=Sh2dY67Ajrid0q4VEl295eWzSJ3VtIPNxipqlJbOhNQksDvNREgTBwmhNqKXWfvF2cDRYXVdfamG3PW6uknCZ+fwvuTFfDRpDRg1TUhIyUXXgl2Al2v3DNZtqW+aBDbu2kdnpyOzN4ygKhQs34pRYJbyrWBfFI+OloOaFEM+Rro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732181801; c=relaxed/simple;
	bh=D+eHwou89mFr6OzrIRcXsHd8ksfyFHdKNITiD/OgHuM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Sju3PBMS/U2HspO7UWe9qaG0E0cl8REzfac+ibFa1KAN3JPFjp8v+nwD9QnVdcGIE9BMg7hyHIBm/o3QH1J0tyri+Ja36uCjuJgeM0iY0oxMZy5xDpxEsC9wUdA4I0BIbjX8YqfpNhcpK/wzUYDz5DfwZX/G4FBkchXuod3/TRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yw41REpa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yw41REpa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0761AC4CECC;
	Thu, 21 Nov 2024 09:36:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732181800;
	bh=D+eHwou89mFr6OzrIRcXsHd8ksfyFHdKNITiD/OgHuM=;
	h=From:To:Cc:Subject:Date:From;
	b=Yw41REpaGazrpGXTGCt+2oDkNemr4Z87iaTRoMZWZA9QD/NXFaIAzUQFAKH6qeK5B
	 vm/4irwbUDi1hhEtEWpWUk/yXdUs1w641bT/swJ16m6R+RctdhKyVU9uF27igJCqh3
	 DBuOmRj902zyckvJWq+kOfq4iVDLZo+fICEeZtNmS+IxkgGKxB/mHOfPQZOmiPqk8X
	 MA17vyD1I4PTMzxyL1dgfZPIdLToiY3itZQkdgy9PJ39dKZVS4iBqIR6Df/94Zxz9T
	 oPrSxlfHub/vkCNjdTiY5D03heEHS8D9vmFOJuQCq8cUZqjFxqum9fuDs38t6jQoxw
	 eywBbJ1pukQMw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 0/3] Squash to "Add mptcp_subflow bpf_iter support"
Date: Thu, 21 Nov 2024 17:36:32 +0800
Message-ID: <cover.1732181419.git.tanggeliang@kylinos.cn>
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
 - add CONFIG_LOCKDEP check in patch 2 to fix the build error reported
   by CI.

Address Martin's comments in v1.

Geliang Tang (3):
  Squash to "bpf: Register mptcp common kfunc set"
  Squash to "bpf: Add mptcp_subflow bpf_iter"
  Squash to "selftests/bpf: Add mptcp_subflow bpf_iter subtest"

 net/mptcp/bpf.c                               | 22 ++++++++++++++-----
 .../selftests/bpf/progs/mptcp_bpf_iters.c     |  7 +++---
 2 files changed, 20 insertions(+), 9 deletions(-)

-- 
2.45.2

