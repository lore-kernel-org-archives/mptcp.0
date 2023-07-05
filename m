Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEC10137F
	for <mptcp@lists.linux.dev>; Wed,  5 Jul 2023 08:02:20 +0000 (UTC)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-991da766865so758678066b.0
        for <mptcp@lists.linux.dev>; Wed, 05 Jul 2023 01:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1688544138; x=1691136138;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nfSvIDkkZtF2ergGgAXX6Gk1rvSywBTXAtkwxInzIxA=;
        b=kjk2SUrYfC15TY/22KbFTzZ70bs5WY3WlDsii8TBCBE8iHmPN0BgHGmU9QAxRlB31B
         paRqQAsGHqi7LAjRYB6niA37MydfVqYgrmK8mRXGY/DbXi/ZVKxjI0Gx7FxutUTMtQAr
         hCpYj5iGl+eFaJHKTm8ipcwnfOokJ5wF2eHAl3fFSz4Ufa6sjXEaHzoAao1SqKKQ2NXY
         xT6aSQatPMUws+0Cwpv0LxTqKKNyAuxhX7tvj9pjAtX3Q3/a5yswljpgPqgUWzBzSSa5
         ZD9f0KzzeR+RYLvUCco7mvLdv2zhScJx+D6mjvPjCKkfzJchDVYZ2rANyvmnsbTMJJg8
         8Q7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688544138; x=1691136138;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nfSvIDkkZtF2ergGgAXX6Gk1rvSywBTXAtkwxInzIxA=;
        b=bDr9F0P9C0lRKttwa5lLuVdP+uCmCPzWcLSDYgjT9ZMfHQMzz3e6mQCcUa2huQclJQ
         nPjcM2BJs/PrzvYLaBgu9JFPujCmEFvI3IvIJA2+sLffa8E/PNkdcEEthi+qmF3gtztH
         y6AaoY4Njc5n7ZUOSXQeq7cT3YtT59Ldh7HY4F0ag4DdyWJEpMlNbDEtljUP+KEganW1
         3yBvJvNrSLTacwaJUhz/OiUQ5Kake7PqTrpYx5WBSri5TokG0fBQcugtze/puKTKRBVy
         f64YD95dEAznw1DVGvn5ntdabfOak2iJNTq0ZLmNz46g/ZZ1Km0hej4XpZcnWUBfGJaI
         mICg==
X-Gm-Message-State: ABy/qLY6chjw2bYgE8s+EOIegVOJ6Lcg0sxrB0iXozXSNwMrPRkp9COm
	gECvKc73xG8nYa12SDdH9MiHlAL4YZxvhzVa67oMDA==
X-Google-Smtp-Source: APBJJlEMuEDdVgLZ3upGr7JccUY34Ljbt7UmwKmoztsUhQ57YI7dbiRG9CfsQnJU6RtsTXRMNTtTYQ==
X-Received: by 2002:a17:906:c458:b0:989:3e0d:89fb with SMTP id ck24-20020a170906c45800b009893e0d89fbmr10820583ejb.45.1688544138482;
        Wed, 05 Jul 2023 01:02:18 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:e210:4cad:4e78:3692? ([2a02:578:8593:1200:e210:4cad:4e78:3692])
        by smtp.gmail.com with ESMTPSA id jo4-20020a170906f6c400b00992c92af6easm7428105ejb.161.2023.07.05.01.02.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jul 2023 01:02:18 -0700 (PDT)
Message-ID: <1d0d9a74-d8ad-e329-7b85-4472e1f95acc@tessares.net>
Date: Wed, 5 Jul 2023 10:02:17 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH mptcp-next v4 0/7] BPF 'force to MPTCP'
Content-Language: en-GB
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
References: <cover.1688540074.git.geliang.tang@suse.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <cover.1688540074.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 05/07/2023 08:56, Geliang Tang wrote:
> v4:
>  - add hooks in __sock_create().

Thank you for this new version!

I had a very quick look: it seems nice!

Personally, I don't know the BPF environment well enough to give a good
review and judge if the direction you took is the good one. Then, I
wonder if it would not be better to rebase this series on top of
bpf-next and send a first (RFC?) version to BPF maintainers to get some
feedbacks (with MPTCP list in CC of course). WDYT?

In this case, it will be important to mention in the cover-letter what
is the goal (e.g. create a different socket and the main use-case is
MPTCP) and why it is interesting to do that with BPF (see my previous
email [1] -- I also updated the ticket [2]). Don't hesitate to add a
link to the v3 explaining what was the limitations.
I can help reviewing the new cover-letter if needed.

[1]
https://lore.kernel.org/mptcp/7d4ccbc9-17b6-28cf-9046-c7f81401ee60@tessares.net/
[2] https://github.com/multipath-tcp/mptcp_net-next/issues/79

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
