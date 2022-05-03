Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBB592FB3
	for <mptcp@lists.linux.dev>; Tue,  3 May 2022 14:10:41 +0000 (UTC)
Received: by mail-ed1-f44.google.com with SMTP id p4so20070517edx.0
        for <mptcp@lists.linux.dev>; Tue, 03 May 2022 07:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=mcq/46v9nYLJyVjqAO4itsL+mGDwSRx+0yfZHlQnEsU=;
        b=JTiYqHQq8svo4faP3IGOdoWVw0dJQyXaNRzeKfh9scU6y6yU7G9Ds45+9/YkRQhght
         ZR+1zg/bVnSXE8y2Q6nXC2dGscF5oMpnJ8C+VaJ1U1Cc777nMGa24cHArIfqHOQK2UuF
         vnIPRx4c7sH5sf99GHdInwtZxpsa2WmYIBYSZDVDJkPBsNAKwP2Ewmgg7tJ6gRCedc1V
         7mCspSigaYA/cpQC8udH7jgGF8nlV41msT9k6Sxr3o+MKSt11vVBXDrmQbzZY6aeuE5M
         GcseOlIwyLQ5V/Mb9/zXkbkkkfUt6RvXam8UwPtppYdv55e/WUKvXR0kxwqB+5TDWzBA
         pRnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=mcq/46v9nYLJyVjqAO4itsL+mGDwSRx+0yfZHlQnEsU=;
        b=yCEXu5txGAJ2Xeb9fC9haK5nmQpeHpXEfQcOfcLUgdiQ8Oh+2fX3/TXsP7X5d1Fa9Y
         5MegPlRXIUQwuP/L6IZLCVV53aJia3OUZIhZhuc/+lX+jklP7MSDCcuEkKQhHoh7olj8
         ZYCfPinidVPk18PPwxX/37G9kgPjzmGw0ZBHnnA8Md+VfXynevbSQCbI3h22hbUEGyCe
         si7eMBZn3nDBc7H2OJDdSGLqbE9sfhJSU3Miv0YGZ8HQDff5hxcdXl/9AhJ36LPrqPd2
         +/286BQVw+DSomQPSQoxKABcx6idMYB1FxEgTQH9ew7SfTnX8YHNLa7GQ/jz0R/43uHw
         bL5g==
X-Gm-Message-State: AOAM531hBvUFivXZN+bwUg9yqkq6d+ZdluVibagrANt9/cam4QPpx1NH
	Tmh0ZESmewvxIL/+5VL9SO0gKbufMrKhNMOE
X-Google-Smtp-Source: ABdhPJw3fJ5RSVsenggSfsA9TlJC5jO5b0MTGXKA7Oege2fqbNE0IEfmWXBN1K83UqLtKwbdnbzdYw==
X-Received: by 2002:a05:6402:228c:b0:425:d911:fd35 with SMTP id cw12-20020a056402228c00b00425d911fd35mr18438177edb.325.1651587039705;
        Tue, 03 May 2022 07:10:39 -0700 (PDT)
Received: from [10.44.2.26] ([81.246.10.41])
        by smtp.gmail.com with ESMTPSA id dq10-20020a170907734a00b006f3ef214de9sm4685054ejc.79.2022.05.03.07.10.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 May 2022 07:10:39 -0700 (PDT)
Message-ID: <8ae93c80-6771-bd01-d459-998aea20a7da@tessares.net>
Date: Tue, 3 May 2022 16:10:38 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH mptcp-net 1/2] mptcp: fix subflow accounting on close
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
References: <84bfd492fa6e4a5ca5c90201283c48ed07318aa9.1651165091.git.pabeni@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <84bfd492fa6e4a5ca5c90201283c48ed07318aa9.1651165091.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo, Mat,

On 28/04/2022 18:58, Paolo Abeni wrote:
> If the PM closes a fully established MPJ subflow or the subflow
> creation errors out in it's early stage the subflows counter is
> not bumped accordingly.
> 
> This change adds the missing accouting, additionally taking care
> of updating accordingly the 'accept_subflow' flag.

Thank you for the patches and the reviews!

Now in our tree (fix for -net) with Mat's RvB tag and without some typos
reported by checkpatch.pl --codespell.

I indeed had 2 small conflicts to apply them (and the same later when
propagating the modifications):


New patches for t/upstream:
- 7434c8d5e0c2: mptcp: fix subflow accounting on close
- f61a56256a0a: selftests: mptcp: add subflow limits test-cases
- d6c3691c8ed4: conflict in
top-bases/t/DO-NOT-MERGE-git-markup-fixes-net-next
- 138248ead67a: conflict in
t/mptcp-bypass-in-kernel-PM-restrictions-for-non-kernel-PMs
- Results: 6e5da9dfbfac..bea7cea0ffcd (export)

New patches for t/upstream-net:
- 7434c8d5e0c2: mptcp: fix subflow accounting on close
- f61a56256a0a: selftests: mptcp: add subflow limits test-cases
- d6c3691c8ed4: conflict in
top-bases/t/DO-NOT-MERGE-git-markup-fixes-net-next
- 138248ead67a: conflict in
t/mptcp-bypass-in-kernel-PM-restrictions-for-non-kernel-PMs
- Results: 9f40b4259885..d3d6ac28f754 (export-net)


Builds and tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20220503T140124
https://github.com/multipath-tcp/mptcp_net-next/actions/workflows/build-validation.yml?query=branch:export

Builds and tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export-net/20220503T140124
https://github.com/multipath-tcp/mptcp_net-next/actions/workflows/build-validation.yml?query=branch:export-net


Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
