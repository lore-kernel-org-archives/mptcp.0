Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A0D7288C36
	for <mptcp@lists.linux.dev>; Mon, 19 May 2025 17:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747676591; cv=none; b=VFv+KORFbmhmE89zWYGP1ysHkXodXnrHLcWfObGPV+J/veFH7blT3ZI3EhHojW+F6M89bGNlxvya4TX/Uqh42IrlRfKwHUVjgD08QPNvvxhGkX5fZX2QFw3gAWqPFsgQgoCqwgi1q3i/w9xGDnfBXNxykRxMEWzxgOk7ZUiA9sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747676591; c=relaxed/simple;
	bh=afb3rzV8+h0ncEe/UUOl3c8pyZ4EGt3ko4mITD5ZJnY=;
	h=Date:From:Subject:To:Cc:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pUAJ18H3Aus4fSgTd+AC22H7njLcupCzGNlIRxmggWIYA6/7jZkX3KfroNhQY+e8/JjTtHshrAyqLKWp+/dscvkx2pLc756RqbPPoWCjWmI8ktMWJ8IhsK735cdkUE9nymrD5Rtmhnh8+gk+LB57WA4oldlLlOvND7kdRrFiFnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unrealasia.net; spf=pass smtp.mailfrom=unrealasia.net; dkim=pass (2048-bit key) header.d=unrealasia-net.20230601.gappssmtp.com header.i=@unrealasia-net.20230601.gappssmtp.com header.b=nZAMxeK6; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unrealasia.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unrealasia.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=unrealasia-net.20230601.gappssmtp.com header.i=@unrealasia-net.20230601.gappssmtp.com header.b="nZAMxeK6"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-23274dbcbc2so3162275ad.1
        for <mptcp@lists.linux.dev>; Mon, 19 May 2025 10:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=unrealasia-net.20230601.gappssmtp.com; s=20230601; t=1747676588; x=1748281388; darn=lists.linux.dev;
        h=mime-version:references:in-reply-to:message-id:cc:to:subject:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6D3C/1YkgWQlDT8+U7H2jg0toRVwhAzg/Ww4RU+uAWQ=;
        b=nZAMxeK6TWtDyBZWH/+pxEup+J6WWuZfY/V9lJCI3ZupV4zMz1axICYgsg+/z4eoTF
         8LUeWysuf8jYOSoDZZDG3O098ESufp4hMTSNT4Td7J6WjX5NQwjPsYKY2T16Mz3RcuUR
         FSMbvzloEWLDzeB5XHlXXHjp1NvtfwDe2ZdKCNVuotma/JOmXGvuvR78z+928XiNavQd
         +luhe7PHIfdxZH3nkNfV78Er8F9hoT9Zh4GIIq9vneFiA74E0p+3B7MNAcJIzylQt3o5
         9lnxwCHQoEUK94rD7wUsn4Y+kdChVv7MKbu1oMyNHzUEG+rFxi5zpBipy1TbDJXVi2Wh
         9BrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747676588; x=1748281388;
        h=mime-version:references:in-reply-to:message-id:cc:to:subject:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6D3C/1YkgWQlDT8+U7H2jg0toRVwhAzg/Ww4RU+uAWQ=;
        b=ZT2iSO5wJ1mC3CcpVJkhJiUTHcZrbMmogxbtOStZpAZBbm4V0Gn9Fenp8dJKKJ5PbF
         /KPfsCoQRj0EK1Wy92QwlC6ZcATLJGr9usaE4aMRqaxPh5z02wt9F9gW4n94emUo7UVv
         thzp/SIZXtN3/yPMmrGDlACWrH8H53a35MCyRkIf8Tq8oLmRNRlzpoKBwa5XiCnVtrsJ
         sLRgu2P+KTgyk1lf8D2kNEOFqZfyBidVcGWyKxRFcpwW8ec2Se5wZX8xDB4CF1SsH4fB
         YM1IUxSO/V/uuTrnsHVBkalAilf4rENYQaRvixAsvkcfcU8G6HWPXBQX+6XUIjW57q1X
         gkOQ==
