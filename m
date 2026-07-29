Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74C8922A4E9
	for <mptcp@lists.linux.dev>; Wed, 29 Jul 2026 11:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785325745; cv=none; b=TRlag4jvzCwANqlTt3i46vysSn9A0kwf3oL1QYCy0zkS0Zht+b97ptlj8FgzbyeTz1zujrR+IAdnN9RjdxrxtKQfP/PGg4fVSBUeJDypjN2O7GPOJvW6Kj3ROfdjyOveHDOdBbwgAeWqgfHFiUZE9IneIDnir+GgOMq62UHCi8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785325745; c=relaxed/simple;
	bh=kEvDugujU/U6a4H3Z8X+BEHZN0Tn2Me6MaK9tZ2HwEw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q1tH1hWqbn6NvZK1+gS2JCfwzcF7Iw2yjz1lE3nKGDSsZJWpE7OdVCN2H9hX7wC7hsTYuLL6aO7STmx4jVGut4fAPPNOCccvYTfKI8ThsHX0/9Mj/gY8Snx7/SCWkMHo+dSccYJkOk9j65rKtD6jrhUoDo8wQ0TZuejyGQZipRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h6mGw/lT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h6mGw/lT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DEF71F000E9;
	Wed, 29 Jul 2026 11:49:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785325741;
	bh=fzHbu05lnMwsMv/WXoDgvuYSSkYfzL7FbUEk22zdf8Q=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=h6mGw/lTYyF3k9WdnZ3ogy2ASTE2QQ3R+YV/JuY3iAlWLjTXpbqIuV9f9IoOKseB9
	 vQw7iTjZFiQqty/Wf6Euo4QGH181LRXQXachYEPKjWfyipCZ2nYEphU87NqSxCQ3fx
	 PjE3E0leOYH4YA/pEfnDgkNR+x0qZ7Uc9gMNFNsn7mNxWhuPVQfhQimfUhRBYOzgaV
	 iFxnmb9FP/avr75F396Ek3XJPte9r/MDceOlbOQi2JoycvIeA4Xcy8PpMLsMqtLKlN
	 nnRyIgPG3/HH/2xKpDdH2dOyB/KtNzLOmCtcxFaF4w7BJ+hB0L5NHeLM3s10u81Iwj
	 VIwu/pIKz5qAQ==
