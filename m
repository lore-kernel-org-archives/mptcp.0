Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7DCA19B
	for <mptcp@lists.linux.dev>; Fri, 15 Jul 2022 14:47:05 +0000 (UTC)
Received: by mail-ed1-f43.google.com with SMTP id x91so6608173ede.1
        for <mptcp@lists.linux.dev>; Fri, 15 Jul 2022 07:47:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=XuTRz6GblJ7BC3eFBOn8UDBcnpNDCQy9M68yaCIMx0o=;
        b=qBO2qDBqncKnHfEbRJ1g0QpQD5o7H/Mp751F9CWTpwaAAyxVpBu2E2jDLpJhbbqjKS
         nVmZebHaNvwWRuQM4rlDisqE8wmNHIQ/ggE4umtAfxwoA5ACdcF/4mhLExmwVpFtAwD4
         AyBwfoiTfmvzCV06iA1Aa+P0D2Sao4J3NNzuUgKY/WXO34XFOGErRFK8XSq8GolcdROe
         mbYWwiVA018mwaD/jcESZJNoenuE+9DrN9n1WrGxdpNRzcZDCZZAVAw6KtFRmHi4/MKl
         IRBsBDm/gx0cvr3xf+G6GfRvRotD1M7YhseHuTKMVLjddUJSpqTss/ErzYrRtNVkr6St
         3g/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=XuTRz6GblJ7BC3eFBOn8UDBcnpNDCQy9M68yaCIMx0o=;
        b=c/jdNhbg/BEYOqMz1XTDQPvv9JKmZ+mu0ui7O+5JvXVHjOTcRfc0gOFo2s6A0BqAoZ
         zSx7rxcFCpRTGRV+ZJkOwi6Afq1YL0IvHUaGHcJoJIL3nmSIpApMBlnOflc0CAFgSfwO
         +dJwhwsOCP2nrZEt3RFoEvbT+B9QPHLcYhBXY59Ex4GYzWiaVd/3eOEcKwQc1DGXfT9N
         xi4ooIfffipHyFUtRSkXTOJXwMnqtECgnCDhPpPdjDK6r6ECyqH5Nnf3kl8JggOVoycd
         bxHl1Y4SRcEIqYnTrnymIFIiYW3BGMNMP9Yva2OW2ycKW10//9+4cs00MSEffoVlQRo9
         v72Q==
X-Gm-Message-State: AJIora+/7sAyMyIvw5rbczvQucNfOjS6PfKV1OvYVuxBw/kSuIOnsKV4
	+X7As4a54Xt1tF4vRMLWwJt3Fg==
X-Google-Smtp-Source: AGRyM1uYBNcq31OL2u8jfqf29+6A/AYN89jWzk/pYlRLG5UKc9zxdiFrAjMTBS2p4FESdT6X/AUlBw==
X-Received: by 2002:a05:6402:510a:b0:43a:91ff:3f4b with SMTP id m10-20020a056402510a00b0043a91ff3f4bmr19398076edd.187.1657896423585;
        Fri, 15 Jul 2022 07:47:03 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:70ff:32c4:2014:7c11? ([2a02:578:8593:1200:70ff:32c4:2014:7c11])
        by smtp.gmail.com with ESMTPSA id ja8-20020a170907988800b0072af843c794sm2116915ejc.43.2022.07.15.07.47.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Jul 2022 07:47:03 -0700 (PDT)
Message-ID: <7cd436ad-6c05-d788-7af3-2ff08d647dfd@tessares.net>
Date: Fri, 15 Jul 2022 16:47:02 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.0.1
Subject: Re: Draft talk proposal for MPTCP @ Linux Plumbers '22 (2nd draft)
Content-Language: en-GB
To: Mat Martineau <mathew.j.martineau@linux.intel.com>, mptcp@lists.linux.dev
References: <78ff1ebd-f440-9dd0-256-abf3345e6d3@linux.intel.com>
 <3f3a487-64b-e687-f566-ae9b3b930bb@linux.intel.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <3f3a487-64b-e687-f566-ae9b3b930bb@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Mat,

On 15/07/2022 00:50, Mat Martineau wrote:
> 
> After some discussion at out last couple of weekly meetings, here's an
> updated draft.
> 
> Changes:
> 
>  * Moved BPF section up (before userspace PM)
>  * Emphasized interactive discussion for BPF issues we've been trying to
> resolve, like the BPF/kernel API.
>  * General edits

Thank you for this v2!

This looks really good. I have one general comment below:

> Suggestions, edits, feedback, etc, all welcome!
> 
> 
> ---
> 
> Multipath TCP (MPTCP) was initially supported in v5.6 of the Linux
> kernel. In later releases, the MPTCP development community has steadily
> expanded from the initial baseline feature set to now support a broad
> range of MPTCP features on the wire and through the socket and generic
> netlink APIs. Two current projects are intended to make MPTCP more
> customizable for client devices and unique use cases without requiring
> custom kernel modules.
> 
> One of these projects is the BPF MPTCP packet scheduler framework. When
> there are multiple active TCP subflows in a MPTCP connection, the MPTCP
> stack must decide which of those subflows to use to transmit each data
> packet. The default in-kernel scheduler tries to utilize all the
> available subflows to favor throughput, but it is not tunable.
> Customizable schedulers can optimize for latency, redundancy, cost,
> carrier policy, or other factors. We have patches implementing a
> proof-of-concept BPF packet scheduler, and hope to discuss with the
> netdev/BPF maintainers and audience how we might best structure the
> BPF/kernel API to balance long-term API stability, future evolution of
> MPTCP scheduler features, and usability for scheduler authors.

Should we insist on the fact that these discussions are not specific to
MPTCP but this is more general and MPTCP is used as one typical use-case?

I would suggest to explain that before this 2nd paragraph. Maybe saying
that we are trying to get answers to questions like: what's the
recommended way to extend a subsystem(?)? The recommended ways seems to
be with BPF and Netlink and they both have limitations. allowing
customisations with BPF bring more questions for us, e.g.: what about
long-term API stability and other questions you raised here at the end.

Then we can introduce the two use cases. The first one with the Packet
Scheduler where we need something on the kernel side as it is a decision
to take per packet. There are some uncertainties when using BPF but a
proof-of-concept implementation exists.

Then for the Path Manager, the decision can be done from the userspace
because the communications are per connections and not per packet. So
this is a another use-case where exposing a Netlink API seems to be a
good fit (even if there are some limitations if there is a very high
number of connections to deal with).

We can then compare BPF and Netlink and trying to get answers to our
questions.

What do you think?

Cheers,
Matt

> 
> The next customization feature is the userspace path manager added in
> v5.19. On the kernel side, MPTCP's generic netlink API has new commands
> that allow a userspace process to control multipath address
> advertisements and the additional subflows that add paths to a MPTCP
> connection. The Multipath TCP Daemon (mptcpd) is the first userspace
> daemon to support these commands. With these components, systems can now
> customize MPTCP behavior on a per-connection basis. The in-kernel path
> manager, which is enabled by default, only has per-namespace
> configuration. We will show what the userspace and in-kernel path
> managers are best suited for and explain the tradeoffs between them.
> 
> MPTCP development for the Linux kernel and mptcpd are public and open.
> You can find us at mptcp@lists.linux.dev, https://mptcp.dev, and
> https://github.com/intel/mptcpd
> 
> 
> -- 
> Mat Martineau
> Intel

-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
