Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDCDFAD25
	for <mptcp@lists.linux.dev>; Wed, 14 Dec 2022 17:36:03 +0000 (UTC)
Received: by mail-wr1-f45.google.com with SMTP id h11so458163wrw.13
        for <mptcp@lists.linux.dev>; Wed, 14 Dec 2022 09:36:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UlJMaLkLFXJ/mgdBrTZNcuBGMM/LUSBDo9Z26iBQZ/Q=;
        b=NWUnS52b/pqQKo3KQ6Jz9FHJ21To3yIOo+ATZ2GtbiMXjVUu1tX/QXicvq+kP8WrmH
         2jybYd92fw8zwU8mUcSrKPgAmJmUe2a5O4g8NfjtfNovXjOmrl72xOPMODtAmLleVpfJ
         SA2Kr6glcjpwp+zS/6g74/QBPM0hMsLI2l3WrEp7d3SIpXa6Z8AztIJdnviGMGOd8yf5
         LBJEkUEtVpXOLMQNP5aEIWSdN1HSHhRrDIvkRsa9BFdH1IBR6KHNMHW+BqNJt9Qdps4y
         fVSC9S7n7OYdS0G/PgeB/NxgOjc0OpJpKUhHe6FijUWQiJAZLrnoWRcn+2rvs+u+3/0Z
         kGqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UlJMaLkLFXJ/mgdBrTZNcuBGMM/LUSBDo9Z26iBQZ/Q=;
        b=WQnujFwCZPaJ4//sX8LIK1ztosnD7QWUusdUo/o6yfHirfwQDSJ2ZN1Q9l6Llamp3H
         yKBQT+51tlarvjr20iJd4pAonWYRxL7P48PGIdzfuhNFTC00jSg4T6cIbsIRuN396k9i
         7fv5L2Act+oggGXpPas/QnqNav89J2xVQPQVlrwySuq5NlhHElI7ZIFNzQDB7Xu9oRXo
         0ErOHt8hIrNPZZ/lS5WjxKs/Y7QHqDSnY3mOQ1gGHu3B87RBIKhs5JwDgKLDW0i7yzvC
         XT1l8AZULIJSYro8SrRT/pbyk8xR+1QCS5t7b5e9C9b9Rq9f5rG+pZtobhg51PUGbjU5
         m7+g==
X-Gm-Message-State: ANoB5pkRI3bH3LJ78hWzaB1fLLB9pyeni3C2KBZ1u5e/q9njU6MSVUml
	IZ4ikeI24As5OGp2JjAunZ5VWorzreYEmRrp
X-Google-Smtp-Source: AA0mqf7oCcTapo3snLuXerrnE2oOBGc9OWv1Jk5fr9mABX7v+n97D4A7X0n7KseG3i+1eK5NzLi7Dw==
X-Received: by 2002:adf:f98e:0:b0:242:8198:625e with SMTP id f14-20020adff98e000000b002428198625emr15709236wrr.63.1671039362046;
        Wed, 14 Dec 2022 09:36:02 -0800 (PST)
Received: from ?IPV6:2a02:578:8593:1200:22af:65bc:a1dd:1562? ([2a02:578:8593:1200:22af:65bc:a1dd:1562])
        by smtp.gmail.com with ESMTPSA id k7-20020a056000004700b002425504ae7dsm3442999wrx.80.2022.12.14.09.36.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Dec 2022 09:36:01 -0800 (PST)
Message-ID: <8225cebd-34f1-8737-5011-c5a397a865ca@tessares.net>
Date: Wed, 14 Dec 2022 18:36:01 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH mptcp-next] mptcp: use msk_owned_by_me helper
Content-Language: en-GB
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
References: <20221209045925.20408-1-geliang.tang@suse.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <20221209045925.20408-1-geliang.tang@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang, Mat,

On 09/12/2022 05:59, Geliang Tang wrote:
> The helper msk_owned_by_me() is defined in protocol.h, so use it instead
> of sock_owned_by_me().

Thank you for the patch and the review!

Now in our tree (feat. for net-next) with Mat's RvB tag:

New patches for t/upstream:
- 27e993d2b4f0: mptcp: use msk_owned_by_me helper
- Results: 8ef79d8e4dfb..3f302724c1a3 (export)

Tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20221214T173523

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
