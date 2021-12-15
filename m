Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B60C173
	for <mptcp@lists.linux.dev>; Wed, 15 Dec 2021 09:04:39 +0000 (UTC)
Received: by mail-ed1-f43.google.com with SMTP id z9so17318725edb.5
        for <mptcp@lists.linux.dev>; Wed, 15 Dec 2021 01:04:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=0h9dZTfD0wp0bJ4WIX0qpweSdgi3kH4wQeGsIEONAn0=;
        b=8Rsr5tP6e33ls1U61SqqRvqmz1J2MKfi+FOPCTyKl0LtBDMUgY16qFVcwa29C5mo1K
         +yFjxG5/mzDyC0+VLfWWiMnYbchowkvyQlbyLhaDBRqHZG0Kgfd0Js0h6/9WEq/aZOmL
         v7q00eEvSUH+Cd0C7SkYuSoOrelFjZTSQymPOT/5dcTWsl7vvlE3AO0G5ECe2DrJxP8L
         inmXHHxH+TdFTn/CpXo6McwDltqBooTAx2L6y1GGqQp8YTPqJtFRmG/WF//26olo4Nj9
         nQnKv3pn/hOk5vAUykqJUX5gK/AA9DmrYpuOeBIVQaU3e3x/AdkUWOE5te5AreBM966y
         HiJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=0h9dZTfD0wp0bJ4WIX0qpweSdgi3kH4wQeGsIEONAn0=;
        b=kmGU7tsgKl08fhNmqQPmR6d19F26qyzv5NMikp2+QGhVAJz2ajN4fUu5Gd01035Kss
         BVsR3TzjPG1ymcwr6moSFjN1jUYM+MONZofwDUe78cYzEW9abpTYVY9X90uFuUCEqBs8
         c8GyQrx8U5/uVT4nRKEvAc+W7tIGiJsx78mXintzkorlUSAAbr/S8nlg5GEhhqiPK9gn
         aOcH2FIJMK7x/sBVjX9JFU8LwXrtamK8gaAzrsMXblVEZP5v3NwcQIacK2idorjN80f7
         QrtVxxVsla0qiFX4CE7vPKLxhNzdpLS0QZPPoYDFq3N9DfCFimoIIY7EcTgyWduk8YgU
         t2hg==
X-Gm-Message-State: AOAM531/o7rcuqcKukTtvjlBkKawFTOfOgJOiOwPmoR7giG8WKPg4W+J
	8y9Cbqe6s6UxavBFkwlpsFU1qQ==
X-Google-Smtp-Source: ABdhPJyXu7J7U+8r9mvnicVsNjNulcj6PuB7lXowgbjKWiFA7BgnjpNRjOBM4Mu0UQwJVCho7IE6cg==
X-Received: by 2002:a05:6402:5c9:: with SMTP id n9mr13380051edx.306.1639559077999;
        Wed, 15 Dec 2021 01:04:37 -0800 (PST)
Received: from [192.168.178.33] (94.105.100.208.dyn.edpnet.net. [94.105.100.208])
        by smtp.gmail.com with ESMTPSA id sa3sm440866ejc.113.2021.12.15.01.04.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Dec 2021 01:04:37 -0800 (PST)
Message-ID: <aeebca24-8584-a24c-700d-b8c8776033af@tessares.net>
Date: Wed, 15 Dec 2021 10:04:36 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v2 mptcp-next] selftests: mptcp: more stable join
 tests-cases.
Content-Language: en-GB
To: Mat Martineau <mathew.j.martineau@linux.intel.com>,
 Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
References: <b6f8d2e06bfa3b15cc7fa0ac3076cfafd7448b07.1639482622.git.pabeni@redhat.com>
 <542f3ab-d93a-4cba-3bdf-4b8b85744073@linux.intel.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <542f3ab-d93a-4cba-3bdf-4b8b85744073@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Paolo, Mat,

On 15/12/2021 02:32, Mat Martineau wrote:
> On Tue, 14 Dec 2021, Paolo Abeni wrote:
> 
>> MPTCP join self-tests are a bit fragile as they reply on
>> delays instead of events to catch-up with the expected
>> sockets states.
>>
>> Replace the delay with state checking where possible and
>> reduce the number of sleeps in the most complex scenarios.
>>
>> This will both reduce the tests run-time and will improve
>> stability.

Thank you for looking at that :)

> Running this in my local VM I saw more failures with the patch than
> without (this is a kernel with a lot of debug turned on):
> 
> 27 remove single subflow                syn[ ok ] - synack[ ok ] - ack[
> ok ]
>                                         rm [fail] got 0 RM_ADDR[s]
> expected 1 - sf    [ ok ]
> 
> ...
> 
> 37 flush invalid addresses              syn[ ok ] - synack[ ok ] - ack[
> ok ]
>                                         add[ ok ] - echo  [ ok ]
>                                         rm [ ok ] - sf    [ ok ]
> copyfd_io_poll: poll timed out (events: POLLIN 1, POLLOUT 0)
>  client exit code 2, server 0
> 
> 
> Could have been an unlucky run on my machine :)
> 
> Matthieu, does it improve behavior in your test environments?

I ran mptcp_join.sh test in a loop during the night.
After 56 iterations, I got 56 failures, each time one test was failing:


# 30 remove invalid addresses     syn[ ok ] - synack[ ok ] - ack[ ok ]

#                                 add[ ok ] - echo  [ ok ]

#                                 rm [fail] got 2 RM_ADDR[s] expected 3

#  - sf    [ ok ]


I didn't have this error with the RFC version shared on IRC.


Please note that one other test failed once in 56 iterations:

# 38 add signal address   syn[ ok ] - synack[ ok ] - ack[ ok ]

#                         add[ ok ] - echo  [fail] got 0 ADD_ADDR
echo[s] expected 1


I guess we can ignore this one for now.


But it seems to be the way to go! What I would suggest is to allow
waiting longer and return an error if we didn't find anything.

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
