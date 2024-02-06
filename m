Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4611E745D1
	for <mptcp@lists.linux.dev>; Tue,  6 Feb 2024 05:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707198222; cv=none; b=aoT7qsFfBCEczgiAvyPyq3izicaXetPFsU84ouY51OZRUwaiAMJzi17HmuRVtjRY4PBJ3/e/tSJbdLxUKCziz329UjXAZASPCXqLaliXxk4qlwEb9y+dW5O+G4SlM43fAEMH/50STlFZGjtt1IPIg0g6V268JS+J9U1Y8JIAgnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707198222; c=relaxed/simple;
	bh=9KdGPa1usQi9wFyO+OPNq1C2oIk9TzDppmPdKpNDwp4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VBuWcngV6wd/RK7PhyXKNLhzq6I1yc/ON9ciLHPKO3v85CR1/650eKmqyxKsdhtr8QcZdoBRWov5rE6KEdkw40VWZFAbfQkO685/h19kluZKT11iLCJFL3shtJ/0dDbB3ph/MF1VgIiQ5ipbQvEr3HgnTulc7nPodF3jnoxGg/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G13X3zbx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G13X3zbx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7503CC433F1;
	Tue,  6 Feb 2024 05:43:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707198221;
	bh=9KdGPa1usQi9wFyO+OPNq1C2oIk9TzDppmPdKpNDwp4=;
	h=From:To:Cc:Subject:Date:From;
	b=G13X3zbxVdqhrSAB5hqQnnoiY2CI1VbXsI/UBAwDEdoI9vfgoy1fMX473+jit1om8
	 Cp+fBV0kiREKHX9mnlKbugsXWu0OOCIqz/QUFzZWOKyAoIi9wHjQ7qNyGXb4yGeQiX
	 Me2UkQsUd7wkK4CkVsMdA5XoBzX0E2PiXzsidEoyIJOpsntQDrvdatDmXNGA7T1sDh
	 pbPJQ5ow1BMJL3KO22Eqk6RsoPq3mAI5dMXdCJmtgnJfe4jRMkQGmV5yESdUSUS+DK
	 JhYlJt/liZYjV4m7fFtu9MSUmjriDkiCbJUmSI2B2zEZJH+aYg+1BFDiq+3FihNN6M
	 gwb2XYPCgHByA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 0/2] fixes for "map v4 address to v6"
Date: Tue,  6 Feb 2024 13:43:33 +0800
Message-Id: <cover.1707198093.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

v2:
 - update selftests as Mat suggested.

Geliang Tang (2):
  mptcp: map v4 address to v6 when destroying subflow
  selftests: mptcp: rm subflow with v4/v4mapped addr

 net/mptcp/pm_userspace.c                      | 10 +++++++
 .../testing/selftests/net/mptcp/mptcp_join.sh | 28 +++++++++++--------
 .../testing/selftests/net/mptcp/mptcp_lib.sh  |  6 ++++
 3 files changed, 32 insertions(+), 12 deletions(-)

-- 
2.40.1

