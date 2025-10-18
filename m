Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4272A34CDD
	for <mptcp@lists.linux.dev>; Sat, 18 Oct 2025 00:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760746589; cv=none; b=dDCdLH6hQki5f1z0e7bvcegR5wynu2N6bSmY5aZ3euYIFtQeXl+RhrTH7O9+p+eQ6ZE+S5ukco3X2hdURRIeWSRX9nD2r1QAeTOh9Fw3WyxZd/Ji5webS97UcCYB17QJsIErdyVo1UJFrFAkn/ZMRCig3KtqEXvOvmQtu5fko7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760746589; c=relaxed/simple;
	bh=tffh3NT9wZET9SeG2m0qw3J5js+FrXIxuPgBPjXemzM=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=I7lgzH8X761kMjBQqHj/i5WWxGxT5UsCVJRO7mphcfT1cYIuAfQpjaHl5UyWF9SeNT4uX4nfuqeRtAXnye2l/8Ql5U/Y8B66VulxN/6N9OZCKYwWfCRbzCiQpQf2YXCJ4XtEkEjqBhnQGNpeOxM9D8MqgTX9TaMXLibk+J1BYMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MDpPD8b8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MDpPD8b8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B3C5C4CEE7;
	Sat, 18 Oct 2025 00:16:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760746588;
	bh=tffh3NT9wZET9SeG2m0qw3J5js+FrXIxuPgBPjXemzM=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=MDpPD8b8syHlmdSJDp5lhgTfTbKBhaez1a4RqIToK2O1iFiVXFBTjTLoN3+uYSfAM
	 1BnLG4ajF9jdRQBhE/rKW1kWHOuS5qe4kZSv7shKNzHaNOWZfz7VSojNEJslBvUjbm
	 63HyAdPEyHdTy1EuAu2nG/gsxz8b26kAcOXs/DfgubuH5YxW4MHojynpNnvazCV3nS
	 MSx1jvT5Zj7Q0UHLk0ejh8XAJFLUmSgAf3Uq6iVRHluyw33y+4+yGdjbQq0jcHkfxK
	 Arjk9uJVAiIN2b9jsNmFjRBDP1oOa2mlRQtt8ze2Vm2S/8kcGGhLWj0qE03RdJO2CQ
	 khR7sI1a1f7Zw==
Date: Fri, 17 Oct 2025 17:16:27 -0700 (PDT)
From: Mat Martineau <martineau@kernel.org>
To: Geliang Tang <geliang@kernel.org>
cc: Paolo Abeni <pabeni@redhat.com>, Matthieu Baerts <matttbe@kernel.org>, 
    mptcp@lists.linux.dev
Subject: Re: [PATCH v5 mptcp-next 00/10] mptcp: introduce backlog
 processing
In-Reply-To: <fc39dd4b9b36334ad52ba3e0940e642db4a560ee.camel@kernel.org>
Message-ID: <cf0833e9-03a0-8040-bd65-113432ed626e@kernel.org>
References: <cover.1759737859.git.pabeni@redhat.com> <2c9f131e-ef34-4916-8aab-e1420e1ae90b@kernel.org> <d0a814c364e744ca6b836ccd5b6e9146882e8d42.camel@kernel.org> <b90e5899-6473-4b3b-a239-9202c2e2cb03@redhat.com> <2389029f56a9fa496b59be7655987e6d9c6362f2.camel@kernel.org>
 <8a8feb1d-ad10-4ba4-a448-db8a0e45c7c3@redhat.com> <c53540268cb422a14d38745c6d0bdb440deb7c11.camel@kernel.org> <6d3545fc-f342-4532-b1c3-fb96d9c79fe6@redhat.com> <e759f7f6-b90f-4663-9ab4-040f76c2bbba@redhat.com> <53ed629a-d364-470f-8a52-5a34692f0da7@redhat.com>
 <20a3df573803203df6b672d1ecd606e242e84b20.camel@kernel.org> <ef0495fe4e1012bb4b68a72361bdeb39872d96b6.camel@kernel.org> <281e24d1-da6a-493e-9d12-66bd3cdd7ed4@redhat.com> <fc39dd4b9b36334ad52ba3e0940e642db4a560ee.camel@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-570250240-1760746588=:34278"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--0-570250240-1760746588=:34278
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Fri, 17 Oct 2025, Geliang Tang wrote:

