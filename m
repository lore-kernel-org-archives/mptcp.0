Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 313184534B7;
	Sat, 26 Sep 2026 15:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790436652; cv=none; b=SzZqiCbx2zp341MSr6S4ByNqm9DsJqW1TePiVbuKTXLEGjHzy+QBj9fvNZYeYaxuw7MEL8yGo+SS8rzBab4PiQGadzjrh9akEXKngMPYT5Ui4Zhjx6fWv2K8j7mp4YFVW26h8SjxKCniMB1A3cBSJxBeCLjxEWUUR3dLixmK8ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790436652; c=relaxed/simple;
	bh=AzWuY2z8U/vUkS+ryriyFb9noPXYkL42OJCQbpmmsRM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=r0FgZRKwH39fXE9NYgWxxQF24KIjiuOQ2GFxrIEy+68QtGeFi1oaAB7tYQYWx8Ek6Q1lX+OAD6XX7OneIDYHLtJqRg0WB7SBBjp4tr1KvHc6d+R2nW1lMVYEyMBqMTomedOQxSzSKesediR7wIN5tH5XYBkQ0Q8SBFwYWczOzYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gDOKsAOO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gDOKsAOO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49DEB1F000FF;
	Sat, 26 Sep 2026 15:30:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790436649;
	bh=5jb3BDftf/ODffcy+muPOJTz2pJouvKTdOelPtX8WzM=;
	h=From:Subject:Date:To:Cc;
	b=gDOKsAOOGhlKivsrI26wSXM0rMpSe4IK/f3gFKDMS4ZGPdXVBhbq055FfoRZI5A/T
	 2Q9gSZTlHm8kuHqRlziY5yYBvF/i3eEtKV3hpTMO2iVUD5uUm44PvErVC2OvYv4FY7
	 PckJGrjatB1UedBwxzT9P8DJk896iJxTKCvBid9tajLAaDa1uDcs64dOJ1i7rn+LBb
	 QjchE9NuVKob+zTgW6lkS42rjxX1QtkyJpm+aTjSJwdZZhcYCDewU8ZmBhv2AjPlzD
	 J4vhhie+vAf+xHnlglZu6gcI4pQVUV+CpHZN3mv1PvD6vu37n9epEN1inq6Mtocp+s
	 IHfaGWra/63og==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH net-next 0/5] mptcp: misc improvements for v7.4
Date: Sat, 26 Sep 2026 17:30:33 +0200
Message-Id: <20260926-net-next-mptcp-misc-feat-7-4-v1-0-67af4ab37406@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/zWMQQrCQAxFr1KyNlAzU7VepbioMdUIHYeZKIXSu
 3esuPiLx+e9GbIklQznaoYkH836CgX2uwr40Ye7oN4KA9V0qFtqMIiVTYZjNI44amYcpDc8okd
 HDYlvT+ych5KISQadtnwHfxMuvye/r09h+9ZhWVbQ+jwXigAAAA==
X-Change-ID: 20260925-net-next-mptcp-misc-feat-7-4-3252e498c334
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Quanye Yang <quanyeyang@proton.me>, Hangbin Liu <liuhangbin@kylinos.cn>, 
 Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1522; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=AzWuY2z8U/vUkS+ryriyFb9noPXYkL42OJCQbpmmsRM=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLK2P1X+/93plBXvojVi876ltz/a3/7AbPPCI1wtEz+qL
 Tzja3Fbp6OUhUGMi0FWTJFFui0yf+bzKt4SLz8LmDmsTCBDGLg4BWAinscZGdq+XlC0OrUrcle4
 /KeTR7dNLChM53pf5Lfu1ttTL3mqm54yMvyfeX9ZXelG2YXvs1+aVU39u6FMSeNUT8QHaY+U9M0
 fT3ABAA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Here are some unrelated improvements for MPTCP and its selftests:

- Patch 1: reduce struct mptcp_subflow_context size: no need to store
  the truncated HMAC for the whole connection.

- Patches 2-3: shrink struct mptcp_options_received used to parse
  incoming MPTCP options, from 136 to 72 bytes on x86_64.

- Patches 4-5: convert IPTables to NFTables in MPTCP selftests.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Hangbin Liu (2):
      selftests: mptcp: convert iptables to nftables for mptcp_sockopt.sh
      selftests: mptcp: convert iptables to nftables for mptcp_join.sh

Matthieu Baerts (NGI0) (1):
      mptcp: remove thmac from subflow ctx

Quanye Yang (2):
      mptcp: split FASTCLOSE key from rcvr_key
      mptcp: shrink struct mptcp_options_received

 net/mptcp/options.c                                |   6 +-
 net/mptcp/protocol.h                               |  45 ++++---
 net/mptcp/subflow.c                                |  18 +--
 tools/testing/selftests/net/mptcp/config           |   4 +-
 tools/testing/selftests/net/mptcp/mptcp_join.sh    | 149 ++++++++-------------
 tools/testing/selftests/net/mptcp/mptcp_lib.sh     |   2 +-
 tools/testing/selftests/net/mptcp/mptcp_sockopt.sh |  58 ++++----
 7 files changed, 136 insertions(+), 146 deletions(-)
---
base-commit: 42a9fb3382fc2573e92f41d203b095d9a372cfc9
change-id: 20260925-net-next-mptcp-misc-feat-7-4-3252e498c334

Best regards,
--  
Matthieu Baerts (NGI0) <matttbe@kernel.org>

