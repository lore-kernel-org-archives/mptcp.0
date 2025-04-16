Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93F7F219A97
	for <mptcp@lists.linux.dev>; Wed, 16 Apr 2025 07:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744787989; cv=none; b=RWBM+lWNYUJPpcEdzSEDgRyNPdW2qfVDJk6FzRZKXo9o5XHT5nWrwtaJVIf7EX0LeLepbi9CxZf5PWiwWOXpX34WTT0aSUiMOkk5whNOKwJsQYQ+xVIidwNUt0Rpmj+2hVShldIdd9fGCkjQFKkKkAOWsqseXS2mtn93SuHHzGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744787989; c=relaxed/simple;
	bh=e8vnzbMbJvLl/q+C+cw+U+IpTcfPs4jvWVrYk0fPyZw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tDheaY3Qs0sFxAK2yfhBXtwedkIYoiSJEr7gQUK64gc1hlBK1Xij33WsPO+AHmPPwF/6q/LKVblvqXC28ZX9CXFUsNd+6Mwx/MCU2CZ4WZtcZVACTYrDI+w/HgCU+cWKKy14IH9L67A9+jyPFjdARqOsWflVpA63dve8BX8UXC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bLVrusYN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bLVrusYN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0083DC4CEE2;
	Wed, 16 Apr 2025 07:19:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744787989;
	bh=e8vnzbMbJvLl/q+C+cw+U+IpTcfPs4jvWVrYk0fPyZw=;
	h=From:To:Cc:Subject:Date:From;
	b=bLVrusYN3+3ld1FG68393PTmDuQyzYm5GnP/7btHDiluUfW5foZ0VQ7jRmHrXtbqw
	 VS8o0+FrwT7y/0ZTEnZLx2cR4F/khgvZUy1i7+/CeRzosqYy3T/7BWEEBZuUbekkcY
	 7Fqx4l7gPhORCde0uXk5QS0u4PvJ6lGEDu+dLLctJLf3Xz+LV1nYJ0xsxryJK7sF3W
	 BviA9AArExVszBu+HjNrv84dGXAjMbajIj2aJeRUBXUYs8iTihAihKZGE6yhRy0zY3
	 HDLtoObg4M622a3k9TQy955fmfZAXoCDjhQQdAibz/HcdlzrvEDRt5yf50CYwukGxY
	 zS7OXlybQ/jbw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v3 0/3] only remove entry from local_addr_list when sending a REMOVE_ADDR
Date: Wed, 16 Apr 2025 15:17:06 +0800
Message-ID: <cover.1744787273.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

v3:
 - update userspace selftests.

v2:
 - squash patch 1 into patch 2 as Mat suggested.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/403

Geliang Tang (3):
  mptcp: pm: userspace: drop delete_local_addr helper
  selftests: mptcp: join: update userspace dump_addr outputs
  selftests: mptcp: userspace: send RM_ADDR between server and client

 net/mptcp/pm_userspace.c                      | 37 +++----------------
 .../testing/selftests/net/mptcp/mptcp_join.sh |  6 +--
 .../selftests/net/mptcp/userspace_pm.sh       | 12 ++++++
 3 files changed, 20 insertions(+), 35 deletions(-)

-- 
2.43.0

