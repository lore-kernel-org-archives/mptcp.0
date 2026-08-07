Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CD1EEEB3
	for <mptcp@lists.linux.dev>; Fri,  7 Aug 2026 16:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786119009; cv=none; b=a77jej/mfY6tp6Hn+3IfbE6BUWcmzX6I32wh3HgZ9T0f956y1znrNmtq11KgPujBMyHbPPiRSQBKXhi2nLRIyE+2LhLUGINNvCloVrIEtbA9koAwPfH2AtMM9EoXo1U81nutjHq8xU+NAB3WBtNsc+hubhelFWDNEQ0Cu7wBQH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786119009; c=relaxed/simple;
	bh=IKFFXdNiWpjDg0C/NmE0fhU2cpXbXrBHoLtXvQYXTQU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dJi81IJrYvo1hMnpljmmJL/u6ZUELYh9JcAy3Zir5VnGg3GGSMSUmmxKQOgewqqaceG9ygTGPP3wV9RJCum+sQk018hrXpkuYB59QFMk8zYhNqAejdTzijmFQpTK20b6u8s+AHXmgKsVu2VfcUeQPmFSmuJ1v2lNGLAmWEmJEPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GX3hxIFN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GX3hxIFN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 724271F00A3A;
	Fri,  7 Aug 2026 16:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786119008;
	bh=/mtwTs+TF8sAJqYaT74DDfXopTI7JcDDiLp4HGm56eE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=GX3hxIFNBUIJn2ZTaH0GHA/FF1zMXq98PVqpVjnz5/wqnytYNF4LMp1cjRmc/avrE
	 t2Ohk7g4ndZnfyhdrI9D7XjwvHo250Vmvdf+7xITBCxkuot6ky0AjHlvHog+Yw6hrl
	 stjIHk5uwhUKYSo/oUfkZC0pQOXhw0d7c1DyqWrsFebdWmdaaa7mL7hwYwBLlM1G2+
	 xOeeU6aN6q81EAE0FBjKllYoMeGzGD1Zw6N0ylTsLx6OXLPLPOyC3/Kv1uZnY1tai9
	 A8akmw2z3Rh6V9VK8p9BRVO4aYzpcLitmTcmHuPSHnQjU4K1LLWPW4aAcQ+ZTKCQoz
	 vkcr1Ews2ZICQ==
Message-ID: <c4180506-a5a8-40c0-87db-a33a61ca0fe3@kernel.org>
Date: Fri, 7 Aug 2026 18:10:06 +0200
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
Cc: MPTCP Linux <mptcp@lists.linux.dev>
References: <20260726-mptcp_penalise_send-v1-0-84485e0e995b@mpiricsoftware.com>
 <1a0d5c3b-05ef-4dbf-bb34-3141ad3d6f58@kernel.org>
 <745def4591c1b3b35ace0719159fe2c6cbbab467.camel@mpiricsoftware.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <745def4591c1b3b35ace0719159fe2c6cbbab467.camel@mpiricsoftware.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Shardul,

Thank you for your reply!

On 07/08/2026 17:17, Shardul Bankar wrote:
> Hi Matt,
> 
> On Wed, 2026-07-29 at 13:48 +0200, Matthieu Baerts wrote:
>> Hi Shardul,
>>
>> On 26/07/2026 07:55, Shardul Bankar wrote:
>>>
>>>
>>> - 2/3 is a guard that is in neither the fork nor what I described.
>>> Without it,
>>>   1/3 regresses badly (about 2x slower in my runs) when the
>>> connection is
>>>   receive-window-limited. In that case the fastest path is capped
>>> by the same
>>>   shared window, so it cannot absorb what the slow path gives up,
>>> and halving
>>>   just sheds the slow path's throughput. 2/3 skips the penalty
>>> while the
>>>   application has queued past the send-window edge (write_seq >
>>> wnd_end), which
>>>   is the sign that the receiver, not our congestion window, is the
>>> bottleneck.
>>>   I kept it a separate patch so you can test 1/3 on its own, or
>>> drop or retune
>>>   2/3 independently. The exact condition is the piece I would most
>>> value your
>>>   lab checking.
>>
>> It feels to me that you require this because patch 1/3 doesn't check
>> if
>> the MPTCP connection was "send-buffer-limited", no? But you are doing
>> something very similar, no? Without testing, it feels like this is
>> required not to limit the penalisation to when it is really needed.
>>
> 
> Patch 1 does gate on load, with tcp_is_cwnd_limited(); though that is
> not the send-buffer-limited check. The send-buffer-limited check never
> fires at scheduler time in this tree, as the msk buffer has just
> drained into the subflows. Patch 2 guards the receive-window-limited
> case, where patch 1 without it can regress the transfer about 2x in my
> tests. I have kept it as the explicit guard and am still characterizing
> when patch 1 alone would suffice. Would you prefer we drop it?

