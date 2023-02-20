Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 641122FAF
	for <mptcp@lists.linux.dev>; Mon, 20 Feb 2023 11:16:13 +0000 (UTC)
Received: by mail-ed1-f44.google.com with SMTP id ck15so4457280edb.0
        for <mptcp@lists.linux.dev>; Mon, 20 Feb 2023 03:16:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8PoFbTAadJ+43wOAm2K5cpVEABJmL3iRNCRdHHCzefw=;
        b=Dir9WT9k1Y/bxVD3+brb5gZm9/yj5Z/1q2L3Bu6uaXxvchM7h3yUE1iH3cT/K6biqj
         UDwCKhvUiWv+mpDY8N33akppy9NqEXu6SGpnZ/bgznVTMld4b5DHDInRgx0KbMyG9dmP
         PpeOQKTF7sgSQuZ7zvJzQwcCLsGz3xZzTJEpaJd4NwnFQOa4Zrhl84u8+PcPr2jEK3gB
         Qk8i9Hg/PPqU5AqZ/aMunOq8Z0K+Z7nEDZEUd7ZkqA/2b820PjYPwVO0aNly5zsKaTBG
         KE7Gw8HcaqAhhRYkD+mMegyKv9QL7Py719GvjEwMeAxXc9JvX6aMmlcVrUhcmph1Q3tc
         OP4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8PoFbTAadJ+43wOAm2K5cpVEABJmL3iRNCRdHHCzefw=;
        b=UbMUSRchIf/1KiyfADEg0iRrAIFafuz5BDwPKtHjt7+z61upd7Gmx/6yrvvjHcUP5J
         lwx8/YTmiJTn9nr+5jTitPR8D45mN5SDXLaxfMMjR6GgTk3SaKP7pnshj/SBTtmtBtLq
         82yz2A564FLs71Wv237wjgrLdVQIVwAalTkpK41yMG5+X5RGI2vlthgZqVu6DROmT3Ao
         Ug2bwUJ5YB6hnVg24dMbFPGJlY95MGv3sDZpgzBTXmEfnffTHPASdXXuGDUT/ZKjTbbg
         rakMzyLU+DGwBysguWKi9BFTQEDNBDqWSa3wr2d11UffzPTf7iCbQPsOUchHOqwZKrZF
         Fbyw==
X-Gm-Message-State: AO0yUKXVKfnMFuGSnyu6Sk3e677VB0DL3J6VzCpf1jJ6AYCvN9E1VAo4
	c/FReB1eOBWjFP6YTG/HpYdAdQ==
X-Google-Smtp-Source: AK7set+HYw4RCAHeS6v6rYL/JuG8/dMUwKnuAvdtPtHONyOn0eft5/2bJ7+F0yVn7fexBYxOUXrzWw==
X-Received: by 2002:a17:907:2da2:b0:889:33ca:70c6 with SMTP id gt34-20020a1709072da200b0088933ca70c6mr14374470ejc.2.1676891771408;
        Mon, 20 Feb 2023 03:16:11 -0800 (PST)
Received: from [10.44.2.5] ([81.246.10.41])
        by smtp.gmail.com with ESMTPSA id w10-20020a170906968a00b008b17de9d1f2sm4787395ejx.15.2023.02.20.03.16.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Feb 2023 03:16:11 -0800 (PST)
Message-ID: <ac85e6d0-c147-6659-ebb6-85b79d7fa797@tessares.net>
Date: Mon, 20 Feb 2023 12:16:10 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCHv2 bpf-next] selftests/bpf: run mptcp in a dedicated netns
Content-Language: en-GB
To: Hangbin Liu <liuhangbin@gmail.com>, netdev@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 bpf@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
 "David S . Miller" <davem@davemloft.net>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>,
 KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
 Mykola Lysenko <mykolal@fb.com>, Felix Maurer <fmaurer@redhat.com>,
 mptcp@lists.linux.dev
References: <20230219070124.3900561-1-liuhangbin@gmail.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <20230219070124.3900561-1-liuhangbin@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Hangbin,

On 19/02/2023 08:01, Hangbin Liu wrote:
> The current mptcp test is run in init netns. If the user or default
> system config disabled mptcp, the test will fail. Let's run the mptcp
> test in a dedicated netns to avoid none kernel default mptcp setting.
> 
> Suggested-by: Martin KaFai Lau <martin.lau@linux.dev>
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> ---
> v2: remove unneed close_cgroup_fd goto label.

Thank you for the update!

Acked-by: Matthieu Baerts <matthieu.baerts@tessares.net>

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
