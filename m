Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B5BB4D8B7
	for <mptcp@lists.linux.dev>; Thu, 18 Jul 2024 15:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721318044; cv=none; b=ZMB+guiCRnCnnjYIDg4fdYwdPVR2/d0/CCjrlLX+jxaevZmdnF5Ena4iaz1N2fj9n323baWNJZSdtsTuP6ETB+urOwmxX5imA6PPFzsJQ+QnfHFVQYHXIkKw3bxlSHlmUJAd0vQKF98oeKq9Q4gBBQzmih9vNnHmZOyKtr9/a8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721318044; c=relaxed/simple;
	bh=ekUvl/FPIPCh6emxaWdN57Uh2jY+s9xJ/YsnEz157x8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=TIdlhuc05c2gwKQC+fiUkrHEx09LK/ej78cAhGMXI08jpTIzUhjSm10BiFBxG63A2Ru92SdjPwHWKNbjicJW402czFIIzEOgpCuNymoKtbzKsk+syUB3CbnDxgZlosNSsrEC5vie3rcsT+MnIVuPbyhGxXKzcNX2MuMZeA6/tbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c7XvgOlA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c7XvgOlA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94923C4AF0A;
	Thu, 18 Jul 2024 15:54:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721318044;
	bh=ekUvl/FPIPCh6emxaWdN57Uh2jY+s9xJ/YsnEz157x8=;
	h=From:Subject:Date:To:Cc:From;
	b=c7XvgOlAwfvP97aJevpauWUzd5XqbgBBaO0Na2r76JQ3uB713LsyeAEZjnNt3scA7
	 wwF1/9JbhzgsPU1JtxQUjI+5hkrr9MpNsa5T1mPe6+iKtM3ZKm0xcE25Jurupkj3Fe
	 QPOOqPfdNqBZV69GRyZGGWGvs7iGi2+eGt3XafaS7SYnVMv/LspsVYV1ZLYsT2RObt
	 sBaXas/7WRS1gkH2ARgwwF1dyPT9hDaQSBpJZktoWDVX3z9BjMpnS/zVC6x6zFH9lR
	 o8yKT0ZYk+AYJNFbltmwCHtOvMq51F6vAalPj5ObW+TzQn/et2OPbCA0aW7vfoZOEe
	 EJ5jRPgu9TPag==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH mptcp-net v3 0/9] mptcp: fix inconsistent backup usage
Date: Thu, 18 Jul 2024 17:53:57 +0200
Message-Id: <20240718-mptcp-backup-mpj-v3-0-1f6cd9b89ee4@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJU6mWYC/3XNQQ7CIBAF0Ks0rMUABdq68h7GBS3TFquUQCWap
 neX4EYTXf7M/29WFMAbCOhQrMhDNMHMNoVyV6BuVHYAbHTKiBHGSUUpvrmlc7hV3XR3KVww6+t
 SNr3SpZQozZyH3jwyeULvtoUFndNpNGGZ/TM/izQX/ruRYoI1F4JIWjPVwHECb+G6n/2Qtcg+B
 flDYEngWqRCxYno2y9h27YXRiMc//4AAAA=
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3213; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=ekUvl/FPIPCh6emxaWdN57Uh2jY+s9xJ/YsnEz157x8=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmmTqaloZN7a6P69qo9o2wOC4vPZdUAOQne7dfF
 MMNeZHatGqJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZpk6mgAKCRD2t4JPQmmg
 cwemEADhgRmUXLVUh/sO+caRxiXMrSmV1TvOa3dey0UmMxF3kY5SUXQLApO96L95N39ZO2eEgvH
 p6mgZ9xSxB38K1RQ7+WHbPtyXl+d+edlINU1k9di9QlvUzDA4LuoP2bjKLuLeYYKyu3gBlDjrvc
 zH8DZwVVaW25yBnyD4Afqhb8cA6WL4eyHXv/9hAuN6FNVV7mKgJW6FQVsHsqaU3QgVv20R0q8WJ
 i41Pb3eHqxV8/kPaKG8SEeGngAswBWWDjwACDM56S4kC/YA8QT9ZpTwQiCyujwm8ZYpIp60aiIg
 QPpOaqWVzSNZ0GV18qD+bGoqqjWYGf/wnqyiX438GTDP59+pNd0BYP6TF+ixr9Yk6W+olg+rtJ6
 E9t2HmvpPQMllAuR9zhdZhH/Yh73MRvY/tZYL3zCSK86uqRV3M5ZzLdv1LHrCnQqktajNZyNJ2d
 ejBLbET/tpmHOVCR0e1xqrJevFH55PA+WSudhr+44A4Yj3dD8NeO2Q0ykxxGQr2TTH6pdzq7wMk
 bU1HAU5BHtApyOLePsIo+DGD4nDgDniOsOAYBdgaRJJ/coD0QfETaZRxwSiznnYZl2hG2YZTbnY
 DTAKiYz+vFjVTGynt7EtRXKPsatoiWCHwCqehWGma0T7FPxjZ8aXUFNh8YFNNcH2JyrCIRpAh0+
 PaYY9/ZvbLfmm6Q==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

