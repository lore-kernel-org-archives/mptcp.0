Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40EAB71
	for <mptcp@lists.linux.dev>; Thu,  6 May 2021 12:29:36 +0000 (UTC)
Received: by mail-ej1-f43.google.com with SMTP id r9so8006796ejj.3
        for <mptcp@lists.linux.dev>; Thu, 06 May 2021 05:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=KhG2RiUc5L6oq7pstlPDc/pr0ZrC01m6fiidTVS5biQ=;
        b=NUq8O5eoUWVGpV3f+UIRSDEYFKRXAtVivWy0VRB4v1zRmFjPYpFK1HgXeYvvwkyXML
         6P9m8yPRUsRKIH89kPYqMDNQcIaBvwUIrtM2gYXxVtBOFKdKkGNLAqp2KL5EPjPGTmSD
         pvl8juMPeP2ciXQVZ75FFraLplhX1VQdLuPqqnkb2aqBrqwipNxzL3lMq4fOb6gOyRm6
         GQVhgvmpyMW5dLNGPUgbfZhtyfG+LARrpUUGZniYDlEcOkTW+YGMuDLv6YBRS83+n8jL
         IcGnsBacCv3f7FOezthTZZhFUWi6yMAcs037ziMTt8E4PotoaQBlm6ayWypLAFXVwtRj
         W5QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KhG2RiUc5L6oq7pstlPDc/pr0ZrC01m6fiidTVS5biQ=;
        b=MM6VSrwN99iN+KqT28koNufwPhnJaHnlGDu4/T4WvWMRnoKgjjOXwlT8ddxmTkTHxf
         SjBhDz/hvBCGiCJUzEwncwT8UjXlEBe6J8CyHrxAetOLPP2ZGr5C6APk9iLv8xRhmx2T
         D5U0yDIsx7ReXajIBet89K/S6q+PTgn59uK0F2aIxhu+CXCV/mBmD2/wisPr5JVykTr/
         jJIXV8nTVikF+jwWT2lGm670kt1Fg+xhp8fqddV3OxUOTmhUZDjqV6SeH1YSJ/kWs70l
         y0MG+tLbjT8TywyLWmB2ED5gTRqLx8SVJ74tZRAxdrbbaqOPOwMQtM3K7Z7cantiPHmp
         TVbA==
X-Gm-Message-State: AOAM530vY4gyM5lHwilGR028sdtqH/h0XW0CoXZiFTLHBK8ogWegqCNA
	bDQjP1TXxzrJgtQzWnGixR/0vA==
X-Google-Smtp-Source: ABdhPJy9OW61kHPPlWve2pbD71IQmlU0iYkjevGhUzta2+X3rbpQO5C2Vr1uNqwCwcpR90cYZi6V7A==
X-Received: by 2002:a17:906:32d8:: with SMTP id k24mr4203774ejk.156.1620304174739;
        Thu, 06 May 2021 05:29:34 -0700 (PDT)
Received: from tsr-lap-08.nix.tessares.net ([2a02:578:85b0:e00:2955:d350:566e:2ff2])
        by smtp.gmail.com with ESMTPSA id g13sm1288107ejx.51.2021.05.06.05.29.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 May 2021 05:29:34 -0700 (PDT)
Subject: Re: [mptcp:export 25/36] protocol.c:undefined reference to
 `mptcp_is_checksum_enabled'
To: kernel test robot <lkp@intel.com>, Geliang Tang <geliangtang@gmail.com>
Cc: kbuild-all@lists.01.org, mptcp@lists.01.org, mptcp@lists.linux.dev,
 Mat Martineau <mathew.j.martineau@linux.intel.com>
References: <202105061823.5b2YbffT-lkp@intel.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Message-ID: <9746feb4-178f-f663-b452-f7c66b29bf25@tessares.net>
Date: Thu, 6 May 2021 14:29:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <202105061823.5b2YbffT-lkp@intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-GB
Content-Transfer-Encoding: 7bit

Hello,

On 06/05/2021 12:42, kernel test robot wrote:
> tree:   https://github.com/multipath-tcp/mptcp_net-next.git export
> head:   a80b9458a82c6568e3859b1e16cc45b48a24dc46
> commit: eb3ca35b48814a29b9942f5109f4c0183aa6f776 [25/36] mptcp: add a new sysctl checksum_enabled
> config: nds32-randconfig-c003-20210506 (attached as .config)
> compiler: nds32le-linux-gcc (GCC) 9.3.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://github.com/multipath-tcp/mptcp_net-next/commit/eb3ca35b48814a29b9942f5109f4c0183aa6f776
>         git remote add mptcp https://github.com/multipath-tcp/mptcp_net-next.git
>         git fetch --no-tags mptcp export
>         git checkout eb3ca35b48814a29b9942f5109f4c0183aa6f776
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross W=1 ARCH=nds32 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>    nds32le-linux-ld: net/mptcp/protocol.o: in function `__mptcp_init_sock':
>>> protocol.c:(.text+0xb2c): undefined reference to `mptcp_is_checksum_enabled'
>>> nds32le-linux-ld: protocol.c:(.text+0xb30): undefined reference to `mptcp_is_checksum_enabled'
>    nds32le-linux-ld: net/mptcp/subflow.o: in function `subflow_v4_route_req':
>>> subflow.c:(.text+0x1934): undefined reference to `mptcp_is_checksum_enabled'
>>> nds32le-linux-ld: subflow.c:(.text+0x1938): undefined reference to `mptcp_is_checksum_enabled'
>    nds32le-linux-ld: net/mptcp/subflow.o: in function `mptcp_subflow_init_cookie_req':
>    subflow.c:(.text+0x19e0): undefined reference to `mptcp_is_checksum_enabled'
>    nds32le-linux-ld: net/mptcp/subflow.o:subflow.c:(.text+0x19e4): more undefined references to `mptcp_is_checksum_enabled' follow

Thank you guys for testing our tree!

FYI, it has been fixed a few minutes before your report:

https://patchwork.ozlabs.org/project/mptcp/patch/20210506103734.3845725-1-matthieu.baerts@tessares.net/

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
