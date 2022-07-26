Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16C9A538E
	for <mptcp@lists.linux.dev>; Tue, 26 Jul 2022 17:13:53 +0000 (UTC)
Received: by mail-ej1-f51.google.com with SMTP id j22so27375920ejs.2
        for <mptcp@lists.linux.dev>; Tue, 26 Jul 2022 10:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=ZD5NRKl75XQ9bEzzNZ2TIRV6Zmonf7ak4PRbrxHuILw=;
        b=EiHXDOUVpK1540z2hixTUigxc4YhlrjXuB+3Yur7f1evA/WhEkMsdtfPSamhOqvxmJ
         Ehi0u7UeTAknjJZMb43QVgFdyy3XSuxgkX1YOTFyJ9vV8Q26ejD0ya8NLOPvKkR0JT2C
         xWmhcHuCdhxyo+ErVJ/Q/cx2l4IOVOK03RhVLKCK1TxG0PJrb7HQV+cuh+/2Jiv1qtan
         c6piU9x9SYAW38HX36gltVh+ohNOwkwqh+cIXRxxCVgzn0tbPc8gOfx0RZ1+/1vKmcqy
         s6yR/k4kZxjSTDR33sqhIwAcbdHCRkLn1Ddeqd/Amlq9RPtXfIokSfl9V1xscsS6o8Er
         4XyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ZD5NRKl75XQ9bEzzNZ2TIRV6Zmonf7ak4PRbrxHuILw=;
        b=jcrc6+qBjCR24o5oDrlWhZU7bRGtabLgogM6r5vXnxUlvo65bmZzcqQADbG43kw8jr
         wwrCCNMiMDucWRo+gKsZQVnK+vrydc1xXJBgtRW07zebUGXxtkOuZrqWycEO2vAtrO/t
         LQ4yud7Rad3R705VFvlv/ZjB2dMqrPPpkaKQMwdrt5eBJ+XQQI5VTnBK22TcKbsJCUL6
         sdhtswaicWG7BqK/taCD8IUA4Lwq65nxhcFUgRUoT8/xApkB7rfkdDBPMXFrJQH/qyo1
         hm/lq6wSyyjzYPj1Vf6/2h+8AS5+9eXJ1sYMVXAuLAKdcyo0QVO8X2K/0AwmD0FIeFQV
         q65Q==
X-Gm-Message-State: AJIora/db7iQ7fIrLWg1c191CKqk77iNwXGBmwIAQp33J1FE9hPp/BTI
	L2ckKh2qQ4UMVNodyPShZnbzoQ==
X-Google-Smtp-Source: AGRyM1s/Cs2mRDtWwBKYyCdP6+JiOzjH7NfFPl3HXcq9uHe/aKc3wjxeTIfAF52SUIMG5slts+jvcg==
X-Received: by 2002:a17:907:97cd:b0:72f:2df:274f with SMTP id js13-20020a17090797cd00b0072f02df274fmr14446780ejc.766.1658855631842;
        Tue, 26 Jul 2022 10:13:51 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:398c:c3ae:6fb2:e421? ([2a02:578:8593:1200:398c:c3ae:6fb2:e421])
        by smtp.gmail.com with ESMTPSA id r2-20020a1709060d4200b00722e57fa051sm6606507ejh.90.2022.07.26.10.13.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Jul 2022 10:13:50 -0700 (PDT)
Message-ID: <0664cad2-322f-8cb0-b6ef-d3e9bc7e3cd5@tessares.net>
Date: Tue, 26 Jul 2022 19:13:50 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.0.3
Subject: Re: [PATCH mptcp-net] mptcp: do not queue data on closed subflows
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
Cc: Dipanjan Das <mail.dipanjan.das@gmail.com>
References: <937464128633daa18ebc093215ac04487f001b3f.1658769042.git.pabeni@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <937464128633daa18ebc093215ac04487f001b3f.1658769042.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo, Mat,

On 25/07/2022 19:10, Paolo Abeni wrote:
> Dipanjan reported a syzbot splat at close time:

(...)

> The root cause of the problem is that an mptcp-level (re)transmit can
> race with mptcp_close() and the packet scheduler checks the subflow
> state before acquiring the socket lock: we can try to (re)transmit on
> an already closed ssk.
> 
> Fix the issue checking again the subflow socket status under the
> subflow socket lock protection. Additionally add the missing check
> for the fallback-to-tcp case.
> 
> Reported-by: Dipanjan Das <mail.dipanjan.das@gmail.com>
> Fixes: d5f49190def6 ("mptcp: allow picking different xmit subflows")
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>

Thank you for the fix and the review!

Now in our tree (fixes for -net):

New patches for t/upstream-net:
- 6f471fc45a7c: mptcp: do not queue data on closed subflows
- Results: 76dabdd1e02b..42b7bf36daba (export-net)

New patches for t/upstream:
- 6f471fc45a7c: mptcp: do not queue data on closed subflows
- f79659168250: conflict in t/mptcp-add-get_subflow-wrappers
- Results: f6822255c960..b6a8d1e56468 (export)


Tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20220726T170140
https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export-net/20220726T170140

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
