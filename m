Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 986D5173
	for <mptcp@lists.linux.dev>; Wed, 29 Dec 2021 13:52:54 +0000 (UTC)
Received: by mail-ed1-f45.google.com with SMTP id z29so86537884edl.7
        for <mptcp@lists.linux.dev>; Wed, 29 Dec 2021 05:52:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=72ycZt8xg2tWrzfzjy+Gr2FGCaIBLHC6zA2gD35gWI8=;
        b=QLH3gnnoprUUe0Co6y2Nzb9wMNLWhHC+zaeWeGOaPtlSC8RL7mVp9aAHXWQtlddo7F
         oJ320/UPVZy5SQWfum3LCFyZdlccjYrOysqBB4R3qtCj/s5y5o8+0Pcv0yDSoJYhdMgg
         diKJYeq1F5zWSmevWbyx9H6P5OIFW8prZHtLwaCSwNUzZT4NHgbkEN8vtvcp/8Im7WYP
         kc3vrx0FgLYlmKglI9cmO6a8edvpMS44iScVueNVJ9K9vZTap9qsV/sNTiR8kmgZ5sf2
         0IRjitwcxR7BPQA42d8gXQF0DP/ATM1hK3Fcjg8r0SOxN368habxqWdex30uMDv44k5e
         oZrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=72ycZt8xg2tWrzfzjy+Gr2FGCaIBLHC6zA2gD35gWI8=;
        b=TTeF16Ofe2Hbt8aYXTWwfCrMT5Ypv2eUSkhnTjdrw8F6lnuaqXF21KnvY2700HolyA
         Mq6iqU0YoG0aPxlgDGIpGQRYOayOGKzggPct3heOcZV+spUrIF9/UJ4ufsN4lVC9s/4/
         Dvh2JX4G5QNwUlBLPIxD19wx/jfH8DAmxoPXkCGnTEhnfmHAKMjlBLUreV2TZ4HJGvEy
         O61/eh3yNqXJ13WNVyKSgNEs2LbxvCSehujFw88uCZOxdcleCNspoj889tDzn/e0sPfL
         hyTsxy2Lc5UYbPBcVOGGNumY7rd20L1uSctSH4Q+5XL/hS8W6iacdKifSGuZ3sWSEt5c
         eKCA==
X-Gm-Message-State: AOAM531NTSe/iyoJepFmmH+vI83/k7YxFj2iaX7XnTKeAUM/TkVEsr79
	f75dUSfJ2HwUBzWc+04KroYcwg==
X-Google-Smtp-Source: ABdhPJzPUrQaoda/AJx5X2xRhX/zfuPMywbil7KuDGNvGxjJkdbAIm9QzvJtZOlXc4uNm65o3njEeA==
X-Received: by 2002:aa7:cd45:: with SMTP id v5mr26522899edw.163.1640785972625;
        Wed, 29 Dec 2021 05:52:52 -0800 (PST)
Received: from ?IPV6:2a02:578:8593:1200:4173:e151:33e7:c1de? ([2a02:578:8593:1200:4173:e151:33e7:c1de])
        by smtp.gmail.com with ESMTPSA id sc34sm6951029ejc.7.2021.12.29.05.52.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Dec 2021 05:52:52 -0800 (PST)
Message-ID: <4f968c6b-9004-8b17-6715-824bb95cb740@tessares.net>
Date: Wed, 29 Dec 2021 14:52:51 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH mptcp-next 07/21] mptcp: netlink: process IPv6 addrs in
 creating listening sockets
Content-Language: en-GB
To: Kishen Maloor <kishen.maloor@intel.com>, mptcp@lists.linux.dev
References: <20211216222314.1244708-1-kishen.maloor@intel.com>
 <20211216222314.1244708-8-kishen.maloor@intel.com>
 <e9dd7944-6eb5-b96e-4192-d52c98decffc@tessares.net>
 <c84d9c47-0ef8-4e00-3724-b6e323c0bba4@intel.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <c84d9c47-0ef8-4e00-3724-b6e323c0bba4@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Kishen,

Thank you for your replies!

On 21/12/2021 08:32, Kishen Maloor wrote:
> On 12/17/21 8:29 AM, Matthieu Baerts wrote:
>> Hi Kishen,
>>
>> On 16/12/2021 23:23, Kishen Maloor wrote:
>>> This change updates mptcp_pm_nl_create_listen_socket() to create
>>> listening sockets bound to IPv6 addresses (where IPv6 is supported).
>>
>> Should we consider this as a bug?
> 
> We could I suppose, at least for lack of completeness. But you're right that we've
> now updated the behavior in this series in attempting to create listening sockets (lsks)
> corresponding to every announcement, which necessitates this handling of
> IPv6 addresses. 
> 
> But prior to this series: 
> -lsk creation (through a subflow's port) did not happen in the kernel under the assumption
> that MPTCP server applications would've established a listener,
> -lsks were created only for port-based endpoints

Yes, that's correct.

> which (I believe) would not work with
> IPv6 (lack of option space), and,

Yes, there is enough space. We even have packetdrill tests, no?
ADD_ADDR are sent in a dedicated ACK packet, without DSS. I think we
started to discuss about having a dedicated ACK packet to cover this
case and ADD_ADDRv6 + echo I think.

> -the stack did not allow incoming MP_JOINs at machines running MPTCP client 
> applications (with this series, subflows can be established from either end so there
> needs to be an lsk).

If I'm not mistaken, that was by design: to simplify things.

It is very rare and very specific when a server initiates connections. I
think in most cases, the client would like to be in charge of initiating
paths and would not like the server to do so.
But as it seems not to be too complex, it is good to have a way to do
that. But I think we would need an option to (dis)allow that.

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
