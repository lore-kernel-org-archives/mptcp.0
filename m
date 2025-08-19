Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBAEE3090CF
	for <mptcp@lists.linux.dev>; Tue, 19 Aug 2025 18:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755626736; cv=none; b=fU1dR18gfQRCYdh4R+Tg4wMXpWxBngaeHcfTjpPABjKMmJ5z5kq6SKQG1mCTaiSK5xx1dDF6CDUgmGSF4CRNOzNNydebLv/kPF1Nq/3wZNDqkGoQ1baP7eqHpICW3RN8E+T2JlnkqYgW4/yck+WfSwlKz4mY2m05PQiCAVZ1c9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755626736; c=relaxed/simple;
	bh=U9Sr+ab6q3g2ZlOzf4DvpiG525E/DPwsPPaAdBUl+yw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To; b=IMK9dcvDPPhkBT4vz4hHErlLpUXVqQEUgwN8kfClUCU2AZbhmKhUWc85cEBfdmIhfS2wlzABIHCSX2fCWbnNeiA5rUaNpvIxQWFuVYUfoKhGnRHQ+pfCbSz2YFEGn0GNqofkzlNYbLi036g5CQL+PSA1xIaZKpONTOiSipubc1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JkI5sfNE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JkI5sfNE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A2A6C4CEF1
	for <mptcp@lists.linux.dev>; Tue, 19 Aug 2025 18:05:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755626735;
	bh=U9Sr+ab6q3g2ZlOzf4DvpiG525E/DPwsPPaAdBUl+yw=;
	h=From:Subject:Date:To:From;
	b=JkI5sfNEwQezmcOnJOGsT8CoCNwgXtz7GzYpsM3DN/Pbd3X8Rl5tXeOPaxWglpRNJ
	 836EOz5a5rwo1jIDCdn3sW5TMfggu15x9PFKYVVfE80rnFnmok3gZHnGZMT5G/wKQl
	 NzSb0W7X+gwFmkN8g9C8IKqV/TxtiGxc90iznQJ5mfBBOrTXw8PId+o5x7iajomiZt
	 Vq51rApzWDjgbS5so2A8bMxUQaqumdKs2SHtADXoTpFNg1TDwQKQc0KxdTBOXpU7wE
	 RySOEP5JLi7DbGIfQzFdLfX6bAGHLXR+/J/aQPxVB0FZuETn3MQ0Ks6l8JuDrdhu4T
	 uCbFlBUzU+jIg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH mptcp-net 0/3] selftests: mptcp: avoid spurious errors on
 TCP disconnect
Date: Tue, 19 Aug 2025 20:05:20 +0200
Message-Id: <20250819-sft-mptcp-disc-err-v1-0-9d0cf296bc13@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOC8pGgC/yWMywqEMAwAf0VyNlAVn78iHrZt1BysJSkiiP++Z
 fc4MDMPKAmTwlQ8IHSx8hkyVGUBbv+EjZB9ZqhN3ZrBdKhrwiMmF9GzOiQRbJq2t303Wuct5DA
 KrXz/pjP83UAJlvf9AtUw2KlvAAAA
X-Change-ID: 20250806-sft-mptcp-disc-err-3357b769bcdb
To: mptcp@lists.linux.dev
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1849; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=U9Sr+ab6q3g2ZlOzf4DvpiG525E/DPwsPPaAdBUl+yw=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDKW7HkV8P3agtU6WsLPBBkeJIdI3cw0ZmWbZvyYhVeKZ
 7EeW3FERykLgxgXg6yYIot0W2T+zOdVvCVefhYwc1iZQIYwcHEKwEQ+VTMyfH5r96w64X+5/xHL
 H2ukq2LPlc/Y0usjZOnOVX1pXkfkYYY//HqzWpYulGRmjTumYlMl+qzLouKZgtga5f1rf19fXhD
 PDQA=
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

Patch 2 fixes this issue, while Patch 1 and 3 improves the errors
reported by the selftest.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Matthieu Baerts (NGI0) (3):
      selftests: mptcp: connect: catch IO errors on listen side
      selftests: mptcp: avoid spurious errors on TCP disconnect
      selftests: mptcp: print trailing bytes with hexdump

 tools/testing/selftests/net/mptcp/mptcp_connect.c | 10 +++++++---
 tools/testing/selftests/net/mptcp/mptcp_lib.sh    | 12 +++++++++++-
 2 files changed, 18 insertions(+), 4 deletions(-)
---
base-commit: 27427f653031e9aca497b147b2d8eb86bf12fb9e
change-id: 20250806-sft-mptcp-disc-err-3357b769bcdb

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>

