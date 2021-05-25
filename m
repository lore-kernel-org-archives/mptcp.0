Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F246A2FAE
	for <mptcp@lists.linux.dev>; Tue, 25 May 2021 10:36:20 +0000 (UTC)
Received: by mail-ej1-f49.google.com with SMTP id f18so16361611ejq.10
        for <mptcp@lists.linux.dev>; Tue, 25 May 2021 03:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=h8UTfIrGF+zLonny+5LcEvOGGFOqA4tJzqIaP4LF8WQ=;
        b=P/pS0V1SZvX+g4mShVmnivF3Dv+4FZcuBGKX1hISkmxosOlaP8n2p5EbBL9UpzHMl3
         AUoORfWX6wy7RAuXcMoCMjeAjhR5euRSeDZ3X8gRms5GvaOcTY1Q8QDBrqO6lU6PhjfT
         YhtYrJEuKymzJJWZn75TQ/66v4hJBUFg7YbbPYoM6+27/l6Osb4NbCJhgcAqjrP9Rd1l
         E3KWufFLvfJUffsYSW4ERKDPlTihasocHzNm2R1UGB3498VMNzdtASsZnpUm+90bIcNy
         bvOpF5L8+xlxmVdnNLMITW1JWp5+yPnbBn2P18EeFUCpjEaUL/VVA8trPyCjt0zMtbbT
         5SgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=h8UTfIrGF+zLonny+5LcEvOGGFOqA4tJzqIaP4LF8WQ=;
        b=dN7kONhkRI2zl/McBenPkmYhn2A6OE8N0JbsN3ftdw31iVOxe9SXUG6QqHyJcUlst6
         GxMbAQfevn33C5Z4uW5Nf8pGmRLslKesxJRiwU8UhcrBDHXD2+UgdcAdmst3ypr/UD5Q
         ELqCPwkO2V1fSrYU8YB0dGXckLAaDEVAdfaUPl1FVhFPkdHKee9WG1i6RX0z73DUSn2m
         9du5aV0Zg7EJ+qPxkPyz6MtRnm98g++u/OYBbUtq0LRLSMH6POLVb+keVKiZ5yRCPS6o
         QW1u64VYzXaDs0R1/taNSCrq0X3QppkSLdc44NY9lRyPMu1jgNQxY8QxZ4ZR9z4uFRuz
         DEdA==
X-Gm-Message-State: AOAM531EarolwZ/QPUPhpQ1gS2edKnnqEXJadK3/5ky6Q47YA2CF3IMp
	jKvn1tOq3UMp2tT8tBz6u5O25mQ0M6PCvSLR
X-Google-Smtp-Source: ABdhPJxYnmA01fKhGavAIYBJICJgVUmX7/UXgN0kqCTN2uOCmPdFqlcHpfK9EE2YXEYHXlCmcytWhg==
X-Received: by 2002:a17:906:8049:: with SMTP id x9mr28628121ejw.13.1621938979014;
        Tue, 25 May 2021 03:36:19 -0700 (PDT)
Received: from tsr-lap-08.nix.tessares.net ([2a02:578:85b0:e00:8839:6e9:c432:46d9])
        by smtp.gmail.com with ESMTPSA id u6sm509135ejr.55.2021.05.25.03.36.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 May 2021 03:36:18 -0700 (PDT)
Subject: Re: [PATCH mptcp-net] Squash-to: "mptcp: fix sk_forward_memory
 corruption under memory pressure"
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
References: <03e3ba49f6d847686dced53e915ace73928fd008.1621517601.git.pabeni@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Message-ID: <cb7b7981-aa3d-f714-cfba-f91c0b6c70dd@tessares.net>
Date: Tue, 25 May 2021 12:36:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <03e3ba49f6d847686dced53e915ace73928fd008.1621517601.git.pabeni@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit

Hi Paolo, Mat,

On 20/05/2021 15:46, Paolo Abeni wrote:
> Commit message to be replaced as follow:
> 
> """
> mptcp: fix sk_forward_memory corruption on retransmission
> 
> MPTCP sk_forward_memory handling is a bit special, as such field
> is protected by the msk socket spin_lock, instead of the plain
> socket lock.
> 
> Currently we have a code path updating such field without handling
> the relevant lock:
> 
> __mptcp_retrans() -> __mptcp_clean_una_wakeup()
> 
> Several helpers in __mptcp_clean_una_wakeup() will update
> sk_forward_alloc, possibly causing such field corruption, as reported
> by Matthieu.
> 
> Address the issue providing and using a new variant of blamed function
> which explicitly acquires the msk spin lock.
> """

Thank you for the patch and the review!

- 8ab3ae44f119: "squashed" in "mptcp: fix sk_forward_memory corruption
under memory pressure"
- 48d3c38d7829: tg:msg: update commit message
- Results: f80805721af4..9d8cf0870447

Builds and tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20210525T103604
https://github.com/multipath-tcp/mptcp_net-next/actions/workflows/build-validation.yml?query=branch:export/20210525T103604

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
