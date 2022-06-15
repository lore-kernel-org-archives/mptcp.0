Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E81887A
	for <mptcp@lists.linux.dev>; Wed, 15 Jun 2022 12:36:51 +0000 (UTC)
Received: by mail-wm1-f41.google.com with SMTP id z9so6227662wmf.3
        for <mptcp@lists.linux.dev>; Wed, 15 Jun 2022 05:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=bCUEs8eIG55Ez1eDu4Ng0Z2DbCZeRwbA56ognUdh5+I=;
        b=ZqytsSEY8UYkT2bNO+lURy/SSLT8ipqjndbabdCkk9xS+Nd+ic3J66Ovremp47oO7s
         9PiZCNUVQk/Rg+D+l7iBHPk+9tYMjUmaxjSP8pH9DhDPem5ErDnaXJ1fW5bSSAZTYKjn
         9Kri3LR7Fis6hhvF/2rP16QZ++z/QnWSdU7Gk8Hen1YaqVGauAAArsqSOFC/bMHGi/ZD
         hC6G1aKEZFtsBzs1/hMoMpxLVJV1+FFCh+HIIA1g44M8KmJBpo1X0llL6WasZmkQKOdj
         hSN3TL3N0dTch7UhUeagary1J3Wx/wAGu7D0BRiDHhFcxIUETqmToaDyGiiolmUyMyv2
         fBRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=bCUEs8eIG55Ez1eDu4Ng0Z2DbCZeRwbA56ognUdh5+I=;
        b=u2ZMAaAtEs8KwtqQYJOVD92yFMEIf4/80x33DYF8RrcGMlMZb3gL7T0tXFcS6g9KdJ
         AWF0AFqz7fv+aymleWSI38yn7OpYnEulpg70+lBb7dSj9UbhOy56rpsm4WQf2SmINFSA
         tyoTK2+3KLd+zf3rO99iXgcRXoJWRVZqceaBQtNEW3arI1PMSditqRBn8lxH47rfAEtT
         7y4IPsFXcAoVOl9u+VdCDFkONx3zSrJ6GkMOalGGxiow1Nq0MbK3IefLGy4xQciUrIbm
         Q4CoPlXotJuDFjNKlJU7DCnHpuWIjDXh9NBESLvxGT+ZHs1t1ykBsY5w4aaUZHi3xVtG
         9k1g==
X-Gm-Message-State: AOAM530zb4znr9G+33d+o07BTOJHi1mgR7I0PgvlAvtH03+sJYWOIE5p
	VPpc8kpFXUfgXNtDcROYKcI8Gw==
X-Google-Smtp-Source: ABdhPJyXAeXLB16koxuZpU2TSWUZh+BZ0Of9By+ov2xik9Wn+XCWFyVMnQ5xRZgikLmkIqUXoU+VPg==
X-Received: by 2002:a7b:c015:0:b0:397:3685:5148 with SMTP id c21-20020a7bc015000000b0039736855148mr9890654wmb.174.1655296609758;
        Wed, 15 Jun 2022 05:36:49 -0700 (PDT)
Received: from ?IPV6:2a02:8440:3440:9b70:7a5d:79f8:b746:24d5? (2a02-8440-3440-9b70-7a5d-79f8-b746-24d5.rev.sfr.net. [2a02:8440:3440:9b70:7a5d:79f8:b746:24d5])
        by smtp.gmail.com with ESMTPSA id w15-20020a1cf60f000000b0039747cf8354sm2285873wmc.39.2022.06.15.05.36.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jun 2022 05:36:49 -0700 (PDT)
Message-ID: <853bc3b4-f6b3-a9fc-2235-ab0897593b64@tessares.net>
Date: Wed, 15 Jun 2022 14:36:48 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH mptcp-next v2 1/5] mptcp: update MIB_RMSUBFLOW in
 cmd_sf_destroy
