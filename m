Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03CE82FB3
	for <mptcp@lists.linux.dev>; Thu, 22 Jul 2021 13:34:03 +0000 (UTC)
Received: by mail-ej1-f53.google.com with SMTP id hc15so8428189ejc.4
        for <mptcp@lists.linux.dev>; Thu, 22 Jul 2021 06:34:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=A0CkItTohVUBQIqkLHEq6Fzqf0TPkg0URX8jywQAocU=;
        b=rGEcpT6KNJLkUcdULcAbwvE9kvjMjpAVyfAbjJ2xlwmH5P565E8f8ZXAFxpt65fCzV
         ZjTS3Cgzew0mMmEz0zrZPb2NVlKn9ZnYMIs6PlLGuv7dVomlEb4kzzdv4Jp5285v5J8f
         G1OCp2ud3HYt62Vc/XxFCaNYGfKsbjJEym3FHoTACq1x50aZXcPOMrvr8+4BNDoXOX8c
         27I57d7JhYGfJ7O38O18fTLzPdgRcAvFUh4NXScYyMys5R08JmpYprwB4XTTWxThQzne
         rBavoqXlL9oeS/VjEnnEt8dF+27y+o+ior9+i7do4IL2b0Avm4SD7k4Csu6jtmdB0pdn
         nHEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=A0CkItTohVUBQIqkLHEq6Fzqf0TPkg0URX8jywQAocU=;
        b=aDutXK47iACxqUGa0lIoi5k/dr/RcbvGtgdg8ai7eaK2Ug1xZQjBZHoR08Mk0AFmAK
         rBxazLA83ou71tu46frkhulUGiQHh4eIhK1fhDuHsTYx8+4C7j0jVJixFEfLg5yQc3Mo
         tYpS0uO2QKNJKQWzDqLQKNyP6IW4JT6brbEaXhaavSh0CEuFeJ8dhqadeVDkooo8DMku
         lFgxMgto0GcFfEfGFht3nHtkx7Z22cnVKr/rhhtxJ8BLQHThvhuUIzXRCFsa7p1bpKiz
         vtC972Qi/OpDH97UINcUtgXddtKmOwDSi7qH1KWjxbR3UisUqmKbYwcz38xAz4y9dRJW
         7iSw==
X-Gm-Message-State: AOAM5322dyT4tFyeZKyKQX15ohTqDzMdu+emctuxUmKLNIRIZyhtHE1s
	+1nBMJjSPTM0JPSQNw/bVdptZqVROtTL2rLzHPg=
X-Google-Smtp-Source: ABdhPJwu59+LpweREbWu9sjvsPeJOWL1BlJSBGw3KWjvdnAbmx300O5t1kFi8ZOfMnOOWTbtQyDgbQ==
X-Received: by 2002:a17:907:3d8a:: with SMTP id he10mr42758751ejc.16.1626960842267;
        Thu, 22 Jul 2021 06:34:02 -0700 (PDT)
Received: from tsr-lap-08.nix.tessares.net ([2a02:578:85b0:e00:8391:ca7f:9c1b:4236])
        by smtp.gmail.com with ESMTPSA id m3sm7878037edb.7.2021.07.22.06.34.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Jul 2021 06:34:01 -0700 (PDT)
Subject: Re: [MPTCP][PATCH v2 mptcp-next 10/10] selftests: mptcp: del
 uncontinuous removing ids
To: Geliang Tang <geliangtang@gmail.com>, mptcp@lists.linux.dev
References: <cover.1626877655.git.geliangtang@gmail.com>
 <b5f63eb4ad680a99fc806d2406968a6a5f272f01.1626877655.git.geliangtang@gmail.com>
 <0000f0168f0d8d1cd34bbe5463aed721225446e2.1626877655.git.geliangtang@gmail.com>
 <93ffe9fbfda6d2efdbab73373b6efbbce3a36b00.1626877655.git.geliangtang@gmail.com>
 <f1175761821947749ac9724deb3009b9b2747bbd.1626877655.git.geliangtang@gmail.com>
 <e9de213a59a066c6beaba2895a7c60412b654601.1626877655.git.geliangtang@gmail.com>
 <149236d46fe59a177a2f36a5c6e45941a1e0c2fd.1626877655.git.geliangtang@gmail.com>
 <d40b7b32bc427e5d43fce298b60e1040398977ac.1626877655.git.geliangtang@gmail.com>
 <66797ed318830e28cdbabf59011c0da39b9f6cce.1626877655.git.geliangtang@gmail.com>
 <b2634ea97c51cdad4f50dd10ef9b8b6dfb267f81.1626877655.git.geliangtang@gmail.com>
 <95baa58d48cb7cd7673d795cf7a4821bda6c3494.1626877655.git.geliangtang@gmail.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Message-ID: <b066569a-2b2c-685b-4690-d740a38dfe29@tessares.net>
Date: Thu, 22 Jul 2021 15:34:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <95baa58d48cb7cd7673d795cf7a4821bda6c3494.1626877655.git.geliangtang@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 21/07/2021 16:31, Geliang Tang wrote:
> This patch added the uncontinuous removing ids support in the removing
> address testcases.

Is it a fix for a previous modification? If yes, may you add a "Fixes"
tag please?
Or is it only visible with this series? What are the consequences
without this patch?

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
