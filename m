Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE4E82105
	for <mptcp@lists.linux.dev>; Fri, 19 May 2023 08:03:46 +0000 (UTC)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-96f53c06babso170029966b.3
        for <mptcp@lists.linux.dev>; Fri, 19 May 2023 01:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1684483424; x=1687075424;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5Kq1KGM75ZTw21yQPIXRnjp+jexS5DH5FR0ZKnh4DmI=;
        b=XWboN4PjdFmvnMsfDdyAbXaQiuCB9PFa7ZRKAws1bWExP8Ed7taKDG/JlQHyk4KfRE
         SaKR4jA/lp72KMREOVO7TL8GS9Q3eMP8d5llXgxU1o2vPyy8InnX2BRuav9cm8gAJbJ0
         Zb3pPuBKebNFH9AKWKCCxDUbmwgbMzZ3xOItCxeImZfV5KMn5uoIaa9xy6xVx1bExo3i
         v3gwM8VSMo8Xa9eQ+fvHjFBDnzZSnh+b/SOhj9lmZMMjjMWw5oNP4OsD91LRNemATqQ+
         LbRCOgSsXifssZryV4faMVYcOkW/p1c0DZW0QK2Csmk8aEXUu45taOwd82kqqRIxcMz2
         hPgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684483424; x=1687075424;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5Kq1KGM75ZTw21yQPIXRnjp+jexS5DH5FR0ZKnh4DmI=;
        b=DyTP76HY47wuUCn/Vrj0O2qJ7Iuj3n60csbVnkMrgDt23g5Kebeig9MWUBwtNwCFmY
         CJoUQbdy5019FiuF5rlcZVzS8JVKkMPg+L3tM0ngkuwozz64e0xvDPbxONCabm3+j0dY
         TNltTkWKpYZ8yf6YrgaLXmYLJhwaKENNJGIPuRixWjz0BrJwVvdU5/P3OdJcawP58ZO/
         LdSyKDOpl8abmjiagOo4TO2f8kIgbOt2nprgx7wn3Zqoo4onanAa7MiGsugZumzDeRFh
         sOl+bnNAPcS5+sGp9EUXsacwQd8HAoYSXhVCnmc6xe3oUYiRwRGaJu5AzKU/PrHqH4oy
         WyfQ==
X-Gm-Message-State: AC+VfDxMFr0xaXz7S376+0z0Nk8OvgtE1S5pFC8FH7FpPRGrt7g6+hFO
	XAhK7earMM5Sh8lFYHZc1Vbngw==
X-Google-Smtp-Source: ACHHUZ4zXxHIdVWrDtz6l5t2hMt3QaMSdY3q2mG/jZ6l6gepWLncRLOGMy/hJH/GEnhU3FP9cUPugQ==
X-Received: by 2002:a17:907:d86:b0:93b:5f2:36c with SMTP id go6-20020a1709070d8600b0093b05f2036cmr1085217ejc.61.1684483424437;
        Fri, 19 May 2023 01:03:44 -0700 (PDT)
Received: from [10.44.2.5] ([81.246.10.41])
        by smtp.gmail.com with ESMTPSA id gv24-20020a1709072bd800b00965a4350411sm1962677ejc.9.2023.05.19.01.03.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 May 2023 01:03:44 -0700 (PDT)
Message-ID: <8c2e1871-8343-6276-6276-de5df7f4656f@tessares.net>
Date: Fri, 19 May 2023 10:03:43 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: mptcp: fix active subflow finalization.: Build Failure
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
References: <41d7df9d8669b5fbfe70cd5551efc9245007ae6c.1684427027.git.pabeni@redhat.com>
 <9cdc6ccf-3529-8fad-5a49-4c1fd8d6feeb@gmail.com>
 <d01c8817dd76a6d427a72a752eafb2027969fd38.camel@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <d01c8817dd76a6d427a72a752eafb2027969fd38.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo,

On 19/05/2023 09:03, Paolo Abeni wrote:
> On Thu, 2023-05-18 at 17:31 +0000, MPTCP CI wrote:
>> Hi Paolo,
>>
>> Thank you for your modifications, that's great!
>>
>> But sadly, our CI spotted some issues with it when trying to build it.
>>
>> You can find more details there:
>>
>>   https://patchwork.kernel.org/project/mptcp/patch/41d7df9d8669b5fbfe70cd5551efc9245007ae6c.1684427027.git.pabeni@redhat.com/
>>   https://github.com/multipath-tcp/mptcp_net-next/actions/runs/5016483061
> 
> The failures are caused by the pre-existing sparse warning around
> mptcp_sk_clone(), that this series rename as mptcp_sk_clone_init(). I
> guess there is some CI rule to waive the error for the old/previous
> function name?!? Any idea to make it generic?

Thank you for having checked!

I just modified the script to whitelist the new warning:

https://github.com/multipath-tcp/mptcp-upstream-validate-export-action/commit/a9d24567

All green now:

https://github.com/multipath-tcp/mptcp_net-next/actions/runs/5016483061/jobs/9005030178

I don't think we need to make it generic. I guess we will rarely rename
the function name and/or move it elsewhere, no?

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
