Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5909E30ACF8
	for <mptcp@lists.linux.dev>; Tue,  3 Feb 2026 10:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770113960; cv=none; b=GnFwUdT5NKQhZh00XkYpX7XBGCQgK7Y+KVYvJTCQi9A39aEveREwU9d0AWuig4yBCFn52B1UE95rYeaRByzxgeX9BcS2wnlyKuTVBr/azdCnq15/4rEhSCO2kCxtlP4ih66gcYgHRt9EtUZiBTd6wfyX7k0DzVBlo4wYExorX+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770113960; c=relaxed/simple;
	bh=qnxtIAgM/9fKSHzoc1X3nZV1mZmASS50vu5mJ1i8ByE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tudx4PaYRYQfK7cBNF+NKym2UE/BXSTb0o7/iNuoRpEy9zoDmOs5iuBDlZ37GtkDsxeFRdg12tGvH0/PqzyXCyZ6GB8S3nvJy6J1wAjI7m7sEnOB8ETH6EFfQG3zlQKKZzRyRKoUraaFeLhuKelCJFzDHU5GCktTNaXP6xfl5Ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZGBVFi7y; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZGBVFi7y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F1C9C116D0;
	Tue,  3 Feb 2026 10:19:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770113960;
	bh=qnxtIAgM/9fKSHzoc1X3nZV1mZmASS50vu5mJ1i8ByE=;
	h=From:To:Cc:Subject:Date:From;
	b=ZGBVFi7yET5uwu2xQq4h60geAPeFKTA7+VVtvnC8yNKq6FampLWSd0TTDejgVOHrK
	 QkZJ+iheeyNAwjJA+oQbO3YT1kS86HUOcQ5mvY6fvmWf1jzVbuMIvZYB9L/R+ZgoIO
	 ngbHsW4lZbFtW3INefpx/xGWklqhnPN0cYi6EIBJPZEwUkgx7WpxwR+NZKspCStE0E
	 qyk991D+WFhnDnllls8ivJO/s4MBslUPNzJ79W7vvLk09P/DgNbk75U0Wg5hz8USEu
	 lX0aFl55UzpZs0xI29JKtOBtpNnyMn1ywjsThaWJszk6NnwgUA58OaIlHiZpnI6e0J
	 Q57RhPfOOjT2g==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 0/3] implement .splice_eof
Date: Tue,  3 Feb 2026 18:19:06 +0800
Message-ID: <cover.1770113743.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

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
2.52.0

