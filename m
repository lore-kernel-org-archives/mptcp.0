Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C13217757
	for <mptcp@lists.linux.dev>; Fri,  9 Jun 2023 15:37:45 +0000 (UTC)
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-973f78329e3so326361366b.3
        for <mptcp@lists.linux.dev>; Fri, 09 Jun 2023 08:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1686325063; x=1688917063;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=N990tCd/4YhiHbYBD6FKQIwfzuYfI4T/5ovWjiv8GGo=;
        b=k8Rf+2+wkrLrjLZUK80HXid3yUB2j1Xe7Hc9aXxrMrZwRgjynk4vSZv7E4Q11sImBr
         2eUd2KD4F358XFK6epxPCk+6iPNlwESH4Db5+y74pGyLe6A//RRPA7dX4q0eMgIZMNj8
         mmRM5zUlJkgKnjZ5eVFoz3wCbnZzilzqQxTwQhhPIIm6mPeLKxhPPHE72LYRlVBkkt+E
         HVd9x66dEptY37hRKpTdCLwx2frgB9H6pb9ptggAuBkWJgGQU3LkfpivMDP+UbK0+i3a
         OmTat4BReNIltJIqi0EQOLBqVM56dAHkAMZLstDRTGoVj+bsgXTPuWemfnUDYV6aMI9O
         PsZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686325063; x=1688917063;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N990tCd/4YhiHbYBD6FKQIwfzuYfI4T/5ovWjiv8GGo=;
        b=SGvP96BQkgpNrfoUXfRJnl+GRWVmpYOC25QC67P+YwVJE13PafQOtTvZpGPr+mpkCD
         0H+TDZEnLBQWCd1hrInjll215dPQk99k/O1mOPalEwDMX64sIznwUM5I3LqJO0Z7aEJF
         lh5cDPtBcDizKztflh8+wwIHlFoAZH35cehAVMbOuC9pCaZ4jdOIE0AY7s7x+8KItFKo
         Y1uT/g56eXNCMBRHLc/08rmhULHIBMqbNRbW0W/tgZFtG/r1biusEMsjcbiuAf9FbCXI
         yX/pMsj5rTX244v28px4Z3VJWkatWOF+YZLHQA5yhIyYfxJgIT/xBf+8GItm8YiOO5+F
         nxng==
X-Gm-Message-State: AC+VfDzauKQ93j/dbVx+iJX1qMSXmjQgbbrEaoRGmND5NFR7oZLsx8py
	kqUYmhDmYiBcHdmHKt2ti+JjObmojTA1UqQaLumKmw==
X-Google-Smtp-Source: ACHHUZ5Xdu31Sk0rpm9UzfqBbdzst3l6U4t5gTgQViGR76rivJIZzT2tV0c6+rzrfsRolZItCz4hAg==
X-Received: by 2002:a17:907:9806:b0:94f:5847:8ac with SMTP id ji6-20020a170907980600b0094f584708acmr2512524ejc.51.1686325063492;
        Fri, 09 Jun 2023 08:37:43 -0700 (PDT)
Received: from [10.44.2.5] ([81.246.10.41])
        by smtp.gmail.com with ESMTPSA id jp20-20020a170906f75400b0096f5781205fsm1437478ejb.165.2023.06.09.08.37.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Jun 2023 08:37:43 -0700 (PDT)
Message-ID: <bfae8085-6fdd-fdcf-5af9-d7db3c7b0d76@tessares.net>
Date: Fri, 9 Jun 2023 17:37:42 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH mptcp-net 1/2] mptcp: fix possible list corruption on
 passive MPJ
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
References: <f88902bdf5168d86a858575a95882e3fbbadf556.1686155270.git.pabeni@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <f88902bdf5168d86a858575a95882e3fbbadf556.1686155270.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo,

On 07/06/2023 18:33, Paolo Abeni wrote:
> At passive MPJ time, if the msk socket lock is held by the user,
> the new subflow is appended to the msk->join_list under the msk
> data lock.
> 
> In mptcp_release_cb()/__mptcp_flush_join_list(), the subflows in
> that list are moved from the join_list into the conn_list under the
> msk socket lock.
> 
> Append and removal could race, possibly corrupting such list.
> Address the issue splicing the join list into a temporary one while
> still under the msk data lock.
> 
> Found by code inspection, the race itself should be almost impossible
> to trigger in practice.
> 
> Fixes: 3e5014909b56 ("mptcp: cleanup MPJ subflow list handling")
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>

Thank you for this patch.

I just applied this one (not 2/2 as discussed) in our tree (fixes for -net):

New patches for t/upstream-net and t/upstream:
- 3212850f0794: mptcp: fix possible list corruption on passive MPJ
- Results: a830ee097367..c633acbd57f3 (export-net)
- Results: f3033b20c7e6..31917aaa7463 (export)

Tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export-net/20230609T153552
https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20230609T153552

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
