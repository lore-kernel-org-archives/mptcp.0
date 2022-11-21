Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15649A32
	for <mptcp@lists.linux.dev>; Mon, 21 Nov 2022 10:37:09 +0000 (UTC)
Received: by mail-ej1-f50.google.com with SMTP id me22so10886865ejb.8
        for <mptcp@lists.linux.dev>; Mon, 21 Nov 2022 02:37:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=p5s7f/cRgM02AebSbAvjSWQv4dYm7v0z3VBFDSMFxEg=;
        b=lCSvk+vR20oZ5G5aLfsWV7w77KgWgvmqp5DxVYUNyPABmgpFfEQuOF0evt6yDjydeU
         uqSoD97qPKL7WhIYJzi8ulUglBpvGlbZO3iOfmy/iTSTEghIDWxarwUB+wCiKwggRy2M
         qbtW7DoeTibv/2BXMl1BEW08+f1TDRGjtxJJHPRxEAcCgmPOrVWplvr2oGx82YgHLzsG
         xzwlxM+K/IeG8FNPk0DhEwLf3d33Jdlecx7Q3SQ/Dk7ELas8Ijjf40aNyjGU/nt85gnW
         tgEOg+yAYfeOHwdf4LDotVVM/IMM3Vz8MPTS4ToRz1LUrPR+MEYtT6rLei3CGphovs1f
         QasQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p5s7f/cRgM02AebSbAvjSWQv4dYm7v0z3VBFDSMFxEg=;
        b=lPF0FOYJO0FUVJxStY9jG1ZqgPUj3qPdgVje/16iRLC+DlacWL01p52jjK/+ER5pzf
         NTczG4M9sFF8eAa0sT7MDA35UTx/72y2IswMxvbGXiVGfyjA+i9OlcEZnl0dEAoe54J0
         wd9O7CX9ZkH2bxCKzBNAHx85+PHASFtlHdY/FcxEHagRaFSYIdaODRdfAEV9Kn4Tceq/
         b2myb50E/aEUauz0rMnFn8y3Pe7k/mdkzU155H1l+amsbJsX0Yf6kQ7s9T1DmHaTes4l
         BYdP8U70YM04fstEJPA6u7DNn81b+uaCBt+E5j/7N6nuFm29Py0EA2msjVvViYDxowea
         0qsw==
X-Gm-Message-State: ANoB5pneyVGiyitoQYjbw3JJRBy0kGnyW7UfcV+YJRhyxZFDID+Rty5h
	sUDy167mSd3eR4GIHSxdLAz9aQ==
X-Google-Smtp-Source: AA0mqf4eYgBMh4ITZryTA5uSQpA376V1vakdAmfQahG2raJJMzB9RIDespyNVlxfrW4o95sv29cilg==
X-Received: by 2002:a17:906:fcd0:b0:7ad:b8c0:3057 with SMTP id qx16-20020a170906fcd000b007adb8c03057mr14871822ejb.440.1669027027259;
        Mon, 21 Nov 2022 02:37:07 -0800 (PST)
Received: from [10.44.2.26] (84-199-106-91.ifiber.telenet-ops.be. [84.199.106.91])
        by smtp.gmail.com with ESMTPSA id p2-20020a056402044200b00461e4498666sm5015902edw.11.2022.11.21.02.37.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Nov 2022 02:37:06 -0800 (PST)
Message-ID: <9771a38b-85e9-599d-b7e2-00483146d37c@tessares.net>
Date: Mon, 21 Nov 2022 11:37:06 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH mptcp-net v2] mptcp: don't orphan ssk in mptcp_close()
Content-Language: en-GB
To: menglong8.dong@gmail.com, pabeni@redhat.com,
 mathew.j.martineau@linux.intel.com
Cc: mptcp@lists.linux.dev, Menglong Dong <imagedong@tencent.com>,
 Biao Jiang <benbjiang@tencent.com>, Mengen Sun <mengensun@tencent.com>
References: <20221121034140.548112-1-imagedong@tencent.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <20221121034140.548112-1-imagedong@tencent.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Menglong, Paolo,

On 21/11/2022 04:41, menglong8.dong@gmail.com wrote:
> From: Menglong Dong <imagedong@tencent.com>
> 
> All of the subflows of a msk will be orphaned in mptcp_close(), which
> means the subflows are in DEAD state. After then, DATA_FIN will be sent,
> and the other side will response with a DATA_ACK for this DATA_FIN.
> 
> However, if the other side still has pending data, the data that received
> on these subflows will not be passed to the msk, as they are DEAD and
> subflow_data_ready() will not be called in tcp_data_ready(). Therefore,
> these data can't be acked, and they will be retransmitted again and again,
> until timeout.
> 
> Fix this by setting ssk->sk_socket and ssk->sk_wq to 'NULL', instead of
> orphaning the subflows in __mptcp_close(), as Paolo suggested.
> 
> Reviewed-by: Biao Jiang <benbjiang@tencent.com>
> Reviewed-by: Mengen Sun <mengensun@tencent.com>
> Signed-off-by: Menglong Dong <imagedong@tencent.com>

Thank you for the patch and the review!

Now in our tree (fix for -net) with Paolo's RvB tag, a Fixes tag and
without the typo (s/date/data/):

- e8695e504942: mptcp: don't orphan ssk in mptcp_close()
- Results: 09c91a08d1dd..f5e72ede5629 (export-net)

Tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
