Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9879E2727EA
	for <mptcp@lists.linux.dev>; Fri, 29 Aug 2025 09:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756458627; cv=none; b=pKT+SCUa4rYyYY74ohbuHwy+o0+kRedjOoAXaBdII+r4fPmoxo3O3QWHP4B7PZ+fKb7hAxaAUqTu7FX/O495TCPAXy3xLsh7t+Yi4X44bGriTLO1qlik4qEWZPhtH+JyxREyhrvgmBqT5ReyuufysPnVGTXfeXXjvr8bAGeZmLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756458627; c=relaxed/simple;
	bh=goewqsKCzJyhdjbI/W3g8DPLSHZ4Koj/LQojGBWT4DA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Zn02uOuQDZX+dztCJA0lOgAV7JHd3G1akGGICpC11itli/JxaLuyI2uG4XT9atx17zsRvYDnF5pCq5xKDTLDSNFNn25KOa11Zz85vmBiyXuFTNXPtJLmim5BH73DrKkIcH3OBcxkvbw6UzwUFCKhkr8JAhW+n/NQF/5y4Kd8JMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M/7EbAM4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M/7EbAM4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB2B7C4CEF5;
	Fri, 29 Aug 2025 09:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756458627;
	bh=goewqsKCzJyhdjbI/W3g8DPLSHZ4Koj/LQojGBWT4DA=;
	h=From:To:Cc:Subject:Date:From;
	b=M/7EbAM4xYAQrl7t6zN51Eowuhsoyei3tdly12uvTxGKEkrmkSuLR9SN65ipg1cMH
	 rw+xrmFvWW7T8wzTDB345BQqgHynpl/ln28zitiokuqvxjYY53q0cACHTy9xJmo8O/
	 j0IUT4UfBYB9yxEW8CP58qnTlG9PrZYLSJf57SRjIYrdALPZSnWwNK7N/XZgpe58E6
	 f9RlVTGBRbzTbXqQlMgo/AGD8T9C8ccaogk7FKpBVbJEA2LubNiZ28wVKEa9WSSr8c
	 Qc8/1LsnE6dYl4SLTTlF+wUP9E+iD//5x8n8JpXt5bq01Ac3dk9ii2myuSyIxc4FuQ
	 hI9GlPBOyVssw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 0/2] Squash to "implement mptcp read_sock" v9
Date: Fri, 29 Aug 2025 17:10:05 +0800
Message-ID: <cover.1756458375.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

v2:
 - a new squash-to patch for "mptcp: implement .read_sock".

Based-on: <cover.1752399660.git.tanggeliang@kylinos.cn>

Geliang Tang (2):
  Squash to "mptcp: implement .read_sock"
  Squash to "selftests: mptcp: connect: cover splice mode"

 net/mptcp/protocol.c                          | 22 ++++++++++++++-----
 .../net/mptcp/mptcp_connect_splice.sh         |  3 ++-
 2 files changed, 19 insertions(+), 6 deletions(-)

-- 
2.48.1

