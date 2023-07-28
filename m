Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4642514283
	for <mptcp@lists.linux.dev>; Fri, 28 Jul 2023 15:55:17 +0000 (UTC)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-99bed101b70so125991066b.3
        for <mptcp@lists.linux.dev>; Fri, 28 Jul 2023 08:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1690559715; x=1691164515;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2BDsJeZ/Q7mDDxKjh2UMKBKrejicN4zQCXzZIHx4SEo=;
        b=F/VsCvxgooS8Z+8br6a6n7CavdfNpXvYEXc5lADrXoJ28GtUbfSMtPElK0cwmi0aAK
         WYFWAXv90swmwUZlxpw1hKH2vbJT9bO6+sLLUxx7Vognrpld1P6t3olT5ciHLO5IMzFW
         bnI7pGEOIfWaci0LaPMx1Aqyp4Fbh/DT++o7grL7srfQdho+d9qKKBlx5PYM/tZduFDk
         tBMmmLlhdbYe/ZpZC7pbuYSBqqW6HgT/VjlaWNZDPJSwerKij2qQ8JcjLskQbVGXfywZ
         XPrJQ+8Mm+bAoMyHAS+wtHLhOJ2M8IAZdb3+ev/6moP5NgCXJhK7LBPpoWAKcVlJeA72
         TgHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690559715; x=1691164515;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2BDsJeZ/Q7mDDxKjh2UMKBKrejicN4zQCXzZIHx4SEo=;
        b=B+9CUYOHD9XyE41H01za2otntNoLdY8W+/OSZrGq9jw3UAinGC89H6b7hj6o8mD+MT
         kr4vZO6FDwp9SDaeof06B74CZt8K7pUPE/E/zFOO/MmuWuD10aJQB4dGRuCah93RFUqx
         qyCEjKOMO1HA8GWDCyvxlZGhKAh9y/oGzotfFDxERxUTYB13hRuORDGXsd2E2essCRSW
         aQOCRTevEzixFc7vhyOFdbcTH7pFLFlI7FT/wvd0qeZRzztnFBg9ATIJ7GJj5SF9XTn0
         XZN7Vp4taniZg6/jjjgUxKGRLO2ETSbU89bnlf10ctTaCmNWRQUx588c/vfTLg9i7R+n
         FcTA==
X-Gm-Message-State: ABy/qLYB7Cv4juOzZ7y2mu65IQ+u0eWtDSXY9xum94UoEvH+xzyIGrCJ
	EU+/faI0210DhqYLnkrgCEDm+A==
X-Google-Smtp-Source: APBJJlH7Ioi3ik/60g8z602pHSDWlX6bY7ooZ1oWoIklY+YXe34YWcg+8fL5KiQ6aCzPuhQiDY4VMQ==
X-Received: by 2002:a17:906:32d7:b0:99b:f3f5:9752 with SMTP id k23-20020a17090632d700b0099bf3f59752mr1345815ejk.14.1690559715141;
        Fri, 28 Jul 2023 08:55:15 -0700 (PDT)
Received: from [10.44.2.5] ([81.246.10.41])
        by smtp.gmail.com with ESMTPSA id e20-20020a17090681d400b0099b8234a9fesm2194730ejx.1.2023.07.28.08.55.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jul 2023 08:55:14 -0700 (PDT)
Message-ID: <b9ca829c-790f-82bf-f0a9-c0d81792ce01@tessares.net>
Date: Fri, 28 Jul 2023 17:55:14 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH mptcp-next v2 08/13] mptcp: add subflow_set_stale helper
Content-Language: en-GB
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
References: <cover.1689650435.git.geliang.tang@suse.com>
 <94b445b3225d4f91e2d05cab0338c4367ecbabb4.1689650435.git.geliang.tang@suse.com>
 <f678a249-e191-05ca-012f-28811c520b51@kernel.org>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <f678a249-e191-05ca-012f-28811c520b51@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Mat,

On 28/07/2023 03:30, Mat Martineau wrote:
> On Tue, 18 Jul 2023, Geliang Tang wrote:
> 
>> Add mptcp_subflow_set_stale() helper.
>>
> 
> I was trying to remember the use case for this. The closest thing I can
> find is this:
> 
>     => the scheduler should be able to interact with the "stale" logic
>        we have in the upstream kernel: mark a subflow as stale / back
>        active.
> 
> from
> https://lore.kernel.org/mptcp/dd4363e7-d057-97e8-0b5f-8570f39aa538@tessares.net/
> 
> I think that need is met by the change in patch 11 to export
> mptcp_pm_subflow_chk_stale - if a particular scheduler wants to track
> some stale-like metric, it can do so with its own sk_storage values.
> There's also the matter of coordinating the values of stale_count and
> stale_rcv_tstamp.
> 
> My suggestion is to drop patches 8, 9, and 10 unless there's a
> compelling reason to allow a BPF scheduler to control this bit. If
> there's a need for it please speak up!

If I'm not mistaken, the 'stale' logic is currently used by the core not
to use a subflow (when calling mptcp_subflow_active()). A packet
scheduler might want to proactively mark a subflow as stall, e.g. if the
latency is too high, too many retransmissions, etc. and just set the
subflow as stale.

But maybe we cannot do that because the core will reset stale in some
conditions? Maybe we need something similar but not reusing "stale"?

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
