Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2CBA4C79
	for <mptcp@lists.linux.dev>; Sat,  7 Dec 2024 01:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733533691; cv=none; b=MiVIjkdZmRnXndTh/TL/jlo+qnuyfZmrP6HI0zZo8TORTxnKlAZotM2P8b4FlMZ/b20cPa31e+QTJjrenHdCg5TwRRSI/tCd+2zAciSXSvO+8unBVNY60UEf5WZqMKqlgdTUK8yjlwdW1XOCKG+Ixxo3g/xain7dh8VZ5K51K2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733533691; c=relaxed/simple;
	bh=IZzwyQ3snB852Kbu+9cQfTCj4ug0+XMSHxw/auo8M/U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cj4SMh0Ktf7hFVNFTHwVXRatAw7tdNCbsKazfSXB6AsLmJZQM1A0/258uVNUqrQgC0V3UrVCRjMFa7htr9sjYMdI3VnhVWRoYdhFkeD5Nl1cLppWG28r92qwPQ+8ld5aDI7mPjU0w4WzZm9g+1u4vligvbHdNRj4wnIW3UcUrPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hBixGsud; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hBixGsud"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76123C4CED1;
	Sat,  7 Dec 2024 01:08:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733533691;
	bh=IZzwyQ3snB852Kbu+9cQfTCj4ug0+XMSHxw/auo8M/U=;
	h=From:To:Cc:Subject:Date:From;
	b=hBixGsudexrywXE08BgpYroq9Iuu+jTHGBrmKen6pkjRL7Z2EtsD8M6+BTyTRmKPG
	 cSA7bo9nNRePbYRe+dxnxoUEzVMNo2p2JtBTEE47kvLZi6t2EG9OKr2/UXyk7kmwIP
	 0RB8g46IB1CJeJQvguLVf3GUqHBzX3m+65hu+jRX+CRSwAWvAx9efmbDzKa2iI/F+M
	 EMl9SA6no+OAScVSpvvsZkLoz9ApAoEr/4O0BMv0PnAyadafeo9muixbxgrAkQz8/J
	 wdlwIXqLpZMkvFylQebda9MS4N6DysNjxUo85JGC6Ju00FoRRO5VdobXMlb09mngOI
	 0evPXslv95wZQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang@kernel.org>
Subject: [PATCH mptcp-next 0/7] BPF path manager, part 2
Date: Sat,  7 Dec 2024 09:07:20 +0800
Message-ID: <cover.1733533215.git.geliang@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In order to implement BPF userspace path manager, it is necessary to
unify the interfaces of the path manager. This set updates get_addr()
and dump_addr() interfaces.

Geliang Tang (7):
  mptcp: make three pm wrappers static
  mptcp: drop skb parameter of get_addr
  mptcp: add id parameter for get_addr
  mptcp: reuse sending nlmsg code in get_addr
  mptcp: change info of get_addr as const
  mptcp: add info parameter for dump_addr
  mptcp: reuse sending nlmsg code in dump_addr

 include/net/mptcp.h      |   7 +++
 net/mptcp/pm.c           | 107 ++++++++++++++++++++++++++++++++++++---
 net/mptcp/pm_netlink.c   | 105 ++++++--------------------------------
 net/mptcp/pm_userspace.c |  94 ++++++++--------------------------
 net/mptcp/protocol.h     |  21 +++-----
 5 files changed, 152 insertions(+), 182 deletions(-)

-- 
2.45.2

