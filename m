Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8D0F174C8
	for <mptcp@lists.linux.dev>; Wed, 16 Aug 2023 16:31:27 +0000 (UTC)
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-3fe4a89e8c4so62319835e9.3
        for <mptcp@lists.linux.dev>; Wed, 16 Aug 2023 09:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1692203485; x=1692808285;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=H2CicINKgqUXLRMfiChTteM+6EzJzO2nxVRPMlt/Fcs=;
        b=Wy/IF44Od/oSnwb+bYBnNkvbB4v3xJxnqJjxguA67g3GT5jMeGgwKZVLnjl1qXPPrR
         R7lYTK4XLq/YUOOUmJMKOWvtbaNPdyN73vkokMjgaagabTJob5poEcpRPAoADfqamfg5
         mUsl3TrEi5O27y/w4Br0ai7E5oafwWgVEo9Act47MUzpwzux3whInO8IvRbhsyI7IqaW
         JgnpmluVMnn0QrQ5lLkBMdHBemtvjD5y7ndacPuYUlN8WFpgZKDyiWGPlppVZ47n2GnX
         E2nhYfareJMOhCnISPa55XcSEZYK6zUzNNf4lJzWWaBCyIg6wQO59nNhZkrmaXtQxTNp
         N2Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692203485; x=1692808285;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H2CicINKgqUXLRMfiChTteM+6EzJzO2nxVRPMlt/Fcs=;
        b=bI1IAFltsrK397mo7LY+NeVeB1Gw+WOt88icbfmGaWJVVPGlkTzfKrqlHoI97JCb2t
         XHrO/cEfFTkRNA3xDbeUtFb990z8shjJa6UFuj8tS5MRT5QRKquWET3Z9aBGnpfRtdYG
         FNHyVMnI5YwGq5QxXXYQwhe7O6LaZRXk/+EEZbMpItMGmCuvv252p4t8ltfx0ymU0eMG
         X+G3sqIhc4Eslx0TULIk94l8YevnQJopz8DYUqbzF+EEEEty0DZ9CsbOY8Stoyvtr/rY
         wPetHF4teGfW0K3aa6QFTzO4qRpjeRJn62HqoBxd1e7Xl7ekhS68bz/Rlu7yEvGUvrTZ
         c4ig==
X-Gm-Message-State: AOJu0YwKSFGQGrweFj9EcAdxXNMEDi9ut+b1BylJM06oxcO7/+fDjHkh
	oOpLj1NJ2FE22QyGJimlE4hoybmOdU0BXdJd+2Y=
X-Google-Smtp-Source: AGHT+IE2Bx/9hZQxo87cHkBQjYBU6FMQvTsWJ7S20o5OtFtf0rPHuWGaaA09gE5QANgLxCLfo7o8oA==
X-Received: by 2002:a5d:4529:0:b0:317:5d3d:d387 with SMTP id j9-20020a5d4529000000b003175d3dd387mr2267553wra.25.1692203485521;
        Wed, 16 Aug 2023 09:31:25 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:9191:2283:c4d7:5cd7? ([2a02:578:8593:1200:9191:2283:c4d7:5cd7])
        by smtp.gmail.com with ESMTPSA id x7-20020a5d6507000000b003143b14848dsm21626245wru.102.2023.08.16.09.31.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Aug 2023 09:31:25 -0700 (PDT)
Message-ID: <ea9957c5-f58b-4ca0-8cda-05c796f76f69@tessares.net>
Date: Wed, 16 Aug 2023 18:31:24 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-next v2 3/4] selftests: mptcp: add id argument for
 dsf
Content-Language: en-GB
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
References: <cover.1691564649.git.geliang.tang@suse.com>
 <c3b615a6e41c66947047c81a8ace8e67792d3e8e.1691564649.git.geliang.tang@suse.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Autocrypt: addr=matthieu.baerts@tessares.net; keydata=
 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
In-Reply-To: <c3b615a6e41c66947047c81a8ace8e67792d3e8e.1691564649.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 09/08/2023 09:06, Geliang Tang wrote:
> This patch adds a id argument for userspace PM subflow removing
> function dsf(), to remove id 0 subflow.
> 
> It can be used like this:
> 
> 	./pm_nl_ctl dsf token $tk id 0

Please see my comment in patch 2/4: this patch is maybe not needed (at
least not to fix issue #379 for mptcp-net).

(if it is needed, please add a reason and a link to the parent comment)

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
