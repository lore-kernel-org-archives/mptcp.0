Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7367D79D1
	for <mptcp@lists.linux.dev>; Thu, 13 Jul 2023 08:22:48 +0000 (UTC)
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-31441dfbf97so582615f8f.1
        for <mptcp@lists.linux.dev>; Thu, 13 Jul 2023 01:22:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1689236567; x=1691828567;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uCZYnOeQivGOjhsnD3wx8LV9H12T1ROjAGUCzV0MUI8=;
        b=Q3B0EhcmlRvgx3GF/HrD3KkmgN0+pozr+BZvqZWsjw8wvKDm6Mk2rtDIuKX0RJ9+aw
         ShLL5uLG71b9hv68+M8VWPsnmluF4uwG/W4mvGj5ocjPKEFUcFOKZb6TO8wXSYFUFo9P
         8OC6eoIXEjhyRF2883HGQAZWRuK4+3z5gU21frXRpt1Gs8/Tevy0Y/lWA6T6JfxDUBV4
         iK380fDcH1NbiL2jQ5MwZ1hDjk8gg0y7aIqV6BpCalwiHwChuGcE0j3WVGArqin6CZmv
         u+EJPJdBmSF4M5TUmznVKdr2vyUh7U3X0N91CQ/UUgvAeJMx2fvT3x26rARDahG0xVpQ
         4VCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689236567; x=1691828567;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uCZYnOeQivGOjhsnD3wx8LV9H12T1ROjAGUCzV0MUI8=;
        b=EAJALKE6vRWxAhwDG/8223xJ9m0DttWlwY7PccQH5cItt0SYQcm64c6clTbj2jokfg
         1i840rwfJvKGbSTEIlNkCVF2afiX6Y1bGYZp7giNoiCmXbHjcPoQAvOnUbo1GLB/I3Ae
         zM5xp+zxdPDvq+kSzukmuucB7UigM+0tmD2TkeTs4/5251G0H5ioGSedalpVBAg8/DKZ
         JhBFu0+t9kE7Gl/mI+YzudXQT8/d/ly7GqNJ51XoiaRiuf7gRRXzPRezUJo1Rv1XG3Zs
         VRD/y4yIZQvlCtTfauqC8dReweJRjYrw1/QeKwgdKrOQf9VUPkzMnpfE7P0WY2V3egUa
         odFw==
X-Gm-Message-State: ABy/qLYuaSkq68qW7Gs40Eet1B4DbzzbRKXnBj+mWzZ4hni40Bxq6OA6
	wBl3abeQYT0Wd62ll9HWIvTsrA==
X-Google-Smtp-Source: APBJJlEWsu5FGpjhhpB7/8xMej4OL7V1bHVmr5dR6Wb+W/jw2MCYDCrgm2Il7EZtm4oUkvijgPKf9w==
X-Received: by 2002:a5d:518f:0:b0:313:f9a0:c530 with SMTP id k15-20020a5d518f000000b00313f9a0c530mr737984wrv.52.1689236567107;
        Thu, 13 Jul 2023 01:22:47 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:c2e6:680:ced7:5e59? ([2a02:578:8593:1200:c2e6:680:ced7:5e59])
        by smtp.gmail.com with ESMTPSA id f14-20020a5d58ee000000b003143c532431sm7277767wrd.27.2023.07.13.01.22.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jul 2023 01:22:46 -0700 (PDT)
Message-ID: <c43a99a1-72f0-7ae5-c954-6d1932a7956d@tessares.net>
Date: Thu, 13 Jul 2023 10:22:45 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH iperf3] add MPTCPv1 support
Content-Language: en-GB
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
References: <298b8a39788b5b24db3abdce70323cc5a17dcbd1.1687843228.git.geliang.tang@suse.com>
 <724f9aa6-b66a-700c-a411-5aa19768af53@tessares.net>
 <8c868c93-86a0-39ab-57d6-e621c833f8bd@tessares.net>
 <20230713070345.GA19473@localhost.localdomain>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <20230713070345.GA19473@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 13/07/2023 09:03, Geliang Tang wrote:
> On Wed, Jul 12, 2023 at 10:14:31AM +0200, Matthieu Baerts wrote:
>> Hi Geliang,
>>
>> On 30/06/2023 18:03, Matthieu Baerts wrote:
>>> Hi Geliang,
>>>
>>> Thank you for this, that would be helpful!
>>>
>>> The code looks good to me, I just have one suggestion for the commit
>>> message, one "typo" with the alignment and one small suggestion in the
>>> code. Please see below.
>>>
>>> I think you can create a new PR on esnet/iperf repo (and mention it
>>> replaces the one of Paolo).
>>
>> What do you plan to do with this patch?
>>
>> There is no hurry at all to suggest it upstream (esnet/iperf) but it is
>> mainly to know if you are expecting something from one of us, just to
>> avoid a deadlock :)
> 
> Hi Matt,
> 
> Thanks for the review, a v2 will be sent later.

Thank you, no hurry at all, take your time!

If you prefer, you can also directly send the v2 to esnet/iperf repo, up
to you, I don't mind reviewing it before or after.

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
