Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7272EAD6
	for <mptcp@lists.linux.dev>; Thu, 13 Jul 2023 08:50:41 +0000 (UTC)
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-3fb4146e8ceso3700855e9.0
        for <mptcp@lists.linux.dev>; Thu, 13 Jul 2023 01:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1689238239; x=1691830239;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QR2XDlfdQ0A7dI6yUdHeBU1mBpj8fLMW/ZD7jJIRQbY=;
        b=5jRBEQ9evlgxPA3nrd/XusQUAACeldeJr0XiOsaZveZfklcEciwbBE+p6c//H5RxxS
         SRsy2vF9gL+pKj+0+EjCieZupCYHrIAkR1DLw5e/VGavzmbFh5s70urIdzfLcI+KU1Un
         ZioJJlBJTrUrT5TcGqIKiuUqbGytv/pgnV+sPldvfFowV1/3vCDDgRgGm5/0qe9hDi3J
         4VAw07TpUQftZSw+HmJxPbDLF0tXN7MijcSAip6Z2/1wXtgwe1zlAaazidP1QdUO4CUD
         0GPX1SFbEJkF3aOTRAmp1UNLTlHtTgjP++8GfqPcaeYRSVHuxgxKGEKOcpCAT87xXVLo
         8MKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689238239; x=1691830239;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QR2XDlfdQ0A7dI6yUdHeBU1mBpj8fLMW/ZD7jJIRQbY=;
        b=Enb8VD47DzgR87jk8OOhiOekSEpvKWjgJDfohJ7WT10DyjFHzPHDqqoSd9kD7t7KNQ
         UackPUV8G1DcCUrH+UK96V+vX4FTMw/H9kgNwC4iK7cOUDINfGLlwy99Dfxu9kJ2vHjU
         x8nRDF1JGPvaLSLPmDgbzVi/TwwFeuVvf5D+ckGAXnsFITh7faJ0f+cxpXltZV2kUXy1
         9RIkzq56hv1SDd+TgfS7JjoGYzJuAgwCPZv/Ezom2WRQ/6UjvPTeQpTanPHTag6XOw6J
         V5oyJpDQdK/M6ogx6pIFW1O00/p+pRSzQN5L1bHTgUUNurcaqQYN8Ialu4ny4M9xhG7j
         ++2Q==
X-Gm-Message-State: ABy/qLaoiU9cC7+6t4pgeLpDDeYPhA4Bpy8Gi+dPKWg/Tt2pZ7j77gpj
	48AxRuLEARxpgi10Akf/c11IXsArMsava2/H0O3g4qCA
X-Google-Smtp-Source: APBJJlFIjbWS28x5C1721My6tm+cVFtzylmR+iTfV+G2PsfPpQqW+88wrFXvawmLnmSF58+t/gXdFg==
X-Received: by 2002:a05:6000:1c6:b0:314:10d8:b491 with SMTP id t6-20020a05600001c600b0031410d8b491mr853059wrx.67.1689238239636;
        Thu, 13 Jul 2023 01:50:39 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:c2e6:680:ced7:5e59? ([2a02:578:8593:1200:c2e6:680:ced7:5e59])
        by smtp.gmail.com with ESMTPSA id o4-20020a5d4084000000b003142c85fbcdsm7423932wrp.11.2023.07.13.01.50.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jul 2023 01:50:39 -0700 (PDT)
Message-ID: <6c26f1f0-2dbe-52e1-861f-f8eae33586f2@tessares.net>
Date: Thu, 13 Jul 2023 10:50:38 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH mptcp-next v11 03/11] Squash to "mptcp: add
 sched_data_set_contexts helper"
Content-Language: en-GB
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
References: <cover.1687827857.git.geliang.tang@suse.com>
 <5694986e33e230afaa68c83c9e9fd64f7a551da1.1687827857.git.geliang.tang@suse.com>
 <20230713071519.GA19684@localhost.localdomain>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <20230713071519.GA19684@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 13/07/2023 09:15, Geliang Tang wrote:
> On Tue, Jun 27, 2023 at 09:06:46AM +0800, Geliang Tang wrote:
>> mptcp: add sched_data helpers
>>
>> Add a new helper mptcp_sched_data_set_contexts() to set the subflow
>> pointers array in struct mptcp_sched_data. Add a new helper
>> mptcp_subflow_ctx_by_pos() to get the given pos subflow from the
>> contexts array in struct mptcp_sched_data. They will be invoked by
>> the BPF schedulers to export the subflow pointers to the BPF contexts.
> 
> Hi Matt,
> 
> You forgot to help me update the subject and commit log :)

Oops, I didn't see you were asking me to change the commit message.
Thank you for your message, now fixed:

New patches for t/upstream:
- 4194305e86f7: tg:msg: apply new commit message from Geliang
- Results: 2e4f8c818fa1..3ee02a7d38ae (export)

Tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20230713T084941

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
