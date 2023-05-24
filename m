Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E64A417ABE
	for <mptcp@lists.linux.dev>; Wed, 24 May 2023 12:04:56 +0000 (UTC)
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-30a95ec7744so707029f8f.3
        for <mptcp@lists.linux.dev>; Wed, 24 May 2023 05:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1684929895; x=1687521895;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=K5ufZkSmV1cv3KAPUp+SyPzr49ihTPMR9mBDm5X7BdI=;
        b=KzrenWfMSTIvjm7hXCqfAwRidaHDEEyDrjoJJIv407xzRTnpqR6tp95V6Dx2VJzk03
         DG4QVz8H8RRjAlbuNXqJzYgFkjFnlMkP7iSsqW9W7/hwemphjOv7vHuVoyvd013F/mIz
         djCWuJeAhH9Aq+4GBYXA0juiO7isG1/vQyK+g0ehKrVpl50flENxvQZI47ZoMfwpOCtJ
         Bpu95fU9IxHKwLDwhuATFMlaxQuBsJQQMDvemxSqH+zlqtgcUWH4p+8hqga8+nZ3FHm3
         dPjGPV47KrOFI+XKqzm7UtP4JQLEjj+c31ptfXp1w0DCRseFL3jQOMpQ7ZtJQLkZkIXs
         ahJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684929895; x=1687521895;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K5ufZkSmV1cv3KAPUp+SyPzr49ihTPMR9mBDm5X7BdI=;
        b=W78+koyFyzrt+4ufsLC67tkxHDzc/FvEDJXcRFOif59OFesZ/Odva9/simb2xJtDnb
         026mhiVIq3y5Dn51vy6igp7I+LL4uIybK0pPR/tqS34Yb/YxjSsFwpNCme60T0o7nVg4
         3hUhl7b+Fqv7S52xon47R2RoT3Cj9jEwYjc6a7/NZ+ufUes6mF2sWntCzWWwGkMmgdhO
         3We5Fl4t2wrEpDRkcmc3scPAtwbp/u8aRFOf+elVauB8zlmnp0XBppz+qH+7tR1qkxeU
         aLjll9JR35RTsoKaFdKR8Z7wT6aWCiXNMW2hROQL0N0/uqVHX6H0qxFes1H7Z2/dHNWi
         PebA==
X-Gm-Message-State: AC+VfDyv0Af1WyQx4pI9N7yqYkugK9/KUcpBRosgXWfFcnH99Nlcxh4/
	Yccl+j8xrqthLDEWNuKrT2r0ex3rSWDwY/lOejnZMQ==
X-Google-Smtp-Source: ACHHUZ63BiLLrlYD7WL6lVkLxW+RjVdwK+SAQ/8nuycCV43q48E+6shXb11ZtICjaUi0xM6FoQqNkw==
X-Received: by 2002:a5d:614e:0:b0:309:3aa0:a170 with SMTP id y14-20020a5d614e000000b003093aa0a170mr14720793wrt.41.1684929894737;
        Wed, 24 May 2023 05:04:54 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:735b:1ad0:911b:4361? ([2a02:578:8593:1200:735b:1ad0:911b:4361])
        by smtp.gmail.com with ESMTPSA id l1-20020a05600012c100b0030630de6fbdsm14197474wrx.13.2023.05.24.05.04.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 May 2023 05:04:54 -0700 (PDT)
Message-ID: <477af94a-d47e-d0c2-ba42-285dc5597fa4@tessares.net>
Date: Wed, 24 May 2023 14:04:53 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 mptcp-next 2/6] mptcp: introduce MPTCP_FULL_INFO
 getsockopt
Content-Language: en-GB
To: Florian Westphal <fw@strlen.de>, Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
References: <cover.1684863309.git.pabeni@redhat.com>
 <67b6345847e8f23fadaf22c14609d4d387eed952.1684863309.git.pabeni@redhat.com>
 <ZG0FL9XM-MFgfyQ-@strlen.de>
 <62d7d915a3536e9bf37770952838308d8f41ad8b.camel@redhat.com>
 <20230524095653.GD17561@breakpoint.cc>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <20230524095653.GD17561@breakpoint.cc>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Florian, Paolo,

On 24/05/2023 11:56, Florian Westphal wrote:
> Paolo Abeni <pabeni@redhat.com> wrote:
>> Isn't num_subflows_copied always implied? == min(num_subflows_user,
>> num_subflows_kern).
> 
> Right, userspace can infer the correct number, i.e.
> num_subflows_kern would always be the "actual" used number.
> 
> num_subflows_user > num_subflows_kern:
> 
> Userspace can safely access "num_subflows_kern" entries
> (contain no garbage).
> 
> num_subflows_user < num_subflows_kern:
> Userspace can safely access "num_subflows_user" entries
> (info arrays did not have enough space for all subflows).
> 
> I added the "num_subflows_copied" for ease-of-use on userspace
> side but I agree that its not required and userspace has
> enough info to figure out which upper cap to use.

If I understand properly, it means that num_subflows_user and _kern will
only be used to know the size of the arrays:

- num_subflows_user: size of the arrays in the buffer
- num_subflows_kern: what has been written by the kernel, max _user

I think it is still important to have somewhere a num_subflows field to
know how many subflows are attached to an MPTCP connection (also for the
userspace to know if it missed some info because it gave a too small
buffer).

"struct mptcp_info" has a "subflows" field but only counting the
additional subflows so you never know the actual number of subflows :)

Or we add a num_subflows in "struct mptcp_info"?

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
