Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 211392C80
	for <mptcp@lists.linux.dev>; Thu, 20 Jan 2022 15:12:31 +0000 (UTC)
Received: by mail-ed1-f48.google.com with SMTP id j2so29958769edj.8
        for <mptcp@lists.linux.dev>; Thu, 20 Jan 2022 07:12:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=oM7q/JVM+F82jumqr7LfZjcOWhRDbs/5matq7eM8e6Y=;
        b=R1xwpGOuDjx7qFUugpiVtYup89OhMjxfMFhz7dou2ibBBtj4e3OaeG+6B1VVWLVxcu
         wqY8diqrNhBIq6UitVlLxo9yHuoKeAloAiZE0jnq1XZ93uVD7k9X0j7/PakFvHqwkqGt
         /bnr4meJwFvMbJZGx9mF3nH8OOtC1UA4lJBDnAfVezbGeTKJE0GgFdKw/mIzoSqofMpd
         jQGo/a5ASGDCdk+h9/CjNdEEsN7R5MrPAwOOg7ZLfHw7ro9qkyKigdYhUikxBcg37VVc
         Hiyfnx/qCWclvyErLd+N8X2YteLRRD+gjAE/+w2H6BszeiEeuddIVMhaOD2o1j8aAvbW
         xBNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=oM7q/JVM+F82jumqr7LfZjcOWhRDbs/5matq7eM8e6Y=;
        b=iEFco4cOUBVJRrkyE3Donxy/9KhE+TjTx4/CLhaHQDxIM4IQLdmk9AXTH87YoaD7jb
         lCkFt92UZgY0Xz6xVWExwwBUQ9EZd1zUIDeyd2mFz1dndzWgu2YXTRa6tidqZ7DwpGeX
         3SW7fjSD3PZNE9LzoR/PYXnsNyPDcZkFuTIirRQDbP5BMdbInn5DpDPrbSMXS0TOiMcM
         c5bDHLLZe3h3x2Z880XKu2uMgPOJPmoNl0gnpMuXlzysgw0+42ABiS4zXTciNUUYXRRz
         pmWoJPnmhejFhlsCehJist7QUhM5NZftk4CcRsF5lJ0ATkyty4VFiQljZp/WcGolV7wB
         uBiA==
X-Gm-Message-State: AOAM531w+lmp8rBCxkSHYU7B9OzJZEsS83och3yN4vZoot894153qz/t
	2W63McmFB5zJKGLCeaYw7JxKaQ==
X-Google-Smtp-Source: ABdhPJzQ76VqOm7i99xV5Rr39wmDZGFugZXHiYdBTrGogapOnt6HffyRXnZb+0v+4J5j2ei45uWnnA==
X-Received: by 2002:a05:6402:22a6:: with SMTP id cx6mr3414415edb.253.1642691549373;
        Thu, 20 Jan 2022 07:12:29 -0800 (PST)
Received: from [10.44.2.26] ([81.246.10.41])
        by smtp.gmail.com with ESMTPSA id k6sm1462812edx.41.2022.01.20.07.12.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jan 2022 07:12:29 -0800 (PST)
Message-ID: <aa6378df-ca44-e4ee-b931-8cf822cd0f8d@tessares.net>
Date: Thu, 20 Jan 2022 16:12:28 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH mptcp-next v3] selftests: mptcp: add invert check in
 check_transfer
Content-Language: en-GB
To: Mat Martineau <mathew.j.martineau@linux.intel.com>,
 Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
References: <ed191af941837d4c63ea37a9a863dc39904571d2.1642570570.git.geliang.tang@suse.com>
 <d6e12420-bc8e-9369-8acf-702539b2fe87@linux.intel.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <d6e12420-bc8e-9369-8acf-702539b2fe87@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Geliang, Mat,

On 20/01/2022 01:06, Mat Martineau wrote:
> On Wed, 19 Jan 2022, Geliang Tang wrote:
> 
>> This patch added the invert bytes check for the output data in
>> check_transfer().
>>
>> Instead of the file mismatch error:
>>
>>  [ FAIL ] file received by server does not match (in, out):
>>  -rw------- 1 root root 45643832 Jan 16 15:04 /tmp/tmp.9xpM6Paivv
>>  Trailing bytes are:
>>  MPTCP_TEST_FILE_END_MARKER
>>  -rw------- 1 root root 45643832 Jan 16 15:04 /tmp/tmp.wnz1Yp4u7Z
>>  Trailing bytes are:
>>  MPTCP_TEST_FILE_END_MARKER
>>
>> Print out the inverted bytes like this:
>>
>>  file received by server has inverted byte at 7454789
>>  file received by server has inverted byte at 7454790
>>  file received by server has inverted byte at 7454791
>>  file received by server has inverted byte at 7454792
>>
>> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
>> ---
>> v3:
>> - add the check_invert flag, do the invert bytes check only when this
>> flag
>> is set.
>> - use 0xff directly.
>> - update the output log.
> 
> Hi Geliang -
> 
> Looks good to me, thanks for the updates! Please update "selftests:
> mptcp: add mp_fail testcases" for the inversion check.

Thank you for the patch and the review!

I just applied this patch at the end of the "MP_FAIL" series in our tree
as it is there for the future "selftests: mptcp: add mp_fail testcases"
patch I guess.

- c118cb35a603: selftests: mptcp: add invert check in check_transfer
- Results: e974a42412b3..750c4599c0cf

Builds and tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20220120T150902
https://github.com/multipath-tcp/mptcp_net-next/actions/workflows/build-validation.yml?query=branch:export

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
