Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD86C29ACC3
	for <mptcp@lists.linux.dev>; Wed, 10 Sep 2025 17:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757523614; cv=none; b=ta035Y41EEHQ7YVGZNmWF60D55HJhaXLDcuZ7y1viFkMgLM78/2C9ovLLuwLxnQdZOWakXMVG0zD5ZmAQVDMvJacvbH4cTsQUnllGg1gLdL4iHSS+DDqWEawnehJtG2u0JNQlbhpsPiR6MzQvw3Kj4wdBHInb3wowHX+5T3bL5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757523614; c=relaxed/simple;
	bh=rYwSHBfz4zcpqBoMpWmSP4CgfxNaS/eIZy5R8qo4phA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q87tTlLuVpG0H6Ljdmno75CSlX8BgaYwiqV422fhDd5UdC5DBGhnjaMz3Xw+zneW+DgRkXZi2N2R8NvI32lkaSOH833pmhL527Yyern8JGtJFktdvfkO6IqiVff+GGZ5T+YlbguJ8okBY3sbzvqQNiHt8KXCgTphEN4zadej+GU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tcd9WbDL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tcd9WbDL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3F38C4CEEB;
	Wed, 10 Sep 2025 17:00:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757523613;
	bh=rYwSHBfz4zcpqBoMpWmSP4CgfxNaS/eIZy5R8qo4phA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=tcd9WbDLC8tRrZRcdcM+SV7sQ7R9V0QSfw72X98IBRj7pph77/j0jqvONWjv8oNBk
	 XXviPZw6USMBcPCCEWlf0P7T+zdfz4uWxOyC1D239kDYw0fExaeM2zyOSs5B9KoBVe
	 XATKgeYW8Xbjh9aFxr+uZzgaoUapXBoVhOELNI7OhQHY1LPIzyOPc+J5dAWO0wQQpY
	 btOBEHtfQSdZqq5xZDUxH/A51cTDg7aZ6c229zF2VXFJTLxePVo919r6HU0YwSZ60g
	 7PXRYRVCv/oZWTfHuWIAM6sOibe60z/rxDTt9mBOW5uv1H1/Umz11XIiaQ4mYmpVhh
	 o+dLqsxlAc28g==
Message-ID: <76dd22aa-7071-4f55-a8ed-21283bf8c2cf@kernel.org>
Date: Wed, 10 Sep 2025 19:00:10 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-net v2 2/3] selftests: mptcp: close IPC descriptor
 on server side
Content-Language: en-GB, fr-BE
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
References: <cover.1756872050.git.geliang@kernel.org>
 <64f5ec5170dd363b19af13fd127a77baa8288104.1756872050.git.geliang@kernel.org>
 <d512f8fc-a0ac-4c23-9a13-0b5c4e1ed20f@kernel.org>
 <ea8ac8aff352d819b9caa0abee2ae272991bd2ff.camel@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <ea8ac8aff352d819b9caa0abee2ae272991bd2ff.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 04/09/2025 10:26, Geliang Tang wrote:
> Hi Matt,
> 
> On Wed, 2025-09-03 at 13:57 +0200, Matthieu Baerts wrote:
>> Hi Geliang,
>>
>> On 03/09/2025 06:08, Geliang Tang wrote:
>>> From: Geliang Tang <tanggeliang@kylinos.cn>
>>>
>>> The client-side function 'connect_one_server()' correctly closes
>>> the IPC
>>> descriptor (a pipe or UNIX socket) after use. However, the server-
>>> side
>>> functions 'process_one_client()' in both 'mptcp_sockopt.c' and
>>> 'mptcp_inq.c'
>>> were missing the corresponding 'close()' call for their IPC
>>> descriptors.
>>>
>>> This omission could lead to resource leaks (file descriptors) in
>>> the test
>>> server processes over time.
>>>
>>> This patch adds the missing 'close(pipefd)' and 'close(unixfd)'
>>> calls in the
>>> server-side code, ensuring symmetric and correct resource cleanup.
>>
>> I don't know if we need such patch. I mean: yes, that's better to
>> close
>> such FD before closing the application, but then:
>>
>> - it is strange to close it in the middle of a function
>> (process_one_client()), and not where it has been created (main())
>>
> 
> Yes, close it in main() is much better. I added close(pipefds[1]) after
> calling server(pipefds[1]) in the new version instead of adding
> close(pipefd) in process_one_client().
> 
>> - if I'm not mistaken, unixfds[0] / pipefds[0] are not closed in the
>> server process.
> 
> Yes, indeed. close(pipefds[0]) is missing in the server process too.
> 
>> So if you really want to fix that, I think it would be better to
>> close
>> all these unix FD in the 'main()' function, no?
> 
> I also moved 'close(pipefd)' from connect_one_server() to main(), just
> after calling client(pipefds[0]). And here's the new version:
> 
>         e1 = pipe(pipefds);
>         if (e1 < 0)
>                 die_perror("pipe");
> 
>         s = xfork();
>         if (s == 0) {
>                 close(pipefds[0]);
>                 ret = server(pipefds[1]);
>                 close(pipefds[1]);
>                 return ret;
>         }
> 
>         close(pipefds[1]);
> 
>         /* wait until server bound a socket */
>         e1 = read(pipefds[0], &e1, 4); 
>         assert(e1 == 4); 
> 
>         c = xfork();
>         if (c == 0) {
>                 ret = client(pipefds[0]);
>                 close(pipefds[0]);
>                 return ret;
>         }
> 
>         close(pipefds[0]);
> 
> Is this better?

(sorry, I thought I replied...)

Yes, that looks more manageable like that: all close() by the "function
owner" (where they have been opened).

Also, please don't bother about closing all FD in the error exit paths,
e.g. in xfork(), etc. when xerror() is called. These are more unexpected
errors, and closing everything properly is this case, for the selftests
is not a priority, and might cause issues if the code is more complex (+
issues for the backports, etc.)

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

