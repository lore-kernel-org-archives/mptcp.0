Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 248C283CA1
	for <mptcp@lists.linux.dev>; Fri, 19 Jul 2024 12:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721391874; cv=none; b=iRafgpAxx1pJEVM8s9QZSxzhiLClNMhF3OiUWkzpCkhfZmg5wOuU5Nzf5+9h33yFpXdRokIRYPOfO10a0JCXFWX4HksciX7qA4Yzb6YFeOAyAchtBBNjWFNC0VlxMp4oa7LG71CpYeKblvPlBBed6QvLQtjQhlC3DGhD12vHoo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721391874; c=relaxed/simple;
	bh=3vXWKEIkOhwgs0TzDVzbbf3yXKvQOagLM26iwHvS9+k=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=BCrOWn5FeyPFDsEWOQghn/jqNeCmc/UbFGtXa8REkeAUr27ciytVvLEprPhBhaBnZ7NJpJBPfiFEz6dsIgRyTbGQnhJy31iqTZfGpwb4CNY9+eU3xkEjaVECGA/oXmWPdFCW+vrZlzDPkKWRJWpzwwjNzH4NHd0tmc3kN27uAL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KypFl6nB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KypFl6nB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF8D8C32782;
	Fri, 19 Jul 2024 12:24:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721391873;
	bh=3vXWKEIkOhwgs0TzDVzbbf3yXKvQOagLM26iwHvS9+k=;
	h=From:Subject:Date:To:Cc:From;
	b=KypFl6nBjaEGXhKU0/SH+6e0eNdspY2G1Paym5FxWoVSzRSCVSctMlO+XRzs6wYbW
	 2VbWkzy/V/+rp7SGrbk/ZWk/zmOyGpg9vUJ3+gr8Vb1k6iWb3tjF0x4fzIUq+EmrWM
	 lR0FEexCWBvf6M0Kw5sUPGl9hOYt5REGvxgmg/CpsiIoG9aoYEZfBjGW/JNLbz9SXx
	 qjUP8vzVRCzJtlLxxEXGGuMDFg8lImswCrXL52mJzIgC/CgXQuIYOegWx95GObys/5
	 LipWXzE/xTOEqJyMM0azYV09rQ4910kk/rzhOUG8O1l6ciCeZBvESHbdBKrSsBf4aY
	 c4Z70RQuchhkQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH mptcp-net v3 00/20] mptcp: fix endpoints with 'signal' and
 'subflow' flags
Date: Fri, 19 Jul 2024 14:24:11 +0200
Message-Id: <20240719-mptcp-pm-avail-v3-0-e96b5591ced3@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOtammYC/2WNQQ6CMBREr0L+2pq2UBBW3sO4oPALjVCaljQaw
 t1tqolRl5OZ92YDj06jhybbwGHQXi8mhvyQQTe2ZkCi+5iBU17QklMy27WzxM6kDa2eiBKY16K
 SWBQMImQdKn1Pwgu8tgZXuMZq1H5d3CNdBZYGbyv7tQZGKJFlzXuB8lRLcb6hMzgdFzckV+Afv
 mLij+eRV51gIpc9UyV+8fu+PwEm87IO+AAAAA==
To: mptcp@lists.linux.dev
Cc: Paolo Abeni <pabeni@redhat.com>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4335; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=3vXWKEIkOhwgs0TzDVzbbf3yXKvQOagLM26iwHvS9+k=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmmlr/XNIfpDSDSzMID8WBGuDszhLbSLE9A7uCT
 Z8iRKKAtQGJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZppa/wAKCRD2t4JPQmmg
 c/ZTD/0QL3AxX6VRlaaXcnsVoXI/UkU4QN5rOGXhraBNvWuWnZNFFMTl31l5A8zh5INpBm44OW6
 eHGvS74yHirvCKKrIkrDZdldWPa8MP+KANbsQK/Msy3cyh+paDNMKYtwhBG3+6Pp64+l/mAzHtX
 JtoHZsHQQwdSlVMglidV/2q9BLUGEqHnjl/hdvdw4Tr0umsplRHI5ltYHNJQpmQv8y0Yu2u+BWc
 b7umJJYY/+4j/xp+wlO374fGGSm4mQGFuvhb8GZ3G40+8DMyMIldHlz9RZUglpYrbZU6t6ojWXr
 N68Ry+HuH8rABvBvsgOyyDymI8xo3ApoQOm+0NfQQoA+dW4m3kMyqNQ9wOMXKKi9n89kthNrPnc
 229cUqgECEQ5barzFbig01NxnWUGL1TTzbTZ7F9J727lyjJZI2+31qTVf7basW3m9PvDy+Ob1fU
 0jzdyReDj1IcrrOW/nGuvk/j/ytaiE6AECvkKrVkymO2YJDZ9N/8kZuuUCrCsfU9GQ3+gKthWnq
 7kAop684WvtYNJ+bn1rby6zH0iHNCt8BnWvXktqIwuWh3bmCBO4PWdsAQyBPOmB0hGP4H9LTZAh
 5vzfuppZH8F30xepCp7vCThS5bLu+3jIUUA87snKAkMyE8rNq9prGJ0xR/2mnxh1FAaLcBTNq3X
 UbOboxbbM8Yzf1A==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

