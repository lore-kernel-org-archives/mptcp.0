Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E6D2C9C
	for <mptcp@lists.linux.dev>; Mon, 21 Mar 2022 12:32:41 +0000 (UTC)
Received: by mail-ej1-f46.google.com with SMTP id r22so9436577ejs.11
        for <mptcp@lists.linux.dev>; Mon, 21 Mar 2022 05:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:cc:in-reply-to:content-transfer-encoding;
        bh=KGsUy3ocFrRCUNjThkIHPtAl4mlt0p/hKzYEnc707eA=;
        b=AcZTRYR/4TqjZs8v2OEKoe2+OqGJDL2xeToYLUO12VVekUk73NbzYtT6otIlQT1naK
         oEGMvxj0XEkfsTlX9SrT7yPGXW6gPmCgUnhXQtcGjTnWArVg90hJC+KH/LPLthA9+CVj
         VK1JiKS5EbPbneUWgBDXEO3W16/h16iHLjlEZrT+d9W8Ldi6q6HwlEqLpbdTgTtzOPF2
         k/rXEi3uhMyQIy01KnUYMoKFtAVT/Lc37C/rB9kKqP2l3SYCg1vggd/ghD6INJ0jv05/
         7BXdm5B3/dYkRXrGvH/jEd737LHMtdUN0DAWluFfsHcaJiSKCX+o6uqhX76U8xAjWhPy
         9YZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:cc:in-reply-to
         :content-transfer-encoding;
        bh=KGsUy3ocFrRCUNjThkIHPtAl4mlt0p/hKzYEnc707eA=;
        b=2FqHFvS5aq7j8Y1OFyuqGTxWpi34Rub877N+ZnDu0R+F5UWXldAqu2GxVVH8iTQfsA
         qybv5toUMpg9uDDQBZWeSOhQhO64JS5X+vXyrg8nVEewfMIjBHczooLNvEmkZDJv4JpG
         REkEDzKL/zRWrp0xvydBTdyzYkfRSbQGGwCxjeY1ogBFOgbdQZ6ocXIks80qOrp5Vvfx
         zdoqd6H9nCiQwlKFSUsLkBJH2/YJCptduymgwjbYQqc8maN6bCrUi+4YpnYy0dQGB93U
         vMnMVjqmusx7mBBWz8qDXwJ27tbMKVqJkj7lXg7ygNgcOB/PiwZJHDq5L60TWomOOTv1
         QO6w==
X-Gm-Message-State: AOAM530d9wOAdiP1n3crsDGApviucfUrxycuK6rJ48+hq0pkaYyWK6sV
	dwQ8dDM3iKqNMXE3Xbv5moWUfw==
X-Google-Smtp-Source: ABdhPJyy5Q06VzWGz9o43X+rNj54tcs66pwJfh9+nr6IZ3TBVl/jk4744YYZyWYSFdIsJO4TEKOQCw==
X-Received: by 2002:a17:906:7c93:b0:6cd:341a:a1d5 with SMTP id w19-20020a1709067c9300b006cd341aa1d5mr20018511ejo.698.1647865959799;
        Mon, 21 Mar 2022 05:32:39 -0700 (PDT)
Received: from [10.44.2.26] ([81.246.10.41])
        by smtp.gmail.com with ESMTPSA id f4-20020a170906738400b006df8b6787afsm6023876ejl.13.2022.03.21.05.32.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Mar 2022 05:32:39 -0700 (PDT)
Message-ID: <d5d271c9-88e1-565e-afbc-41e73bccb415@tessares.net>
Date: Mon, 21 Mar 2022 13:32:39 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: MPTCP Linux Implementation
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>, Sam Kumar <samkumar@berkeley.edu>
References: <CA+5NP0kpxDU-+57tZe0V7TkcWGH5Jc8cMhck6sKA7ptz2tvbmw@mail.gmail.com>
 <67be2502ac695a76da2ea758b7e03636a4ec9540.camel@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev, mptcp-dev <mptcp-dev@listes.uclouvain.be>
In-Reply-To: <67be2502ac695a76da2ea758b7e03636a4ec9540.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Sam, Paolo,

(+cc mptcp-dev as you also asked the question there)

On 21/03/2022 10:43, Paolo Abeni wrote:
> On Sat, 2022-03-19 at 11:54 -0700, Sam Kumar wrote:
>> I'm Sam Kumar, a PhD student in Computer Science at UC Berkeley. I
>> read the NSDI 2011 paper about congestion control in MPTCP (this
>> paper: https://www.usenix.org/conference/nsdi11/design-implementation-and-evaluation-congestion-control-multipath-tcp).
>> I think it is really nice work and I would like to try running it.
>>
>> I came across your community's work on upstreaming Multipath TCP
>> (https://github.com/multipath-tcp/mptcp_net-next/wiki), and I wanted
>> to ask about the congestion control algorithm that your implementation
>> supports. Does the version of Multipath TCP in Linux support the
>> congestion control protocols for preferring subflows with less packet
>> loss, such as the COUPLED, SEMICOUPLED, or MPTCP (Sec. 2.5) algorithms
>> described in the paper? 
> 
> Nothing of the above. The in-kernel MPTCP implementation uses a single
> scheduler algorithm, which is a custom heuristic based on the bleast
> scheduler:

Regarding the TCP CC, there is no coupled congestion control algorithms
implemented in the upstream kernel. A few are available in the fork:
lia, olia, balia, morena (not sure about this last one...), etc.

These CC are only needed if fairness is important for you when you have
multiple paths of the same MPTCP connection with regular TCP flows
sharing the same congested link. That is not often the case: it is more
needed for specific use cases. That's probably why nobody started to
work on that as long as I know. It was a popular topic a few years ago
because it is an interesting research subject from a mathematical point
of view. But I don't know if it solves "real-life" problems.

So in short, these coupled CC have not been implemented in the upstream
Linux kernel and as far as I know, nobody is working on that.

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
