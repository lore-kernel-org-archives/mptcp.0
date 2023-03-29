Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E11B7B
	for <mptcp@lists.linux.dev>; Wed, 29 Mar 2023 11:10:02 +0000 (UTC)
Received: by mail-wm1-f47.google.com with SMTP id bg13-20020a05600c3c8d00b003ef90adc168so1566529wmb.5
        for <mptcp@lists.linux.dev>; Wed, 29 Mar 2023 04:10:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1680088201;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hDbjEuQFfIGhiFup0MoaRSctlyOJkhDe3mgcLFDs8MM=;
        b=2eusvKf8L/U36krB429cZgofHETasAZ7YoouHc0eFHIdon2EboFVUYcgWsXPNAxIsW
         BO1Q6eC+oBV8CORQckJh/TB+pJAToU/7qSkge/DyZ3AWF/9lVZsgKVyRuWqArS3TTdDj
         485DpeGvDipbIx4jLHQKgQmmT9h7fdbjPWv0JBP5+rWmXwa9eoAb4YvbqwEUqouX8VmU
         6kJIkjyNKtUDNrUHPrGgO+ZmhD8mtpL0YeMMmJZv1MG8J/zmO86xycZ1OhGRfXKJvmG4
         53+0smjDvjqjkpEJkgHiIvMoz3P3vXwo9egBDb0Bi5jZwLWYlxwEsiYpR8Uc+APSTxe/
         cmtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680088201;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hDbjEuQFfIGhiFup0MoaRSctlyOJkhDe3mgcLFDs8MM=;
        b=zEbLAgDcDbWQgigcAFbE3vJHPru2m7ewX7COuYhGM9xYI6RpK/oF2TCVz0TLIQi3+Y
         ShiLB1NG/pBRrEimd/4od99Hx+5GdG3W8JmfT3yvxQrPaC6s/A5g7pVpULSRKAlYBfrM
         ehWOKI02vdfpHuRFFPjdTl9QVppG3EnjPH4JoqjTevo2nhybVh7TixT7T2KbtxGmvw2I
         52uNJx6gS9mTq/G+3K4O2uO7n1fSNvvGC+w5bJdTzCCU7gH5Pf+/JhgNYWPzNT5rPTqX
         xrm/ge3aQREER7WgtkzMP4aOpY8kXs/dE1RwxFNOeCwxGNZfLlRuM+IdAYNTEslj/oWx
         WXHw==
X-Gm-Message-State: AAQBX9fznwh5xe57BdeD62jWBV9BCvXIWWvtAmOjUxKxEYR6hv+TdLez
	iSBRhZC0YZOqUuRr0CW4dt1cvw==
X-Google-Smtp-Source: AKy350Yq5apzJnqzOKEpEdW7aqu0UKQ+OcJ8SQuJ0STN4+gcCjW6Kv2dSyGhJ8YYwulHnHi1EaTxFQ==
X-Received: by 2002:a05:600c:a4e:b0:3ed:bfb4:ad9f with SMTP id c14-20020a05600c0a4e00b003edbfb4ad9fmr1491159wmq.2.1680088200889;
        Wed, 29 Mar 2023 04:10:00 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:79fe:97a:4a91:5b93? ([2a02:578:8593:1200:79fe:97a:4a91:5b93])
        by smtp.gmail.com with ESMTPSA id d7-20020adffbc7000000b002d5a8d8442asm25636871wrs.37.2023.03.29.04.10.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Mar 2023 04:10:00 -0700 (PDT)
Message-ID: <041730e5-a578-1ffa-a2eb-81e776f07df1@tessares.net>
Date: Wed, 29 Mar 2023 13:10:00 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: MPTCP_Up_Stream
Content-Language: en-GB
To: Iheb Zannina <iheb.zannina@gmail.com>
Cc: mptcp@lists.linux.dev
References: <CAKdABxssnqVYwgJnhqD4653-n8+aCX1CCqNOxN-EWG+YWaGRyg@mail.gmail.com>
 <c14c5a19-5a88-0dba-b58a-ea5cfe8a6211@tessares.net>
 <CAKdABxvkQmFDXM8eBqEc-jqFdLuW+yp1_1zexsGez8BrA2JoDg@mail.gmail.com>
 <886b5c3d-53e9-d797-8bd2-aeb809351fe7@tessares.net>
 <CAKdABxupt1=Q5ZQY_tg9j2q68a5bBa3UBY7hEMRNihCBi6a68g@mail.gmail.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <CAKdABxupt1=Q5ZQY_tg9j2q68a5bBa3UBY7hEMRNihCBi6a68g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Iheb,

On 29/03/2023 12:05, Iheb Zannina wrote:
> In the https://progmp.net/  ->  progmp_helper.py file (attached).
> You can see that to set a Default Scheduler you need to open the "
> /proc/net/mptcp_net/rbs/default  " file. Then write the name of the
> new scheduler.

progmp was a fork of the out-of-tree implementation. They never sent
patches to include this in both the out-of-tree implementation [1]
(kernel < 5.6) or the upstream one [2] (kernel >= 5.6).

[1] https://github.com/multipath-tcp/mptcp
[2] https://github.com/multipath-tcp/mptcp_net-next

> What about MPTCPv1?

MPTCPv1 is about the spec, not the implementation:

 https://github.com/multipath-tcp/mptcp_net-next/wiki#mptcpv0-vs-mptcpv1

> How can I change the Default scheduler?

As mention before, there is still only one MPTCP packet schedulers in
the upstream implementation. The work is in progress:

 https://github.com/multipath-tcp/mptcp_net-next/issues/75

There are some preparation patches in our git repository but not related
to "progmp". As described on the GitHub issue, our approach is using eBPF.

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
