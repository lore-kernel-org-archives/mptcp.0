Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DF7120311
	for <mptcp@lists.linux.dev>; Wed, 11 Oct 2023 16:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=andyt.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=andyt.co
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=andyt-co.20230601.gappssmtp.com header.i=@andyt-co.20230601.gappssmtp.com header.b="dsFh4SeM"
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-79fce245bf6so1529439f.1
        for <mptcp@lists.linux.dev>; Wed, 11 Oct 2023 09:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=andyt-co.20230601.gappssmtp.com; s=20230601; t=1697040253; x=1697645053; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GGnvJ0R9vgodao2BxrVqmImUp7Ad4gi8WoMVzfAMIY8=;
        b=dsFh4SeMYN7H5Pd4/A5ysv72y1v/F9owqPQ2Wt0NOteejpc+TTry6WbvBUwq8jFGER
         4UoYWjhv2r3r+oPGsGEojDkXOgltWJDNSiLUCw/GJWruZHpnz6kwCZKq+DmA5Zr14DMW
         G4Gkzsz4SjtVgK32lcJCD0PHhqtPtHP7MomkmAhX3hpjgpDp8gbMLBzDQLYGqXXnZJfT
         lCliIb8PWOG2i4HUKVZOqWblYnJEZArbNqKCEe5YJQCn8kF9eKn3SOlZgANA8/svKb+y
         5K/GiWQYihKBf303eboYJNjd4o5hHyV9JVoTH9DdZpT07MV7tR5vN2setI/ksVqzxkE1
         E8fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697040253; x=1697645053;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GGnvJ0R9vgodao2BxrVqmImUp7Ad4gi8WoMVzfAMIY8=;
        b=W06pm2IZU3tWy/kPsUR00pxb1uwOsFNANo7dx+LdS1O37ECMBlBuLTK2Q8Aaf5jnYq
         3VSkxYqTgX1OyZKr4sglpjHolZnsteF+8EdpEh4yt4CM91sge5hU2Gxl8AvLZ67Mxgfq
         EVX+6ciWsJz4+l/+Ih3SG0EEGc3F03j+U3xVQXMlSysqHlJpepAMddGKlqsS/5JM01g0
         zFGRKp+wD+ZHIbpAaTkhWEpQ3ao33ayQyjc1weTkqmbmak6qCBA8gdjA1Btc8Q36leW0
         V/DZyd1hgbjbM1a/khYUASpjnOtB6nwBKBktQW5h2NV7MkKYTgc4xmiZFfR9Cp2s2jGz
         HDog==
X-Gm-Message-State: AOJu0YwUoll3Owk+dx/atmIrd7YdyDbnrMetDXTbaA014md3GZJf+9Ht
	cHWhkeeUYBMynmNn/EZZBXUA1jayrrcfCZgm/M0bwa0NI1z/CW+oHpg=
X-Google-Smtp-Source: AGHT+IHuWf1JcOfTd9Pfi4wa0xOUBauNOIf/BRyksaOu2umj45O7NTz0qGft3ZGSOmLgyvlI7lOHJIYQRMPtPKVmPss=
X-Received: by 2002:a5d:990f:0:b0:794:d833:4a8a with SMTP id
 x15-20020a5d990f000000b00794d8334a8amr23125860iol.0.1697040252941; Wed, 11
 Oct 2023 09:04:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAGKODjrSDQ8r9_0+Kfskyj0Efx_1XQKMQO7N3LsYn2xhDGCMLQ@mail.gmail.com>
 <ccc810ad-2880-5528-4497-5181492793b3@kernel.org>
In-Reply-To: <ccc810ad-2880-5528-4497-5181492793b3@kernel.org>
From: Andy Tranter <andy@andyt.co>
Date: Thu, 12 Oct 2023 03:04:02 +1100
Message-ID: <CAGKODjpTTMTKfWtLR44TfwMniq0AUD_sNeUweirx6_9Cmfo33g@mail.gmail.com>
Subject: Re: mptcp - very slow start?
To: Mat Martineau <martineau@kernel.org>
Cc: mptcp@lists.linux.dev, Matthieu Baerts <matttbe@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"

