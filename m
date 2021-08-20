Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9C903FC1
	for <mptcp@lists.linux.dev>; Fri, 20 Aug 2021 08:05:16 +0000 (UTC)
Received: by mail-ej1-f41.google.com with SMTP id x11so18600452ejv.0
        for <mptcp@lists.linux.dev>; Fri, 20 Aug 2021 01:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0wnzsvjYE8nFGmkA9hwc7hkuziqDLbnoOaJ4VAwA+JY=;
        b=Bj5h5WhSDoIALEYCHtBVO2GTdRLZMsTEeygW3cCJhx1G9IPxO2DKUpG7z5yYISlp4R
         1cUqA/AYeUoSf6LDrLcP8ZSUMbs/XdippStS2FXqwhXHsLxUHTrhVFHr8p1u37OLwa6G
         njNk/NZvRp44jyPV3uX5zvh1gV0XMIl0rik2iOwsT7+UMlyQ4bSL2/vahHvTknni2ZOX
         q8DWWzj7XgRK4g6OhMu35qWVV62FYCVgdZ/9faVKFs31+uoz2kiYcj8Ygd5klS7bj9gc
         vvkptfxm/ld1IQPK1/bSri3TJxo0gic8YPhmdnLashiQUbB3B+Au+1mq56TtWwAFXtRl
         NvFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0wnzsvjYE8nFGmkA9hwc7hkuziqDLbnoOaJ4VAwA+JY=;
        b=MoY3pjSFyS1ovizyN8s3Ub1Cg6YgbUjEIJGOz9KER63f7TTqw7oNeCZeL9Rq0yM9Bg
         Jy+6WDsCt1rHTo0z2AtDyjlzF1FWlYHT0byEmOINeXkIn7pwXxODDA7sXju/7WNlqak6
         HXHhYaXZPmgPx2qwKE8Dn5e2mnt6HR17bRnFcvpMtV6dVawPv2aRw91CXTaE/Q8r83Px
         PnEfOuVd+huBurrVxMS/31JOlHjxXUClImyntNWQ3424Fiaho3tTuvE+JK/jTj486JZ6
         7b2O+I2sWT72JregKD+gBD1etiNutVZRsqLKhfNWdJNhT5lAuAjHb8KuSvoE6KzRiAfC
         xUDA==
X-Gm-Message-State: AOAM533cvbBQmBuzmEwZbGUX2mS24l46iocfAvJVjOPve2hxGbYSkwhK
	4YllKrBcsUyiCG9BKasJjr3nVKfPIFs9J7BQ
X-Google-Smtp-Source: ABdhPJxBdGTv7+l6S4Ji2vzYvadePghFHhOXNH4LJsPjqC7KLgO/O/kB4GwuniWDI+wvekufY45uDQ==
X-Received: by 2002:a17:906:7256:: with SMTP id n22mr20072881ejk.173.1629446715051;
        Fri, 20 Aug 2021 01:05:15 -0700 (PDT)
Received: from tsr-lap-08.nix.tessares.net ([213.211.142.31])
        by smtp.gmail.com with ESMTPSA id d26sm3089421edp.90.2021.08.20.01.05.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Aug 2021 01:05:14 -0700 (PDT)
Subject: Re: [PATCH v2 mptcp-next 0/4] mptcp: minor receive path optimization
To: Paolo Abeni <pabeni@redhat.com>,
 Mat Martineau <mathew.j.martineau@linux.intel.com>
References: <cover.1629386016.git.pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Message-ID: <b2bf225b-6fcc-acf8-e621-96b7142c8a76@tessares.net>
Date: Fri, 20 Aug 2021 10:05:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <cover.1629386016.git.pabeni@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit

Hi Paolo, Mat,

On 19/08/2021 17:16, Paolo Abeni wrote:
> This series aims at closing:
> 
> https://github.com/multipath-tcp/mptcp_net-next/issues/42
> 
> The relevant code is introduced by patch 4/4.
> 
> Do do the above in hopefully clean way, the series needs some
> changes to the input options struct. That means a lot of
> noise in the option-related code in the previous patches,
> anyhow no functional change is intended here.

Thank you for the patches and the reviews!

Now in our tree with Mat's RvB tags and without two small things
reported by checkpatch (duplicated "are" word + over 100 chars).

- 43bb18ab33aa: mptcp: do not set unconditionally csum_reqd on incoming opt
- a232edf92729: mptcp: better binary layout for mptcp_options_received
- 8b88edd207eb: mptcp: consolidate in_opt sub-options fields in a bitmask
- 2cea5d97a2ff: mptcp: optimize the input options processing
- Results: 720da4811476..6d620b4d8c2b

Builds and tests are now in progress:



https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20210820T080437

https://github.com/multipath-tcp/mptcp_net-next/actions/workflows/build-validation.yml?query=branch:export/20210820T08043

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
