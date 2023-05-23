Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E56371F922
	for <mptcp@lists.linux.dev>; Tue, 23 May 2023 15:20:04 +0000 (UTC)
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3093eb8cd1fso4782447f8f.1
        for <mptcp@lists.linux.dev>; Tue, 23 May 2023 08:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1684855203; x=1687447203;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UMdsLzCt245ZaBRaS1W1mN2Bc7ESfbpLfdY/Ck7zO0s=;
        b=H+PPPP6t+1mMwP/kgToloLj4tq3vKH/miagvJPAijkS2osbXhYJR4ZnBsXtkgi2+hx
         r5F7FRxN6VaOZpB2EkcN7fpjGiL79Tj+mAmqLLQVW2VEbJWdT8RGQTRtO6RyWJ7pMoQ9
         7QdduNKfhjsEnAlkgaYTb/Jf0z5P5Bi6QYrEx7cR4C32U2p9GVjAvD2DAznBRHzwg2Xm
         78uzXwky0tGRfmCUA4UadC8BaANYMP5Cxn/E7UfuDF9Vt9ca81fyhGPrl9QYCBcgJF5H
         tCIWfpj98/qyEDXEXnL1WFI4xy/00S+dsGAqhHE0w148SzH+hutQks6Ec8qucOGxMJBJ
         MArA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684855203; x=1687447203;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UMdsLzCt245ZaBRaS1W1mN2Bc7ESfbpLfdY/Ck7zO0s=;
        b=NUS1UnW8g7wzSwgM+knQEUFgCbskrJt/1a1Z8ufgra7LF4eMdkZr0AAGxWyagHguC2
         70elavjJUfX6OmLqnuTz4ESXs77nQJAJAB1UEUB/Bk3THJcGbw7MppS14kxVVWYSc3Ds
         2+Doi8vhZU/Z5BfBkMvmnsRkJ+YZkSMXo9WY3vzDNRSCf/JHfeTpD0FgICzidEBeQhH5
         yBgdsWO0EVwOyMKPkaj5LXd7eZu9iAsfziBam9aIH/9Ok3Ory63J9OHVYGeA4IFOFeE5
         3Y0prJWjh/L50+tNwFE3AMnm5guRUmNM0/zSHv6JmqzOCvRxrLisT96EbzX+vQiPx2hg
         xXSA==
X-Gm-Message-State: AC+VfDxxy9DQ2ZS1pavMrx7LipFf0E282yhUs2PMhLubPTzcE5yeSW0J
	v/BxhHPlTUPr7aNuuqSbV+Znzg==
X-Google-Smtp-Source: ACHHUZ4IrbImwDzbCgNW0w/Jto7Bu7UaIBuYcCAKRU2ZurX44u9mxRXCLYvcVr/v2MxKUkDwJwfoVw==
X-Received: by 2002:adf:f64c:0:b0:309:43cd:484d with SMTP id x12-20020adff64c000000b0030943cd484dmr10065629wrp.27.1684855202759;
        Tue, 23 May 2023 08:20:02 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:6cb1:7d36:3be3:30d? ([2a02:578:8593:1200:6cb1:7d36:3be3:30d])
        by smtp.gmail.com with ESMTPSA id n11-20020a5d484b000000b00307c0afc030sm11619953wrs.4.2023.05.23.08.20.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 May 2023 08:20:02 -0700 (PDT)
Message-ID: <18e20b8f-aaf1-81ae-1f88-8572bf270098@tessares.net>
Date: Tue, 23 May 2023 17:20:01 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH mptcp-next v2 1/6] mptcp: add subflow unique id
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
References: <cover.1684763196.git.pabeni@redhat.com>
 <82dfa3a412939eb515bba411d8aa585f987e61f6.1684763196.git.pabeni@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <82dfa3a412939eb515bba411d8aa585f987e61f6.1684763196.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo,

On 22/05/2023 15:56, Paolo Abeni wrote:
> The user-space need to preperly account the data received/sent by
> individual subflows. When additional subflows are created and/or
> closed during the MPTCP socket lifetime, the information currently
> exposed via MPTCP_TCPINFO are not enough: subflows are identifed only
> by the sequential position inside the info dumps, and that will change
> with the above mentioned events.
> 
> To solve the above problem, this patch introduces a new subflow identifier
> that is unique inside the given mptcp socket scope.
> 
> The initial subflow get the id 1 and the other subflows get incremental
> values at join time.
> 
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> v1 -> v2:
>  - properly set subflow_id for the first passive subflow and active subflows, too
>  - drop the tcpi_fackets overload
> ---

(...)

> @@ -3203,6 +3206,7 @@ struct sock *mptcp_sk_clone_init(const struct sock *sk,
>  	msk->snd_nxt = msk->write_seq;
>  	msk->snd_una = msk->write_seq;
>  	msk->wnd_end = msk->snd_nxt + req->rsk_rcv_wnd;
> +	msk->subflow_id++;

It is a bit confusing. Just to be sure, here it would be the same to do

  msk->subflow_id = 1;

because subflow_id from the listener will be 0, right?

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
