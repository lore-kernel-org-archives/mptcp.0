Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51EAB568B
	for <mptcp@lists.linux.dev>; Wed, 12 Apr 2023 14:03:47 +0000 (UTC)
Received: by mail-wm1-f41.google.com with SMTP id i8-20020a05600c354800b003ee93d2c914so7887344wmq.2
        for <mptcp@lists.linux.dev>; Wed, 12 Apr 2023 07:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1681308226;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/0wwyuud4qHS0hRc7o6eTAN79ukeFWmG3O1CPHKGrxo=;
        b=EHNqDsJ9BojkvsQus3FpqyEhcBilkfalGnnZHa9AX9IyeyqTLv8q4bx6mtG+gZgApV
         J8VYL6OG5a8bZFTF4ssMy7t9g/SFe/GGh93OM607TIlTSCz/UZevYC/UvgpcAjVo7slx
         7lX7NpnXNwv2GZGSiqYRYiz5Kc4oiEyGaG1TWykaXf3Wtrcwsx/BLOPaOQfKtgkCZH5F
         NVrUFmeaLyGsw1dsAyW4hedWepjYzek+sanlIzPMU7h3XX79skaHHsidhTDhZ9A7Qunw
         QWbIuhzRmzkY09fdEj2qc4vNerp/BtPCY5Tp0tVqwC/1iD2K4sQ9WrPhhXGIGiWUz7eJ
         CeFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681308226;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/0wwyuud4qHS0hRc7o6eTAN79ukeFWmG3O1CPHKGrxo=;
        b=db1Bb87LmEliYgtgAtdvAns52l/grAXF4Zunh8k28C8FnymeCQe57NNJvxSTtgK7VZ
         uDk42KMtnYWDcvXwBOTeuwu4yVw/fz+PBAiUD2DALs8X5E4AjSHCoNPGKV+W4dHkKb2R
         rDTgyr1/ZqQc+pFVPA/Nz4aU46sNMJZqzxAaA0Bc20OVK0OpUFT/vZNNq4YKZ2IH85cj
         I+43YBpxwm5DNuvWrH65qZgmJrczlgosC/JjAq4c49yoAB47as0yLTphwmKH566ZnvoG
         rb4dNWZzByqV6GoXqWXd4JrMAgKM8I+XKFDjG+SlyMSKy/HYY5SBvKI12WIfx4QGdDLA
         TS0A==
X-Gm-Message-State: AAQBX9fMlK8hrCyCZ5T5e7xeDBfZDYdD9iSCivWxAQO3rCLzmwe/Adb0
	qYjZfwBeuz83NNf2B/YIxhJBOOcWUQP5a1iArCNkeW1n
X-Google-Smtp-Source: AKy350bEXCtyi6vc2Ai+8n6ctkhzIeSmm2U3vbUtevVjPBNE8mSnAZ5bVMeI1igWcNBQG1P6gs2YJw==
X-Received: by 2002:a05:600c:21c9:b0:3f0:3d47:2cbe with SMTP id x9-20020a05600c21c900b003f03d472cbemr4836056wmj.10.1681308226198;
        Wed, 12 Apr 2023 07:03:46 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:4382:4a00:b3c9:ac57? ([2a02:578:8593:1200:4382:4a00:b3c9:ac57])
        by smtp.gmail.com with ESMTPSA id p23-20020a1c7417000000b003f0824e8c92sm2504149wmc.7.2023.04.12.07.03.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Apr 2023 07:03:45 -0700 (PDT)
Message-ID: <1d7650cc-7b97-699a-aac0-7075cc209454@tessares.net>
Date: Wed, 12 Apr 2023 16:03:45 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 mptcp-net] Squash-to: "mptcp: fix accept vs worker
 race"
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
Cc: Christoph Paasch <cpaasch@apple.com>
References: <835d24d74d7381f79e994b20d84002ec1b953da8.1681306366.git.pabeni@redhat.com>
Content-Language: en-GB
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <835d24d74d7381f79e994b20d84002ec1b953da8.1681306366.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo,

On 12/04/2023 15:45, Paolo Abeni wrote:
> The current patch has at least 2 issues:
> - the first subflow context cleanup can race with
>   the path manager: we should acquire the full ssk socket.
> - such subflow can accept data while the msk is closed, leading
>   to fwd memory corruption.
> 
> Address the issues moving the ssk cleanup into plain mptcp_close_ssk
> and detaching the ssk from the msk before closing the latter: no
> input data can land to the msk at that point.

Thank you for the new version!

> v1 -> v2:
> - fix memory leak for unaccepted MPC sockets (previous version lacked
>   a sock_put()

Good catch, I see the modification.

New patches for t/upstream-net and t/upstream:
- 0e8001f374ec: Revert "Squash-to: "mptcp: fix accept vs worker race""
- 30fc4dff89a7: Revert "mptcp: reduce scope of ssk"
- e6b49563f4b4: "squashed" in "mptcp: fix accept vs worker race"
- 8a56bac92a70: Revert "Revert "mptcp: reduce scope of ssk""
- Results: 497462bd7901..a234873f266c (export-net)
- Results: 5edc47a5f768..263b6c28fab6 (export)

Tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export-net/20230412T140112
https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20230412T140112

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
