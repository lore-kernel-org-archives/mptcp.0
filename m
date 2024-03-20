Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF6B93D0C6
	for <mptcp@lists.linux.dev>; Wed, 20 Mar 2024 12:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710938232; cv=none; b=P48WMBzKXFvU/0HCa1Fx2kJOyQDb+GhzsQ1FZ7KpClLabsFrjNKpZKUlqiSNZ/PaELZtAjgv98wYLgF2WHB7dLblOLLgQuMUhWJ5IZS/TUzuV14CchhMEptTlvSZ56CD51tgOjJfZMnbDGoP5046eRNgUeeKaELzoLlItnAvKjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710938232; c=relaxed/simple;
	bh=w/ntrsoqTP4Aq3JFTNY+kFheREOfLVqkr3SYVCrOC+0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VVLBu4IckdEcJUBg2o6v+WXlj0QM7IMYhuSQQh7FDQg5HK5xpWjQWVfBMQUGs+/f3IecV1VLFkJqtUcQ+oj4EDebW13o0d3evmoVG304Mz5p3jrCB0JDTzpyg/spcoJuFeCyq9RU8aF5anGkR/SUBA1EqBgZYCNAdA4bBZ+OvkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HONz8hPZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HONz8hPZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B16CFC433F1;
	Wed, 20 Mar 2024 12:37:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710938231;
	bh=w/ntrsoqTP4Aq3JFTNY+kFheREOfLVqkr3SYVCrOC+0=;
	h=From:To:Cc:Subject:Date:From;
	b=HONz8hPZa2pxg2+q/Qv9toYqRCRm6K5jLwOIZlXJPSDkgc38xTBLymSi+nKLPFR9b
	 ZEbGRQT5eu3aa46usGzi/ZjO/BdJwItT8nl1d6nOMzvH8RZ6CjkW/ErL6WpdoCArrl
	 dL9ZZHKLh/yOdp3GBazKlkYgwUjYVDKJyWqRrDGIQuKnCNSRcLXXGM4MFTByRX5FKs
	 qXQLsOn/eAWyv472ebvGP22zixeyzZcq4oToFbbyn0S23CrEeulrFXO/owXEZstF1D
	 Yd11D3l6F+TQAeuxhjLzW/jd+tuiGrp1RsrT9QgHmEHf2DlOd6MWVWWgvf+BnMLk/+
	 VycrxQES1C+GQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 0/4] [gs]etsockopt per subflow: BPF
Date: Wed, 20 Mar 2024 20:37:01 +0800
Message-Id: <cover.1710938175.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Address #76.

Geliang Tang (4):
  Squash to "selftests/bpf: Add bpf scheduler test" fix
  selftests/bpf: Add mptcp subflow prog
  selftests/bpf: Add mptcp subflow test
  Squash to "selftests/bpf: Add bpf scheduler test" cleanup

 .../testing/selftests/bpf/prog_tests/mptcp.c  | 131 +++++++++++++++---
 .../selftests/bpf/progs/mptcp_subflow.c       |  72 ++++++++++
 2 files changed, 182 insertions(+), 21 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/mptcp_subflow.c

-- 
2.40.1

