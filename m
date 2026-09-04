Received: from mta1.migadu.com (out-69.mta1.migadu.com [95.215.58.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F95B3A48F7
	for <mptcp@lists.linux.dev>; Fri,  4 Sep 2026 07:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788507105; cv=none; b=NawSoH+w9RtEwJEwT5BrOMqS4/a3t1thAbzOMhkQ2ayNZ9nI+j9iT8urQqM8rFC10p4Ha/LXwapLXMmtWLgGXMwBKfVx9YUQWWdzg9x8P2kvZP2IIJYKDwtsW1afz9rCd9p/IAwh13PJG8QO+xDwmhUDu2ii7X9Ze82sIutu0BM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788507105; c=relaxed/simple;
	bh=T7bBbnQAu5RBMN1O5b81ybKVK9obut3luOrD0T77f18=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ZvJlXLEQTvBt/xFp5An9/fBvpMw3IxWbrrXsUJpKFFAXzZBSvgbCD1CwB/fPXzDrUeTVUM3DEu3PeCwqcxgneTZS6Zbki8XI6qekwz5bslfJxAlemcl2EZT35LoG7J/tANNtt+/ifMAYzgw2QyWtr3bjcf1AdL4xQpnj2qU73x0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Bbv/m5Me; arc=none smtp.client-ip=95.215.58.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Bbv/m5Me"
X-Envelope-To: mptcp@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=T7bBbnQAu5RBMN1O5b81ybKVK9obut3luOrD0T77f18=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788507101; v=1; x=1789111901;
 b=Bbv/m5MeX+tiuBI6FfXLtM3lqi+Pd5Pud+is15Qkg5YwaBKP4qL5Vm5EnedPtKbeQIc1XDi3
 jWWCSdvy8IidyHTcIUMZKvLqtKnDUk9anUCWyUKR+mOxv341imAgK9YnvqqyTDD8ID3R99Zm0MI
 GPqKLkz6k+PLKrXabWAO6Nok=
X-Envelope-To: mptcp@lists.linux.dev
Received: by smtp.migadu.com with ESMTPS id 59580b8a16b848ca;
	Fri, 04 Sep 2026 07:31:41 +0000
X-Mizu-Trace-ID: 59580b8a16b848ca
X-Migadu-Flow: FLOW_OUT
From: Hangbin Liu <hangbin.liu@linux.dev>
Subject: [PATCH mptcp-next v3 0/2] selftests: mptcp: convert iptables to
 nftables
Date: Fri, 04 Sep 2026 15:31:16 +0800
Message-Id: <20260904-mptcp_nft-v3-0-4abedaf00bf9@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/22NQQ7CIBBFr9LMWgwMLRZX3sMY0yJYotIGCGnT9
 O4SVjVx+TPvvVkhaG91gHO1gtfJBju6PPihAjV07qmJfeQNSFFQSZF8pqimuzOR9K3EU4vaSJS
 Q+clrY+fSukLBiNNzhFu+DTbE0S/lTWKF+FNMjFDSNFJ1HROmZvTyWt7WjeGoXMkk3Kt8r2JWh
 cCW67qXivc/6rZtXwA1BjXqAAAA
X-Change-ID: 20260902-mptcp_nft-b892782ef929
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: Hangbin Liu <liuhangbin@kylinos.cn>, 
 Hangbin Liu <hangbin.liu@linux.dev>
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

For mptcp_join.sh, I add an init_nftables() function so we can only init
nftables when needed. With debug kernel on my 4 cpu vm, Here is the
total running time of mptcp_join.sh.

With iptables

real    35m44.460s
user    0m22.455s
sys     25m17.923s

With nft init on each init_partial (Last patch version)
real    43m37.393s
user    0m29.183s
sys     32m15.354s

With nft init only called needed (This patch version)
real    37m6.645s
user    0m25.325s
sys     27m10.385s

We only increase 1m22s compared with iptables.

Signed-off-by: Hangbin Liu <liuhangbin@kylinos.cn>
---
Changes in v3:
- Use jq to get the nft handle and drop count (Matthieu Baerts)
- Remove iptables/ip6tables and CONFIG_NFT_COMPAT since no one use it
  after the conversion. (Matthieu Baerts)
- Add init_nftables() so we can only init the nf tables when needed (Matthieu Baerts)
- Bundle the nft init steps so we only need to call the nft binary once (Florian Westphal)
- Only get the nft_handle when needed and reset it before using (Matthieu Baerts)
- Link to v2: https://lore.kernel.org/r/20260903-mptcp_nft-v2-0-66283e4b9c3b@kylinos.cn

Changes in v2:
- Fix --sync and --tcp-flags RST convert not match issue (sashiko)
- make sure drop is a number in check_mark. (sashiko)
- Other than using one inet table, use ip/ip6 tables to retain the same
  table and chain names used by the original iptables/ip6tables setup.
- Link to v1: https://lore.kernel.org/r/20260902-mptcp_nft-v1-0-559caa16f410@kylinos.cn

---
Hangbin Liu (2):
      selftests: mptcp: convert iptables to nftables for mptcp_sockopt.sh
      selftests: mptcp: convert iptables to nftables for mptcp_join.sh

 tools/testing/selftests/net/mptcp/config           |   4 +-
 tools/testing/selftests/net/mptcp/mptcp_join.sh    | 158 +++++++++------------
 tools/testing/selftests/net/mptcp/mptcp_lib.sh     |   2 +-
 tools/testing/selftests/net/mptcp/mptcp_sockopt.sh |  64 +++++----
 4 files changed, 107 insertions(+), 121 deletions(-)
---
base-commit: e9b3407fa4686e58a862f6889b18a4f422199261
change-id: 20260902-mptcp_nft-b892782ef929

Best regards,
-- 
Hangbin Liu <liuhangbin@kylinos.cn>

