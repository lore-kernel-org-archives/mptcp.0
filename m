Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2F7F7B
	for <mptcp@lists.linux.dev>; Tue, 25 Apr 2023 10:32:19 +0000 (UTC)
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3003b97fa12so3348087f8f.2
        for <mptcp@lists.linux.dev>; Tue, 25 Apr 2023 03:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1682418738; x=1685010738;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BiBTFiqj+tD6KYMSvWZyjg9cv8dyox095sVncjuwm9Y=;
        b=YVxkyMoKarcqW++Zy0E08jgE2gy7N+ipEPCnoZH6Lyap09W6efmUMjbaZNXq9e8THC
         RHt+NM3D+asZ+NMqFyUZ+Lrm7zLgg0qvEWU+mm96SfcHBr7SVt0036z1KewfACUHLlVP
         svsxTpO77YPKZ5BTAqVuGwc+1iJCayCBx46GqQggxwtkznT3xvv72pk1OPL/DikJhmh7
         1byIgna+PdfZxT5j7ABhnScQ5ti4Kf1ZqwbJa6GXehYQIkJbbCV/dduDopsQvEa/1SOH
         SsVJckQydYc5J8kcyDnF36XNFvDh+gz+B962kzxNbkdreflhQemSKnKrFLa1w1KS27/G
         dBLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682418738; x=1685010738;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BiBTFiqj+tD6KYMSvWZyjg9cv8dyox095sVncjuwm9Y=;
        b=RpRpRAUpk9/tnH/528hIAjJA2H+CUwVjgatkH6oln31mr0G1tzShWb5ykMx37QlBAA
         RbCxEZeC+6fMVirYYclC5KjluSo03iLSqUFAuAhWZ4sKCZgpR25EErPjnWDZnjzFcT4x
         bQ806R45S41Pf24EYWgI4T2WNn/VtPCIJp+UMJi/AYS6jPfe0bDomGcX55g/Ln6AhH/a
         s7L/GWprMgfi15DzBzo+AxYQQTGgGz8MIgfcDpDKjXXwfllYzd/ARsyxSru2dwOi/kGi
         alA4ljfPRAJmNKoaUQnsLPQ/KWOmKDAABps0hQSI4QSWry5k1VrmIeFO3IwfZqTqth2Z
         Xydw==
X-Gm-Message-State: AC+VfDyGzzUpxXXPne4LAs73UN+W4FkndpnZffb8KmNI2AZ3FYvz5zgM
	sQ9xPaFHHn8jvWRezekAb77VZlQoPV1LxUKHhzHcCg==
X-Google-Smtp-Source: ACHHUZ5Nr6kvjFwzzwIiMkFPwSdaJlIjpNJDkB6WSaBtOMH2QljOVjDf0dlacBzaE5857T6Fr/tmsQ==
X-Received: by 2002:a5d:43d1:0:b0:304:8888:87ad with SMTP id v17-20020a5d43d1000000b00304888887admr1755572wrr.12.1682418737970;
        Tue, 25 Apr 2023 03:32:17 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:61cc:5ecb:aad9:418c? ([2a02:578:8593:1200:61cc:5ecb:aad9:418c])
        by smtp.gmail.com with ESMTPSA id e5-20020a5d5005000000b0030469635629sm7775091wrt.62.2023.04.25.03.32.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Apr 2023 03:32:17 -0700 (PDT)
Message-ID: <62594b16-1797-86e2-1f9a-0d213d0b7c40@tessares.net>
Date: Tue, 25 Apr 2023 12:32:17 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH mptcp-net 00/13] selftests: mptcp: skip tests when
 features are not supported
Content-Language: en-GB
To: Mat Martineau <martineau@kernel.org>
Cc: mptcp@lists.linux.dev
References: <20230406-mptcp-issue-368-selftests-old-kernels-v1-0-246ac567724d@tessares.net>
 <03935b76-591d-85af-ad97-62c5ed5acedb@kernel.org>
 <798f7a6c-34b7-9285-8d4c-c05dd0f4936c@kernel.org>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <798f7a6c-34b7-9285-8d4c-c05dd0f4936c@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 25/04/2023 02:21, Mat Martineau wrote:
> On Mon, 24 Apr 2023, Mat Martineau wrote:
> 
>> On Fri, 7 Apr 2023, Matthieu Baerts wrote:
>>
>>> Selftests are supposed to run on any kernels, including the old ones not
>>> supporting all MPTCP features.
>>>
>>> These different patches add support for older kernels. More similar
>>> checks will be needed but here is a first batch not to have too many
>>> patches (because each patch fixes different commits).
>>>
>>> I tried to minimise the modifications and do the checks from the bash
>>> script not to have to detect the feature when being used in a .c file,
>>> then pass the info to the bash script, skip the test, clean the
>>> environment, etc.
>>>
>>> Link: https://github.com/multipath-tcp/mptcp_net-next/issues/368
>>> Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
>>
>> Hi Matthieu -
>>
>> The "skip if MPTCP is not supported" patches (1-7) and patch 10
>> (missing ip tool) look good to me:
>>
>> Reviewed-by: Mat Martineau <martineau@kernel.org>
>>
>>
>> I have some comments on patch 8 and related, I'll reply separately on
>> those.
>>
>> Thanks!
>>
> 
> One more question:
> 
> Did you check some older kernels to see how the tests behaved? So far I
> only had the chance to try 5.4 (because it was easily available). If I
> recall, we may have had some behavior changes along the way that could
> cause some test failures even if features are present.

Yes, I previously checked on v6.1 and in between, I also checked on
v5.15. That's why a v2 is coming :)

I didn't check on v5.10 but I don't think it is worth trying to support
it, mptcp_join.sh is validating a lot of unsupported features in v5.10.
But if someone else wants to look at it, why not :)

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
