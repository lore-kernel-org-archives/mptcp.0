Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D40D470
	for <mptcp@lists.linux.dev>; Mon,  7 Jun 2021 15:04:14 +0000 (UTC)
Received: by mail-ed1-f51.google.com with SMTP id f5so15761621eds.0
        for <mptcp@lists.linux.dev>; Mon, 07 Jun 2021 08:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Z8PrcjG1QzoutoemjKyTiDMzfrnEulQy/d+pElG4lkY=;
        b=Esv+S+Dikorf4YvPDTJKPJUXHAKxn3DUkqPy/oxsSQEG6NqOJXR9EDFVBdHs9szb4s
         twL8eYjqER/4Vu0TxsBQZXYE8aAt3DwMFZUExsWAK+zVvPehtPXVddCoV2BcycXgNzf2
         mmQWwz7ZyCRG/gSLWA1cbmdf35EpeIMCZmfrJlZDGesoGOHHPkaEAPdP4dJyBB73Es8Z
         tKc4yT7fSG0VWqtvtYTOw6qrmbHEf2NRrqZKBEbR6FgAe3ELimS2rocP1JgQTDWdf059
         FVd51u5JSjjjmWggonRyjlfA4PKXIwBx2RUzisM4W67UmRkl/eDt1hrQ9Dgh9oHpkw9i
         Ei2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Z8PrcjG1QzoutoemjKyTiDMzfrnEulQy/d+pElG4lkY=;
        b=gfgsSfI/1EkIqR1PtqfOb2dIJqHols1whMlUWzWokqZcmiNq54kJYo992srfKoltRu
         7BmfNjYvQ5ol7lzt63YZDj82LvgmYO+HY5/fNLynLI4hDbD4DUcDQFk4ojAeVUd4KxHJ
         Tl8LWOepfbNjB7wpGyc9/il1olhfsHVbkkHrPBcjb8YPu3stK1vKRCRWUF/+rViS8DSU
         37cf0cm8YxKtivFUCgsPsdBcXW9wJKp90RjymhmxQ0Xexdm16InsxgtMGnxjNymkoNDo
         Hkv8KGSdj8VGe793b7hF83NSjtyISNTJUrDvdg/bn5gO9Ek0js0G7/zcrfnHmjqisTcz
         uu9A==
X-Gm-Message-State: AOAM530V9f7fUk//y5avjeIbMxSg5JTcB8I2LTw1QqnJtytXsWCCVTKi
	O9WniheMxzttS27eVjnvfogdw7nG7cml7SHM
X-Google-Smtp-Source: ABdhPJxuSMuoHRduBQK6MsS1vtGsqcKCKjYejE46vXB2QEh+04ruiShxqu8PZ0FXVdr6Q2Rdst1exg==
X-Received: by 2002:aa7:d482:: with SMTP id b2mr20678479edr.45.1623078253271;
        Mon, 07 Jun 2021 08:04:13 -0700 (PDT)
Received: from tsr-lap-08.nix.tessares.net ([2a02:578:85b0:e00:b57e:3c04:9ae7:cda2])
        by smtp.gmail.com with ESMTPSA id am5sm6592221ejc.28.2021.06.07.08.04.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Jun 2021 08:04:13 -0700 (PDT)
Subject: Re: [PATCH v3 mptcp-next] mptcp: drop tx skb cache
To: Paolo Abeni <pabeni@redhat.com>,
 Mat Martineau <mathew.j.martineau@linux.intel.com>
References: <3373718d8687043f4827123d18a3029f2aace6a2.1622042633.git.pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Message-ID: <95baf313-c021-cf13-70bb-e12669f41b55@tessares.net>
Date: Mon, 7 Jun 2021 17:04:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <3373718d8687043f4827123d18a3029f2aace6a2.1622042633.git.pabeni@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit

Hi Paolo, Mat,

On 26/05/2021 17:24, Paolo Abeni wrote:
> The mentioned cache was introduced to reduce the number of skb
> allocation in atomic context, but the required complexity is
> excessive.
> 
> This change remove the mentioned cache.
> 
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>

Thank you for the patch and the review!

Now in our tree:

- c0c5da0dfec1: mptcp: drop tx skb cache
- Results: e5d80c7af352..b01ac56d4eb3

Builds and tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20210607T150236
https://github.com/multipath-tcp/mptcp_net-next/actions/workflows/build-validation.yml?query=branch:export/20210607T150236

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
