Received: from mta0.migadu.com (out-201.mta0.migadu.com [91.218.175.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57EAC3B05B8
	for <mptcp@lists.linux.dev>; Wed, 12 Aug 2026 10:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786529185; cv=none; b=K3eldHC8P66XOlaYEQfBCNZ8TSWfLLpwC/8RxKi48ZOmL7VgEgZ8z9PnIRHsDL3hoSQKMHJY7stJjS4xRapsBIq/kvMRLGRQvLnMf8ZewTsRq0o6THjDhfky24F6AJr0hHfUlA688KqQkfisftbnINnxxcFa1awiWvht7PX/97Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786529185; c=relaxed/simple;
	bh=/Z8OfNrgjOA2C0xFZuY2aXKDCQQgpuCSHr9HA2p6D54=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PudZE/1bATzsgnvcOkBd5n7RqmnzkF6+ehr1Tbm91P0OwuLTKVC1HQhkp7RMwpanCuTaqViGzzghXaOdyJJksii0kd0hais7KvQnettvTaD4P1q8ovdcgkmPhJ+86NKdjmuDWUjgy2h8uPsJqkfWHa5I4rSwQHfZaZ+hC8FDZP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=TV0AIPLe; arc=none smtp.client-ip=91.218.175.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="TV0AIPLe"
X-Envelope-To: mptcp@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=/Z8OfNrgjOA2C0xFZuY2aXKDCQQgpuCSHr9HA2p6D54=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786529182; v=1; x=1787133982;
 b=TV0AIPLe72wEw1h0VPIfek3r9uIm7a0JLqo9qoIY/+9UucgdHiykWPDWEn0o11QMvsSNpk2v
 r5YzxQ6plfjSipks80N3tB90+cA5HwGU63aZoavFqaiBpA9M8UWF1S5f1sFjI7vaTsOrym3VWGk
 5quu3tc//+D/iQ0v3OogkfCw=
X-Envelope-To: mptcp@lists.linux.dev
Received: from thinkbook16p.. (120.244.49.214)
	by smtp.migadu.com with ESMTPS id 20317544af29f70b;
	Wed, 12 Aug 2026 10:06:22 +0000
X-Migadu-Scanner: mta10.migadu.com
Authentication-Results: mta10.migadu.com;
	none
From: Gang Yan <gang.yan@linux.dev>
To: mptcp@lists.linux.dev
Cc: Gang Yan <yangang@kylinos.cn>
Subject: [PATCH mptcp-next 0/2] mptcp: MIB counter for invalid option
Date: Wed, 12 Aug 2026 18:05:48 +0800
Message-ID: <20260812100550.148670-1-gang.yan@linux.dev>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Gang Yan <yangang@kylinos.cn>

This series is designed for [1].

Patch 1 passes the 'net' to options parser, I used to use
dev_net(skb->dev) for MIB counters, but the AI reported it is not
suitable for this. This patch has no functional change.

Patch 2 adds the InvalidOptionRx counter, and increments it when
receive the invalid options.

The packetdill testcase is submitted, and can be reviewed in [2].

[1] https://github.com/multipath-tcp/mptcp_net-next/issues/628
[2] https://github.com/multipath-tcp/packetdrill/pull/205
Gang Yan (2):
  mptcp: pass net namespace to options parser
  mptcp: add MIB counter for received invalid options

 net/mptcp/mib.c      |   1 +
 net/mptcp/mib.h      |   1 +
 net/mptcp/options.c  | 107 +++++++++++++++++++++++++++++++------------
 net/mptcp/protocol.h |   2 +-
 net/mptcp/subflow.c  |  10 ++--
 5 files changed, 85 insertions(+), 36 deletions(-)

-- 
2.43.0

