Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DBEF2CA2
	for <mptcp@lists.linux.dev>; Tue, 28 Feb 2023 11:28:45 +0000 (UTC)
Received: by mail-ed1-f42.google.com with SMTP id f13so38471700edz.6
        for <mptcp@lists.linux.dev>; Tue, 28 Feb 2023 03:28:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GBj/GGcssUIPclJb9OaTVZJj6GUgJJTT+lDCTo9rCgQ=;
        b=ev4Uj0zM8CDLMvFJ9N89gY8s6bTexBCziLfJ9y93h0GjAvOdGgRLYhyM7EWKpGSG/c
         uBBFYWpQ+ShDHjIhAMAbtmkRcPG4oU1w/LTk+Xr4H+V/ZfQfiOsJm6yk5r2BuJ15vlic
         wQiodG7MheSxV25r7YFRcY9iC1qE2jrqtB3l03dLuU8KG0QcEaJvbntY1ecSLelsUB6F
         Z7Q3nrhzvpDTr0apjMYNKcvvhwD+geZ8bmraNLTfVIY2NphLF5ntsu0sIRC+8QB7Z+nB
         fVaQ4mzqOaH5FDJQRt757SZpNXAlTZJ/iNhFbhpQbSdIJM0+QDLF5Ul/EQJq6KYRdE5h
         gOVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GBj/GGcssUIPclJb9OaTVZJj6GUgJJTT+lDCTo9rCgQ=;
        b=GNuEI18cC/HOJbrDuNzoE/lfC6+G0hUXqz2jpuHXfo1fPXQ2wk+CKyqnxe+Z3Hha25
         QUv38UEiw0V4HsrX1TYwXvXV+SMOJE7yvX0uVcasjVoSq2BVZ3V2LgXnnueYgO4UsMEJ
         mcVU4c9RAw4dvhMLIpyRhnqoxKnW+rHsEz4BEWCcXBBeoprjamziAr64Kvb27jPmE4rR
         s4AaH44PjzKic63SOK57qsGAdVU6vVGI5cryod6mC9Px7ct8F9+2+dULwATdnyLX62Dl
         M2neZ6Pj7KP7bNXEZ4IwXKWp5ZBC2dcJc+kupYt5zS3++k29EAW8qT6sOmuMwFIMbJq/
         YEBA==
X-Gm-Message-State: AO0yUKW3K0TaQtcq5r8I15v28y64ej6rxg+nt0rVIDMxN1cFdhVWOCl/
	c0YzTdU9qWfsGt0gFZkZ5/WtmWQD3gfrG3kSmo4=
X-Google-Smtp-Source: AK7set8RZDJ6WdOsfg3RtQ3zH7fB6FvZdtq4hk6RJEmyFYlX71IvTbbNpXsS2JtDUgI3CjxqD9hTNg==
X-Received: by 2002:a17:907:ca14:b0:8b0:26b6:3f2b with SMTP id uk20-20020a170907ca1400b008b026b63f2bmr2016682ejc.53.1677583722973;
        Tue, 28 Feb 2023 03:28:42 -0800 (PST)
Received: from ?IPV6:2a02:578:8593:1200:5848:64ae:8a99:312a? ([2a02:578:8593:1200:5848:64ae:8a99:312a])
        by smtp.gmail.com with ESMTPSA id r22-20020a50aad6000000b004af6a7e9131sm4223979edc.64.2023.02.28.03.28.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Feb 2023 03:28:42 -0800 (PST)
Message-ID: <a0a76c20-4fd9-476b-3e32-06f7cc2bbf1b@tessares.net>
Date: Tue, 28 Feb 2023 12:28:41 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH net 0/7] mptcp: fixes for 6.3
Content-Language: en-GB
To: mptcp@lists.linux.dev, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Menglong Dong <imagedong@tencent.com>,
 Mengen Sun <mengensun@tencent.com>, Shuah Khan <shuah@kernel.org>,
 Florian Westphal <fw@strlen.de>, Jiang Biao <benbjiang@tencent.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, stable@vger.kernel.org,
 Christoph Paasch <cpaasch@apple.com>, Geliang Tang <geliang.tang@suse.com>
References: <20230227-upstream-net-20230227-mptcp-fixes-v1-0-070e30ae4a8e@tessares.net>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <20230227-upstream-net-20230227-mptcp-fixes-v1-0-070e30ae4a8e@tessares.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hello,

On 27/02/2023 18:29, Matthieu Baerts wrote:
> Patch 1 fixes a possible deadlock in subflow_error_report() reported by
> lockdep. The report was in fact a false positive but the modification
> makes sense and silences lockdep to allow syzkaller to find real issues.
> The regression has been introduced in v5.12.
> 
> Patch 2 is a refactoring needed to be able to fix the two next issues.
> It improves the situation and can be backported up to v6.0.
> 
> Patches 3 and 4 fix UaF reported by KASAN. It fixes issues potentially
> visible since v5.7 and v5.19 but only reproducible until recently
> (v6.0). These two patches depend on patch 2/7.
> 
> Patch 5 fixes the order of the printed values: expected vs seen values.
> The regression has been introduced recently: present in Linus' tree but
> not in a tagged version yet.
> 
> Patch 6 adds missing ro_after_init flags. A previous patch added them
> for other functions but these two have been missed. This previous patch
> has been backported to stable versions (up to v5.12) so probably better
> to do the same here.
> 
> Patch 7 fixes tcp_set_state() being called twice in a row since v5.10.

I'm sorry to ask for that but is it possible not to apply these patches?

> Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
> ---
> Geliang Tang (1):
>       mptcp: add ro_after_init for tcp{,v6}_prot_override
> 
> Matthieu Baerts (2):
>       selftests: mptcp: userspace pm: fix printed values
>       mptcp: avoid setting TCP_CLOSE state twice
> 
> Paolo Abeni (4):
>       mptcp: fix possible deadlock in subflow_error_report
>       mptcp: refactor passive socket initialization
>       mptcp: use the workqueue to destroy unaccepted sockets

After 3 weeks of validation, syzkaller found an issue with this patch:

  https://github.com/multipath-tcp/mptcp_net-next/issues/366

We then need to NAK this series. We will send a v2 with a fix for that.

>       mptcp: fix UaF in listener shutdown

The other patches of the series are either not very important or are
linked to the "faulty" one: they can all wait as well.

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
