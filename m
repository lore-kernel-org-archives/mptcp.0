Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0618371CE7
	for <mptcp@lists.linux.dev>; Tue, 17 Mar 2026 09:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773740510; cv=none; b=ZVBpyjmQpA6EgsOheZZ223jStVYnjo6EaR5iYLhxypT/TqkvWaqy80wChXXtnzRm0W+a+xfPnhdEXd2diwarlkcMnx9/pL5iTJOWRbhpqkLuhyN+kWlTzOJNoZDBVCr9Dz/L7B8EJ178sMaRCIDwAd/pLYVagHuzz85/M0VD174=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773740510; c=relaxed/simple;
	bh=fRyHVXquORC+1S4o6mg0hvTEye/fIg0xQk7gQ2C4LrY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fCy9pCKIkrcpBjB2nqRj1l5njgMzVRBC06/tNV2UbGj5wrazXMFxrFd0oMQI1wwaSPNc/O8D2r9RqzUP6arFlhTHRziqLn0dLHAV2VUy2TWJ7Pk0Xorgg5f+GFjXjBY50bg3prBvnuipyIXS0aUfmxvEkdBjm4hcfrXhZVjKNyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lg7qLB0w; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lg7qLB0w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FECEC4CEF7;
	Tue, 17 Mar 2026 09:41:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773740510;
	bh=fRyHVXquORC+1S4o6mg0hvTEye/fIg0xQk7gQ2C4LrY=;
	h=From:To:Cc:Subject:Date:From;
	b=lg7qLB0wWsG3WErlUcwAW4aN1UuCqyQwoXobzIe5azO+Za/p0ZrF9VF5sHWpmjbgu
	 d0408tZP+7CVqSjDkS44Gn2KTNVsLw5hXa7pU7IgBX558FeeHv08wbr3CvzeP+5Z4H
	 CR4JxWA3YFUDM5PrYRQQU69DGVOALj3WvlI3XXQl6g8Szmcses9tyYvIlAZxTrWuJj
	 0oTJ0oBlpRJ9CZww/L91bjZRYyQJHnOv4/gd8QBzt/Y6sGlpwizBo//3aKcVBdvJgQ
	 +vYxfxcYw2BfT1URYGe8Mxv4PE8GT7xa3YD6IuiP0jmdiEvOXr0nBeRETU5c4DGeZF
	 JOQjgTYtc+xwQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [RESEND PATCH mptcp-next v2 0/3] implement .splice_eof
Date: Tue, 17 Mar 2026 17:41:25 +0800
Message-ID: <cover.1773740361.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

RESEND:
 - to trigger ai review.

v2:
 - add sk_state check in mptcp_splice_eof. (Matt)
 - call mptcp_rps_record_subflows in mptcp_splice_eof. (Matt)
 - update commit logs.

This set implements .splice_eof for MPTCP and tests it.

v1:
 - Link: https://patchwork.kernel.org/project/mptcp/cover/cover.1770023932.git.tanggeliang@kylinos.cn/

Geliang Tang (3):
  tcp: export do_tcp_splice_eof
  mptcp: implement .splice_eof
  selftests: mptcp: connect: trigger splice_eof

 include/net/tcp.h                             |  1 +
 net/ipv4/tcp.c                                |  8 +++++--
 net/mptcp/protocol.c                          | 23 +++++++++++++++++++
 .../selftests/net/mptcp/mptcp_connect.c       |  2 +-
 4 files changed, 31 insertions(+), 3 deletions(-)

-- 
2.53.0

