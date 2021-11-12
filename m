Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 977CC2C83
	for <mptcp@lists.linux.dev>; Fri, 12 Nov 2021 11:00:08 +0000 (UTC)
Received: by mail-ed1-f41.google.com with SMTP id f4so36031413edx.12
        for <mptcp@lists.linux.dev>; Fri, 12 Nov 2021 03:00:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=ukFyZoUcigi/2YlbFcCxQKDaKRpMUF5MfSd4ciMpW18=;
        b=mZp6CR8JUWJ31JH2f8kwoJ2cwMnZsmpPf6LbUVif55c5W0q3OMgDBxjI0MtYqTZugQ
         pN2h2e6tyJTf4BU+O7lACv1hlxSruN+qBStQrqpGA1qYbFMP3FSlZ+4fNv5xaH7nZkNz
         PWm2Nle3m0j3sBj86qQybkP5L62uvFwFGcVyFhE5By7DdBsz+iFCZUcVje+1QbGoDpHK
         CcJTShRYnRaxsIV3bgmbwZ3WhxO1HeAYYdUZDrD4MJRq6084Sj1rD8fA2to78dN4At54
         XBghLN7NTWqlbd2ZOJIaQF5p4MNZ7ofaUDuC4KLoXS3jef3VxxqE5y/hB8d9OWCc7sI3
         bulA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ukFyZoUcigi/2YlbFcCxQKDaKRpMUF5MfSd4ciMpW18=;
        b=16c3RxSbi2VqqOo1ZnrZ6bgA4dlaj9JlDCxPKz5t4ySAW0ljNYhDF66g06yXdNop13
         LayqIPQCJLiUIUwXJJNyaXRvNk3SEaXExZXiEHGHwWKRPVO9TjXCn5CslaT0a/Qs4vn/
         2rtkBZCTk4TYry0bAPuylkDTGj4nQbLCe4s5DnyBI2a0NNdRfr6Z5GdMPp4VwBcimvfk
         CeldoXIA9rCHcYYu3LoVgFFPFhdn75l+SfiSxswWYg1RylT/F+MQStALkTDPEYVYAWG4
         9bpd34SuQ5RrMk/sMguiaAwu4oNv8jm28rA3388j48ZDNFpBwF26vPIPcVlE2ZJqEyTj
         PzRg==
X-Gm-Message-State: AOAM530WmvtSxVXVYwW7WdcNn/vgco6Shyw7Kn/yDFnEvsw2hWsuYp8V
	B2HK2vmrfQDpCJD2QQHP/gLvngMAj9EA7aJG
X-Google-Smtp-Source: ABdhPJxRGfIpB+EgSbSdxI+8WZ2r6A5yIGTwhiXoG1I6LlwSAxmaVZifMctGs2EYwqDCtFSoC1wMiQ==
X-Received: by 2002:aa7:de18:: with SMTP id h24mr4123828edv.389.1636714806576;
        Fri, 12 Nov 2021 03:00:06 -0800 (PST)
Received: from [192.168.178.46] ([213.211.156.121])
        by smtp.gmail.com with ESMTPSA id q7sm874501edr.9.2021.11.12.03.00.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Nov 2021 03:00:06 -0800 (PST)
Message-ID: <d71cacb5-7694-f714-8f7d-da50b73981c4@tessares.net>
Date: Fri, 12 Nov 2021 12:00:05 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH mptcp-next] Squash to "mptcp: sockopt: add SOL_IP freebind
 & transparent options"
Content-Language: en-GB
To: mptcp@lists.linux.dev
Cc: kernel test robot <lkp@intel.com>, Florian Westphal <fw@strlen.de>
References: <20211112104209.1991721-1-matthieu.baerts@tessares.net>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <20211112104209.1991721-1-matthieu.baerts@tessares.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hello,

On 12/11/2021 11:42, Matthieu Baerts wrote:
> Intel's kbuild found this warning:
> 
>    net/mptcp/sockopt.c:625:9: note: initialize the variable 'ret' to silence this warning
>            int ret, err;
>                   ^
>                    = 0
> 
> We don't use 'ret' at all in this function, we can then remove it and
> use '0' instead.
> 
> Fixes: 222f62c8bcf7 ("mptcp: sockopt: add SOL_IP freebind & transparent options")
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>

I just applied this patch in our tree:

- 5678002249d1: "squashed" in "mptcp: sockopt: add SOL_IP freebind &
transparent options"
- (I didn't add a Co-developed-by tag just for that)
- Results: ea9e134962cc..67feee727282

Builds and tests are now in progress:



https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20211112T105912

https://github.com/multipath-tcp/mptcp_net-next/actions/workflows/build-validation.yml?query=branch:export

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
