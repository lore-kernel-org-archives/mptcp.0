Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A771C5250
	for <mptcp@lists.linux.dev>; Mon, 19 Jun 2023 09:18:21 +0000 (UTC)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-51a52a7d859so2077251a12.0
        for <mptcp@lists.linux.dev>; Mon, 19 Jun 2023 02:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1687166299; x=1689758299;
        h=content-transfer-encoding:in-reply-to:cc:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/lVVFewVaE+P6JBt8Wdotx9KtVwgLlpdfuN8wwxmUvg=;
        b=6Efu3X1Mu0xLRS0TetnRUGnzsB7NRS73QVAqSYUpcVMt8sEigWWy4pVC2BCM/kT1C3
         ZPKI7wzG4DjiAqxN3qdGugbg/Fp8siqPVrdyKqpKDixhYfihajbuqaD/xEmqsLyrfUCX
         B6R5IxmWDIPfdvleHQCZVRfsgENIHpEEeVnMBL+WG3Juubad9j34fHkeck1Dpc9nwREL
         197qV1Q72zuu+GLZsFnsfX9gMC19NcOFha0Vdxig1g0uXaecus7TLpNObI/G9Uz7uHUV
         DeuLh3Jj5ZemajuI41BrzQ1BPgvFMDqzzEgrFGLTCyl/kaYFFp7VVD4ow1+Z+NOLVrnN
         tqzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687166299; x=1689758299;
        h=content-transfer-encoding:in-reply-to:cc:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/lVVFewVaE+P6JBt8Wdotx9KtVwgLlpdfuN8wwxmUvg=;
        b=WAxyd2r9MEyfZAj6W6PQAijFFeJvLv+pGxKfd2QyjeUO5+pvBy53lzw7V0WSyGUv/O
         QzbY3835aaU+pay/DLhsn+Xs/O8miRD+OWlQWvqnqorfCUobQy4ZFhydfBEIPQ5t3END
         FpqZNWm62iVIk/a2OQG6lhrOjl4ylNSDMumYMYjJ/NX149pPZ8ebIJbTjSj/RI2QufP9
         JUdoOl2QijC/EpLSir6b00eqxL1Jv4hlYIaT8tP3d7BdnRMUsz07ZHMvIFPo9zFHjeVv
         t42B98X0AFsDXurvtog5Fo57j+884rTZyAzcsqUJCb35k2Cmy2ry0Hhfjb30yC28XXkv
         qaKA==
X-Gm-Message-State: AC+VfDzN/RZAlfCO/2s8RwR9dlc+NUf/jDhnkLESKrZ8ETYmoGz7KjRU
	neWqDZQ/REajutlBQ5/IM4CmgFWkYrPZpzJurnz5Mw==
X-Google-Smtp-Source: ACHHUZ6THBchPOciZYrBDo9GXXBv0bALsvJavmmSvNkniqyJ0AzQz78FewinxR+95UfJCCVkLDogXQ==
X-Received: by 2002:a17:907:3e83:b0:987:fe18:1c58 with SMTP id hs3-20020a1709073e8300b00987fe181c58mr3884301ejc.35.1687166299288;
        Mon, 19 Jun 2023 02:18:19 -0700 (PDT)
Received: from [10.44.2.5] ([81.246.10.41])
        by smtp.gmail.com with ESMTPSA id o6-20020a17090611c600b00987bc81506dsm2900579eja.202.2023.06.19.02.18.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jun 2023 02:18:18 -0700 (PDT)
Message-ID: <62f9107a-3b64-468c-b5bb-232965fbede0@tessares.net>
Date: Mon, 19 Jun 2023 11:18:18 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH mptcp-next] mptcp: drop legacy code.
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>
References: <3bac625cd995fdb3fc6786b599e3c413f00fc6f5.1686584494.git.pabeni@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev
In-Reply-To: <3bac625cd995fdb3fc6786b599e3c413f00fc6f5.1686584494.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo, Mat,

On 12/06/2023 18:02, Paolo Abeni wrote:
> Thanks to the previous patch we can finally drop the "temporary hack"
> used to detect rx eof.

Thank you for the patches and the review.

Now in our tree (both in "fixes for -net" as agreed at the last weekly
meeting) with Mat's RvB tag, the modification asked by Mat in the commit
message of patch 1/2, mention the name of patch 1/2 in the commit
message of patch 2/2 and a small change in the title of patch 2/2
because we already have a commit with the same one.

New patches for t/upstream-net and t/upstream:
- 92a5d1cb400c: mptcp: consolidate fallback and non fallback state machine
- f5dc57f26818: mptcp: drop legacy code around RX EOF
- Results: 7c2d56234e38..3aa564399c36 (export-net)
- Results: ce02fd8dab59..0cf78b82b67f (export)

Tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export-net/20230619T090002
https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20230619T090002

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
