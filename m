Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 166F3625
	for <mptcp@lists.linux.dev>; Tue, 26 Apr 2022 10:22:18 +0000 (UTC)
Received: by mail-ej1-f49.google.com with SMTP id r13so35089981ejd.5
        for <mptcp@lists.linux.dev>; Tue, 26 Apr 2022 03:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=iAWq6bFgAxiVwsJoKkHNMSwiY6nZ34TsIhxowp661zk=;
        b=eExgsubuOo7f5bl7tAga4n8wIb5nobi/RpL4wLPWu+x3FoqbXImQwdvBqkHLPNAE50
         tms/afqXsdUQLkj0kPCahRqH+ceyMpYoqbSNZeurmVFV1ViniQ9zE8pHqo3hFsrc6crO
         OTpm7b4PBGSFTt/ENH4loMi9ELPqkyJ0iW/8BqEWVHreB1/DLNkJCTHkGbsmD+3NaKFA
         30hPmHWpISCLJPYvbJzl/M0xzl66CewKaPlo529icK7fcQcYGHhMDgQRnnJ8XtBjpoa/
         9pIRebG+m5wDMP2+iQsvfp/GUazm8fO7gb3UcrzthbIn1QFRE9sudezLZbEof/mryO8d
         lKtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=iAWq6bFgAxiVwsJoKkHNMSwiY6nZ34TsIhxowp661zk=;
        b=POd+lPBQDpElaV5dBR+FUCl3IlZmsV3cm67JSoLnig3nv5alzY+dtk+zkBhMqCnbJx
         BWGAWflOFBoCGGLmpcnowC+DcpG9HJrnu5GETbFvlvAgyIdTTNMvR0XkLX6epLq3xfXa
         oHaycbfAoR55pQuuGQ04q39b0rdeNIq1ALFTfgbbtDJ2NGbu3X+8WMZYC1YU3qMQWPPY
         VLLb0FmaTT2T+v9j94x5eghLjqECJa+MucnCpv95ku4Siyq8JE86lr8RSixWSvIXoguE
         E8W3V8AStw3MrjeTEHjT9/RVOkGCt+pTukomPMgtMM10dLC721GGeKVsTo+7cdichbN9
         O8aA==
X-Gm-Message-State: AOAM5322SvzrGLoQcaE8BMQHMgklIwGEw4X8to5kc3PueLOJcBFtdT9V
	VYHA4J5G1Kz6nqWBf0PqvcHGTg==
X-Google-Smtp-Source: ABdhPJwC47dZH2xx+Tce8uIjGRXOq+2Njj+CQWn1CBY/sdI0RZlSP6oQaL0R74kGhtS9fWffsWXDpA==
X-Received: by 2002:a17:907:7d94:b0:6f3:b160:9fb7 with SMTP id oz20-20020a1709077d9400b006f3b1609fb7mr2198039ejc.410.1650968536964;
        Tue, 26 Apr 2022 03:22:16 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:20e3:b4e6:37ad:5b92? ([2a02:578:8593:1200:20e3:b4e6:37ad:5b92])
        by smtp.gmail.com with ESMTPSA id jo11-20020a170906f6cb00b006f3955761c4sm2201645ejb.158.2022.04.26.03.22.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Apr 2022 03:22:16 -0700 (PDT)
Message-ID: <83c27c3b-4bbe-d68f-e066-4dad57b3143c@tessares.net>
Date: Tue, 26 Apr 2022 12:22:15 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH mptcp-next] selftests/bpf: Drop duplicate max/min
 definitions
Content-Language: en-GB
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
Cc: Daniel Borkmann <daniel@iogearbox.net>, Song Liu <songliubraving@fb.com>
References: <93623928052528277b9a67f19a1a102518c538bb.1650967584.git.geliang.tang@suse.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <93623928052528277b9a67f19a1a102518c538bb.1650967584.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

@Daniel, @Song: please ignore this message, sorry for that.

@Geliang: I think you accidentally let 'git send-email' adding in cc
people mentioned in the commit message. Don't worry, you are not the
first one and you will not be the last one :)


On 26/04/2022 12:09, Geliang Tang wrote:
> Drop duplicate macros min() and MAX() definitions in prog_tests and use
> MIN() or MAX() in sys/param.h instead.
> 
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> Acked-by: Song Liu <songliubraving@fb.com>
> Link: https://lore.kernel.org/bpf/1ae276da9925c2de59b5bdc93b693b4c243e692e.1649462033.git.geliang.tang@suse.com
> ---
> This patch was applied on bpf-next. It needs to merge to mptcp_net-next
> too. Since the commit "selftests: bpf: add bpf_first test" will depend
> on this patch.

Thank you, I'm going to add it in our tree.

You can also send me an email on the ML with a link to a message in lore
or a sha in a Git repo. It might be easier and less "risky" ;-)

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
