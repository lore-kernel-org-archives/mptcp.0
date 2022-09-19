Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1430C7C
	for <mptcp@lists.linux.dev>; Mon, 19 Sep 2022 15:14:54 +0000 (UTC)
Received: by mail-wr1-f43.google.com with SMTP id b5so47995284wrr.5
        for <mptcp@lists.linux.dev>; Mon, 19 Sep 2022 08:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=15L5ppRGWxdu1AzxtTDfMXfD1wRkvt2gL7rNRsMafk8=;
        b=co3OKAIeVTZx8EfDcIQtJr00gvUpPwbCThJKX6yFG3XFnC34k5jdKfevcqbsr1Px6n
         8zkrKJqYK/i1PpqSzNQaEYVw8xShhfIrQ2IZkbpwIHCySniR8awTnR8/Eo3NYuwVC+XD
         ZNHIJV00n+kfu83O/oICfpUozeEJyspp9tFboW7KsuDoWR2poEtwK4P0NSemW5gBQQ0I
         fKcM1PWI7F/6XFv5jmMK15iC2POMqwTBTZqOgTwOj7VmZ7LjVON4hgzYdwzFvf2bT+G2
         NRQWORJzz8wLOVrmb34Dt29TuK1+A7BuIOqOV9EJsywczKhD5GPmJhoJiMYKg+JvG5Mj
         tK2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=15L5ppRGWxdu1AzxtTDfMXfD1wRkvt2gL7rNRsMafk8=;
        b=yL6aHx2pPEBrixPkvcyaH8grd+WnBcF40kvBcXctHSWhI15g3K0pcVqrEqA4hfutWJ
         cgh7Ot0buuaNT2W6ZF1X15Ax8BZtbzKJ/Gj+/BRYLSKhwg6sVvCr5bnqvaIotIGYUdjY
         YbxzBuVgbMtSy+8IIoArvtdFb/2ul0KLnVovj+ZxQpHkECJsgDfinfNb5vJDJgiZL2U4
         12MxvdJEqCDJeUiIDs0rN1CDI4pndvJ9oFAvjcjZ0joTXUW2DtM55Tinw56IZM1mPxoH
         G9Srilyrd+tq2G/ep7LR6hxbNIjsCPP0efCKup2XI2Zo3OYMleEUEEbnv6WSy+g3HYN4
         zQ/w==
X-Gm-Message-State: ACrzQf2BZANfx2pemoPUZIX2haPDoTBBgZS4YRT9E3Hu3NufveX5bZPs
	6Fxm9bEKlDZnGHrJigz6BBlA7Jyxy0LLig==
X-Google-Smtp-Source: AMsMyM64V7s5kD+INIBwOfFDkbs2IVM3G1trCbq38JlCOpNA5DzdUGTPEYtTxGeNA3gYHB26gzttlA==
X-Received: by 2002:a5d:6052:0:b0:22a:2ee9:4377 with SMTP id j18-20020a5d6052000000b0022a2ee94377mr10846158wrt.449.1663600492937;
        Mon, 19 Sep 2022 08:14:52 -0700 (PDT)
Received: from [10.44.2.26] (84-199-106-91.ifiber.telenet-ops.be. [84.199.106.91])
        by smtp.gmail.com with ESMTPSA id s15-20020a5d510f000000b00228655a5c8fsm13981510wrt.28.2022.09.19.08.14.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Sep 2022 08:14:52 -0700 (PDT)
Message-ID: <f7f23136-3227-5c80-45c0-29a52c5ec11a@tessares.net>
Date: Mon, 19 Sep 2022 17:14:52 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH net v5 0/2] net: mptcp: fix unreleased socket in accept
 queue
Content-Language: en-GB
To: menglong8.dong@gmail.com, pabeni@redhat.com
Cc: mptcp@lists.linux.dev, Menglong Dong <imagedong@tencent.com>
References: <20220911041418.818201-1-imagedong@tencent.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <20220911041418.818201-1-imagedong@tencent.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Menglong, Paolo,

On 11/09/2022 06:14, menglong8.dong@gmail.com wrote:
> From: Menglong Dong <imagedong@tencent.com>
> 
> The mptcp socket and its subflow sockets in accept queue can't be
> released after the process exit.
> 
> While the release of a mptcp socket in listening state, the
> corresponding tcp socket will be released too. Meanwhile, the tcp
> socket in the unaccept queue will be released too. However, only init
> subflow is in the unaccept queue, and the joined subflow is not in the
> unaccept queue, which makes the joined subflow won't be released, and
> therefore the corresponding unaccepted mptcp socket will not be released
> to.
> 
> In the 1th patch, we factor-out __mptcp_close() which should run under
> socket lock.
> 
> And in the 2th patch, we fix the problem we mentioned above by closing
> all of the unaccepted mptcp socket in mptcp_subflow_queue_clean()
> with __mptcp_close().

Thank you for the patches and the reviews!

This series is now in our tree (fix for -net) with Paolo's ACK and
without one typo found by "checkpatch.pl --codespell" and 'net:' prefix
has been strip from the commit titles ('mptcp:' is enough)

New patches for t/upstream-net:
- 8c21b4904d34: mptcp: factor out __mptcp_close() without socket lock
- f00ac22032b8: mptcp: fix unreleased socket in accept queue
- Results: 69b3bebab7a6..2882a52515ba (export-net)

New patches for t/upstream:
- 8c21b4904d34: mptcp: factor out __mptcp_close() without socket lock
- f00ac22032b8: mptcp: fix unreleased socket in accept queue
- Results: 6cd726fd86f8..6c59a4b0aee6 (export)


Tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export-net/20220919T151225
https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20220919T151225


Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