In all the backup tests we have, the backup flag is set on one side, and
the expected behaviour is to have both sides respecting this decision.

On the scheduler side, only the 'backup' field is checked, which is
supposed to be set only if the other peer flagged a subflow as backup.
But in various places, this flag is set when the local host flagged the
subflow as backup.

One last thing that has been fixed is the backup flag in 'signal'
endpoints: it was working only when setting the backup flag while the
connection was already opened. That's what the MPJ selftests were doing
to check that the signal endpoint were supporting the backup flag (on
purpose I guess, because the support was broken in MP_JOIN...).

The last two patches adapt the BPF selftests to mimic what is now done
by the in-kernel packets scheduler.

Note that the Packetdrill tests need to be updated because the behaviour
has been changed / fixed:

  https://github.com/multipath-tcp/packetdrill/pull/152

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Changes in v3:
- Small fixes in patch 1 and 5: see the individual ChangeLog
- Use a new dedicated helper in patch 6: see the individual ChangeLog
- Link to v2: https://lore.kernel.org/r/20240716-mptcp-backup-mpj-v2-0-4d50247405fb@kernel.org

Changes in v2:
- new patches 4 and 5.
- split patch 6 in two (code then tests) to ease the backports.
- patch 6 addresses Mat's comments, and support the ID0 case.
- Link to v1: https://lore.kernel.org/r/20240711-mptcp-backup-mpj-v1-0-d45506182a9e@kernel.org

---
Matthieu Baerts (NGI0) (9):
      mptcp: sched: check both directions for backup
      mptcp: distinguish rcv vs sent backup flag in requests
      mptcp: pm: only set request_bkup flag when sending MP_PRIO
      mptcp: mib: count MPJ with backup flag
      selftests: mptcp: join: validate backup in MPJ
      mptcp: pm: fix backup support in signal endpoints
      selftests: mptcp: join: check backup support in signal endp
      Squash to "selftests/bpf: Add bpf_bkup scheduler & test"
      Squash to "selftests/bpf: Add bpf_burst scheduler & test"

 include/trace/events/mptcp.h                       |  2 +-
 net/mptcp/mib.c                                    |  2 +
 net/mptcp/mib.h                                    |  2 +
 net/mptcp/options.c                                |  2 +-
 net/mptcp/pm.c                                     | 12 ++++
 net/mptcp/pm_netlink.c                             | 19 +++++-
 net/mptcp/pm_userspace.c                           | 18 ++++++
 net/mptcp/protocol.c                               | 10 +--
 net/mptcp/protocol.h                               |  4 ++
 net/mptcp/subflow.c                                | 10 +++
 tools/testing/selftests/bpf/progs/mptcp_bpf_bkup.c |  3 +-
 .../testing/selftests/bpf/progs/mptcp_bpf_burst.c  | 12 ++--
 tools/testing/selftests/net/mptcp/mptcp_join.sh    | 72 +++++++++++++++++-----
 13 files changed, 142 insertions(+), 26 deletions(-)
---
base-commit: 50d1a79f5003b88b03b37d05189ad02a84d7be49
change-id: 20240711-mptcp-backup-mpj-2f8369fad366

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>