Hi Mat

Thankyou for your response.
I'll log a more detailed issue report when I get a chance. I am busy
for the next week, so won't be until after then I think.

In the meantime I was quickly able to compile 6.6.0-rc4+ for my local
test system However the 27 second issue (for a test downloading from
apache) still remains (note, the server is only running 6.5.7).

Incidentally, I needed to upload a large file today, so figured I'd
mptcpize sshd on and give it a go. Was able to mptcpize rsync upload
successfully bonding/load balancing all 4 Stalrink connections approx
4x faster upload than normally, about 80% of their combined capacity.
Considering the normally poor performance of vanilla sshd for file
transfers, this is quite an achievement.
mptcp was active with all 4 connections transferring data immediately.
Is interesting that the reverse works as expected. I will have to
experiment further once I get both ends on 6.6.0-rc4+.

Andy..

On Wed, 11 Oct 2023 at 04:04, Mat Martineau <martineau@kernel.org> wrote:
>
> On Tue, 10 Oct 2023, Andy Tranter wrote:
>
> > Hi
> >
> > I thought I'd give mptcp a go, but I've come across some confusing
> > test results that I thought I might ask about.
> >
> > We have 4x residential Starlink connections, and (predictably) I've
> > had trouble bonding them to make one big connection. But looks like
> > mptcp might be useful as a basis to eventually create a similar end
> > result.
> >
>
> Hi Andy -
>
> Yes, MPTCP looks like a fit for bonding these links. It's an interesting
> setup since Starlink connections behave differently from wired or
> cellular links. MPTCP has a "packet scheduler" that decides which subflow
> (in your case, which Starlink connection) to send each packet on and we
> haven't tested that with connections like yours.
>
> > I have mptcp working end to end, and can see several established
> > messages via 'ip mptcp monitor' as soon as the connection is started.
> > For each test, I see the first connection running at 200-300mbit, but
> > the other 3 sit at around 8.5kbps. After approx 26-28 seconds they all
> > suddenly become active, all 4 links are utilized, presumably evenly,
> > and bandwidth creeps up until I think we're flooding the satellite or
> > base station and can't go any faster (lol).
> > But is this 26-28 second delay intentional?
> > Perhaps something is wrong with my test or environment?
> > Seems to me that a delay of several rtt before establishing mptcp
> > makes sense, no point for short lived connections, but 26-28 seconds
> > seems very particular and rather excessive.
> >
>
> It's not clear how much of the delay is due to MPTCP establishing
> additional subflows vs. the packet scheduler choosing to utilize the
> other active links after they are created.
>
> Could you open a GitHub issue at
> https://github.com/multipath-tcp/mptcp_net-next/issues and provide a few
> more details like:
>
>   * Which commands are you using to configure MPTCP for additional
> subflows?
>
>   * What tool/program are you using for the bandwidth test (so we can try
> to reproduce similar conditions)?
>
>   * Are the connection speeds you're referencing for the entire link or the
> specific TCP subflows in this test?
>
>   * Output of 'ip mptcp monitor'
>
>
> > I'm running 6.5.1 (Sept 2nd), so not the absolute latest but it's
> > pretty new I think. Do you think I need to try newer?
> > Various tcp options nor cubic vs bbr congestion control seem to make
> > any difference.
>
> It could be useful to try our development branch ("export") at
> https://github.com/multipath-tcp/mptcp_net-next/, if you're comfortable
> building & running a custom kernel.
>
> That is v6.6-rc5 + net-next (networking dev branch) + MPTCP latest
> patches. Those latest MPTCP patches include some related to latency tuning
> and the MPTCP packet scheduler.
>
>
> Thanks,
>
> Mat
>
>
