Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A2FE70
	for <mptcp@lists.linux.dev>; Mon, 28 Jun 2021 16:45:49 +0000 (UTC)
Received: by mail-ej1-f51.google.com with SMTP id bg14so31002995ejb.9
        for <mptcp@lists.linux.dev>; Mon, 28 Jun 2021 09:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=to:cc:references:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ffK6KdgxDQ0O7nup8iYnyRkcTkZ/cmhe7JPcIzmSvsw=;
        b=RoI2vAW8UBmnJrx6scOeqfISunbXe/26Bzk+yjAc7vyKvs7N4h049cXB1nlX6uN5D5
         P+XpsPIX8c3VVR5s7bsQvieuVg2LZAjVcYk9We6PWc85bTDrpQgg2WwwcYVmCIpdIvlO
         Pg+oatxKwjvxvKzky58Rnr/1XRtSbXsrn9H6gtwj5qLdA1YRLSMOHsCqTP56dfv3DiJ7
         3Y/+7y+xEXD8lrURhoqlh4dZXRjTMQNBynyzTlPOQRupSMca8rBMaZYxv1k/XZW5qcAb
         +l9hAB+TcMqW5Cn7vfjhQup84qjPUCw0DJR/iZj1NaYxM2slA2KWVUYPhnYEePamwi03
         YJmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ffK6KdgxDQ0O7nup8iYnyRkcTkZ/cmhe7JPcIzmSvsw=;
        b=oFD5xDJd1z0tePaWIR4oR81aC14YcnWtOe2neMGEeZS6vrQCAmOD34jZfqeZW57Bvj
         8+AiXgVQwwPKkpNcdxwxcWrjOLA0+6JikkjAFOUn0UZ6/m1gB3ZoPoxy88VL96ZZkwFj
         w4Yjn8nmzvDs1PObo9u07rKqtvV0S+tSW8wss+sLaoAnzgz425gdVMLUF7rwx85IqE0+
         4Qtjit2ROC+nbCxsM8LIiHhKJmjnDpSt9f4mw4IPVoodCDrPoumzGpuCTpPF4cq8iLxx
         WGR15HbMzOIDwO6lbFkGCfePF1dopRHXRTrU8HFkY1Y/EHT6dMEfevPmAEr2rVK+KWZ1
         ZxPQ==
X-Gm-Message-State: AOAM533hdkWh+PoWl93xBLxwdlAHpjGCTLiuCtQR6EXNhIrODVey1Elo
	jiomJfCpttnIwS3g9B9k2yLUZw==
X-Google-Smtp-Source: ABdhPJzUaVxe4SfxRglUjpUpHDSkPsPRNQ0WQtkHaW5ByKNxXZEQk7Qu1xwKNzuES23Xez4dtT1gJQ==
X-Received: by 2002:a17:906:cc87:: with SMTP id oq7mr25233389ejb.193.1624898747596;
        Mon, 28 Jun 2021 09:45:47 -0700 (PDT)
Received: from tsr-lap-08.nix.tessares.net ([2a02:578:85b0:e00:9e05:d9d8:5ebb:93ff])
        by smtp.gmail.com with ESMTPSA id hx18sm7072522ejc.82.2021.06.28.09.45.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Jun 2021 09:45:47 -0700 (PDT)
To: Geliang Tang <geliangtang@gmail.com>, Jianguo Wu <wujianguo106@163.com>
Cc: mptcp@lists.linux.dev, Paolo Abeni <pabeni@redhat.com>,
 Mat Martineau <mathew.j.martineau@linux.intel.com>
References: <1624698998-9029-1-git-send-email-wujianguo106@163.com>
 <1624698998-9029-5-git-send-email-wujianguo106@163.com>
 <CA+WQbwuJ64zQcCnOAwqw9_Mxud6BRJu300sP4pWFOeU7FH8nEA@mail.gmail.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: Re: [PATCH mptcp-net v8 4/5] mptcp: avoid processing packet if a
 subflow reset
Message-ID: <02fdfd28-812d-0242-e354-9cd629288bcd@tessares.net>
Date: Mon, 28 Jun 2021 18:45:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CA+WQbwuJ64zQcCnOAwqw9_Mxud6BRJu300sP4pWFOeU7FH8nEA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit

Hi Jianguo, Geliang,

On 28/06/2021 10:35, Geliang Tang wrote:
> Thank you for this new patch set!
> 
> There are three checkpatch.pl warnings in this patch set, please fix them.
> And a minor comment below.

As pointed out by Paolo on IRC, these modifications are required but
they are minor. Because it is already your v8 and your first major
series, we did these small modifications for you ;)

Note that we didn't change the "goto" just to return "true".
Also, I didn't add any Acked-by or RvB tags because none were given but
I can easily add them later if I get any but I guess Mat will send these
patches later to netdev with his SoB.

- 6bb69e9b2123: mptcp: fix warning in __skb_flow_dissect() when do syn
cookie for subflow join

- ee4bcc0a7a64: mptcp: remove redundant req destruct in subflow_check_req()

- f0056198a479: mptcp: fix syncookie process if mptcp can not_accept new
subflow

- b65e3f889d44: mptcp: avoid processing packet if a subflow reset

- fc66a740c7c7: selftests: mptcp: fix case multiple subflows limited by
server

- Results: 31aa314277b1..60851d13158d

Builds and tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20210628T164431
https://github.com/multipath-tcp/mptcp_net-next/actions/workflows/build-validation.yml?query=branch:export/20210628T164431

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