Content-Language: en-GB
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
References: <cover.1654958401.git.geliang.tang@suse.com>
 <4ed5348a34b4de9b482fe192fc271a59ee334e37.1654958401.git.geliang.tang@suse.com>
 <982d63cf-8369-5f88-64bd-b59bc8c2f93f@tessares.net>
 <59e571be-7ce8-6af-4ebe-74c538446f29@linux.intel.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <59e571be-7ce8-6af-4ebe-74c538446f29@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Mat,

On 14/06/2022 01:04, Mat Martineau wrote:
> On Mon, 13 Jun 2022, Matthieu Baerts wrote:
> 
>> Hi Geliang,
>>
>> On 11/06/2022 16:54, Geliang Tang wrote:
>>> This patch increases MPTCP_MIB_RMSUBFLOW mib counter in userspace pm
>>> destroy subflow function mptcp_nl_cmd_sf_destroy() when removing
>>> subflow.
>>>
>>> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
>>> ---
>>>  net/mptcp/pm_userspace.c | 2 ++
>>>  1 file changed, 2 insertions(+)
>>>
>>> diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
>>> index f56378e4f597..ebbab5200290 100644
>>> --- a/net/mptcp/pm_userspace.c
>>> +++ b/net/mptcp/pm_userspace.c
>>> @@ -5,6 +5,7 @@
>>>   */
>>>
>>>  #include "protocol.h"
>>> +#include "mib.h"
>>>
>>>  void mptcp_free_local_addr_list(struct mptcp_sock *msk)
>>>  {
>>> @@ -418,6 +419,7 @@ int mptcp_nl_cmd_sf_destroy(struct sk_buff *skb,
>>> struct genl_info *info)
>>>
>>>          mptcp_subflow_shutdown(sk, ssk, RCV_SHUTDOWN | SEND_SHUTDOWN);
>>>          mptcp_close_ssk(sk, ssk, subflow);
>>> +        __MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_RMSUBFLOW);
>>
>> It looks like this instruction is causing quite a bit of issues
>> according to the public CI:
>>
>> - KVM Validation: normal:
>>  - Critical: 7 Call Trace(s) ❌:
>>  - Task: https://cirrus-ci.com/task/5443636765655040
>>  - Summary:
>> https://api.cirrus-ci.com/v1/artifact/task/5443636765655040/summary/summary.txt
>>
>>
>>
>> I guess you should use MPTCP_INC_STATS() instead.
> 
> +1
> 
>>
>>
>> Side note: I don't know if it is a good idea to increment MIB counters
>> from the PM code (any pm*.c files). I think this should only be done
>> from "core" functions in protocol.c and subflow.c (+ options.c of
>> course). Or from new helpers declared in protocol.h. WDYT?
>>
> 
> Could you elaborate some more on this? There's some existing MIB counter
> code in the pm*.c files that doesn't seem too out of place - is the idea
> that moving calls to the core it would reduce duplicated code in
> pm_netlink.c and pm_userspace.c?

Yes indeed, this is linked and probably more code should be refactored.

My point is that if you need to do a few "independent" calls to
functions from the core API to do a certain type of action from
different sides, it seems likely to have this code being out of sync
after a bit of time or in new code. I'm not sure I'm explaining clearly
what I have in mind so here is a "silly" example to explain this simple
thing:

If you want to destroy a subflow you might want to do:

    msk = get_msk(ssk); // you need the msk later, normal to have this

    // these two functions are linked: here we need to use both to have
    // the desired behaviour. We might not want to close the subflow
    // after the shutdown so fine without helpers (except if it is more
    // common to do both)
    shutdown_ssk(msk, ssk)
    close_ssk(msk, ssk);

    // it is easy to forget counters
    inc_stats(msk, REMOVE_ADDRESS); // maybe too specific: add helper
                                    // to avoid dup code in pm*.c and
                                    // inc the counter only in 1 place?
    dec_stats(msk, SSK_COUNTERS);   // this could go in core API func


But OK, now when reading the code in pm_netlink.c, adding a helper would
not really help so it is probably easier to keep this stat being
increased here I suppose.

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
