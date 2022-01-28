Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C39C2C80
	for <mptcp@lists.linux.dev>; Fri, 28 Jan 2022 17:09:20 +0000 (UTC)
Received: by mail-wr1-f52.google.com with SMTP id w11so12114631wra.4
        for <mptcp@lists.linux.dev>; Fri, 28 Jan 2022 09:09:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=FbE7m/AVnAUqeYdGTO5vyHO1tqpGwkwRj0EsKLaZHUA=;
        b=COeZa8GhhvMmgRo0/zdTmYnb8Ek6PuSyhZHv5najuULdCTp59vUj5hjBfzYjwkyBKT
         6aTCZwHkmMWfRdUPjJHBBCqGrHioBGZykiH7NX6QTpsLkXdt+YyHFN9D1a2qpUNF4i9K
         KdHN7thRDNw8iq27BNXfhfg6qRZjNheT0OB9TcmEX+7gggs6D9g2qaK80qzF1TH+BKiG
         m2TuHwH1F+UfcX6RoMgly+EjC2FjfHypNVgWBavn6P8/6HQ77LjBCuzZsFmbmBDrqlPa
         tDfCCG6oO5XUvoYYRal5U/TPV9eN5qVwsOcZc/DEIMNuI7YnZ2zkUPuO21jwt4hE84n7
         KQ9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=FbE7m/AVnAUqeYdGTO5vyHO1tqpGwkwRj0EsKLaZHUA=;
        b=e2odzRJTGSKbQoTg75vMbZJsL6TZx423Sg6ciSam+QWifRz9LFjNfW+JtVaKWi8pG8
         lJUvq5FTDjO2x3JHrAHA+6dT+q2pW0YAbAMzMxr7ZWRXfAHJ/SKjetpEzqL+XziaBy+k
         bzYCW4jWTREvzM77KU8s1K0jFajIt4nyf3t2WXzntpokXVN9EYmkypLoX0jq0oRX3Fnu
         53B34KcXur1P5QMeuk21HAYOGl+X9NcqAWaTlBcf6Hy5jcJ2iiewon4jB3VwiQ98P/ZG
         WHukoyLC3qNh/JncwmfD7hfx8eXULbAnmItHQVDPsILLplY3kW1oQFnEqMwQvILHo3YG
         OMbw==
X-Gm-Message-State: AOAM530w8k1YjK8d0SQGVoFIKrxb+fV4vHhuniHHB/NL8fYUfJA1D97X
	NifOP9kds2wGl1PaS1C4yWCJnF37v6VtPQ==
X-Google-Smtp-Source: ABdhPJws8PPN/F2DujqRgsfs+L/7qCNKMeH91MUXDF/CjrPNmn+hIJSA1yeFNcF6FiEkX7CvwKkOQQ==
X-Received: by 2002:adf:c3d4:: with SMTP id d20mr7737580wrg.55.1643389758659;
        Fri, 28 Jan 2022 09:09:18 -0800 (PST)
Received: from [10.44.2.26] (84-199-106-91.ifiber.telenet-ops.be. [84.199.106.91])
        by smtp.gmail.com with ESMTPSA id i19sm2223539wmq.45.2022.01.28.09.09.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jan 2022 09:09:18 -0800 (PST)
Message-ID: <3e2eb3cb-3e4f-ef3b-4276-9b0b7ec0da73@tessares.net>
Date: Fri, 28 Jan 2022 18:09:17 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH mptcp-next v5 0/2] add the id argument for set_flags
Content-Language: en-GB
To: Mat Martineau <mathew.j.martineau@linux.intel.com>,
 Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
References: <cover.1643165468.git.geliang.tang@suse.com>
 <d03a927-5489-66f8-f137-45a8d1c332ab@linux.intel.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <d03a927-5489-66f8-f137-45a8d1c332ab@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Mat, Geliang,

On 26/01/2022 22:45, Mat Martineau wrote:
> On Wed, 26 Jan 2022, Geliang Tang wrote:
> 
>> v5:
>> v4:
>> - update the output of pm_netlink.sh
>>
> 
> Thanks for updating, patches look good to me.
> 
> Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>

Thank you for the patches and the reviews!

Now in our tree (feat. for net-next) with Mat's RvB tag:

- f8e513817b09: selftests: mptcp: add the id argument for set_flags
- ec38992d3ed7: selftests: mptcp: add set_flags tests in pm_netlink.sh
- Results: d57649f20e6e..6cf1fda75aaf

Builds and tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20220128T170856
https://github.com/multipath-tcp/mptcp_net-next/actions/workflows/build-validation.yml?query=branch:export

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
