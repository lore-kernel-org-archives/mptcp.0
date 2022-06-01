Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0BF42562
	for <mptcp@lists.linux.dev>; Wed,  1 Jun 2022 15:04:27 +0000 (UTC)
Received: by mail-ed1-f44.google.com with SMTP id x62so2580153ede.10
        for <mptcp@lists.linux.dev>; Wed, 01 Jun 2022 08:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:cc:from:in-reply-to:content-transfer-encoding;
        bh=mDt8VyRhOTkbEbvkqKJu0pPTg6jhmIp+WhDQUVhbOLk=;
        b=th3g+EslkRaQJArIvyOCseC6Etw1eWSRfRfagSyn2y80/DKKfYCnPkW2MmVzNpREHE
         ck+6Hk1MhI5peQJE+KRNkG7uMWdgmWuYWWa1kMztW5dmvefz7aEwQxmt6f/zXSa2tbBM
         lTI6n6EAauoyxL10OFa86aHjHiYdQ1nV6EPIEWV7eweodZpY/mvCK9EnFgTKReE9HCfs
         ziSb/wXx617isoUZzYmjKgzLN4LauQf5ZaVpVpnb5xwRx0PsCBR/JOs0GB7NOLOQIuNr
         Wsxsxqwi3Pf7PBHtH9t2Pto+UrSmccpaVGq+2P37eL+Km5yEZ0cMKdhG9/ta5PYRkbfn
         ZlEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:cc:from:in-reply-to
         :content-transfer-encoding;
        bh=mDt8VyRhOTkbEbvkqKJu0pPTg6jhmIp+WhDQUVhbOLk=;
        b=YbT5fe3hKRiulPwgPS9sVCKzkX8PVNnoRYxrSFFRX4RzU9NPM1X7b5PaA7goslRM+R
         gvg0+vBQTwugPJlIrkV4McInEpQI5x5H1sIyPjMlANFNoYt4bp3fLKE0B/eAazn9dGvs
         n89AxuJe4QMdre3T1ACC8+d4noCpy8QfltqJix8bO+Aap+1XKN/07cWpVGpKqfxXmPgK
         Ux/a/ySmbEpzj4AxCtsKgZPHoRYBO1jdjUCPcveLSv29S09aLjBGinzgM2zxj4ZcEB/3
         T8A9o1mUrvjniZlOsXrHDg7FyDQ6wxK7gN2s4LbKkxc1Ss4KiHgLWRu6nrgaT9j14wOq
         zp/A==
X-Gm-Message-State: AOAM533VBvvo5xrUfAnvgTUFdpaEGE/bh4Zq+j6BonF80OVD1c9p/2BS
	5XKNNA+YwUul2D9VkSoRdhlzQL/Id/mZzg==
X-Google-Smtp-Source: ABdhPJyUrw0d4o5WdTJA/5yK3n4pIWK5CiB0M0de8h23iB7zFGggC4YgEwP8lLTRm6rnqECWjR2SQQ==
X-Received: by 2002:a50:ed12:0:b0:42d:d1d3:493c with SMTP id j18-20020a50ed12000000b0042dd1d3493cmr147512eds.174.1654095865400;
        Wed, 01 Jun 2022 08:04:25 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:5a6a:8d5b:5988:be90? ([2a02:578:8593:1200:5a6a:8d5b:5988:be90])
        by smtp.gmail.com with ESMTPSA id q24-20020aa7d458000000b0042aad9edc9bsm1091237edr.71.2022.06.01.08.04.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jun 2022 08:04:24 -0700 (PDT)
Message-ID: <0e945e4c-212f-bf6f-04ce-50d32bb6e330@tessares.net>
Date: Wed, 1 Jun 2022 17:04:24 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: selftests/bpf: add bpf_rr test: Build Failure
Content-Language: en-GB
To: Geliang Tang <geliang.tang@suse.com>
References: <94de6d463bde36d3ad8e50324b9c40ce9ae36467.1654092153.git.geliang.tang@suse.com>
 <dbd58b00-6a0d-91fc-c739-8f8c453b0c42@gmail.com>
Cc: mptcp@lists.linux.dev
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <dbd58b00-6a0d-91fc-c739-8f8c453b0c42@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

Thank you for the new version!

On 01/06/2022 16:21, MPTCP CI wrote:
> Hi Geliang,
> 
> Thank you for your modifications, that's great!
> 
> But sadly, our CI spotted some issues with it when trying to build it.
> 
> You can find more details there:
> 
>   https://patchwork.kernel.org/project/mptcp/patch/94de6d463bde36d3ad8e50324b9c40ce9ae36467.1654092153.git.geliang.tang@suse.com/
>   https://github.com/multipath-tcp/mptcp_net-next/actions/runs/2422165357

Regarding these errors, are they normal? I mean: will they be removed
after having applied the different Squash-to patch?

I guess for these ones yes:

  net/mptcp/sched.c: In function 'mptcp_sched_data_init':
  net/mptcp/sched.c:94:6: error: 'struct mptcp_sched_data' has no member
named 'sock'
     94 |  data->sock = NULL;
        |      ^~
  (...)


But also for these ones?

  In file included from ./include/uapi/linux/posix_types.h:5,
                   from ./include/uapi/linux/types.h:14,
                   from ./include/linux/types.h:6,
                   from ./include/uapi/linux/bpf.h:11,
                   from ./include/linux/bpf.h:7,
                   from net/mptcp/bpf.c:12:
  net/mptcp/bpf.c: In function 'bpf_mptcp_sched_btf_struct_access':
  ./include/linux/stddef.h:16:32: error: 'struct mptcp_sched_data' has
no member named 'sock'
     16 | #define offsetof(TYPE, MEMBER) __builtin_offsetof(TYPE, MEMBER)
        |                                ^~~~~~~~~~~~~~~~~~
  net/mptcp/bpf.c:55:7: note: in expansion of macro 'offsetof'
     55 |  case offsetof(struct mptcp_sched_data, sock):
        |       ^~~~~~~~
  (...)


Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
