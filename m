Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58E6F2F24
	for <mptcp@lists.linux.dev>; Tue,  8 Feb 2022 07:47:41 +0000 (UTC)
Received: by mail-ej1-f53.google.com with SMTP id a8so49654336ejc.8
        for <mptcp@lists.linux.dev>; Mon, 07 Feb 2022 23:47:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=wgU7z5ZU4FPxga2/TFj9KChn00b7D8piSamC7DkcNB4=;
        b=4bm5XIu3Oug6AJC/j6ifeaDFW5uFXZhEFTYVERheEFoe4ppWcitKFXEIAZkeuVHLOU
         fhzbUgAaEnPj9KXOGEbYPoLD0DDDJRCnWIo4smtsHkwHsgNziGQSxShurTzJLDjDBQDI
         JdWhJhgog5tctQ9KolY/pFzDYHPntwEsKuyKdf5W2as7QIxbZyaQG+zZNplL7AEnD05L
         SAJlneJP3W9r5SJE7MyWt+J9cO3LFk8bG8BqA6s8P5w3mnNVZed5XjLG4Rsch7C7zkhI
         Olj/NVjItUAmskq0qFtxAeAH9COWV6KvxIykhYxWE5jo7rbpxtvtghIv4FPuZZpcUwNU
         0yRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=wgU7z5ZU4FPxga2/TFj9KChn00b7D8piSamC7DkcNB4=;
        b=3xLSFNBtBxHjBnn2J0HbOvQt6DFfX6IhVpXDUKW/ivJ+P397eW9NnW2G6XWaT4uIU8
         iJqP7X7zJW/ryTnuRHx5nKPSSqH5IjmfOdboO9aAVKoSMa2Re75w+DXdZTq808ZoW3zJ
         Qk38xofd/h72ILVdJM96kUxF1gg43b4n5aH6xiPD7HlHXdZUgdg2Y5ecLvDmqOYL6J9k
         SL+HV8QMsEu3Jk4vCXQs/Ni7oXBYTMGlN0F60bnkImPDlFhENQZ1m9JUF4NQG7YIMFj+
         Up12G2vbiQVEieTbwYmm+fifWXN+1zRTIqLDOsjuH+OgABQpnzLQSgIZq3HdSW3Q4DYv
         tOvQ==
X-Gm-Message-State: AOAM533nYBeMctjwKVtcNCZbnN9GbUeTooSx0/eWYLXtj+dVjl/sa3ZR
	ZzbIjXEiDgNOoHM1gx5peWUMUQ6VqmaT1CVXEtQ=
X-Google-Smtp-Source: ABdhPJxhkBKp8TpAS0W1Uh7paeRU4/j3MLOdLsn/BABj2OIVCrpaiNmrqZH5vbqrC+/IPQuZKv4hpg==
X-Received: by 2002:a17:906:4bc6:: with SMTP id x6mr2646024ejv.161.1644306459178;
        Mon, 07 Feb 2022 23:47:39 -0800 (PST)
Received: from ?IPV6:2a02:578:8593:1200:ba0f:5a93:d93e:ce85? ([2a02:578:8593:1200:ba0f:5a93:d93e:ce85])
        by smtp.gmail.com with ESMTPSA id gv34sm4441127ejc.125.2022.02.07.23.47.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Feb 2022 23:47:38 -0800 (PST)
Message-ID: <a2f5b55d-a4ab-c274-a27c-ec1461f6f8d3@tessares.net>
Date: Tue, 8 Feb 2022 08:47:38 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH mptcp-net] mptcp: fix race in overlapping signal events
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
References: <c5d17a37b8ad315e72dd8551e148017a66987f7f.1644266387.git.pabeni@redhat.com>
 <f6abaf441e13c2f4cb6929605f67f9c0c7417e44.camel@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <f6abaf441e13c2f4cb6929605f67f9c0c7417e44.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo,

On 07/02/2022 21:53, Paolo Abeni wrote:
> On Mon, 2022-02-07 at 21:39 +0100, Paolo Abeni wrote:
>> After commit a88c9e496937 ("mptcp: do not block subflows
>> creation on errors"), if a signal address races with a failing
>> subflow creation, the subflow creation failure control path
>> can trigger the selection of the next address to be announced
>> while the current announced is still pending.
>>
>> The above will cause the unintended suppression of the ADD_ADDR
>> announce.
>>
>> Fix the issue skipping the to-be-suppressed announce before it
>> will mark an endpoint as already used. The relevant announce
>> will be triggered again when the current one will complete.
>>
>> Fixes: a88c9e496937 ("mptcp: do not block subflows creation on errors")
>> Signed-off-by: Paolo Abeni <pabeni@redhat.com>

Thank you for looking at that!

> Please keep this on-hold a little, it need a little more testing,

I still have the same issue with this patch. Do not hesitate if you need
me to provide you more debug info.

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
