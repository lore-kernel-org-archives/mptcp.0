Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1204B192D69
	for <mptcp@lists.linux.dev>; Wed, 21 Aug 2024 11:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724239715; cv=none; b=fG3T98K52ITmjCFAmlhIC+3bkl6Dxr2hxbMucgAzYgjvdhXjbO53T30g71gdVP0s+R5jHi/WPQB1jlXTlQxaY8e/BhTqItVOvA5XBGEu8C5qEYI48fwBH1UuLefqtnPi2I76AjR0bX11QQVUGuRoQUqiVeyxBWBmn9RbcnzZbuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724239715; c=relaxed/simple;
	bh=j0e8kNNr53rqJS3ydt44JTwp+YZHYCXLcPoTeh9ZU0w=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=mZMaHXfdOtJ+Y5yDeo9s8xC1NJCEzWb+KNgKpHX5pF/nzLUZxs03r7HlxGvbSVMWZI3VOnQeJ5UbgB4G8DJyOWD/w9B8zKR7cXalzkWah2sv09So6OaSd5LXoVHMRu2ngUZmDExlhkxX2/HkUxflnhNbSfEWBE/gXGHIWlaos3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UpFTSFpd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UpFTSFpd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F24DCC32782;
	Wed, 21 Aug 2024 11:28:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724239714;
	bh=j0e8kNNr53rqJS3ydt44JTwp+YZHYCXLcPoTeh9ZU0w=;
	h=From:Subject:Date:To:Cc:From;
	b=UpFTSFpdmZ9/w9SjxbZXTWCgx7VRbw6BPwugEXyNZspPQNoWuLdjcU2SZ2JtKn5fd
	 0wOcjKpdzI3IGS9KH2lQC2kWMUKvW6ohilOyzvyPMcHuEd+swY6nQxYqcoAowCx5R9
	 w7gyBbzzXbv82uBYkvF808sAs2Uuw0WpW5CEajcrCLsoetlh5Sopi0qTWEBuUq0ipu
	 JiSxm8zB5qrPuiTTsFMByrCaKhyCycfFemWuAiNAgcfXE2Q94cFuVTEc3wdbuGDWIU
	 SpcZjiwD1B1fIfE7cvSCUIOcNROFNo4KxZZtsQfQ/to13tJjhY8bKbKHHGK+uenI6B
	 mDlY3gSTU882w==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH mptcp-next 0/3] selftests: mptcp: add time per subtests in
 TAP output
Date: Wed, 21 Aug 2024 13:28:29 +0200
Message-Id: <20240821-mptcp-ksft-time-v1-0-c4ea94f41244@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAF3PxWYC/yWMQQqAIBAAvxJ7bsHEQ/WV6FC61hKaqEQg/T2p4
 8DMFEgUmRKMTYFIFyc+fYWubUDvi98I2VQGKaQSvezQhawDHslmzOwIzaoGaRVpZRaoVYhk+f6
 OE/yypzvD/DwvaOaRvm0AAAA=
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1220; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=j0e8kNNr53rqJS3ydt44JTwp+YZHYCXLcPoTeh9ZU0w=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmxc9h2h8rv4+UWMmpy91EiJQF5S6gYzfxJKjpk
 Zs5939WtMiJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZsXPYQAKCRD2t4JPQmmg
 cwAfD/43t6SgKjMobSG4hsaZhYdzSulA6Sy1gBL6eFAPJ9YQQVdu/mh6qXrNiWcd/5Ijhs+jRZ3
 3ond0+rcRoTlyxK6osh2/KJojpZk2NgETiX9or2gEVwfT5nB/VfULV7VS7YYHTtzGXpNQ1O8S0p
 U9rOGknRMGoaTYDcnmtnvW8L1im+BTehOKqUflvBYuZvXfKdsem+eXRszPNU8dnjBEBNaTsCy6n
 YnIul6HWfgHUkwu6QQX82cjd+bRvNFdqnD9DKg59pNPL2c6pHKA2Na6R92EC9bhmnQh1KsiTUlM
 W7Zr2LgI/r/O7dqKp24qDj2DCRZ+XYvRsPsVMHonCYOhkUjif86i8aZE/ahtBMHe5IILZlzqRgg
 l51e5cwVDUMKGkR+Vx5T3zbs9pGnexXyBGWk40MB5daXr5usuRrMGIx1SIgfyg+nbUa57o4y8Ga
 M09gWskh9CMlFeVpd7yYN0oxDudlYbPDzPJS8S0rMjjHfkieRdBDtGDZvLZMZMoiMBBt9QGry9E
 ynHroF5kEjLbuve7ryY5iqDyA1Yesh339AE62je69W+TTCnCFxvKdyBeEkSCMIrDb3b4VsjN36G
 N8jMo/nNYewjF9VeL9ClUFLoN6n4PszfdsfR6KBHYjvgPuUtSICQg33oLQH4PnRN28nXxd4U9zu
 HzbDIRXimLHRt7Q==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Patches here add 'time=<N>ms' in the diagnostic data of the TAP output,
e.g.

  ok 1 - pm_netlink: defaults addr list # time=9ms

This addition is useful to quickly identify which subtests are taking a
longer time than the others, or more than expected.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Matthieu Baerts (NGI0) (3):
      selftests: mptcp: lib: add time per subtests in TAP output
      sefltests: mptcp: connect: remote time in TAP output
      selftests: mptcp: reset the last TS before the first test

 tools/testing/selftests/net/mptcp/mptcp_connect.sh |  3 ++-
 tools/testing/selftests/net/mptcp/mptcp_join.sh    |  3 ++-
 tools/testing/selftests/net/mptcp/mptcp_lib.sh     | 17 ++++++++++++++++-
 tools/testing/selftests/net/mptcp/mptcp_sockopt.sh |  1 +
 tools/testing/selftests/net/mptcp/pm_netlink.sh    |  2 ++
 tools/testing/selftests/net/mptcp/simult_flows.sh  |  1 +
 tools/testing/selftests/net/mptcp/userspace_pm.sh  |  1 +
 7 files changed, 25 insertions(+), 3 deletions(-)
---
base-commit: 624d90dc5dcaee846a57aa0985789623f7c64f2e
change-id: 20240821-mptcp-ksft-time-db492f4ec4da

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>

