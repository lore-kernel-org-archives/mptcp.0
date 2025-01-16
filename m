Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D84271D63C3
	for <mptcp@lists.linux.dev>; Thu, 16 Jan 2025 07:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737012426; cv=none; b=hxlZKlXKSBmrlyQPSzxmYXeYYsoJuxwpdIqJ1Uku62v2XXB4MOcWp9bbBw+gftsJWOBoxkhHZ5haW3Py5MzqGmZFkIYskKgZ9MSs7TDzQHME1KIGQef9fKSfWfUUBYj7UIhaTSpa1xjalKwN2kq0y2O1ciBGaJmEFM6cU0hDujs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737012426; c=relaxed/simple;
	bh=ly9oy3s/crGxgC32F4F9yKUOxNUMyiYGORgQV45N9vM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cqXEpCJFcpRW/1yIV9TPrSWxcAnJ5ZuKeo1Xqm5RIXDhNuXM7siDUbsObpyJMpK+z0xf069AtoCQuKQeW64lTZmc4lFKJQcVIl7vfmf6nwZhjySnlU/HrtPlXTMU9XRrxzPiYSwDudi4J7+VRyvximotyedxVVfis32eMsDFEjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N2WlbMfB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N2WlbMfB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D169C4CEE4;
	Thu, 16 Jan 2025 07:27:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737012426;
	bh=ly9oy3s/crGxgC32F4F9yKUOxNUMyiYGORgQV45N9vM=;
	h=From:To:Cc:Subject:Date:From;
	b=N2WlbMfBcVS0qOby6DfwJxXva+cAbPXRJisbPjoDDFzmKABABXSMyHqf4C1J49hTW
	 ni8HfSaGscDA59UCk+kWafB8t3+YRWzStRlDij2U7vaHP5TwddI+qQ8+XqW/GT2dC/
	 Rws+UhvC963bbM5w/ZVymgZFU9rVet4BYnGk4GpmucnuUrRIYjVDEtQaNQCRMJwlvX
	 5VfdsMQkhtUwzfbGs/VGkGtHEmE/JVupEsc1b1a8Do2tgiMeY3yEaQV0OnpPIIBvZ8
	 4w5z4n6+1XYC3MUpeDNImhvuM7kk8TZeKdkvZ4qzdt5rAmPT3xa/SPi77JbQ82qbgG
	 bT5UxJb/2MkCw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v4 0/7] BPF path manager, part 3
Date: Thu, 16 Jan 2025 15:26:52 +0800
Message-ID: <cover.1737012165.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

v4:
 - add a new patch, "add a build check for userspace_pm_dump_addr" as
   Matt suggested.
 - patch 4, fix a warning here reported by CI:
   WARNING: line length of 84 exceeds 80 columns
   #27: FILE: net/mptcp/pm_userspace.c:468:

v3:
 - drop "mptcp: update address type of get_local_id".

v2:
 - a new patch "hold msk lock before removing id 0 address"

Drop the patch "mptcp: reuse sending nlmsg code in dump_addr", add a new
helper mptcp_pm_genl_fill_addr() to save the duplicated code.

Define struct mptcp_pm_addr_id_bitmap in protocol.h, instead of defining
mptcp_pm_addr_id_bitmap_t in include/net/mptcp.h, since get_addr() and
dump_addr() interfaces of BPF userspace pm is dropped as Matt suggested.

Geliang Tang (7):
  mptcp: add mptcp_pm_genl_fill_addr helper
  mptcp: add a build check for userspace_pm_dump_addr
  mptcp: add struct mptcp_pm_addr_id_bitmap
  mptcp: drop inet6_sk in mptcp_nl_find_ssk
  mptcp: drop match in userspace_pm_append_new_local_addr
  mptcp: hold msk lock before removing id 0 address
  mptcp: change is_backup interfaces as get_flags

 net/mptcp/pm.c           | 28 ++++++++++++++--
 net/mptcp/pm_netlink.c   | 20 +++--------
 net/mptcp/pm_userspace.c | 71 ++++++++++++++--------------------------
 net/mptcp/protocol.h     | 11 +++++--
 4 files changed, 65 insertions(+), 65 deletions(-)

-- 
2.43.0

