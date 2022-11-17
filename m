Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35FC28BE0
	for <mptcp@lists.linux.dev>; Thu, 17 Nov 2022 18:24:32 +0000 (UTC)
Received: by mail-ej1-f48.google.com with SMTP id f18so7220165ejz.5
        for <mptcp@lists.linux.dev>; Thu, 17 Nov 2022 10:24:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:in-reply-to:from:cc:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QK99coJy/kT0gVrmXLU4DBSf9iCQMfzncKu7JuAccaM=;
        b=rpOhi5HeupY5LMQ10j3ilvOE4OaNyDhZWrfKPX9+ymiXBN5DbmO0TUgtyY2Prh0Gt3
         7I9wJetqwZYSqopht5IQvPl0jVpETLcpX9E3xIHfHYLDaPM+CbAA3F0SsTixU7b4cuQK
         VxIudIncH5cywDbxaMcJDtRFPGYDETeCsbv2O1XO79vbaWWnjZXZoU4+NeAgo4foLYvW
         HjcXlM7d9pILCYLjMPMt1uzzeCgLfV06TNCX1j3QvGCV052FqchjQukHq8vCqENmhYY9
         ZLPZZjGmU+KVOctocriuvZpRrwl38v8EVUDUuQuvQ6sGreUKeBhW1/8usrKFHMNUEMmb
         +RCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:cc:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QK99coJy/kT0gVrmXLU4DBSf9iCQMfzncKu7JuAccaM=;
        b=VrI0+uiDTcBywwHMhDyK1gZgPAM2rlTvMYasi22IslBBNhYihH7Na/avob9MzKVku6
         cVXZThCKCKvnSN1cIPnT6tSnZ2hyoe5uJRLxp4oN53k5XAjl5b6C75vwGJkwfXrG7Z5m
         EyWHt95vTNQwYyBI+U/En+G/b0AvxRzj5yr86Gr5HFJYeCHVuEWuYJJiv9X9Nlm4lLpu
         buiNSOwJzzv90dSxUHr86+jCGXcfFghWiqBQflDadt+aFBWC1jfI4wsd4JzOXZGRfpi8
         hrJc0hhllxAwvEL3h8NnXb0AXq35mMPzxjewGUL8X4pcdgxBzVAf92XgKFhH9H9H/9QL
         Qrqw==
X-Gm-Message-State: ANoB5plwjdBkCSl8orsxQzcrc4nBY3irdhu22pTvOJ6Dfy4A7D2yV57g
	O08KJoUD19ZJjg+/0ywVST3sl+767RWEsSlM
X-Google-Smtp-Source: AA0mqf7oniYSygFAihapxIMh77r2357lq4C4VIYTzYnxOQLi5FH/EzN5SLFxs0jEjDkxlJy+Wy2+Dg==
X-Received: by 2002:a17:906:234a:b0:7ac:e7b1:20c8 with SMTP id m10-20020a170906234a00b007ace7b120c8mr3281073eja.68.1668709471003;
        Thu, 17 Nov 2022 10:24:31 -0800 (PST)
Received: from ?IPV6:2a02:578:8593:1200:c628:990b:1aee:b25? ([2a02:578:8593:1200:c628:990b:1aee:b25])
        by smtp.gmail.com with ESMTPSA id z6-20020a170906668600b007add1c4dadbsm679018ejo.153.2022.11.17.10.24.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Nov 2022 10:24:30 -0800 (PST)
Message-ID: <768ebac9-476b-97af-9f40-a0e68f3af698@tessares.net>
Date: Thu, 17 Nov 2022 19:24:29 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH mptcp-next 0/2] mptcp: more fastopen follow-up
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>
References: <cover.1668531722.git.pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <cover.1668531722.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo,

On 15/11/2022 18:45, Paolo Abeni wrote:
> The last bunch of mptcp fast open follow-up I have planned.
> 
> This aims at reducing the number of unnecessary mptcp_crypto_key_sha()
> invocation, calling such primitive at most once per MPC subflow
> and caching the result as subflow level.
> 
> The first patch should be inserted just before
> 
> "mptcp: implement delayed seq generation for passive fastopen"
> 
> while the 2nd one is a squash-to, still to the above.
> 
> Note that this will cause a trivial conflict in "DO-NOT-MERGE: mptcp:
> use kmalloc on kasan build"

Thank you for the patches and the notes here above!

New patches for t/upstream:
- cccf62e31b88: mptcp: consolidate initial ack seq generation
- b4c09c888e0b: conflict in t/DO-NOT-MERGE-mptcp-use-kmalloc-on-kasan-build
- Results: dc870dc49415..ee79be9e1648 (export)

- 23c22cf366e6: "squashed" patch 2/2 in "mptcp: implement delayed seq
generation for passive fastopen"
- Results: ee79be9e1648..42fdee53dc8e (export)

Tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20221117T182326

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
