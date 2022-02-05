Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01FF92F23
	for <mptcp@lists.linux.dev>; Sat,  5 Feb 2022 10:39:06 +0000 (UTC)
Received: by mail-ej1-f52.google.com with SMTP id p15so27005821ejc.7
        for <mptcp@lists.linux.dev>; Sat, 05 Feb 2022 02:39:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:cc:from:in-reply-to:content-transfer-encoding;
        bh=86Zn5VlbagfP1jaTPxDYb2pZ41uzBeFYWn1l6n2MtpY=;
        b=OQB33iJDXOZv3jKm/bkUC98UU/YHEMaa1WiDOoE1PZIroqnnrlNpAtWSRelCNmEm0X
         FXEmX1elaxoy/G9kYDc9B4g1LYd21NGT2El8O3uWYPwPYeRXiOhb1dcNkAaf2l452Z6U
         pgLqBu6Zlxo49Vf2hAwPGs27BxLDWbFQ+PYccOOsfARCrQQ3Iu6wPe+MM8EKhaUy1dm0
         ZD0Foe0SpIIMSjKf0p6ctYbLc9RkoIjc3k0n+zqrvTdVTfWs2F24Ej9uot48rzVRSoKr
         ADdxzQcl9Io/gktDqAUwpi5REiEajp5UbQhrcjGG/bFBVCRjj5i0tXbD/7VJ7lPvMdrE
         z7AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:cc:from:in-reply-to
         :content-transfer-encoding;
        bh=86Zn5VlbagfP1jaTPxDYb2pZ41uzBeFYWn1l6n2MtpY=;
        b=oFsyHo5ezbGaQ4Qcoz8eBxH4Wzm/ytcBs2lo3xn+/Z9aEpH+jLIFdvn9oHp6iJAyg4
         hNdxvsXnjPDNq4wWciAnUz8ZdrfmIhywAtr65Zt0ONDWKy83j8dMQ1ovq2mFWw1O5I4c
         PJWzJ//LAt2MgWOWZ9aq/yzJpU/0vbkKk1XxcvlyAFooDw9HOG2M4k+2gI8bKoKtHAo2
         Wdtuz4xwkZe7PYgDMTmJjL73im6i0TAo8S0SxzUSMtsxib8QgBXo+MqX542TdnW5dUKr
         MfuBd+toLD2ebVIX62MAtZki4M7lC1gzngkcmZ/KX3hrve6Bb0usLqM6MkKfItQZlYfG
         /EkA==
X-Gm-Message-State: AOAM530uZ2umtasOkpZQBC4U5BFJerdCv0VNSEyDdn1CDgTyfyXLneRu
	Hbzauw6uzjQsLz7EUE8l/3+n7jsbR1D+/hPe
X-Google-Smtp-Source: ABdhPJwMaJLgN5osJB+IphybwNbtEYhv6bEdTXUOJA0YUypujGvRX2rL93naWRLS9LSSBx8s6tSL3w==
X-Received: by 2002:a17:906:7310:: with SMTP id di16mr2485718ejc.511.1644057545088;
        Sat, 05 Feb 2022 02:39:05 -0800 (PST)
Received: from ?IPV6:2a02:578:8593:1200:a34b:82ea:44:c0a5? ([2a02:578:8593:1200:a34b:82ea:44:c0a5])
        by smtp.gmail.com with ESMTPSA id si16sm160084ejb.51.2022.02.05.02.39.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Feb 2022 02:39:04 -0800 (PST)
Message-ID: <d938eba9-0bbd-8cea-9148-a36afadbb31a@tessares.net>
Date: Sat, 5 Feb 2022 11:39:03 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH mptcp-next] selftests: mptcp: improve 'fair usage on
 close' stability
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>
References: <eb310fd3bdfe3315ff17ebb865fd2f1e2957fd02.1643999595.git.pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <eb310fd3bdfe3315ff17ebb865fd2f1e2957fd02.1643999595.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo, Mat,

On 04/02/2022 19:33, Paolo Abeni wrote:
> The mentioned tests has to wait for a subflow creation failure. The
> current code looks for TCP sockets in TW state and sometimes misses
> the relevant event. Switch to a more stable check, looking for the
> associated mib counter.

Thank you for the patch and the review!

It has been running all night on my side, more than 2000 attempts,
without issues!

Now in our tree (fixes for -net) with Fixes, my R&Tb and Mat's
RvB tags:

- c43e2e4ed88d: selftests: mptcp: improve 'fair usage on close' stability
- Results: 3150c57070f7..1baae8d646d8

Builds and tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20220205T103656
https://github.com/multipath-tcp/mptcp_net-next/actions/workflows/build-validation.yml?query=branch:export

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
