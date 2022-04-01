Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A9431367
	for <mptcp@lists.linux.dev>; Fri,  1 Apr 2022 14:01:51 +0000 (UTC)
Received: by mail-ej1-f53.google.com with SMTP id bg10so6090736ejb.4
        for <mptcp@lists.linux.dev>; Fri, 01 Apr 2022 07:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Q1lcpXj0tA+qrmBqBWaO84Qd1GXGQQ30EBs541/V/JM=;
        b=KcCB9Dwi4L2wH4XuLBCUe5lwvy//bOnw4oRd073YfukwNIEbKfQiEC1EtsIHjfVyc7
         6tge+1uo0LIk+XDZrgNb/QWtb+nXjjIGWZIqVBAEB3YlJ0eK0w9gl0IPXpianw8+d7j7
         Wyhtk215cWS94Cc1T12Y2epqPcBLwM9BgI+BBTYsDOOFcbSA7k1dNYBqWCDxKwiDpvyR
         36bAWtOenoQP4GCHLgy8YgO9FhY0gBVgZO2EJ2dy9UFwsuJjqNqcrZil4Er/SZJQRdcD
         R0vSLeBpl8feS2agH8c0G+0e7P+PRC4dDzzRR9ixN8PJzSHcHhjkOAk4X8ERfPaBMZ0V
         8AUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Q1lcpXj0tA+qrmBqBWaO84Qd1GXGQQ30EBs541/V/JM=;
        b=DY98myn9u9S7Ynaq3EQw+ekz9/Gu55Ci6o1T2XlwOaDHvw4+qm+RRneJ7ekNESrcFv
         YTtkfgsYc/tPBRgRPXdVhm48tNNX0o4RQZhJe5bj2ekCaPmmy8nMOMXXGgouYZOhfYui
         zHynmM8ssne6n5mUcI1NgtaEVa3k+ZehQqrs4sC9IvsTSRJd4Q3CWLnVPReMZAbN71hF
         rZUQLtjLo8kSGdqAytruubDqw5FEuGs0WogPDVCcAqV//TzSSqs7vfqDUGXVWNXPhNy3
         OEQvQFaScNZbhs10pbUOyK1SX92LoJrZusJ/QsqlLYv4DOJrBXtjIyRIllrqVX9bUO5H
         sJYg==
X-Gm-Message-State: AOAM530O+GremJ+TPX38cpNMANgBqRMbm9S21v7v0d9gu9LWQMUP4Dsn
	CWqetUpmf7cjiP7DOZA0SRbgDaW1eRwzB2uD
X-Google-Smtp-Source: ABdhPJyDOLXOdjbkc6S+odutC57jKtTKy1BnWoZDAUlfD9bJAGpXji0rKMNsvQGxfjZE3+8RgYssnw==
X-Received: by 2002:a17:906:c145:b0:6da:f8c8:34f1 with SMTP id dp5-20020a170906c14500b006daf8c834f1mr8964735ejc.310.1648821709197;
        Fri, 01 Apr 2022 07:01:49 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:65cd:a27f:e743:cc46? ([2a02:578:8593:1200:65cd:a27f:e743:cc46])
        by smtp.gmail.com with ESMTPSA id r22-20020a17090638d600b006d584aaa9c9sm1067906ejd.133.2022.04.01.07.01.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Apr 2022 07:01:48 -0700 (PDT)
Message-ID: <e9271f28-9ad7-8744-65f3-a8fe51c7d984@tessares.net>
Date: Fri, 1 Apr 2022 16:01:47 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: Commit logs update request
Content-Language: en-GB
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: Geliang Tang <geliang.tang@suse.com>,
 "mptcp@lists.linux.dev" <mptcp@lists.linux.dev>
References: <HE1PR0402MB34974081CB4E91797BF80DE1F8E19@HE1PR0402MB3497.eurprd04.prod.outlook.com>
 <8bf4ccea-7095-0183-66b7-40e19af72dfc@tessares.net>
 <69e6641-8e9c-43d1-aa29-bde79af009f@linux.intel.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <69e6641-8e9c-43d1-aa29-bde79af009f@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang, Mat,

On 31/03/2022 19:09, Mat Martineau wrote:
> On Thu, 31 Mar 2022, Matthieu Baerts wrote:
> 
>> Hi Geliang,
>>
>> On 31/03/2022 17:46, Geliang Tang wrote:
>>> Hi Matt,
>>>
>>> As I mentioned in the weekly meeting, I noticed some of the commit logs
>>> of my patches on the export branch became mismatch since changes have
>>> squashed to them.
>>>
>>> Here I send a list of new commit logs. Please help me to update them.
>>
>> Thank you for noticing that!
>>
>> @Mat: because your RvB tag is on some of them, are you also OK with the
>> modification?
>>
> 
> The updated commit messages are all ok, thanks!

Thank you for having checked!

I just modified a bunch of commit messages. I didn't add Mat's RvB tag
where it was missing but I guess Mat will add a SoB anyway when sending
them upstream.

New patches for t/upstream:
- 45bd4e88d059: tg:msg: update from 'Commit logs update request'
- 608979779671: tg:msg: update from 'Commit logs update request'
- ff5034728c57: tg:msg: update from 'Commit logs update request'
- 26d0a0be59de: tg:msg: update from 'Commit logs update request'
- d681b1dfbe3c: tg:msg: update from 'Commit logs update request'
- 001e9d359899: tg:msg: update from 'Commit logs update request'
- 4ea8489f01ce: tg:msg: update from 'Commit logs update request'
- f86dbe52aa55: tg:msg: update from 'Commit logs update request'
- 99fe1bfb5fdd: tg:msg: update from 'Commit logs update request'
- d0167e625579: tg:msg: update from 'Commit logs update request'
- 3cecfdde5dc3: tg:msg: update from 'Commit logs update request'
- Results: 7ee50b5fce5a..c56ab3a9d998 (export)

Builds and tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20220401T135831
https://github.com/multipath-tcp/mptcp_net-next/actions/workflows/build-validation.yml?query=branch:export

(but it is the same content)

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
