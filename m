Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D6D41C30
	for <mptcp@lists.linux.dev>; Wed,  5 Jul 2023 08:04:55 +0000 (UTC)
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-51de841a727so6833802a12.3
        for <mptcp@lists.linux.dev>; Wed, 05 Jul 2023 01:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1688544294; x=1691136294;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xpBAXE/P4dL0Oy2Wx3VC55SQVM2xI9plGM6gEZENvIk=;
        b=ENxU7ZRv+tS1ibpf/huZTk1jgIJJ+or/vQCelqX8l7zFl69BYiVXLKW/Qo9KuS2FoB
         WASdJbbzYi4rWBpoYX1Caj1SbKR0ZkaRONrjN7/3ph/qIqBxJcr9lsn2zvhy7D6HmJjH
         uyoD1jNQChEkqEz95Sg9FQHRZGSgR7SJjkJ2baFiOMhY+AGzBk+afU3y2DQ8MS+uhiXv
         pJS+Fc426npW/zujL/FaF2TtnfdNyxO552IT6cvRhUL3bh18LilHlURt2acmakMC6Co5
         gwXi2R8c033Xn2tYBkRNwEeHkFydAlmrB/M1R8UdQ4DK+eDgAz8ohigVCSKtTQouhcTE
         Wa9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688544294; x=1691136294;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xpBAXE/P4dL0Oy2Wx3VC55SQVM2xI9plGM6gEZENvIk=;
        b=SgPRGtxHlb5uFoUC8QRBz4RZZer0G9ezM9R3DpMf7W3HJCSTCiRV/5gz5WdWJSRAPC
         hElQtriQc/T8wjCQe3nm6GuxxNpyx7GJN182g0l5QivgpAm5jq5nOF++w11XhoDBIOU5
         aebWXSifQqyUKcO+vsbhs1PGyNpcuNrGlqowt/V1IfnIieBjMIGkK1IK4NmhMOzh6Sne
         Fu+46HRCbu6tApPxZPJN5dkKtAddR45NMG7ukINpKH5j6fB6Gih6EQVP8hoQU14AQteg
         9UJGdXRvge296W09+0zsnSWFi1wEiCfras+CQ4Du2I5n/xF/hws4OIP1/U+78c+vjao/
         Sfzw==
X-Gm-Message-State: ABy/qLa8icXysPSnKe6Crc8cCrs6zRXUhQDMhm8H+kjFAwkO0ruD3POe
	9O4tb4JeWnoDXEzWMx6w3jwFnl9kuX+svw85exaB4A==
X-Google-Smtp-Source: APBJJlF70v45Gye2X4paLvvKxCQ0RfsKowwQ1XZpM0MpCOkxBDHGt6SKFC5XVlv2sRk1XimstGWK8g==
X-Received: by 2002:a17:907:119a:b0:992:630f:98b6 with SMTP id uz26-20020a170907119a00b00992630f98b6mr10579646ejb.37.1688544294104;
        Wed, 05 Jul 2023 01:04:54 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:e210:4cad:4e78:3692? ([2a02:578:8593:1200:e210:4cad:4e78:3692])
        by smtp.gmail.com with ESMTPSA id c17-20020a170906529100b009930c61dc0esm6150210ejm.92.2023.07.05.01.04.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jul 2023 01:04:53 -0700 (PDT)
Message-ID: <13ecb494-5cb8-ed52-8ef8-4f4038bd65fd@tessares.net>
Date: Wed, 5 Jul 2023 10:04:53 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH mptcp-next v4 6/7] Squash to "selftests/bpf: add two mptcp
 netns helpers"
Content-Language: en-GB
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
References: <cover.1688540074.git.geliang.tang@suse.com>
 <46dcc7443cf6f73bb777e40e5c93dea803c9e48e.1688540074.git.geliang.tang@suse.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <46dcc7443cf6f73bb777e40e5c93dea803c9e48e.1688540074.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 05/07/2023 08:56, Geliang Tang wrote:
> Move the helpers to the beginning.

I can already apply this patch, it will be easier for you later I guess.

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
