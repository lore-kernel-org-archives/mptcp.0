Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03A6B168
	for <mptcp@lists.linux.dev>; Thu, 30 Sep 2021 16:14:11 +0000 (UTC)
Received: by mail-ed1-f50.google.com with SMTP id v18so23592813edc.11
        for <mptcp@lists.linux.dev>; Thu, 30 Sep 2021 09:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=aBUOAJKF8yj1ypIk79rMIZqdZC9DwobescNSaDOto+k=;
        b=1f4HZp2eJYa6+3KPl9nymW3xsRboD+h8Rj0FY6Wuh4gGpw6QkPgicwt58LiYV/ELZC
         kf63uywTgyljExwJAwzk+LQCZOcgabcsHcXEy2ZZULlPxMdUNvpbzJEFbZfiOz3p47St
         WTe5vFIzFeilU9G92KPHTP+XH6am/BD6bpviTBiAOrcpRoPnQJIs5DCATFrK1RVxLqWC
         GQe/2v9ZIOwyyWO2w/Z2sGhxA34IyqcqsdEt4QNrEJ0B5h7Z5Y5SEx7lR54wAv9MRO/N
         +PuzJIFch+Le5z0Rr3Rq1qWPu5ggeUpqtCqqykYZ6c3zwKvvBxtXf28BQVmQY0WRlyqA
         TE2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=aBUOAJKF8yj1ypIk79rMIZqdZC9DwobescNSaDOto+k=;
        b=WocWw3JTml7Zv4MegjjHuRPRIgsC/irI8U2a15K/+Y+1z8O1PbuqR/nNWU/1pOc5RU
         gm2GDwiZBFCdJXrVGMZNt4q9VgBCrEeywVOzzP0D7f6bNlgEwY0BvPXY8SWm9zz2UtUu
         atSt7FZYgB+DjXH6HVkkTBkLuGbj0U0rPTlenlsLrBJAixVPRrmeEIb0YdcNlkV6dGRy
         UnHf7da8/SaqI48r9NOVe3MMwrEuc8VYa3P2xiM01xYc9gaEPjsja3vGT8pw8HqGsFBU
         U8gQgaggN4FlmGOh3cVA/sVl2n4EI9/9K3xHyBB7FwjOn5GtdNG6vPS3EzduOncr+O1v
         B3Ag==
X-Gm-Message-State: AOAM532y3R0l2km56XJgPIF7UverkoZhL749XOH4aleSjxBrVQUx5+o4
	TiqBkrOMWdp9ea//Aze/cSib5w==
X-Google-Smtp-Source: ABdhPJyQ+GydzthKXzDoudkxs+tcuNocp7LoVJMIUjVALy5R5KpAevxQnOF0fCSKz+rZyyrbKpgk4g==
X-Received: by 2002:a17:906:368e:: with SMTP id a14mr99860ejc.60.1633018370908;
        Thu, 30 Sep 2021 09:12:50 -0700 (PDT)
Received: from tsr-lap-08.nix.tessares.net (94.105.102.72.dyn.edpnet.net. [94.105.102.72])
        by smtp.gmail.com with ESMTPSA id e7sm2015141edk.3.2021.09.30.09.12.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Sep 2021 09:12:50 -0700 (PDT)
Subject: Re: [PATCH v3 mptcp-net] mptcp: fix possible stall on recvmsg()
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
Cc: fwestpha@redhat.com
References: <d3e857b6ba93e95976888ef95f6227c05bc79e27.1632858614.git.pabeni@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Message-ID: <493df150-0f1d-7588-d443-2b60578de28d@tessares.net>
Date: Thu, 30 Sep 2021 18:12:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <d3e857b6ba93e95976888ef95f6227c05bc79e27.1632858614.git.pabeni@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit

Hi Paolo, Mat,

On 28/09/2021 21:50, Paolo Abeni wrote:
> recvmsg() can enter an infinite loop if the caller provides the
> MSG_WAITALL, the data present in the receive queue is not
> sufficient to fulfill the request and no more data is received by
> the peer.
> 
> When the above happens, mptcp_wait_data() will always return with
> no wait, as the MPTCP_DATA_READY flag checked by such function is
> set and never cleared in such code path.
> 
> Leveraging the above syzbot was able to trigger an RCU stall:

Thank you for the patch and the review!

Now in our tree (fix for -net) with Mat's RvB tag and without a
Checkpatch warning (spaces vs tab).

- b7179850c2e3: mptcp: fix possible stall on recvmsg()
- Results: 3b6bbb41bc9e..4d16553077d4

Builds and tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20210930T161228
https://github.com/multipath-tcp/mptcp_net-next/actions/workflows/build-validation.yml?query=branch:export/20210930T161228

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
