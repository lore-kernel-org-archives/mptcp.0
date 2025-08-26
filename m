Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABE5B3074AA
	for <mptcp@lists.linux.dev>; Tue, 26 Aug 2025 09:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756200584; cv=none; b=ciXeyqpjPmSSxmLHTY5qk3umL6aVUpt+yIuJYlisCuspwUT00KUXs1lUUyPV+DSKVGdEwuWWogHO8k4MzpxArwdFjOXK4nWzOUdwfKiUmk/FN3XTdTgPXMjVeUrM+C6sUQ4m/kQEdPeK1aViBMXcIq2BbTcsmdy+5/NX1tumM+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756200584; c=relaxed/simple;
	bh=el041z+6HmbidnReGzkmXxz9/UNQgsAxSrg1LtLkDn0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WtUwnGqXQBmzqWgYcU4ZVTzwT0J12dlzKgfMnVWU2ivyOzGsgNTrvHe3Q4SdXF24BQyPPWa67HvAfSF+gW2DdPJlRU+MvGf8fr6l/mtAqewf4dldtG44jRA23pni2NnuPvsalGz2lwd0rFsh6wlGFU29qY5Pi9XwqYYtduk/sj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=twtJntxr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="twtJntxr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01EF7C19421;
	Tue, 26 Aug 2025 09:29:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756200584;
	bh=el041z+6HmbidnReGzkmXxz9/UNQgsAxSrg1LtLkDn0=;
	h=From:To:Cc:Subject:Date:From;
	b=twtJntxrdspUpvfdQJIxI1jedEghNCn0fZ1TfmoFwTPgF44NDm4P+cBrDkItWn7LI
	 B1oPlJkEueKSe6VCARt2RVVUhL/qn1J4CIEyOaGMLuuQG7nwHD1zefvhIfEZRknIeQ
	 L2JoCkjxxeSNFT8Q0yQLRFR7gjWr1kOgWyESDS94PmhMfPRqzOV6pYDx/01Zeshfx0
	 iy+d/VaAl1Jxe5TgqirV6CXpPA1Ive/bZtD6473UZTQ+wZmH5Lerkg40AjyxyAlg0v
	 6Zz/CW2g/XmfrCzvqIucOzWMeL1nEMlGweTd+A/WiS1eOooJEL7gLm6rV6jqevISGb
	 50YB+AY/FUBsA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v3 00/14] selftests: consolidate TCP_INQ testing into sockopt
Date: Tue, 26 Aug 2025 17:29:24 +0800
Message-ID: <cover.1756200029.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

v3:
 - No longer using process_one_client_inq() and connect_one_server_inq()
   for switching; instead, the inq-related code has been merged into
   process_one_client() and connect_one_server().

v2:
 - patch 4, a new patch, add do_setsockopt_inq helper.
 - cleanups.
 - https://patchwork.kernel.org/project/mptcp/cover/cover.1754664106.git.tanggeliang@kylinos.cn/

v1:
 - https://patchwork.kernel.org/project/mptcp/cover/cover.1754620968.git.tanggeliang@kylinos.cn/

This series consolidates the TCP_INQ test functionality from mptcp_inq
into mptcp_sockopt, simplifying the test suite while maintaining full
test coverage.

Geliang Tang (14):
  selftests: mptcp: sockopt: replace /dev/urandom with getrandom
  selftests: mptcp: sockopt: add protocol arguments
  selftests: mptcp: sockopt: add inq argument
  selftests: mptcp: sockopt: set TCP_INQ on accepted sockets
  selftests: mptcp: sockopt: use unix socket instead of pipe
  selftests: mptcp: sockopt: read eof at the end of process_one_client
  selftests: mptcp: sockopt: use recvmsg instead of read
  selftests: mptcp: sockopt: read one byte first
  selftests: mptcp: sockopt: add large data transfer tests
  selftests: mptcp: sockopt: add wait_for_ack
  selftests: mptcp: sockopt: set FIONREAD ioctl
  selftests: mptcp: sockopt: add check_tcp_inq helper
  selftests: mptcp: sockopt: replace mptcp_inq with sockopt
  selftests: mptcp: sockopt: remove obsolete mptcp_inq

 tools/testing/selftests/net/mptcp/.gitignore  |   1 -
 tools/testing/selftests/net/mptcp/Makefile    |   2 +-
 tools/testing/selftests/net/mptcp/mptcp_inq.c | 608 ------------------
 .../selftests/net/mptcp/mptcp_sockopt.c       | 346 ++++++++--
 .../selftests/net/mptcp/mptcp_sockopt.sh      |   8 +-
 5 files changed, 296 insertions(+), 669 deletions(-)
 delete mode 100644 tools/testing/selftests/net/mptcp/mptcp_inq.c

-- 
2.48.1

