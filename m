Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3D7C192B90
	for <mptcp@lists.linux.dev>; Tue,  1 Apr 2025 04:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743481817; cv=none; b=GdS8ITLFlnPubzHvfx+ZoE/ObhVUMoQpnnaqh93oOTW3Qr3m9G+LmL44duHBeH2c6EHtdwQvUVR3d+TBTekYKakJVL5GDA4PhxARxfUaXykiCtS0AS4OK4KUQFKtf8fJSQH4EmB7R1lNkDvBH9+xa4mKvBT7b7sfk1ydL39gC9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743481817; c=relaxed/simple;
	bh=e+zxkWajK9NSliQf3dBONPqL39vG1v8gogDX4FGP4Jk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dnf0c89osjgH/NMoToZyuGZ27O445aRPdsgnnbm4gvmXbR0xr4TUSzwi6Scz7RB8MfFwbWAHBoI7i0cvCDZgPM1/XoJDIPUofBE69NU/E4HiGTjpoYzb2dkc3b8zj8bg5SnJwM51sY2gXTFOo+4FWOhW1X7LG76Y9RMrKzqwf8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fADvZFC7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fADvZFC7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4E58C4CEE8;
	Tue,  1 Apr 2025 04:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743481817;
	bh=e+zxkWajK9NSliQf3dBONPqL39vG1v8gogDX4FGP4Jk=;
	h=From:To:Cc:Subject:Date:From;
	b=fADvZFC7nqNy4I5DVpkEsmzybb3dDDkF6auuSw4UYggq+lMt73IHLenUbLYm2SOeN
	 SGPAu+EcVz5tgp5CWBLd2dD0jcH2tjWLDJrf4zxVNo8UsYJjvN5/c/PEkw8zEF9Ufg
	 SgvanzBQmjE/6FNdpHyIMhT1l6oSiiJM6LKeE0clRvl+Q2FTTDgd+IPonv04vykdZk
	 sCBHI07WqZMcQHNFjlwJvzww0Wkz767Su/zBt9xJW1DP8BnSDKxeXd9gSUnkSH+KeZ
	 rnYH0tHYFAkmp+0iPDKH6S1WOXSmOlzPC7BJNQ7qK5eXAJcIsWjsxyhZBuliaIkyv9
	 Td7hBM4QJ9x4A==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 0/4] BPF path manager, part 7
Date: Tue,  1 Apr 2025 12:30:07 +0800
Message-ID: <cover.1743481566.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

- add_addr_received/rm_addr_received interfaces are added.
- a new interface accept_new_address() is added intead of
  add_addr_echo() in "BPF path manager, part 6" v4.

Depends on:
 - BPF path manager, part 6, v6

Based-on: <cover.1743133948.git.tanggeliang@kylinos.cn>

Geliang Tang (4):
  mptcp: pm: add accept_address helper
  mptcp: pm: add accept_new_address() interface
  mptcp: pm: add add_addr_received() interface
  mptcp: pm: add rm_addr_received() interface

 include/net/mptcp.h      |  8 +++++++
 net/mptcp/pm.c           | 45 ++++++++++++++++++----------------------
 net/mptcp/pm_kernel.c    | 34 +++++++++++++++---------------
 net/mptcp/pm_userspace.c |  7 +++++++
 net/mptcp/protocol.h     | 12 +++++++++--
 5 files changed, 62 insertions(+), 44 deletions(-)

-- 
2.43.0

