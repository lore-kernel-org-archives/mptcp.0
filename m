Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DEA2111A1
	for <mptcp@lists.linux.dev>; Wed, 17 May 2023 16:22:25 +0000 (UTC)
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-3f427118644so10032145e9.0
        for <mptcp@lists.linux.dev>; Wed, 17 May 2023 09:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1684340544; x=1686932544;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5VSQjo1SHiwWZ5p30WfeaI1rsvzSvel5dDG20yEutqk=;
        b=7+ByggaJ3wR0PFIyfLd9nlAvgy+Peeumbk/VzAvlIBd6iQhq0ajQwgUyrmlLPtVXTL
         6+ardlWAEg/5xo6Uv4iK6Rfxw3NWH5+oG8x5wv82uMe90LFGjR6ZnjlBdBY85BspuICP
         aWKQFWPoEEe8tLA4EybtuZ9rBH0yoTTDkpkOKUAl618AJx1ptvXOlKWHQLoU0GTKARoQ
         e2YPv880zQ1uHe8+099gH93gSow658aup+TdmLt8Fr44St2LeUFUJ+l4e4FmQjydir4a
         0z7sn0AV7D5XnimPdBDIUsWWn76tivtF9NBdwKtqtOX3tbv58Hj/fmlvYhWMb+zoGCHO
         QHNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684340544; x=1686932544;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5VSQjo1SHiwWZ5p30WfeaI1rsvzSvel5dDG20yEutqk=;
        b=LFFq1IDjtkoWaUCjhoFmm06GpVATleL28IQ1eKXI8YIc9TW2NVVDuqna/eUw7rGEnc
         jEkUHUx8dfzr7AhHNo1H4RIez2/3mEitxeJ/zwwW5PvkQcZ6LJ7FLDZEvPcKccfJRbe0
         ySgLvgS7rTDtRDtjI1t096HZvW4f9uBXsN1xagarEj4eX+LFlQbLpyCasM0pPcZKhPrr
         im41/T0Hx2Yihjb9tE8ZXt3uYDIyvegOMFprcpjKxa+51h8IHxz8lEoIm7yWfbtgYu6r
         UwQNsuCG4JjAiaa6c+7YtJboxs3cCgDssAECdbHnPOnkrR3Q5nQHdeasI3SnYmM5FdEV
         RzJg==
X-Gm-Message-State: AC+VfDzH6vmQwZDtF2vAgdmLqGPDX8RSCSVG7nui1zZTQs7Eq7zJWS3X
	c8+WFjhwbHY51VzderRxF11UC+lVfdslB5cs47k=
X-Google-Smtp-Source: ACHHUZ41kdGDUSdXNiANOmAKgGyAJXoDdtpe1HNTUuKZlhUXWUwGzFGRNq1ZUBe2BD7b2iiP1vszbQ==
X-Received: by 2002:a05:600c:21cb:b0:3f5:54f:b1b2 with SMTP id x11-20020a05600c21cb00b003f5054fb1b2mr10821248wmj.37.1684340544121;
        Wed, 17 May 2023 09:22:24 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:a66b:672f:3b69:b6da? ([2a02:578:8593:1200:a66b:672f:3b69:b6da])
        by smtp.gmail.com with ESMTPSA id g17-20020a05600c311100b003f4283f5c1bsm4905153wmo.2.2023.05.17.09.22.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 May 2023 09:22:23 -0700 (PDT)
Message-ID: <4d04c383-d64e-1bb6-2489-8fef5133a27d@tessares.net>
Date: Wed, 17 May 2023 18:22:22 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH mptcp-next v13 1/7] mptcp: update userspace pm infos
Content-Language: en-GB
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
References: <cover.1684116357.git.geliang.tang@suse.com>
 <6f3fe80ded90e36d08b395333071b2cf55bb4258.1684116357.git.geliang.tang@suse.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <6f3fe80ded90e36d08b395333071b2cf55bb4258.1684116357.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 15/05/2023 04:10, Geliang Tang wrote:
> Increase pm subflows counter on both server side and client side when
> userspace pm creates a new subflow, and decrease the counter when it
> closes a subflow.
> 
> Increase add_addr_signaled counter in mptcp_nl_cmd_announce() when the
> address is announced by userspace PM.
> 
> This modification is similar to how the in-kernel PM is updating the
> counter: when additional subflows are created/removed.
> 
> Fixes: 9ab4807c84a4 ("mptcp: netlink: Add MPTCP_PM_CMD_ANNOUNCE")
> Fixes: 702c2f646d42 ("mptcp: netlink: allow userspace-driven subflow establishment")
> Link: https://github.com/multipath-tcp/mptcp_net-next/issues/329

You can now use the "Closes:" tag here instead of the Link one: if you
are using the version from v6.14-rc1 that is in our export branches or
net/net-next, checkpatch no longer complains about this tag. We can use
it to automatically close the issue 329.

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
