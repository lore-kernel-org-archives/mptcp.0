Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42ED73FC1
	for <mptcp@lists.linux.dev>; Tue, 24 Aug 2021 07:28:38 +0000 (UTC)
Received: by mail-ed1-f44.google.com with SMTP id cq23so30077195edb.12
        for <mptcp@lists.linux.dev>; Tue, 24 Aug 2021 00:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=c6GWBa06nkMUUT4xQR+i9wt0iGOaVj/Wq8jvzy7JYHI=;
        b=c4P8lzgZL1QG2x6ktVNzCzpZaEDe7GnLO/lnXzrH0ln1rWUo+tR7/jLaUqbVeblzaC
         kC2mvlnn7h+afpoQd1hkIp9trScThMRHb0ugyYvJn6UpjPd2eDbAywHDr4HvzEQTRDhZ
         Y4jhdGd7IG2KMhTUVI1T31Ntg4ydHDzlLF+tQc9Si0qSSYDBnoAk8YkqYrHlJupcG9J1
         yegjoVqY73pT6kgQVUhj/59JCAXLn8JDGrTAhb433mQaL3rFuxHFFY7P79gp8CVsbego
         4HO1KtJsXoPsC8pawgRnWCH0J4e4j3F1eSNYmkRTBBLokoGiLeXjdmyAk31OfUD6DKeb
         D3XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=c6GWBa06nkMUUT4xQR+i9wt0iGOaVj/Wq8jvzy7JYHI=;
        b=X8RTdQznRp/Ekwtu4byojpsIa/WLVxC7/cw6ybEgHTcF61ueWbttSgpRwPFEKo2Lkd
         Tdd7JCAZYCB2PN/pmLwh28ofiIBpioP6J+n3ggrPkAF/9daXxO5qZKZByxPPf5m4R0+M
         M/8C+Gn2G8A6Zie9icTigy24bjJofb9pzVaRHgHCigjXphpQxF10EODgOpkgjIlu/G4f
         REXcndodz1e4/+TopzOKiidCnvQsQUAOhc1hljvqHVrCUGptAX8UWnPfsf+yu5taaPF3
         8AVpnKnc6BRoPCT19O4ibw7TWLf2kRQGyv1bZrXHI5UYP44k1YLMSumCLoLkZ04k0ocD
         SNvQ==
X-Gm-Message-State: AOAM533qlSeksBiwGqeB6X2QYSvPcINAI3FtZ2Tjk8RuQ9NUjvxzepSo
	N3RJp+lCJ4i7Rd8zGPEuvOJIrw==
X-Google-Smtp-Source: ABdhPJxvMxkPemRDNtTzqWp7w5HrDOVs/DYk2ABJjaoM7nnkc/iNCOyialGJwmgKh8QDOSuicMMyXQ==
X-Received: by 2002:a05:6402:1b01:: with SMTP id by1mr23827223edb.2.1629790117380;
        Tue, 24 Aug 2021 00:28:37 -0700 (PDT)
Received: from tsr-lap-08.nix.tessares.net (94.105.103.227.dyn.edpnet.net. [94.105.103.227])
        by smtp.gmail.com with ESMTPSA id ay20sm10955243edb.91.2021.08.24.00.28.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Aug 2021 00:28:36 -0700 (PDT)
Subject: Re: [PATCH mptcp 1/2] mptcp: fix possible divide by zero
To: mptcp@lists.linux.dev
References: <cover.1629481305.git.pabeni@redhat.com>
 <286de8f451b32f60e75d3b8bcc4df515e186b930.1629481305.git.pabeni@redhat.com>
Cc: Paolo Abeni <pabeni@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Message-ID: <e6347ff5-8c64-2467-e7db-f42b169821f9@tessares.net>
Date: Tue, 24 Aug 2021 09:28:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <286de8f451b32f60e75d3b8bcc4df515e186b930.1629481305.git.pabeni@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit

Hello

On 20/08/2021 19:44, Paolo Abeni wrote:
> Florian noted that if mptcp_alloc_tx_skb() allocation fails
> in __mptcp_push_pending(), we can end-up invoking
> mptcp_push_release()/tcp_push() with a zero mss, causing
> a divide by 0 error.
> 
> This change addresses the issue refactoring the skb allocation
> code so that skb allocation always happens after the call
> to tcp_send_mss() correctly initialize mss_now.
> 
> As side bonuses we now fill the skb tx cache only when needed,
> and this also clean-up a bit the output path.

For those who might have missed the info, a regression has been
introduced by this patch.

This is tracked on Github:

  https://github.com/multipath-tcp/mptcp_net-next/issues/227

(Paolo already shared a patch that seems fixing the issue)

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
