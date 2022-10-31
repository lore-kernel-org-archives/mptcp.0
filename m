Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BACB47E
	for <mptcp@lists.linux.dev>; Mon, 31 Oct 2022 16:02:44 +0000 (UTC)
Received: by mail-wm1-f46.google.com with SMTP id l16-20020a05600c4f1000b003c6c0d2a445so8301114wmq.4
        for <mptcp@lists.linux.dev>; Mon, 31 Oct 2022 09:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e5EbZbsCczKeRGwCGAVG5Fak3XqoDJP/1V0TIOCTaUs=;
        b=btV5mDGIfG7bg2FXrKQfdJq24A2ziwN8YFiJv3USmM+JULM6/fYpnq6TA42f/+suf+
         1N1wIIB2hHLp/wKjvQP8IVzd0ywf+gTLwLNnVsjL7FLhJpQgNtGeQS5HhJY4oDVs9a5k
         4aJjDURXluY8enNIzStrp6Z9QIK355nuF6jnVjIsqmPN8znfAVd0ueev6noE3HqyggwD
         mFeHa7VwKU9V365K1/eVPcOZLlejY6EyANVzB/c3muqYoedurj/sVZDsWYZ23N2FmUjq
         iH4pHKtYa7Wz3WgzJkXRdwD24gyIDBwnWPtNs818er/xp3y4HcQ2aMyqwk0hfNMwvWLF
         4+0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e5EbZbsCczKeRGwCGAVG5Fak3XqoDJP/1V0TIOCTaUs=;
        b=GQhgk9RDpD+KsWyRlV9C7Ee5kcfmrETRQ0rc6qo/08P9hYLYQv1iXnXx4pAUyfKOfq
         ZsJPNrKS9fTCNfb6kSZ2UuSKdrkXw3StwSmPiJyxBO0MDT0SdJ/QULZVSTLBXQSxFETS
         xZidtosrIxXbVIn1xBb7MlcYN5LJN1tBiuMooZtk9TJnUYNIytjVzA7H6Qu6mcWT61CM
         BPa88xC5ovxRvu+739hfx07Eu9qV1DCEtCq7OCD4BLciszEgjdHM6YXKRIDPVyMjjc2D
         E6+gVGfOEbUUpzZFPHpatBO93LdtnLmDS6syeYl0cvR9R6WF5SlWPc7cC2ltrACsGpoe
         O3CA==
X-Gm-Message-State: ACrzQf0KdyWZCtMoH7D4NYQXB4B4vBuXlv5scMyWvd7bbufaScnWjegv
	j92TSi7aNGE7HJzZqnJhao17EQ==
X-Google-Smtp-Source: AMsMyM5MTdf3R+L1PkmjThdlVEnDMQy7Ofr5KnqxF+1etKeVrQGfWF/zTyoyJ6LE53XG3qaERttHsQ==
X-Received: by 2002:a7b:cc8c:0:b0:3cf:7b8c:d18a with SMTP id p12-20020a7bcc8c000000b003cf7b8cd18amr198660wma.0.1667232162770;
        Mon, 31 Oct 2022 09:02:42 -0700 (PDT)
Received: from [10.44.2.26] ([81.246.10.41])
        by smtp.gmail.com with ESMTPSA id h17-20020adfe991000000b0023657e1b980sm7414488wrm.53.2022.10.31.09.02.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Oct 2022 09:02:42 -0700 (PDT)
Message-ID: <5189fcad-f347-ca4d-473d-547ea9fe47aa@tessares.net>
Date: Mon, 31 Oct 2022 17:02:41 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH mptcp-next v2 1/2] mptcp: use entry->lsk directly
Content-Language: en-GB
To: Geliang Tang <geliang.tang@suse.com>,
 Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: mptcp@lists.linux.dev
References: <cover.1666780919.git.geliang.tang@suse.com>
 <6c8c57c5a419395f8f4a23aa8e3f76c830f0c12f.1666780919.git.geliang.tang@suse.com>
 <673ea417-59a7-bc9f-9e09-d290417ceae9@linux.intel.com>
 <20221028111256.GA2511@localhost>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <20221028111256.GA2511@localhost>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang, Mat,

On 28/10/2022 13:12, Geliang Tang wrote:
> On Thu, Oct 27, 2022 at 12:50:03PM -0700, Mat Martineau wrote:
>> On Wed, 26 Oct 2022, Geliang Tang wrote:
>>
>>> This patch drops msk and ssock in mptcp_pm_nl_create_listen_socket(),
>>> use entry->lsk directly instead of ssock.
>>>
>>
>> Hi Geliang -
>>
>> The change looks good, but the old code looks buggy. Seems like it would be
>> trying to re-bind the nmpc socket each time a listener socket was created.
>> Is this a fix for mptcp-net in your opinion?
> 
> Yes, this should be a fix. Please add this into the -net section when
> merging it.

Only this patch 1/2 should go to -net I suppose and with this tag, right?

Fixes: 1729cf186d8a ("mptcp: create the listening socket for new port")

Also, I think the commit message should be improved to describe the
issue that is being fixed. Currently, it sounds like it is a simple
refactoring to me :)

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
