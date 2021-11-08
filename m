Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF30C2C96
	for <mptcp@lists.linux.dev>; Mon,  8 Nov 2021 17:08:34 +0000 (UTC)
Received: by mail-ed1-f45.google.com with SMTP id r12so65120065edt.6
        for <mptcp@lists.linux.dev>; Mon, 08 Nov 2021 09:08:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:cc:from:in-reply-to:content-transfer-encoding;
        bh=mDl5x4VHnhe5qF3Muw0cN/J6fkbNTXGETOqO5+w0XDc=;
        b=HTfB25yqK2/nqgHaANlMBnpkw3ip1jnUf7yrxrw/61LJurdNtSrY9+fA7Y6iLFAFwG
         6bq6gzjYLCKPGxAqiyNCa8rgRzskD2dg0CBntsdJN+Pg9JwGCQsmOFGHcxOCyadVdURE
         v/sXKd1MpX0UMC5iijkt7pgd5B/ORKGcja7nEFRZNXQ7IPuW2ruw/zh4TNcpxaoCo/k1
         CY6awsz0rKn4RFqlPMRLGki+vltaPL5AGSUaB4bG5sCWz8o6RDZEMUC4CV7NzHwlHqnh
         jdItxklj6IGGZE7pY8lt8ucFeecV2hGzbw72K1Y6u/VHp+gK/MJUb+kOMUsOar6UEKYN
         78jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:cc:from:in-reply-to
         :content-transfer-encoding;
        bh=mDl5x4VHnhe5qF3Muw0cN/J6fkbNTXGETOqO5+w0XDc=;
        b=uP42QJ6MxQDc1TNaHdZIT12jnhsCS4mcbabR+/1AJ2EEC8hF5yYqVMUv0+cYGUc1FC
         G2v31MLt9F334sXO2VDcn4ni0my5DUX/mtdOjF70NMzywN/uw/4OLLnGPtNt3OyPBM7Q
         cyFTDWFr8lQawFPj7X1BUhxXEGg6IvTVyJZx9GEBDfEBZSWzVusPHXQCNBU0BPU0HMzM
         irfWTjIxFwOA6eVuhcx/1pUUhzJlUhaVcQZch+F2mJ4uVIJdLmfc9hpj7XBjF7ZdoA5i
         TtUJGNuNOWAI4Ujm6r3hnTXuQU4oC64w9VkeHAhp55qoZT25a9wveQ64r3Pp3Y8yolpr
         40rw==
X-Gm-Message-State: AOAM533qnq2ofw8fHoB5aXyAeIi0VMz3ByOCeqZstZbNatJOdvqO06My
	gqrGNicfCzJXpyQ0rJazyWPAzpLwyGlJdKxF
X-Google-Smtp-Source: ABdhPJzxPdMnzniSEq2KsehKaSTQOTQajvYIGviALhaaBl6Mm0qnfNuNvnxTIQeRYWdTqglFtq8Rqg==
X-Received: by 2002:a17:906:e85:: with SMTP id p5mr898063ejf.159.1636391311756;
        Mon, 08 Nov 2021 09:08:31 -0800 (PST)
Received: from [10.120.18.54] ([84.17.46.18])
        by smtp.gmail.com with ESMTPSA id cs15sm8501240ejc.31.2021.11.08.09.08.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Nov 2021 09:08:31 -0800 (PST)
Message-ID: <9aced5fc-6a08-0498-db3c-e55eb214a78a@tessares.net>
Date: Mon, 8 Nov 2021 18:08:30 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.2
Subject: Re: [PATCH mptcp-next 3/3] mptcp: add SIOCINQ, OUTQ and OUTQNSD
 ioctls
Content-Language: en-GB
To: Florian Westphal <fw@strlen.de>
References: <20211108105711.16200-1-fw@strlen.de>
 <20211108105711.16200-4-fw@strlen.de>
Cc: mptcp@lists.linux.dev
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <20211108105711.16200-4-fw@strlen.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Florian,

On 08/11/2021 11:57, Florian Westphal wrote:
> Allows to query in-sequence data ready for read(), total bytes in
> write queue and total bytes in write queue that have not yet been sent.

Thank you for looking at that!

(...)

> +static int mptcp_ioctl(struct sock *sk, int cmd, unsigned long arg)
> +{
> +	struct mptcp_sock *msk = mptcp_sk(sk);
> +	int answ;
> +	bool slow;

Very very small detail: we should swap the two lines.
I can do that when applying the patches if no v2 is needed.

Cheers,
Matt

-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
