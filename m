Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61B482CA8
	for <mptcp@lists.linux.dev>; Sat, 18 Dec 2021 09:06:28 +0000 (UTC)
Received: by mail-ed1-f54.google.com with SMTP id j21so12544622edt.9
        for <mptcp@lists.linux.dev>; Sat, 18 Dec 2021 01:06:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=dtMEk67KgzWzoRfyyBIWiM/l2FM9B6/fac0GUu0fV7Q=;
        b=Y8dFhv8RAs81r6lz6Jm7qm2njVtOtYrb7xaaIjMBQbQD4ks2XL2NBxLjUGP9tSrEeg
         uoiXwrVE1uxb2rThcpvA6z9OlDi/rnQagXZrRWW+H+A4SlpemrS1sGcmBze5INgrXN33
         BQJgiCQhNFErlRBENt7V1c3a2qDTNk4qdu1+krqhzp3tspREEbDXgLbIXcVWpLCEfu/o
         cUQPLpnnjhpVEQzUeoYglU/4VDVpbTcGmlszSFnSpDOOAMre8uRIfmK0klJXkSu89SXK
         zg6cgbkvyrf0Jt2xtJ3JXyhBthriUaK0Xqe5pgRU2KqcayRUN4Z9dRwTpGxICqx4C0V8
         mGLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=dtMEk67KgzWzoRfyyBIWiM/l2FM9B6/fac0GUu0fV7Q=;
        b=NMU4LLJRKLRvUboMAcLrchgvbsD7avO/qt2rf3aYAT56knKmhZ7iBzNiuVzlFtSwWm
         9l6UxqG3tRPllNNl8SP/mQVcIWbPppDlzDpEOBVBflizFLDqhhm7rFhd4a7W1b+PPyrx
         OvFfKMzusqx7YjwggXkBHy2xo+Vn9b1mbqSsU4cqQV7Z8UWPhmj8Gb2V+RACE2ErKnQy
         e5/g3F2lFXrUZUHVTUnuNsEN6pCk5I5clf5vrwsN4LwW6a3wjfen8ursXtkTALFjpCah
         lhF8xRWM6yKeCfiFwCS06KVUpXo5RWJBkhYrb0h492cWdr6nynUuXqDa4d19SfFZogVR
         xt0g==
X-Gm-Message-State: AOAM531aD1rZkYfEpZmyOdPpUyPv+22KnBCenJT8ngVhLLc/pWBNtrLJ
	bdxMaMbim2sUxlPP7dlN+KyEt9DKEvqaIkNI
X-Google-Smtp-Source: ABdhPJzpbef/54DUQeKb58W6NAgK2MOIeKRdNeejvdPDPsmtG9mFfzF9TIENNBJVbGMwVX6cQNYKQw==
X-Received: by 2002:a05:6402:5246:: with SMTP id t6mr6381060edd.18.1639818386679;
        Sat, 18 Dec 2021 01:06:26 -0800 (PST)
Received: from [10.120.18.55] ([84.17.46.18])
        by smtp.gmail.com with ESMTPSA id c28sm3526055ejj.207.2021.12.18.01.06.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Dec 2021 01:06:26 -0800 (PST)
Message-ID: <aefc6de6-8211-a88f-456a-153ac5c485cb@tessares.net>
Date: Sat, 18 Dec 2021 10:06:25 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH mptcp-next 0/2] reuse __mptcp_make_csum in
 validate_data_csum
Content-Language: en-GB
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
References: <cover.1639722883.git.geliang.tang@suse.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <cover.1639722883.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang, Mat,

On 17/12/2021 07:38, Geliang Tang wrote:
> Two cleanup patches for the data checksum.
> 
> Geliang Tang (2):
>   mptcp: change the parameter of __mptcp_make_csum
>   mptcp: reuse __mptcp_make_csum in validate_data_csum

Thank you for these patches and reviews!

Now in our tree (feat. for net-next) with Mat's RvB tag:

- 3d0fe9f4a4ff: mptcp: change the parameter of __mptcp_make_csum
- 4990d2f45261: mptcp: reuse __mptcp_make_csum in validate_data_csum
- Results: 079ed80abcff..23b272a3d65a

Builds and tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20211218T090448
https://github.com/multipath-tcp/mptcp_net-next/actions/workflows/build-validation.yml?query=branch:export

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
