Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 520B72C81
	for <mptcp@lists.linux.dev>; Mon, 18 Oct 2021 17:04:24 +0000 (UTC)
Received: by mail-ed1-f52.google.com with SMTP id y12so2165542eda.4
        for <mptcp@lists.linux.dev>; Mon, 18 Oct 2021 10:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:cc:from:in-reply-to:content-transfer-encoding;
        bh=ULVG8/SWOO1QSLB+nShgf+NV6sAA3qhcJLLwzGtdjZM=;
        b=zW7DcGE21btlvRQ3G7EzE2kLFmdliOxBckcMIs8CWWClupOqjcIw5qUSEyhALyqc9J
         01ePkQapSDWbtaEv1U9nsaDTx4DGo8Fn2hX+d0BBL78YBwI1aWB3MJI9FR2ViwOAtn9s
         PsnTHAKauMW6CotokBG0wl5RLtWKOJLG9NwqW+EQWksyN/tKgWlOIlnuTmN5Yemdl0t/
         KaNsF42nwtcywvjUViAWXze/rd02nCGoh9heu542gpSPPsRZ4Sv3aM0bi2flosJkcE2T
         P98Ms0qqShDooDddZQS4IHneuGoMBo4PSSg7Kkf2G553A+TBQKdRiNyDaoxNZIBezpdN
         iygQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:cc:from:in-reply-to
         :content-transfer-encoding;
        bh=ULVG8/SWOO1QSLB+nShgf+NV6sAA3qhcJLLwzGtdjZM=;
        b=HhbMlETE0j3O6N3MaaEmNTvfPaAzuGIpOO8XUqdSXDHGbY0qurZOJdKqsZ5rxqj15o
         Mfr0fZLHhIKIsg5n7iSOZ7Zkbk4kGOF2txsiHiznhtBG7b6Dk+MYAoj/rKKG0SGLQ320
         p0lVCBcsNl7fG5bGgSWXXQbo75TCIdsUOMkA0CuqPgl4I3EHimmDvtgn+8Mij1NyxpB6
         XrxI5SR84wJbPKqPPRjBmpJXJGWbEVUvfaMPcr8zzNeMBG+aiYdchzTfW07b7gh+r4S1
         fmZIYt0Ra68/yQj0LZFPkXeF/M0pWlsIbkN8ECVr+f2CNlfuC8TCBpwane+niZhY8Vsh
         pp2A==
X-Gm-Message-State: AOAM533Ra0jSl+PNk6Sh59DnQ8uM4eg+mn/gaE5MnzD5DOdnod91rbDM
	42fTIU8amkGh3HRdoEclltjiRtmBqMAv1wvzEZY=
X-Google-Smtp-Source: ABdhPJxgbRXutStvmAlpddoCPWnCUNsPdvqzprj0hA3AnT7mGTFflO+aGzipzfHdn07Y+e1KCTvHLw==
X-Received: by 2002:aa7:c783:: with SMTP id n3mr45845589eds.122.1634576663149;
        Mon, 18 Oct 2021 10:04:23 -0700 (PDT)
Received: from ?IPV6:2a02:578:85b0:e00:549e:a93:d8e8:be6e? ([2a02:578:85b0:e00:549e:a93:d8e8:be6e])
        by smtp.gmail.com with ESMTPSA id a1sm9918369edu.43.2021.10.18.10.04.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Oct 2021 10:04:22 -0700 (PDT)
Message-ID: <f93520a8-d05b-f278-f61f-11fd3dfb21a1@tessares.net>
Date: Mon, 18 Oct 2021 19:04:21 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.2
Subject: Re: [PATCH mptcp-next] mptcp: drop unused sk in mptcp_push_release
Content-Language: en-GB
To: Geliang Tang <geliang.tang@suse.com>
References: <0177e007bc31fd8e5783b115b66c6b18d3dd2387.1634528367.git.geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <0177e007bc31fd8e5783b115b66c6b18d3dd2387.1634528367.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 18/10/2021 05:39, Geliang Tang wrote:
> Since mptcp_set_timeout() had removed from mptcp_push_release() in
> commit 33d41c9cd74c5 ("mptcp: more accurate timeout"), the argument
> sk in mptcp_push_release() became useless. Let's drop it.

Good catch and thank you for the patch!
It is now in our tree (for net-next) with a Fixes tag.

- 04e012677aa1: mptcp: drop unused sk in mptcp_push_release

- Results: 2c9a91c34b69..cec4678228e9

Builds and tests are now in progress:



https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20211018T170406

https://github.com/multipath-tcp/mptcp_net-next/actions/workflows/build-validation.yml?query=branch:export/20211018T170406

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
