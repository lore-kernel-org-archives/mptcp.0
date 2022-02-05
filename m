Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DB362F23
	for <mptcp@lists.linux.dev>; Sat,  5 Feb 2022 10:32:58 +0000 (UTC)
Received: by mail-ej1-f46.google.com with SMTP id og43so3023347ejc.0
        for <mptcp@lists.linux.dev>; Sat, 05 Feb 2022 02:32:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:cc:from:in-reply-to:content-transfer-encoding;
        bh=vtoxpIcNGK63LIMND+1ajO7DUeMMflo7muaHuvkGY4U=;
        b=zaU3/Go6EC4fLME0WbG1ATjf3ZtvHksjwyBF8HOIG2+IY95uDKbajL3ou0N2jQZB7U
         baP8epVjvC2q3YqaqCoPZ8IYHRBNSQ053kX4oi3LNkyx6Qj1T+FP4uzKEkMMo5+xaXhV
         KRSD3eTy0OC5Xk/b3DHcGAyUPpXUbWzJZ6mJgPbBJFAoUlkRWoBU2jB+W+x2Ou0o23Os
         Umr/HoiiGBP1Uz7ag118xHjP7iASRnfqKsUDQe/QIqbREW9lmgbu9s/ZW8I9o0qexwQW
         7OqzWLPAoTHHOr/JBfeGOtQKT772gyXuIoPlFeEPAboClWqHJbbq/r4cg+2tSotY3+wM
         yWMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:cc:from:in-reply-to
         :content-transfer-encoding;
        bh=vtoxpIcNGK63LIMND+1ajO7DUeMMflo7muaHuvkGY4U=;
        b=lIRnxQntE2mhkost6LB/kJ7u97JAKbJKbQdbQ4R0h1QzG52J1bFdIVtlgUzL7+pnV1
         TcVWAgzi3B5mriZ4virwIwN64xTqk/JbPW5fNXE2NIEjN6ZV196H6iKSUQ0DJPEBmPX7
         Syag5sG7R3JQab3boLLJEvXbQDaG7NxxwWB3oWJhfJCeHy/lTQLgW5853Yyl6HnoUe4f
         Mxjek+oLc9q8kBHaBsO5FxDUKp5dPsn2cAcI33ur7hxlyucOew+OHIY6ccvg7c2jAVJQ
         DPZ6Ck8Ydr4yCFV8zE1o01Stli8xQigfKy9AezrrUjvdrO/NqE2XjTPwURfLiuNQ3hwo
         /jkg==
X-Gm-Message-State: AOAM531Mp0mTNjdOf+bhgzxeBC8oqLM3CJmfUION8OB9fOH/VzqVidiV
	ul9u9NVwlTz6MqrQjbKGxd2vqA==
X-Google-Smtp-Source: ABdhPJzvnTrm721vUi47nwjcfNE745LedX54Tdq51fNU+f02HgrPBUikmx8fy0VtPDhQKxnzJWNrZg==
X-Received: by 2002:a17:907:3d87:: with SMTP id he7mr2792296ejc.593.1644057176808;
        Sat, 05 Feb 2022 02:32:56 -0800 (PST)
Received: from ?IPV6:2a02:578:8593:1200:a34b:82ea:44:c0a5? ([2a02:578:8593:1200:a34b:82ea:44:c0a5])
        by smtp.gmail.com with ESMTPSA id n11sm1958522edv.52.2022.02.05.02.32.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Feb 2022 02:32:56 -0800 (PST)
Message-ID: <002dc530-4938-725b-37ac-f46b6d8ae7ec@tessares.net>
Date: Sat, 5 Feb 2022 11:32:55 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v2 mptcp-next] selftests: mptcp: fix diag instability
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>,
 Mat Martineau <mathew.j.martineau@linux.intel.com>
References: <db50196c67b30e7b89d241faffc78e5ffbb04e83.1643976999.git.pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <db50196c67b30e7b89d241faffc78e5ffbb04e83.1643976999.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo, Mat,

On 04/02/2022 13:17, Paolo Abeni wrote:
> Instead of waiting for an arbitrary amount of time for the MPTCP
> MP_CAPABLE handshake to complete, explicitly wait for the relevant
> socket to enter into the established status.
> 
> Additionally let the data transfer application use the slowest
> transfer mode available (-r), to cope with very slow host, or
> high jitter caused by hosting VMs.

Thank you for the patch and the review!

Now in our tree (fixes for -net) with Closes, Fixes, my R&Tb and Mat's
RvB tags:

- 3b63b1552ae2: selftests: mptcp: fix diag instability

- Results: 4514f808428c..3150c57070f7

Builds and tests are now in progress:



https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20220205T103236

https://github.com/multipath-tcp/mptcp_net-next/actions/workflows/build-validation.yml?query=branch:export

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
