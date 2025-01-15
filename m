Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0969723243D
	for <mptcp@lists.linux.dev>; Wed, 15 Jan 2025 07:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736924508; cv=none; b=lgr0eJxCCUPB1jzoDW8NOXAtrVCfQfK0AoncKDyJdOdJ8K1OixVPSCpR3in+CpdLicQXk0HXtgdCVLwc2Zd8zkSITOuTmYCZ+hg7RrGLvFI6CeuobAW5XR0Y65+d6ej7qe34pnbEtSjwyZVZEvUedvjsYevyniiRg3w3KiAgIVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736924508; c=relaxed/simple;
	bh=5kBKjncnYwmbebsAL0CmgtJPr7xMo64e0zzZW1lBj34=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CjjBLWN9QzUMYevZmmvnSzUGPam/NPNzzyJw9q35duHgguaU499JwZGEysnHXsGOiqXo2NnG3fxQL1HguVRbQsnviuSt1tfNWEKggp/ku3d0qqzK4SKnyEoTSVjifR62MvuLkEffd00qApLIveWWmQabDzqGLP7wQ89guSlR8p0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k/OO3wwM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k/OO3wwM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 715D8C4CEDF;
	Wed, 15 Jan 2025 07:01:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736924507;
	bh=5kBKjncnYwmbebsAL0CmgtJPr7xMo64e0zzZW1lBj34=;
	h=From:To:Cc:Subject:Date:From;
	b=k/OO3wwMlSILQnYSGRwkkoRF8XE3MPCFyX2b/inU0wcqqB4lvAxtLj8z3P5Eofqeo
	 hAwIb2jqPIxAYMRYQ5xq5Kfc4jSz/9Wd3axqRLDv4RxO9syzZqRbIvPZUF1jFDN8dM
	 KVoKtyODM5DEtoyK6Qihwtx5FqHoYCtLIGoq5bAlSQFDtoVZeeL6qjrdSEr9xNSmxQ
	 nb1U/U39G5Mpo0xZqC1wMn7xI8mqe0Re8n4GaqMFOsaSTyAyNENI61s6tXeIpUlnjE
	 z1jQrlGJSNwFpMmr4sbMesgnSsTGf/uD7yExhm1hy2J61OVN+mPWQLG5QR50iZldqG
	 UeiqyqQ8z+9gQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 0/7] BPF path manager, part 3
Date: Wed, 15 Jan 2025 15:01:33 +0800
Message-ID: <cover.1736924314.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

v2:
 - a new patch "hold msk lock before removing id 0 address"

Drop the patch "mptcp: reuse sending nlmsg code in dump_addr", add a new
helper mptcp_pm_genl_fill_addr() to save the duplicated code.

Define struct mptcp_pm_addr_id_bitmap in protocol.h, instead of defining
mptcp_pm_addr_id_bitmap_t in include/net/mptcp.h, since get_addr() and
dump_addr() interfaces of BPF userspace pm is dropped as Matt suggested.

Geliang Tang (7):
  mptcp: add mptcp_pm_genl_fill_addr helper
  mptcp: add struct mptcp_pm_addr_id_bitmap
  mptcp: drop inet6_sk in mptcp_nl_find_ssk
  mptcp: drop match in userspace_pm_append_new_local_addr
  mptcp: hold msk lock before removing id 0 address
  mptcp: update address type of get_local_id
  mptcp: change is_backup interfaces as get_flags

 net/mptcp/pm.c           | 38 +++++++++++++++---
 net/mptcp/pm_netlink.c   | 33 +++++-----------
 net/mptcp/pm_userspace.c | 84 +++++++++++++---------------------------
 net/mptcp/protocol.h     | 19 +++++++--
 4 files changed, 85 insertions(+), 89 deletions(-)

-- 
2.43.0

