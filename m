Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D38C41662FA
	for <mptcp@lists.linux.dev>; Thu, 11 Jul 2024 15:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720712394; cv=none; b=fw/4pj3nccTSVuLHGPnzhbCIlT4SRDmIoXf916fN6AOki46F25VFcP9y38WQCxF1vVXauiCHE5Y4nD+S2/56mHfd0bgtKY8pg75j2/ZOhO4xDjmA2CC/Z/hJ1TG7UlquQ0yf9m6mcy+AZJS3T8Dh9+IwCAzRiUeP2JLrojNh2Sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720712394; c=relaxed/simple;
	bh=qt238KAH1HoONNqykav2oNlgQbcm1b5rGlwQFfiZVK8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=o26wGCPXr7vQmiXdawu4ua8FGFYpWTAig5+5g8QES/4KRXodrbkoJZ11QiYJPjJ7JKex0nsgUV/bKrsJMeEcksOHUCxxMZCAFMHl4VS3CETyEzQHbJmUcdcpQ+j6KqpbSVn8PX9oj/JE83Z2zldod9YZgoCV2eh9PTKMitrutdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JOYKNlbj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JOYKNlbj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FCFBC116B1;
	Thu, 11 Jul 2024 15:39:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720712394;
	bh=qt238KAH1HoONNqykav2oNlgQbcm1b5rGlwQFfiZVK8=;
	h=From:Subject:Date:To:Cc:From;
	b=JOYKNlbj5ou6Rtb16JdLSO2L5iflZp6pjd2TMvEcJpHr7nmo9bLxcAknXRPtmy9gP
	 n3rYrugx+dd73CFdFk5hLuIHzqWn6++758iEO9WZrbl7DNuZWMKIT2mhh75Mgvl2kV
	 Lo7Ja4FgJfNip/GN9v8eQLHI8kpsFTA0itnf774w4IFqQy0ngL6dUoPq0wuEEq4n8N
	 FF9strS8aUoMarfhT7o+FJXxXOaLdfJJiRJfSHoz0U8OIwzl9fS7S5NWUF363YawGb
	 CIgPVPvY6N3loqO9Ngzp/biXw/IpwWi/A7518xWV49vCtNEspF/jDBO5UtcFxGVaCw
	 6bweO3E5vpRrQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH mptcp-net 0/6] mptcp: fix inconsistent backup usage
Date: Thu, 11 Jul 2024 17:38:57 +0200
Message-Id: <20240711-mptcp-backup-mpj-v1-0-d45506182a9e@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJH8j2YC/yXMywqAIBCF4VeJWSekhV1eJVqYjTVFJloRRO+e1
 PKD/5wbAnrCAE1yg8eTAm02gqcJ6EnZERkN0SAyUWQl52x1u3asV3o5XMTMhKlyWRs15FJCnDm
 Phq7vsoW/trhD9zwvi7mLTG0AAAA=
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2448; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=qt238KAH1HoONNqykav2oNlgQbcm1b5rGlwQFfiZVK8=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmj/zIfQUL1/8dDmbhvu6KS8n/gqwyDv75iLiC0
 rDx6lGnXIaJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZo/8yAAKCRD2t4JPQmmg
 c14rD/wKoJXkjR2wrNjjsnKQ9rsjeU9/9cvOgXq9NpzGvRjJvKrudxXlBWMddfQz8Q4Qam+yx/r
 ddbcujJQ21Vo9LEchFXhWt9w+FeTitXMbuKs+R36OliLnzg++/8V5NpXd4TGv38NWl31vfv7cNC
 Mh2mEqrWvHmi+MnrL8EFNp52oislolDyMBm24MjIovald67DMpE1EfGKRQm5J3q5Zpd1Z944Orr
 Z8A/JvtE7aVfaPJGoNeLM91VoumzITT1Dfms22ZDzKPtHLxReecIPPzYxROjQ+zs8v9JbvnGZGx
 5w1q1EeBI5zksL+Lm5EjO4/m2JH2rDwpnx0Zdk8eWKRnwphwHEW3HyjblUHhLGcUKFhZBTsPrD2
 zrN3TJ44ovQF/JsC46QtxgI+aANvUJ3JL1pVDffIlgunaZM5g5dtobfdYKDH6Dsq1DMH+i8lFSO
 InTG3BZSSC5p4tn4EoN5vSCuVu8RJhnyRgU++u32gOxqNPIXDjEjtEYwXMqlbnUtuJC8AmN/quN
 4tcyhb3xF6yPvSzjrJIl30qbg5EGPsvmqEeA6kzUNipBVXY983F8VEzCvEN0kjsinuB8UcPxBj9
 uJqIVCd1DWhF0Hl3flXheC8CmY37XdAm4QQuTm+6WrZgAjnPcaDKedjF3gVIcpnQ1NXHF+OUDsr
 AfRHjDuR2n+aDYg==
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
Matthieu Baerts (NGI0) (6):
      mptcp: sched: check both directions for backup
      mptcp: distinguish rcv vs sent backup flag in requests
      mptcp: pm: only set request_bkup flag when sending MP_PRIO
      mptcp: pm: fix backup support in signal endpoints
      Squash to "selftests/bpf: Add bpf_bkup scheduler & test"
      Squash to "selftests/bpf: Add bpf_burst scheduler & test"

 include/trace/events/mptcp.h                        |  2 +-
 net/mptcp/options.c                                 |  2 +-
 net/mptcp/pm.c                                      |  9 ++++++---
 net/mptcp/pm_netlink.c                              |  5 +++--
 net/mptcp/pm_userspace.c                            |  6 ++++--
 net/mptcp/protocol.c                                | 10 ++++++----
 net/mptcp/protocol.h                                | 10 +++++++---
 net/mptcp/subflow.c                                 |  8 ++++++--
 tools/testing/selftests/bpf/progs/mptcp_bpf_bkup.c  |  3 ++-
 tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c | 12 ++++++++----
 tools/testing/selftests/net/mptcp/mptcp_join.sh     | 19 ++++++++++++++++---
 11 files changed, 60 insertions(+), 26 deletions(-)
---
base-commit: 3b378b48c0eb39df55dacebebb958187fd68d802
change-id: 20240711-mptcp-backup-mpj-2f8369fad366

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>