X-Gm-Message-State: AOJu0YzTQCSGFOmGF3X8Gat5DquQN32HCSfU+qNB4xovBQPfv11e/GIq
	Wr+pIRRa+xaTrb0zb1uo5iLTpJ+4XhYzuS27pFlBHBB/eFib1eowLxYsG5Lq9dEOsHI=
X-Gm-Gg: ASbGnctIXw0Xjp5lYHmkrKgsQ9rqeAsuHwspnqSPSMI4CTiRreMkc+xxvIgjq7xR8e5
	aM/xfVL7vHhG4E1quGqnr5YX3D6TKLZLXQ1FPvfJZnHdKHBS2Q140+1XfTosNDXR+7HJavw/WKH
	dHJJ3bvdGMqYDE5Fl+wRHz3L5gLI31mKB/97OIjBCC39Mb+/1C4bp94ReFqn/0tjFmF2PHCa9N/
	lymS5mnxGf8i+aK0TwYeVGkqWNAznfLRftarWFeQ3Xnq7Ygx9k7x2t/LxR73OJfgdeeRNTHFSYA
	lbywiNGU+FcmnwG128LiBIGqiMDp95qOwCg6xvUlo2m1z7nuevEQ8SII5sZExsgp/w==
X-Google-Smtp-Source: AGHT+IG5X+RsqKM35sENQbUlpWdSR0eQpqS3xH3JfUgB44sz5uIeJvtWzcRI5EaYk6dqBlm7kbcEyQ==
X-Received: by 2002:a17:902:e808:b0:22f:c19c:810c with SMTP id d9443c01a7336-231de3bad0dmr154200065ad.51.1747676588400;
        Mon, 19 May 2025 10:43:08 -0700 (PDT)
Received: from muhammads-ThinkPad ([2402:1980:2a3:6667:81ad:dc5c:b828:4b13])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30e334e2907sm10622934a91.36.2025.05.19.10.43.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 May 2025 10:43:07 -0700 (PDT)
Date: Tue, 20 May 2025 01:42:59 +0800
From: Muhammad Nuzaihan <zaihan@unrealasia.net>
Subject: Re: MPTCP support for git (on Linux)
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Message-Id: <NVRIWS.HAQBNXTEKXJO2@unrealasia.net>
In-Reply-To: <305297b3-0911-402c-ab73-11de793881e7@kernel.org>
References:
	<CACNYkD4fBm6FDDUNbBY7Uc3MkONF7A7UDNajkTP4Xc4nfvWXZw@mail.gmail.com>
	<305297b3-0911-402c-ab73-11de793881e7@kernel.org>
X-Mailer: geary/40.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed

Hi Matt!

Great to hear from you.

On Mon, May 19 2025 at 06:47:10 PM +0200, Matthieu Baerts 
<matttbe@kernel.org> wrote:
> Hi Muhammad
> 
> On 19/05/2025 13:02, Muhammad Nuzaihan wrote:
>>  Hi,
>> 
>>  I don't know matt's email address so i am reaching out here.
>> 
>>  I have currently added support for the git protocol (not git over 
>> ssh
>>  or git over http) and you can find the patch here:
>> 
>>  
>> https://lore.kernel.org/git/4A7FWS.KARM6LOQBQ5S3@unrealasia.net/T/#m43718b0ad86f1f70b425a913dde63a09ff56b758
> 
> Thank you for suggesting this and telling us about that here.
> 
> I think it might help to reduce the size of the patch to get this
> feature accepted. You can eventually do that by modifying how socket()
> is called to use IPPROTO_MPTCP instead of IPPROTO_TCP or 0. In other
> words, no need to modify the arguments passed to getaddrinfo(): it
> supports MPTCP only since recently, and not particularly needed, just 
> to
> change one parameter.

