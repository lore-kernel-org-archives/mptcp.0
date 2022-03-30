Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9398A63C
	for <mptcp@lists.linux.dev>; Wed, 30 Mar 2022 13:29:09 +0000 (UTC)
Received: by mail-wm1-f46.google.com with SMTP id h16so12258977wmd.0
        for <mptcp@lists.linux.dev>; Wed, 30 Mar 2022 06:29:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Pg19OyUba2H/pb0ewgVc9lo4WrIUZAUv0Ud1Skq5a5Y=;
        b=vXq5cvPDfXffTx4+zALWDOHQxjFVPQZMrJrFtaHWdoJWaK9RQCoFvkCQqsQVQhHYu6
         E985nEBFpOZvDyNwA4IMz7SU89hATEJK9UDMrKfsTJ9W/MquAkoEwy7e9AwkkMopfKOd
         7vTLDDaqYGCqLL9iuOwhHEZwgfCqY/sYf+nw2VGNB/ssi5FmeCPEvTF4q2xBG7zPSQ56
         tAjMzGz1k9YyF7wHpnEKd/5W02nD7d5JibjdRir+HR5huzi51bHLcKvcOz6sfpIXROrQ
         HyVwXsQEafbkoQRxAo0CiSuLXKzJcjkl36dRHSzjQtWZ/MipuY9Jrs/WqvldHrIYivQ7
         V0mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Pg19OyUba2H/pb0ewgVc9lo4WrIUZAUv0Ud1Skq5a5Y=;
        b=sTmaaQwXfQqNREz3jyEGkXsukoqGOmXp1KfIees/IPEpA/iUZSTVmyqODO74T0XyQp
         CHYcFmRkJjZK3Pwu1iNwVLNWLYMTq2tOtZGFU7YXFigt69ezH+r7Rld/RBQh/UNnEdqE
         vs8sgQP5huPc6fOz6FKtTeDYur9fYZSz6J+cnWki57i0i5haZ7MXCRfuJzewnCDFxfQK
         TkgbeXhRw1KKU7h3o/gS684oreRYL+eMvCNqst73RhmHSjm/yfBiEYj1LLAzUAfljPS7
         ibYAnwF7k78sfgFK2QHLak0jiogCU9QgQPr1VCeVQwkUN4YpCmOApU1YdVttvxCn6a1U
         yxMg==
X-Gm-Message-State: AOAM53079Rw4CmkpOb1cVAJg2fsJy1n+Y2ECIF+FmSF50HoWid6XoxW3
	+OakSC0UfeCPP3hkjwtdPz6PyA==
X-Google-Smtp-Source: ABdhPJwJkLMGq7BUecKF6P7OLlxXv4kggLycL47tGn4jzFbMdMunW8yBCq+GQZwkp0aWbj6lnF45Zw==
X-Received: by 2002:a05:600c:49a9:b0:38c:987d:d692 with SMTP id h41-20020a05600c49a900b0038c987dd692mr4585374wmp.166.1648646947628;
        Wed, 30 Mar 2022 06:29:07 -0700 (PDT)
Received: from [10.44.2.26] (84-199-106-91.ifiber.telenet-ops.be. [84.199.106.91])
        by smtp.gmail.com with ESMTPSA id k40-20020a05600c1ca800b0038c6c8b7fa8sm4889296wms.25.2022.03.30.06.29.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Mar 2022 06:29:07 -0700 (PDT)
Message-ID: <ecc7a980-d75f-2172-8fc2-eb12de7cf7e3@tessares.net>
Date: Wed, 30 Mar 2022 15:29:06 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH mptcp-next] Squash to "bpf: add
 bpf_skc_to_mptcp_sock_proto"
Content-Language: en-GB
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
Cc: kernel test robot <lkp@intel.com>
References: <ffd704984e4e76741161d35ef127fde082d0add1.1648624018.git.geliang.tang@suse.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <ffd704984e4e76741161d35ef127fde082d0add1.1648624018.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 30/03/2022 09:08, Geliang Tang wrote:
> Fix the build breaks reported by kernel test robot:
> 
> [mptcp:export 32/40] ld.lld: error: undefined symbol: bpf_mptcp_sock_from_subflow
> [mptcp:export 32/40] filter.c:undefined reference to `bpf_mptcp_sock_from_subflow'
> 
> - add defined(CONFIG_BPF_JIT) too.

Thanks for the fix!

> - move bpf_mptcp_sock_from_subflow from bpf.h to mptcp.h.

Should we add an explicit #include <net/mptcp.h> in filter.c.

But maybe it is enough to have net/mptcp.h in net/tcp.h?

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
