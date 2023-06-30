Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C39011FB8
	for <mptcp@lists.linux.dev>; Fri, 30 Jun 2023 09:24:45 +0000 (UTC)
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-51d9890f368so1785736a12.2
        for <mptcp@lists.linux.dev>; Fri, 30 Jun 2023 02:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1688117083; x=1690709083;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=X15+5kgPHp0lkBfz7qMXE5Aheh7QBhUWd/SqO44qOcE=;
        b=5DoAsdHBlCXiV9I1R0jO5KEsU62KPqyVlzKRHGZMV7/Mn94SPA+idhMi/6Gi3WMthz
         X3uZCM+29nHzbloKLeS7e9gneoxlcVdkmghbLsPBC4OsHcjz+rK+CG5YEsOktkx7SYqr
         uoNh9JCdowyX7NnbvDIia7+hsFG+uz0s66L30dentzugPntgQXXP0Z9vlmoBCd6Hdmd2
         Lh0u7NQOoxigodANPWysVOFv5hxN0BU3K/fKxLUMgu/UtzE9s4w5aHhwTYJF2n2ek945
         wJI42crUk4yIXSWxhWUPGs16fwnj5/v/m8+8Q0qp0n04sp0hdXRusMDqMmO1J6R+tHN4
         u74w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688117083; x=1690709083;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X15+5kgPHp0lkBfz7qMXE5Aheh7QBhUWd/SqO44qOcE=;
        b=Re8cIeHfmCNdggYYOVp3sFfHlQ4paET74SME52TI3S9kZLhJh5Vgyo1UlUWUhcKp8z
         hbh9srSJe+GJWYibMXN0kUHPm8D4hE8Rkmz7HZYgzZBtZ5j4VqhQi2bSD42ShB84wFFS
         A0g/Rz9Vk+OGqTRPRSjaf7HG4R+4X5mxUaKQM0V0s//L3QiHYANu6XtUIi8RzOUO/39c
         T6sda65c1LOP5Cp3SywF1c2qp0XougFV5jaVyfIewD8qctrPgSXF4ZrjfECmtrsVDGs0
         SXRHyGm0yN23BNBX/lSMSu7+nYYh+9lJ7ZDpQHf5QwjPKs8Z8OUUg1nmCdesIVURczf6
         odwg==
X-Gm-Message-State: ABy/qLbVKHxM5rESz0CERRbXKluvXb5NICCfxGFdpp+EwSiFcJbqvcrf
	VgO2pScEN1ekl3k6e+o2/3zDd+VYTg7wFMoIqg7wcPcY
X-Google-Smtp-Source: APBJJlHqEailZHdmTUArFdsp05aAvpUUe9CIsnzHClup3rOe+XpG4pgDcnuW1tganT9OoA4YZT4MSw==
X-Received: by 2002:aa7:d04d:0:b0:51d:91ef:c836 with SMTP id n13-20020aa7d04d000000b0051d91efc836mr1149258edo.32.1688117083577;
        Fri, 30 Jun 2023 02:24:43 -0700 (PDT)
Received: from [10.44.2.5] ([81.246.10.41])
        by smtp.gmail.com with ESMTPSA id f4-20020a056402004400b0051d9de03516sm4431953edu.52.2023.06.30.02.24.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Jun 2023 02:24:43 -0700 (PDT)
Message-ID: <484eecec-bd6c-e3cc-0519-5e66d1d609f8@tessares.net>
Date: Fri, 30 Jun 2023 11:24:42 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH mptcp-next v2 0/4] update userspace pm mptcp_info fields
 part 3
Content-Language: en-GB
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
References: <cover.1688092826.git.geliang.tang@suse.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <cover.1688092826.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 30/06/2023 04:42, Geliang Tang wrote:
> v2:
>  - set all env vars as local ones as Matt suggested.
>  - update the commit logs.
> 
> v1:
> - add three new env vars
> - Patch 10 "selftests: mptcp: set endpoint out of transfer" of part 2
>  v20 is dropped.
> 
> Geliang Tang (4):
>   selftests: mptcp: set all env vars as local ones
>   selftests: mptcp: add fastclose env var
>   selftests: mptcp: add fullmesh env var
>   selftests: mptcp: add speed env var

Thank you for the patches!

Now in our tree (feat. for net-next) with the modification I suggested,
see below:

New patches for t/upstream:
- b7165f898f6a: selftests: mptcp: set all env vars as local ones
- 9e29d1329e0c: selftests: mptcp: add fastclose env var
- ee74b5fd49ee: selftests: mptcp: add fullmesh env var
- 9b7ce494fb4e: selftests: mptcp: add speed env var

- f2fafad6ed72: Squash to "selftests: mptcp: set all env vars as local ones"
- 092b9bcfc8a3: conflict in t/selftests-mptcp-add-fastclose-env-var
- 10c23ed7ed13: conflict in t/selftests-mptcp-add-fullmesh-env-var
- d78d7b90ed35: conflict in t/selftests-mptcp-add-speed-env-var
- Results: 89daa1420390..d7082226044f (export)

Tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20230630T092326

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
