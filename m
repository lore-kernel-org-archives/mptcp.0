Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 234052F24
	for <mptcp@lists.linux.dev>; Thu, 10 Feb 2022 13:00:34 +0000 (UTC)
Received: by mail-wr1-f46.google.com with SMTP id d27so9430982wrc.6
        for <mptcp@lists.linux.dev>; Thu, 10 Feb 2022 05:00:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=/JwjR+SWl9XaYb7Kc4MfTJ20qIIvFjMb7bIGhsxiQUk=;
        b=WwL3IzxCfvkfZFK7cOos3cFtVvChbQh27aHuKRzcNqzQKp5opNEq1NvtOPtRFLLB/E
         gwoc3shy05OKy1fpxhRqhl/ol7FxJucVBOj1B661XCOSpM5GrLaTWuxB5kYPz7OSGr2M
         Ik21eiKeC036S8PzElsA00p+tazMBeSUnolkX3lWnlveslpo14NQf3dU/+T5oZmv9KcJ
         yMhvpbxJ4nf9knQwN1ayXx6C1Imdpa4U8p2aLDTD8AbCUHXCWQlk/0/ENykZJp/aGW+t
         WJ/CL3fSZvdIminRzrGoYbjUcCsZqnpeQAbHgLaxM69RxWMrBlv929i2ggXJrZpUsq0b
         RDbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=/JwjR+SWl9XaYb7Kc4MfTJ20qIIvFjMb7bIGhsxiQUk=;
        b=GpOSrYZ8e1Nky1BhcHNzQLAUmP/ELpl3v2EE46Tge4bu1L6A++gf5XJRQJicsdfp3R
         L+iNbU1/DytgQd+77LyXOtGmoX2yxBVkdewgJTlFL+sYeXBQwIM+XcUm10h4XMoARmxx
         eT7LDz26nySAmwQNKaFUBwEiENsq+vMGcjOAPwaVJFbLNfYXRUE0JAkLwUhgNm02n02U
         Fg4vVHgyh909vJztBGcTigsWIQNi5d3NDf/VuZkCRk8M+weY7e/znr0/xX+yr4d2w6Hi
         BBYIWq8xGut6cm6B5ldoXOj4oyu1s6mf7GO5oZgMOW73U2JO2Z2AONinP6bGwt5+L484
         hX4A==
X-Gm-Message-State: AOAM5324x8A2ZlDmIdiNiQLl9yWcIJb51MTVHlf25PumK+Gny8r4Azmv
	wtCHY8Qtn3udY6K8uv1j23e44rJhx4LSZycj
X-Google-Smtp-Source: ABdhPJxfKWS9tk4p20cMU45TMlN7deAgb+o8lTB8X8jDo5/9iQFM/eahFCZ4S3hn4UZRpZLsBNx8TA==
X-Received: by 2002:adf:fac8:: with SMTP id a8mr6274180wrs.330.1644498032332;
        Thu, 10 Feb 2022 05:00:32 -0800 (PST)
Received: from [10.44.2.26] ([81.246.10.41])
        by smtp.gmail.com with ESMTPSA id s187sm1773163wme.14.2022.02.10.05.00.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Feb 2022 05:00:32 -0800 (PST)
Message-ID: <a9425ee2-27f8-1e9a-0780-a8f5bd4fa194@tessares.net>
Date: Thu, 10 Feb 2022 14:00:31 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH mptcp-next v6 0/7] add mp_fail testcases
Content-Language: en-GB
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
References: <cover.1644466570.git.geliang.tang@suse.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <cover.1644466570.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 10/02/2022 07:00, Geliang Tang wrote:
> v6:
>  - Split two patches from the last one.
>  - Retry the multiple subflows test three times to fix this
> "MP_FAIL MP_RST: 0 corrupted pkts" failure reported by me in v5:
> 
> Created /tmp/tmp.e4nE5Q14mj (size 1024 KB) containing data sent by client
> Created /tmp/tmp.QwpQYClFnm (size 1024 KB) containing data sent by server
> 001 MP_FAIL MP_RST: 0 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
>                                          sum[fail] got 0 data checksum error[s] expected 1
>                                          ftx[fail] got 0 MP_FAIL[s] TX expected 1
>                                          rtx[fail] got 0 MP_RST[s] TX expected 1
>                                          itx[ ok ] - infirx[ ok ]
> 
> A test log of running v6 500 times is attached, named v6-loop-500-times.log,
> in it, we can see retry happend 8 times (116, 136, 236, 295, 297, 402, 444,
> 457), and no "0 corrupted pkts" any more.

I'm still not sure I understand what happened. Could it be because the
subflow was never used to carry (enough) data and we never corrupt anything?

