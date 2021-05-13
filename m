Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E40672FB1
	for <mptcp@lists.linux.dev>; Thu, 13 May 2021 07:46:46 +0000 (UTC)
Received: by mail-ej1-f42.google.com with SMTP id t4so38700725ejo.0
        for <mptcp@lists.linux.dev>; Thu, 13 May 2021 00:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=3cJiHQBtEGkH9n4vqOz/EURApAiaRvpZojoG6Ow2pkk=;
        b=TtNLahayzstiMkESoxpsUdUL3S6XnC9TzmdO6rzalB2RI4RzDpOPUNQDuvEcTHaHFJ
         tgDyWhh7wvxUnSNMju96Ynkz97CMBHYGRONc5MJMN/2vgstam5hEp83FKxEr8KdSOWah
         SRmljiAlWSQk9IMLFZhdzwoCsBI0rPWADqf4ZMWrBj54dVejTqmjTzNZ+yTLR3gPlMn5
         /7nP0JFSsrOXQmFDHYIHr5a9P5BjUe1iZDBYKoHfURhuHeRMMMeWtPjrYkzn868kJEWU
         uStCKEkcB1sEsrMADs+fSIpOmcttsND+d86jG0mX5cM7iVwlH9w1J9eXbxQw/zh+LZAE
         sfoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3cJiHQBtEGkH9n4vqOz/EURApAiaRvpZojoG6Ow2pkk=;
        b=rpt7Ir5ze2TQIMep/urb3Lg8eWejm7nk+IGxTVkBBt/Mhmz5LKnfz9doKHeW3Bq/QB
         B58r9YNqSHbA8rLp4fFXB159VxuQ77Nh8+YXzJB7IdVe3Ifs5t49VKVonudprwKmI/+x
         MZ6IIORvKWA/1hqHTPpV5CTJoNamf0oadTgdZtcw6gP2lwkUQrWK9WfgFO19SNQk8EfM
         c8uHcUn58iSqh25uSMcVBYZBKkst7QyLKGzrCO9CZFFq4bPAFUvzxo/j9ZNfILLPpAjv
         PogtSeXwkSaDefLOp0dLUkE3UYyW76LybuExPMC3yu6hOFuefUch/2U/Ca+1HGhu55QB
         pUjw==
X-Gm-Message-State: AOAM533ekHJWZw+t9NJSF5tXZ+CIC4DVhl1D4YdRrhnLInNs1r9Abc/R
	x89U7/uiAUtQWuxwX1Xh/ytqXbrw1adj/pvW
X-Google-Smtp-Source: ABdhPJyZoDp4d111LJMFY/QLrtdZP8TBJZ26fYvCrDXr7q2ziiGEIiDqtH09pQbwKmUUtcALX7lReQ==
X-Received: by 2002:a17:906:79a:: with SMTP id l26mr41916803ejc.268.1620892005403;
        Thu, 13 May 2021 00:46:45 -0700 (PDT)
Received: from tsr-lap-08.nix.tessares.net ([2a02:578:85b0:e00:8928:ef6b:4f39:1fcb])
        by smtp.gmail.com with ESMTPSA id cr21sm1344464ejc.2.2021.05.13.00.46.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 May 2021 00:46:45 -0700 (PDT)
Subject: Re: [MPTCP][PATCH mptcp-next] Squash to "mptcp: receive checksum for
 MP_CAPABLE with data"
To: Geliang Tang <geliangtang@gmail.com>, mptcp@lists.linux.dev
References: <894be7ae85244360c4dd5a250043086d3bbc8826.1620792920.git.geliangtang@gmail.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Message-ID: <3f87e8e4-4456-04a6-17f6-4a5e8302f954@tessares.net>
Date: Thu, 13 May 2021 09:46:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <894be7ae85244360c4dd5a250043086d3bbc8826.1620792920.git.geliangtang@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit

Hi Geliang, Mat,

On 12/05/2021 06:16, Geliang Tang wrote:
> Drop the csum_replace2 trunk as Mat suggested.
> 
> mptcp_make_csum() hasn't been called yet so the pseudoheader has not been
> included in the checksum.
> 
> Signed-off-by: Geliang Tang <geliangtang@gmail.com>

Thank you for the patch and the review!

Now in our tree:

- 54133a0eca73: "squashed" in "mptcp: receive checksum for MP_CAPABLE
with data"
- 54133a0eca73: Squash to "mptcp: receive checksum for MP_CAPABLE with data"
- Results: f8de7f4600ea..655ba588ab88

Builds and tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20210513T074617
https://github.com/multipath-tcp/mptcp_net-next/actions/workflows/build-validation.yml?query=branch:export/20210513T074617

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
