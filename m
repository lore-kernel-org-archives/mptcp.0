Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EC36168
	for <mptcp@lists.linux.dev>; Fri,  7 Jan 2022 11:03:02 +0000 (UTC)
Received: by mail-ed1-f44.google.com with SMTP id m21so20907553edc.0
        for <mptcp@lists.linux.dev>; Fri, 07 Jan 2022 03:03:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=/V4fpOsAJYUA6mEOi8ZjjeRM2Egwg2KmD11fE5oD6Zs=;
        b=wm3w0pDQUfHy6OAlJbkBTPr5Yx9E2VCFkFRgww/DDjfa9HZZ6J9fmiuYPWq07T2/pB
         7SVbtrLhGQfUIg4zdiJY+P1MiNahdJSyOT5zcEos5WXh3OMHkIz4dwn4xf35uO94dqGn
         YgVn6stLbUJXEuQ6uqwdjfbSOUJOLcQ3t3QsmDVJzlzijngonSL61pSW4GI9iDVtI4W9
         ojxHfJpZK4UyDcc/DA6OGCG2IeQqFxJ53i4xBP005pIdsXvz9u5Z2oUDh7tSpKxPKeea
         PhL3C3rsJ8jw0aGSISaTeNNqmTrQM0JfrflaA1kvwCKOTyK1u7r6PkmdADyCfkwotve4
         33Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=/V4fpOsAJYUA6mEOi8ZjjeRM2Egwg2KmD11fE5oD6Zs=;
        b=Wc6Mnf4IjOUz/Tel/dIcpNDXrEVgrr/KSaad19H9kXZcGIjFk6OW9G/w/frp9dz9od
         jgam/pQ6ldrYGJjLCFGBKpHptFFsH6m0tDNsxUYG3g+YV7IXSkLGYwcZgqaEvzvy7MMx
         AJnrML4r02uAgDhccIg8ItX2nfW3McKlI0v35accFCylNsaXmRlh+ZPRp9ZQjucy88w5
         qL9gdeBKupHaTUopsyQivs5BuoWourYReSObXxFuueYNHswhazjPH0fGiZWt6yOEOm0x
         HN35GeCUJRe1qwi+0wv24Rl0XpEFy5DbtVZrsH1N2TaX4+ec6DHPyFne2jL1rVh+V8mD
         OhwA==
X-Gm-Message-State: AOAM531VqGEYWesQGch5rX458EOCautEusxYeSluI7feyIh47z4Pabqn
	+sLJTWbEWRi6NL9jAtt9qHbnQlNXhR++Q0iU
X-Google-Smtp-Source: ABdhPJyBlq1QCQ2GCFV46mVFROiajlaqhFEnKdrM9YDMuh8cXabQ3sIOnr/UWxYgZjk69JiDPrE4NA==
X-Received: by 2002:a17:907:6ea4:: with SMTP id sh36mr49781674ejc.482.1641553381062;
        Fri, 07 Jan 2022 03:03:01 -0800 (PST)
Received: from ?IPV6:2a02:578:8593:1200:5952:d10f:7cfd:375e? ([2a02:578:8593:1200:5952:d10f:7cfd:375e])
        by smtp.gmail.com with ESMTPSA id dd6sm1297165ejc.212.2022.01.07.03.03.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Jan 2022 03:03:00 -0800 (PST)
Message-ID: <9fde3240-18c4-ceb5-903d-64c532a87992@tessares.net>
Date: Fri, 7 Jan 2022 12:03:00 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH mptcp-next] Squash to "selftests: mptcp: more stable join
 tests-cases"
Content-Language: en-GB
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
References: <613b986defe37faa7298095b364d9c81d6899664.1641549011.git.geliang.tang@suse.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <613b986defe37faa7298095b364d9c81d6899664.1641549011.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Geliang,

On 07/01/2022 10:51, Geliang Tang wrote:
> IPv6 removing test failed on my test every time, this patch fixed it.

Thank you for looking at that!

The public CI has many similar errors and maybe (hard to say) more with
your patch, e.g.:

https://api.cirrus-ci.com/v1/artifact/task/5889173428109312/summary/summary.txt


> Our CI did some validations and here is its report:
>
> - KVM Validation: normal:
>   - Unstable: 1 failed test(s): selftest_mptcp_join 🔴:
>   - Task: https://cirrus-ci.com/task/5889173428109312
>   - Summary:
https://api.cirrus-ci.com/v1/artifact/task/5889173428109312/summary/summary.txt
>
> - KVM Validation: debug:
>   - Unstable: 2 failed test(s): selftest_diag selftest_mptcp_join 🔴:
>   - Task: https://cirrus-ci.com/task/5326223474688000
>   - Summary:
https://api.cirrus-ci.com/v1/artifact/task/5326223474688000/summary/summary.txt
>
> Initiator: Patchew Applier
> Commits:
https://github.com/multipath-tcp/mptcp_net-next/commits/3b5258004128

Could it be linked?

Should we eventually wait before and after having emitted the del
command with different counters?

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
