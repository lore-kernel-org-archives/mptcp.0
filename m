Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B30ACC146
	for <mptcp@lists.linux.dev>; Wed, 24 May 2023 08:29:49 +0000 (UTC)
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-3f606912ebaso7858685e9.3
        for <mptcp@lists.linux.dev>; Wed, 24 May 2023 01:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1684916988; x=1687508988;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0QMsdFYmTJ5VD//yWdZm0NMb80AhHBJYDQgKo76AZyg=;
        b=LPrDds0sK5qwacctNbftMMTVh1u361ZE5ireYF+uHaLZtGGjVtkRMylLWIz8o4frZe
         5jb55Ow9hdGEVPTPsONoiZtQTsnSHmMOTfHYK90wIfJkETO1T2ScmFSl6N5y8oqEYYX2
         JB5IJtVQDynjREYxgPgCkbgqAV0gSuZI3NvDS632huytmrIereUyXRDk3CV3EmXnroBR
         sGr6WwQflaN+y+7bDqCK3oL8YNQhV5/PLCCRVUnenSlzS8m75qCR4qnAWx914GFCPLt6
         HTnNq+3lAQc25xFXzaXkIpUeajDYS43FiL5hd+gN4B32k3bwsrkAZYfWNkBOa9WveyEj
         CoqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684916988; x=1687508988;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0QMsdFYmTJ5VD//yWdZm0NMb80AhHBJYDQgKo76AZyg=;
        b=BZN2+z4acefdCtI57EK86Xkl3OBL7NsUhkGL3X/0q+NoYuig4bYEKJwCyTMJK2xjiM
         2B4eKTzwJ2NCqPCGqwa82O/2Qb3Y6e2GEzCyRKXJbxV5xokntSlob/1OntOd+siWCbPS
         DRy43rz1SwbfUOu55bw1/Uy05eDsd6He2otSkBsJHWrRbR12yIMXJvhiXfmZIf9JYZ8D
         yzaWmOq8Rk7ttiRFNi4mPgrFokw63kikrl7VTY3cSYCKxhStS82AOkfALiIKvVf+tM+W
         gbxr3RmrqL5bC0JC4y5k8AHcenhwak9OEmMBfXOnn6xyZz5O10CokU7Nn4TF1GVHyQJv
         lu3w==
X-Gm-Message-State: AC+VfDwmYQxjP7RcVrYES29M+3g8B+bHcNXg0xyJdrpc2Tf+Z9f4occm
	VOIorybB/CJn1O7wuDsB25xXGh9geI0gh8XLitNN9g==
X-Google-Smtp-Source: ACHHUZ4zS3zmIP85iVbx/E8tvnbbaJPiDskg3jcr9Q0ozrAaxBH+rT3HXPPOlKyvdvgINnFmr5O6uw==
X-Received: by 2002:a7b:c31a:0:b0:3f5:f83:4d84 with SMTP id k26-20020a7bc31a000000b003f50f834d84mr11937398wmj.31.1684916987686;
        Wed, 24 May 2023 01:29:47 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:735b:1ad0:911b:4361? ([2a02:578:8593:1200:735b:1ad0:911b:4361])
        by smtp.gmail.com with ESMTPSA id n25-20020a7bc5d9000000b003f42328b5d9sm1470363wmk.39.2023.05.24.01.29.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 May 2023 01:29:47 -0700 (PDT)
Message-ID: <27730b33-6a07-7d18-c4ea-31a56b952e91@tessares.net>
Date: Wed, 24 May 2023 10:29:46 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH mptcp-next] net: skip printing "link become ready" v6 msg
Content-Language: en-GB
To: Mat Martineau <martineau@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
References: <20230522-mptcp-skip_print_link_becomes_ready-v1-1-9d5f28f19440@tessares.net>
 <614e76ac-184e-c553-af72-084f792e60b0@kernel.org>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <614e76ac-184e-c553-af72-084f792e60b0@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Mat, Paolo,

@Mat: Thank you for having reviewed this patch!

@Paolo: I have a question for you below if you don't mind.

On 24/05/2023 02:20, Mat Martineau wrote:
> On Mon, 22 May 2023, Matthieu Baerts wrote:
> 
>> This following message is printed in the console each time a network
>> device configured with an IPv6 addresses is ready to be used:
>>
>>  ADDRCONF(NETDEV_CHANGE): <iface>: link becomes ready
>>
>> When netns are being extensively used, e.g. by re-creating netns with
>> veth to discuss with each other for testing purposes like mptcp_join.sh
>> selftest is doing, it generates a lot of messages: more than 700 with
>> the latest version.
>>
>> This message can be useful in many situations but in some, it floods the
>> logs without providing any useful input. The proposition here is to have
>> a new sysctl knob to easily skip this specific message.
>>
>> Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
>> ---
>> include/net/netns/ipv6.h                        | 1 +
>> net/ipv6/addrconf.c                             | 5 +++--
>> net/ipv6/sysctl_net_ipv6.c                      | 9 +++++++++
>> tools/testing/selftests/net/mptcp/mptcp_join.sh | 1 +
>> 4 files changed, 14 insertions(+), 2 deletions(-)
>>
> 
> Hi Matthieu -
> 
> Using a sysctl for this seems like overkill. I noticed a similar change
> for ADDRCONF(NETDEV_UP) that changed a pr_info() to pr_debug():
> 
> 7c62b8dd5ca89dabd9f455d19e663bad60951bd5
> 
> Maybe that's more suitable?

I don't know. I mean: I don't even know if this message is that useful.
I quickly search for this message on the Internet and I found bug
reports because this message was abnormally printed. So in these cases,
it was a sign something else was wrong. Maybe the case in most use
cases? Even if there are other (better) ways to track issues with
network devices...

But yes, pr_debug() would be easier :)

The commit you mentioned also talk about the message I want to mute:

  (...) it seems to be more interesting to hear when the addrconf
  actually start (...)

(but it doesn't say if it is that useful)


@Paolo: should I ask on netdev which direction to take? Or send this
patch as a RFC (and mention the doc is missing and the modification on
the MPTCP side will be done in a separated commit + the pr_debug()
possibility)?

> If you did want to keep pursuing the sysctl, the patch would need to
> update Documentation/networking/ip-sysctl.rst

Good point, I forgot that!

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