> Hi Paolo, Matt, Mat,
>
> On Wed, 2025-10-15 at 11:00 +0200, Paolo Abeni wrote:
>> On 10/13/25 11:07 AM, Geliang Tang wrote:
>>> On Fri, 2025-10-10 at 20:22 +0800, Geliang Tang wrote:
>>>> Hi Paolo,
>>>>
>>>> On Fri, 2025-10-10 at 10:21 +0200, Paolo Abeni wrote:
>>>>> On 10/9/25 3:58 PM, Paolo Abeni wrote:
>>>>>> @Geliang: if you reproduce the issue multiple times, are
>>>>>> there
>>>>>> any
>>>>>> common patterns ? i.e. sender files considerably larger than
>>>>>> the
>>>>>> client
>>>>>> one, or only a specific subsets of all the test-cases
>>>>>> failing, or
>>>>>> ...
>>>>>
>>>>> Other questions:
>>>>> - Can you please share your setup details (VM vs baremetal,
>>>>> debug
>>>>> config
>>>>> vs non debug, vmg vs plain qemu, number of [v]cores...)? I
>>>>> can't
>>>>> repro
>>>>> the issue locally.
>>>>
>>>> Here are my modifications:
>>>>
>>>> https://git.kernel.org/pub/scm/linux/kernel/git/geliang/mptcp_net-next.git/log/?h=splice_new
>>>>
>>>> I used mptcp-upstream-virtme-docker normal config to reproduce
>>>> it:
>>>>
>>>> docker run \
>>>> 	-e INPUT_NO_BLOCK=1 \
>>>> 	-e INPUT_PACKETDRILL_NO_SYNC=1 \
>>>> 	-v "${PWD}:${PWD}:rw" -w "${PWD}" --privileged --rm -it
>>>> \
>>>>         --pull always ghcr.io/multipath-tcp/mptcp-upstream-
>>>> virtme-
>>>> docker:latest \
>>>> 	auto-normal
>>>>
>>>> $ cat .virtme-exec-run
>>>> run_loop run_selftest_one ./mptcp_connect_splice.sh
>>>>
>>>> Running mptcp_connect_splice.sh in a loop dozens of times should
>>>> reproduce the test failure.
>>>>
>>>>> - Can you please share a pcap capture _and_ the selftest text
>>>>> output
>>>>> for
>>>>> the same failing  test?
>>>
>>> The pcap captures (gQQ13x-ns1-ns3-MPTCP-MPTCP-dead:beef:3::2-10013-
>>> connector.pcap, gQQ13x-ns1-ns3-MPTCP-MPTCP-dead:beef:3::2-10013-
>>> listener.pcap) and the selftest text output (selftest_output) are
>>> attached.
>>
>> Looks like the 'stuck' scenario is quite consistent. The receiver
>> filled
>> it's receive window, and sent an ack shortly after when re-opening,
>> but
>> the sender did not react to such ack.
>>
>> The perf instrumentation I mentioned would be very useful. I tried to
>> capture it myself, but so far I failed - the repro run for several
>> hundred iterations without issues and finally podmad stuck (podman
>> bug
>> apparently, or local resources exhausted).
>>
>> Did you have better luck collecting the perf trace?
>
> Sorry, I haven't made any progress yet. Please give me some more time.
>
>
> I was thinking, since this issue only occurs during the splice test,
> let's move the discussion to the future "implement mptcp read_sock and
> splice" series. We shouldn't let it block the merging of this current
> series.
>
> I don't have any further constructive review comments on patches 9 and
> 10. I'm wondering if we should get input from Matt and Mat.
>

I am planning to take a close look at 9 & 10 early next week, would like 
to understand the new backlog rx path. Sorry for the delay!

- Mat

--0-570250240-1760746588=:34278--
