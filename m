Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD56F70
	for <mptcp@lists.linux.dev>; Wed, 11 Aug 2021 15:37:01 +0000 (UTC)
Received: by mail-ej1-f49.google.com with SMTP id b15so5125896ejg.10
        for <mptcp@lists.linux.dev>; Wed, 11 Aug 2021 08:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=8TAeOLiUC+AVBLHgnaqw365oZ2kShBdT0FDDoYT8fr8=;
        b=kqkRt55Lc2/HvbuvpGsPU/tNssjRP1QsyRauQzUVQiGAr6T0vUvTkYHKNDhInGt8LB
         Phw/toQSSwbkE72mfWw4yFvFoolqYcdOK6ukMDb7EHgbyuUhYGDuX2C9/N5rod4thA3E
         rcE18IzEHjAQwgKuFqw1pvVbiMw3lMGPhbE+e9Ecflcj4BNrLOx3SlcguM+fTaPj9MEK
         TniNoZdF4m97BaiRq/xB2dLeWGHYiJKQ+XWWZiZza0Ur2+AnIHIsRuUM0k14K29D+5VL
         8DguiLiSSCQpR766Rsi4JxcI99V54pg79ix3EWVZtO3YIS4pNcGDO0LijET4lfbuu+1K
         C2Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8TAeOLiUC+AVBLHgnaqw365oZ2kShBdT0FDDoYT8fr8=;
        b=S1IMc2mTaWCAdCRezxDmAxUC2qj5iAEuFCH3TmoGvMjedwW477F9ZsbFuO0Q5OljjY
         QR7v06ZoUpkWO1E4QYVXCZmB4eqZx5nk6q/vKKRfcPzVkJLBPK84LkQMGxD+Xz8nowiL
         yE//EgG/9bASqIRP+IjGqpfQbQhxpUEFy0RICSe63e8V3cL7Rx2UYSm7t6R81OpwIp6h
         CzV0Jjbd2AcjVVXPJ9GAviHJwsZ+JXY6P4qdHD7SRIG93EUFYbgPCttMqz36mp8oXOoe
         e5/MgSW8A9ZfCZ2ubrRz/HIshn+T8hfV5j9Z8LbfFr48rpYlR+my8XW3JaQMJxYFJG77
         gVBg==
X-Gm-Message-State: AOAM5339APeB6YHpVIHMrZqgDc+vJld0H+OXYnlgBrXDy+hVAfwNOoLh
	090uueBcUQ4AVHZLudatfmbLhYxULxyhoXOA
X-Google-Smtp-Source: ABdhPJxD+zaDZRasTpd4SSF7MLn/ibvz6LAhkfNY6H8GMcqJGRSKwN18TL+spTG/DL9J+yAPUzdnjw==
X-Received: by 2002:a17:906:a012:: with SMTP id p18mr4270421ejy.331.1628696220052;
        Wed, 11 Aug 2021 08:37:00 -0700 (PDT)
Received: from tsr-lap-08.nix.tessares.net ([213.211.156.139])
        by smtp.gmail.com with ESMTPSA id bx11sm8313828ejb.107.2021.08.11.08.36.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Aug 2021 08:36:59 -0700 (PDT)
Subject: Re: [PATCH mptcp-next 0/2] mptcp: some self-tests fixup
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
References: <cover.1628673891.git.pabeni@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Message-ID: <2b3daaa4-4a07-9b9b-8e48-0fd294e1ba1f@tessares.net>
Date: Wed, 11 Aug 2021 17:36:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <cover.1628673891.git.pabeni@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit

Hi Paolo,

On 11/08/2021 11:25, Paolo Abeni wrote:
> The 2 squash-to patches try to address issues/221, at least
> for the root cause reported in the github tracker.

I confirm that it is much better, thank you!

Before the patches, it took me 2 attempts to have "mptcp_join.sh -l"
failing with a debug kernel.

With the patches, I have 30 successful runs so far!

Tested-by: Matthieu Baerts <matthieu.baerts@tessares.net>

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
