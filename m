Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E0311FB8
	for <mptcp@lists.linux.dev>; Fri, 30 Jun 2023 09:04:08 +0000 (UTC)
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2b5e7dba43cso25796451fa.1
        for <mptcp@lists.linux.dev>; Fri, 30 Jun 2023 02:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1688115846; x=1690707846;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Sa3DyR8yJPnqoUYzjck6nr0OnF9t4/bYV/C5u7nn/tc=;
        b=IIjjUcqKGHgj7e3Ar66Od0lVDR4p3opIY64CqtxnKyZVjURUInmMPLFab48Zczu1hy
         bzPpAjz5d8kWd5a+QpnmhzgdxfFIZyE9gW70aQNO5XahUKIQz33P2y5e8T7i2ygM35HZ
         cQQiSmJKkCvuh/WlzWejkEi1PVj6Gbnyd6Rkx4ovHO2okyFp2V2NtMNX31MBujD9DEri
         amnGC6guBaJnUDZqgTH2gdudqgR7Xv4UZNV0KHzOKWykjXEnmiLqjqEEXNHiVNjLtUnH
         5Voptl1ItECRRc9WO9CZPtvowjtWmNrfd0npYeb9dl7k1z5PDjnNbueBIPwGs343QL0r
         v3+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688115846; x=1690707846;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Sa3DyR8yJPnqoUYzjck6nr0OnF9t4/bYV/C5u7nn/tc=;
        b=ZgGP3fRj32ciDv0yNxKKjg7SUSVVqCTz63fgVGoi1m6QToNeEzlE6xwRYiLJJikeWq
         dPDnrtBcUUBXUXWx/kk64Sm7C3hHUMpskU0JMxZ/Prqzzz+zucLOsP0bkLBzOLcQPZb3
         AasOs74sTcC9ZrRAARuOdm6jYRUuU7aBpuX48OyAbLdz9QaFg4p2FPCT8tM8VG9hZ5fE
         xrC2k+tcnIbCeqcP7MUJoc90qooPWCKX88k7/3SkvozyW23OR2kA/cDY0JsXQ7Cdek5N
         WLEsZCJI9xzIKHFHdo7zRVM/zePD6obpMtb8FwvlQ4PIKrT397eQHYOl1piixSYxzz8T
         UXiQ==
X-Gm-Message-State: ABy/qLaEAK8ATFFyOIHUFZ2bvy3PJFSNhanbkt3tiUMGMB/R3tEzBazJ
	y/UlQ+P6lttnM6tVqXQhdQGJ/Q==
X-Google-Smtp-Source: APBJJlEn7V9hdX8119pZ+5w22xXo7ffBdQFPBUnsy9fEq4cqJu4l/sSYFoGywc24CDmgatBd5oC3rQ==
X-Received: by 2002:a2e:8847:0:b0:2b1:e807:f0f with SMTP id z7-20020a2e8847000000b002b1e8070f0fmr1702026ljj.28.1688115846092;
        Fri, 30 Jun 2023 02:04:06 -0700 (PDT)
Received: from [10.44.2.5] ([81.246.10.41])
        by smtp.gmail.com with ESMTPSA id d1-20020aa7d5c1000000b0051d9ee1c9d3sm1380850eds.84.2023.06.30.02.04.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Jun 2023 02:04:05 -0700 (PDT)
Message-ID: <d4aca9e4-eb73-62c9-e351-f4d4bd4f8337@tessares.net>
Date: Fri, 30 Jun 2023 11:03:59 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH mptcp-next v2 0/4] update userspace pm mptcp_info fields
 part 3
Content-Language: en-GB
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
References: <cover.1688092826.git.geliang.tang@suse.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <cover.1688092826.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 30/06/2023 04:42, Geliang Tang wrote:
> v2:
>  - set all env vars as local ones as Matt suggested.
>  - update the commit logs.

Thank you for the new version.

It looks good to me with the modification I suggested on patch 1/4.

Reviewed-by: Matthieu Baerts <matthieu.baerts@tessares.net>

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
