Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 234E74B0C82
	for <mptcp@lists.linux.dev>; Wed, 14 Oct 2026 08:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791968389; cv=none; b=Hua7a3AZsCiJxHsKRMoVVgNQAFx57qTnRXI0xsgczOL58rc5nhJ23Vz/G2lbrPjO7m91A9pzPCzvsHxY6kUTmOsBsQXhTu99tOFUgilma+gMOgWr+saQNyOAYTRZEcfpAfS1SBNloZhQEsWneZTkERBdmcBbcEYflpDlG8tkWxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791968389; c=relaxed/simple;
	bh=uHUNgb6OO0w4ys/wv5V7Yimt3mDvNpw5d2JiLKZL4BQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oJxSaSRNWPIfJlKUVkzrwnBimbqgIcL/AM27l2s7fXNIX6OfMiGkcJ8XfIny6NKrT1+Jlh3tatngyiVlL0N1szYyfYPk6q+xBz9VMgBOyvBrHDVXf+eAUn6Bll6ELHOIZZi0ZgRuHdmHDQuDZWLmrtMWez9Wq/MYrYjEb8poDCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mACYih9X; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mACYih9X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83EC71F000FF;
	Wed, 14 Oct 2026 08:59:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791968381;
	bh=8gnkbT9K08bEhdqcjvWng/DLSstfQK1/HPc9JR9eoWQ=;
	h=From:To:Cc:Subject:Date;
	b=mACYih9XZ1w655letNlso0c3IdFxREEWBTn5KUUbrEAYlj04vFVwZJvKjJcOeCLuB
	 LawJCKGFyrG5BVfl0AnADWuM0+u6ccasuGXnx3EoV+2FnqDT6w4si1GGMQvQGObNr0
	 Mw1CSDNWvwSrAcBqMz5IgKiKfXDaDJfUR45ziYad4n8CADNlWbqvlK3CYYGYa0aEBe
	 KMkNxbK93GNRlQVDE3c+An5/JzaourlJSceyonhUT8R5pztOKxhR9XC/QOBgqGcg4w
	 5wN5Jej597IUKaSbAOZfm7sN9kDdTIabf7dHIvfdteY5k41pTsOBtDShLU4nXDvzvs
	 AUcGOn9Rxjj7g==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 0/2] TLS disconnect support
Date: Wed, 14 Oct 2026 16:59:34 +0800
Message-ID: <cover.1791967771.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

To verify the correctness of MPTCP KTLS implementation, I added TLS test
support to MPTCP selftests mptcp_connect.c. The test results showed that
the disconnect test group failed with error code EOPNOTSUPP, so I added
this series to support TLS disconnect.

Patch 1 implements tls_disconnect() to support disconnect operation for
TLS sockets via connect(AF_UNSPEC).

Patch 2 updates selftests to verify the full disconnect/reconnect cycle,
including data transfer verification before and after disconnect.

Geliang Tang (2):
  tls: implement tls_disconnect
  selftests: tls: update disconnect tests

 include/net/tls.h                 |  12 +++-
 net/tls/tls_main.c                | 112 ++++++++++++++++++++++++++----
 tools/testing/selftests/net/tls.c |  57 ++++++++++++++-
 3 files changed, 163 insertions(+), 18 deletions(-)

-- 
2.55.0

