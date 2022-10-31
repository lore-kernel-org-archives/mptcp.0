Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3D2E7E
	for <mptcp@lists.linux.dev>; Mon, 31 Oct 2022 15:13:39 +0000 (UTC)
Received: by mail-wr1-f51.google.com with SMTP id bk15so16380344wrb.13
        for <mptcp@lists.linux.dev>; Mon, 31 Oct 2022 08:13:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LjsbPG2IVm3pHSnnKzkgjqBtg1XdJ+vZ2TKzIlk3ow0=;
        b=4mxRev8+PY3fpHB7AHa5B0WksAygUcn74wnMyt3lsR2NszX00XNdaKgGrHc2k44oLd
         2H3JZkIhHvYGISXFbJ/yMUPfLLM7BDY4cHL/HQViQTd6BkAfw35BAyaa+RDJirE9MHIk
         yu1gNuPqNn7Ih1SSka87VsFgucUnfFIIAaCWbTjjKUtiCPDNhhAiwUJKk+IrZ7F2wt2O
         maSZJITwUQdAVYY5B+4X63hasdL9/KtTzLJSJRJ7X4n8nXC8/qajciF4oVFPBX54vmas
         WgssTVrsoxutyy0z5lHLOFlnz27w0Zz+aQqjWvIwDAPRQwVWwHqIp+99Qik/GWO1OJR6
         28vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LjsbPG2IVm3pHSnnKzkgjqBtg1XdJ+vZ2TKzIlk3ow0=;
        b=UZM3nG4Vm8GXZbm1TUpMLZW3xqDFuTP9D4a75ODzNFawwd612yxLzfzSvCr3V1m2HE
         tU0uqH0ycdfz3jAcG0l5woiN6rtbVvfbNeRT88hUJj+KH7Oj++CtMUlC/cTRjiAvj5cL
         +NYOdLTGbXmgE36HW53CRGWPIHwuPdhI0Pn+Ef5u22zDYnARfGPBC5sDDgQZDY6XSBLs
         tez1tDQL9Lbz6GjSoD6uy2VT51o2SCcBtoO4Rpulcsa67P+rblS4HIZvKuqK6UPTLZcU
         fCBE33ll0Re2Hd1XrugcDaHxk26faIEgctLHXqJpXieTm7YujBkOJrSjxoFsFpIv11rE
         T3Sg==
X-Gm-Message-State: ACrzQf0Be87fJdO0mS+wPLgdfnflo24UPY3l7BAeBh1lBB9TtxbKUu/w
	kIEiN4p5M5Ae5MSAbmMDfhu1S3na5b8C7Q==
X-Google-Smtp-Source: AMsMyM6TlhlOtqB1zyaUUsvJRhnxIA+L/clRhdtpnmcUlnsKJSChtcdj+lASJcX5ytQIePuvHC8rAA==
X-Received: by 2002:a5d:6550:0:b0:236:960f:15cf with SMTP id z16-20020a5d6550000000b00236960f15cfmr8513613wrv.177.1667229217772;
        Mon, 31 Oct 2022 08:13:37 -0700 (PDT)
Received: from [10.44.2.26] ([81.246.10.41])
        by smtp.gmail.com with ESMTPSA id k2-20020a5d6282000000b00236cb3fec8fsm4424430wru.9.2022.10.31.08.13.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Oct 2022 08:13:37 -0700 (PDT)
Message-ID: <206ccc44-7f26-b14f-5a56-e4a22a2ce4fa@tessares.net>
Date: Mon, 31 Oct 2022 16:13:36 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH mptcp-next v2] Revert "mptcp: add get_subflow wrappers" -
 fix divide error in mptcp_subflow_get_send
Content-Language: en-GB
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
Cc: Mat Martineau <mathew.j.martineau@linux.intel.com>
References: <95f77f38e54f9564608e844f507701c04745475b.1666668425.git.geliang.tang@suse.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <95f77f38e54f9564608e844f507701c04745475b.1666668425.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang, Mat,

On 25/10/2022 05:27, Geliang Tang wrote:
> This reverts commit 8ae8437eb930b887219dc50b159322f6f9331bfb.
> 
> The wrapper mptcp_sched_get_send() will be added in the later patch
> "mptcp: use get_send wrapper", and the wrapper mptcp_sched_get_retrans()
> will be added in the later patch "mptcp: use get_retrans wrapper".
> 
> Fix this divide error:
> 
> ----
> divide error: 0000 [#1] PREEMPT SMP KASAN NOPTI
> CPU: 0 PID: 14336 Comm: syz-executor.6 Not tainted 6.1.0-rc1-00215-g47aa7f23f440 #1
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
> RIP: 0010:div_u64_rem include/linux/math64.h:29 [inline]
> RIP: 0010:div_u64 include/linux/math64.h:128 [inline]
> RIP: 0010:mptcp_subflow_get_send+0xa87/0x1200 net/mptcp/protocol.c:1486
> ----
> 
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/314
> Reported-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>

Thank you for the patch and the review!

Now in our tree:

- dce423f5bbb7: "squashed" in "mptcp: add get_subflow wrappers"
- Results: 9bcf275fb027..d708694301f4 (export)

Tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20221031T151210

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
