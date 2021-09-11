Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 287EB3FD0
	for <mptcp@lists.linux.dev>; Sat, 11 Sep 2021 06:06:26 +0000 (UTC)
Received: by mail-ed1-f43.google.com with SMTP id t6so4270403edi.9
        for <mptcp@lists.linux.dev>; Fri, 10 Sep 2021 23:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=ifVqD9m5/UtPfyScMSQR/KgOUWvfZShwrHr5QkiJnxI=;
        b=cnUC9LbtlIAl7HVlja9TYEHbppPoW5o1bRNjFBVoXEwqyxC6COxUmWrFRSu33DoyIa
         hk8cNtomldCicTI5goE/T0qCAQ3n9EG5OdkYVKmPpVq31HGkNwVnAnrlXq0YCTpbpfBf
         +UwzTTF2RUj47TwE7WwHM3MHTufjCpXOzBvltLODDpnU6lUG84Vwa2YhWmVk53ekgGEa
         6zWBFB0wUMSfulQZthn4606tiVj0us+aO3vYVEnp6SuJl87mo+tKe7ziPl6WRPDUTD0a
         JrDfCfs6UV8ZgH27EYkUAy87CZAX4gTp/AQPYTydR3E/+4gpbiVdLpIZgIK2EV/GmOcH
         U30Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ifVqD9m5/UtPfyScMSQR/KgOUWvfZShwrHr5QkiJnxI=;
        b=VYwZ3wH8vUsEc4mnRv3MyqqgjlBWuujnSb5yqvI1XFhkYOPhC10eH4dhlC+eZSZgeS
         HHGW6sFLcMvbZbGCwaKbY+r52yhjUTOjsLZWeddt8p+wTyL9YSBb59HiAAuMLcnEVxRz
         LiQPZWbQihpx94Scj4rDjT97NXGRRpG/7DpWpsCWR7T4COHlP1JtIaesJH2VHHXiKuf5
         wAzY16DRpJtojxWq/yzVeGsLfBy8VqhbyJGTlrM2tdltN9gLeJmWI6k6pWFGI9cBvfDo
         N8o1urzCkXCbOWH0pSMd7tewnhlkJcyoam6m8Yq8QTvJLgwdiCY9/d3FEd3fcXVDtgtu
         emSA==
X-Gm-Message-State: AOAM5311PlHMqOxs7b9cj1KMQJs/hm4Z4s126idYktsaI44gkJX9ClP0
	y/DDrLpi6V4XVRYKzG/O3idj3u9fg0tw3E+K
X-Google-Smtp-Source: ABdhPJx6hlHddKxLh3eJWBEdS89Ja8F/CcggEn7/8j6hcSBSm4ZV6/GlWlpmqF1hvKzU8hQN3X0YAw==
X-Received: by 2002:aa7:d402:: with SMTP id z2mr1737320edq.291.1631340384373;
        Fri, 10 Sep 2021 23:06:24 -0700 (PDT)
Received: from tsr-lap-08.nix.tessares.net (94.105.103.201.dyn.edpnet.net. [94.105.103.201])
        by smtp.gmail.com with ESMTPSA id z8sm310988ejd.94.2021.09.10.23.06.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Sep 2021 23:06:24 -0700 (PDT)
Subject: Re: [PATCH mptcp-next] chtls: rename skb_entail() to
 chtls_skb_entail()
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
References: <ed8775ab838ec39895e14b191a338e0f529dfcc0.1631176902.git.pabeni@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Message-ID: <9ca14b4b-3474-b1b3-7959-421b5e38032c@tessares.net>
Date: Sat, 11 Sep 2021 08:06:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <ed8775ab838ec39895e14b191a338e0f529dfcc0.1631176902.git.pabeni@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit

Hi Paolo,

On 09/09/2021 10:43, Paolo Abeni wrote:
> The next patch will expose the core TCP helper with the same
> name. It looks like we can't trivially re-use it in chtls, so
> remame the driver specific's one to avoid name conflicts.
> 
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> notes:
> - this should land before "tcp: expose the tcp_mark_push() and skb_entail()
>   helpers"
> - just build tested, I lack the relevant H/W to do anything better
> - we need to CC the appropriate chelsio maintainer when submitting
> this patch upstream
> - I did not add the reported-by buildbot tag. as there will no issue
>   with the patch applied in order, but I guess it can be added, too

Thank you for the patch and the review! Added in our tree before "tcp:
expose the tcp_mark_push() and skb_entail() helpers" and with Mat's ACK.

- 99bd188ec0e2: chtls: rename skb_entail() to chtls_skb_entail()
- 5f3ea6614848: tg:msg: add missing Reported-by tag
- Results: fecd1f9bf19f..98e7006b1e5b

Builds and tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20210911T060609
https://github.com/multipath-tcp/mptcp_net-next/actions/workflows/build-validation.yml?query=branch:export/20210911T060609

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
