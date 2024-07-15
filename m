Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8924A186E42
	for <mptcp@lists.linux.dev>; Mon, 15 Jul 2024 10:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721038201; cv=none; b=VxxFMGNiFTRppcSuB9UaLTC5tYREFnZ0Y9FXVT1LYvhUoXuZbX4u+Ig3bcspOsPifaYPhb8+FDmUwb61dHfORljuvzt1ZJsmlIpkmvdJu9VldZUIAr+yu5l/lvx253r+lxsAk5QzcDOq2UQIbCYzZCYQg6bE7/IjMFP4CJ+0rzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721038201; c=relaxed/simple;
	bh=Tmw+utT74hNEZNrJYoTUMlpt2uCtzr8gL0l5Qtr2ZyM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=i0lHfvZTEubzmY+tnpMdRHoRU3nXwL3jFBmv7/ZvJcDMTNPhKmmlrZ/Amdp0Zdx17gEEoM0RcSuQdjGwjL921qniAMo85WSWAMbYcQdbbgIFnt/Le5zbfls4aImKB5bshjcQPkQs2hrZss6FaK8YX/l2owXVbh3IyCNJuAZsnTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FsU/vzw6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FsU/vzw6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45485C4AF0A;
	Mon, 15 Jul 2024 10:10:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721038201;
	bh=Tmw+utT74hNEZNrJYoTUMlpt2uCtzr8gL0l5Qtr2ZyM=;
	h=From:Subject:Date:To:Cc:From;
	b=FsU/vzw6Y0p86e0EemukkO5l/0vS/LhNZxg/ELYgERiCdDq0rWUqD1bAFaWpEelH5
	 DArHCOCzk2Tzx10eOBRgjChnOOp7mvHUNPH2/FbWyMKX57Mgz0wMUMwEKdGGZdmG7C
	 bKvjFpHpAXy8Us4t51eDeY50xInuKcrk6BiyGGktwaFqbObtBR+90hKyrblBdhD1i7
	 agCk86Rwu3yOEei0jcSLUelo0k9SPaeO5vWDOYNlSppSWZSfNePRm9dK4wbmNKr+Fy
	 +aIOH9wo/i//3Lkz7KzcwaKeA5RjJ1ckne+PubPnl+QfpsmK+H4q7an3l7uaXR+f+B
	 url63pv/83+Ww==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH mptcp-net v2 00/17] mptcp: fix endpoints with 'signal' and
 'subflow' flags
Date: Mon, 15 Jul 2024 12:09:38 +0200
Message-Id: <20240715-mptcp-pm-avail-v2-0-fc5153bd1f6e@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGP1lGYC/12NwQ6CMBBEf4Xs2TVtpSic/A/DgcICG6E0LWk0h
 H+3QU8eJ/PmzQaBPFOAKtvAU+TAi01BnTJox8YOhNylDEqoXBRK4OzW1qGbsYkNT9hrupT6aij
 PJaSR89Tz6xA+4MtaWqFO1chhXfz7uIryAH5W+W+NEgWaolSdJnMrjb4/yVuazosfoN73/QMPB
 5MRuAAAAA==
To: mptcp@lists.linux.dev
Cc: Paolo Abeni <pabeni@redhat.com>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3933; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=Tmw+utT74hNEZNrJYoTUMlpt2uCtzr8gL0l5Qtr2ZyM=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmlPV2dBx3zlCxejL2Zv+/xYZ9d0LtvaFFA00Mn
 PjQmCHOakKJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZpT1dgAKCRD2t4JPQmmg
 c5aMD/90iQtDeTk7f93gTZixBMe/7cQAFcRbNIsPukTlY2ZiJ/gxADoussiiUZUzp0p7hfNcgsB
 davSyNq6EFKhqRvuKHIvJMKR8sSxyNVLNhzmv+xrXt71SCL+TpCqr47wwS0JgBqMm6LColVMfOE
 hz5JlMIu1W2mOot7BTB6KtFlZMnD3I/tm0ha5p1ruWnsBTboLw3b7w1MFfH+Oqstoa+Q/Kcy5Bq
 RmVieMNDjZD2xrkD7A0T/xqJPxB8C1VagQVwa5kQzHeLUZwfpzHnrD+4EvNKCeFIlsUV3j8xRAR
 mCswyzz55ATWmcUs6Y0PBd2AKbuOj88v6FmIUCd50Oiv2ptEhZ0YIcFN+r7O2JQFSfWssESORK0
 htAXANKb48BSshnF9HKxE9IXcvPZLAMtrWdtpBiBqEObWIq9eqZynFvyHjw44ObvOvkQyvuxR0w
 RKt6KhQpHVuU+t180L969DP9P1nzhc3EQtIUqAG2QKvorYHGEQy+GBI/UkCTZ8EioYSPHEUcG3R
 gwPrY1+MA2SAo20uHD5E7HlSJ77LmAc04m0SHPG0ecEesFVBIKwi7mikMIgIQgAyriIPsOIwB4R
 4wxQn0HF+qgwVHae565WUZSwx5OVJ7x+nuqvRglY3splw/UUuP0n6dAxUib2TvX+Y3UwylxIlOc
 ctrEBEkVVgcH+hw==
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
Changes in v2:
- Do not split id_avail_bitmap per target in patch 5 (Paolo)
- Explicit deny (patch 2), reduce indentation (patch 3), stop earlier
  (patch 4) (Paolo)
- New fixes and tests (patches 8-17).
- Link to v1: https://lore.kernel.org/r/20240621-mptcp-pm-avail-v1-0-b692d5eb89b5@kernel.org

---
Matthieu Baerts (NGI0) (17):
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

 net/mptcp/options.c                             |   3 +-
 net/mptcp/pm.c                                  |  10 --
 net/mptcp/pm_netlink.c                          | 127 ++++++++++++++++-------
 net/mptcp/protocol.h                            |   3 -
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 130 +++++++++++++++++++-----
 5 files changed, 197 insertions(+), 76 deletions(-)
---
base-commit: 6cad12b229c1b550b9be002f364632fd0f120b24
change-id: 20240620-mptcp-pm-avail-f5e3957be441

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>

