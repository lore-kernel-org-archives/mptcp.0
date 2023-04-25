Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C57127B
	for <mptcp@lists.linux.dev>; Tue, 25 Apr 2023 10:32:29 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-3f19c473b9eso76313045e9.0
        for <mptcp@lists.linux.dev>; Tue, 25 Apr 2023 03:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1682418748; x=1685010748;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YCUon1652Afn2r5qmcc2rUISaJ8zK98o1kTbmHHZVl4=;
        b=R7f3+TpaFSe4BWueqnXQ42tVgqyJDG33q3Iq5E3rqVnmxHGm835aLtZZEh2Hd94DjP
         4f7WJe5AQxHoHkkyHhYqy+3/y62++xN+YDVqmu4+D+pm+7ufbns+SQPVgTTS+dJQMdt7
         1s0pw3WPhatKkZNo+LFbVw2ya7GaH/3p08x4OfNSli1Z7RACR/9AzNFf2gwgxiqh74Uu
         s1iUDsq21RlsLYpc6wrupTR4kc1J4Miq0FLIpnrgZNpTClE/MTymiCC1LLnH0e18viuh
         keFNqR+xvVbZ8ChtlgFsXxvt1WxCsmksgSEBCMXb7kjjWAzsFMl16MDk0BHIuM6ZUmnv
         oWuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682418748; x=1685010748;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YCUon1652Afn2r5qmcc2rUISaJ8zK98o1kTbmHHZVl4=;
        b=g7eGTFWOs3PXi45jpm+Lf2whs5mzfxvOznW5gcUsEvN3Llx/EGbVag/Y/YGBz57MrE
         ID2/PYLaCCTdZRGUpDkc03eYvtAN0sWaBZ4KkEhtxm8rSBQBqlQ9vEbNuQHPy+3uJx8M
         KoqtFu+4HA5m9aWIlXQ2h5y4KMB1hOSOjyJoz2NnMoKjto/7bKObWd+fWHd46LKoAnbV
         7h8QvnLBIpj4/feMDfaEK2qkbR/OgfpMei/Ly7AuE7HOAk8d9Wvszc1vtbAFWc9Ze+f6
         s82MvD6MNPjOyX7SRFHxjYhO6F1ks0Pcksf1ZLAM3Gw5QZ3m1mncAoyFNXKUfhLHh7YX
         H6ug==
X-Gm-Message-State: AAQBX9cBShWESstoxsvjLpACJuFO819R5hPih3oBhvJVRNmi3LNvw1Si
	QjyBe6Mo+qJL/2gq9LCGzMuxf/wQBE8nRMPZNk8z4Q==
X-Google-Smtp-Source: AKy350bDFhKprQrEcXpMECIEpeeDiHFGaBEFRG1piZpz22g3kFwKZZPL9lN2turOr3ATECK4D3Lcig==
X-Received: by 2002:a05:600c:198c:b0:3f1:80d0:906b with SMTP id t12-20020a05600c198c00b003f180d0906bmr9651657wmq.4.1682418747788;
        Tue, 25 Apr 2023 03:32:27 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:61cc:5ecb:aad9:418c? ([2a02:578:8593:1200:61cc:5ecb:aad9:418c])
        by smtp.gmail.com with ESMTPSA id ay37-20020a05600c1e2500b003f18b52c73asm14302703wmb.24.2023.04.25.03.32.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Apr 2023 03:32:27 -0700 (PDT)
Message-ID: <60af65a4-a988-f49e-f673-345236a1c6d0@tessares.net>
Date: Tue, 25 Apr 2023 12:32:26 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH mptcp-net 11/13] selftests: mptcp: userspace pm: skip if
 not supported
Content-Language: en-GB
To: Mat Martineau <martineau@kernel.org>
Cc: mptcp@lists.linux.dev
References: <20230406-mptcp-issue-368-selftests-old-kernels-v1-0-246ac567724d@tessares.net>
 <20230406-mptcp-issue-368-selftests-old-kernels-v1-11-246ac567724d@tessares.net>
 <d7e35e19-6a22-4052-19d4-27b6e9e8ddb2@kernel.org>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <d7e35e19-6a22-4052-19d4-27b6e9e8ddb2@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Mat,

On 25/04/2023 02:13, Mat Martineau wrote:
> On Fri, 7 Apr 2023, Matthieu Baerts wrote:
> 
>> Selftests are supposed to run on any kernels, including the old ones not
>> supporting all MPTCP features.
>>
>> One of them is the new MPTCP Userspace PM. We can skip these tests if
>> the feature is not supported.
>>
>> Link: https://github.com/multipath-tcp/mptcp_net-next/issues/368
>> Fixes: 259a834fadda ("selftests: mptcp: functional tests for the
>> userspace PM type")
>> Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
>> ---
>> tools/testing/selftests/net/mptcp/mptcp_join.sh   | 6 ++++++
>> tools/testing/selftests/net/mptcp/userspace_pm.sh | 6 ++++++
>> 2 files changed, 12 insertions(+)
>>
>> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh
>> b/tools/testing/selftests/net/mptcp/mptcp_join.sh
>> index 315ea136fe2c..4bc181485fef 100755
>> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
>> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
>> @@ -135,6 +135,7 @@ cleanup_partial()
>> check_tools()
>> {
>>     mptcp_lib_check_mptcp
>> +    mptcp_lib_check_kallsyms
>>
>>     if ! ip -Version &> /dev/null; then
>>         echo "SKIP: Could not run test without ip tool"
>> @@ -3045,6 +3046,11 @@ fail_tests()
>>
>> userspace_tests()
>> {
>> +    if ! mptcp_lib_kallsyms_has 'mptcp_userspace_pm_'; then
>> +        echo "userspace pm tests are not supported by the kernel: SKIP"
>> +        return
>> +    fi
> 
> In this case, it seems simpler to see if /proc/sys/net/mptcp/pm_type
> exists.

Indeed, good idea.

> I didn't find as simple of an answer for MPTCP TFO and pm listener
> events, but maybe there's some other hint from the kernel about this
> functionality. The kallsyms approach seems a bit "brute force", if we
> can find similar lightweight checks for these other features.
> 
> If I missed a discussion on this topic please let me know and I will do
> a better search of the list archives :)

I agree with you, the kallsyms approach seems a bit "brute force". In
previous discussions, we said we wanted something simple to make the
tests from LKFT on stable kernels useful: for the moment, many selftests
are marked as failed because a few subtests are always failure due to
unsupported features.

You probably read that we said we don't think it is a good idea for them
to run the latest selftests on older kernels but that's not something
they want to change. The recommended way for us to support that is to
try to use a feature and then check the error that is returned but this
doesn't always work. Either because we validate internal behaviours like
which packets have been exchanged: we can change the internal behaviour
without impacting the user API. Or because it is not be easy to put
everything in place (ns, network, etc.), then run a tool (mptcp_connect,
pm_nl_ctl, etc.) to see that a feature is not available, then we need to
propagate the error, clean everything, mark the subtest as skipped, etc.

That's why we are looking at "external" hints. Looking at kallsyms seems
to be a good enough approach but yes, if we can look at sysctl, that's
safer and lighter! :)

I will do that in a v2.

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
