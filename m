Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F067A
	for <mptcp@lists.linux.dev>; Thu,  3 Mar 2022 09:58:19 +0000 (UTC)
Received: by mail-ej1-f54.google.com with SMTP id yy13so585160ejb.2
        for <mptcp@lists.linux.dev>; Thu, 03 Mar 2022 01:58:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=9NaPtkVQwg82vkQNz5OefrA0q/A40Qigpp4c/P78Jb0=;
        b=E++MQcTUkhtXS3bSXNPPZyB3YTaSUb/JYW7w/aLdE0RFFuGMQ6+JEkNHJUNc+6sOzF
         zUcPAwwF1qaG92CsPZgqpJz9JFG0Sgf9Aie0KFFhDqgs+peejRyqkxAApGnWyhcVC/68
         lSXCCmZ3YhBssI7s3GBaf8hqeEgCw5ew5O1ARMB3pG4H5kGkP0T/uk3+XxofrP1GRRDr
         Plt4/mGhx77xxnB/fO2peWf1dtG/NMc2N55lrrPV3DgFChAD0Ji6uFUoHgkv4L+gttud
         +/9xysK629SZLJemxY0wedTjkF3wHDHorYsaKknqwXOMAomqzdp4x2mGonWtGVynlZXe
         MUMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=9NaPtkVQwg82vkQNz5OefrA0q/A40Qigpp4c/P78Jb0=;
        b=fWbq0Sv9s+4P4dzyQIQn9Jjh0tTjpFIH/uFvJhvALzFxfgzHFYYQ6sKMtWPm6SUkef
         hqmdBhfDl1wZYny/WDYvo7carczxhq+vbDwQU1Xb02/N8vyJvF2ugiBP26zvHFQPTLmy
         vUzppeMXSUkEvlOL/DKkqD5t8irinPiFQSTmRilA8viiFEIrONUSXDJDiZaP2H5eEmdZ
         qGDuThrF7uaqNvd86iM/R9e5s7AZUzDVC0ZhYZ93UAKKGNszgQeGSwEWpBhG9jVJxhHj
         nk/2X5w9EXM7EzQ8kSqaWWzChSTKb2WFygyxnhuxc3jhztdVSzHrjP8CL+OhUUiLVJJ6
         3jyg==
X-Gm-Message-State: AOAM532vCmj9bnXA9IdwwkpuKeSXIo+FOezA3HjfWyRdhUzPmZsnwI/5
	/+k3r83Ao6fX8KSI/yrTgVG/jr0Lj1ZDSqyz
X-Google-Smtp-Source: ABdhPJzOeq1NwZZombbR3wjpUEO/C0j/2GZOnaS2aeJdvt99HqyZoCASJiiwD2TW6tvhDaHGxHexXQ==
X-Received: by 2002:a17:906:1603:b0:6ce:362:c938 with SMTP id m3-20020a170906160300b006ce0362c938mr26492546ejd.253.1646301497306;
        Thu, 03 Mar 2022 01:58:17 -0800 (PST)
Received: from ?IPV6:2a02:578:8593:1200:9692:b15:c6e7:1c2e? ([2a02:578:8593:1200:9692:b15:c6e7:1c2e])
        by smtp.gmail.com with ESMTPSA id q2-20020a170906144200b006ceb8723de9sm508118ejc.120.2022.03.03.01.58.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Mar 2022 01:58:17 -0800 (PST)
Message-ID: <66702bd7-f08d-3d4f-fcaf-da92dc35dff5@tessares.net>
Date: Thu, 3 Mar 2022 10:58:16 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH mptcp-next v4] Squash to "bpf: add 'bpf_mptcp_sock'
 structure and helper"
Content-Language: en-GB
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
References: <4a1d63bb7976c1d61308a875132107e17272c8f8.1645519631.git.geliang.tang@suse.com>
 <f3d4da00-5483-7da4-8890-d40df6ba34f4@tessares.net>
 <20220303091205.GA19132@bogon>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <20220303091205.GA19132@bogon>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Geliang,

On 03/03/2022 10:12, Geliang Tang wrote:
> On Thu, Mar 03, 2022 at 09:44:52AM +0100, Matthieu Baerts wrote:
>> Hi Geliang,
>>
>> On 22/02/2022 09:52, Geliang Tang wrote:
>>> This patch addressed to the comments in [1] from BPF maintainer Alexei:
>>
>> (...)
>>
>>> diff --git a/include/linux/net.h b/include/linux/net.h
>>> index ba736b457a06..9c1a634e5ac5 100644
>>> --- a/include/linux/net.h
>>> +++ b/include/linux/net.h
>>> @@ -238,6 +238,7 @@ int sock_recvmsg(struct socket *sock, struct msghdr *msg, int flags);
>>>  struct file *sock_alloc_file(struct socket *sock, int flags, const char *dname);
>>>  struct socket *sockfd_lookup(int fd, int *err);
>>>  struct socket *sock_from_file(struct file *file);
>>> +struct sock *msk_from_subflow(struct sock *sk);
>>
>> Would it not be better to expose this in include/net/mptcp.h instead?
>> And prepend it with 'mptcp_' as it is exposed to the "outside world"?
>>
>>   mptcp_sock_from_subflow()
>>
>> But when thinking about that, maybe better to name it:
>>
>>   bpf_mptcp_sock_from_subflow()
>>
>> as the implementation is quite specific to BPF.
>>
>> In this case, it should go in include/linux/bpf.h with the other
>> bpf_mptcp_ functions (with the #if/else CONFIG_MPTCP you need to avoid
>> compilation errors).
> 
> Thanks Matt, I'll update this in v5.
> 
> But v4 still needs to be improved. The token value is incorrect in it,
> since bpf_mptcp_sock_convert_ctx_access is dropped. We should do this
> convert in this BTF_ID mode too, but I don't know how to do it. I mean
> how to invoke this convert function when we use
> RET_PTR_TO_BTF_ID_OR_NULL.

I just sent a reply in 'selftests: bpf: exercise bpf_mptcp_sock()​' thread.

In short, now bpf_mptcp_sock() returns a "struct mptcp_sock *" and no
longer a "struct bpf_mptcp_sock *" with only the token in it. No?

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
