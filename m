Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 833E8253958
	for <mptcp@lists.linux.dev>; Sat, 25 Jul 2026 13:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784985249; cv=none; b=A48OqrBwhJagWW7P2T9CwSZdLvgd/+5G6FGy8GtepaF4tkg4ZYh4nf3aC3H/VGlLSo5cB8yR3h0x/WtlsnlMKWgNTimPUZ8JYn9GiIce1hSEmfTlP2BUsiQYEqmue70Z2rtkbgnFsLTCf149jZQh9Dne5/Akh1XAR8Pe9Oyo78g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784985249; c=relaxed/simple;
	bh=/RX+H2zox7Rc98GgzWpSrj/ZIoK60noFQ5as3ZHWBiA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=s5i+BlL/Tnr34of9sECPcr9BkqzRPKDDsXOuyGQ9tXYHrmy7DSwunzeikNhh2tLJfZuxWRQ2CPITHKeQ5h+6tsTpKq6G5rgPJ+sWCBXWtaR1i+lZCV+UCAAsERUAv7x1eTAm0zH356Zik/Ns1xknGy1HyM0amPlVbjiZ78McQDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xb02+hQK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xb02+hQK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F4C31F000E9;
	Sat, 25 Jul 2026 13:14:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784985248;
	bh=FZnWxjSFr3bZ75A3YqSxN0J8/IEVixR9qEunuyw7WkY=;
	h=From:To:Cc:Subject:Date;
	b=Xb02+hQKK1Hxl8NhTcZf5h61HVk/DhGnwIT7A2hK4UV+HvUf/T+9Wewa+l58z2nCf
	 lSAcqlqYCksa0N8C9I8Ot/3mRlYoZNzsPcfR6vLCDvRdkh7ltoO6wzvcd1bE52AG8p
	 KKnIm5nk/sQ7ZUk9JA7CEragCtvN5+4gCvgamvipVCpw/FWN2eN4FDr+MrKhWMHaJK
	 pxELccd5p8jzf7XVTFZ0U0gyq4IVkH7QWSUJ7TPDx5FzjmpOrTDH3fLao/NgBCYzyM
	 T/YKIyqtT78pejEQ10TdW97wcWd/oyxYlMg0GQdvDasZH+FBQBdy24S4VWfALY6aIq
	 pS7XPsnaY9KNw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 0/6] Fix socket options used by NVMe over MPTCP
Date: Sat, 25 Jul 2026 21:13:37 +0800
Message-ID: <cover.1784985085.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

NVMe over MPTCP relies on SO_LINGER, SO_PRIORITY, SO_REUSEADDR, TCP_SYNCNT,
TCP_NODELAY, IP_TOS, and SO_BINDTODEVICE. This series contains fixes to make
all of them work correctly. Patch 4 is a cleanup needed by patch 5. Patch 6
adds a selftest to cover these options.

Geliang Tang (6):
  mptcp: copy the subflow's rcv_tos to the msk on accept
  mptcp: don't reset dst when setting default 0 tos
  mptcp: inherit sk_reuse on subflow creation
  mptcp: handle TCP_MAXSEG getsockopt in common case
  mptcp: add TCP_SYNCNT setsockopt/getsockopt
  selftests: mptcp: sockopt: cover LINGER REUSEADDR PRIORITY NODELAY
    SYNCNT

 net/mptcp/protocol.c                          |   2 +
 net/mptcp/sockopt.c                           |  28 ++++-
 .../selftests/net/mptcp/mptcp_sockopt.c       | 116 ++++++++++++++++++
 3 files changed, 141 insertions(+), 5 deletions(-)

-- 
2.53.0

