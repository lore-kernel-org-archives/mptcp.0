Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F20A6171075
	for <mptcp@lists.linux.dev>; Mon, 22 Jul 2024 19:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721676953; cv=none; b=b+HkC6m/V/tMEsHoPgoWn6z6wGoI6B7MUinfjCYo70gr2P8oq+ka1mYMp/Iopm67fODaHMraik3zVS1fXVehY8QhrUogk4fuZp1pY/Av40jfvXjwlt4qUdc1/tjYPmQ6Z6osFxQlDvS/iJiUXCkKuON0+Ecq/vMzhESVkXU8moY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721676953; c=relaxed/simple;
	bh=FkY++dfB+R2OVNPehig3tUAUXWK45QHc2e47vXP0HmY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=A+DkzPY67oQb/G/ISnCJQmCIrXh3zAUCbXGxGvr/vVAALoo4i0MJCtM4ux6beFTMLFEZzAQJVEegaUPV53BpBH2/wPhFnncFmyvXbvfiVIGrgYrZMdgI6g/6QruicbL1BnMt+FAUo3YLDJv8auonvEDeFuQINXmbhKXSX/XpVdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XDlSvbvX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XDlSvbvX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF0A3C116B1;
	Mon, 22 Jul 2024 19:35:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721676952;
	bh=FkY++dfB+R2OVNPehig3tUAUXWK45QHc2e47vXP0HmY=;
	h=From:Subject:Date:To:Cc:From;
	b=XDlSvbvXsKVlbiOboExnQrsQ6IZGMVVwTz/kMR3edp4XvoEsIHyp0nRYy1ZdwIaQL
	 0TYYs/flpUqig94KJLoGUGvMm54Kr3i/AFKmK5tPtyeEMtby6xt2oUAzXpQMnfpYf0
	 PES9FgKfxNThAbcQ6wFKUxDe0Gej0cw/0XffBAn2FXbF6laFtpoFGlsx1yrz2iz3nF
	 CNh2elGiFzmHMS8yToDfJ1YTDQm7idicPybC4ZwfqQ63TC5PD/OF+3ikBV1XgK1R9s
	 YsGAp8lTy1E/Yyw2Y7ChdYeRCoZdXtfxVbYqXRRHpGPNGIwkAfG/coniHPI9WxD4N5
	 6P3eIFZ2mbI1Q==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH mptcp-net v4 00/23] mptcp: fix endpoints with 'signal' and
 'subflow' flags
Date: Mon, 22 Jul 2024 21:35:38 +0200
Message-Id: <20240722-mptcp-pm-avail-v4-0-15bfd73de384@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIq0nmYC/2XNyw6CMBAF0F8hXVvT14B15X8YFxQGaMTSFNJoC
 P9ugyY+WN7MPXdmMmKwOJJjNpOA0Y52cCmoXUaqrnQtUlunTAQTiuWC0ZufKk/9jZaxtD1tAKW
 GwqBSnCTkAzb2vg6eyavrcCKXdOrsOA3hsb6KfC28V/n/auSUUZNrUQOagzZwumJw2O+H0K5bU
 Xx8wWHjRfJNBRykqXmT48bLb683XiaPOjcAmldYyx+/LMsTD4cQ/DgBAAA=
To: mptcp@lists.linux.dev
Cc: Paolo Abeni <pabeni@redhat.com>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4922; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=FkY++dfB+R2OVNPehig3tUAUXWK45QHc2e47vXP0HmY=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmnrSW62HP2Nth1lBvvIw2AVhf6jFJdqYw9F2QG
 UKkM3LUNd2JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZp60lgAKCRD2t4JPQmmg
 c5d+D/9FK122zUXSNDo0gu0GW60dU3jFQREXtM0kO/rJcrOwNAz0YlSiAiQPeXBwtXkyB/Xgnn3
 N8Tqsp4zH5/+oQzv2mgAmSdoy/ym1+hsQD9iUXf7ej1QTsN37qDPQnzoioTWl8eIL8wU7rtPlTC
 BM0rl44lPKQ9H/auj9aarYBnG4ytiutLCFiWmy3wWI0Ww0FsxaeWLtLvMqvjjuCGpatIkAbgWWP
 LHyjsJjj8CBGHTQK3tKbh8eH92c4mkJ7DZfP+oSG5W9WMRHXthz34QfciIt6qp3lHZtzI34xd+e
 Idxv2mi/8KF5+KyLeWBVeR8olFJQHBlL9BYeagsTxJ073G6ZQcXFnYqcHhxK3VO8myLT06cq12L
 PmSd1vUx9ajddLNtBlmkdVjfNXVFXYCHK76HzIDA/hM4l/7MUS/hPohfdk2y3/KKoV20JYU1xFj
 i0jj4Jdlv3rMFP+fG7c7EjgDwohzN6fN4riCbu87SW/L23ymwej2q4uB/FDj9ERx0YitVfLslYe
 uzlqPXlAlYRrXDaX9fApwkwWGkIawQtL2/bp8GB1uEQ9YG7palMSD9RA/9nOtZuc4JL81a2imY0
 crT8BHK1zZxps1sp2BjpxhXSEEInCS/X9e0PbFHDKOzKeCZ+QXonHfQKuUbrfT2k4Y1wvpvrEUt
 vKulav7i+JUa7JQ==
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
Changes in v4:
- Patch 19: check for msk->first != NULL
- New patches 21-22
- Imported patch 23: might be easier to review all of them, then this
  single one alone, while it depends on the previous ones.
- Link to v3: https://lore.kernel.org/r/20240719-mptcp-pm-avail-v3-0-e96b5591ced3@kernel.org

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
Matthieu Baerts (NGI0) (23):
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
      mptcp: pm: avoid possible UaF whend selecting endp
      mptcp: pm: reuse ID 0 after delete and re-add
      mptcp: pm: reduce entries iterations on connect

 net/mptcp/options.c                             |   3 +-
 net/mptcp/pm.c                                  |  24 ---
 net/mptcp/pm_netlink.c                          | 210 +++++++++++++++---------
 net/mptcp/pm_userspace.c                        |  19 +--
 net/mptcp/protocol.h                            |  13 +-
 net/mptcp/subflow.c                             |  29 ++--
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 131 ++++++++++++---
 7 files changed, 258 insertions(+), 171 deletions(-)
---
base-commit: 140ff27ee47286bb0a270f3aa275fc319724da8d
change-id: 20240620-mptcp-pm-avail-f5e3957be441

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>

