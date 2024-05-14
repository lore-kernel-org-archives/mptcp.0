Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 810BB1DFD1
	for <mptcp@lists.linux.dev>; Tue, 14 May 2024 21:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715721086; cv=none; b=q0mDHTsyOUNhjdwvOPHC4B1nseV5yDbJbv7QVRZsCwFaYsmNh0EDxcFkzjGm0EPH5v8Qm27AlAsZH7kWr+xpUD0ib4h+kbly6+8BRT1IPMvyJfKuvoEdy4W3uk83q3qz9/0XyNYLOK9WxKmZlLNsiJ/WvUPXuRH6EmjCq6WBhWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715721086; c=relaxed/simple;
	bh=zVwPG2BSEBGLzXXjnB2eSCXJlgFxXw3d+LQcSegisb0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=azLrWEMsMleVZ/2325qTMDaneSieLXuU67OfzdXPkYZEVLJ3h0zm9+rINa7vfhSX3535+GukZVBQ6HkYJwwWz5ABy0d2Uv7Be41JLHE0wQVExmVDJAgDLTg/SBXL7/K4eHBCrHWzx64XeCD8BgTb1aANEw2yzOxDBZT5eyAeAk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PsSd4YI3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PsSd4YI3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CDC3C32782;
	Tue, 14 May 2024 21:11:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715721086;
	bh=zVwPG2BSEBGLzXXjnB2eSCXJlgFxXw3d+LQcSegisb0=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=PsSd4YI3ecfzOPlaE8GxskBkalQhLTy/bqyM62kv/Miy2Kb6s08DGGPi42r/9+SLX
	 h5rjxlCFUvZHlwKbrn33fPIMLc4y8OvIN/8mtU3uWWVtYrQ1XK3N9kEQLdD+uvHVyO
	 aUnjgPgnN0nXHRWUI7Z8IExd8OBBg9Jadcz3BNc8SzyMWYs8Wm4NZMbx3+3oW1wCXA
	 sHPansNdtydO0omJtp6QSuou57YzGLPteOS1dAjrDjUueDDYghZrHbb4GLqKGgoyaE
	 ZULfAxjSTxhqLprCGvi5Xtr5QA8Xtk1/OrlTawK/MuRXyyBweKH+Q3/zzHOxBY2c1t
	 a4aFIJ0t7vnHA==
Message-ID: <f8a1596d-77d1-409e-9dfb-c43462e3f968@kernel.org>
Date: Tue, 14 May 2024 23:11:22 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: pull-request: bpf-next 2024-05-13
Content-Language: en-GB
From: Matthieu Baerts <matttbe@kernel.org>
To: Geliang Tang <geliang@kernel.org>
Cc: MPTCP Upstream <mptcp@lists.linux.dev>
References: <20240513134114.17575-1-daniel@iogearbox.net>
 <a7cd8362-a091-4df9-827b-73887c690308@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <a7cd8362-a091-4df9-827b-73887c690308@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 14/05/2024 22:47, Matthieu Baerts wrote:
> Hi Geliang,
> 
> On 13/05/2024 15:41, Daniel Borkmann wrote:
>> Hi David, hi Jakub, hi Paolo, hi Eric,
>>
>> The following pull-request contains BPF updates for your *net-next* tree.
>>
>> We've added 119 non-merge commits during the last 14 day(s) which contain
>> a total of 134 files changed, 9462 insertions(+), 4742 deletions(-).
>>
>> The main changes are:
> 
> (...)
> 
>> 8) Another batch of improvements to BPF selftests to retire obsolete bpf_tcp_helpers.h as
>>    everything is available vmlinux.h, from Martin KaFai Lau.
> 
> These modifications are causing issues on our side: bpf_tcp_helpers.h
> was modified, mainly to access to more items from structures. The prefer
> way is to rely on vmlinux.h, see [1]:
> 
> For the sync, I then resolved conflicts:
> 
> - 5a4748274773: conflict in t/selftests-bpf-Add-mptcp-sched-structs
> - 16e27bc205f2: conflict in t/selftests-bpf-Add-bpf_rr-scheduler
> - 6e4457a51a02: conflict in t/selftests-bpf-Add-bpf_burst-scheduler
> 
> But then we need to adapt the code, not to rely on bpf_tcp_helpers.h. I
> started that, see [2]. The code compiles, but the tests fail to run. It
> is too late for me to investigate. If by chance you have an idea what's
> wrong, don't hesitate to share that with me. If not, I will try to
> continue looking at that tomorrow.

When doing something else, I think I found what I did wrong. Please tell
me if you see any issues with the new version:

  https://github.com/matttbe/mptcp_net-next/commit/b2fa488b5155

Except that now, I think we hit issue #487 quicker:

  https://github.com/multipath-tcp/mptcp_net-next/issues/487

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

