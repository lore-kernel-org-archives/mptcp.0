Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB404748D
	for <mptcp@lists.linux.dev>; Mon, 14 Nov 2022 17:05:22 +0000 (UTC)
Received: by mail-ej1-f46.google.com with SMTP id bj12so29826372ejb.13
        for <mptcp@lists.linux.dev>; Mon, 14 Nov 2022 09:05:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MLas3BIw/OXzo4ZW8SnAHKqvtOb6v1ZX3Ub7WyXiK68=;
        b=6qrnomKBwwvFeXCCILXPEsq4aTh+LbCoXaLwJqxVeWuVCRvT8TcJJIDO+fM9fnksGq
         Svq/EWLXQeCtXEY7ZfWlTPMLhVDIvpxeAo16fJDeDlWiW7kiIIS3lLclCJIPe5SYM5Y5
         lcOgBP+MREpG30qSmcyFBmF/HlBobmLLgavea3criLNuK3y2+f4qnpK/OBUWjF9JQUjd
         OpfdzQliCgKh8j4/rczKIsjp9izBfadsnqoLBSsjoBdTUwAEhGk5s5AZvEfo/cYkjMY0
         LNFb/k6TCyU8lIe+jEZwlykrQj4uBCpakMJpyOuGogaW7zqaL1kzYCZyQeqOCkMtFyY2
         6PVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MLas3BIw/OXzo4ZW8SnAHKqvtOb6v1ZX3Ub7WyXiK68=;
        b=cXMMnjAg36xf+YN4u2vCSPARmQ0U7Y+IbgBw55YZtrgJZPG0VpIHda5CtQ1+61awY6
         H/YDVEBqWkasm+tTW6wO4Mvg9/sUJoSfKDT737H2FxMUafdpPiDW1GZF0Ij5S/1jZnoo
         aMdOVlbjfqsTJJ77U0dS5LYJzrFLq6pD0pXzKP6ewRQ4aaP+ZIg/WLqOPlk77MHESNbe
         dzJdvtyUoEL+onug+b0j0I0nIAzAAwXPASb+iHO2UWkEJ2NabyDEDuGNW/aiv+dt73vn
         n5rLsQt0OVsO2POhSjBaXXmopndVdmLv9DEd8Bj2v9eXpO7ko4+uoVqb/3eDIsb02gpn
         6h6g==
X-Gm-Message-State: ANoB5pnIJJfrv/rrbtt/qnZE7D9mDhBpWZps6TOjKyKJbAd0RlD+cUSq
	h+TOk0EpdSCMs8hsDlo1MxUONA==
X-Google-Smtp-Source: AA0mqf5FGAwiA6S9Ls9avusdmmyqEFHGjWbqwq6+6GSHACFBzxotyb0m3Z4JLmEgH9NklqeLkq/LHQ==
X-Received: by 2002:a17:906:148c:b0:7ad:f0ae:bc88 with SMTP id x12-20020a170906148c00b007adf0aebc88mr11219065ejc.188.1668445520505;
        Mon, 14 Nov 2022 09:05:20 -0800 (PST)
Received: from [10.44.2.26] ([81.246.10.41])
        by smtp.gmail.com with ESMTPSA id f24-20020a17090631d800b0073d81b0882asm4445424ejf.7.2022.11.14.09.05.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Nov 2022 09:05:20 -0800 (PST)
Message-ID: <8065dec5-b261-d9e2-6809-effc1e6f12b1@tessares.net>
Date: Mon, 14 Nov 2022 18:05:19 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH mptcp-next 0/2] mptcp: more cleanup in mptcp_sockopt.sh
Content-Language: en-GB
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: mptcp@lists.linux.dev
References: <20221110175857.3953994-1-matthieu.baerts@tessares.net>
 <384e3619-ec0f-b826-c7d2-122b547f6020@linux.intel.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <384e3619-ec0f-b826-c7d2-122b547f6020@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Mat,

On 11/11/2022 02:23, Mat Martineau wrote:
> On Thu, 10 Nov 2022, Matthieu Baerts wrote:
> 
>> The first patch was suggested by Geliang in [1].
>>
>> While at it, I also added more 'local' keywords as we do in other
>> selftests.
>> Nothing complex or fancy ;-)
>>
>> [1]
>> https://lore.kernel.org/all/CA+WQbwuyOdNfg-g=QC-KF9dMyxdXp1vaEPoWn2LzpE+kM_w1yw@mail.gmail.com/

(...)

> Series looks good to me. The CI failure appears to be an intermittent
> issue - I see the same failure on October 14.
> 
> Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>

Thank you for the review and for having checked the CI!

I just added these patches in our tree:

- f13009343876: selftests: mptcp: clearly declare global ns vars
- d5362e879e51: selftests: mptcp: declare var as local
- Results: ff1606d98e1c..b5e3796fd633 (export)

Tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20221114T170404

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
