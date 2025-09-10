Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6CEB30F7F1
	for <mptcp@lists.linux.dev>; Wed, 10 Sep 2025 08:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757494614; cv=none; b=Ex5UvSktyP3nUjoI06TAes+OTSsJPDk1qwMV+yjaLFkUQUBqAW8I2WJ5jkXsv1kqF1LJZyISJRP+B3p3WEPUjDawwilXvCdzSTRCO6bl1xOtN6HjUGhV2PnukTVZX7vfufAf2ayEalWJHI1juDL6RkSHBk7RgeW07QZY81IzJok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757494614; c=relaxed/simple;
	bh=DD/vEiluEzBbdx4bXyWpg7i78Xv7DEwzIm5YUVmLHfM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=k0fChv+srHJtxwp0CgjqhLz5HLrVWhRY1yzKvsSInL6/gGrgJoX/3os55FZnJUPXGwpC+do0lBVY9yc2w4/FHnLnmm1t5OqQZWlb4VdHtEs4QWWx+butX0HzztafQBqrSt1GsbWMA2RLzQv1ILNfi8HGMXqpMa+cOCjESb8gd6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zia8wUGy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zia8wUGy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9776C4CEFA;
	Wed, 10 Sep 2025 08:56:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757494613;
	bh=DD/vEiluEzBbdx4bXyWpg7i78Xv7DEwzIm5YUVmLHfM=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=Zia8wUGyIVp4c/TbHDC0Y8DI2F4EYBdRsyqqqkBogw4AtlEkOaJMYlt53gaNRr89A
	 EQ78qljRvsea8Z2bZA44oYJKqd0IQ/qcInvbIHJQVFU7iyl6zbeG48dQ+6kr/nF24a
	 0H95gN193og5FoxYUev7gT4NkOHE9v37bYlRbNeuvYH3g9QJAh2mudwAMEM51rQyeh
	 beJeE/Y2FO9MoC5q2wLcjDCKAgu1h5znksN5dtpa/9ftZbdsEGlt2qXv0TmmR98ZG/
	 AsdwAqwgazU5TaLdKupSKRVUb69ZUCJpg9wfSdnicH5WTQoi4bdMDwRntNzaDJwS0B
	 +/hHvNQIH/nZg==
Message-ID: <6906f6ca-742c-4e06-8fa7-9bc996816525@kernel.org>
Date: Wed, 10 Sep 2025 10:56:49 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-net v2 2/5] selftests: mptcp: connect: catch IO
 errors on listen side
Content-Language: en-GB, fr-BE
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
References: <20250905-sft-mptcp-disc-err-v2-0-dfb3b6b4a877@kernel.org>
 <20250905-sft-mptcp-disc-err-v2-2-dfb3b6b4a877@kernel.org>
 <39e9e5644c96315181e19d5db1b2b44cb48fbf8a.camel@kernel.org>
 <cf2fe151-78d8-414c-adf5-6fd62e6a1f44@kernel.org>
 <a55a9d1b123dae37f0478072d9eda0f6e6be7078.camel@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <a55a9d1b123dae37f0478072d9eda0f6e6be7078.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Geliang,

On 10/09/2025 04:44, Geliang Tang wrote:
> Hi Matt,
> 
> On Sat, 2025-09-06 at 15:54 +0200, Matthieu Baerts wrote:
>> Hi Geliang,
>>
>> On 06/09/2025 01:49, Geliang Tang wrote:
>>> On Fri, 2025-09-05 at 20:18 +0200, Matthieu Baerts (NGI0) wrote:
>>>> IO errors were correctly printed to stderr, and propagated up to
>>>> the
>>>> main loop for the server side, but the returned value was
>>>> ignored. As
>>>> a
>>>> consequence, the program for the listener side was no longer
>>>> exiting
>>>> with an error code in case of IO issues.
>>>>
>>>> Because of that, some issues might not have been seen. But very
>>>> likely,
>>>> most issues either had an effect on the client side, or the file
>>>> transfer was not the expected one, e.g. the connection got reset
>>>> before
>>>> the end. Still, it is better to fix this.
>>>>
>>>> The main consequence of this issue is the error that was reported
>>>> by
>>>> the
>>>> selftests: the received and sent files were different, and the
>>>> MIB
>>>> counters were not printed. Also, when such errors happened during
>>>> the
>>>> 'disconnect' tests, the program tried to continue until the
>>>> timeout.
>>>>
>>>> Now when an IO error is detected, the program exits directly with
>>>> an
>>>> error.
>>>>
>>>> Fixes: 05be5e273c84 ("selftests: mptcp: add disconnect tests")
>>>> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
>>>> ---
>>>>  tools/testing/selftests/net/mptcp/mptcp_connect.c | 6 +++++-
>>>>  1 file changed, 5 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c
>>>> b/tools/testing/selftests/net/mptcp/mptcp_connect.c
>>>> index
>>>> 4f07ac9fa207cb08a934582b98d688d0b9512f97..c1586a7286123a509495ac3
>>>> 19fd
>>>> 624b98f0bfd18 100644
>>>> --- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
>>>> +++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
>>>> @@ -1112,6 +1112,8 @@ int main_loop_s(int listensock)
>>>>  	salen = sizeof(ss);
>>>>  	remotesock = accept(listensock, (struct sockaddr *)&ss,
>>>> &salen);
>>>>  	if (remotesock >= 0) {
>>>> +		int err;
>>>> +
>>>>  		maybe_close(listensock);
>>>>  		check_sockaddr(pf, &ss, salen);
>>>>  		check_getpeername(remotesock, &ss, salen);
>>>> @@ -1125,7 +1127,9 @@ int main_loop_s(int listensock)
>>>>  		SOCK_TEST_TCPULP(remotesock, 0);
>>>>  
>>>>  		memset(&winfo, 0, sizeof(winfo));
>>>> -		copyfd_io(fd, remotesock, 1, true, &winfo);
>>>> +		err = copyfd_io(fd, remotesock, 1, true,
>>>> &winfo);
>>>> +		if (err)
>>>> +			return err;
>>>
>>> The file descriptor (fd) should be closed before returning.
>>
>> I do agree it would be better to do so, but when you look in this
>> file,
>> most errors paths don't close the FD, because that's the exit path.
>>
>> 'fd' will need to be closed, 'remotesock' as well, but same when it
>> was
>> not possible to create 'fd'. Also, I guess 'listensock' is never
>> closed.
>> Honestly, I don't think we need to increase the complexity, and close
>> them, just for the tests. It would be different if the FD were reused
>> later on, but I don't think we need to spend time on these details
>> when
>> this test program is about to close.
> 
> What I mean here is not to return directly, something like:
> 
> '''
> int err = 0;
> 
> if (remotesock >= 0) {
>     ... ...
>     err = copyfd_io(fd, remotesock, 1, true, &winfo);
> }
> 
> if (cfg_input)
>     close(fd);
> 
> if (!err && --cfg_repeat > 0)
>     goto again;
> 
> return err;
> '''
> 
> WDYT?

I do agree it is better. But again, I think there is no need to do that
in this patch, because most error exit paths in this file don't close
the fd's. That makes the patch longer and slightly more complex -- which
can cause more troubles during the backports -- just for the exit error
path. But because I keep being reminded by net maintainers that this
series is needed to fix CI noises (and real issues), I want to move on,
and I'm going to send a v3 with this modification.

> I will send a patch to close remotesock and listensock later.
> 
> Thanks,
> -Geliang
> 
>>
>> Cheers,
>> Matt

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

