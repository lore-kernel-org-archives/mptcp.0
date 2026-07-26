Received: from sender4-of-o52.zoho.com (sender4-of-o52.zoho.com [136.143.188.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4024A344DAE
	for <mptcp@lists.linux.dev>; Sun, 26 Jul 2026 05:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785045351; cv=pass; b=ofpqMJ832Px/xPr/4CvH0aClVwUP3OyWwfss9xTb50cGR8uj+xew+XkAhq5Bt0qBae2jW7/ai+zYa2wJ3VndQg5Mnd9gp3F8BK6NNtEQbDE6m7RP1vhWZq7j6/7s0DBmFftivphzyud2AAf9TqfrWkC6O/fDZ0iMU+Wt9sbo4BE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785045351; c=relaxed/simple;
	bh=pPZ3qBtbX5MCLcG/XOLpsQ0di6aCw4Nq978O8Aef+j0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=QpzutTWvrn8CYdXkNXoCmiClTNLJJfTXsFCk5OEyGoE+Mcs0R94ZDSmW+XqPvWavsEYu5gGvqpr2xJkV3R4uDkcGIMI0MF+ufGFbVS0UwDeilb4pvRClak1O0hj1KJNCRa+XqXGijpL9B27LCSL2Su/AF6mPgij3n8qFZKd7+cw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com; spf=pass smtp.mailfrom=mpiricsoftware.com; dkim=fail (0-bit key) header.d=mpiricsoftware.com header.i=shardul.b@mpiricsoftware.com header.b=dOL8MhPt reason="key not found in DNS"; arc=pass smtp.client-ip=136.143.188.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mpiricsoftware.com header.i=shardul.b@mpiricsoftware.com header.b="dOL8MhPt"
ARC-Seal: i=1; a=rsa-sha256; t=1785045347; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Qq3w3zewcuGsOiqMgJYm5r0aarASJi5riIz3hoM9lBfmL+9UZPur4OGT9oNe5D+nx9emSEu1Usq+f4uEzS3ZPfcvm9jaB/Zz3ACVY5afF36PV+tCkv19MqGLzE/ejMs9YIDv4J4tjtN7/XypcpD/A3zG4M/GMcyEi+8RcrYTmtA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1785045347; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=XA5MfRebIgfrdK2vbEGbq2pPXKL0pgJsWW7Ejbzs5h0=; 
	b=Wg6a4Fp324mIRllHujz8VPqASTXRIKC7gRWjjN0819M95Tc75+adRlTpsAaa236NcYz2rbIL0PAaRaDYreiKSW7pbxlBONpNWOvk7Dgg/flFXCxNqp/aElF7v7ELDmbfxXdeIBT86O0GVOHzdWNTsWLcWWLIwr+I5QoflYWYuag=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=mpiricsoftware.com;
	spf=pass  smtp.mailfrom=shardul.b@mpiricsoftware.com;
	dmarc=pass header.from=<shardul.b@mpiricsoftware.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1785045347;
	s=mpiric; d=mpiricsoftware.com; i=shardul.b@mpiricsoftware.com;
	h=From:From:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:To:To:Cc:Cc:Reply-To;
	bh=XA5MfRebIgfrdK2vbEGbq2pPXKL0pgJsWW7Ejbzs5h0=;
	b=dOL8MhPtuQwQUIp0SSBuUy8Z7j4xvGs9Y6Ocu2sLVnv5Ldu5OidQrqviVqfc9K8y
	oV0FT8jdKCer2uF9OHKJ/XXgvwvAUOOowDz76zplUeZQ7T9NuNCH5JQdF28N3wfKBpG
	FU9vRSdgaHVlCjik6WdW0nrPsbJ15JWDGIYUr7YQ=
Received: by mx.zohomail.com with SMTPS id 1785045345004810.5507381962997;
	Sat, 25 Jul 2026 22:55:45 -0700 (PDT)
From: Shardul Bankar <shardul.b@mpiricsoftware.com>
Subject: [PATCH mptcp-next 0/3] mptcp: sched: penalise a slow subflow
 (#345, first cut for your lab)
Date: Sun, 26 Jul 2026 11:25:38 +0530
Message-Id: <20260726-mptcp_penalise_send-v1-0-84485e0e995b@mpiricsoftware.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFqhZWoC/yWMUQrCMBAFr1L220CzYoteRaS06YuuaAzZKIXSu
 zetn8MwM5MiCZQu1UwJP1H5hAL2UJF79OEOI2Nh4pqbuuXGvGN2sYsI/UsUnSKMhv3g7enIZ9d
 aKmVM8DLt1yvtgQmYMt3+Tr/DEy5vW1qWFSl+ja6DAAAA
X-Change-ID: 20260726-mptcp_penalise_send-2fbf15329c71
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 MPTCP Linux <mptcp@lists.linux.dev>
Cc: shardulsb08@gmail.com, Shardul Bankar <shardul.b@mpiricsoftware.com>
X-Mailer: b4 0.15.2
X-ZohoMailClient: External

Hi Matt,

Following up on my note about aligning #345 to mptcp_rcv_buf_optimization():
here is a first cut, as a 3-patch series. A few things came out differently
from what I described there, so I have called each one out below rather than
leave it for you to spot.

  1/3 penalise a slow subflow by halving its cwnd
  2/3 do not penalise when receive-window-limited
  3/3 DO-NOT-MERGE counters (for testing only)

1/3 is the simple version. In the scheduler, once a subflow is picked, it is
flagged for a cwnd halving that is applied in the push path under the subflow
socket lock (so it is safe with the per-subflow locks, as I mentioned). The
flag is set when the subflow is clearly slower than the fastest path, the
fastest path is cwnd-limited, and the subflow is in TCP_CA_Open. The reduction
halves cwnd (and ssthresh if cwnd is past it), at most once per RTT, and the
congestion control grows it back.

What differs from what I described, and why:

- Trigger on delivery rate, not RTT. I had said "slower by RTT". In testing
  that over-penalised a path that is only higher latency but still carries its
  share of the traffic (equal bandwidth, unequal delay): it fires on the
  slower-by-latency path even though shrinking its window loses real goodput.
  Keying on the pacing rate instead (penalise only a path whose rate is below
  half the fastest) targets a genuinely low-throughput path, and reuses the
  avg_pacing_rate the scheduler already maintains. On the threshold I raised
  with you (the fork's "any slower" versus a small factor): I had said I would
  default to "any slower", but with a rate trigger that fires on almost every
  non-fastest path, since rates always vary a little, so I used the factor to
  keep it to genuinely slow paths, as I flagged might be needed. Half is just
  a starting point, easy to tune.

- I did not carry over the fork's "meta is send-buffer-limited" gate. In
  mainline the msk send buffer is the sum of the subflow send buffers, and it
  is effectively never full when the scheduler samples it (the scheduler runs
  on the push path, just after an ACK has opened room), so that gate never
  fires and the penalty stays dormant. That is why 1/3 has no send-buffer
  condition.

- 2/3 is a guard that is in neither the fork nor what I described. Without it,
  1/3 regresses badly (about 2x slower in my runs) when the connection is
  receive-window-limited. In that case the fastest path is capped by the same
  shared window, so it cannot absorb what the slow path gives up, and halving
  just sheds the slow path's throughput. 2/3 skips the penalty while the
  application has queued past the send-window edge (write_seq > wnd_end), which
  is the sign that the receiver, not our congestion window, is the bottleneck.
  I kept it a separate patch so you can test 1/3 on its own, or drop or retune
  2/3 independently. The exact condition is the piece I would most value your
  lab checking.

Testing was local (network namespaces plus netem, patched against a clean
mptcp/export), starting from the existing simult_flows selftest. It is a debug
kernel and mostly single runs, so please read the numbers as directional; I am
happy to share the full logs and the scenario script.

- No regression on the simult_flows suite.
- To see the intended effect I looked at MPTcpExtOFOQueue, the number of
  segments the receiver had to hold out of order over the transfer, since that
  is what the change is meant to reduce and a plain throughput number cannot
  show it. On the asymmetric-bandwidth pair (10 vs 3 mbit) with a small
  SO_SNDBUF, that count fell by roughly a fifth (about 18 to 23% in my runs)
  with no change in throughput. So this is a reduction in reordering, i.e. a
  latency and smoothness effect, not more bytes per second; whether that is
  worth it for a real workload is exactly what I hope your lab can judge.
- The receive-window-limited regression above is back to baseline with 2/3.
- Two honest limits. First, with fully autotuned buffers (the common default)
  the guard does not fire, because the connection is not receive-window-
  limited, and the penalty then leaves a small reordering cost: halving trims
  the slow path's delivery rate, so its share of the in-order stream arrives a
  little later and the out-of-order count rises a few percent. I did not find a
  simple way to also suppress
  that without re-opening the gating, and I did not want to over-build v1;
  scoping it more tightly (for example only when send-buffer-limited) may be
  the right call and I would defer to your lab on it. Second, I have only
  exercised two subflows and no backup subflow so far.

3/3 adds two MPTcpExt counters (CwndPenalized, PenalCandidate) so a run can
tell "the guard held the penalty back" from "the trigger never fired". Not for
merge. I left your Co-developed-by on it in case it is useful to you elsewhere.

I drove those regimes with a small simult_flows variant (receive-window-
limited, send-buffer-limited, and autotuned cases). It is a helper, not
selftest quality, so I did not fold it into the series; it is on a branch of
my tree, in case it saves your lab time or you spot a case I missed:

https://github.com/shardulsdk-mpiric/linux/blob/6926c4b7f583/tools/testing/selftests/net/mptcp/mptcp_sched_penalise.sh

Run it on a baseline and a patched kernel and compare (prefix with
MPTCP_LIB_IP_MPTCP=1 if pm_nl_ctl does not work in your setup):

  SCENARIO=suite                              ./mptcp_sched_penalise.sh
  SCENARIO=unbounded                          ./mptcp_sched_penalise.sh
  SCENARIO=rwnd    RCVBUF=262144              ./mptcp_sched_penalise.sh
  SCENARIO=sndbuf  SNDBUF=65536               ./mptcp_sched_penalise.sh
  SCENARIO=both    RCVBUF=262144 SNDBUF=65536 ./mptcp_sched_penalise.sh

For the rwnd/sndbuf/both scenarios the simult_flows pass/fail bound is not
meaningful (it assumes both paths are fully used): read the printed runtime
and out-of-order counts, not OK/FAIL. The "both" case also occasionally fails
to bring up the second subflow with the very small SO_SNDBUF; just rerun it if
you see a single-subflow run.

Thanks,
Shardul

Signed-off-by: Shardul Bankar <shardul.b@mpiricsoftware.com>
---
Shardul Bankar (3):
      mptcp: sched: penalise a slow subflow by halving its cwnd
      mptcp: sched: do not penalise when receive-window-limited
      DO-NOT-MERGE: mptcp: sched: penalise counters

 net/mptcp/mib.c      |  2 ++
 net/mptcp/mib.h      |  2 ++
 net/mptcp/protocol.c | 94 ++++++++++++++++++++++++++++++++++++++++++++++++++--
 net/mptcp/protocol.h |  2 ++
 4 files changed, 97 insertions(+), 3 deletions(-)
---
base-commit: 97ce11d2793f114ca652a565a8d2795c085d8ff1
change-id: 20260726-mptcp_penalise_send-2fbf15329c71

Best regards,
--  
Shardul Bankar <shardul.b@mpiricsoftware.com>

