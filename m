Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7714B62B
	for <mptcp@lists.linux.dev>; Sat, 14 May 2022 10:05:41 +0000 (UTC)
Received: by mail-ej1-f43.google.com with SMTP id ch13so20297448ejb.12
        for <mptcp@lists.linux.dev>; Sat, 14 May 2022 03:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=CQbgtAr/ZhV+wZhAyhJAujaSIPZALxZPOiUNU4jSo8A=;
        b=7Ajipl5b/6ZOIHPhBCUIft4iqB4I4fY9oQRd9tnKj4mY0Zs12iVVaUnJyO718xx6zm
         Sgm5+ROOAKxcghMktO/Px0m6nnhui3wNOZR3t74qdZYhb8X1ULiMI+g8TxIP7FhQd4ZS
         V+WCnAsKoAqORx/md7hKELQjeIzm+ms4E7Wb9pDIj5X90fxfPOEyn5Xz+fAMix+k6Tmr
         keKhYH5KwBRpqoyftD/QFjOt4dpe/xLtk9qNJTyfUTZ1j2i8/2yxbJp0NlV84lqJxaS+
         ERghMmQXa9svxTGD0wiPvG2rnpK27nyMPyJH7MXLtioUnt52/MS5P85D5b150mgWNsgG
         YKzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=CQbgtAr/ZhV+wZhAyhJAujaSIPZALxZPOiUNU4jSo8A=;
        b=SFZLFbf6FlF8Z+KJyQFUlGBgRvpX7EryeJjdgFby0cUdj89u2jKvT2T1+p+nddaB5Z
         jif3mPRJ9b3l80gFm1qWFgBQlJFOmLiO20qzd9E42jKhXJtaFPNa2NoC5rJ5FqIESF+x
         +xMEZ1HXSgkVTpPDhVQOivq75UYo5ggdpcA/cAVvZsMcuSBUS2nsoujZ8OgNYi6oI26+
         CJuQfKiDzPMehw7Woyv1LikoeW8G2tdA1gb8qrQrgFHvNwJK25aVx4xuGpRjXz3sXpdD
         o3ztAFOvjUXsr4shsmfg7r83K/je3UQ8HxNRTg7/PhF4wMatzX33ka5dkYSQ1v346M7M
         jkHQ==
X-Gm-Message-State: AOAM5323LrHavpFpVUFkQ90XddjBS3/HxFFsk2wPT1bbJFaD4p5fzJHW
	iNOoIFuVveRiuX05sc10xf4UmrgU+I/hKg9Xns0=
X-Google-Smtp-Source: ABdhPJxkdhfc3gt09Kvzl0+kpF1J5fqKeQtvyiV5r2sfDpnj31ka7cYl68YFl/3D6dSIbelo4oNoUg==
X-Received: by 2002:a17:906:d54b:b0:6f4:cea3:843b with SMTP id cr11-20020a170906d54b00b006f4cea3843bmr7458022ejc.40.1652522739168;
        Sat, 14 May 2022 03:05:39 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:764e:bcb8:669d:8965? ([2a02:578:8593:1200:764e:bcb8:669d:8965])
        by smtp.gmail.com with ESMTPSA id f15-20020a056402160f00b0042617ba63a6sm2091911edv.48.2022.05.14.03.05.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 May 2022 03:05:38 -0700 (PDT)
Message-ID: <896634ab-bb72-bbc0-19c8-4e14b6ead723@tessares.net>
Date: Sat, 14 May 2022 12:05:37 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH mptcp-next] Squash to "selftests/bpf: test
 bpf_skc_to_mptcp_sock"
Content-Language: en-GB
To: Mat Martineau <mathew.j.martineau@linux.intel.com>,
 Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
References: <6de915f94665491d2944dd7aab1e6f7a0f3abcaf.1652156539.git.geliang.tang@suse.com>
 <45f492b2-1b41-9681-2fac-9cd59dd0f6b@linux.intel.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <45f492b2-1b41-9681-2fac-9cd59dd0f6b@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Mat, Geliang,

On 11/05/2022 01:03, Mat Martineau wrote:
> On Tue, 10 May 2022, Geliang Tang wrote:
> 
>> Drop bpf_mptcp_helpers.h, squash into bpf_tcp_helpers.h (Andrii)

Thank you for the patch!

> Hi Geliang -
> 
> Since there are 6 different commits touching bpf_mptcp_helpers.h, maybe
> it would be easier for Matthieu if you posted the full patches for
> "selftests/bpf: test bpf_skc_to_mptcp_sock" and all the bpf patches
> after that, instead of squash changes / instructions?
> 
> I'm not sure the instructions below translate well to topgit.

Sorry for the late reply. In fact, I prefer to get squash-to patches
instead of reworded patches where I need to find differences :-)

If there are conflicts, I'm usually fine with some explanations in the
commit message. Here, the conflicts are easy to resolve: just move the
content of one file to another one. For these conflicts, I don't even
need the detailed instructions but that's always useful, just in case.

If the conflicts are harder to resolve, sharing a Git branch on a public
repo is an easy way for me to compare the resolution I did with the
expected one.

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
