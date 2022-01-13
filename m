Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A42A6173
	for <mptcp@lists.linux.dev>; Thu, 13 Jan 2022 10:21:53 +0000 (UTC)
Received: by mail-wr1-f49.google.com with SMTP id x4so9167301wru.7
        for <mptcp@lists.linux.dev>; Thu, 13 Jan 2022 02:21:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=CoHBa2OALZTGgXf6fa0qu1HzLs/FaHa8z6Hu6RTi4+0=;
        b=07kvDc79ZsEr+FwbJ14+M0uYLqecVeL4c7EBWtulUgug9vhDcMoWVDL+/tD3rfP/0p
         DWFYEWmFpyCO0Z24jUd4B8Gdcz+ia2zm8lJ2CccmJyC+GmflKsXPZzPTMDV6hEzG1lOY
         hAh27lwSuuA9ZxxLaDkZ/gM4CA37b8bT2Ljz6pHSlMGm3PyDt91qgGkBs7AtnfwkMWxj
         vGpAe9Ornb8d5RxrPunVjlLhs337t3Jwv4Im5YAU2K8f04opuQNapoG8yxpgGVMtQCUB
         R1eSTT/gO7EUiSzAdHl84fwN57hXgM6D22JJY+I5b9NWut2Vedd/PAPxteNHiLlQcCHa
         3DyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=CoHBa2OALZTGgXf6fa0qu1HzLs/FaHa8z6Hu6RTi4+0=;
        b=CortIdoIUTxRmuTVSxlQmaJ4deHRnKBHvbC1cdaJUx2th76QjA6z0Bxt6+TWb7Kb90
         5Bw95Ewb41HlLpUwUUpF/2z67kCl8yaV6m52yGLDT/hCnq8cIzhgJAoTQf/YJIJzduVh
         FiM4uPALnP0fyeBaJ4TEjaGKVrOL1kya4cgE3uFRpaSRqrqYI5c8qAe+46QlgMzoCTKU
         pNS89M3CzmCJH5QdOh2pA31Bq9XryEtDz4GoGLzEjm68D/wdDXzGwEqNX1BNSbRzJzcM
         QIf8Umq32BLQShelsRJFL9abWlhNb2XdxnWgKpr/yiH7sUNql830ahigVb7CAVsOXofJ
         oWmA==
X-Gm-Message-State: AOAM530JtHhX6WlvyTIjSxniGe70Pbp40fkFgjZyIs4QnREhpFgcb1MM
	0EYA6HslVgJjqrzANmzZwBUhww==
X-Google-Smtp-Source: ABdhPJxigJsl9Uo96LYRRlJDFwcVU9H9EhHG6/z57uEmHAmjSoKlG3UBbfXst54DEkeS59gXWNX0gw==
X-Received: by 2002:adf:fec9:: with SMTP id q9mr3368671wrs.72.1642069311646;
        Thu, 13 Jan 2022 02:21:51 -0800 (PST)
Received: from [10.44.2.26] (84-199-106-91.ifiber.telenet-ops.be. [84.199.106.91])
        by smtp.gmail.com with ESMTPSA id 1sm2711609wrb.13.2022.01.13.02.21.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jan 2022 02:21:51 -0800 (PST)
Message-ID: <d27db41b-a6f9-65a2-b3e6-6940e0d9c900@tessares.net>
Date: Thu, 13 Jan 2022 11:21:50 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH mptcp-net] mptcp: fix msk traversal in
 mptcp_nl_cmd_set_flags()
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>,
 Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
References: <a73b5ff4e26150d7db36a639ab671cb66c566e20.1641902813.git.pabeni@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <a73b5ff4e26150d7db36a639ab671cb66c566e20.1641902813.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo, Mat,

On 11/01/2022 13:07, Paolo Abeni wrote:
> The MPTCP endpoint list is under RCU protection, guarded by the
> pernet spinlock. mptcp_nl_cmd_set_flags() traverses the list
> without acquiring the spin-lock nor under the RCU critical section.
> 
> This change addresses the issue performing the lookup and the endpoint
> update under the pernet spinlock.

Thank you for the patch and the review!

Now in our tree (fixes for -net) with Mat's RvB tag:

- 41fdb59d2a03: mptcp: fix msk traversal in mptcp_nl_cmd_set_flags()
- Results: b755fcc13413..6eab36365cea

Builds and tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20220113T102140
https://github.com/multipath-tcp/mptcp_net-next/actions/workflows/build-validation.yml?query=branch:export

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