Message-ID: <1a0d5c3b-05ef-4dbf-bb34-3141ad3d6f58@kernel.org>
Date: Wed, 29 Jul 2026 13:48:59 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next 0/3] mptcp: sched: penalise a slow subflow
 (#345, first cut for your lab)
Content-Language: fr
To: Shardul Bankar <shardul.b@mpiricsoftware.com>
Cc: shardulsb08@gmail.com, MPTCP Linux <mptcp@lists.linux.dev>
References: <20260726-mptcp_penalise_send-v1-0-84485e0e995b@mpiricsoftware.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <20260726-mptcp_penalise_send-v1-0-84485e0e995b@mpiricsoftware.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Shardul,

On 26/07/2026 07:55, Shardul Bankar wrote:
> Hi Matt,
> 
> Following up on my note about aligning #345 to mptcp_rcv_buf_optimization():
> here is a first cut, as a 3-patch series. A few things came out differently
> from what I described there, so I have called each one out below rather than
> leave it for you to spot.
> 
>   1/3 penalise a slow subflow by halving its cwnd
>   2/3 do not penalise when receive-window-limited
>   3/3 DO-NOT-MERGE counters (for testing only)
> 
> 1/3 is the simple version. In the scheduler, once a subflow is picked, it is
> flagged for a cwnd halving that is applied in the push path under the subflow
> socket lock (so it is safe with the per-subflow locks, as I mentioned). The
> flag is set when the subflow is clearly slower than the fastest path, the
> fastest path is cwnd-limited, and the subflow is in TCP_CA_Open. The reduction
> halves cwnd (and ssthresh if cwnd is past it), at most once per RTT, and the
> congestion control grows it back.

Thank you for having sent these patches!

Note for others: these were supposed to be offlist RFC patches, as an
iteration for the development we started off list, but they were
accidentally shared here. I think that's fine, sorry for the noise, but
please consider this series as an RFC.

I have some questions and small comments.

> What differs from what I described, and why:
> 
> - Trigger on delivery rate, not RTT. I had said "slower by RTT". In testing
>   that over-penalised a path that is only higher latency but still carries its
>   share of the traffic (equal bandwidth, unequal delay): it fires on the
>   slower-by-latency path even though shrinking its window loses real goodput.
>   Keying on the pacing rate instead (penalise only a path whose rate is below
>   half the fastest) targets a genuinely low-throughput path, and reuses the
>   avg_pacing_rate the scheduler already maintains. On the threshold I raised
>   with you (the fork's "any slower" versus a small factor): I had said I would
>   default to "any slower", but with a rate trigger that fires on almost every
>   non-fastest path, since rates always vary a little, so I used the factor to
>   keep it to genuinely slow paths, as I flagged might be needed. Half is just
>   a starting point, easy to tune.

Sounds good to me!

> - I did not carry over the fork's "meta is send-buffer-limited" gate. In
>   mainline the msk send buffer is the sum of the subflow send buffers, and it
>   is effectively never full when the scheduler samples it (the scheduler runs
>   on the push path, just after an ACK has opened room), so that gate never
>   fires and the penalty stays dormant. That is why 1/3 has no send-buffer
>   condition.
> 
> - 2/3 is a guard that is in neither the fork nor what I described. Without it,
>   1/3 regresses badly (about 2x slower in my runs) when the connection is
>   receive-window-limited. In that case the fastest path is capped by the same
>   shared window, so it cannot absorb what the slow path gives up, and halving
>   just sheds the slow path's throughput. 2/3 skips the penalty while the
>   application has queued past the send-window edge (write_seq > wnd_end), which
>   is the sign that the receiver, not our congestion window, is the bottleneck.
>   I kept it a separate patch so you can test 1/3 on its own, or drop or retune
>   2/3 independently. The exact condition is the piece I would most value your
>   lab checking.

It feels to me that you require this because patch 1/3 doesn't check if
the MPTCP connection was "send-buffer-limited", no? But you are doing
something very similar, no? Without testing, it feels like this is
required not to limit the penalisation to when it is really needed.

> Testing was local (network namespaces plus netem, patched against a clean
> mptcp/export), starting from the existing simult_flows selftest. It is a debug
> kernel and mostly single runs, so please read the numbers as directional; I am
> happy to share the full logs and the scenario script.
> 
> - No regression on the simult_flows suite.
> - To see the intended effect I looked at MPTcpExtOFOQueue, the number of
>   segments the receiver had to hold out of order over the transfer, since that
>   is what the change is meant to reduce and a plain throughput number cannot
>   show it. On the asymmetric-bandwidth pair (10 vs 3 mbit) with a small
>   SO_SNDBUF, that count fell by roughly a fifth (about 18 to 23% in my runs)
>   with no change in throughput. So this is a reduction in reordering, i.e. a
>   latency and smoothness effect, not more bytes per second; whether that is
>   worth it for a real workload is exactly what I hope your lab can judge.
> - The receive-window-limited regression above is back to baseline with 2/3.
> - Two honest limits. First, with fully autotuned buffers (the common default)
>   the guard does not fire, because the connection is not receive-window-
>   limited, and the penalty then leaves a small reordering cost: halving trims
>   the slow path's delivery rate, so its share of the in-order stream arrives a
>   little later and the out-of-order count rises a few percent. I did not find a
>   simple way to also suppress
>   that without re-opening the gating, and I did not want to over-build v1;
>   scoping it more tightly (for example only when send-buffer-limited) may be
>   the right call and I would defer to your lab on it. Second, I have only
>   exercised two subflows and no backup subflow so far.
> 
> 3/3 adds two MPTcpExt counters (CwndPenalized, PenalCandidate) so a run can
> tell "the guard held the penalty back" from "the trigger never fired". Not for
> merge. I left your Co-developed-by on it in case it is useful to you elsewhere.
> 
> I drove those regimes with a small simult_flows variant (receive-window-
> limited, send-buffer-limited, and autotuned cases). It is a helper, not
> selftest quality, so I did not fold it into the series; it is on a branch of
> my tree, in case it saves your lab time or you spot a case I missed:
> 
> https://github.com/shardulsdk-mpiric/linux/blob/6926c4b7f583/tools/testing/selftests/net/mptcp/mptcp_sched_penalise.sh
> 
> Run it on a baseline and a patched kernel and compare (prefix with
> MPTCP_LIB_IP_MPTCP=1 if pm_nl_ctl does not work in your setup):
> 
>   SCENARIO=suite                              ./mptcp_sched_penalise.sh
>   SCENARIO=unbounded                          ./mptcp_sched_penalise.sh
>   SCENARIO=rwnd    RCVBUF=262144              ./mptcp_sched_penalise.sh
>   SCENARIO=sndbuf  SNDBUF=65536               ./mptcp_sched_penalise.sh
>   SCENARIO=both    RCVBUF=262144 SNDBUF=65536 ./mptcp_sched_penalise.sh

Sounds good! Did you check with a fixed sndbuf higher than the rcv one?

Also, be careful that with netem, the limits you give to run_test() can
influence a lot the bufferbloat. Did you monitor the RTTs during these
transfers?

On the other hand, it would be good to validate this with one path
having bufferbloat. These patches should also help to improve the
situation. (And issue #332 should help even more)

> For the rwnd/sndbuf/both scenarios the simult_flows pass/fail bound is not
> meaningful (it assumes both paths are fully used): read the printed runtime
> and out-of-order counts, not OK/FAIL. The "both" case also occasionally fails
> to bring up the second subflow with the very small SO_SNDBUF; just rerun it if
> you see a single-subflow run.

I see, yes. I think what is important here for #345, is that when the
transfer is buffer limited, the slow subflow impact should be reduced.
At least not to cause the transfer to be worse than without this slow
subflow.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

