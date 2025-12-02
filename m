Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E16330648A
	for <mptcp@lists.linux.dev>; Tue,  2 Dec 2025 11:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764673404; cv=none; b=tiQyCzHxJedfRVy3vQFCsciRprVkJX8OkxcrBmxGHMqmDJiYKAbPXWQljdZnfyCuAwu1yKqJnMXN03oIeNzCcXeaB5yFP6KD+VZ4crWR1v1eN1CqM/rWWrqrzJ1tgc5S79H4Eq7gC4CNKMGokAl863D6OeuClQ2Zk+juWTHMoCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764673404; c=relaxed/simple;
	bh=lLcCD/6bKj619eT+yLxmwIbCa/yqhgrV4oCeq4oudt0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=nWP3/FyFD1+DWi7g93p1Qxhh8wJ3YMxePXwaMi539yeqoV3SEiiDtd/B0JBZxvG/1+vta1wmQP01BnxPv1p0mTXZjWDeZ/S9XwlJzUAWF2LgfGtpkXegjb3ZYSpPM5PMN01y4hyib++1AMfWgowH605Pfcr2K0hRhwu19h3GIwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H5xH7Twg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H5xH7Twg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 189EFC116D0;
	Tue,  2 Dec 2025 11:03:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764673403;
	bh=lLcCD/6bKj619eT+yLxmwIbCa/yqhgrV4oCeq4oudt0=;
	h=Date:Subject:From:To:References:In-Reply-To:From;
	b=H5xH7TwgxGUcsLepAsXakx9N/Qhs9oOvmvXaz71I6VZmCI0CD9sXz5hbMLqrcxE4A
	 qpFOpCfjq977lzL6d8DWbxq5neV+WoHBuedoKL7TVoe6e6GWoY4mJ5gXE1BIrhZysg
	 OpogvgKimcDrsX798WGTIrojcIKtPVgmZd/qphDv70fMuH/R1t7lDwZ9eN8om0vAVx
	 zdhO9HJIWTJ926Xhj32IH4jqfsSfPRG5AQzdMcnjduVYmuG9Thcic4HTDGo/7KaLSF
	 alFw3Q6ovRsELUlvdEsNomsnYK9FGxmTtDCI3NU1F0xRxCWKq7dDe1RCzmCzfrBEtb
	 eR4tqejM6Kz5Q==
Message-ID: <25ab27c2-28e4-4604-bf9b-c17661c032da@kernel.org>
Date: Tue, 2 Dec 2025 12:03:20 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-net] mptcp: fallback earlier on simult connection
Content-Language: en-GB, fr-BE
From: Matthieu Baerts <matttbe@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
References: <36b926c5d55933a6f2d2a7f6ff8d8a091c0de719.1764332508.git.pabeni@redhat.com>
 <fdf749ae-ec10-4809-957e-be2737241650@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <fdf749ae-ec10-4809-957e-be2737241650@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo,

On 01/12/2025 18:35, Matthieu Baerts wrote:
> Hi Paolo,
> 
> On 28/11/2025 13:22, Paolo Abeni wrote:
>> Syzkaller reports a simult-connect race leading to inconsistent fallback
>> status:
> 
> (...)
> 
>> The TCP subflow can process the simult-connect syn-ack packet after
>> transitioning to TCP_FIN1 state, bypassing the MPTCP fallback check,
>> as the sk_state_change() callback is not invoked for * -> FIN_WAIT1
>> transitions.
>>
>> That will move the msk socket to an inconsistent status and the next
>> incoming data will hit the reported splat.
>>
>> Close the race moving the simult-fallback check at the earliest possible
>> stage - that is at syn-ack generation time.
> 
> Good idea!
> 
>> Fixes: 23e89e8ee7be ("tcp: Don't drop SYN+ACK for simultaneous connect().")
> 
> From what I understand, the modification on TCP side is needed for this
> fix. When reading its commit message, it sounds it should have contained
> a Fixes tag, but net-next was chosen to delay the fix. Is that correct?
> 
> If yes, should I ask to backport this other commit with this patch? Or
> should this patch be backported only up to stable trees already having
> this other commit?
> 
>> Fixes: 4fd19a307016 ("mptcp: fix inconsistent state on fastopen race")
>> Fixes: 1e777f39b4d7 ("mptcp: add MSG_FASTOPEN sendmsg flag support")> Reported-by: syzbot+0ff6b771b4f7a5bce83b@syzkaller.appspotmail.com
>> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/586
>> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
>> ---
>> @mattbe: could you please test vs yours syz repro?
> 
> In progress!

Sorry for the delay, I had some issues with my setup.

I can still reproduce with your patch and my reproducer. I have added
more details on:

  https://github.com/multipath-tcp/mptcp_net-next/issues/586

I can easily reproduce it now, and the issue might be slightly different
from the one identified by syzbot.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

