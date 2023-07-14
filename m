Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B669156DE
	for <mptcp@lists.linux.dev>; Fri, 14 Jul 2023 17:49:08 +0000 (UTC)
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-56352146799so1521982eaf.3
        for <mptcp@lists.linux.dev>; Fri, 14 Jul 2023 10:49:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20221208.gappssmtp.com; s=20221208; t=1689356948; x=1691948948;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I7DDN8GbZMG3KlpuHTN+v0LnOTBPGrIWfYxu7LMvL/8=;
        b=EsObdH5GmfJY05wMbzoDxMZl7qGlDG1hB3mWeD4J9KH+vhPUO8vzmrTibNYCg3HFsX
         N/yHTsKtySUpQBqoznTOulPdXkVf5BdhhRbu9EJ5Plf9zeBRSvrgCTYrz9g9r9YKgv7P
         /THveqSATuTYP4pJoUUX65Uan3QgCrP+vldmXjs13ym6CziZ2rBvZP2Xn0T2UKRIVHRM
         AochMDIvMr3iWvDt4ot+U2i+6lwRdJJyOJtOSxXxo0HTi0zV9wlssvgbjSZEyuoRkFiD
         d7e0tq9zTPgg6hRtHTm4SCr/NXDD25LFVWKsc5TWQsXVNx76aIbvTrm0/36SWRYONc5H
         2iZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689356948; x=1691948948;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I7DDN8GbZMG3KlpuHTN+v0LnOTBPGrIWfYxu7LMvL/8=;
        b=RfICd/XSb5/C7+w3S2wBv1qw7jHeiE7CwAmA3k4F2+Vqq+nMwLy+VMHfwojFXiysPc
         DSNQrmAZZG34yTkYoQE/pf2K9nK8tbxH+lh8hmpSgwV/yWFbOQ0q9ZrnCFKY1pQ3X3Kd
         SA6GoJ3iIdjsXgwkVv0wsPgfJ+zx8s4VGPIJpdMGD5dZLp7iavNbgu9dl1f18COQUaR8
         zL/isbXjvlOQaYPi1rDP/6MGB56Vy6cckSzUG8XyEMveveMAGaH6G+DYPCIl8zqrTf8U
         TWEjYd9tPD6rhNfkJ8kGOKHq6y0tnM3KneLBoHnXI1bqATMjALe8FtNGabQ0OC5obtU+
         dMeQ==
X-Gm-Message-State: ABy/qLawpQbtgsKr/j+V/OR2ZrZ/g2R6yuvhARaqAvr5Y1yFDHemDUaK
	abXT6AwMwox1CHm1AyDVpTjVtw==
X-Google-Smtp-Source: APBJJlEFEC11jJ2OVWqVyq80ycE+Wi778tCXgrJAAGfwWU4P6AqQ9H0EWkwamlDgNCerFGk1EU/3MA==
X-Received: by 2002:a4a:d298:0:b0:566:6928:2e3c with SMTP id h24-20020a4ad298000000b0056669282e3cmr5186911oos.9.1689356947824;
        Fri, 14 Jul 2023 10:49:07 -0700 (PDT)
Received: from ?IPV6:2804:14d:5c5e:44fb:860d:7d54:c6cc:ceb3? ([2804:14d:5c5e:44fb:860d:7d54:c6cc:ceb3])
        by smtp.gmail.com with ESMTPSA id 184-20020a4a1dc1000000b0055e3dd89c12sm3065807oog.1.2023.07.14.10.49.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Jul 2023 10:49:07 -0700 (PDT)
Message-ID: <deeb8fe7-1f0e-bc1c-cde5-74e9af160bf7@mojatatu.com>
Date: Fri, 14 Jul 2023 14:49:01 -0300
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH net 1/3] selftests: tc: set timeout to 15 minutes
Content-Language: en-US
To: shaozhengchao <shaozhengchao@huawei.com>,
 Matthieu Baerts <matthieu.baerts@tessares.net>,
 Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>,
 Jiri Pirko <jiri@resnulli.us>, Shuah Khan <shuah@kernel.org>,
 Kees Cook <keescook@chromium.org>, "David S. Miller" <davem@davemloft.net>,
 Paul Blakey <paulb@mellanox.com>,
 Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, mptcp@lists.linux.dev
Cc: Shuah Khan <skhan@linuxfoundation.org>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 stable@vger.kernel.org
References: <20230713-tc-selftests-lkft-v1-0-1eb4fd3a96e7@tessares.net>
 <20230713-tc-selftests-lkft-v1-1-1eb4fd3a96e7@tessares.net>
 <bf7f8867-6b14-dd53-a6e4-2addee4a5ad8@huawei.com>
From: Pedro Tammela <pctammela@mojatatu.com>
In-Reply-To: <bf7f8867-6b14-dd53-a6e4-2addee4a5ad8@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 13/07/2023 23:25, shaozhengchao wrote:
> 
> 
> On 2023/7/14 5:16, Matthieu Baerts wrote:
>> When looking for something else in LKFT reports [1], I noticed that the
>> TC selftest ended with a timeout error:
>>
>>    not ok 1 selftests: tc-testing: tdc.sh # TIMEOUT 45 seconds
>>
>> The timeout had been introduced 3 years ago, see the Fixes commit below.
>>
>> This timeout is only in place when executing the selftests via the
>> kselftests runner scripts. I guess this is not what most TC devs are
>> using and nobody noticed the issue before.
>>
>> The new timeout is set to 15 minutes as suggested by Pedro [2]. It looks
>> like it is plenty more time than what it takes in "normal" conditions.
>>
>> Fixes: 852c8cbf34d3 ("selftests/kselftest/runner.sh: Add 45 second 
>> timeout per test")
>> Cc: stable@vger.kernel.org
>> Link: 
>> https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20230711/testrun/18267241/suite/kselftest-tc-testing/test/tc-testing_tdc_sh/log [1]
>> Link: 
>> https://lore.kernel.org/netdev/0e061d4a-9a23-9f58-3b35-d8919de332d7@tessares.net/T/ [2]
>> Suggested-by: Pedro Tammela <pctammela@mojatatu.com>
>> Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
>> ---
>>   tools/testing/selftests/tc-testing/settings | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/tools/testing/selftests/tc-testing/settings 
>> b/tools/testing/selftests/tc-testing/settings
>> new file mode 100644
>> index 000000000000..e2206265f67c
>> --- /dev/null
>> +++ b/tools/testing/selftests/tc-testing/settings
>> @@ -0,0 +1 @@
>> +timeout=900
>>
> I remember last year when I tested all the tdc cases（qdisc + filter +
> action + infra） in my vm machine, it took me nearly 20 minutes.
> So I think it should be more than 1200 seconds if all cases need to be
> tested.
> 
> Maybe we should really optimize the parallel execution process of tdc.

Let's try to spend some cycles improving the tdc code performance first.
TDC boils down essentially to:
- Setup namespace (if needed)
- Setup network interfaces
- Spawn a few processes
- Match a regex
- Bring down namespace

Nothing above screams expensive, so I'm sure there are some low hanging 
fruits to improve the overall wall time even in debug kernels.

