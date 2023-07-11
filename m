Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD3F182B6
	for <mptcp@lists.linux.dev>; Tue, 11 Jul 2023 10:22:29 +0000 (UTC)
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-992ca792065so694623566b.2
        for <mptcp@lists.linux.dev>; Tue, 11 Jul 2023 03:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1689070948; x=1691662948;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Rsf+TrLfMmeE1X2ijbvEisPOH8eAVXvHGVSzMLkizwY=;
        b=O6wUG7GNVpUERWMiE3eQvV+73Ld5cPERj+gTVPpHlQwebtkyUZTGH3b4FQhOjOCW6v
         dv4knDHmsrnzowJAHOqJo2GJ6SY854po5u6s8NEdXe35HofIWmsOIgbuqY9ltBgx9nCM
         b443h1toeX2ldVDmnWvNHXiUkWfCEUfnehvDDhNT/4t/q3WGUHWpPHcA4FTTIJkum4I1
         pqTu/hTIyzxrVTPjlhprqNrqhNUF+1YaIbZta+mZZW36ww1G6sh62VUZH2ZM8Cgf00Q+
         PrhA+Z4iBhsAyXFaeEXStJq7L4+Bg1DaMpG7D4nZ+3redpTlGsHM1Sxs4W+emV6Wf8Uj
         /k/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689070948; x=1691662948;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Rsf+TrLfMmeE1X2ijbvEisPOH8eAVXvHGVSzMLkizwY=;
        b=I9TgeqIbbDEqbeOBnVztN3hNFXU7RwlS/2H6o1EbK8JIPbmlFAG5CAqgDtPvgeUKjN
         MnK9sLWL11fxDpsetdZbAalkNKciiZJF0jyr4mgAA12V/HLBr7iKeeTdxjd8D7NaEKLH
         FbW50lvf63pFMKizEPcxRACOlyeTbibLZ9jPglnU9zzqZQvAIuMCxSL0Qu/duyf6Kmpl
         DueoyxL4WtnPAukJ1U2+ijXwUjOWgOmidlraMvO47O0+V5fw3Mj1vt8t9OdfdQxvGMpo
         XI3uhJz8pXjbVKlx6o+ezmKm8w77m+Xki9dUQEhrBzZslWCid5z+d54+gx2UqyXhINII
         449g==
X-Gm-Message-State: ABy/qLakdLqWy+E8zx3BnX66nE4Y5ZV05Ls5jGY3Z2EH0bhIeUNU13ht
	Lql5Mwzr2rNLyLcTaCv2eAAMbUEx9oxYs3PpTUE=
X-Google-Smtp-Source: APBJJlEfTBR7/M10CQexGb7CkrlF+IaO6J1Eq581qVJjdM2jGfA9B4zlBGIcotsxg7OTWGj8rWK/Bg==
X-Received: by 2002:a17:906:5a50:b0:978:928:3b99 with SMTP id my16-20020a1709065a5000b0097809283b99mr15249161ejc.46.1689070948177;
        Tue, 11 Jul 2023 03:22:28 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:7fe7:f31d:3a5d:b710? ([2a02:578:8593:1200:7fe7:f31d:3a5d:b710])
        by smtp.gmail.com with ESMTPSA id k5-20020a1709061c0500b0099307520b8csm968607ejg.29.2023.07.11.03.22.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jul 2023 03:22:27 -0700 (PDT)
Message-ID: <bc861997-4f71-c254-6e49-f92ba86dce67@tessares.net>
Date: Tue, 11 Jul 2023 12:22:27 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH mptcp-next 0/6] mptcp: sockopt: uniform code to get/set
 values
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
References: <20230707-mptcp-unify-sockopt-issue-353-v1-0-693e15c06646@tessares.net>
 <9de27c12da208e32efc43e2b36840d941cd1575f.camel@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <9de27c12da208e32efc43e2b36840d941cd1575f.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo,

Thank you for your feedback!

On 10/07/2023 18:51, Paolo Abeni wrote:
> On Fri, 2023-07-07 at 18:00 +0200, Matthieu Baerts wrote:
>> Here is the implementation of an idea I suggested a few months ago: it
>> is a factoring of the sockopt code trying to uniform it, mainly to rely
>> on {ip,ipv6,tcp}_[gs]etsockopt() instead of copying what is done there
>> to get and set values.
>>
>> That's a first step. More might come if we are OK with the approach,
>> e.g.
>>
>> - For SOL_TCP socket options we cannot store info in the MPTCP socket so
>>   we still need to "manually" store it somewhere in the msk. Maybe we
>>   could store info in the different subflows (and create a first one if
>>   there is no subflow) and retrieve info from there?
>>
>> - For SOL_SOCKET socket options, it looks like it should be feasible to
>>   do something similar to what I did here but I'm probably missing
>>   something. This could clean quite a lot of code, e.g. the last commit
>>   from:
>>
>>     https://github.com/matttbe/mptcp_net-next/commits/b4/mptcp-unify-sockopt-issue-353
>>
>> - To sync the socket options when a new subflow has been created, for
>>   the moment, we copy info from the msk to the subflow but maybe it
>>    would be fine to call some getsockopt() / setsockopt() to do the
>>   sync? If we take this approach, we might want to save a list of
>>   setsockopt() that have been done in the past on this socket and only
>>   re-do these ones? That should help with the maintenance of these
>>   socket options and ease the support of new ones.
> 
> I would highly discourage this latest approach.

Before going further, I want to insist on the fact that it is just an
idea, I didn't look at the implementation (and to be honest, I was not
looking at doing that now :) )

> We will have to limit
> the list length, breaking the sync at some point.

Why would we have to limit the list length and break the sync?

I understand having a list might not feel good but I'm not sure what
else we can have.

> And there are few
> quite gray area, e.g. how errors should be handled?

Same as what we have now I guess: errors are ignored :)
But I don't see what else we can and it doesn't feel worst than before
(regarding how we handle errors during the sync)

> I also fear the
> "final" state of the subflow could be different from the
> expected/correct one for non trivial socktopt.

I would expect it to be better because we would follow the "normal" flow
to set values. What bother me is the fact we bypass checks and directly
set values. If the code change on the different IP/TCP/SOCKET socket
options side, we might (very likely) miss the fact we also need to
update what we are doing on the MPTCP side, e.g. if new checks or extra
actions (BPF/Netfilter hooks) are added later, etc. So the idea of this
approach is to ease the maintenance (but maybe that's not needed and/or
not worth it) :)

Of course, this would work only if we can do something like *only* for
each setsockopt() that have been done before:

  void sync_sockopt(sock, level, optname)
  {
    socklen_t buflen;
    char val[1024]; // we can also record the max given before

    buflen = sizeof(val);

    if ((err = getsockopt(sock, level, optname, val, &buflen) < 0))
        return;

    setsockopt(sock, level, optname, val, buflen);
  }


Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
