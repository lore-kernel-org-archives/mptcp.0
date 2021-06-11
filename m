Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C691C72
	for <mptcp@lists.linux.dev>; Fri, 11 Jun 2021 14:45:31 +0000 (UTC)
Received: by mail-ej1-f46.google.com with SMTP id ci15so4914399ejc.10
        for <mptcp@lists.linux.dev>; Fri, 11 Jun 2021 07:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=l7MORHksJQSUhf1VDh+ln5JDqM5fK5k8bJr7yCln2fQ=;
        b=Wr41KuWE/7SkdnDpqFJzQqMh9RYQEGFMVd9AkMy1npL3vY0DwiQXj8rmTDSCLShy2d
         LHG4qOgZgPSG1G6TiLo2TI58UrmZsku8mG38dHcm9Cuwi5YvSMFyWyr++BShEi1utdTh
         +fD0nrASjuNiYqt0emJEf2b5JmVzMTfAMoIuVXOr0/MsvwZ8hAwAL70j8+WltlK6Pzpx
         Hm7NRBseTMwBtxHdh45CgKQXgW+iFr4jr+E5qW1Kapkl1u0qKCCo0pYdmBoIHiPpltfw
         7SObn9+egihex64MymoCVUKcRn3Va+1DmMxBVmx9ZUvNEWLAAq25om8UF+yqBeWlICi1
         S09A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=l7MORHksJQSUhf1VDh+ln5JDqM5fK5k8bJr7yCln2fQ=;
        b=RSuD/arBoM+Do9k3UA0PVl8jVkpKoflaKKRMPjI3Gw2AclDkntDYlM9BQD4KGTY02L
         PelVqfaaoThiuk9LEpQoVljNaQhDBhucf+AstRG2hXiJMJU4kELQqlmQPxbjP53gqELu
         OzPP+N99PSSIHU1VDko/hvtTftow49lN4jv9QavBC0J8C2xeUoC+QiC/9947aDXZ5AFs
         jwgGm0vgfCdr6e6BUpacuDUJs5l6Q0XN/VEdffIawDMw6x8gvR1oCv2ODToG/TjNwwq3
         Z+PEPGThYvacXUrmk8XGW1b6haFyA7Dk3mp9sT8H/LjCE4qo2ZWw3QAn8uckbRMFG4f5
         9UMg==
X-Gm-Message-State: AOAM532s8ydb2cOkY3racRDPb8nmYplIv1PzHUbjVSi3JAVJoHY0E6rr
	HT07+ANdiyhJV/IR/fEXgdTKHa+0/a072jjppAI=
X-Google-Smtp-Source: ABdhPJxSlURQxWDMYcX2NLdo/FMes9b4+Td47yxmHrqfm68ly4/lUKaQY8ptXP0bnGZOH3EcvX2CGw==
X-Received: by 2002:a17:906:3a04:: with SMTP id z4mr3973034eje.221.1623422729962;
        Fri, 11 Jun 2021 07:45:29 -0700 (PDT)
Received: from tsr-lap-08.nix.tessares.net ([2a02:578:85b0:e00:26d4:4bdb:59fd:ed42])
        by smtp.gmail.com with ESMTPSA id i26sm2624355edq.54.2021.06.11.07.45.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Jun 2021 07:45:29 -0700 (PDT)
Subject: Re: [PATCH v2] selftests: mptcp: turn rp_filter off on each NIC
To: Yonglong Li <liyonglong@chinatelecom.cn>, mptcp@lists.linux.dev
Cc: pabeni@redhat.com, mathew.j.martineau@linux.intel.com,
 geliangtang@gmail.com
References: <1623288316-2771-1-git-send-email-liyonglong@chinatelecom.cn>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Message-ID: <2e2c5451-db09-9b81-20a0-7b4817eb5d02@tessares.net>
Date: Fri, 11 Jun 2021 16:45:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <1623288316-2771-1-git-send-email-liyonglong@chinatelecom.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit

Hi Yonglong, Mat,

On 10/06/2021 03:25, Yonglong Li wrote:
> To turn rp_filter off we should:
> echo 0 > /proc/sys/net/ipv4/conf/default/rp_filter
>  and
> echo 0 > /proc/sys/net/ipv4/conf/all/rp_filter
> before NIC created.
> 
> Signed-off-by: Yonglong Li <liyonglong@chinatelecom.cn>

Thank you for the patch and the review!

- 48aa051e5c6b: selftests: mptcp: turn rp_filter off on each NIC
- Results: 4e92195bd477..ea78893dca6c

Builds and tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20210611T144454
https://github.com/multipath-tcp/mptcp_net-next/actions/workflows/build-validation.yml?query=branch:export/20210611T144454

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
