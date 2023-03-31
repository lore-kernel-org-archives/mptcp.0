Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D3818835
	for <mptcp@lists.linux.dev>; Fri, 31 Mar 2023 16:35:46 +0000 (UTC)
Received: by mail-ed1-f52.google.com with SMTP id i5so92094892eda.0
        for <mptcp@lists.linux.dev>; Fri, 31 Mar 2023 09:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1680280544;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WZwxEK4Vr2SjdlZqM1KsOdITrO8DeuDszlBiLJkWNQM=;
        b=FwL1ysTUoddcsEiKr3brr7cJ61nfl5sHd5DY6ZC5LjADccD/fXaYR1eH29s1RLnvCI
         3OrX7VHmtmmDPE9Gah1GFdEmI66SUaf/uOgr25wu0oMBXVr90XSYG7Fx2gzw7eOm6tO2
         qQYfiOZPmikiBPWO5VsmoqJSgPmAORcoLDZkcGvewQVhoLVAjzUQtyZtT+DuR2+akJfs
         aTOt5cr+ql4EsAso/00oweajeWF4OyhWvhD1IrCTE+CbuPi+2FkQbvAx0ij+8PtP7vj0
         UEQf+NmMrv5nNXjJEvtJIoCRN6KkmKfACOHipM2Oahtea1k0wAU7Ojo+VXjM4kkUepWA
         iLZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680280544;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WZwxEK4Vr2SjdlZqM1KsOdITrO8DeuDszlBiLJkWNQM=;
        b=EL2obd/zvG8g5HH3xjvvOUiOVxZ2jtAKUWe553CrrAf2p1FUxXwfvneD+IvHBcpEDZ
         HF0n7OWusVgNZRG2zYh1BI1wI202SWoJ0URWi8TRX+5ZcSHJFliH3cQPjGwzvMrk+o6B
         DNxgng0f+AdDSIDVlQEYfYxKPXaOmf28cuOEKl5il4Vo6SQ2z4NjM76pSnqosyVWBYG7
         HBSaevPGpq6MVGeb95QSE2yh1TLZ9ze90Cmg+3+XgGlQyrdSkGvHSpFWB0HbRFbE8qkm
         puJgaujwdbMUqfgMkbEplbMpD5AkOPU+Ci3LptIEIl0px1PUBZDlvmJxkawPYY3tw2YS
         H1jA==
X-Gm-Message-State: AAQBX9d7n9pvtzJFrkx9vGz2BbgjlA9bNFwBqXuoTI5HiPsNIITUKFzT
	NhvMXCogwfWqI9zqHgJSIGa407UCRI6d9rhczf5Unw==
X-Google-Smtp-Source: AKy350a+pu7x4jOY3s10CG/NCIcY29L6oku6agO264XmsMZRMROFAxLMstpN64v8cMQLf+xJsEYU8g==
X-Received: by 2002:aa7:d44c:0:b0:502:52dc:b9d0 with SMTP id q12-20020aa7d44c000000b0050252dcb9d0mr11727240edr.26.1680280544320;
        Fri, 31 Mar 2023 09:35:44 -0700 (PDT)
Received: from [10.44.2.5] ([81.246.10.41])
        by smtp.gmail.com with ESMTPSA id d7-20020a50cd47000000b005027ecc148esm828159edj.65.2023.03.31.09.35.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Mar 2023 09:35:44 -0700 (PDT)
Message-ID: <54df707a-ab98-fbd5-6e28-f97cffe1c2b8@tessares.net>
Date: Fri, 31 Mar 2023 18:35:43 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH mptcp-net] mptcp: fix NULL pointer dereference on fastopen
 early fallback
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
Cc: Dmytro Shytyi <dmytro@shytyi.net>
References: <07059bdc844f97430ff5c92afc548485b1c20d74.1680253474.git.pabeni@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <07059bdc844f97430ff5c92afc548485b1c20d74.1680253474.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo,

On 31/03/2023 11:17, Paolo Abeni wrote:
> In case of early fallback to TCP, subflow_syn_recv_sock() deletes
> the subflow context before returning the newly allocated sock to
> the caller.
> 
> The fastopen path does not cope with the above unconditionally
> dereferencing the subflow context.

Good catch! Thank you for the patch!

Reviewed-by: Matthieu Baerts <matthieu.baerts@tessares.net>

Now in our tree (fixes for -net):

New patches for t/upstream-net and t/upstream:
- f3df6e0f6a79: mptcp: fix NULL pointer dereference on fastopen early
fallback
- Results: f01e02dfadff..2ef375cf1603 (export-net)
- Results: 68957ea8fdf9..036dd2fa6b15 (export)

Tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export-net/20230331T163332
https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20230331T163332

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
