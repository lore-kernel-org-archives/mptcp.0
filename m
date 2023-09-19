Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88D3E38DD5
	for <mptcp@lists.linux.dev>; Tue, 19 Sep 2023 08:55:47 +0000 (UTC)
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-400a087b0bfso57564665e9.2
        for <mptcp@lists.linux.dev>; Tue, 19 Sep 2023 01:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1695113745; x=1695718545; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=roKxWtM8hyHh5W6pbUJT0a2MOueV/CRa3rUaV4mCMNI=;
        b=JNlog0NXswSpnNtfPlIRec1goCkiirUuqfJBtDc48EtIbnfExC/AttCGYFBbVPZzcP
         nc72smZIk3Xa+gOD9M2b97VTrnQMrQ1miRJiBThAByks5MxgyAkNS03Uk8/yyOLAldUA
         DtBiDy31x2auJ9AstlA/tCWtgNOxvGHCDQi2wkHb5fbLTeiZ8XBcSN2XWFycubjYxNAX
         mN5O5SgFspnv1eLxO9MtaK4/lYpKxAbIQX3dtE0iDDCjg4/8hMLAC/FGg8CVaWiufBuP
         a0rRkOnFIRi6efMkl/ZnxYxtssaJd9VjLN0TmXMcIGuuscl7kR3/vHm6leHwDjRLnUQj
         FHvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695113745; x=1695718545;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=roKxWtM8hyHh5W6pbUJT0a2MOueV/CRa3rUaV4mCMNI=;
        b=sHTA8rMA7ZGqjOEu+UVx/81MgXfCML2Q3rYlWmiBl3WqvLfZ1/bEe2PBhZI7lozK0T
         MS7F6M/zw80w03y/m101AoNwfI+Foc3WgMDMf7Zn5xXrOQ8M9a2TJ0f+dk67QAGV/yNT
         aR1X58Y4W2cu/OzfrgH4UzHlSZp09tS/WhITv55BVySTUnYyoQ1BX1NEwERII3vA9Qdb
         fxnoJqPfFARfB3TVI2PGv8ywbgniS/bzxC2XALCAEmeqxe+XeeQmN6o1u7urxMWpwa1Q
         qCVAXHmgiF7pMgB2Ik6EuDyaWRguRJCb+RntXbT4O/EP0o3fDeRMgeKza1wJcubZb40E
         n63g==
X-Gm-Message-State: AOJu0Yw+9/l7PlJRVbd3sDT2mG2zALFXAdC6clzavQh+gGIJczDkqPAJ
	lKTKQ2oKfJJVzEC+E2Jp4AfuFps0tFIvMl5kHtA=
X-Google-Smtp-Source: AGHT+IEaFAFrX4fPjPRVsSdkDgWTCffymmrnWwNkLFsedR2NrbugLefIZNxTt2x2ubkIyzg0RGRCKw==
X-Received: by 2002:adf:9dc3:0:b0:320:938:300e with SMTP id q3-20020adf9dc3000000b003200938300emr6872891wre.4.1695113745333;
        Tue, 19 Sep 2023 01:55:45 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:61d9:bcd8:32b9:948b? ([2a02:578:8593:1200:61d9:bcd8:32b9:948b])
        by smtp.gmail.com with ESMTPSA id m7-20020a05600c280700b003fed630f560sm14546094wmb.36.2023.09.19.01.55.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Sep 2023 01:55:45 -0700 (PDT)
Message-ID: <d79dc0e1-8748-4a91-ac9a-967be44a9521@tessares.net>
Date: Tue, 19 Sep 2023 10:55:44 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-next v2 00/30] userspace pm enhancements
Content-Language: en-GB, fr-BE
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
References: <cover.1695095289.git.geliang.tang@suse.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Autocrypt: addr=matthieu.baerts@tessares.net; keydata=
 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
In-Reply-To: <cover.1695095289.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 19/09/2023 06:02, Geliang Tang wrote:
> Some of my patches in ML are conflicted, rebase them into one series.
> 
> 1-8: some small cleanups, v2
> 9-10: address #428, add mptcpi_subflows_total
> 11-17: address #379, #391, userspace pm remove id 0 subflow & address, v11
> 18-20: address #403, add refcont for address entry
> 21: add userspace fullmesh tests
> 22-30: seltests cleanups

Thank you for this series, it is useful (and again sorry for the delay
to review them). I will really try to look at them ASAP, hopefully soon.
I had a very quick look.

Please note that patches 14/30 and 16/30 will need to go to -net instead
of net-next. I guess it's OK if the selftests linked to them go to
net-next because I think they depend on new features you are adding
here. I think it should not be an issue to apply these two patches
before (maybe a small conflict with "mptcp: define more local variables
sk" but easy to fix).

One more thing: we should be able to run the last version of the
selftests on older kernels (e.g. v5.15 and v6.1). I think with your
modifications, we are fine (I didn't test and only quickly looked) but
that's something to keep in mind.

(also, I think we will need to invert patches 10/30 and 11/30 because
patch 10/30 depends on helpers introduced in the next patch if I'm not
mistaken)

Good idea to share code via the lib then having multiple copies!

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
