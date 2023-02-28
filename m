Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D46A944C
	for <mptcp@lists.linux.dev>; Tue, 28 Feb 2023 18:05:01 +0000 (UTC)
Received: by mail-ed1-f53.google.com with SMTP id ck15so43844913edb.0
        for <mptcp@lists.linux.dev>; Tue, 28 Feb 2023 10:05:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:in-reply-to:from:cc:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aOLJcznK2WmzyoyyLyS3WYhveMUFHeQmA0hkoj2kJyM=;
        b=cgEShcCKSQhhlyuOm+uZUKfmG+MwYeNWlEE0kPfEZOsbcEyIZDS4bGh0JyEchdw4aq
         iq5HxG7Ou9bd3ld22oVMYkMLLc71/59KcTm2Op4F2zRJt8xonMise26XOE2DhtCF+zBz
         go/Ym1Nyq5vIjkr8IRuiHLeeXklt3ULZVEGR3ZdegUpi0A1A/1faMRgTAGbFWZzyKDT4
         y+ma7Wbwe3Yc31wCoZhnE7cCQ2Nf/GiA/Cux3tzAFpca9SqrpNmfJPbdXEgTrEqm3J1N
         Bs3C1AXppfE33SSY3EnAo1X/+/ILTxwoXsWXgqI/ULIDvBmmVA076Qs5Bn79j41Ai3dK
         LQSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:cc:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aOLJcznK2WmzyoyyLyS3WYhveMUFHeQmA0hkoj2kJyM=;
        b=4NILlUByF1zmC5T5z2ecRRUdk2UHiCt4S/TnT75Aq8tLdD8cPq8UYK2sWmitR6dyET
         WcjX2gDXKkvDmYkBEBYIQ/Ia9GvPkGPZh20NuJMtqhqPVhqvxFRco1AemstiOxqH/IMh
         xJPlBm+5hRGTxd+EsbBdSuV4BNkm9d2oPrc7k1bXJGoAHp71+ZGpIgY0WKvZt664w29I
         85moZF3QlW/S3XIkoP+pAryJ5wymKLdzfarCVT/aY0lDk8ZjM2nkm3rZJvgKNgHzcU4z
         AAQL9tAyKrQWw/3BQcNL4xjtCVJyoqyhmDPr84o5enI6tkDl2qtDKOxVxgM+Ol33bnta
         j/Vg==
X-Gm-Message-State: AO0yUKU1mH8VaOKyVkx76yMK0ygBYkOSC5Pa4Z2fW6J5J5XWUju/tOIx
	uZgCRxJHkWk53BdqTGCmcHGnvQ==
X-Google-Smtp-Source: AK7set9FM/hVGDMkvKtHGDli2Xxjk2FEDbdjQ8jwiuZHPa3QJcTVMc9VEqyyRt9exo6aro8GIXflAw==
X-Received: by 2002:aa7:c989:0:b0:4ad:5220:79ef with SMTP id c9-20020aa7c989000000b004ad522079efmr4433024edt.8.1677607499991;
        Tue, 28 Feb 2023 10:04:59 -0800 (PST)
Received: from ?IPV6:2a02:578:8593:1200:57a5:5793:c93a:632e? ([2a02:578:8593:1200:57a5:5793:c93a:632e])
        by smtp.gmail.com with ESMTPSA id qq10-20020a17090720ca00b008e09deb6610sm4700327ejb.200.2023.02.28.10.04.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Feb 2023 10:04:59 -0800 (PST)
Message-ID: <f2be51fa-2b80-2b95-5374-0c74611d89e3@tessares.net>
Date: Tue, 28 Feb 2023 19:04:58 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH mptcp-net 1/2] Squash-to: mptcp: use the workqueue to
 destroy unaccepted sockets
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
References: <ee3e0181ffd7e4d81ed43d27f18401da3d5927d6.1677600530.git.pabeni@redhat.com>
Cc: Christoph Paasch <cpaasch@apple.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <ee3e0181ffd7e4d81ed43d27f18401da3d5927d6.1677600530.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo,

On 28/02/2023 17:19, Paolo Abeni wrote:
> The workqueue could trigger before inet_csk_listen_stop() kicks-in,
> or the closed socket could even land to accept(). Solve the race
> falling back to TCP - we already complete the MPTCP level close
> signaling.
> 
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/366

Thank you for the patch! I just applied them in our tree (I didn't wait
for the CI because it is not launched with series without cover-letter)

New patches for t/upstream-net and t/upstream:
- 430272c257f3: "squashed" patch 1/2 in "mptcp: use the workqueue to
destroy unaccepted sockets"
- 03d9f4ab2222: "squashed" patch 2/2 in "mptcp: fix UaF in listener
shutdown"
- debc0d5178b4: tg:msg: add v2 note for
t/mptcp-fix-UaF-in-listener-shutdown-net
- d84418297384] tg:msg: add v2 note for
t/mptcp-use-the-workqueue-to-destroy-unaccepted-sockets-net
- Results: 514a81fd1aca..32ae3eb24f07 (export-net)
- Results: 9c607bd60779..aea9c8c6d129 (export)

Tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export-net/20230228T175908
https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20230228T175908

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
