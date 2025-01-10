Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A7361C878E
	for <mptcp@lists.linux.dev>; Fri, 10 Jan 2025 07:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736494588; cv=none; b=mU8tRfpnNSPRctGQNB36F4rBnOa5zGA1kiPA2k01/Op8f4agjGLgyyJsAArJB2LhnFhNKs7/+JcVAjmSk55ugTIePprlXqFpa140DPWdGJeXXeMt4jx4gSftAYHonWkGaQH6ukZ0xK8Vje05GXy19uJu1nsnV9wPpgil9g6U++c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736494588; c=relaxed/simple;
	bh=2OYJms7zN/GU+CzFcCviYT6prVJtgeBJGTkCLnJgYTY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=daadN9zkhEfktW0py/IjFQf6mimtuDmrm0SkMEoh8hrZHL9t9MEGSr2jFOcbOJXK7vPzDXZL7j3GT6V6SV6lZp+TFva5XDwh70X0M9G/dq+x0O9UJMmbEolahHrlYxNGxJsJXmHM/8YrNfSn8tSdxcjyafmARIBWWvSIJDyhlCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GVmY4jtx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GVmY4jtx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBD76C4CED6;
	Fri, 10 Jan 2025 07:36:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736494586;
	bh=2OYJms7zN/GU+CzFcCviYT6prVJtgeBJGTkCLnJgYTY=;
	h=From:To:Cc:Subject:Date:From;
	b=GVmY4jtxhgpxu3iXSgRMt7MIdqsOdm2m3Tnes22YEU2cPju/fKQxxy7/e5C9hZxWK
	 Vw+TA/btPQ+M6t63ihLqLMKPlFfU8Q1aTQhyCRBYUppYx9yOBd33Vhrs4zjcdo555I
	 cNN/G+3cyics6tiIewe7NQPDVG03abCyio4dWvpkd2uXye5C4snN/wxkGIXQWnPEXE
	 YsFgJswlJJMTq7pppdRqpOvfz4jREyGDIkUggwK+v7tFJapb9CRstQ99/nOJ1E25H2
	 WCvibGv/OCGMDhaHHHD6jPiYt3SNTfJbtwL37gyUXGLKb6mfe4MW9KVNZ3Bk4ydlLa
	 kRtIXP49BpDfw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v4 0/7] BPF path manager, part 2
Date: Fri, 10 Jan 2025 15:36:13 +0800
Message-ID: <cover.1736494320.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

v4:
 - move "mptcp: userspace pm set_flags id support" out of this set.
 - only add 'local' parameter for set_flags, no 'remote'.

Based-on: <cover.1736493803.git.tanggeliang@kylinos.cn>

v3:
 - Thanks Matt for the review on dump_addr interfaces. It seems that
it needs more time to be modified. In this version, I removed the
patches for dump_addr interfaces from this set and added the patches
for set_flags interfaces.
 - set_flags interfaces patches address Matt's comments on the set
"mptcp: use GENL_REQ_ATTR_CHECK in userspace pm" v2.

v2:
 - split patch 7 of v1 into two.
 - patches 1-6 have no code changes, only the commit logs have been
updated.
 - more commit log to explain why mptcp_pm_addr_id_bitmap_t needs to
be defined.
 - use mptcp_pm_addr_id_bitmap_t in userspace_pm_append_new_local_addr
too.

In order to implement BPF userspace path manager, it is necessary to
unify the interfaces of the path manager. This set updates get_addr()
and dump_addr() interfaces.

Geliang Tang (7):
  mptcp: make three pm wrappers static
  mptcp: drop skb parameter of get_addr
  mptcp: add id parameter for get_addr
  mptcp: reuse sending nlmsg code in get_addr
  mptcp: drop skb parameter of set_flags
  mptcp: change rem type of set_flags
  mptcp: add local parameter for set_flags

 net/mptcp/pm.c           |  86 +++++++++++++++++++++++++++++---
 net/mptcp/pm_netlink.c   | 104 ++++++++-------------------------------
 net/mptcp/pm_userspace.c |  81 +++++++-----------------------
 net/mptcp/protocol.h     |  14 +++---
 4 files changed, 124 insertions(+), 161 deletions(-)

-- 
2.45.2