Dropping it, no, but I was more thinking about squashing. But fine to
keep it separated (but within the same series) for now or even for the
final version if that helps with the explanations and reviews.

>>> I drove those regimes with a small simult_flows variant (receive-
>>> window-
>>> limited, send-buffer-limited, and autotuned cases). It is a helper,
>>> not
>>> selftest quality, so I did not fold it into the series; it is on a
>>> branch of
>>> my tree, in case it saves your lab time or you spot a case I
>>> missed:
>>>
>>> https://github.com/shardulsdk-mpiric/linux/blob/6926c4b7f583/tools/testing/selftests/net/mptcp/mptcp_sched_penalise.sh
>>>
>>> Run it on a baseline and a patched kernel and compare (prefix with
>>> MPTCP_LIB_IP_MPTCP=1 if pm_nl_ctl does not work in your setup):
>>>
>>>   SCENARIO=suite                             
>>> ./mptcp_sched_penalise.sh
>>>   SCENARIO=unbounded                         
>>> ./mptcp_sched_penalise.sh
>>>   SCENARIO=rwnd    RCVBUF=262144             
>>> ./mptcp_sched_penalise.sh
>>>   SCENARIO=sndbuf  SNDBUF=65536              
>>> ./mptcp_sched_penalise.sh
>>>   SCENARIO=both    RCVBUF=262144 SNDBUF=65536
>>> ./mptcp_sched_penalise.sh
>>
>> Sounds good! Did you check with a fixed sndbuf higher than the rcv
>> one?
>>
> 
> Yes (SNDBUF 256K, RCVBUF 128K). The guard correctly suppresses the
> penalty there: the receiver is genuinely at a zero window (receive-
> window-limited, not congestion-limited), and it is not slower than
> baseline.

Nice, thank you!

>> Also, be careful that with netem, the limits you give to run_test()
>> can
>> influence a lot the bufferbloat. Did you monitor the RTTs during
>> these
>> transfers?
>>
> 
> I do now. The harness samples the subflows' srtt, and it confirms your
> point: the netem queue length drives it (srtt max is about 40 ms with
> the fast path alone, rising to several seconds on a bufferbloated
> path).
> 
>> On the other hand, it would be good to validate this with one path
>> having bufferbloat. These patches should also help to improve the
>> situation. (And issue #332 should help even more)
>>
> 
> I added a bufferbloated-slow-path case, but it was too noisy to draw a
> firm conclusion: the completion times swung widely, and the same swing
> was on the baseline kernel, so my setup is not measuring the effect
> cleanly. I would build a more controlled bufferbloat case (a moderate,
> stable queue, and a latency metric rather than completion time). I
> agree #332 is likely the bigger lever there.

Indeed, that's where my lab would be handy (but not ready yet, keep
being delayed by "urgent fixes"...)

>>> For the rwnd/sndbuf/both scenarios the simult_flows pass/fail bound
>>> is not
>>> meaningful (it assumes both paths are fully used): read the printed
>>> runtime
>>> and out-of-order counts, not OK/FAIL. The "both" case also
>>> occasionally fails
>>> to bring up the second subflow with the very small SO_SNDBUF; just
>>> rerun it if
>>> you see a single-subflow run.
>>
>> I see, yes. I think what is important here for #345, is that when the
>> transfer is buffer limited, the slow subflow impact should be
>> reduced.
>> At least not to cause the transfer to be worse than without this slow
>> subflow.
>>
> 
> Using that as the bar: when send-buffer-limited, the penalised two-path
> transfer beats the fast path alone (about 11.3 s against 14.4 s), with
> roughly 15 to 20% less out-of-order data, so the slow subflow helps.
> When it is bufferbloated, it comes out about even with the fast path
> alone.

Excellent!

> I have all of these changes ready in my tree. I would rather settle
> whether patch 2 stays (above) and the counters question on 3/3 before I
> post v2, but I am glad to send v2 now if you would prefer to look at
> the code directly.

See my other replies, but in short:

 - patch 2 can stay or not, up to you
 - extending the tracing and keeping the counters (at least "Penalized")

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

