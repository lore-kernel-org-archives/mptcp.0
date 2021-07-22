Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2791173
	for <mptcp@lists.linux.dev>; Thu, 22 Jul 2021 13:33:38 +0000 (UTC)
Received: by mail-ej1-f49.google.com with SMTP id qb4so8360704ejc.11
        for <mptcp@lists.linux.dev>; Thu, 22 Jul 2021 06:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=to:references:from:subject:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=y//ZIOCxyQM1wrIPV5uML+zILDB1cRinJ653fIaQDko=;
        b=u3tEFbFcvi37KpGsxm1BJ5cmOT6byjlvuNUQmVajCOz4n4mSTuSogQvkdB0P8g7yeC
         iBXDsHex7sm8cbV73vXvGasH4pdZw66U/idMtNzGTQMAfZHwkcB2ejl1sXsh51oZcRk0
         uchdB+g0n2w0N1OIMBcnyPzvs2c8IP8DRrO4I5Zl2YQblE+uPkXnkOPqhrkBlkh0Hu13
         2wEGb5Icd87q6gtywxZRHh+wNktYxvFGZ0jqL7GJ9OnD8ovB/Zk183hlNzGmtz0RUPFk
         bYToG97uxB+4WQH2UrpdmOeTMpH5fl+yzGmjB4ofwCXyVmPCOFfXEooH7NxbTQubDW82
         K61g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=y//ZIOCxyQM1wrIPV5uML+zILDB1cRinJ653fIaQDko=;
        b=WTlqo04mjQZge60mbhtTAljPDms1gvwA6BgbXAhABARXwmIe0HWi8sm7lNJzlxHArw
         zLYulhKTlNNOVYAvChTHG8gKKyz1c0Fb9w0JrQHN7BYETRahw7N93ji1JI3nWa26l3Mc
         eI7gM1DIhr0g4hmBexJkHrnf1Mg7HUOsqp2QgrD/pQwyvuCBYhLaOHDzT4MNSBqx8TIC
         /++4251Qrmmz4CB+tz60t1FseVG49dseO5OJhuYIBF62wFQCyIYfRZdj2J2SeBmVBGOx
         yho8Sxyh2u/bqKViPobpWGevCGC1AAh/pCVvF5y3lZvdR45Nxr0ng8HnGpAPeGyBKhj6
         M0wQ==
X-Gm-Message-State: AOAM532Man1s1t5L3LqdL19T5kjVKJWulhWY9xGMRo07vCd4Cok5owWx
	8milEwSd3toyTqVuewMxRDjRMXDAvvUDxsXeDMM=
X-Google-Smtp-Source: ABdhPJwcSGY8b+QxEQMIlz/enllEKfcbrQGlTNdvKXZHiBwumUV8kGASMC8FaHUVeA1ZC2qJ6+bXnQ==
X-Received: by 2002:a17:907:381:: with SMTP id ss1mr42848766ejb.404.1626960817006;
        Thu, 22 Jul 2021 06:33:37 -0700 (PDT)
Received: from tsr-lap-08.nix.tessares.net ([2a02:578:85b0:e00:8391:ca7f:9c1b:4236])
        by smtp.gmail.com with ESMTPSA id j5sm3972813edv.10.2021.07.22.06.33.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Jul 2021 06:33:36 -0700 (PDT)
To: Geliang Tang <geliangtang@gmail.com>, mptcp@lists.linux.dev
References: <cover.1626877655.git.geliangtang@gmail.com>
 <b5f63eb4ad680a99fc806d2406968a6a5f272f01.1626877655.git.geliangtang@gmail.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: Re: [MPTCP][PATCH v2 mptcp-next 01/10] mptcp: add a new sysctl
 fullmesh_enabled
Message-ID: <9e41f1de-fac9-145a-f8c7-79c5028c5f91@tessares.net>
Date: Thu, 22 Jul 2021 15:33:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <b5f63eb4ad680a99fc806d2406968a6a5f272f01.1626877655.git.geliangtang@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit

Hi Geliang,

Thank you for sharing this v2!

On 21/07/2021 16:31, Geliang Tang wrote:
> This patch added a new sysctl, named fullmesh_enabled, to control whether
> the fullmesh path manager mode can be enabled.

Should we not fully control the PM via Netlink?

I know it is easy to add sysctl knobs but mixing places for the
configuration might be confusing :-/

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