When looking at improving the user experience around the MPTCP endpoints
setup, I noticed that setting an endpoint with both the 'signal' and the
'subflow' flags -- as it has been done in the past by users according to
bug reports we got -- were resulting on only announcing the endpoint,
but not using it to create subflows: the 'subflow' flag was then
ignored.

My initial thought was to modify IPRoute2 to warn the user when the two
flags were set, but it doesn't sound normal to ignore one of them. I
then looked at modifying the kernel not to allow having the two flags
set, but when discussing about that with Mat, we thought it was maybe
not ideal to do that, as there might be use-cases, we might break some
configs, and it was working before apparently. So instead, I fixed the
support on the kernel side (patch 5) using Paolo's suggestion. This also
includes a fix on the options side (patch 1), an explicit deny of some
options combinations (patch 2), and some refactoring (patches 3 and 4).

While at it, I added a new selftest (patch 7) to validate this case --
including a modification of the chk_add_nr helper to inverse the sides
were the counters are checked (patch 6) -- and allowed ADD_ADDR echo
just after the MP_JOIN 3WHS.

While working on that, I also noticed that re-using IDs were not
possible in some cases -- see patches 8, 10 and 12 -- and the accounting
was not correct in some other cases -- see patches 14 to 17.

The selftests modification have the same Fixes tag as the previous
commit, but they should not get the 'Cc: Stable' one later: if the
backport can work, that's not, if not, no need to worry, many CIs will
use the selftests from the last stable version to validate previous
stable releases.

The last patches don't have any modifications of the selftests attached
to them, because the current ones were producing the new WARN() that
have just been added.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Changes in v3:
- Small changes in patches 10 and 14, see individual changelog (Geliang)
- New patches 18-20: small fixes
- Link to v2: https://lore.kernel.org/r/20240715-mptcp-pm-avail-v2-0-fc5153bd1f6e@kernel.org

Changes in v2:
- Do not split id_avail_bitmap per target in patch 5 (Paolo)
- Explicit deny (patch 2), reduce indentation (patch 3), stop earlier
  (patch 4) (Paolo)
- New fixes and tests (patches 8-17).
- Link to v1: https://lore.kernel.org/r/20240621-mptcp-pm-avail-v1-0-b692d5eb89b5@kernel.org

---
Matthieu Baerts (NGI0) (20):
      mptcp: fully established after ADD_ADDR echo on MPJ
      mptcp: pm: deny endp with signal + subflow + port
      mptcp: pm: reduce indentation blocks
      mptcp: pm: don't try to create sf if alloc failed
      mptcp: pm: do not ignore 'subflow' if 'signal' flag is also set
      selftests: mptcp: join: ability to invert ADD_ADDR check
      selftests: mptcp: join: test both signal & subflow
      mptcp: pm: re-using ID of unused removed ADD_ADDR
      selftests: mptcp: join: check re-using ID of unused ADD_ADDR
      mptcp: pm: re-using ID of unused removed subflows
      selftests: mptcp: join: check re-using ID of closed subflow
      mptcp: pm: re-using ID of unused flushed subflows
      selftests: mptcp: join: test for flush/re-add endpoints
      mptcp: pm: remove mptcp_pm_remove_subflow()
      mptcp: pm: only mark 'subflow' endp as available
      mptcp: pm: only decrement add_addr_accepted for MPJ req
      mptcp: pm: check add_addr_accept_max before accepting new ADD_ADDR
      mptcp: pm: only in-kernel cannot have entries with ID 0
      mptcp: pm: fullmesh: select the right ID later
      selftests: mptcp: join: validate fullmesh endp on 1st sf

 net/mptcp/options.c                             |   3 +-
 net/mptcp/pm.c                                  |  13 ---
 net/mptcp/pm_netlink.c                          | 136 +++++++++++++++++-------
 net/mptcp/protocol.h                            |   3 -
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 131 ++++++++++++++++++-----
 5 files changed, 205 insertions(+), 81 deletions(-)
---
base-commit: 296fa2eabd1b78e41a4ff9e4d345be994de96ea8
change-id: 20240620-mptcp-pm-avail-f5e3957be441

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>

