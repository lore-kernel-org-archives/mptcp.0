Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B59E7F
	for <mptcp@lists.linux.dev>; Tue, 17 May 2022 07:01:30 +0000 (UTC)
Received: by mail-ed1-f46.google.com with SMTP id g12so5811916edq.4
        for <mptcp@lists.linux.dev>; Tue, 17 May 2022 00:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=DRGKs1GN7uGV/MGON3ombxJkQtTa5l08+qO7U3wn8nU=;
        b=hr37GqZwcTl34bfUcDXbDv43lSD547/gPK3gP9hcAMulCEwmOpQd/pv2hIV/oltxrm
         Tz4EwFb4J3IEBktK0JhsWNTU6g9OMMVoR6lOgREFHs0crVdMubphUOSSx+4mgG8hDXru
         TDqgKTy9ac3CdLthzlUIRPABfpPK1E149d5A3UDdVsnHxnc1P1QYW1LxCIgBozUZ7bzN
         cy3SQ8owigksOzkrJnoPkoI478/o1odxQn2QZZrQcxr6s3F9ZOrnjY2n99axIkQEO0AF
         FlkoPuF/AEKWSQRHHxbNZkk2Jnp1mZr1tUkxJzy6FT+bAXvcMputmBH8LpluPO31nQmg
         amHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=DRGKs1GN7uGV/MGON3ombxJkQtTa5l08+qO7U3wn8nU=;
        b=GDD/+Ij52Fw7wgtjhXIFUCadqlWaJYNP7yXO1IFXSN05u8S8cc3enE5tD5618rdDo3
         sHqmfdsTm3FwEtMF6RQIyjM5cwKACghyr2eAB4T9GU2f270nVQbTh5ArHGAUD6P48N+l
         N5chmI9PG8NlW1Fpbwxu+cEnEG19G7CCuBia9qlrr1ewbKQ9ehGv2a6yVEMC0lBBz+rN
         FXtcZ2mAem5lDhsAGtCXy8Ff9rtM+yO4KM0l1Et6XJi4uP5HPN+NSGQCXy2LcU8M451S
         dX9dZahvhM36Y/bbZdgOtyIPDy4t4FvC5vcjnB7iBeExHCrsRBgdyuh4CuMfezVkLBfu
         lV8Q==
X-Gm-Message-State: AOAM5335EE8SgSEljSSqv+AiLw9LCiTnqgiVJazPQUXkBGDoo3M9K5jN
	WuLN/gkTXPh+yupeTT7f/pMxug==
X-Google-Smtp-Source: ABdhPJwC9pvT00blFTgIzjqRizPpW4p8jwKdqqkW4kW+Gecj3wcm9Bv6gaGyNgoQZizs2DSdugjVTA==
X-Received: by 2002:a50:9b08:0:b0:42a:2d15:e15a with SMTP id o8-20020a509b08000000b0042a2d15e15amr16966095edi.361.1652770888308;
        Tue, 17 May 2022 00:01:28 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:e69d:55f5:f7d9:4300? ([2a02:578:8593:1200:e69d:55f5:f7d9:4300])
        by smtp.gmail.com with ESMTPSA id u7-20020a1709060b0700b006f3ef214dc1sm670444ejg.39.2022.05.17.00.01.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 May 2022 00:01:27 -0700 (PDT)
Message-ID: <49ee2e2e-8fd3-dedd-8aac-566b6e0e07c9@tessares.net>
Date: Tue, 17 May 2022 09:01:26 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH net-next 1/3] selftests: mptcp: fix a mp_fail test warning
Content-Language: en-GB
To: Jakub Kicinski <kuba@kernel.org>,
 Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: netdev@vger.kernel.org, Geliang Tang <geliang.tang@suse.com>,
 davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
 mptcp@lists.linux.dev
References: <20220514002115.725976-1-mathew.j.martineau@linux.intel.com>
 <20220514002115.725976-2-mathew.j.martineau@linux.intel.com>
 <20220516131346.1f1f95d9@kernel.org>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <20220516131346.1f1f95d9@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Jakub,

Thank you for the review and for having applied the patches!

On 16/05/2022 22:13, Jakub Kicinski wrote:
> On Fri, 13 May 2022 17:21:13 -0700 Mat Martineau wrote:
>>  	tc -n $ns2 -j -s action show action pedit index 100 | \
>> +		grep "packets" | \
>>  		sed 's/.*"packets":\([0-9]\+\),.*/\1/'
> 
> sed can do the grepping for you:
> 
> sed -n 's/.*"packets":\([0-9]\+\),.*/\1/p'

Yes, thank you, that would have been shorter!

> But really grepping JSON output seems weird. Why not use jq?

We started to use 'jq' because we originally had to extract a few values
from this command. At the end, we only needed to extract the number of
packets and we didn't want all MPTCP tests to depend on 'jq' just for that.

But because 'jq' is already needed for a few other selftests, next time
we need to parse a JSON, we should use 'jq'!

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
