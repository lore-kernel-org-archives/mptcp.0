Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A98E7E7
	for <mptcp@lists.linux.dev>; Mon, 20 Jun 2022 16:33:25 +0000 (UTC)
Received: by mail-ej1-f50.google.com with SMTP id mf9so1882870ejb.0
        for <mptcp@lists.linux.dev>; Mon, 20 Jun 2022 09:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=GSYI3CMXkKGQO4ZDm4ldukFCGLY8krq4r+8++Sno5Go=;
        b=PMmhiFqFD/aZudp8m9LJ43INKo8A3idTR4K7YATSqAPE27tn9qMbzHfbyzvzJFbxKI
         n5L0vmJemixKATTEXlHafAn6hmN7I93YhIjsu2r87FFPx01JhvtGj2vatG2rrhw744fV
         OobizfOGSHB3Cjb79fP9X9P5yooBGF1p1taBUDpPrN5qohyZ4o6ZLI7AeajY8fbCfqxe
         0rp7Ac6dbEjEDXI8SIfffiOSSgOhG+xbojRX6uyyRPhPWYTzqRj3bM//XJTziSuHu+cf
         HmsMvvdLXLA0JLxbmxDC0ssVqkeITmWXNIO1Lm+EkNeva9IxoSLAmLafZzzbuFYNxQqI
         pE5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=GSYI3CMXkKGQO4ZDm4ldukFCGLY8krq4r+8++Sno5Go=;
        b=wUTP4Yiv8jHWNOmPqNTtIwuf1Q7eQ87Vs8IO0bIF4eX/sZ/lHsS43XV8fPRIAFZmhF
         VZ11RJ0wkIQI8YzL9XW7+ziVh+O5ioh4wPB7k5gZ+Lbz3YGJz1Xil+dO1SKVFQChXMCB
         4YZpqIKnxw+bEfLU8MP/WUoixxjxF25jnHVs0F45oIpuc8SZqM/1qmASimIKKQ2lQhB2
         gqc9kWI1nkvc6Wf1JToRRUlKnGfDcf6U9yxdf13SK/va0I8qG/R3AAJJJCrXnvgBTypo
         LPVAhMpic8S5vpanoL8Gw6y8MFENIgMBy9x967UtSJpk9kRqabCSPM4hKCpsOIE+OtYl
         EYMw==
X-Gm-Message-State: AJIora8YGNhzvp0+v/KjPdi1bf8UCZO2frx8XO4XcuvDs4J76CxiYlgM
	IVYKKmCoMOkCSEMr2OBfil43Cthqt1Djm1cs
X-Google-Smtp-Source: AGRyM1tLGj2WCRxBOnzSbi6QpgZzqbppq6j5EZPf2o+Z2qQyfxoAFhDCNTbqdRj9o7mGx35njLCToQ==
X-Received: by 2002:a17:907:7dac:b0:722:3352:ac05 with SMTP id oz44-20020a1709077dac00b007223352ac05mr9722165ejc.421.1655742804084;
        Mon, 20 Jun 2022 09:33:24 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:dab4:d6b9:b46d:dda6? ([2a02:578:8593:1200:dab4:d6b9:b46d:dda6])
        by smtp.gmail.com with ESMTPSA id nb36-20020a1709071ca400b0070beb9401d9sm6280138ejc.171.2022.06.20.09.33.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jun 2022 09:33:23 -0700 (PDT)
Message-ID: <c3923775-a448-76b5-e7c9-c2ea69aa43c2@tessares.net>
Date: Mon, 20 Jun 2022 18:33:22 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH mptcp-net] selftests: mptcp: more stable diag tests
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
References: <f318c8ca562695b07272ea3753a52f950555c18a.1655362313.git.pabeni@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <f318c8ca562695b07272ea3753a52f950555c18a.1655362313.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo, Mat,

On 16/06/2022 08:51, Paolo Abeni wrote:
> The mentioned test-case still use an hard-coded-len sleep to
> wait for a relative large number of connection to be established.
> 
> On very slow VM and with debug build such timeout could be exceeded,
> causing failures in our CI.
> 
> Address the issue polling for the expected condition several times,
> up to an unreasonable high amount of time. On reasonably fast system
> the self-tests will be faster then before, on very slow one we will
> still catch the correct condition.
> 
> Fixes: df62f2ec3df6 ("selftests/mptcp: add diag interface tests")
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>

Thank you for the fix and the review!

Great to see the CI reporting less issues :-)

I guess I can close issue 264:

  https://github.com/multipath-tcp/mptcp_net-next/issues/264

New patches for t/upstream-net:
- 718b9e36a088: selftests: mptcp: more stable diag tests
- Results: bd3a280300a4..2500388fcff9 (export-net)

New patches for t/upstream:
- 718b9e36a088: selftests: mptcp: more stable diag tests
- Results: f267d3bf87de..1445c5fa4907 (export)

Builds and tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export-net/20220620T160817
https://github.com/multipath-tcp/mptcp_net-next/actions/workflows/build-validation.yml?query=branch:export-net
https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20220620T160817
https://github.com/multipath-tcp/mptcp_net-next/actions/workflows/build-validation.yml?query=branch:export

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
