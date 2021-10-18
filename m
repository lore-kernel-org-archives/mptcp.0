Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1798A72
	for <mptcp@lists.linux.dev>; Mon, 18 Oct 2021 14:12:57 +0000 (UTC)
Received: by mail-ed1-f48.google.com with SMTP id 5so41039534edw.7
        for <mptcp@lists.linux.dev>; Mon, 18 Oct 2021 07:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:cc:references:in-reply-to:content-transfer-encoding;
        bh=y5uNPOLBsffK7AW+nPVVR1R4lTJIdSuURHY1BK4wVqg=;
        b=FuJPKuSUf9MpBWiyUjcXE4N9iJdPr69+PpdMP+5hHKhZhsQxk1dhV6a+J4tEeEUXty
         iswDQgFd6Y/81yQ/r2BLHxi9DUQ6JBi946+XdwlKCTxKqJ+CGzbge/gXA3dO+f93qVSi
         sheDbiBXHMhES1A6QR0ERcb9+3udmS+kYM5FzUzLbHPN41M8r0zWvYrNyi5dgm6L54wz
         Q9JTqNpGwJXLtC8KSds3rP+FWGOVc/xuk5fYFjKsmGoVNc6GSpD69aFD1gnJPutYiJGl
         zXKrdR7+vIEwGVuzCyVkEacAwfSk0uCGeGMoauO1F/u48IXZ9WRPwnida/hQZ0Rkfz6s
         vanQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=y5uNPOLBsffK7AW+nPVVR1R4lTJIdSuURHY1BK4wVqg=;
        b=emsiAt2YTpelPT3PC+j39vilzSY8niPUVxkVlNekHY8/inK1LQ6THvdlsscgtm4iE2
         +CERetJSVdGd9k0ODsd0mv0mITb7cYcZx8UnuA3VPbdDFcskPhZdjAnuxW+hiy0jTxK5
         xh7+haI4gSR3Nsct+zSvtT54LkNlmGWJGtqEW9owe9NW86NUcseQE3gZN1pYv9EMvF4D
         LOcU6QlhIKOAxajt6/To6j8GqPAiTaXjP2ihyo9jYlX4ppjoi7uUa2iI8fRL4LOpPqHQ
         ZDS4GudCkiA5LaBEKGyyws4ccNj8puFQAmhX2xQQJantf/5X7n5AIJ0RZHYtM62XHMvm
         e8LA==
X-Gm-Message-State: AOAM531YVAZvO066zglNhqs1rXa8rU+b0vW8Qg/K+ZiM0bb6GvAihyk3
	GSXE1LdVF6UhneVBFvap0bRfFA==
X-Google-Smtp-Source: ABdhPJxIzsgylE1sqpza+2tjw07ARWDpd3so6o5Pyt4qmkO3DlvWKid8Ti9d/SHG8jqEfuhr8RHEwA==
X-Received: by 2002:a50:d88b:: with SMTP id p11mr46766887edj.287.1634566184165;
        Mon, 18 Oct 2021 07:09:44 -0700 (PDT)
Received: from [10.120.18.87] ([84.17.46.26])
        by smtp.gmail.com with ESMTPSA id p13sm6201715ejn.12.2021.10.18.07.09.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Oct 2021 07:09:43 -0700 (PDT)
Message-ID: <9805a0ef-ba30-6ec0-5450-f39e31c8ddae@tessares.net>
Date: Mon, 18 Oct 2021 16:09:43 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.2
Subject: Re: [RFC PATCH v2] selftests: mptcp: more stable simult_flows tests
Content-Language: en-GB
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: Mat Martineau <mathew.j.martineau@linux.intel.com>,
 Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
References: <9d66028a72b6807d4dc3397bb70f028cbc78161d.1634310418.git.pabeni@redhat.com>
 <32692122-28e1-4028-36c4-43649e2fa629@linux.intel.com>
 <1fe3d619-370f-d5bb-6d6f-af6890f9fc43@tessares.net>
 <9ae482b2-90e1-8e4c-7b98-9de3072bd242@tessares.net>
In-Reply-To: <9ae482b2-90e1-8e4c-7b98-9de3072bd242@tessares.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 18/10/2021 14:30, Matthieu Baerts wrote:
> On 18/10/2021 12:24, Matthieu Baerts wrote:
>> Hi Paolo, Mat,
>>
>> On 16/10/2021 02:12, Mat Martineau wrote:
>>> On Fri, 15 Oct 2021, Paolo Abeni wrote:
>>>
>>>> Currently the simult_flows.sh self-tests are not very
>>>> stables, expecially when running on slow VM.
>>>>
>>>> The tests mesures runtime for transfers on multiple subflows
>>>> and check that the time is nearby the theoretical maximum.
>>>>
>>>> The current test infra introduces a bit of jitter in test
>>>> runtime, due to multiple explicit delays. Additionally the
>>>> runtime is measured by the shell script wrapper. On slow
>>>> VM, the script overhead is measurable and subject to relevant
>>>> jitter.
>>>>
>>>> One solution to make the test more stable would be adding more
>>>> slack to the expected time; that could possibly hide reall
>>>> regressions. Instead move the measurement inside the command
>>>> doint the transfer, and drop most unneeded sleep.
>>
>> Thank you for looking at that!
>>
>> It is indeed more stable: with a debug kernel and a "slow host", the
>> test fails almost all the time. Now I got 3 failures in X attempts, not
>> bad! (and I stopped after the last failure)
> 
> And X=18 here ;-)

The public CI seems happy too, no issue with "selftest_simult_flows":

- KVM Validation: normal:
  - Unstable: 1 failed test(s): selftest_mptcp_join 🔴:
  - Task: https://cirrus-ci.com/task/5047114079141888
  - Summary:
https://api.cirrus-ci.com/v1/artifact/task/5047114079141888/summary/summary.txt

- KVM Validation: debug:
  - Unstable: 2 failed test(s): selftest_diag selftest_mptcp_join 🔴:
  - Task: https://cirrus-ci.com/task/6173013985984512
  - Summary:
https://api.cirrus-ci.com/v1/artifact/task/6173013985984512/summary/summary.txt

Initiator: Matthieu Baerts
Commits:
https://github.com/multipath-tcp/mptcp_net-next/commits/d0beafc15723

Good job :)

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
