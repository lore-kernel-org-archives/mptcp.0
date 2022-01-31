Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F41B32C9C
	for <mptcp@lists.linux.dev>; Mon, 31 Jan 2022 17:40:29 +0000 (UTC)
Received: by mail-ej1-f46.google.com with SMTP id ka4so45204841ejc.11
        for <mptcp@lists.linux.dev>; Mon, 31 Jan 2022 09:40:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=jrCFhvJFjkaYwOXJA7yxbcT/9cZHHgYgpYM4Hqf/6PE=;
        b=wRKufUZMnKUFZO6QGU1FDrnp4dgzIToqJ16daFLoLH2nizgviANT7sZjdBc7XS5t6g
         cMiY2Wh7CmrRRgiN9Ws6qCbfULeWarNX4y7xomNbV6acY23ijanHjkxfiYz1SOugXz8d
         r22cywqbEy5XrNw2vUaoT1DcB8feme+AthI1uvoC0qi3C/JjUFrbKCmRn/NC2fiv9JaE
         0j9AWJYXfHXqmnAq4g5KUKL65eHrs217aMNL5W3s3U7K+njJTYWLPLDS9qagwyMxmHE9
         kClm/esniOLlz+yRq2wJb9GdgONy/fVGo0IolWcEPd+vBTc9el9KbX4x6cfcpSjiAxGi
         PiRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=jrCFhvJFjkaYwOXJA7yxbcT/9cZHHgYgpYM4Hqf/6PE=;
        b=cnXBvXFFH1n4r1//x2r+ahm/chZ7sNEVooKay6JYe/QoOw2A97Xm9gl3G6ENjaQDzK
         DuQ/rsUeL/c2XEFfr04DXyeoLN/frgA5qgf7fJsuie5Q5a8mDabXMz1Mo0LuIBX6/5Pc
         +VoBB8+C6e70byn187bmMU2XU2zDiow8p3TJ52Hgm3YpaabB5dKUPf5cvs/zSKzmR7lh
         oMGqKkHCXr27OvWRn2ii0j31fTT8CwzJCUcAFuXcAuEuEcCO5wdiujk+oohI3/NIvJ/j
         b7HjVXy5gU8r2bAqaUiUGID+haNqEAIJqJ56l9OmUvZzetlluCXGbHwmKXFtVv2+85Z1
         d1yA==
X-Gm-Message-State: AOAM531fqdoU8G9nq56b2rGy0uk5gJoHr3BRGXGEAATxENwHILcd2e4Z
	HrAR3EQMOg8RcgG4ouFXYcQ3c2ngdPjy+g==
X-Google-Smtp-Source: ABdhPJzMXD+pyfyd3gEaKkGF5wmJgQV0bBtT1awmiDDXqFGyj8WuFb/3GXK84sFyRg8mvyMXcXn1aA==
X-Received: by 2002:a17:907:60cb:: with SMTP id hv11mr17804686ejc.122.1643650827797;
        Mon, 31 Jan 2022 09:40:27 -0800 (PST)
Received: from ?IPV6:2a02:578:8593:1200:daf0:2a8c:b440:96c5? ([2a02:578:8593:1200:daf0:2a8c:b440:96c5])
        by smtp.gmail.com with ESMTPSA id p11sm18138370eds.38.2022.01.31.09.40.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Jan 2022 09:40:27 -0800 (PST)
Message-ID: <8339d9dc-4055-57c9-9c97-9ca4075c7496@tessares.net>
Date: Mon, 31 Jan 2022 18:40:26 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH mptcp-next] mptcp: use nla_parse_nested
Content-Language: en-GB
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
References: <022caed0c9e5964f525336aced8233338c29386f.1643437533.git.geliang.tang@suse.com>
 <25250bc9-015e-df2a-582d-5b5dd3eabdcb@tessares.net>
 <20220130043318.GA7781@dhcp-10-157-36-190>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <20220130043318.GA7781@dhcp-10-157-36-190>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 30/01/2022 05:33, Geliang Tang wrote:
> Hi Matt,
> 
> Thanks for your review.
> 
> I don't know why this commit didn't show in the patchwork. The CI seems to
> have complained about it.

It seems the issue was on kernel.org side, now fixed: your patch is on
patchwork and lore.

> On Sat, Jan 29, 2022 at 12:53:20PM +0100, Matthieu Baerts wrote:
>> Hi Geliang,
>>
>> On 29/01/2022 07:26, Geliang Tang wrote:
>>> NLA_F_NESTED has been used in both 'pm_nl_ctl' and 'ip mptcp'.
>>
>> Was it always the case for 'ip mptcp'? I mean, we cannot break the user API.
>>
>> And even if it was always the case for 'ip mptcp', there could be other
>> tools not using NLA_F_NESTED. Maybe we can ignore them in this specific
>> case but I'm not sure.
> 
> I think now is the right time to switch to the new API: nla_parse_nested.
> Since now no other tool uses our mptcp netlink yet, only 'ip mptcp' and
> 'pm_nl_ctl'. There's no need to consider about the compatibility.

I would like to only consider Open-Source tools but I don't think we
can. It is unlikely someone wrote a new tool not using NLA_F_NESTED but
I don't think we can be 100% sure. This is an uAPI break to change this
I think, no?

> The old
> API - nla_parse_nested_deprecated - is reserved for the compatibility of
> the netlinks that already have some user tools using its interface in the
> non-NLA_F_NESTED way. We are not the case.
> 
> Switch to the new API can force the user tools to use the NLA_F_NESTED way
> from now on. That makes sure no user tool uses the non-NLA_F_NESTED way for
> our mptcp netlink. Otherwise, one day the old API will be abandoned, and
> then if there're some user tools use the non-NLA_F_NESTED way, we will have
> to deal with the compatibility at that time. If we switch to the new API
> now, we can avoid this potential trouble.

I guess the compatibility will need to be kept of a bit of time. This
function is used in 250+ places in the kernel. I guess it has the
"deprecated" word in the name to clearly indicate "you should not use
that for new features" but not to say "in a few months, we will drop
this, deal with it now.", no?

It would be easier to use nla_parse_nested() instead of
nla_parse_nested_deprecated() but I don't think we can.

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
