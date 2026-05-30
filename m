Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88B9738A722
	for <mptcp@lists.linux.dev>; Sat, 30 May 2026 07:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780127443; cv=none; b=lxpbQIeHChCWsRQGNNRuVGEeBDvQyka1pIB2A5snxMxxTQt8esMQXOpWaAWVjBEc0V8kfNGT2LvEQrxYuUGgTxD488/5larDAB4jgB2zI0dXPYUmklbG9gUEjqFuB3pQ4YSEuFSFdMT9KhSKcvBUjwfZJveabAYxAp5dMKSe8dM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780127443; c=relaxed/simple;
	bh=aTnh8GAL2/vntYQMhhAJvIBHL1YGHdW78zKZNvIqou4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=C+SxvjICdWiEo8SVFlD5C/4ML0W3rQNHhfIINAuBwRQ21eLDynHcz9ymDbzkIBQnlAnFyD6EJ7yTKhMagabsMpPbF9m/tuXm9cD71a1ejgjYqEfZWbo8cYX77lVBX3vweLlzv9BR/XMxYQnmzeJo8tHqbzi03Ues5fba5unvdqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ibDMTKWU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ibDMTKWU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A8531F00893;
	Sat, 30 May 2026 07:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780127442;
	bh=Osrl2aLOEp8kxZTFQh9HLJ9CfAT5x25dN/h/PHNa/b4=;
	h=From:To:Cc:Subject:Date;
	b=ibDMTKWU/IPhjg+PA/yrBDpgsUoJgkeEYFpCDlQihGWUGnMrF0s6KWVVg9bB7NP+P
	 vG4D1kw/DxJ/JPY6OykbpY1dWAG8Wi7ZKSZQdX3Bqyz/+kvYH+HfZlOaVgcs+N13+1
	 m+yG1InfhmDsB2nH8HqfvttAq1C8gTpjaCsZ1haQQ6PPMzDhPF9v4owddgEo7LAyDl
	 QT/s5BXiGncthNRhtvw4MbWOxaPZdUgCXzkvrjxUig+5JzXapuBbQWUdHEG8xVTciH
	 cJ5FdCD4WFL3m4/WAV6kM79/vovYfRqesWCrQqP8xmnByRm5mxnFaIu4GXjFujjcS6
	 Lub7oFo75SOEQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 0/5] Fixes for TLS and ULP
Date: Sat, 30 May 2026 15:50:06 +0800
Message-ID: <cover.1780127277.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This series fixes several pre-existing issues in the TLS/TOE and
TCP ULP layers, found during MPTCP KTLS development.

Patches summary:

tls: add clone callback - prevent NULL pointer crash when listening
socket carries TLS ULP.

tls: init mixed SW/TOE proto - avoid NULL function pointers on TOE
fallback.

tls: fix concurrency in TOE device list iteration - safe two-pass
snapshot to eliminate list poisoning crash.

tcp: add socket lock to TCP_ULP getsockopt - fix use-after-free in
getsockopt(TCP_ULP).

tcp: fix ULP diag race by RCU - protect diag reads with RCU, paired
with release barrier.

All fixes are independent of MPTCP and can be merged separately.

Geliang Tang (5):
  tls: add clone callback to prevent NULL crash case
  tls: init mixed SW/TOE proto to prevent NULL call
  tls: fix concurrency in TOE device list iterations
  tcp: add socket lock to TCP_ULP getsockopt safely
  tcp: fix ULP diag race by RCU read locks properly

 net/ipv4/tcp.c      | 44 ++++++++++++++++++++-----------
 net/ipv4/tcp_diag.c | 15 ++++++-----
 net/ipv4/tcp_ulp.c  | 14 +++++-----
 net/tls/tls_main.c  | 16 ++++++++++++
 net/tls/tls_toe.c   | 63 ++++++++++++++++++++++++++++++++++++++-------
 5 files changed, 114 insertions(+), 38 deletions(-)

-- 
2.53.0

