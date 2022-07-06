Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67054538E
	for <mptcp@lists.linux.dev>; Wed,  6 Jul 2022 16:57:00 +0000 (UTC)
Received: by mail-ed1-f42.google.com with SMTP id y8so14300912eda.3
        for <mptcp@lists.linux.dev>; Wed, 06 Jul 2022 09:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:cc:in-reply-to:content-transfer-encoding;
        bh=+/IDqvNL2I3Nb4Q4sd6HIBc4e+AHol9eyRwzLTmJcCU=;
        b=gESQvR1bV7G2wbCoJ2RW2lvz/489tTd5U/5W95G7VK67WNC6PdK1p8pxDm83n35LV1
         dg9XBkJV8fW1aGek4TOF9JGXbARMgxaNFip0eSMQtkGYwX3Yu73iQ3+DRj60SfSB+JC8
         vU7wA0ZqCKJ1mIK7cApP8NoH52hsxHd1PLfb6Njw3PQmP6tzVoielihfFAPuRV6sFwRM
         BM3AYqmg0hwaaY35dESMWuebb7G2ku+K1tdLFz/U6YY1mk5bU+pU1UKxn5jtL5L4IYV0
         aCuSqWfRwJhCe20RkrjkzLLt+hb4Lgp+q9KBwbRTFi/vXDCSC/4vwgmtP01AFePoAFvs
         if2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:cc:in-reply-to
         :content-transfer-encoding;
        bh=+/IDqvNL2I3Nb4Q4sd6HIBc4e+AHol9eyRwzLTmJcCU=;
        b=B7RMZti80oH/lY4SlyaGOIRz1safHzrZ9C0v7cLDwt9k+beUxva9Bf38J80DFF8ahu
         eojKodzu1owRcqyr2pW/Rt3GgXGilNrJrlwI6XReDEf4ZJlq/azWuByGgtDLotIrKbTg
         pktap5oZsXt6CIRxXtKQU84cRHZKPrOl8iRuqNaXDNXAz+AIPr5Ott6lQnrwLtaeLuF2
         D5eWynkMfaBxd8cHvlWm5zxQ6G4Rchtanp/8Efec/bgEzgDYdh1T99zu5S/Q7K7N71Uv
         iSQWPqRp9/5WTjJYVrvI/C+BxvIh8v4Dyq5VW6ftss6LnHsPf3YWQeYpKhoJQLyUFZKo
         37Pw==
X-Gm-Message-State: AJIora/nLt9I7vmxLnnyp7HFM4+g6XEYCi19JDyUEWr98GyUZLlpvine
	ZBRitBAnEFps7Aik43dfAYfBkQ==
X-Google-Smtp-Source: AGRyM1tdH9ZDEcIqTfIA2/1OEpvsZvdkIKQr3zE4LhjZHQUrtNYQh6K3QR4xZa73kLaUUucr3ANbWg==
X-Received: by 2002:a05:6402:355:b0:43a:4f13:56d2 with SMTP id r21-20020a056402035500b0043a4f1356d2mr24327015edw.312.1657126619239;
        Wed, 06 Jul 2022 09:56:59 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:c688:fc49:57d7:6b4c? ([2a02:578:8593:1200:c688:fc49:57d7:6b4c])
        by smtp.gmail.com with ESMTPSA id b21-20020aa7cd15000000b0043a6c538047sm6886552edw.70.2022.07.06.09.56.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Jul 2022 09:56:58 -0700 (PDT)
Message-ID: <05928f87-fe08-2be9-0677-a9611138a088@tessares.net>
Date: Wed, 6 Jul 2022 18:56:58 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH mptcp-net] mptcp: fix subflow traveral at disconnect time
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>,
 Mat Martineau <mathew.j.martineau@linux.intel.com>
References: <2c5147569717a1c879b291230d460e8e85992878.1657106043.git.pabeni@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev
In-Reply-To: <2c5147569717a1c879b291230d460e8e85992878.1657106043.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo,

On 06/07/2022 13:18, Paolo Abeni wrote:
> At disconnect time the MPTCP protocol traverse the subflows
> list closing each of them. In some circumstances - MPJ subflow,
> passive MPTCP socket, the latter operation can remove the
> subflow from the list, invalidating the current iterator.
> 
> Address the issue using the safe list traversing helper
> variant.
> 
> Reported-by: van fantasy <g1042620637@gmail.com>
> Fixes: b29fcfb54cd7 ("mptcp: full disconnect implementation")
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> I think this should go soon upstream, sending here to trigger the CI
> 
> A pktdrill test will follow.

Because the CI report was not fully green, I ran the full tests suite on
my side (with and without a debug kernel) and I didn't spot any issues.

Tested-by: Matthieu Baerts <matthieu.baerts@tessares.net>

The patch looks good to me. If we can wait a bit, I guess it is better
to wait for Mat to review it. But I don't mind applying now if needed.


Also, I think we should probably add a new macro on net-next:

  mptcp_for_each_subflow_safe(msk, subflow, tmp)

WDYT?

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
