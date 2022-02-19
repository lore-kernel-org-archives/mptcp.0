Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13B075580
	for <mptcp@lists.linux.dev>; Sat, 19 Feb 2022 16:55:20 +0000 (UTC)
Received: by mail-ej1-f43.google.com with SMTP id p15so22310285ejc.7
        for <mptcp@lists.linux.dev>; Sat, 19 Feb 2022 08:55:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=EQU8wfWqkJ4GiaOPE5kc51Xc228D7IwdlJINBpVbrKA=;
        b=oH7xrkHPsaMFaxhhgWqw4/2Sjs8F/adi9c6DdSJqOA+f5c0J/z1kxAka80cjQNbXgd
         elMLqTN5f/sLc3s6d6GjKskpypVrsA1nwfSyi0OMwYmUA6gXKT7Iimn+MEs7W0QjZ771
         HTEej9fb/mjNnb5Ky9fRjX/DUQEBCNC7BydCVHaENgacByQw7LhZRjVmQ6Qwh0pIowSZ
         JomJmpBZRD7/pe+qe+S4L4pB71TOcepXwKv5bJKsTVyA0yG76xIi5RY35XC559fPENQB
         irNoC/ZJuxv3A0XGkNMSH3Ynpw/3GznelQV2K9ZR+qfR4MNCSJuJhYDVHLqgJMr1yNhL
         REfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=EQU8wfWqkJ4GiaOPE5kc51Xc228D7IwdlJINBpVbrKA=;
        b=Nbm9E9w7qoUDHrxQLr6KiI2JhWCJ5YtQ5tEq0Bv7Pi1Cow6iXHHuPT1GRMqENtsMIT
         Fsy3o0IPlGfWxHUu0IRqjWK+cYMHM0yp8ODKkDg4Ppyi8sYIaWUEA27fVQuFC8/vlvMP
         JKvoAf6FdeItnF2Z5GOs13jPZQPPOHuUupbfo/8toVwNTM424iWEnec39/KSXUpz/BgQ
         Ky6iBlxpfqWE9tEkgb1Q/1eZWsoamT+u+ZhYtD0n3pARJT2jtsEikCCO5m3jSCq98a7T
         2j3eyI4tmSA/u3Hx+4tmenXDcip/GzkVNUkWT9+S/fsf+sIkchvDfPiCHxDPp5wFNvIg
         /hiQ==
X-Gm-Message-State: AOAM533cxg+XWbJoCaSGaCa2auA8wyRlM8EV4tu6qr6E33Mw+moPBMDy
	rdzRlqH+4YXjTZdXjre28XLR8DqfJJGoMXnI
X-Google-Smtp-Source: ABdhPJwyoLtMj7mxV1UjmHQFLZRvlNxtjt0uGRGYE+Fdu4HGbNIBl+DumL94SuZ3XZmOySbBJqutFg==
X-Received: by 2002:a17:906:b356:b0:6cf:3810:dcf1 with SMTP id cd22-20020a170906b35600b006cf3810dcf1mr10502736ejb.761.1645289719174;
        Sat, 19 Feb 2022 08:55:19 -0800 (PST)
Received: from ?IPV6:2a02:578:8593:1200:e864:9933:3026:4675? ([2a02:578:8593:1200:e864:9933:3026:4675])
        by smtp.gmail.com with ESMTPSA id b19sm2671135edd.91.2022.02.19.08.55.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 19 Feb 2022 08:55:18 -0800 (PST)
Message-ID: <bb98d3a3-07ce-dca8-ea71-55f11c15ca52@tessares.net>
Date: Sat, 19 Feb 2022 17:55:18 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH mptcp-next] Squash to "selftests: mptcp: add fastclose
 testcases"
Content-Language: en-GB
To: Mat Martineau <mathew.j.martineau@linux.intel.com>,
 Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
References: <22588887e5e516015f7f7b9d09112efc679fecf7.1645159759.git.geliang.tang@suse.com>
 <bf71c5e-2814-9774-69c8-e938b67db35c@linux.intel.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <bf71c5e-2814-9774-69c8-e938b67db35c@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Mat, Geliang,

On 19/02/2022 01:00, Mat Martineau wrote:
> On Fri, 18 Feb 2022, Geliang Tang wrote:
>> 2. Use the test_linkfail value to make 1024KB test files. So patch 4
>> in the "add mp_fail testcases" series ("selftests: mptcp: reuse linkfail
>> to make given size files") and its squash-to patch (Squash to "selftests:
>> mptcp: reuse linkfail to make given size files v8") need to be moved into
>> this series, just before the commit ("selftests: mptcp: add fastclose
>> testcases").
>>
>> The order of all the mp_fastclose and mp_fail testcases patches in my
>> tree looks like this:
>>
>> pick a854ead2766e mptcp: add the mibs for MP_FASTCLOSE
>> pick 57f50b740bdc selftests: mptcp: add the MP_FASTCLOSE mibs check
>> pick 12ae36a6ccc1 mptcp: add the mibs for MP_RST
>> pick fc3da2c8bcbc selftests: mptcp: add the MP_RST mibs check
>> pick 963f2f26574e Squash to "selftests: mptcp: add the MP_RST mibs
>> check v3"
>> pick 46680be81472 selftests: mptcp: add extra_args in do_transfer
>> pick 81803638389d selftests: mptcp: reuse linkfail to make given size
>> files
>> pick fe9ed20f6bdc Squash to "selftests: mptcp: reuse linkfail to make
>> given size files v8"
>> pick 24ba919394f9 selftests: mptcp: add fastclose testcases
>> pick fb989057969a Squash to "selftests: mptcp: add fastclose testcases"
>> pick 9985ed286b3a Squash to "mptcp: infinite mapping receiving"
>> pick 0d5bc6ecc54d Squash to "selftests: mptcp: add infinite map mibs
>> check"
>> pick 2ed9ce9e914b selftests: mptcp: add more arguments for chk_join_nr
>> pick 82435d67b9e8 Squash to "selftests: mptcp: add more arguments for
>> chk_join_nr v8"
>> pick bcc0e73c5acb selftests: mptcp: add the MP_FAIL testcases
>>
>> If it's better to resend the whole series, please let me know.
>>
> 
> Everything applied ok for me without conflicts. Matthieu would you
> prefer a resend?
If you don't mind, I'm going to apply Paolo's patches first and run
mptcp_join.sh selftests in a loop during the WE before adding more patches.

Regarding these patches, it should be fine, good there is this list :)

@Geliang: on the other hand, if it is easy for you squash all Squash-to
patches, rebase on top of the latest export branch and send all these
patches Mat reviewed in one big series, it might help me! Especially if
commit messages need to be updated :)

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
