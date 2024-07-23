Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE5E7136E3B
	for <mptcp@lists.linux.dev>; Tue, 23 Jul 2024 14:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721744146; cv=none; b=Askt2j17OfgAFHExx3en34/eTTTnAbgEIYPqwnY4DHpu6Nn8dNPbuXRN7qKaJZNY+u6HW8TC86h8hAZEr9tnnNhmMchP4ZiNBtSWySWDqnKCsqxJkLhkxRuAgmLkjAofkd0RiNHD3gsc/AK/PyG/nLFCG2cbFpvdklfIBe65cDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721744146; c=relaxed/simple;
	bh=grdUoVjODQF5ibxZKkUuCAcSNLGdfZV6ZrkXk8ZNkaw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UVdvUrLNqgBJHGkNI6zeGewvysb1FXVNQJA12TOYaP8k4OHerxoBdQweDga/xAsKLDfP2ARwHxSDn24SBzQq28PKSQUAXwmecY9aJkrYc2gEG8keuen9f9ZFCS3/OcXexjgwIWP+0WHhf3LCTmtMWpMffUNNqki4qfE0xSn2xIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ew5oJlxW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ew5oJlxW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBA68C4AF12;
	Tue, 23 Jul 2024 14:15:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721744145;
	bh=grdUoVjODQF5ibxZKkUuCAcSNLGdfZV6ZrkXk8ZNkaw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ew5oJlxWJ0M0aSSb+m2AFEZv7FKbYsljYMorE1UKUfJcruQjeyjueNoPb0A0F6t4B
	 huiyOCZMaBkfpAAqqdbcXitT2hTDh6oFy1Z2RMAi7wcdIszwGeZYreEaxbL9xxI/SL
	 LzMdgKjfrXHhxaCj7Hgy2nolCLJQujtN87n/tJoypoHO1wHVzCarKEOe7CB2gsihCO
	 sNOc3PE+w9d37KRb8WDtvIlFGAIiJCQYOk7eaxgL/u37LcLZ4fk/hd8giClKrUb8/e
	 oSlbljLgjlww3tPraTwyndB7KleMA/b/XQDtDnWsoderCKIe7M5XXbTzuM0qOWbUeI
	 7oDq74djBb1Gw==
Message-ID: <6be2da59-f589-46cb-b50c-f13dd6944d65@kernel.org>
Date: Tue, 23 Jul 2024 16:15:41 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-net v3 0/9] mptcp: fix inconsistent backup usage
Content-Language: en-GB
To: Mat Martineau <martineau@kernel.org>
Cc: mptcp@lists.linux.dev
References: <20240718-mptcp-backup-mpj-v3-0-1f6cd9b89ee4@kernel.org>
 <a59b9b6a-0c6b-0918-415e-378a482b3d6b@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <a59b9b6a-0c6b-0918-415e-378a482b3d6b@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Mat,

On 23/07/2024 02:24, Mat Martineau wrote:
> On Thu, 18 Jul 2024, Matthieu Baerts (NGI0) wrote:
> 
>> In all the backup tests we have, the backup flag is set on one side, and
>> the expected behaviour is to have both sides respecting this decision.
>>
>> On the scheduler side, only the 'backup' field is checked, which is
>> supposed to be set only if the other peer flagged a subflow as backup.
>> But in various places, this flag is set when the local host flagged the
>> subflow as backup.
>>
>> One last thing that has been fixed is the backup flag in 'signal'
>> endpoints: it was working only when setting the backup flag while the
>> connection was already opened. That's what the MPJ selftests were doing
>> to check that the signal endpoint were supporting the backup flag (on
>> purpose I guess, because the support was broken in MP_JOIN...).
>>
>> The last two patches adapt the BPF selftests to mimic what is now done
>> by the in-kernel packets scheduler.
>>
>> Note that the Packetdrill tests need to be updated because the behaviour
>> has been changed / fixed:
>>
>>  https://github.com/multipath-tcp/packetdrill/pull/152
>>
>> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
>> ---
>> Changes in v3:
>> - Small fixes in patch 1 and 5: see the individual ChangeLog
>> - Use a new dedicated helper in patch 6: see the individual ChangeLog
>> - Link to v2: https://lore.kernel.org/r/20240716-mptcp-backup-mpj-
>> v2-0-4d50247405fb@kernel.org
>>
> 
> Hi Matthieu -
> 
> v3 LGTM. I'm not sure if the new MIBs are best targeted for net-next,
> they do help with testing but don't seem critical for -stable.

Indeed. My reasoning was that the MIB counters were not there, mainly
because this behaviour has never been verified. At the end, it is only
10 new but well controlled lines :)

I suggest applying them in our tree, and delay them if they got
rejected. At the end, the new MIB counters and the tests are well
isolated, and with a note about that.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

