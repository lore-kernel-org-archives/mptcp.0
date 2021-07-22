Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08643168
	for <mptcp@lists.linux.dev>; Thu, 22 Jul 2021 09:21:59 +0000 (UTC)
Received: by mail-ej1-f43.google.com with SMTP id gb6so7406869ejc.5
        for <mptcp@lists.linux.dev>; Thu, 22 Jul 2021 02:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Vt8qjy/Y9MdUewLV3xbIf3eIFsrFVuA56va+CBJYhUA=;
        b=NRQQBtIwDsHGrG4MWwD6bR/rm1szoz2eAlPqoOIG0rFTrDthIQAeWs595nB5jL16cG
         AB6RFgYF2GuwhB2+n7Hm0z7u11J82jld/ehTJRnfwYWk5hqmG+SKBp6JZc9fCeA7fsGq
         xkMdY37am7Oada1ccAd/rcnMmHRFerqNpq2bfKzMGiY8SYRjLqy9CSzUGxBNmcIJiQW6
         aoA5/J56QF+9oPeMGFWzQayzo7+i93BaPvKbCgfDcbKyoYxnaQkNcL0ylYaMrRUX0VwJ
         drWDbt6D6uoaGwigUvmIj3vLeS21qMVNZnHS9yF0SObC0HdSLyOgR4fkndFNuFO9MB+u
         aBmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Vt8qjy/Y9MdUewLV3xbIf3eIFsrFVuA56va+CBJYhUA=;
        b=HtGBk1cA3YPQ0HyXBk6pT8C1dOvbTRTY2Lf1qfflbk4HEsZZcDWfMfiQXWvrj5gYZn
         Qo9Qu0LZ4yBBxl7hP1E8vprAuEmT1jAvbqRv8D9GC6pb/T7fVyjEc8miiz8LDKxn+0vX
         aBLK/V7mxJc60q99iNedgYdcMTEBR9+1yIY5jAump+LLP8+hAZxzzRTCLuj3/jAPXCF8
         mJ+VLs1Z6ouY/m0gfLqXEwprIpeDuw2Aa5AAFmwWLO3olDMaDJcKSyfhPbvqdhRbv/zr
         ecFJjehbtKlnOqUaTy4FF4QG5H/LYl1ry08XoFKNrQp7dYOgeFj8erMdgXlP0CWslme3
         a0vQ==
X-Gm-Message-State: AOAM530oxOpGaINNv82K50nladaMJcYwS19WvGT++eADyk568E89BFSg
	x1YlyowH9GKiCOuT+fAJGtVPJIoXWtoZ00EDJjk=
X-Google-Smtp-Source: ABdhPJzIqWKft+S00sl0QGPKiUWLT8yHck/Rht8U2g28JElxskWl1jntFYr6nifRnLgJy+m8qmOo3A==
X-Received: by 2002:a17:906:1156:: with SMTP id i22mr43615302eja.167.1626945718062;
        Thu, 22 Jul 2021 02:21:58 -0700 (PDT)
Received: from tsr-lap-08.nix.tessares.net ([2a02:578:85b0:e00:8391:ca7f:9c1b:4236])
        by smtp.gmail.com with ESMTPSA id n11sm9475869ejg.111.2021.07.22.02.21.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Jul 2021 02:21:57 -0700 (PDT)
Subject: Re: [MPTCP][PATCH v9 mptcp-next 0/6] mptcp: fix conflicts when using
 pm.add_signal in ADD_ADDR/echo and RM_ADDR process
To: Geliang Tang <geliangtang@gmail.com>,
 Yonglong Li <liyonglong@chinatelecom.cn>,
 Mat Martineau <mathew.j.martineau@linux.intel.com>
References: <cover.1626404090.git.geliangtang@gmail.com>
Cc: mptcp@lists.linux.dev
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Message-ID: <69cb5d6b-b61d-4d0a-ff7d-22382f52295f@tessares.net>
Date: Thu, 22 Jul 2021 11:21:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <cover.1626404090.git.geliangtang@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit

Hi Geliang, Yonglong,

On 16/07/2021 05:12, Geliang Tang wrote:
> From: Yonglong Li <liyonglong@chinatelecom.cn>
> 
> fix issue: ADD_ADDR and RM_ADDR use pm.add_signal to mark event, so
> in some case pm.add_signal will be flush when ADD_ADDR/RM_ADDR in
> process.
> 
> fix issue: if ADD_ADDR and ADD_ADDR-echo process at the same time,
> only one event can write pm.add_signal. so ADD_ADDR will process
> after add_timer timeout or ADD_ADDR-echo will not be process.

Thank you for these patches!

I just applied them in our tree to get more feedback.

- fea9f8b0171f: mptcp: move drop_other_suboptions check under pm lock
- 097eb5756742: mptcp: make MPTCP_ADD_ADDR_SIGNAL and
MPTCP_ADD_ADDR_ECHO separate
- edaad5420e34: mptcp: fix ADD_ADDR and RM_ADDR maybe flush addr_signal
each other
- b140ddc3f7eb: mptcp: build ADD_ADDR/echo-ADD_ADDR option according
pm.add_signal
- 90f451056fe9: mptcp: remove MPTCP_ADD_ADDR_IPV6 and MPTCP_ADD_ADDR_PORT
- bb8637ec2243: selftests: mptcp: add_addr and echo race test
- Results: 519fb8907fda..3a1215522891

We can leave them a bit in our tree for more tests and also to wait for
Mat's feedback as he helped reviewing the previous versions. No urgency
there anyway.

Builds and tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20210722T091935
https://github.com/multipath-tcp/mptcp_net-next/actions/workflows/build-validation.yml?query=branch:export/20210722T091935

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
