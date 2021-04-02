Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 380B570
	for <mptcp@lists.linux.dev>; Fri,  2 Apr 2021 19:18:10 +0000 (UTC)
Received: by mail-ej1-f53.google.com with SMTP id u21so8591086ejo.13
        for <mptcp@lists.linux.dev>; Fri, 02 Apr 2021 12:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=to:cc:references:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=eFB0yUxdAtmrud+f+z++USvOAcFQZf+xx1jMM0ULHEs=;
        b=xX474NvUA9aPsBqNGS62P20M6lE05a3ZP9spVbhwOWuant9j0h0HQ6Oa8f+Ioes2Bm
         /JNF1x8oreE13sO0IZ4xr5r1zdLeVIx5QnxC7tz2gMdtdABfZZgkiXD+v45t/haZovEt
         9IDAsrfpsvCJHURGu1NB13zozWeti2SGtUriiovuIyw3wWe6e3m13BplkcLR6rGvrQVF
         JYxx/EMG+Di8tXYTSDU7ZAObmr7vTugksFQ2iVUnVyjLPlDtNG6dNY+uIRUuRZr4alt+
         e3d7y50LHjNfaOaKr+DzpQRjVIkzyF/GsGd2au211aJbN0rsmbfTQx7N3CctwXF53ep0
         dg9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=eFB0yUxdAtmrud+f+z++USvOAcFQZf+xx1jMM0ULHEs=;
        b=T9eaHTGdAdYuDVWPFn5zGbgxQWxm9lOxrpeLP0RhSb3g58Kn+Aukr1RQsbiko8HhW7
         sVSdVxxXm8KD5DoTXM2xOE5VTUbid5mcZTO3pE5CaRtZKgNDxVztXVkEcthwj53wPW4A
         L5DS8C31k0W+o9kmDhWIqeMMhg1vd6mCSwclgUMdhEtiCzBpeEilkR9QGtsKhkrbSZbJ
         N3e8FZysPV9xdI+xABwxOaOrgtQ3XwPqWes83LwUA1WkAVx+TF4zfo4RA0ScfRYNcfzm
         tnGrlZUwMBt4C82GUQObXz2qxWPsCOUeeEI1oRAsDyfDSWu7GsV5QyPEeJyrlLrni2L/
         i+UQ==
X-Gm-Message-State: AOAM532zbmCLUds/wrFamY6YYgZP+SA6GWDstyu71NBy6zFP75oMbf5R
	CBpMdORvDXm+L6HUjtDfLyU8pWrD0GlX4Q==
X-Google-Smtp-Source: ABdhPJxqNR8vQayzL47WvzuOgAuYjp3ydD4uHM5Y8NgipnnjEzuB+D2wYTWQONK3YMkcUmiSesQYpg==
X-Received: by 2002:a17:906:1155:: with SMTP id i21mr15338466eja.218.1617391089114;
        Fri, 02 Apr 2021 12:18:09 -0700 (PDT)
Received: from tsr-lap-08.nix.tessares.net ([2a02:578:85b0:e00:8dc4:b2ca:ed3c:37c])
        by smtp.gmail.com with ESMTPSA id dg26sm5849903edb.88.2021.04.02.12.18.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Apr 2021 12:18:08 -0700 (PDT)
To: Geliang Tang <geliangtang@gmail.com>, Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
References: <77e57026944d545dc4aaf9a6199ffa39485e1f43.1617296035.git.geliangtang@gmail.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: Re: [MPTCP][PATCH v3 mptcp-next] Squash to "mptcp: add tracepoint in
 mptcp_subflow_get_send"
Message-ID: <a9039284-c40a-e67d-d12c-6f2c9ccff958@tessares.net>
Date: Fri, 2 Apr 2021 21:18:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <77e57026944d545dc4aaf9a6199ffa39485e1f43.1617296035.git.geliangtang@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit

Hi Geliang, Paolo,

On 01/04/2021 18:54, Geliang Tang wrote:
> Reduce the indentation level and zero the uninitialized fields.
> 
> Suggested-by: Paolo Abeni <pabeni@redhat.com>
> Signed-off-by: Geliang Tang <geliangtang@gmail.com>

Thank you for the squash-to patch and the review!

Now in our tree:

- 8c49e105a00a: "squashed" in "mptcp: add tracepoint in 
mptcp_subflow_get_send"
- Results: 9f7fd6e1752e..f6973d0e03b2

Tests + export have been started!

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
