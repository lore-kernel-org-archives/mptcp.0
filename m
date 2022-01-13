Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC0D2C82
	for <mptcp@lists.linux.dev>; Thu, 13 Jan 2022 10:41:54 +0000 (UTC)
Received: by mail-wr1-f51.google.com with SMTP id k30so9256719wrd.9
        for <mptcp@lists.linux.dev>; Thu, 13 Jan 2022 02:41:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=BDfyt8rch0y9g5Wm/cz07dwKg+duEmCjbHPSyasHKYg=;
        b=KD0ZBZMao9/eq/TbsbA9c8z1CiCIPInrFvg+RMrKW2fydjVMz54/pwFxoRQVSW+xvk
         Rk9dRQrg3+/lwwHMShAwR9SXLtAh4CsyahVeejqfoOlYGj8FSQ/o3uZtnHsBsnhQMRWb
         5v1hOpQinTVN1qMfhIpIL/BY7nINsI2Xhgmy8SQMrTSpWIQzG+cde1/YpR3KCLmUTnYz
         PweE3pfcMUZcgYZN/TouATMFSaLuMK4FmOYrGp/Kfk9p6o8vP9CrOXqYqBspbE4Ii1HN
         3Ar6X9hVejhpdnkpyRxnyjEA+tE7O3jsr+CpdNGjViqjOKe3EogSzXvj1TnUNsc/PuWv
         Js2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=BDfyt8rch0y9g5Wm/cz07dwKg+duEmCjbHPSyasHKYg=;
        b=sfzwI45G+47UzjIEWZ3WXQbXwUtHJM4nfRjfRABypTq3TruVjp1yL5BMHINAwqTL5+
         LN9rMIMVzt0YoX5ZZJzCghYSwTmep1CmfniZ0VGHRybn7ncFAaONWoA9cO8CFgFwu1cE
         HORVQ6sEFA+gV/qicLUuWXguwHTUg5ESv5XZ8/J8nQSpKAwEyGpyBpfoUmCp8UU6uI2z
         dVpZ9gzO+z1dz2JkjBmfiLdzLGKazLSZ3CY4WVjxOWhxrHbfIZMiq2l/EZGDEySNxhl6
         hxEM7rAbqkTsXShsLgM0dhDW6W70Wc3vzK1TjaP5CizOVH5S3q2NJ/z8kHe/tYNbMTXd
         QLSw==
X-Gm-Message-State: AOAM532V6dAUXklKrEQhzz/0y+vIaZ/jrYAqmXUneFNDHPV/qKoXtHp/
	9+aQBcoJc7tSHnbBQf/LYbMU6jhQ12HlnQ==
X-Google-Smtp-Source: ABdhPJzGcKwmTKQDjVljnn0GdI6cbfXxEM8k8jiYGKwZRbAwTjXpNbQjrxnaZ/JXk1dh18U+l/K05w==
X-Received: by 2002:a05:6000:1869:: with SMTP id d9mr3395602wri.231.1642070512346;
        Thu, 13 Jan 2022 02:41:52 -0800 (PST)
Received: from [10.44.2.26] (84-199-106-91.ifiber.telenet-ops.be. [84.199.106.91])
        by smtp.gmail.com with ESMTPSA id h205sm4143212wmh.19.2022.01.13.02.41.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jan 2022 02:41:52 -0800 (PST)
Message-ID: <c9cf7d10-dc8d-d715-eb24-30b088503f76@tessares.net>
Date: Thu, 13 Jan 2022 11:41:51 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH mptcp-next v9 0/5] Clarify when options can be used
Content-Language: en-GB
To: Mat Martineau <mathew.j.martineau@linux.intel.com>,
 Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
References: <cover.1641804767.git.geliang.tang@suse.com>
 <35eaa787-f52a-7b0-5c99-f4ff38427ae@linux.intel.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <35eaa787-f52a-7b0-5c99-f4ff38427ae@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Geliang, Mat,

On 13/01/2022 00:33, Mat Martineau wrote:
> On Mon, 10 Jan 2022, Geliang Tang wrote:
> 
>> v9:
>> - drop patch 1-3 in v8, they are accepted.
>> - drop patch 6 in v8.
>> - add a new patch "move the declarations of ssk and subflow" to avoid
>>   the compiling errors when moving the mp_fail label.
>> - update patch "reduce branching when writing MP_FAIL option" as Mat
>>   suggested.
>> - Change 'ADD+RM' from 'C' to 'P' in patch "clarify when options can
>>   be used".
> 
> Hi Geliang -
> 
> I think patches 1-4 are ok for the export branch:
> 
> Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>

Thank you for having sent this new version and for the reviews!

Now in our tree (feat. for net-next) with Mat's RvB tag, without my SoB
on patch 4/5 and without patch 5/5:

- ac07cdb70be9: mptcp: move the declarations of ssk and subflow
- 77ef153f0748: mptcp: reduce branching when writing MP_FAIL option
- be77cda2def6: mptcp: clarify when options can be used
- d185331aff82: mptcp: print out reset infos of MP_RST
- Results: 459ae9092f30..26c341404c60

Builds and tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20220113T104129
https://github.com/multipath-tcp/mptcp_net-next/actions/workflows/build-validation.yml?query=branch:export

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