If that's the source of the issue, we can probably fix it by adding more
delay on the other paths or something similar, no?

If not and if you can reproduce it, may you also check IPTables and
counters if you don't mind?

  ip netns exec $ns2 iptables -t mangle -L OUTPUT -v
  ip -s -s link

Or because packets are dropped before MPTCP processing? We can also
corrupt more packets or even all the ones carrying enough data.

I think we should really avoid retrying except if we have a very good
reason to, e.g. something "normal" we cannot control, happening ~10% of
the time and we retry only if we confirmed before it was due to that.

>  - Reduce the single subflow test files size from 1024KB to 128KB to fix
> this "file received by client does not match" failure reported by CI and
> Matt in v5:

As long as we don't hide another bug :)

> # Created /tmp/tmp.crkOA4p7hr (size 1024 KB) containing data sent by client
> # Created /tmp/tmp.jFbZEAnYZa (size 1024 KB) containing data sent by server
> # file received by server has inverted byte at 195585
> # 100 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
> #                                          sum[ ok ] - csum  [ ok ]
> #                                          ftx[ ok ] - failrx[ ok ]
> #                                          rtx[ ok ] - rstrx [ ok ]
> #                                          itx[ ok ] - infirx[ ok ]
> # Created /tmp/tmp.crkOA4p7hr (size 1024 KB) containing data sent by client
> # Created /tmp/tmp.jFbZEAnYZa (size 1024 KB) containing data sent by server
> # [ FAIL ] file received by client does not match (in, out):
> # -rw------- 1 root root 1048604 Feb  9 11:37 /tmp/tmp.jFbZEAnYZa
> # Trailing bytes are:
> # MPTCP_TEST_FILE_END_MARKER
> # -rw------- 1 root root 1048606 Feb  9 11:37 /tmp/tmp.ghV0iWPhu5
> # Trailing bytes are:
> # MPTCP_TEST_FILE_END_MARKER
> # file received by server has inverted byte at 169
> # 101 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
> #                                          sum[ ok ] - csum  [ ok ]
> #                                          ftx[ ok ] - failrx[ ok ]
> #                                          rtx[ ok ] - rstrx [ ok ]
> #                                          itx[ ok ] - infirx[ ok ]
> 
> In the attached v6-loop-500-times.log, no "file received by client does
> not match" any more.
> 
> I think this v6 is very stable, but there are still 6 tests failed in the
> 500 time tests log (68 77 97 112 161 243). These failures are all due to
> get one more unexpected checksum failure:

OK so probably at the end, we didn't have issues because we had a hash
collision (no MP_FAIL while there were corrupted packets), that's good.

>  > cat v6-loop-500-times.log  | grep "\[fail"
>                                          sum[fail] got 2 data checksum error[s] expected 1
>                                          ftx[fail] got 2 MP_FAIL[s] TX expected 1
>  - failrx[fail] got 2 MP_FAIL[s] RX expected 1
>                                          rtx[fail] got 2 MP_RST[s] TX expected 1
>  - rstrx [fail] got 2 MP_RST[s] RX expected 1
>                                          sum[ ok ] - csum  [fail] got 1 data checksum error[s] expected 0
>                                          sum[fail] got 2 data checksum error[s] expected 1
>                                          ftx[fail] got 2 MP_FAIL[s] TX expected 1
>  - failrx[fail] got 2 MP_FAIL[s] RX expected 1
>                                          rtx[fail] got 2 MP_RST[s] TX expected 1
>  - rstrx [fail] got 2 MP_RST[s] RX expected 1
>                                          sum[ ok ] - csum  [fail] got 1 data checksum error[s] expected 0
>                                          rtx[fail] got 2 MP_RST[s] TX expected 1
>  - rstrx [fail] got 2 MP_RST[s] RX expected 1
>                                          sum[fail] got 2 data checksum error[s] expected 1
>                                          ftx[fail] got 2 MP_FAIL[s] TX expected 1
>  - failrx[fail] got 2 MP_FAIL[s] RX expected 1
>                                          rtx[fail] got 2 MP_RST[s] TX expected 1
>  - rstrx [fail] got 2 MP_RST[s] RX expected 1

I see it is also happening when only one packet has been corrupted. So
it is not because a few packets in a row have been corrupted I suppose.

I guess we don't have retransmitted MP_FAIL/RST here, right?

> These failures are related the checksum bug reported by me, issue #255.
> When transferring a larger file, the checksum sometimes fails. Running
> "./mptcp_connect.sh -C" in 10 times, we will the MP_FAILs. If we solve
> issue #255 in the future, this mp_fail testcases will be more stable.

Indeed, maybe linked.

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
