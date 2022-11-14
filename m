Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 869776FC1
	for <mptcp@lists.linux.dev>; Mon, 14 Nov 2022 15:49:47 +0000 (UTC)
Received: by mail-ej1-f52.google.com with SMTP id bj12so29284176ejb.13
        for <mptcp@lists.linux.dev>; Mon, 14 Nov 2022 07:49:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q47pCyaowZ+xGFOdtMRv8v9tLZNSqDD/1Ag/TG5t0g4=;
        b=igzjuVty0gqKh8OvfBiHvUSuWAhLwWQDpIzwnKbt8WU/uLa/yhVnYNuD8JJwnalrif
         rPddCb8Rly8tJS4WdzRbKGG5nCOW07rwo9B0bhAMa4AVKn9bUGE3lfhsOULOqDnFoEtz
         l5yuTvD/1iL99u34RaEFw7Or5txUZYzNdwaP0wFs7cyrLHY18ZJs3l9MPaeyIAWjrr1/
         cVHc/wY2w3yKHpyUPagwsG8ncTzIh4cjd2TXawiE1HATRRHWq+HnjRDHTZMkzYJe8H+h
         44LihzBYjL3EDv4qBT/Wtr3oTaJC2M1+DFVnrekfIp52hMG+II/GfRccVRhiGxtP9sk1
         e0/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q47pCyaowZ+xGFOdtMRv8v9tLZNSqDD/1Ag/TG5t0g4=;
        b=4jryCHaRCbceFuT8lABzV5HQSXHWRNFeXSK57eis3L71dVP/DfhEXrzYHUnYi/dATX
         RcVmRqDeSCTBIldAGs/dZFaFHiM+egRlf587czPsoEzw+2T/L3uTRSutTrQddIvcKTnu
         XI6ognrFLFMVIY3MfZ5xYZA1qe+zKXUvYHqdwd0KR2HqvrQNXc/Yhi2iNfUlnnUkjpkU
         b+qDySpVeHnj9YUa1pdvWsCuCypW4W953gL428pOq1rKvKGbwOtF3D9uexrLw1RzBXsW
         AdyhhlHFf0CU86l2Z465Ka21dC5Ew60vkcC7Ej/+OIrBJnIzv6oUQhYiWVKM7r7ZXKQv
         VrsA==
X-Gm-Message-State: ANoB5pkgnKFRbEzdO5TIN2qHGtLuPfJarf4iQioicH4i4xGV/lt/Zsny
	rs3keXu4ASW4aGU+8G9k3WnYo+mrKH/UCQ==
X-Google-Smtp-Source: AA0mqf7RvTJTZcBj04E02AJysP+916ETZjSBGZxeLS9iGbzH1Vt/jj5dDvvde12UNAAZS3sb0XU+JQ==
X-Received: by 2002:a17:906:b2c7:b0:78d:260d:a6e4 with SMTP id cf7-20020a170906b2c700b0078d260da6e4mr10533708ejb.93.1668440985310;
        Mon, 14 Nov 2022 07:49:45 -0800 (PST)
Received: from [10.44.2.26] ([81.246.10.41])
        by smtp.gmail.com with ESMTPSA id u1-20020a1709064ac100b007305d408b3dsm4316403ejt.78.2022.11.14.07.49.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Nov 2022 07:49:44 -0800 (PST)
Message-ID: <58c9bac1-58d9-7d20-f3e4-6b7cebc5efd9@tessares.net>
Date: Mon, 14 Nov 2022 16:49:43 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH mptcp-next 0/3] mptcp: fix checkpatch splats
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
Cc: Dmytro Shytyi <dmytro@shytyi.net>
References: <cover.1668426733.git.pabeni@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <cover.1668426733.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo,

On 14/11/2022 12:54, Paolo Abeni wrote:
> This series addresses a bunch of checkpatch reported issues
> on TFO-related patches
> 
> Paolo Abeni (3):
>   Squash-to: "mptcp: implement delayed seq generation for passive
>     fastopen"
>   Squash-to: "mptcp: implement delayed seq generation for passive
>     fastopen"
>   Squash-to: "selftests: mptcp: mptfo Initiator/Listener"

Thank you for the patches, I didn't fix them when I applied the original
patches as I usually because there were quite a few (and I had to go)
but added that to my TODO list. I can remove that from my TODO list
then, thanks! :)

- a8f5e57ea3bb: "squashed" (with conflicts) patch 1/3 in "mptcp:
implement delayed seq generation for passive fastopen"
- 5dffe8c2719d: "squashed" patch 2/3 in "mptcp: implement delayed seq
generation for passive fastopen"
- 849dac7246e2: conflict in t/mptcp-add-subflow_v-4-6-_send_synack
- 1e76c3150046: "squashed" patch 3/3 in "selftests: mptcp: mptfo
Initiator/Listener"
- Results: 14ca49819653..ff1606d98e1c (export)

Tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20221114T154623

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
