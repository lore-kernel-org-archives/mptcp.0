Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 338645580
	for <mptcp@lists.linux.dev>; Sat, 19 Feb 2022 16:45:56 +0000 (UTC)
Received: by mail-ej1-f41.google.com with SMTP id d10so22268840eje.10
        for <mptcp@lists.linux.dev>; Sat, 19 Feb 2022 08:45:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=xHkzzGxxkhmIBF2Rm6ljrt2tY09hwb+Em7l8Zk4qoFA=;
        b=APn+Hhd7+s1HcBRpCg39ua0DwoBmXa4qWttky4NJWShJ5FGngS71qemxRSYX8CJdSg
         Ueoc+iSA4Q8jUupmAcw9Urw4fiBaE7oof4f3aMHM3nySKySKfZBNunZMWjTLvIlNKGWk
         145dBzSkI+aUceI43SjeJbjLBq4hrTEswjfkXnfIF8q4vne/XRhEDv0163V3JWHx3PVx
         aYpSugmFab+NkkZyi5W6E7MVGGxmuIWlVrbenzLbo9Pkg9Aa5cwC2HerUZU8IP8x4Ize
         Xh4gOdnuecRXw65PmjkU+Rg+D/+PcbYfHbFW/MBPTlr/fvtJzyzOFyvcp6924ePjLafK
         uOYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=xHkzzGxxkhmIBF2Rm6ljrt2tY09hwb+Em7l8Zk4qoFA=;
        b=4s38UOIgxt4NfcCCrBJ/s/BJauFaf9vnnt619iRs+S6jj4GTwt+yiUSJN/buXCmR5O
         qlNzWswMzSDyoNbPBjyRYpmPc44lvFWodEzG7bwIv3SJaDPL8pQ5exg3B30vHuK+7cK9
         LuWBPLC34vICuAmWh5SqEGX+gUURsMTiYLVuOPABFSuRH8oQ6jBeYV4r1WTl4ixsQ+uP
         /Sxj3kMtPiDAqpb/eHK+FbfWMnPZeqk5JQFfbkGEr19uNua1YgEpRq+tgZjfZd6s4sEa
         2q9ldqeh4cBsYaV6ZIoUnUY+1kTTKbYv9jdYtSx9j5P1yVWYeQALA9qxkyiPkKiYRy/T
         +5jg==
X-Gm-Message-State: AOAM531hW3psAzoWtNNMZ1LmaZARSjIfgkp4F8Le266U1Y2YSd1YEGEA
	dUTFODnbhXn4Vn2sX/Ug8dU1whSZLlzsY1qc
X-Google-Smtp-Source: ABdhPJyyQ3mLjoXNbqQS4FPBgNHPPikE89NQG0IWW50mfocvicm/ubvWK1zAdpn1BOXYyLY23BzJdQ==
X-Received: by 2002:a17:906:7751:b0:6ce:e3c:81a6 with SMTP id o17-20020a170906775100b006ce0e3c81a6mr10051990ejn.278.1645289154916;
        Sat, 19 Feb 2022 08:45:54 -0800 (PST)
Received: from ?IPV6:2a02:578:8593:1200:178d:a7ba:fef8:c05f? ([2a02:578:8593:1200:178d:a7ba:fef8:c05f])
        by smtp.gmail.com with ESMTPSA id d18sm3340764ejd.95.2022.02.19.08.45.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 19 Feb 2022 08:45:54 -0800 (PST)
Message-ID: <fe907d60-865b-0b97-ba8a-5176be8ed304@tessares.net>
Date: Sat, 19 Feb 2022 17:45:53 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH mptcp-next 0/3] Upstreaming cleanup
Content-Language: en-GB
To: Mat Martineau <mathew.j.martineau@linux.intel.com>, mptcp@lists.linux.dev
References: <20220218221814.72026-1-mathew.j.martineau@linux.intel.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <20220218221814.72026-1-mathew.j.martineau@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Mat,

On 18/02/2022 23:18, Mat Martineau wrote:
> The most recent patch series I upstreamed for -net needed a couple of
> tweaks to mitigate net/net-next merge conflicts. The first two patches
> here update the commits in "fixes net" on the export branch to match
> what I sent upstream, and the third patch restores Paolo's function
> rename in mptcp_join.sh.

Thank you for these patches!

Now in our tree to be ready for the next sync with -net:

- 74d3b29e0057: "squashed" patch 1/3 in "selftests: mptcp: improve 'fair
usage on close' stability"
- ab0f4168d96d: "squashed" patch 2/3 in "selftests: mptcp: more robust
signal race test"
- 1c3bc536df32: selftests: mptcp: Rename wait function
- Results: 93c0eb10f07a..8dda577d8414

Builds and tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20220219T164531
https://github.com/multipath-tcp/mptcp_net-next/actions/workflows/build-validation.yml?query=branch:export

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
