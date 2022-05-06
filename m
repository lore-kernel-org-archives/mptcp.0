Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDFA22FAE
	for <mptcp@lists.linux.dev>; Fri,  6 May 2022 19:31:12 +0000 (UTC)
Received: by mail-ed1-f53.google.com with SMTP id g20so9792699edw.6
        for <mptcp@lists.linux.dev>; Fri, 06 May 2022 12:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=jW1sNae3+4XiMrZh/uZDGJUW+JbJouJOjBWwrNW8SfQ=;
        b=oZKlNrywekoh3I17wcRQxsnMJcEQd4cVsJnusMCKnou9WXlx3WTW6q/ejNhfrqGaNE
         4Pve485QMEP3JFbViVtLWuMXX23Uh06L7yGVj5/ZphbJ1KHzC1iXsvq5KdrzpunWopX7
         WN/b35eAete5XVI7YBVVdqMZySCtb7I7wfCwOBykTTmGVNon86YoL/DDGmiOAO+GLUie
         8+BZy1RWfFdUl1+4S+4MTXav4OSMZ+JvJK0wZZYZsK9aCQpqQD2La+X8h6ZqdUKW0I8f
         x3ssWhC0Z7JfKCjajpmmOu3sXU5IJIimtP5twvHc1PWKLeKu/RqCd/CKTY5vzzDzNiUE
         1P8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=jW1sNae3+4XiMrZh/uZDGJUW+JbJouJOjBWwrNW8SfQ=;
        b=l0OToTg2GJr22rf123UORAgR1erjfTpOJGzFhbnjq2b3ds6IpPcQ/3TD8bYXw8+wHv
         VN89TCRY7FL0ghp1eHVPlLfkdSRzihbFV5bzBqL0ImeTcaMheHQT3Aqp48R0axXekP6J
         WzbeSXt48ZwH1ILTRYWYxILcIoa/QN/Bb8vtOUb9t2EisT7KRECow5FBaRCcPbjaFnpV
         pwjtkxn1D6rtSJDWIt0pAtADke4ZFOUGF3di9cdlk63XCOR0zQ46sNWIvXEKjq34j+we
         ayLnYk2cCYdxi8W8CW/DswpzKUSJe0pYFEd4fIjsUtNdaINKzBg60OD2bGB7w13MvRcV
         Vquw==
X-Gm-Message-State: AOAM530a9QmVuX4vcIAQOqW8QcmwcWgvA9pGQ6OioeJQBBGpTNLSquHk
	DMoLsF3zVfXd3mC9lOw3UhMRU/zhFXZ/wvGN
X-Google-Smtp-Source: ABdhPJxoRumJLXDOxxl7lR5t6O1H63vpBBXWSASuho+NWmTxkp5389SOWItA4Q4tm1hsVUfRUy4EOA==
X-Received: by 2002:aa7:da08:0:b0:425:af3c:196a with SMTP id r8-20020aa7da08000000b00425af3c196amr5106993eds.69.1651865471020;
        Fri, 06 May 2022 12:31:11 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:b63e:f9ca:c9c4:cf8a? ([2a02:578:8593:1200:b63e:f9ca:c9c4:cf8a])
        by smtp.gmail.com with ESMTPSA id bx8-20020a0564020b4800b0042617ba639bsm2604582edb.37.2022.05.06.12.31.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 May 2022 12:31:10 -0700 (PDT)
Message-ID: <863dd5a5-ca95-17fe-a12d-364f805ffcdb@tessares.net>
Date: Fri, 6 May 2022 21:31:09 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH mptcp-next v2] selftests: mptcp: fix MP_FAIL test-case
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
References: <613074c6f6136ebb652df581fbb3d7de02fb8e33.1651655175.git.pabeni@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <613074c6f6136ebb652df581fbb3d7de02fb8e33.1651655175.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo, Mat,

On 04/05/2022 11:06, Paolo Abeni wrote:
> The mentioned tests sometimes fails because the data
> transfer completes before any packet is sent on the 2nd
> link (the failing one).
> 
> Address the issue reducing the "virtual" b/w available
> on the primary link.

Thank you for the patch and the review!

- 4fe3d4071237: "squashed" in "selftests: mptcp: add MP_FAIL reset testcase"
- ac30a511e2eb: "Signed-off-by" + "Co-developed-by"
- Results: 9a52d7243fda..9a06ad1b6cf2 (export)

Builds and tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20220506T192929
https://github.com/multipath-tcp/mptcp_net-next/actions/workflows/build-validation.yml?query=branch:export

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
