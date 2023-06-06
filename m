Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C927A174D4
	for <mptcp@lists.linux.dev>; Tue,  6 Jun 2023 16:39:27 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-3f6d3f83d0cso64572225e9.2
        for <mptcp@lists.linux.dev>; Tue, 06 Jun 2023 09:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1686069565; x=1688661565;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1ASTAqe22RoAXfX4mOeV4cP1cKQo70/MkSPzBJshwGg=;
        b=WsNqb+tSlCFRD1cfBfFmlN6JP8niFzzOLUBUrSHD5umd2EIKEPp5INRsKUGaOhDp5b
         wBYR0ig/jQDjZhDNa+gdQ143GtaJSSImiFgzanCONug6oa0fp+Zj7uYxsfBUGatqWrJ5
         /6EYxVCl96rXHXe4nIrXAzPvGldNER2ylaAMmh+S4mln95tHEYsbo3SIXG14w7aDEJwK
         5DUWPdBolufdGD66tnCo1El3UiTDF2RJE58wF3VrW6cAR+0kTYh8mdmrtGKlj4Ot+WFl
         A6KSSg0uV40yHMoYkWF9eoCtJAa5qKN8vgV0ydHxjsJH3zx+zGymtNLZtj9FkeRdmteW
         Nl0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686069565; x=1688661565;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1ASTAqe22RoAXfX4mOeV4cP1cKQo70/MkSPzBJshwGg=;
        b=I1ylBBqKx3VphUOU6nFS3FI43ZXzmdMaBWUDXrLD794giS3fuhB0bW9Ho2YVxwN5AT
         HmiIhFpREJbkogl8+pYQvgQ9BvjxBiOjh6UH85TlGn6tzKaMuAZuvHb9cZD/T/pI2U/A
         RMDDozxOUDMsRrlJgveE4nUnkH63qnQzK12ivbaK7RQUEgY38I6VG2yfDsHNRM67guwN
         VeP9ilSzPtBPmSAdeNXqr0MK+51yNuaE0H0HhSSYFqd981mXR86CAMVO2kYcMDs+5vYR
         EP5oHDWX/9qikqQDgFkz1BUYC/73Nd7xmrz7ZzYUTX99rsL+a5kRWAcKbgbbBMoWXyLg
         w3GA==
X-Gm-Message-State: AC+VfDy41W9lRFqfGjVtBzpS6pMZA7Tz6XfRSQY6bYfA31SMeqt023LE
	otvrdfwJ+E1p7h9rQphZXE8BaWqve/wUPEPzYyxIZQ==
X-Google-Smtp-Source: ACHHUZ60vMEGWAEGXunokQTuZUbn6o1NslVOevvI1PrjePtQ/hW/4e8pkIF4GFk+miqwBWjbLq7GZw==
X-Received: by 2002:a1c:4b0b:0:b0:3f7:e58b:5898 with SMTP id y11-20020a1c4b0b000000b003f7e58b5898mr2926657wma.33.1686069565208;
        Tue, 06 Jun 2023 09:39:25 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:7b38:4357:a1cd:69cc? ([2a02:578:8593:1200:7b38:4357:a1cd:69cc])
        by smtp.gmail.com with ESMTPSA id y17-20020a1c4b11000000b003f7298a32ccsm13124183wma.41.2023.06.06.09.39.24
        for <mptcp@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Jun 2023 09:39:24 -0700 (PDT)
Message-ID: <5e6ad809-ab4d-302a-14f9-4d7cecb27027@tessares.net>
Date: Tue, 6 Jun 2023 18:39:24 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: Revert "Merge tag '9p-6.4-for-linus' of
 git://git.kernel.org/pub/scm/linux/kernel/git/ericvh/v9fs": Tests Results
Content-Language: en-GB
To: mptcp@lists.linux.dev
References: <20230606-mptcp-revert-9p-features-v1-1-1d7ea4b3749d@tessares.net>
 <7010ca97-ebd4-db4d-4468-ddab9cfe4593@gmail.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <7010ca97-ebd4-db4d-4468-ddab9cfe4593@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 06/06/2023 18:29, MPTCP CI wrote:> Our CI did some validations and
here is its report:
> 
> - KVM Validation: normal (except selftest_mptcp_join):
>   - Success! ✅:
>   - Task: https://cirrus-ci.com/task/5398812588507136
>   - Summary: https://api.cirrus-ci.com/v1/artifact/task/5398812588507136/summary/summary.txt
> 
> - KVM Validation: debug (except selftest_mptcp_join):
>   - Success! ✅:
>   - Task: https://cirrus-ci.com/task/4695125146730496
>   - Summary: https://api.cirrus-ci.com/v1/artifact/task/4695125146730496/summary/summary.txt
> 
> - KVM Validation: debug (only selftest_mptcp_join):
>   - Success! ✅:
>   - Task: https://cirrus-ci.com/task/5821025053573120
>   - Summary: https://api.cirrus-ci.com/v1/artifact/task/5821025053573120/summary/summary.txt
> 
> - KVM Validation: normal (only selftest_mptcp_join):
>   - Success! ✅:
>   - Task: https://cirrus-ci.com/task/6524712495349760
>   - Summary: https://api.cirrus-ci.com/v1/artifact/task/6524712495349760/summary/summary.txt
> 
> Initiator: Patchew Applier
> Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/f2c91962d1e4

\o/

I just applied this patch (fix for others). I will revert it where there
is a proper fix on 9P side but at least the public CI will send useful
reports now!

New patches for t/upstream-net and t/upstream:
- 5876bd9220ea: Revert "Merge tag '9p-6.4-for-linus' of
git://git.kernel.org/pub/scm/linux/kernel/git/ericvh/v9fs"
- Results: 0c1e7b4e4fa3..89f8cf5b4521 (export-net)
- Results: 69716a8e21e4..ae3926919ae2 (export)

Tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export-net/20230606T163748
https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20230606T163748

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
