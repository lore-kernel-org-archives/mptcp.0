Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9717617CF
	for <mptcp@lists.linux.dev>; Wed, 12 Oct 2022 13:11:48 +0000 (UTC)
Received: by mail-ed1-f47.google.com with SMTP id r14so10055333edc.7
        for <mptcp@lists.linux.dev>; Wed, 12 Oct 2022 06:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:in-reply-to:from:cc:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=k+1LoIP/UXVm1vY43v0oiL48MUza4EmmjGcu5eU/orw=;
        b=Kq4RzI1dmR8JDucAIoQuHmns/llrbLQEck+043XDPZttsX+ZFOrtfDrCl4Xd6KhDKF
         hyP1DUamSiNKXacEaQXiO8+VPnkJLmJAFXZRW4ErbaY+rOS75GCqum4SRapIUAczs4tQ
         p4q50QaeqPFgQxfQsXja3nAisFK3QtQpp6L/zH6I0kyMCshL3ZBikUgpjYTgTPvh+VRZ
         MP44LEcjid4VVWQp5psTuUhLk6bGen2/bsr1aN6oLEtEtUolKArGa/4ONgt1ouE3XSFO
         QFR4R0C4GZevLoCFDgDRElHc7TV0uUDbrYyredbT/vlm4/2Q8aLEVi2LxiM+JmJUa60H
         SlFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:cc:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k+1LoIP/UXVm1vY43v0oiL48MUza4EmmjGcu5eU/orw=;
        b=3qr1zVwScVNnH2bUqfLrnC0qc/pdZ7OY8lwdlp21UlrHkdQzvP6WMnGt1Vjl6SX0FR
         vFZnd7U4NycAbOEpzmRHf7Z6mIxOkd1hXKiL+kOBSwRGrlNTfKJssPNS19D+pMaW+5/M
         04v+NijRL02RSC/9UJPsF1KVMOixScBxvN9RvJyJSDA9IaDCzGss1384xuFkgUnSyZgB
         nh6feD9HH2omJh3kgWA7u/PD2vIwNIr6OtHu5f04V2aQi1mn2WfVjv8G42W5BV1eetIt
         lSrL0YIbpT7FkjgMdZDhN0EceLm76rLFKDVx3LngYkmt+BvzJNwz1Eiw8InPpCrzcN/d
         aW3A==
X-Gm-Message-State: ACrzQf0/y0FQ6ZuDOV90tkoxmn1if846cfpRX1vWn1S6IpWquls+3WmT
	iekAdQnlsvMGbu7shLAbDsq2NA==
X-Google-Smtp-Source: AMsMyM6k/4aLGo2VClD2n3zQXHg/Entha0hXJqYdP9ftxgVFgVRifL9oAW9IQyZcuZEBaEhOR+nAXw==
X-Received: by 2002:a05:6402:3988:b0:44e:6f08:ddfb with SMTP id fk8-20020a056402398800b0044e6f08ddfbmr26991995edb.89.1665580306562;
        Wed, 12 Oct 2022 06:11:46 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:765f:321d:fe2e:6d29? ([2a02:578:8593:1200:765f:321d:fe2e:6d29])
        by smtp.gmail.com with ESMTPSA id l18-20020a1709063d3200b0071cef6c53aesm1296729ejf.0.2022.10.12.06.11.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Oct 2022 06:11:46 -0700 (PDT)
Message-ID: <403b7811-8dc0-3ebf-23de-585d6788b327@tessares.net>
Date: Wed, 12 Oct 2022 15:11:45 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH mptcp-net] mptcp: set msk local address earlier
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>,
 Mat Martineau <mathew.j.martineau@linux.intel.com>
References: <f5e8bfe9878d3948df9328870fc35daec6388e2b.1665431162.git.pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <f5e8bfe9878d3948df9328870fc35daec6388e2b.1665431162.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo, Mat,

On 10/10/2022 21:56, Paolo Abeni wrote:
> The mptcp_pm_nl_get_local_id() code assumes that the msk local address
> is available at that point. For passive sockets, we initialize such
> address at accept() time.
> 
> Depending on the running configuration and the user-space timing, a
> passive MPJ subflow can join the msk socket before accept() completes.
> 
> In such case, the PM assigns a wrong local id to the MPJ subflow
> and later PM netlink operations will end-up touching the wrong/unexpected
> subflow.
> 
> All the above causes sporadic self-tests failures, especially when
> the host is heavy loaded.

Thank you for the patch and the review!

Now in our tree (fix for -net) with Mat's RvB tag, without a typo
reported by 'checkpatch.pl --codespell'[1] and with a fix for the simple
conflict reported by Mat:


New patches for t/upstream-net:
- 82e484041f04: mptcp: set msk local address earlier
- Results: fc5b58f5783a..6cb6fb39b470 (export-net)

New patches for t/upstream:
- 82e484041f04: mptcp: set msk local address earlier
- 345f2d3a78c6: conflict in t/mptcp-add-a-new-sysctl-scheduler
- Results: 01e347f336e0..d99ebc8b27c4 (export)


Tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export-net/20221012T130521
https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20221012T130521


Cheers,
Matt

[1] https://github.com/multipath-tcp/mptcp_net-next/actions/runs/3222012193
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
