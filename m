Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E235B402BBA;
	Mon, 11 May 2026 15:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778514411; cv=none; b=gymwjdbBXI774hcyoIkYJh1VWmeou/ggKN8f8PFPKhvjqWx85efCBS6jVijLBuX3juXdOH/vnE66clVkAu1Enwhfpo0wKlDKSpYqeJUUOwlE85k+FtjWEisgkzsRvMMhpQt2MQdPwJ/tbbv4hwpavck93JXm6bz5qY6Ay5l5VUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778514411; c=relaxed/simple;
	bh=7sqpX/RGgiQGlcXoNsGZI8XmaqwweqJXC66BEehtjaE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=YItFVWB7lIkpXcyyDBH3xd54M8NNAZ4+aOpI0Yfmi80OaE2wGqlXx86A43bWlaUmKKE0vky9y5UhFMMBzSBVsvNmTiOVMXkdeKSE1a1gW3uIwaSkfwPqK7IRUR+Zq9N/VFt2SI4i3ONb/24671w/io3nso+hw8lTMbp2xtL7XwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ByKj8eDy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ByKj8eDy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A661BC2BCB0;
	Mon, 11 May 2026 15:46:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778514410;
	bh=7sqpX/RGgiQGlcXoNsGZI8XmaqwweqJXC66BEehtjaE=;
	h=From:Subject:Date:To:Cc:From;
	b=ByKj8eDy/sajVMez24k171DDOg94hEs8RiwJd8SGiO4pvsFBKDh3T2BW5Z2xcqyNX
	 31F543lXn/SNSZdatVJcPga0beXKS4+UXKF6g41sgJK5P3oXpP5VbL2RVVlra6ZzoS
	 iwkag3FkD37RYm/Zor00L5iTjtkbZkHL07+rIXwkfKhFxCUDWlZQwAEY5V7FOIDMrd
	 5nDWTjqSZBBRdjVYau2++grz1ONTf0JgA9TUiMwovwwQKXILa+hd1+Atx1SWPzbiou
	 4eh8hgsT+b6sH4+FlZlTHgDeYwqQ3aWmlpwZGS9uKiw5bxLgcxIOojGM1icEkZmQge
	 0jwn9U8hSds7Q==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH net 0/5] mptcp: misc fixes for v7.1-rc4
Date: Mon, 11 May 2026 17:46:26 +0200
Message-Id: <20260511-net-mptcp-misc-fixes-7-1-rc4-v1-0-5ee57cb2b7eb@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWM0QrCMBAEf6XcswdJiBX8FfFBrxs9oTHkUhFK/
 92oj7PszEqGqjA6DitVvNT0mTv43UByv+QbWKfOFFwY3d57zmg8lyaFZzXhpG8YH9hzlcgIY3R
 pikhBqCdKxe/QCyfqJp3/oy3XB6R9w7RtHy96DuqFAAAA
X-Change-ID: 20260511-net-mptcp-misc-fixes-7-1-rc4-e2640fd4ef2c
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: Eric Dumazet <edumaze@google.com>, netdev@vger.kernel.org, 
 mptcp@lists.linux.dev, linux-kernel@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Shardul Bankar <shardul.b@mpiricsoftware.com>, stable@vger.kernel.org, 
 Li Xiasong <lixiasong1@huawei.com>, Shuah Khan <shuah@kernel.org>, 
 linux-kselftest@vger.kernel.org, Gang Yan <yangang@kylinos.cn>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1507; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=7sqpX/RGgiQGlcXoNsGZI8XmaqwweqJXC66BEehtjaE=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLIYfz4+ujZ1H6vK2hZ7W/MH87zW/PHp/W9aWpq136rnt
 GRE5hPZjlIWBjEuBlkxRRbptsj8mc+reEu8/Cxg5rAygQxh4OIUgIn85GNk+GWseSzKymvXt9j3
 25Pcg1aqXV3KNO3tu8pTLwvucb0vUGX477Gb7/H/CTklXxuuTtik3x2YpbHnfeRJb/MfvpdM2u0
 7eQE=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Here are various unrelated fixes:

- Patch 1: avoid dropping partial packets. A previous version has been
  sent a few week ago. A fix for 5.10.

- Patches 2-3: stop ADD_ADDR timer when an ADD_ADDR can never been sent
  due to insufficient option space. A fix for v5.10.

- Patch 4: reset rcv_wnd_sent on disconnect, just in case the next
  connection falls back to TCP. A fix for 5.17.

- Patch 5: update window_clamp when SO_RCVBUF is set during the
  connection. A fix similar to a recent one on TCP side, for v6.6.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Gang Yan (1):
      mptcp: update window_clamp on subflows when SO_RCVBUF is set

Li Xiasong (2):
      mptcp: pm: fix ADD_ADDR timer infinite retry on option space insufficient
      selftests: mptcp: join: cover ADD_ADDR tx drop and list progress

Paolo Abeni (1):
      mptcp: reset rcv wnd on disconnect

Shardul Bankar (1):
      mptcp: do not drop partial packets

 net/mptcp/pm.c                                  | 56 ++++++++++++++++++++-----
 net/mptcp/protocol.c                            | 25 ++++++++---
 net/mptcp/sockopt.c                             | 10 ++++-
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 31 ++++++++++++++
 4 files changed, 105 insertions(+), 17 deletions(-)
---
base-commit: a450063ef86b9967234ca1f896c0d77400c74f11
change-id: 20260511-net-mptcp-misc-fixes-7-1-rc4-e2640fd4ef2c

Best regards,
--  
Matthieu Baerts (NGI0) <matttbe@kernel.org>

