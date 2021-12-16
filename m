Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 978E82C82
	for <mptcp@lists.linux.dev>; Thu, 16 Dec 2021 15:13:51 +0000 (UTC)
Received: by mail-ed1-f49.google.com with SMTP id z9so32783630edb.5
        for <mptcp@lists.linux.dev>; Thu, 16 Dec 2021 07:13:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:cc:from:in-reply-to:content-transfer-encoding;
        bh=ygk4i+B9JVBKFQLGhQoHdxa9jnna7gNbtpEQkp4PXPg=;
        b=K0xsr5z+/mc5AJtsxo5Mf7CNlqvqU0zwNHd2rALPEoP+IQAFoJVlijDWkDKihubaPO
         lkQxjJcFJK7G+OEF4LqENMS8DUzIzOJoY8RhxX2oWW0pAj1MoX/y1qmxmXr6lfc0DXGX
         gA2qCnmU8gVE+pDRpjJ4avlmZnhxepH+2g6lS+KWn6OSU/jzONVWlyxCQ4FaijMkx9IO
         MBRV/dL7iHsTXptg9k9z3XrdzXW9lDkfvIgRv6UnaZ1yBjGqjmnh5xACAZF2V10q7wH3
         DX937dC+7AxrOE7r4eSO0hCJpDFzAgKJ755wbAuIX/Of3dEOi0wLj5nKmBQ+TURk244t
         wWhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:cc:from:in-reply-to
         :content-transfer-encoding;
        bh=ygk4i+B9JVBKFQLGhQoHdxa9jnna7gNbtpEQkp4PXPg=;
        b=Xc7p3o2nVH+nDhXz/+YHoZPgycY4mCcPC0xef1xXlVazuMZVs51cmUG/JNgJM0ZM1l
         mKbKD7VDLkMeIG4GOYUOrdwKM4Mv1fzszR/nABgL5OgMFsC231kpcisjPgP0w16PAjdF
         1G9hsO63kws4Ry0sFCkXXCG2lb+1J8tK+iMu0zkXxwMpCVcSF4PfLBTk1wqF6YN0Ueaj
         09JKHDrHqYUM/uHOTzpPl2TJNjui6+VTSm0nHgFeA3y46dCyj7g+p+e6iH1A1kaluMrd
         07l/YjbfWCndQ9F8gl1SDaRF5dGVxoo8pKqCsSYluFjjHivVFjydo/M5b030zSV3VjZg
         c6Aw==
X-Gm-Message-State: AOAM532jTuK10D0kX2p408H08g7EpLCpnmImNmawaEXhGrecD4BuICWl
	FxYipaVv2qIbYkxOF/wF5f/7Y/6APLAs0g==
X-Google-Smtp-Source: ABdhPJzfgsP8ckRxrSWORs16Hn7modJejCn/X4RAr0ZnhO38bjmklgwfNWmNddDffBE3zA59Ov3bMg==
X-Received: by 2002:a05:6402:184c:: with SMTP id v12mr6531132edy.154.1639667624322;
        Thu, 16 Dec 2021 07:13:44 -0800 (PST)
Received: from [10.44.2.26] (84-199-106-91.ifiber.telenet-ops.be. [84.199.106.91])
        by smtp.gmail.com with ESMTPSA id jx10sm1895745ejc.102.2021.12.16.07.13.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Dec 2021 07:13:43 -0800 (PST)
Message-ID: <085d9b7d-1f66-0c55-943d-5225e2c9941e@tessares.net>
Date: Thu, 16 Dec 2021 16:13:43 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v6 mptcp-next] mptcp: avoid atomic bit manipulation when
 possible
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>,
 Mat Martineau <mathew.j.martineau@linux.intel.com>
References: <cf505ef6fadd1ca26cdef0f65b54a250d1b280ef.1639583569.git.pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <cf505ef6fadd1ca26cdef0f65b54a250d1b280ef.1639583569.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo, Mat,

On 15/12/2021 16:53, Paolo Abeni wrote:
> Currently the msk->flags bitmask carries both state for the
> mptcp_release_cb() - mostly touched under the mptcp data lock
> - and others state info touched even outside such lock scope.
> 
> As a consequence, msk->flags is always manipulated with
> atomic operations.
> 
> This change splits such bitmask in two separate fields, so
> that we use plain bit oper operations when touching the
> cb-related info.
> 
> The MPTCP_PUSH_PENDING bit needs additional care, as it is the
> only CB related field currently accessed either under the mptcp
> data lock or the mptcp socket lock.
> Let's add another mask just for such bit's sake.
> 
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>

Thank you for the new version and the review!

I just applied this patch at the end with Mat's RvB tag and
__most_hold() as discussed on IRC:

- bcccc445fb2e: mptcp: avoid atomic bit manipulation when possible

- Results: c85bd1253bfa..1fdc9db07613

Builds and tests are now in progress:



https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20211216T151318

https://github.com/multipath-tcp/mptcp_net-next/actions/workflows/build-validation.yml?query=branch:export

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