I feel my code is a bit huge as well. I did this over last weekend to 
look at
the git and made that quick patch. the git developers weren't too 
helpful and
it's just that everyone seems pessimistic about mptcp.

The first concern from the git mailing list was the 2022 CVE about the 
crash
because of backpressure in mptcp and i do not find the comment about it 
reasonable
as the bug was a long time ago and RedHat/Debian would have backported 
the patch.

First it was chromium and i hope git project maintainers could look at 
it differently.

It's not the first time as i had to faced something similar to this as 
previously
was with IPv6 decades ago.

Anyway,

So i'll just revert the part of code that i made a check for 
getaddrinfo() then.
> 
> Also, if MPTCP is opt-in, then no need to check for the kernel 
> version,
> the errors, etc. simply abort.
> 
> In other words, the modifications could look like this:
> 
>       sockfd = socket(ai->ai_family, ai->ai_socktype,
>   #ifdef IPPROTO_MPTCP
>                       needs_mptcp() ? IPPROTO_MPTCP :
>   #endif
>                       ai->ai_protocol);
> 
> (+ the needs_mptcp() helper or just checking for the 'mptcp' var)

ah! my old mistake, i always forget about using ternary operators.
> 
> 
> On the client side, it looks strange to me to look at an env var. Is 
> it
> common in Git? Can you not use a new entry in the Git config instead?
> (If we have to set an env var before each Git commands, maybe even
> easier to use 'mptcpize run git (...)'.)

I wanted to add an option in git config (can be global ~/.gitconfig or 
per-project),
but it was taking too long so i left it with env var (i think it's an 
unknown fact git can
be configured with env vars and i was surprised after reading the code)

To be honest, i think a clear way is to add the option in .gitconfig is 
the way forward and i will add that in after i figure that out.

It was a quick hack which i added persisted the environment variable in 
my shell.
> 
> 
> On the server side, it might be interesting to first suggest using 
> MPTCP
> by default if available. If not, a fallback to TCP can be done, e.g.
> 
>   #ifdef IPPROTO_MPTCP
>     sockfd = socket(ai->ai_family, ai->ai_socktype, IPPROTO_MPTCP);
>     if (sockfd < 0)
>   #endif
>        sockfd = socket(ai->ai_family, ai->ai_socktype, 
> ai->ai_protocol);
> 
> To justify this, you can refer to:
> 
> 
> https://www.mptcp.dev/faq.html#why--when-should-mptcp-be-enabled-by-default

I see. Just got to know about the defaults. Thank you!
> 
> (in short: an MPTCP socket will be returned after a call to accept()
> only if a client requested to use MPTCP ; if not, a TCP socket will be
> returned like before. So the client can decide to use MPTCP or not, 
> and
> no impact on the previous traffic on the server side.)
> 
Ah, alright, i'll do that one.
> 
> If you want me to review the new versions, you can fork the Git repo 
> on
> GitHub [1], do your modifications in a dedicated branch, then create a
> pull request to merge this branch with master **on the same repo** 
> (not
> on the upstream repo). From there, you can ping me.

I'll start continue the work this weekend if you are okay with it since 
i would
have more free time then.

I've already forked the main git repo: https://github.com/muhammadn/git
> 
> [1] https://github.com/git/git
> 
>>  Reason being was that i was handling large (public) git codebase 
>> over
>>  unstable links and i think it's also a good idea for me to add for 
>> the
>>  support for the most basic git protocol for read access of large
>>  public git codebases.
> 
> That's a good use-case. I didn't think about it because I often use 
> Git
> over SSH (or HTTPS), but I understand it can be helpful for you!
> 
> 
>>  The implementation i did is for both client side and server side of
>>  the git protocol.
> 
> I think it might be better to split the two implementations in 
> different
> commits, no?

Agreed.

> 
> Cheers,
> Matt
> --
> Sponsored by the NGI0 Core fund.
> 
Thanks!,
Zaihan


