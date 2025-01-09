Received: from out203-205-221-190.mail.qq.com (out203-205-221-190.mail.qq.com [203.205.221.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7647D217725
	for <mptcp@lists.linux.dev>; Thu,  9 Jan 2025 13:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736429529; cv=none; b=T8xcMc3QFiAR29/NspM6VhmXWQ3pbKhb6iMkLEQDw428I89Ed8oGykLPT6oKMC759aKso/OYK1GVNJDW+FMi0g3ZcvG/1bOf4fCKmp+AszsfWadzfXV5tjnoomPawReBaN0nzTrP4YffwLw4isTFCJa5Ejic+EGeFW8z978m1oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736429529; c=relaxed/simple;
	bh=y1+Hcj/s42EpT37Dd76EcDF1SyiNQiklis8WZRgHdlM=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=XwW/cnykPrOxlusnE/HvLvHs1bZKVwldP21vTpkIWDrNc0A8K+ri+FhSLam07WMzayxJlSSaLulT6wXNA2PYZktSIf0EV8KO8TYbbaWP9BYxu/F2WI7SwxeExuvmb0DAXKMctLzyBsOwPjPyMT+t9sxu2JdB41lWo6rkl72G+vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=xBdzPt8o; arc=none smtp.client-ip=203.205.221.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="xBdzPt8o"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1736429520;
	bh=or7Rg0XMblpU0vAlNNN6iANPISd8cT4VKCXLD2HJniE=;
	h=From:To:Cc:Subject:Date;
	b=xBdzPt8oP6d/jxBfRx9GPfNk27VnzPwArw/T/3vFPygnojizHjI/FXL6Hv41iIRq2
	 BySA0Idrz2HBAUaRi/nRahif7DHcsRmLy8OFyEQVr/p7+klwxcuBrZDXFhRge5dB5I
	 B2RE/CHxfF4UkVpe2cgMRB7vpwzBbaUxhsZerVcE=
Received: from localhost.localdomain ([39.156.73.13])
	by newxmesmtplogicsvrsza36-0.qq.com (NewEsmtp) with SMTP
	id 7F928650; Thu, 09 Jan 2025 21:31:57 +0800
X-QQ-mid: xmsmtpt1736429517ta4mf7336
Message-ID: <tencent_3C9419313E4EE06582D82709B4EA32A2D009@qq.com>
X-QQ-XMAILINFO: NnIX2CK8LSsJAVxjuk4/GNx1sNfT+ncyCzyHy64vgwZSBDdgY9Zd0C3nzu8fJd
	 CdMbSnBzDWYdL0esYhJWOLgfCTsJFlCpyvwpJHvQBgoi7BY1mso2n4irT6MC8WITEWQYEjlr+JFK
	 nlIPRDeZepI2U0n0M4wPpGIkIkvI4AS0x1LVQ+ZNZ+aQl6XJV+uASIS0SD5S7WY46fdyS7NYuAbG
	 VEntuhXgUNqa0+dqW4wjbjlcnqFJv7Ezzdhs9skPNkEPWIwmwKaq+UIYFOUnB7Wajm45oksHZPX0
	 2ri4nwRkvi3m1abDiIqaiO+3Kh+YeMNnqXPGIUiIz52Z5s4INfmgQESAzWRIc+x0Co7E51t7cjzj
	 YNG2wpRTs+xzUYKFm/mkigYyk2oTbDR46R7Jrr1NbhQkPGGVpM5Osz/OhjB3QdUpa+iLCCX79di5
	 IBWe0T0E70N8doONDPFwfaNS/lXtfPNYY5B0v6zIZ6Hx7u58Ri0cMtjaYlNgW/2JfAqWp9IiOS9y
	 OVGbuM9oLGyce+gKbN8bvdmYlRoYRKJJ5mnqxa0ps1xAyH9lqyXwiHmhNIlJzVssKRiCEsQa4xvy
	 gM05sDLdhrvM3UfKWqPKqVcLTdFSGIUzk1JgZMIVEUxmj+A8fAO5nDuOxaORj9HQnR2O5niTrBeN
	 v6UDuWWYj6dW8JdO2zlGe/KTLtMPD+KKe+xcZCBbPbwib/ST7QSqHQniPDbd2xk9eT4X5n1aToUX
	 gPwAlbvyEaIqVvCpM9L7Gw18+KBfhKrhO2rAhyXSTcMZia0JGh7RhwrmsBnAbrXVaKpYOllLHH2p
	 hVkxzcS3qNZPBeOdhnqTkz8SSggjLB6KxcrPZ83K/iHD7A0SwktfpoQW/Zc9hWCDgHUQFTY7WZNM
	 Xea4kOuzLBFCS+vztM2gBJN6qoKhcQMU7xJknmxsCfu9b8bQada/b1OS8ehdcnaNBnr1STh2jvRv
	 8vbtd+WZtBI5S21E1eGyhyCWecROIkcw4wYu+wjA9s37DUKzSiJZ7NMZNWIT4UfCWjWfYhKD8/hO
	 MfuBR9Sg==
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
From: Gang Yan <gang_yan@foxmail.com>
To: Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>
Cc: Gang Yan <yangang@kylinos.cn>,
	mptcp@lists.linux.dev
Subject: [mptcp-next, v2, 0/3] mptcp: fix the issue of an valid signal can not join in
Date: Thu,  9 Jan 2025 21:31:51 +0800
X-OQ-MSGID: <20250109133151.220223-1-gang_yan@foxmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Gang Yan <yangang@kylinos.cn>

When we test the mptcp_join.sh, we find a bug. The 'signal invalid
addresses timeout' will be FAIL when run in real test environment,
but PASS in virtme. That's mainly because the status of invalid_addr's
tcp connection is different. It is TCPF_SYNC_SENT in virtme, but
TCPF_CLOSE in another cause the bug of 'add_addr_accepted'.

But in virtme, we can reproduce it through an invalid address
in the same LAN, this also result in an error in TCP level. These
patches will fix the issue.

Gang Yan (3):
  mptcp: fix invalid addr occupy 'add_addr_accepted'
  selftests: mptcp: relax conditions in SYN_TX validation
  selftests: mptcp: add a testcase for invalid addr timeout

 net/mptcp/pm_netlink.c                        | 25 +++++++++++++++++++
 net/mptcp/protocol.c                          |  3 +++
 net/mptcp/protocol.h                          |  2 ++
 .../testing/selftests/net/mptcp/mptcp_join.sh | 23 ++++++++++++++++-
 4 files changed, 52 insertions(+), 1 deletion(-)

-- 
2.25.1

