Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21BBD18D
	for <mptcp@lists.linux.dev>; Wed,  3 Aug 2022 16:31:34 +0000 (UTC)
Received: by mail-ej1-f46.google.com with SMTP id c24so1650076ejd.11
        for <mptcp@lists.linux.dev>; Wed, 03 Aug 2022 09:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=JvTUEgxu3LtwkI0TnpQkqvLy+9CzfL/Hd5+ZyExTZxI=;
        b=UUUyc3lGNU/EGVcI46JZQ67Y6N3JSvFGVHZ/HeCyanIZa5VMi5WzA8yoACVDrDkMZd
         8PZROqNx1AFspi2uvYmHHRdxOpbhffyYP7RoAqv6r1habea70Mo9iDSt1REMiEtyKVr2
         ilXDiwXFBX3HuUpJou/7LvzfLM/aCs4/qjJzE6whgFcgEQubXPMZNj28LGSehsusNmCV
         k0VVLwwjBKdtoMGNH9W8+E2qBR6Ys4KfESHRlpxjV1bUGibqQI+/kAERzDW1lCMHvSWE
         FueGRk+j7ia21rAcA2NFzRfLk7v61la6zUtEXwUf1YCDuQcKYBKF3+8J6WBTYuYzrFfN
         nHZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=JvTUEgxu3LtwkI0TnpQkqvLy+9CzfL/Hd5+ZyExTZxI=;
        b=SV+RbhZxwC1lPmNYq75j4gH8dY+uxCLcWK/qt987M8BRpiLX1NdKntsETjpfk9VulZ
         zAHfiQzllnYeJ6eZdX6yxSmGymjCeTvLreHRWdvLzzU32A1vFjliOebpJZE0bRRBMTp+
         Je8+9qcV6h0Cg+8PfE8Wd4Z5XBR5gb1xFzq2Ms3SlGQLGtLj4mdXIeG8N5cVtTNo8FZH
         /zhtmTLuCs0QONUQKwHHo5NK5FDn/Td80siweAG35Fj39pxm5JKmrzfT5Ds2WpSwWG6m
         bAUTxnLQulZYg1fWtddeXlkxXLMrBjWbBb7toEkkRiWwkcOAfVlwkiqmi7B+/np3eUaa
         7Q7A==
X-Gm-Message-State: AJIora9nRZdb8DCB06kLetCjWfrxD+ANajY0ggxR0wjTrX3f0hBVsv37
	wJ36Z7VkMdw3N6JF/l9Yb5tCYw==
X-Google-Smtp-Source: AGRyM1sIUDH8DKLvEI9OCQmUtZbgwJz0G7gyTjNa4BF/nbW51mtGstJt+n0OtidDMOfuuxIoAefAvQ==
X-Received: by 2002:a17:906:8cb0:b0:72f:6ce7:3a1 with SMTP id qr48-20020a1709068cb000b0072f6ce703a1mr20292075ejc.322.1659544292857;
        Wed, 03 Aug 2022 09:31:32 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:aec0:3f15:459e:231a? ([2a02:578:8593:1200:aec0:3f15:459e:231a])
        by smtp.gmail.com with ESMTPSA id kz25-20020a17090777d900b0073085243f3fsm3474095ejc.64.2022.08.03.09.31.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Aug 2022 09:31:32 -0700 (PDT)
Message-ID: <902b74e0-6053-9570-61df-f27ff1895961@tessares.net>
Date: Wed, 3 Aug 2022 18:31:31 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.0.3
Subject: Re: [PATCHv2 bpf-next] mptcp: Add struct mptcp_sock definition when
 CONFIG_MPTCP is disabled
Content-Language: en-GB
To: Jiri Olsa <jolsa@kernel.org>
Cc: mptcp@lists.linux.dev
References: <20220802163324.1873044-1-jolsa@kernel.org>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <20220802163324.1873044-1-jolsa@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Jiri, Mat,

(MPTCP ML only)

On 02/08/2022 18:33, Jiri Olsa wrote:
> The btf_sock_ids array needs struct mptcp_sock BTF ID for
> the bpf_skc_to_mptcp_sock helper.
> 
> When CONFIG_MPTCP is disabled, the 'struct mptcp_sock' is not
> defined and resolve_btfids will complain with:
> 
>   BTFIDS  vmlinux
> WARN: resolve_btfids: unresolved symbol mptcp_sock
> 
> Adding empty difinition for struct mptcp_sock when CONFIG_MPTCP
> is disabled.

Thank you for the patch and the review!

FYI, I just applied this patch in MPTCP tree (feat. for other trees)
just to track it and prevent conflicts on our side with the future
bpf-next/net-next.


New patches for t/upstream:
- fa5c3bcfae6e: mptcp: Add struct mptcp_sock definition when
CONFIG_MPTCP is disabled
- Results: 982ba3087aac..ba0f79895fde (export)


Tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20220803T162341


Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
