Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 755B168
	for <mptcp@lists.linux.dev>; Wed,  8 Dec 2021 13:04:33 +0000 (UTC)
Received: by mail-ed1-f46.google.com with SMTP id o20so8088380eds.10
        for <mptcp@lists.linux.dev>; Wed, 08 Dec 2021 05:04:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=tNsy9FBY5gyvfYKiPKKqPYVZM0sCqI5+eBbyfD9McEU=;
        b=Qy42ogkrz7jVSpYwCaLR4WP/2e4vvmBpinL8PZl74zm77xQ4OPqj5ffN9gLm1yVeFo
         pgVwfFKAFZulgp7Z1Lty97/6xLIP8iwUyIxE4dLQceAgmk/CoVqmTa2D8LoQXDhRDI2/
         oSyv0xSTG/pfLOa9zicbED97Sb+RyNPsTukw+4vyX2J84j0FdKlqz5Bo5aBIeBJD8pIP
         bVX62L1iRtuMsMr+d1NlluRIUMwja987OZADCUjmUIW50clP64nT6rKKj0HsAOTlVdyP
         /aj6e1r5WBC5yOtq1IqYID9GAzWH+zeWG3PfinMInGB2SP2FVRBmyh6TjWe4mjsPW3TK
         jVBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=tNsy9FBY5gyvfYKiPKKqPYVZM0sCqI5+eBbyfD9McEU=;
        b=yPh0ejw3IgWsO5BFH+DID/pZDZu/+U1y6Vzl9ge7X4GAzPWPCZk46KrHxKxBjoZJGz
         MiKhHmX4YyU1rheYjvII0ad/imozKay6NGZtx8iGzKNGfNFqg6U5E8q7Gz4GTYSUQv2I
         6Z25N8CEWyhw79SyFuqy2gQk2JK44v/L95XrAYtXUdacvQ+A7/4oZC5jQB/zFDHToGps
         DHL3ItuHlXlE8ZphFOohWh3sqMoYFHKUIYeiYQSlapmRssdMJmn1NUSPwxAlGAlu5/Rt
         SOAEJ18fkdvWVs51NriGBAVH37MLBDcyDyAh6jEmSHL3eSKGXI0n/1RE8yzHfS05A0H4
         RHsA==
X-Gm-Message-State: AOAM532vWglNBfkKHVAEyw/hF9tqtefsWBKkyPU+v7ZXXcOdfgcvl8vn
	tHgURFHfTZYf60xX9pBYbx3twA==
X-Google-Smtp-Source: ABdhPJxfJ3mGmXoub1K25PNEY/F2tNrnbydzpHg8jUsJUqB/+jT6AWXWwvm5ylTjj7PaOj4kNKIqlA==
X-Received: by 2002:aa7:c50b:: with SMTP id o11mr18669665edq.160.1638968671366;
        Wed, 08 Dec 2021 05:04:31 -0800 (PST)
Received: from ?IPV6:2a02:578:8593:1200:9dd5:a52b:99d6:b584? ([2a02:578:8593:1200:9dd5:a52b:99d6:b584])
        by smtp.gmail.com with ESMTPSA id qa7sm1479654ejc.64.2021.12.08.05.04.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Dec 2021 05:04:31 -0800 (PST)
Message-ID: <06d4fc0c-9f1a-87c7-6e15-66e54006385c@tessares.net>
Date: Wed, 8 Dec 2021 14:04:30 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [mptcp:export 24/34] net/mptcp/sockopt.c:1174:12: error:
 redefinition of 'mptcp_getsockopt_v4'
Content-Language: en-GB
To: kernel test robot <lkp@intel.com>, Florian Westphal <fw@strlen.de>
Cc: kbuild-all@lists.01.org, mptcp@lists.linux.dev
References: <202112081738.D1IpgkU6-lkp@intel.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <202112081738.D1IpgkU6-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hello,

On 08/12/2021 11:58, kernel test robot wrote:
> tree:   https://github.com/multipath-tcp/mptcp_net-next.git export
> head:   8d79e486d97bbdec3af4cf2f19d91fec433d437b
> commit: 48c617e1584b3190eb02338f4ef77807f433e579 [24/34] mptcp: getsockopt: add support for IP_TOS
> config: um-i386_defconfig (https://download.01.org/0day-ci/archive/20211208/202112081738.D1IpgkU6-lkp@intel.com/config)
> compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
> reproduce (this is a W=1 build):
>         # https://github.com/multipath-tcp/mptcp_net-next/commit/48c617e1584b3190eb02338f4ef77807f433e579
>         git remote add mptcp https://github.com/multipath-tcp/mptcp_net-next.git
>         git fetch --no-tags mptcp export
>         git checkout 48c617e1584b3190eb02338f4ef77807f433e579
>         # save the config file to linux build tree
>         mkdir build_dir
>         make W=1 O=build_dir ARCH=um SUBARCH=i386 SHELL=/bin/bash
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>>> net/mptcp/sockopt.c:1174:12: error: redefinition of 'mptcp_getsockopt_v4'
>     1174 | static int mptcp_getsockopt_v4(struct mptcp_sock *msk, int optname,
>          |            ^~~~~~~~~~~~~~~~~~~
>    net/mptcp/sockopt.c:1161:12: note: previous definition of 'mptcp_getsockopt_v4' was here
>     1161 | static int mptcp_getsockopt_v4(struct mptcp_sock *msk, int optname,
>          |            ^~~~~~~~~~~~~~~~~~~
>    net/mptcp/sockopt.c:1161:12: warning: 'mptcp_getsockopt_v4' defined but not used [-Wunused-function]

Thanks for the report.

For those who missed the message on IRC, this has been fixed a few hours
ago. For more details:

- 70eb54838540: tg: drop 't/mptcp-getsockopt-add-support-for-IP_TOS'

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
