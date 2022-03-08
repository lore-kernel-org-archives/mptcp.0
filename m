Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3562F48D0
	for <mptcp@lists.linux.dev>; Tue,  8 Mar 2022 14:28:47 +0000 (UTC)
Received: by mail-ej1-f51.google.com with SMTP id a8so39624596ejc.8
        for <mptcp@lists.linux.dev>; Tue, 08 Mar 2022 06:28:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=19PXEmeV/KGmgEANv2DsrtT3MA/K49WNrePAHFZ92/8=;
        b=4PF50ClmV62LbpsthulpUXRfrUrLwkyxYkloJQ/t1CYQShPHYhRcDlKOM+DlpIDItC
         6QtzzRw5ihzplbjsBvB8qcHSQy3Ubo5/RXEFP/p04RynKl9qyrLzzOpM3xdlgmcZbdU7
         p7JRJci7Q1D1NkUzOwEN0oxRi2cAIx1oXggTtZX0ZhU7ey7qfx+tpVOTeod7SYCkLlDK
         SeDFKWINTAVi/V1F/rspmlS+Zuanlw410SfaBC8hN73ulF+rT+e6+zrA/9AsjWLe9CUe
         kmaEmxEeoUshuY/UfWLXoUe1XHUvxyM8F//KEkuo/sOHZwGz3yAD1Y0EAsM9Qud3ZN7n
         J+Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=19PXEmeV/KGmgEANv2DsrtT3MA/K49WNrePAHFZ92/8=;
        b=29H9WWiqfb/4N0q8T4S/Hu3W76tvOhf+ViXi9WAIr85HPUCs4n7Cd14fHkLe6HeOAk
         bLhaedyybyXCmojdfnZc/znTURhXjHVma6DdCT5e6dDFG+NlUrlnrTB7BX6JWh2z3Kto
         wt5ZODgO18bN4UK03tq7Q+EVGlZIxEkFrOW/C9ueR2DDGJZxyykL1NghsUaEGKKGFBp3
         wcxgX7+/DRZEttxLC6dg5J8qcWqLjzmQz1/p7eIMvnmBjHnR9yRHsI44BV+q0U/GKK/4
         cEONP21UvciPLWpArF8X4Tak0cIAqOLMabZG/ko2Ho9hOMzokaitMxkZ0nYEULK48B8w
         NHrw==
X-Gm-Message-State: AOAM532Tagh2KwRXvVfxiz5YI/1phq+AgI0kYML5KHIVNzNxBngR3vIk
	biPFBHdqLZt7IEa1EBJjDSOYDPusECdqpg==
X-Google-Smtp-Source: ABdhPJxZRZUopPnw48w69qUWPIe8g4MAM0FD3vEi4VWy4WR3T/07D0cWPd0xvkHcdhI9aVoMw1qExA==
X-Received: by 2002:a17:907:a40a:b0:6db:462:dbe9 with SMTP id sg10-20020a170907a40a00b006db0462dbe9mr12409926ejc.59.1646749726024;
        Tue, 08 Mar 2022 06:28:46 -0800 (PST)
Received: from ?IPV6:2a02:578:8593:1200:4a74:9d9d:42fe:ff08? ([2a02:578:8593:1200:4a74:9d9d:42fe:ff08])
        by smtp.gmail.com with ESMTPSA id t3-20020a170906268300b006db02dda82fsm3714644ejc.168.2022.03.08.06.28.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Mar 2022 06:28:45 -0800 (PST)
Message-ID: <01d4f89c-b459-8d50-54fb-c2c08f4bcad1@tessares.net>
Date: Tue, 8 Mar 2022 15:28:44 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH mptcp-next v9 5/5] selftests: bpf: add skc_to_mptcp_sock
 test
Content-Language: en-GB
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
References: <cover.1646745228.git.geliang.tang@suse.com>
 <72ffef207bb0a4cdbce2c1bb5bf9c892b2d9a1cb.1646745228.git.geliang.tang@suse.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <72ffef207bb0a4cdbce2c1bb5bf9c892b2d9a1cb.1646745228.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 08/03/2022 14:16, Geliang Tang wrote:
> This patch extended the MPTCP test base, to exercise the new helper
> bpf_skc_to_mptcp_sock() from C test as Alexei suggested in [1].
> 
> Added a new function verify_msk() to verify the msk token, and a new
> function get_msk_token() to parse the msk token from the output of the
> command 'ip mptcp monitor'.
> 
> [1]
> https://lore.kernel.org/netdev/20200922040830.3iis6xiavhvpfq3v@ast-mbp.dhcp.thefacebook.com/

Thank you for the new version.

I was wondering if we should not squash this commit into "selftests:
bpf: add MPTCP test base" but I guess it is fine like that.

> Co-developed-by: Nicolas Rybowski <nicolas.rybowski@tessares.net>
> Signed-off-by: Nicolas Rybowski <nicolas.rybowski@tessares.net>
> Co-developed-by: Matthieu Baerts <matthieu.baerts@tessares.net>
> Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>

For this commit, you don't need to add those. Only for "bpf: add
skc_to_mptcp_sock helper" because it replaces "bpf: add 'bpf_mptcp_sock'
structure and helper".

For patches 1-2/5 and 4-5/5 + Squash-to patch:

Acked-by: Matthieu Baerts <matthieu.baerts@tessares.net>

For patch 3/5, I had a small remark, it can be fixed with another
Squash-to patch if it is easier for you ;-)

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
