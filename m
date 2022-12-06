Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD4BA28E7
	for <mptcp@lists.linux.dev>; Tue,  6 Dec 2022 09:55:50 +0000 (UTC)
Received: by mail-ej1-f50.google.com with SMTP id n21so4838203ejb.9
        for <mptcp@lists.linux.dev>; Tue, 06 Dec 2022 01:55:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kMfnRnynkbHu/P1xUthNQDUf84XAPvKxogIReN4oWko=;
        b=g3SktiJ4TC5IcpTqAqS6QmkO81qupeqwgy0dAUFaPAPP1TkJnHGDTsglrN66cEyhHW
         n2n9wL0kjvjLAhCXHs6+S45EY2L6m8fboNtaxsAc6/2DvfhAqenS78sHNXr9KmxxDlvz
         vtmfO5cYE3/8on2nwlLQpeIlMhHVFCNYxoINNB17q47tUpwvdwWO+v5rZHpKARPcJhHz
         3oXW4R1UN+RkY5tjhCap2ivkeDVb7GJOlUXoTUY6zItGf5tsq6X38kw9oPDyR01nYQVZ
         5jkhqul1pZRGGXxuMhPZCVu2Yu4dHjCBgGrHL2gOM4Hh/iy3ODL+Ks+uiqyY3T5UYAux
         OBXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kMfnRnynkbHu/P1xUthNQDUf84XAPvKxogIReN4oWko=;
        b=hA2jboeTU188KHa+YwzwmtaMLVzZ4fF9qlVe+/olmPf99x9+Q/zqDg1t/n2cUkEYHs
         rqRZvuM1mBxSDGzEzh95T+uAg3H6njThFBHpUwIm8DHJ9xldRhUdRrCPgsW8zB2URsbw
         jHno1eBson6kuSj5YAQKO6QSKRuJnwA5Bw80OBKkAUgiO3y4ZprL7DHyZwhrlXjRgXKz
         7Mnw4x5QHjM5+5f0430hxqJYkWchTJ4cB95qCqFfYhA8Eu8j15SRpSVKsYDqmwzrU3n+
         accApk2r0KDsT/gnpdelucWiut8m2EWsdlisW7xy6zdcr4ZYmgmMCnqGbVGTxsOowwUk
         ljxQ==
X-Gm-Message-State: ANoB5pn2YBOMg9JemkQUWLpbYtkyus/3NBy8xA3ZGvXGpEee8bLL/Q6m
	Y1iklzJEiBYDA3a3Z1+/KszwhA==
X-Google-Smtp-Source: AA0mqf6IZO3CLL1cmjBlcxFwA0SxvZEdrsUlLg1tsgvB9maGZl/m8hyC2o0x6g7cWLWNKexD6ebN3A==
X-Received: by 2002:a17:907:c718:b0:7ad:dd43:5d2c with SMTP id ty24-20020a170907c71800b007addd435d2cmr111745ejc.8.1670320548460;
        Tue, 06 Dec 2022 01:55:48 -0800 (PST)
Received: from [10.44.2.26] (84-199-106-91.ifiber.telenet-ops.be. [84.199.106.91])
        by smtp.gmail.com with ESMTPSA id fe17-20020a1709072a5100b0073d7b876621sm7131513ejc.205.2022.12.06.01.55.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Dec 2022 01:55:48 -0800 (PST)
Message-ID: <54b8bf5a-a456-c2fb-6dec-95121fe4fab5@tessares.net>
Date: Tue, 6 Dec 2022 10:55:46 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH mptcp-net v2 1/3] mptcp: remove MPTCP 'ifdef' in TCP SYN
 cookies
Content-Language: en-GB
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: mptcp@lists.linux.dev, Paolo Abeni <pabeni@redhat.com>
References: <20221130094448.4119946-1-matthieu.baerts@tessares.net>
 <20221130094448.4119946-2-matthieu.baerts@tessares.net>
 <48d0aa62-276c-c23b-d49a-1d7e3a62fed5@linux.intel.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <48d0aa62-276c-c23b-d49a-1d7e3a62fed5@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Mat,

On 05/12/2022 22:52, Mat Martineau wrote:
> On Wed, 30 Nov 2022, Matthieu Baerts wrote:
> 
>> To ease the maintenance, it is often recommended to avoid having #ifdef
>> preprocessor conditions.
>>
>> Here the section related to CONFIG_MPTCP was quite short but the next
>> commit needs to add more code around. It is then cleaner to move
>> specific MPTCP code to functions located in net/mptcp directory.
>>
>> Now that mptcp_subflow_request_sock_ops structure can be static, it can
>> also be marked as "read only after init".
>>
>> Suggested-by: Paolo Abeni <pabeni@redhat.com>
>> Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
> 
> Hi Matthieu -
> 
> I noticed today that there's no Fixes: tag for this commit, which the
> netdev CI will check for. Like you say in the commit message, this patch
> is a small bit of refactoring to prepare for the following patch(es) -
> should it share Fixes: tags with those or just let the git dependencies
> speak for themselves?

I don't think we need to add a Fixes tag because as you said, it is
mentioned this modification is needed for the next patch. I'm sure
netdev maintainers will understand why it doesn't have a "Fixes" tag.
But I guess we can also add it (even if it is not really a fix).

We should probably Cc 'stable' ML on the 3 patches but we never really
did before.

Up to you, if you prefer, I can add it :)

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
