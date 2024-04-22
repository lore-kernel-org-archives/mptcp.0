Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09218145FE8
	for <mptcp@lists.linux.dev>; Mon, 22 Apr 2024 10:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713782401; cv=none; b=VOjHOutHleVsDsMNhc3L1vYVqEqaGhb3BkozrYFHnuMwycq/NQ3K2ukk41IFuCbcvR2uf2cuJ6aypoRkLwvCYuXSfHkd0gnUGk//HKNZ3brTOk81vxP8EJPqwmluXRPCJgH4nQLYR//VFU7lr1BBZwqPpd0GIalps0EUZulH2nU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713782401; c=relaxed/simple;
	bh=k07GGGGw73NI4ykfphepd7Xa+ZUYGIiVGLbCho333GI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Uh2clsoZ3Z9jDZ2ysuh1GMasDCkCiiHfHuYu9tc9W0Tf/gkyIVemNS+q5//2I8SS52iY0DnAcsm2pPcfbxbvP7tQxwDfdQ+6DRNl4vLEBV7FQPvfHex+bS4D8a5v/taigynfpc1CUd+x0GoftEcFmiKrxF4nkz1pPPFxTAJ5YnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jg+DlrDs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jg+DlrDs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF831C113CC;
	Mon, 22 Apr 2024 10:39:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713782400;
	bh=k07GGGGw73NI4ykfphepd7Xa+ZUYGIiVGLbCho333GI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Jg+DlrDsfrw0bx7jbAV5DCqGUIbS4iy0h/HY7unEZn1U4EODJIodDTAQIRFRaCod2
	 ZdZagtaz+PH+r0fJSpjjRFvtLw3WQESOSYeJONCXpBhqiIJaUbo4JpkmwDJM3OX0cf
	 dtkzeM28B1BwerubwWG3lpaXLrGsZ8zLFWCglBU9TKY7az4i6cbSDDiYn7Lnm0U+B4
	 bYz6lQHiNqIC1Kee5510XbZ/9moJkcAt1pSti8wTLlUsaDfl87pevxwHKWUlgCmeWd
	 +sks8alv15T1Tqz0KgL7LXiaQ26tSI9QwVk3jx0bC0RXL/XqRrYmh84X/RR9CJTDd9
	 8CGJkSDyUlBlQ==
Message-ID: <8a0b7902-4b75-47cc-a22b-d3b97ecac22d@kernel.org>
Date: Mon, 22 Apr 2024 12:39:58 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH bpf-next v4 3/3] selftests/bpf: Support nonblock for
 send_recv_data
Content-Language: en-GB
To: Geliang Tang <geliang@kernel.org>, Mat Martineau <martineau@kernel.org>
Cc: mptcp@lists.linux.dev
References: <cover.1712729342.git.tanggeliang@kylinos.cn>
 <9cd358958245f8ec87c4f553779aa4243f967a2f.1712729342.git.tanggeliang@kylinos.cn>
 <12aab271-da72-49b4-ac91-2091b6889856@linux.dev>
 <bec7ade6bfc99f6340fa231cf68f0f4459625dbe.camel@kernel.org>
 <9475c2259b3d32774bc1488dd0d6004f7ddfbf13.camel@kernel.org>
 <52673f90-84c6-4e3d-9967-a3d0a7335c46@kernel.org>
 <7732f129e5c1c2ff128878be9b865115e1319b85.camel@kernel.org>
 <0017e477-3fcd-45de-917b-b58b3781ca9b@kernel.org>
 <d0032920b64e075c5247b431ae48acc47232bff3.camel@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <d0032920b64e075c5247b431ae48acc47232bff3.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 22/04/2024 12:34, Geliang Tang wrote:
> On Mon, 2024-04-22 at 12:31 +0200, Matthieu Baerts wrote:
>> On 22/04/2024 12:04, Geliang Tang wrote:> On Mon, 2024-04-22 at 11:45
>> +0200, Matthieu Baerts wrote:
>>
>> (...)
>>
>>>> I might be wrong, but with MPTCP schedulers, it is different:
>>>> with
>>>> non-blocking IO, EAGAIN can be seen, and this case needs to be
>>>> handled.
>>>> Actively waiting by retrying directly in the loop in case of
>>>> EAGAIN
>>>> is
>>>> not recommended, but probably OK for the tests (still, might be
>>>> good
>>>> to
>>>> add a comment to recommend polling instead). So here as well,
>>>> such
>>>> modifications can stay in our tree for the moment.
>>>>
>>>> Also, what is not clear to me is where we set the socket as the
>>>> non-blocking one. Is it only done for MPTCP servers/clients?
>>>
>>> I didn't set the socket as non-block in the end.
>>>
>>> EAGAIN will be got no matter non-block flag is set or not.
>>
>> That's strange, no? When the userspace sends data with a blocking IO
>> socket, it should not get EAGAIN, no?
>>
>>> In old version like "[mptcp-next,v7,0/5] setsockopt per subflow:
>>> BPF":
>>>
>>> https://patchwork.kernel.org/project/mptcp/cover/cover.1712571740.git.tanggeliang@kylinos.cn/
>>>
>>> "set_nonblock" is added in patch 2, and invoked in run_subflow() in
>>> patch 3.
>>
>> I see, but the commit message of patch 2 doesn't explain why
>> set_nonblock() is needed for MPTCP. I see it is used in patch 3, but
>> is
>> it really necessary? Maybe it was added for other reasons, that are
>> no
>> longer valid today?
>>
>>>>> I added a issue #487 to trace this issue.
>>
>> Please also note that we didn't have this issue for a while. When we
>> had
>> it, it is when KVM was not supported on the CI:
>>
>>  $ /opt/virtme/virtme-run (...)
>>  Could not access KVM kernel module: No such file or directory
>>  qemu-system-x86_64: failed to initialize kvm: No such file or
>> directory
>>  qemu-system-x86_64: falling back to tcg
>>
>>
>> Maybe we had this issue because the VM was abnormally too slow, and
>> we
>> reached the 3 seconds timeout described by Martin in a previous
>> message?
>> If this is due to the "abnormally slow setup", maybe we don't need to
>> do
>> anything?
>>
>> In other words, can you (easily) reproduce the issue on your side?
>> With
>> or without KVM support?
> 
> It's easy to reproduce by increasing total_bytes:
Even without "set_nonblock()"? With what is in our tree, we don't do that.

As I mentioned above, if 'send()' stops before the end with -1 and errno
set to EAGAIN while the socket is supposed to wait for the transfer to
be over (blocking IO), I guess there is a bug somewhere, but not in the
tests, no?

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

