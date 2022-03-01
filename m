Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF005A0A
	for <mptcp@lists.linux.dev>; Tue,  1 Mar 2022 10:09:36 +0000 (UTC)
Received: by mail-ej1-f49.google.com with SMTP id qx21so30378315ejb.13
        for <mptcp@lists.linux.dev>; Tue, 01 Mar 2022 02:09:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=wj0ontzEcOyYcSbv1Xg4cM9AP2mbmQ+DUhV8t2eqwWI=;
        b=lCrTASFpGhfrTc+ho0DfcrQXxvc9REHVSndNAia3P5jDYqEaeoyrwpRHxYboCHAWRT
         rQjlgq/hv5wTpV/yCTeWU2Av9wnRqon/++Rqdow5DPHqMeSMHsJtQAUHl4Uo0qfUA3Wz
         FoBTlpkgWOh9fQhA6cvoiaa+okSHXiWJaYLf3a29Rj3G6FTS7DAX5p5RPwWKlVEj0AKY
         BdCxBXFxsKaoUTNxiLalGRY4kp3whJPT69Rs2sUHynL2jFyMDQl/RILWcIFmMLC7SwfL
         MkRJ1siDfSKBMWH97ASfDbC5HZmHaiGoS0MrkfF0k+wdEwNMELj7Ww6aKe+1EkevrLr6
         OsxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=wj0ontzEcOyYcSbv1Xg4cM9AP2mbmQ+DUhV8t2eqwWI=;
        b=GC18kDDUVS0Qa/pdKG5a8IUUFLMLulMqTkOvbVAHA2eyzorTeLvQAAjRrFs+kpYhCI
         thPuyTD0jcpI1hxu1UIDGcpe9xKkdwAGwnAsflabiqVuMSjEosntLPZQ/pTNfOoRmAyr
         6bVqV4eDWc8/t+XTIQfvZ9KZHMkygR+hL6VL6MLl9PnQqMxKkGip5T8ZCiRMsR9rs9ni
         A9DdKnxQZ+y6TMWFjS6xDMEawL761raH5crufshqFqL3p/82pfleVibBPc82aL+4KoeW
         3URilNx1iDPMZ9zN1c+UWX30hPc1CcjUI554kWn7P9MzzzUs6JDVjxGHr4VrY3NyIbaC
         uBhQ==
X-Gm-Message-State: AOAM531fiq9n9vbwS2554dnpzC1on4KDE+LYF25d6+9Vkxwq2rWuZuRC
	3uAwR3ChKQB0CWOzc0epxvyk5KSeE9Iqlf9q
X-Google-Smtp-Source: ABdhPJzV8MeDP/J3cPkdmVcolvC4NBO/o5SGHvOWQlimTupsbW+ncKEUlUb3t89EWB153iryFTnQSw==
X-Received: by 2002:a17:906:9605:b0:6cd:47e8:3b5e with SMTP id s5-20020a170906960500b006cd47e83b5emr17944792ejx.360.1646129375045;
        Tue, 01 Mar 2022 02:09:35 -0800 (PST)
Received: from ?IPV6:2a02:578:8593:1200:9adc:7cd9:4239:a8d7? ([2a02:578:8593:1200:9adc:7cd9:4239:a8d7])
        by smtp.gmail.com with ESMTPSA id r19-20020a17090638d300b006d6e4fc047bsm509720ejd.11.2022.03.01.02.09.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Mar 2022 02:09:34 -0800 (PST)
Message-ID: <838d6b14-6e7c-afd6-cbca-5ebef2bc2f37@tessares.net>
Date: Tue, 1 Mar 2022 11:09:34 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH] mptcp: send ADD_ADDR echo before create subflows
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>, Yonglong Li
 <liyonglong@chinatelecom.cn>, mptcp@lists.linux.dev
Cc: mathew.j.martineau@linux.intel.com
References: <1645779233-19742-1-git-send-email-liyonglong@chinatelecom.cn>
 <67e97880f72920d45e6ef9dbb55b7e626363a28f.camel@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <67e97880f72920d45e6ef9dbb55b7e626363a28f.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo,

On 01/03/2022 10:15, Paolo Abeni wrote:
> Hello,
> 
> On Fri, 2022-02-25 at 16:53 +0800, Yonglong Li wrote:
>> In some corner case, It may receive ADD_ADDR retransmit package
>> before created subflows done.
>> It's more reasonable to send ADD_ADDR echo before creating subflows.
>>
>> Signed-off-by: Yonglong Li <liyonglong@chinatelecom.cn>
> 
> The patch LGTM, and beyond fixing some corner case it looks like a nice
> cleanup.

Can I add your Acked-by? :)

> I think the changelog could be clairified a bit (even if I'm possibly
> the last person to give this specific kind of adivice ;). What about
> something alike:
> 
> """
> In some corner cases, the peer handing an incoming ADD_ADDR option, can
> receive a retransmitted ADD_ADDR for the same address before the
> subflow creation completes.
> 
> We can avoid the above issue by generating and sending the ADD_ADDR
> echo before starting the MPJ subflow connection.
> """
Good idea! Indeed clearer with this updated commit message.

> @Matt could you handle such change while applaying the patch?

Sure I can if there is no objection from Yonglong!

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
