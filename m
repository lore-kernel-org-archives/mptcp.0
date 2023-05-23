Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7043A1E501
	for <mptcp@lists.linux.dev>; Tue, 23 May 2023 10:14:42 +0000 (UTC)
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-3f603ff9c02so15784525e9.2
        for <mptcp@lists.linux.dev>; Tue, 23 May 2023 03:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1684836880; x=1687428880;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=U91vWxoi2D8XcwNBz0Eadb9O0D8etQGXBL20BiPe4YI=;
        b=VFvGlu2fcFTUEo1sRj/FOqB2/LyhaVj2luds9ddC2YBcTozDlHYvVDSM6Xac+9hz2t
         Pc+4Q4lNsxbKZQ5+IQeQihr6w813qWrpCFT408N6GbzlWFleq+nfodND08SsELekjvPo
         pjJxXZuGBsoGLIsMxSSUjj+KopXCAgDtlvoA169cJILz0c6M26bJPNUawtiPkzv87Q3k
         sxn5ofR58xvDVKIOwfijJIHhF6WizEOeOjNVd6fsDdyHDqhAWKe846NGlLDN4mm0rqmL
         /Oolvbh8ULRKELw2XrdTQlODSHmCYo0XS2DOiltG+bIMMiT1eA+h9feAA+7lcaT0Zq+N
         89LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684836880; x=1687428880;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U91vWxoi2D8XcwNBz0Eadb9O0D8etQGXBL20BiPe4YI=;
        b=Vjfm4arVFr1tOg9ODbD3G1RyKn5oqUPWVrcjhrDd0s4vhyQCtsKPWsR8/c+08YVR/O
         D2qpD5TPD6NgO83DOMmp72L+9Pn35ZQ8dv/IgCjXhEmbV0nHyIYsd4GBPssCzo2yHNBb
         vXOPvcckQEy6WjF6sZOC+bK90mIHHCxKp+V28X3g+pscVVaFTnnUsnO+tewFcFvWOiyD
         fN8Pi9GgkciARJ0fQdqA3MkbO68ni1CrVYl1N0AYbAZmXgizqXBSUkb0ulNcmIDgVRu+
         SNB9RtIA1s5wFzzyP+A0HpCB2v2XL3bbxXUf+zjcY+72mTbV8TgzyRrUreHIZg9cQ+ag
         WkwA==
X-Gm-Message-State: AC+VfDwuqZGew0kqJN0IAopaRfdtlj3bYIPqLToSS1kjqVqJbK4zSte0
	cYhPb42fvcNXhmiMsEuFwIL2UXCQn4vWaLtw5sjxcA==
X-Google-Smtp-Source: ACHHUZ6rkqiRTMdNCk5oKWcheSaIDiEyyIH0SCAWa0lCZnmZNsTVvwYO3AY8CEXXJTnlk8z1lcI+bA==
X-Received: by 2002:a7b:c014:0:b0:3f4:fd67:6d7c with SMTP id c20-20020a7bc014000000b003f4fd676d7cmr8253056wmb.40.1684836880402;
        Tue, 23 May 2023 03:14:40 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:7ae3:96f4:110c:3f46? ([2a02:578:8593:1200:7ae3:96f4:110c:3f46])
        by smtp.gmail.com with ESMTPSA id b10-20020adfde0a000000b0030649242b72sm10516568wrm.113.2023.05.23.03.14.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 May 2023 03:14:40 -0700 (PDT)
Message-ID: <3c2c6992-b175-04fb-29c0-959c5a88fbda@tessares.net>
Date: Tue, 23 May 2023 12:14:39 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH mptcp-net v2 28/37] selftests: mptcp: join: skip Fastclose
 tests if not supported
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
References: <20230406-mptcp-issue-368-selftests-old-kernels-v2-0-50313e4f83ab@tessares.net>
 <20230406-mptcp-issue-368-selftests-old-kernels-v2-28-50313e4f83ab@tessares.net>
 <e163a9ecc2d40f123f396aa1bd67e2a3f6b60b1e.camel@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <e163a9ecc2d40f123f396aa1bd67e2a3f6b60b1e.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo,

On 22/05/2023 19:45, Paolo Abeni wrote:
> On Mon, 2023-05-22 at 18:38 +0200, Matthieu Baerts wrote:
>> Selftests are supposed to run on any kernels, including the old ones not
>> supporting all MPTCP features.
>>
>> One of them is the support of MP_FASTCLOSE introduced in commit
>> f284c0c77321 ("mptcp: implement fastclose xmit path").
>>
>> If the MIB counter is not available, the test cannot be verified and the
>> behaviour will not be the expected one. So we can skip the test if the
>> counter is missing.
>>
>> Link: https://github.com/multipath-tcp/mptcp_net-next/issues/368
>> Fixes: 01542c9bf9ab ("selftests: mptcp: add fastclose testcase")
>> Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
>> ---
>>  tools/testing/selftests/net/mptcp/mptcp_join.sh | 17 +++++++++++++++--
>>  1 file changed, 15 insertions(+), 2 deletions(-)
>>
>> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
>> index 1f24495308f9..ccf52aba8a1c 100755
>> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
>> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
>> @@ -263,6 +263,19 @@ reset()
>>  	return 0
>>  }
>>  
>> +# $1: test name ; $2: counter to check
>> +reset_check_counter()
>> +{
>> +	reset "${1}" || return 1
>> +
>> +	local counter="${2}"
>> +
>> +	if ! nstat -asz "${counter}" | grep -wq "${counter}"; then
>> +		mark_as_skipped "counter '${counter}' is not available"
>> +		return 1
>> +	fi
>> +}
>> +
>>  # $1: test name
>>  reset_with_cookies()
>>  {
>> @@ -3179,14 +3192,14 @@ fullmesh_tests()
>>  
>>  fastclose_tests()
>>  {
>> -	if reset "fastclose test"; then
>> +	if reset_check_counter "fastclose test" "MPTcpExtMPFastcloseTx"; then
>>  		run_tests $ns1 $ns2 10.0.1.1 1024 0 fastclose_client
>>  		chk_join_nr 0 0 0
>>  		chk_fclose_nr 1 1
>>  		chk_rst_nr 1 1 invert
>>  	fi
>>  
>> -	if reset "fastclose server test"; then
>> +	if reset_check_counter "fastclose server test" "MPTcpExtMPFastcloseRx"; then
>>  		run_tests $ns1 $ns2 10.0.1.1 1024 0 fastclose_server
>>  		chk_join_nr 0 0 0
>>  		chk_fclose_nr 1 1 invert
>>
> 
> Here and in a few later patches, I would do the 'feature check' only
> once at the beginning of the functional block ('fastclose_test' in this
> case), in the most conservative way possible. The goal would be
> minimize the conflicts caused by present/absence of such patch.

I initially did that but then it breaks the feature to start a specific
test. Also, the ID of the tests would be different on the different
kernels which might make the tracking of the different issues more
difficult.

On older kernels, we already have conflicts because of all the "if reset
(...)" I introduced one or two years ago :)

But likely, we don't need to backport such checks to know if a test can
be started or not too far: as long as we can backport such checks to the
last stable kernels, that's enough for the different CIs using the last
stable version of the kselftests on older kernels.

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
