Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C08FE30F535
	for <mptcp@lists.linux.dev>; Fri, 12 Sep 2025 14:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757686842; cv=none; b=RErH+ebKnF3EnN6ShV12eXhoMZCajmpC2pjqXWfVXSRpyFJcTrHBfEVQZBuHvXPAHlUPyjPEHDF2XT3UqbddBo5pSH77AM7TS2noCBXkj4lS7ykcdBYVxmIYlXEm1TVNTP/z7mRN08biqj2jyxsECcgDVyM3oO30mV4zFHOR8xY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757686842; c=relaxed/simple;
	bh=gUy/NBJsqYzSbpKxxvFpI9G4dOl7oh0biXHwKPvTwWo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gULIynN9AxT3W0QF3I0wDYFa8V6RYGBP9G6H/ghsOAzY2Ceq6PaTN+4XBwxHkQ90lxGo9jaqDQgo+wplNaTNCTs8uqMVq7NRN0YUo6C24xfLrKJmz49VgBwvzpYQK7f4CZSK7oNNzo5hPLuQuq1lN+56i8suBQydP6o9MY7uAzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qPsppjIT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qPsppjIT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68DD0C4CEF1;
	Fri, 12 Sep 2025 14:20:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757686842;
	bh=gUy/NBJsqYzSbpKxxvFpI9G4dOl7oh0biXHwKPvTwWo=;
	h=From:To:Cc:Subject:Date:From;
	b=qPsppjITgDnXSn2bz5/zAlFFDySHVQ88lKkr8zya/wwGNAim3dsj1CYdPs3ftANVi
	 JGuRKXlNqFlYi+3ccnqhHm0GhUk/uL6pTyokNIhJGG7JmNYrsjkzm10pcTfnrLMUM7
	 uZILyxwooC1hE6ggEYQwIA7IkzAyDohjeqMdSPI0NU9bBOBOHvGWwcnAtUkIQCAL6Q
	 bo+PcixwpGj0AMhdj5pPwU5pMuA3OKSZezN+gQDxEe/fmOnn1rigQN3aDumeoh46Eh
	 wEL4pFOWBEP6UFAn73VDI5gV86PB92aoV6py/TFLcJuKcbuQVXO8sV/5Uy7symC2xQ
	 cD8ilIxwvTIAg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v4 0/9] selftests: consolidate TCP_INQ testing into sockopt
Date: Fri, 12 Sep 2025 22:19:47 +0800
Message-ID: <cover.1757686538.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

v4:
 - v3 changed the behavior of process_one_client and connect_one_server,
   causing intermittent failures during loop testing. Revert to using the
   v2 approach, along with some cleanups.

v3:
 - No longer using process_one_client_inq() and connect_one_server_inq()
   for switching; instead, the inq-related code has been merged into
   process_one_client() and connect_one_server().
 - https://patchwork.kernel.org/project/mptcp/cover/cover.1756200029.git.tanggeliang@kylinos.cn/

v2:
 - patch 4, a new patch, add do_setsockopt_inq helper.
 - cleanups.
 - https://patchwork.kernel.org/project/mptcp/cover/cover.1754664106.git.tanggeliang@kylinos.cn/

v1:
 - https://patchwork.kernel.org/project/mptcp/cover/cover.1754620968.git.tanggeliang@kylinos.cn/

This series consolidates the TCP_INQ test functionality from mptcp_inq
into mptcp_sockopt, simplifying the test suite while maintaining full
test coverage.

Geliang Tang (9):
  selftests: mptcp: sockopt: replace /dev/urandom with getrandom
  selftests: mptcp: sockopt: add protocol arguments
  selftests: mptcp: sockopt: add inq argument
  selftests: mptcp: sockopt: rename pipefd to ipcfd
  selftests: mptcp: sockopt: set TCP_INQ sockopt
  selftests: mptcp: sockopt: handle INQ on server side
  selftests: mptcp: sockopt: handle INQ on client side
  selftests: mptcp: sockopt: replace mptcp_inq with sockopt
  selftests: mptcp: sockopt: remove obsolete mptcp_inq

 tools/testing/selftests/net/mptcp/.gitignore  |   1 -
 tools/testing/selftests/net/mptcp/Makefile    |   2 +-
 tools/testing/selftests/net/mptcp/mptcp_inq.c | 613 ------------------
 .../selftests/net/mptcp/mptcp_sockopt.c       | 368 +++++++++--
 .../selftests/net/mptcp/mptcp_sockopt.sh      |   6 +-
 5 files changed, 335 insertions(+), 655 deletions(-)
 delete mode 100644 tools/testing/selftests/net/mptcp/mptcp_inq.c

-- 
2.48.1

