Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0B552F2E
	for <mptcp@lists.linux.dev>; Tue,  6 Dec 2022 11:02:49 +0000 (UTC)
Received: by mail-ej1-f52.google.com with SMTP id qk9so5295930ejc.3
        for <mptcp@lists.linux.dev>; Tue, 06 Dec 2022 03:02:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b3focy5DPRaylciSJKtJeMul5LMPRnPX+E8mGzav3Ag=;
        b=GjtZPoETNrGAtHGPBij+7ohy8mUZSdjwv0dNRsljGtc3cIWu2vR+vrD4BFWcYDdEAL
         9pZpMKtifqZ9YLhmeHkkxka0NlBquO5JzTwjBVKjOFZ8KXsaJ2z06FXVTsQ25LwhDCih
         g4EorocVI/3k23pUJK7msl4p7UNrbcmF5q1bB6RN8XBBaE/scJ3wew3FTUF3y1HNVq3R
         5S6DoR+GedPNjozh5e3W46m1rr+jfY6SWv2PgGShz4BGbPgcUdKclI5YF4Ij1ESDJqM1
         kK9no2af75RuCqVVrP/o0QQSsv+NWcwwRYsakam48/WsaX08eYx72oEACowVT/hVvj5W
         4e0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b3focy5DPRaylciSJKtJeMul5LMPRnPX+E8mGzav3Ag=;
        b=5Yd01dKS9wigTylZnCLawz2RL52nVvFOdm2IvcXCAHi4ti+kvCEs/sC2S2mgx3LLn7
         qq7qZpawzNAko51NVkuUsi7Cx7YaKjJLicZFYcvTQvIbA+51hFP/Z8X9fGBtCN4yhi0y
         ti7PCz3NfbfVFDfEmnrPDu1IwdnK/Ut+eC2X37FfLsQ4Hx8vdS9n4a2Var9DFTn1l1ho
         VNtywdUxNdTap0vtvkIDLTLmXgndUE3XkyE/VnxjthQX5hmWtjTyvQpJr/l91g7nForw
         +dnsk3oneuqoxjeMM1N1w5I92I283qZilrgWSkzNaX5TMHEMpsvpVIpw/zdW/EKwDyx7
         6fNg==
X-Gm-Message-State: ANoB5pmXngXFtHoei0WdvzyGE07nBrsnBU6yCu2rPi4A+MyDar6a+LBS
	U6EMdE4UtD5gPtphsZtuZtajRF16JyUs34gn
X-Google-Smtp-Source: AA0mqf6H/xujUtV4AxisjCWAeG8wmqnusz/7Oz0485kKxrg8TPICyRydHn8D3uL8nnHnjHLrc8U4zQ==
X-Received: by 2002:a17:906:844:b0:7ad:fd3e:8fd4 with SMTP id f4-20020a170906084400b007adfd3e8fd4mr117996ejd.69.1670324567779;
        Tue, 06 Dec 2022 03:02:47 -0800 (PST)
Received: from [10.44.2.26] ([81.246.10.41])
        by smtp.gmail.com with ESMTPSA id b19-20020a17090630d300b007adade0e9easm4583479ejb.85.2022.12.06.03.02.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Dec 2022 03:02:47 -0800 (PST)
Message-ID: <1213912e-b707-d6a5-195d-5383726c69c5@tessares.net>
Date: Tue, 6 Dec 2022 12:02:46 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH mptcp-next] mptcp: return 0 instead of 'err' var
Content-Language: en-GB
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: mptcp@lists.linux.dev, kernel test robot <lkp@intel.com>,
 Dan Carpenter <error27@gmail.com>
References: <20221205101002.2620762-1-matthieu.baerts@tessares.net>
 <4ca7e8d1-4d93-0e23-45a5-2084f7df982e@linux.intel.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <4ca7e8d1-4d93-0e23-45a5-2084f7df982e@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Mat,

On 05/12/2022 22:31, Mat Martineau wrote:
> On Mon, 5 Dec 2022, Matthieu Baerts wrote:
> 
>> When 'err' is 0, it looks clearer to return '0' instead of the variable
>> called 'err'.
>>
>> The behaviour is then not modified, just a clearer code.
>>
>> By doing this, we can also avoid false positive smatch warnings like
>> this one:
>>
>>  net/mptcp/pm_netlink.c:1169 mptcp_pm_parse_pm_addr_attr() warn:
>> missing error code? 'err'
>>
>> Reported-by: kernel test robot <lkp@intel.com>
>> Reported-by: Dan Carpenter <error27@gmail.com>
>> Suggested-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
>> Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
> 
> Thanks for the cleanup Matthieu. Looks good to me.
> 
> Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>

Thank you for the review!

Now in our tree (feat. for net-next) with your RvB tag:

New patches for t/upstream:
- 1172127291d8: mptcp: return 0 instead of 'err' var
- Results: c7fdd02a4241..fb04e49223d2 (export)

Tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20221206T110210

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
