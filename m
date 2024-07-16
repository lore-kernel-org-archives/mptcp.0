Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A59EE626CB
	for <mptcp@lists.linux.dev>; Tue, 16 Jul 2024 20:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721163203; cv=none; b=clVx+JBdzeLvZmQyiSB6Qro95r0D//yL/ndVv3ITxe9e+zn4cvhHmiX8NZXtucZoRYOM4HS7jxoayaTpSs/WXZAsNrPNSF9Z+xutaiYjboED7ElxqHHe6JL4pM6lgG77PfoK6CLxtsI0mXE6cE9YZNT2g9s/1gmClZE7+b5htxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721163203; c=relaxed/simple;
	bh=UHuNqlZGxBejBVBmJI0UqHf0eUnY3p3lpg60fspnI4o=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=X5Csn7b5IvDvsQJkA5miBGJeb/35bFNtcjzQESjagTFcT4MMFgsoj6oqw7jRnuJCqIUHKTxfXAYlkEr6+v7Fz8UJWYDFXK1fHm9ckwzJ4OznmfZKcKeXacYZy1H6RMuc2Jt3gL9sWDvv4Ld/8+IXluvvjIwobS5IVBasq+Rk1p8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K3yOceNd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K3yOceNd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4BB3C4AF0E;
	Tue, 16 Jul 2024 20:53:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721163203;
	bh=UHuNqlZGxBejBVBmJI0UqHf0eUnY3p3lpg60fspnI4o=;
	h=From:Subject:Date:To:Cc:From;
	b=K3yOceNdcVeheog/7LLIa+T8Nt8Ra59XGb5OmUmt+9apdGEtxEVc4dhGHTcvkbZTr
	 Cprm2eg5rq1plUZxZm6thB44lmEWXidb1sVNmFZqlGAVN3OMCajAmDyERyGhtrYjlr
	 31mTH0wnoCu2NHQbT9jSC6SPqAXMbo5FDGDaVksEy4ac0+XyARIIbrjUI/EhLtH2qs
	 xwpv9hA5EM0I6PWWP+aisASV6VXfh323MVAiAYnoN7TCxNA4sMIn/VXfQ+7PDWd3/v
	 90nKp1Ljr4je6+TCWawJRe3Q47GAWwpzRWvdLK8gRz0CIQUuokhyXg2FfC30d7kfrZ
	 N9ZQVF/zTARoA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH mptcp-net v2 0/9] mptcp: fix inconsistent backup usage
Date: Tue, 16 Jul 2024 22:53:12 +0200
Message-Id: <20240716-mptcp-backup-mpj-v2-0-4d50247405fb@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALjdlmYC/3WNQQ7CIBREr9L8tRigLbauvIfpAulvi1UggETTc
 HdJXbt8mZk3GwT0GgOcqw08Jh20NQX4oQK1SDMj0WNh4JQ39MQYebqoHLlJtb5cgTvhU1eLfpJ
 jLQSUmfM46feuvMKvbTDCUKJFh2j9Zz9LbC/89yZGKBmbtqWCdVz2eFnRG3wcrZ9hyDl/AW6sY
 9W8AAAA
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2975; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=UHuNqlZGxBejBVBmJI0UqHf0eUnY3p3lpg60fspnI4o=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmlt3B5YF6HCd2U/8YLWVk61Kn+jh/BIib0oEG3
 O97ejFn4hKJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZpbdwQAKCRD2t4JPQmmg
 cyHeEADDBC7i99zHNgF7DTYs4znhh5bketiHuM5Y5gCxAHP6VhPg+dOAJHUrt4rcKlPnwRMi7qk
 HVujhENP0SoEGEXxdctsB4LZ64C0JJTjRAClHAeQitYqHJmw6E3w2H2tGty4hRk40IPW/hwmr1u
 8wBidW/lurJnKkGw7ES2p1vsMw/tXmCs2DvKgM+sFLd7rcjKAmXH1c21bGh4gtt38gQelHgBsa8
 QPibwIK4ZSWoqmXTqXRv5NzI23oSGZpk9lFQwqfg2dxmNaqoyv0g9n6yWinRUfgZc5+uI3osZhU
 naoUHTnQGkgmr2u1XL7v0BRS6azYcbnDCZHnE46gR3+OhrPJZFmWH+z+EfV0NZ45jxSzsRRBbEh
 i9bKaOcYK+4m5IjRPhG0es/PpNvKPtFiq70JCv3x9nNvJuuRtv8NDxFMIRJZjAOX3Wh4Osn8yO4
 GJo9M38Y594XE1jkouMOuBiSTyHFzDCHYplVWtCJpfiBW96klWuZ8QPRvq+aleys0tmBcMNmpsM
 sN0nGftVyGlNm02Wt3h9ght9yz+dRARP6Puv3OmQcAk9ysO1vopg4up+7ZgFlnnV464vbCdpqEJ
 7zO1pKD+5zagbsI6yq1PB513ISK8J98jKZzC6wT/kSF06dGR8LbNV5aLKRICJBkBLoD6wW+TM+m
 ZqqIXFwoaoYXseQ==
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
 net/mptcp/pm.c                                     | 15 +++--
 net/mptcp/pm_netlink.c                             | 24 +++++++-
 net/mptcp/pm_userspace.c                           | 25 +++++++-
 net/mptcp/protocol.c                               | 10 +--
 net/mptcp/protocol.h                               | 12 +++-
 net/mptcp/subflow.c                                | 16 ++++-
 tools/testing/selftests/bpf/progs/mptcp_bpf_bkup.c |  3 +-
 .../testing/selftests/bpf/progs/mptcp_bpf_burst.c  | 12 ++--
 tools/testing/selftests/net/mptcp/mptcp_join.sh    | 72 +++++++++++++++++-----
 13 files changed, 159 insertions(+), 38 deletions(-)
---
base-commit: 06bd6d6c3416101af4881b6f3a0830ccca97c056
change-id: 20240711-mptcp-backup-mpj-2f8369fad366

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>

