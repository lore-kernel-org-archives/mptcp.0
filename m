Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8544519A
	for <mptcp@lists.linux.dev>; Fri, 23 Dec 2022 14:35:19 +0000 (UTC)
Received: by mail-ed1-f54.google.com with SMTP id c17so7304508edj.13
        for <mptcp@lists.linux.dev>; Fri, 23 Dec 2022 06:35:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8appdaKr2iAm0DZslpg6fOlbxUtqGE/mlEsWTMCnrbo=;
        b=WW686VdIBkNAx28f7+Si8iPGlWEuPGCewNZ0/5ikpdSxW8TcdecZANUYd1Nwk8d8yO
         SHvlbcLGaTaDFMfjzYHLrYgG8ui3J+pnvMhv6Jw2IpP10bW7Y2Vq3G6VNOUNl8CXnc83
         bAzM+EsAoFD2e+hSJmH2m+Y5fsAzro82TTHrwjqz2V9lAWN0LIhTqy8JLGvWLCnvPS2X
         1gD41uI67iz0I1RiXB+8tJSa4+wcgtd6/GneB3YHKN62DwhS/gYl28//2napqbj2oCAY
         f3+LoE9XUHFL8eMGL/piXJoLE7DNHaG+aqJQztzyotWBxITuEAPK5Ca2cJfPSyGoeBU7
         cLxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8appdaKr2iAm0DZslpg6fOlbxUtqGE/mlEsWTMCnrbo=;
        b=6kReaR4yVcychymvU6my6B94h1+APYQnw+S7DFDg3uBeX88JAn/i7O4xGc7Dbo5rQj
         wT7HqmtlKZBfWp44t7cYAIh9UZwvIn5yPFIPbHI33Fwv7Vsg8OxZYkguW49EWyCeMy/u
         ZzCVk13LCZpHeP7EwMIkGk63Twnzz+5ITzDYc+nJdVqljXNoQiWI5ZaWmwCxQaXDXwYV
         zb0gLA749gMDoyj6sSO3/rZ7R+COoFke17ujRYFwbjksV6ojuOZYVqnZXg4sTPtbE8GF
         wSu4d2kxx4T+gY8v4DZ2SWbrxOIH5+aHg00UvnHMbexP9/6qJYea0xPtUSU9BqlsHTtU
         Yokg==
X-Gm-Message-State: AFqh2kqzRqP7vL+6ZCPhroiN9gvQ7GVsrZCjQKfBeIcgIg3lu/p+d9Sk
	GKPCD4gi1S+EcLipapLWf91eBYHlgCsmMfQUHwGBog==
X-Google-Smtp-Source: AMrXdXvp7AOLIfqUaGpZjcmJYWY10jo2fjEjWTldZYxNnSWaJZQs/PU32Vcsxf+sNzMvuM/w3fOWmQ==
X-Received: by 2002:aa7:c505:0:b0:47f:2419:336c with SMTP id o5-20020aa7c505000000b0047f2419336cmr5876154edq.25.1671806117353;
        Fri, 23 Dec 2022 06:35:17 -0800 (PST)
Received: from [10.44.2.26] ([81.246.10.41])
        by smtp.gmail.com with ESMTPSA id ec16-20020a0564020d5000b0046ab2bd784csm1546966edb.64.2022.12.23.06.35.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Dec 2022 06:35:16 -0800 (PST)
Message-ID: <a4006e0e-1b75-c8a3-f474-6740197ff1a4@tessares.net>
Date: Fri, 23 Dec 2022 15:35:16 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH mptcp-next 0/3] mptcp: add support for mixed v4/v6
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
References: <cover.1671799401.git.pabeni@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <cover.1671799401.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo,

On 23/12/2022 13:51, Paolo Abeni wrote:
> The core MPTCP implementation is just a few bits of to support such
> feature, we just need to allow specifying the subflow family explicitly
> (patch 1/3) and remove the artificial constraint currently enforcing
> no mixed subflow in place (patch 2/3)
> 
> Some self-tests added on patch 3/3

Thank you very much for having looked at that!

I just have a couple of questions in the different patches :)

> Merry Xmas ;)

Thank you for this Xmas gift :-)
And Merry Xmas as well!

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
