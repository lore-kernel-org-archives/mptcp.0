Received: from mta1.migadu.com (out-11.mta1.migadu.com [95.215.58.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCA003ACEE0
	for <mptcp@lists.linux.dev>; Tue,  8 Sep 2026 11:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788867388; cv=none; b=rXDNiErY+HJiHJkPo36lQc8fVbH9prF/we/cveBtCYlmzKB515dnlq/xp/7PTD1VMlAVKiNzP9kkuoOhNh3LgLVpPxfhV408t3DqxhR3ncDVsdNvtYL04EDmbNAupa38ja+fL7Khs+Q4pIpmIcya35ShKChOWbv465YDj8CGJeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788867388; c=relaxed/simple;
	bh=H+4of2Cy0YQSOCkrGt39Pr78SBYDhaeOR4kUleLW/dE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=G7/VGvV3D/1pbm1khV8Xw8ggLmJdh5SUqtqSGVaKAAPHNj86ShKIgOywDKkZbkDfxiZTHjOKoIO9m/R3Dq0dx5nGzbWAL2wCRgpsDmcDAPT+RWuGTO5rriib/u8X4EBLg8/OO+daI1XiHB8m+nJabPuiQWjO3O1342Q/XnSdE44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pOV7TT5m; arc=none smtp.client-ip=95.215.58.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pOV7TT5m"
X-Envelope-To: mptcp@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=H+4of2Cy0YQSOCkrGt39Pr78SBYDhaeOR4kUleLW/dE=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788867376; v=1; x=1789472176;
 b=pOV7TT5mSBnhD/ZyyCCpV2o0cc7TCy2s+v6T1FuBMsI35FpygCR4rvs+4JRsls/1CPCNpDVN
 RKpiyex2BjYijOxzaQC775ZHiIY3qTj9jTihV+UM5C7CVCSllXKpvJvEpxXPJdCfktDlxh9Qzv0
 UdvdHwg5qWH1XhA4SCLKL7Ho=
X-Envelope-To: mptcp@lists.linux.dev
Received: by smtp.migadu.com with ESMTPS id ed65064c7e757b84;
	Tue, 08 Sep 2026 11:36:16 +0000
X-Mizu-Trace-ID: ed65064c7e757b84
X-Migadu-Flow: FLOW_OUT
From: Hangbin Liu <hangbin.liu@linux.dev>
Subject: [PATCH mptcp-next v4 0/2] selftests: mptcp: convert iptables to
 nftables
Date: Tue, 08 Sep 2026 19:36:08 +0800
Message-Id: <20260908-mptcp_nft-v4-0-af0a6120240b@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/23N0Q6CIBQG4FdxXEfDA5p01Xu01gAPySp04JzO+
 e4xrmx1+e/8339WEjE4jORcrCTg5KLrfQriUBDTKf9A6tqUCTComWRA38Nohru3I9WNhFMDaCV
 IkvpDQOvmvHUluUY9ziO5pVvn4tiHJb+Zytz4sziVlNGqkkapsraiZJfn8nK+j0fj88wEe8r3F
 BKta2g4Ci0N1z+U76nYU56oUBpbZRnTVn7Rbds+ZrdHCSUBAAA=
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

With nft init on each init_partial (Patch v2 version)
real    43m37.393s
user    0m29.183s
sys     32m15.354s

With nft init only called needed (Patch v3 version)
real    37m6.645s
user    0m25.325s
sys     27m10.385s

We only increase 1m22s compared with iptables.

Signed-off-by: Hangbin Liu <liuhangbin@kylinos.cn>
---
Changes in v4:
- fix add table typo in init_nftables() (sashiko)
- Flush the nft table(which is safe) instead of using global nft_handle (Matthieu Baerts)
- Link to v3: https://lore.kernel.org/r/20260904-mptcp_nft-v3-0-4abedaf00bf9@kylinos.cn

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
 tools/testing/selftests/net/mptcp/mptcp_join.sh    | 149 ++++++++-------------
 tools/testing/selftests/net/mptcp/mptcp_lib.sh     |   2 +-
 tools/testing/selftests/net/mptcp/mptcp_sockopt.sh |  64 +++++----
 4 files changed, 98 insertions(+), 121 deletions(-)
---
base-commit: a5ccf9a640b87f84558f35b17b02747380128513
change-id: 20260902-mptcp_nft-b892782ef929

Best regards,
-- 
Hangbin Liu <liuhangbin@kylinos.cn>

