Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32B897C
	for <mptcp@lists.linux.dev>; Sat,  2 Apr 2022 11:01:17 +0000 (UTC)
Received: by mail-ed1-f54.google.com with SMTP id a17so5678087edm.9
        for <mptcp@lists.linux.dev>; Sat, 02 Apr 2022 04:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=tqgXLlEfo6HE9vGhovPqJa+1ssqZQ+lbRKLBUHKN3fw=;
        b=wSUhQymVOguc3DfZ+YcnbhrIAfrUkBzFSrsQXD54JKC1uCWAg7bWPmP9U80aPD9psc
         d/KYTxOSHnWD/wqdTnCDd8bW2hxIHUNbZ33pIAUAntjJJc75cZCI0UJjKeBkd8E974EK
         L54hbK5+HgWPQiuKStVgzcMSbT/gQ1jUB3WHOW1rzFIWrk3lR1xxw5B9PsS+kDh9zORQ
         FaTPHbMvfiIgrR3cNYcLdacYi98IUi2S5UNMY+oR7/zG12owy59T1TnzK8aMyYJDvbp4
         K8B979CSorCkyTbC6Ic5QkQHXwCoEYwM4ssw9QAuWAdvBVfqgrGfnLylINf7tux2rJth
         6jgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=tqgXLlEfo6HE9vGhovPqJa+1ssqZQ+lbRKLBUHKN3fw=;
        b=fwzaHHqd5AMg356mRp2wK9KctA6uHnWJKsqIzttdqDqyG0f4XBR0A6qeJ/VD67TLyc
         GWdVuHzUDsi2DzappmMsd7QwuVdKJ1jYFoanh1dZLEF3vy3yO902JcoS48v7tFZKuT7z
         815RYvC23gVKdWOkblLFwZTWvu5LLHc1gbGMpDNoDcVqmkIsD+wsLmYEfR78SOx+JEc0
         qbLyb46l/iw3FEN+kBE56noJit6pLoIHTnO3s/U6HHVQM5WA/JW/RxrDscp/aNtytKqR
         QBcFP2JzngY+65oVhW5Kmw9kgqzeLeK+G8ivJYNjMUFL4+TxoTau6TOEll0XEC8ubmPn
         WtuQ==
X-Gm-Message-State: AOAM533E4weAOkMienjGGO4nHA+v7oVnOPHDVwCPt3Cfcuozjk0QUUt/
	MCX3XyLBb8udvz98v5kYGgv7tzji+vx+/w==
X-Google-Smtp-Source: ABdhPJzdiNRkrhgkX6l6RoUj22PCKSNMzeyCwLoVTiJkRM4Ya0PxhEM3JUdmCpCt8sV90i+H+jDCAA==
X-Received: by 2002:a05:6402:914:b0:419:a627:ef6f with SMTP id g20-20020a056402091400b00419a627ef6fmr24878609edz.67.1648897275793;
        Sat, 02 Apr 2022 04:01:15 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:38b2:90f6:4953:8b31? ([2a02:578:8593:1200:38b2:90f6:4953:8b31])
        by smtp.gmail.com with ESMTPSA id by4-20020a0564021b0400b00418fc410299sm2261440edb.62.2022.04.02.04.01.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Apr 2022 04:01:15 -0700 (PDT)
Message-ID: <85efdabe-044b-5c78-de66-e3d7138fdccc@tessares.net>
Date: Sat, 2 Apr 2022 13:01:14 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH mptcp-next v9 0/6] mptcp: fixes and enhancements related
 to path management
Content-Language: en-GB
To: Kishen Maloor <kishen.maloor@intel.com>, mptcp@lists.linux.dev
References: <20220329021401.1196466-1-kishen.maloor@intel.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <20220329021401.1196466-1-kishen.maloor@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Kishen, Paolo, Mat,

On 29/03/2022 04:13, Kishen Maloor wrote:
> This patch series incorporates fixes and enhancements related to
> path management over MPTCP connections, particularly in support of
> userspace PMs. The changes ensure that the required bits of
> information are conveyed through MPTCP netlink events which
> would be consumed by the path manager in making its decisions.
> Further it adds flexibility in establishing paths and from
> both ends of MPTCP connections.

Thank you for the patches and the reviews!

Now in our tree (feat. for net-next next) with Paolo's ACK and Mat's RvB
tags + my RvB tag on Mat's patch:

New patches for t/upstream:
- 427906c8a699: "squashed" patch 1/6 in "mptcp: Bypass kernel PM when
userspace PM is enabled"
- 6640ff7f4de5: "Signed-off-by" + "Co-developed-by"
- Results: 463bac3cb3eb..6ecd31441499 (export)

- ab5c3fe24c5d: "squashed" patch 1/2 in "selftests: mptcp: Add tests for
userspace PM type"
- Results: 6ecd31441499..bdcfe21e5935 (export)

- 3fd4c2a2d672: mptcp: bypass in-kernel PM restrictions for non-kernel PMs
- 564dcdfa9e21: selftests: mptcp: ADD_ADDR echo test with missing
userspace daemon
- f9900267d0b8: mptcp: store remote id from MP_JOIN SYN/ACK in local ctx
- fc1a120f5a70: mptcp: reflect remote port (not 0) in ANNOUNCED events
- 12d4f5bc7b1c: mptcp: establish subflows from either end of connection
- 653a3596c18f: mptcp: expose server_side attribute in MPTCP netlink events
- Results: bdcfe21e5935..580d91d8ba51 (export)

Builds and tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20220402T105856
https://github.com/multipath-tcp/mptcp_net-next/actions/workflows/build-validation.yml?query=branch:export

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
