Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7A152BE02B
	for <mptcp@lists.linux.dev>; Wed, 10 Sep 2025 08:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757494634; cv=none; b=GP/tgpITBUJ5HgyVxdeWgkXNIsqGDT41KIrMeUWN5QM18WEiUvwBSnVHH3DR/b0hBGpmJLqrJeNnl278JZcGuKei7mfiLWW3tJxcx1NqP/4asq8aPBUE1RPKnDZ5sa69SHReNTfYwjQUMGOZQYcnZox+eDYCBqTiuaCzp7Ywmnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757494634; c=relaxed/simple;
	bh=eGvVqn/hZvn/VJdprEJxXpPfUCbq93HDV6WW9B9uRlY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=fGRmiUmGPWDkt/kGgCYtR7dJlHHSYUuso+r6pmlvigIWxwPMTvbuBPIhP46xIs1UCToXzeWBKRv149v8xvwpJA2rHtNH9IjawXc2UMsVeIZcgOCnBqBDo1sAR+J15wvO1pF9q5lZFlV5hotp+dWF23MlcGNsjW2qW2qo37eE5Tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a0IBxuhE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a0IBxuhE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7D5FC4CEF0;
	Wed, 10 Sep 2025 08:57:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757494633;
	bh=eGvVqn/hZvn/VJdprEJxXpPfUCbq93HDV6WW9B9uRlY=;
	h=From:Subject:Date:To:Cc:From;
	b=a0IBxuhEC2YWoYvw2Ht6X0fNRP25kNhedgKQSgn4KLHAOXnNZmWQFznhAMeFK/DjU
	 EExf9+/rsyB7x/0VTaYe3BDMfajf+ZcEzKqHMehdSQYEanlZG3C7VlmaAlmjNO6a4S
	 KcalKnaMbzYl1tOeTqbmAfcN2Q4YraCH6FrzM27kS8skYhFuEvJeUUuXHE0XX4n5nJ
	 RbPR7/MiNkSLn2x1rcF3gn9zBEWc5iSSRekv0wldlfu7zrI3snHbNWpfXbAMrBoJWK
	 fkGKP4rHFVuinVYlRMfCo65obz6OiV7X8FkoXJHKyEGOP7eUbqOIXkK5NW1VEm/9id
	 pnfj4MQw617XA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH mptcp-net v3 0/5] selftests: mptcp: avoid spurious errors
 on TCP disconnect
Date: Wed, 10 Sep 2025 10:55:46 +0200
Message-Id: <20250910-sft-mptcp-disc-err-v3-0-6799fa467d77@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABI9wWgC/23NQQ7CIBAF0KsY1mIoWCiuvIdxUWBoiUobIETT9
 O4SujAmXf7M/28WFCE4iOhyWFCA7KKbfAnseEB67P0A2JmSESW0JR3hONqEX3PSMzYuagwhYMZ
 aoQSXShuFynAOYN27oje0dT0kdC+n0cU0hU99l5ta2ORG7sm5wQRLQ7SlkivdsOsDgofnaQpD9
 TL9GZK0uwYthrGKKa7OfSfEn7Gu6xd2sWAwBAEAAA==
X-Change-ID: 20250806-sft-mptcp-disc-err-3357b769bcdb
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2887; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=eGvVqn/hZvn/VJdprEJxXpPfUCbq93HDV6WW9B9uRlY=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDIO2qYoZ5mrndVpkpxYcT4s2eNXrTVLeOmUhdWZLkn8q
 j2n5+R1lLIwiHExyIopski3RebPfF7FW+LlZwEzh5UJZAgDF6cATCTrBSPDe+M69SWevKG63lNi
 rz1N+NR8X8h1L8+Hv/eXT7Db/2WlGSPDjDzGpTaXGnwblkQcTC95zLpjerjKpQ2CLF21YqvLzv5
 mBAA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

This should fix the recent instabilities seen by MPTCP and NIPA CIs
where the 'mptcp_connect.sh' tests fail regularly when running the
'disconnect' subtests with "plain" TCP sockets, e.g.

  # INFO: disconnect
  # 63 ns1 MPTCP -> ns1 (10.0.1.1:20001      ) MPTCP     (duration   996ms) [ OK ]
  # 64 ns1 MPTCP -> ns1 (10.0.1.1:20002      ) TCP       (duration   851ms) [ OK ]
  # 65 ns1 TCP   -> ns1 (10.0.1.1:20003      ) MPTCP     Unexpected revents: POLLERR/POLLNVAL(19)
  # (duration   896ms) [FAIL] file received by server does not match (in, out):
  # -rw-r--r-- 1 root root 11112852 Aug 19 09:16 /tmp/tmp.hlJe5DoMoq.disconnect
  # Trailing bytes are:
  # /{ga 6@=#.8:-rw------- 1 root root 10085368 Aug 19 09:16 /tmp/tmp.blClunilxx
  # Trailing bytes are:
  # /{ga 6@=#.8:66 ns1 MPTCP -> ns1 (dead:beef:1::1:20004) MPTCP     (duration   987ms) [ OK ]
  # 67 ns1 MPTCP -> ns1 (dead:beef:1::1:20005) TCP       (duration   911ms) [ OK ]
  # 68 ns1 TCP   -> ns1 (dead:beef:1::1:20006) MPTCP     (duration   980ms) [ OK ]
  # [FAIL] Tests of the full disconnection have failed

Patch 3 fixes this issue, but a fix in MPTCP in patch 1 is also needed
to fix MPTCP behaviour, and simplify patch 3. Patches 2 and 4 improve
some errors reported by the selftests, and patch 5 helps with the
debugging. I guess all these patches can be sent to 'net'

Note: Patch 1 will cause errors in Packetdrill, that's normal, see [1].

Link: https://github.com/multipath-tcp/packetdrill/pull/171 [1]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Changes in v3:
- Patch 2: close some FDs in case of errors (Geliang)
- Patch 4: mention there are now more bytes (Geliang)
- Link to v2: https://lore.kernel.org/r/20250905-sft-mptcp-disc-err-v2-0-dfb3b6b4a877@kernel.org

Changes in v2:
- Patch 1: new
- Patch 3: no more state filtering needed thanks to patch 1
- Patch 4: switch from hexdump to od (Mat)
- Patch 5: new
- Link to v1: https://lore.kernel.org/r/20250819-sft-mptcp-disc-err-v1-0-9d0cf296bc13@kernel.org

---
Matthieu Baerts (NGI0) (5):
      mptcp: propagate shutdown to subflows when possible
      selftests: mptcp: connect: catch IO errors on listen side
      selftests: mptcp: avoid spurious errors on TCP disconnect
      selftests: mptcp: print trailing bytes with od
      selftests: mptcp: connect: print pcap suffix

 net/mptcp/protocol.c                               | 16 ++++++++++++++++
 tools/testing/selftests/net/mptcp/mptcp_connect.c  | 11 ++++++-----
 tools/testing/selftests/net/mptcp/mptcp_connect.sh |  6 +++++-
 tools/testing/selftests/net/mptcp/mptcp_lib.sh     |  2 +-
 4 files changed, 28 insertions(+), 7 deletions(-)
---
base-commit: 1e51af26b216c689f6d75872290bb0de1eeaae34
change-id: 20250806-sft-mptcp-disc-err-3357b769bcdb

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>

