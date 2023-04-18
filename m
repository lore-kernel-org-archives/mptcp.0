Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1B551C02
	for <mptcp@lists.linux.dev>; Tue, 18 Apr 2023 08:21:01 +0000 (UTC)
Received: by mail-ej1-f53.google.com with SMTP id dm2so71134796ejc.8
        for <mptcp@lists.linux.dev>; Tue, 18 Apr 2023 01:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1681806060; x=1684398060;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mVt5p7SShiItNbthKbmGtnFXX+qJqoqJaI2I752KVkg=;
        b=uEtL1ZqL/eFVPBp1abVDNNsi+trf45T2qFhVQwa82/HX2Ar9t5lVJHIkc1wuXNm28m
         9W7UCV6F/GgZFNVdwHJtkr0Wz39AjKl3KGqIr1iW121UEamENjUpAdN2X32T1c18ZYLP
         SV4Fj7/nLAelexcfgCJ2Y3DhDgKxKIs6y0GrBnN8YognD8yLDcIdLooFl9F1m4LKydZL
         ktyJYCUasWhFkWIQcPqZGBoW5ek4jjKlw04HYMQERG53YecTjfJqL9XMs6tmEug65fR2
         w3kLIM72C3ABiBb/7uQUzV0THYHOI8IHCCOhAX/4jOoQRYicqKaNG/QpC7AW4HjylbrA
         oZtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681806060; x=1684398060;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mVt5p7SShiItNbthKbmGtnFXX+qJqoqJaI2I752KVkg=;
        b=hRmEM48L2QgFKddtMTzl7fwwGjbKDf7B38WeqVGlSoG1CzxYDJenSSh89RBBpUfpyC
         n+zHZyhsCF3rfo1XUrardtKbH7P6H4EMshrEfsKyLt85KeOJL85f5Bc0QNHTHq1e8DDx
         3vVPWaP/XzEx2PM1wI6Q9Mk+Ihoz3hIcVj4iGP5ByWAYnZwO0G5i9din8FShB61YEKTL
         oPtIf82d4CTtQHGubzTTi4K+DfdxhskgPxSAfZFF5mFTmq1kJ5NdWTzNPfEMgUAIKWrE
         hDrt3WV18x30fMRr936bQDPmAXxe0ri6s2eWyy+/wKHtlFmGRUaRJEn7K+LoxfoLRaXP
         CMzg==
X-Gm-Message-State: AAQBX9cP1HIprTWxM3uPTt66PGj9CwNFsLZHPEZ7WrE4rcuQ0/Az3WV0
	PIuVkTvtLudrRALjhnpkcWRTgWHVY/FMn1Bi2pWSBw==
X-Google-Smtp-Source: AKy350a+ECCbQGJPyhw3g/0pWimGPzQ/e7vUyzS7115QeTb93xC7pUExs4sGa0ClMWdqL/Z0iOJilQ==
X-Received: by 2002:a17:907:6d93:b0:94f:6c6c:e14c with SMTP id sb19-20020a1709076d9300b0094f6c6ce14cmr6526198ejc.57.1681806059688;
        Tue, 18 Apr 2023 01:20:59 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:3cb9:953f:8660:73e? ([2a02:578:8593:1200:3cb9:953f:8660:73e])
        by smtp.gmail.com with ESMTPSA id dy11-20020a05640231eb00b00506956c99d9sm3844227edb.15.2023.04.18.01.20.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Apr 2023 01:20:59 -0700 (PDT)
Message-ID: <8bf71db3-aa30-6991-e9db-82696cfa3213@tessares.net>
Date: Tue, 18 Apr 2023 10:20:58 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH mptcp-next] mailmap: add entry for Mat Martineau
Content-Language: en-GB
To: Mat Martineau <martineau@kernel.org>, mptcp@lists.linux.dev
Cc: Mat Martineau <mat@martineau.name>
References: <20230417-mptcp-mat-alias-v1-1-abe486377b02@tessares.net>
 <fa956ceb-cdfa-5acf-ed1b-7fbe4a2cdef7@kernel.org>
 <6772d944-fa7d-b840-04e5-c46600c8c8f3@kernel.org>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <6772d944-fa7d-b840-04e5-c46600c8c8f3@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Mat,

On 18/04/2023 01:54, Mat Martineau wrote:
> 
> 
> On 4/17/23 4:25 PM, Mat Martineau wrote:
>>
>>
>> On 4/17/23 10:25 AM, Matthieu Baerts wrote:
>>> Map Mat's old corporate address to his kernel.org one.
>>>
>>> Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
>>> ---
>>> Mat's address is still being used because get_maintainers.pl will look
>>> at the Git history.
>>>
>>> @Mat: still OK to use your kernel.org one?
>>
>> Hi Matthieu -
>>
>> Yes, martineau@kernel.org is what I plan to use going forward. Thanks
>> for creating the commit!
>>
>> Signed-off-by: Mat Martineau <martineau@kernel.org>
> 
> Oops, maybe I should have said:
> 
> Reviewed-by: Mat Martineau <martineau@kernel.org>

Thanks!

>>> ---
>>>   .mailmap | 1 +
>>>   1 file changed, 1 insertion(+)
>>>
>>> diff --git a/.mailmap b/.mailmap
>>> index e42486317d18..ad1d3c166e64 100644
>>> --- a/.mailmap
>>> +++ b/.mailmap
>>> @@ -297,6 +297,7 @@ Martin Kepplinger <martink@posteo.de>
>>> <martin.kepplinger@puri.sm>
>>>   Martin Kepplinger <martink@posteo.de>
>>> <martin.kepplinger@theobroma-systems.com>
>>>   Martyna Szapar-Mudlaw <martyna.szapar-mudlaw@linux.intel.com>
>>> <martyna.szapar-mudlaw@intel.com>
>>>   Mathieu Othacehe <m.othacehe@gmail.com>
>>> +Mat Martineau <martineau@kernel.org>
>>> <mathew.j.martineau@linux.intel.com>
> 
> Oh yeah! Can you also add
> 
> Mat Martineau <martineau@kernel.org> <mathewm@codeaurora.org>
> 
> to cover my old Bluetooth commits?

Sure, good idea!

I will send this directly to netdev, for the net tree, no need to add
that in ours :)

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
