Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05DA72C98
	for <mptcp@lists.linux.dev>; Sat, 23 Oct 2021 07:34:49 +0000 (UTC)
Received: by mail-ed1-f54.google.com with SMTP id e19so4439725edy.0
        for <mptcp@lists.linux.dev>; Sat, 23 Oct 2021 00:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=1oDC8GrcMW+Sfv2DijuB1bNBNGyk+QkUqSh7qyiY30w=;
        b=IHRKEo5cSBRXAGPGUVKtoLihJbKvDh7o/704W7ihL2yF1DDxHWNhj/bVZaAnq/F2YW
         +YdvtM2Vr8akfCf4uMYs4yK1Fl5LKpuw4s0QEJ8iuW7BzpkXhyeyHnzVayBqwy4Vt3wl
         gMPlPY2NmVQ5HdMvCxmR10y8YGMlQaXqzHfYdlKyxLBDObfMB5UO4bwV5BsQGx0NrrNV
         zPd5EJDJnLFtSdgBu6HbKCRC0+wJrQy1rnmEYlikDTDjy807+9mw8z/WgVwhyPdShEwb
         I8q733bsaEQy2+3igUhzOj8stR4Xqo8nyM6eMioG5fiHMYauxzC8snITO4D23vIDt3dD
         O4Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=1oDC8GrcMW+Sfv2DijuB1bNBNGyk+QkUqSh7qyiY30w=;
        b=PBgqbBd+PcpyK6DIsoZZLaRCFQDa1WRNruta8xqrbZ+24FZoqRw5cG7NfbW6OwM1g3
         4+T1MN9crD+pvjNzyxIlKoyWnZ5w2Kuu6z5vegCXQoq7ZhoLGQPrp03o/gcNmhutiRTK
         t/TrV3yKh9wNQqzYvlF9oi8tJxu20fTQ6cnkvgZgpmGThVJhS7hzScvMSavazwZU0tFr
         gYQhEurQ47xnCt40dYMaGppFcgNIk055GKTwjHkE3JD7iA+dbCF0lzYSpopR5KnP2sXI
         T25iILlM4L3OEu25F9Bajcqn5wguv1urJrp9th4GenhXj/O/SxBTBB/RrWkQVynwdLNG
         rTlw==
X-Gm-Message-State: AOAM531Gjax4nAiJWTBY0X25PaPkE4ktwR4PaYKHBVc1SEljq7zVK3U8
	3VXJiN7gTmUo2iltSOQc/+HRp8QEHeRN5g==
X-Google-Smtp-Source: ABdhPJzkqo1L0km/Va6kUWa2KAc301Cyml74RBJunrThPRQHAd2ObVFJrIcA+AyMQtZai/aQrBUHsg==
X-Received: by 2002:a17:906:3b03:: with SMTP id g3mr2847541ejf.52.1634974487848;
        Sat, 23 Oct 2021 00:34:47 -0700 (PDT)
Received: from [192.168.178.46] ([213.211.156.121])
        by smtp.gmail.com with ESMTPSA id mp5sm3019497ejc.68.2021.10.23.00.34.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 Oct 2021 00:34:47 -0700 (PDT)
Message-ID: <18e6872e-5fcf-000d-26d1-93eaf0f17ddb@tessares.net>
Date: Sat, 23 Oct 2021 09:34:46 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.2
Subject: Re: [PATCH mptcp-next] mptcp: enforce HoL-blocking estimation
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>, mptcp <mptcp@lists.linux.dev>
References: <22cda018a37459d99683e572e35ac61bbc43fcae.1634900440.git.pabeni@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <22cda018a37459d99683e572e35ac61bbc43fcae.1634900440.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo,

On 22/10/2021 13:38, Paolo Abeni wrote:
> The MPTCP packet scheduler has sub-optimal behavior with asymmetric
> subflows: if the faster subflow-level cwin is closed, the packet
> scheduler can enqueue "too much" data on a slower subflow.
> 
> When all the data on the faster subflow is acked, if the mptcp-level
> cwin is closed, and link utilization becomes suboptimal.
> 
> The solution is implementing blest-like[1] HoL-blocking estimation,
> transmitting only on the subflow with the shorter estimated time to
> flush the queued memory. If such subflows cwin is closed, we wait
> even if other subflows are available.
> 
> This is quite simpler than the original blest implementation, as we
> leverage the pacing rate provided by the TCP socket. To get a more
> accurate estimation for the subflow linger-time, we maintain a
> per-subflow weighted average of such info.
> 
> Additionally drop magic numbers usage in favor of newly defined
> macros.
> 
> [1] http://dl.ifip.org/db/conf/networking/networking2016/1570234725.pdf

Thank you for looking at that!

It improves a lot the situation! I ran the new version in a slow
environment with a "debug" kernel and it fails after 806 attempts! (more
than 16 hours ;-) )

# unbalanced bwidth with unbalanced delay: transfer slower than
expected! runtime 4011 ms, expected 4005 ms max 4005        [ fail ]

I usually have:

3923 max 4005
3922 max 4005
3872 max 4005
3880 max 4005
3801 max 4005

So all good I guess. We can then close 137, no?

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/137
Tested-by: Matthieu Baerts <matthieu.baerts@tessares.net>

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
