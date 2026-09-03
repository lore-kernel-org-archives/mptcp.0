Received: from mta1.migadu.com (out-212.mta1.migadu.com [95.215.58.212])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D5FD2F8E87
	for <mptcp@lists.linux.dev>; Thu,  3 Sep 2026 01:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788397961; cv=none; b=cFxiqlG4hZjmAxzxo2pnAcmBdm6PDYYrsRbF8eJYPgOOICLtpJhml5k5xYztUwrMZbwVKf9DEkUn/oN3tfLL9J5Wr+vd3NJpl04Z1UAXlF/H7S8wwxpyOHkFVDBrn23uCzdCt1VkYnN4xpaf7FYvAVmps3P+GssViBmYhWPCo/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788397961; c=relaxed/simple;
	bh=rcSvnwdgysIYaZNX3OhjT56/9EbUy6eEYgqPG+yJFKE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=eAvoxDBJZ3Y1UVOBU1u3e39xoQ1Aju4+2i+b5OFxuenHnKHGHjcxIhHZ6kHgbU6ZXH82devcqm4X7rRfy6Y6Hx+cTQzbkXxpmeTcQBYul41xopestRUY2VFAxSkWuKmHdakJIf/wseioKfjp1WvTZaIM/YLsetDgJryXTncrAhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JweijNVR; arc=none smtp.client-ip=95.215.58.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JweijNVR"
X-Envelope-To: mptcp@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=rcSvnwdgysIYaZNX3OhjT56/9EbUy6eEYgqPG+yJFKE=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788397956; v=1; x=1789002756;
 b=JweijNVRuyEapt4j5eJ2uuolPk4CyoFEHSRQEQFf0mN2ACiRAR7dxSRFDvhwQ3+0NpsmRUlR
 C5/K9Op4Q/r4YLW5xG5R/xId0qmoe2xQMuTOJhsUNpP/Lexq22bTBh1CbMSgrfwJiWTN9A1s7/V
 FZg46uoqBP27o/vZW5EyF1lI=
X-Envelope-To: mptcp@lists.linux.dev
Received: by smtp.migadu.com with ESMTPS id 729514d5e02325d1;
	Thu, 03 Sep 2026 01:12:36 +0000
X-Mizu-Trace-ID: 729514d5e02325d1
X-Migadu-Flow: FLOW_OUT
From: Hangbin Liu <hangbin.liu@linux.dev>
Subject: [PATCH mptcp-next v2 0/2] selftests: mptcp: convert iptables to
 nftables
Date: Thu, 03 Sep 2026 09:12:19 +0800
Message-Id: <20260903-mptcp_nft-v2-0-66283e4b9c3b@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/22NQQrCMBBFr1JmbSQZbG1ceQ8pEuPEDmpakhBaS
 u9uyNrl4z/e3yBSYIpwaTYIlDny5AvgoQE7Gv8iwc/CgBI7qSWK75zsfPcuiUev8dwjOY0aij8
 HcrzU1g2qJjwtCYayjRzTFNZ6k1U1/hSzElK0rbbGqM6dlLy+1w/7KR6th2Hf9x+GHWVXrwAAA
 A==
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

Tested with iptables-translate to make sure each nft conversion is the same
with previous one. e.g. for mptcp_sockopt.sh, the ip6tables shows

bash-5.3# ip6tables -L
Chain INPUT (policy ACCEPT)
target     prot opt source               destination

Chain FORWARD (policy ACCEPT)
target     prot opt source               destination

Chain OUTPUT (policy ACCEPT)
target     prot opt source               destination
ACCEPT     tcp  --  anywhere             anywhere             tcp flags:FIN,SYN,RST,ACK/SYN mark match 0x1
ACCEPT     tcp  --  anywhere             anywhere             tcp flags:RST/RST mark match 0x0
ACCEPT     tcp  --  anywhere             anywhere             mark match 0x1
DROP       tcp  --  anywhere             anywhere             mark match 0x0

And the backend nft shows like

bash-5.3# nft list tables
table ip6 filter
bash-5.3# nft list table ip6 filter
table ip6 filter {
        chain OUTPUT {
                type filter hook output priority filter; policy accept;
                tcp flags & (fin | syn | rst | ack) == syn meta mark 0x00000001 counter packets 0 bytes 0 accept
                tcp flags & rst == rst meta mark 0x00000000 counter packets 0 bytes 0 accept
                meta l4proto tcp meta mark 0x00000001 counter packets 0 bytes 0 accept
                meta l4proto tcp meta mark 0x00000000 counter packets 0 bytes 0 drop
        }
}

Which matches what we change in the script, except the counter.

Signed-off-by: Hangbin Liu <liuhangbin@kylinos.cn>
---
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

 tools/testing/selftests/net/mptcp/config           |   3 +
 tools/testing/selftests/net/mptcp/mptcp_join.sh    | 142 ++++++++-------------
 tools/testing/selftests/net/mptcp/mptcp_lib.sh     |   2 +-
 tools/testing/selftests/net/mptcp/mptcp_sockopt.sh |  51 ++++----
 4 files changed, 84 insertions(+), 114 deletions(-)
---
base-commit: 8dd2802091fbba563abec55e0455d0e5273c7529
change-id: 20260902-mptcp_nft-b892782ef929

Best regards,
-- 
Hangbin Liu <liuhangbin@kylinos.cn>

