Received: from mta0.migadu.com (out-71.mta0.migadu.com [91.218.175.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09AFC3A8FE6
	for <mptcp@lists.linux.dev>; Wed,  2 Sep 2026 06:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788331996; cv=none; b=p5rc/Xgym+B85pS3gzVb7T9itr6vvr7uKKwOtpNRh8d9XtV9NNYHp7RWX+ut3RRJNjZ3kg03teZ2WMlUZoWODi2PyiB0H2QHc+vdxJmmgNwDnVERbXFoGXeNdNKhXEUKyFNTiU4YclL/It9K9UTi19tACNUAZDvznxK7z+8CWmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788331996; c=relaxed/simple;
	bh=dySyQAn0DDi/OmRXW6V7xLYbRbFjNAUAITo75E6DfYs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Vs5Lt4vaSwyHLNeuJOhBFc+vcstcEBdFeDCVVsJvFUIoxK6psGU6WhoV0YNBNYeOFzROCbN8EKbIxNT7s2ezrrawNd1ljprA8xg1eLtlFzAcvfagRUruNDz/dzFy74TdKtFeDgPfbSjh9ZiMInj/4OzBHqtiK9q/b5vZCGmkDVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gFoN28ga; arc=none smtp.client-ip=91.218.175.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gFoN28ga"
X-Envelope-To: mptcp@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=dySyQAn0DDi/OmRXW6V7xLYbRbFjNAUAITo75E6DfYs=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788331974; v=1; x=1788936774;
 b=gFoN28gar3N0i+QaLQGlFi0uYdXMTdWLjpTpSFOc3fYQTSYM/ESq8jmgv3sBT5TCd7k/qBw9
 m51zegGGf8aPRuDIU2ME8WdjfFTKBvQ5tRwPC8Hlw8qimcZy1PFjH7Jk2l04WPXPy8R8hxASTEX
 pQzkYltvDhtpNBKu19Ev2bNM=
X-Envelope-To: mptcp@lists.linux.dev
Received: by smtp.migadu.com with ESMTPS id 512cd5bb4ec76f49;
	Wed, 02 Sep 2026 06:52:54 +0000
X-Mizu-Trace-ID: 512cd5bb4ec76f49
X-Migadu-Flow: FLOW_OUT
From: Hangbin Liu <hangbin.liu@linux.dev>
Subject: [PATCH mptcp-next 0/2] selftests: mptcp: convert iptables to
 nftables
Date: Wed, 02 Sep 2026 14:52:34 +0800
Message-Id: <20260902-mptcp_nft-v1-0-559caa16f410@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MTQqAIBBA4avErBNsFtV0lYjoZ6xZZKISgnT3p
 OWDj5chsBcOMFQZPD8S5LYlmrqC7VzswUr20oAaW00a1eXi5mZrolp7wq5HNoQExTvPRtL/GuF
 nynKKML3vB25ENvBnAAAA
X-Change-ID: 20260902-mptcp_nft-b892782ef929
To: MPTCP Linux <mptcp@lists.linux.dev>, 
 Matthieu Baerts <matttbe@kernel.org>, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Shuah Khan <shuah@kernel.org>
Cc: Hangbin Liu <hangbin.liu@linux.dev>, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, Hangbin Liu <liuhangbin@kylinos.cn>
X-Mailer: b4 0.14.3

iptables has been deprecated for years. The Linux kernel has included
nftables as the successor to iptables since 2014, and every major
distribution uses nftables as the default packet filtering framework.
The iptables command we run on modern systems is actually iptables‑nft,
a compatibility layer that translates iptables syntax to nftables rules
behind the scenes.

There are also some features that can be set easily with nft, while we need
to convert to BPF code under iptables, such as MPTCP add‑addr and
remove‑addr suboptions. To make future work easier, convert iptables usage
in mptcp to nftables.

Signed-off-by: Hangbin Liu <liuhangbin@kylinos.cn>
---
Hangbin Liu (2):
      selftests: mptcp: convert iptables to nftables for mptcp_sockopt.sh
      selftests: mptcp: convert iptables to nftables for mptcp_join.sh

 tools/testing/selftests/net/mptcp/config           |   3 +
 tools/testing/selftests/net/mptcp/mptcp_join.sh    | 136 ++++++++-------------
 tools/testing/selftests/net/mptcp/mptcp_lib.sh     |   2 +-
 tools/testing/selftests/net/mptcp/mptcp_sockopt.sh |  56 ++++-----
 4 files changed, 77 insertions(+), 120 deletions(-)
---
base-commit: 8dd2802091fbba563abec55e0455d0e5273c7529
change-id: 20260902-mptcp_nft-b892782ef929

Best regards,
-- 
Hangbin Liu <liuhangbin@kylinos.cn>

