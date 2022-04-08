Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2B64623
	for <mptcp@lists.linux.dev>; Fri,  8 Apr 2022 09:35:28 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id f16-20020a7bcd10000000b0038e9ce3b2a9so742596wmj.2
        for <mptcp@lists.linux.dev>; Fri, 08 Apr 2022 02:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:cc:from:in-reply-to:content-transfer-encoding;
        bh=IySqQcPJfa1ZV5tCKeJzqxcXw1IJX39QXoa6tgX6Yk0=;
        b=MHvcQLL8X1wkdFt2e1ys+B8qi4FUWxFkn9EaM3aNRm5iiArC5StqK40A2aAUPrEHNY
         kMxcPqjnBcwOAyaT2JG75txsxl5YP5qjI79OQxtywnY9aJt/ERrKxEMKnr4osCImWVm2
         fomc3B/JEfOVfqKrHTUQ6HEfI+33Uj46sTVFwG4Xkw9W2oSAQOvxwp6pcb8O1LRw5HgN
         all9fffe8ybF4b2GiZZucpC7QgrXGtweWK3Ho7MVjF1i28kR/HKt/T6FobKyAlCDU46K
         hqlubPmeeEkx9jx/R4zQQl7kTCiTMQIsFTPcLlMVpklsQmzg9RIZ/C/60U1jR4/Gc/qS
         o7rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:cc:from:in-reply-to
         :content-transfer-encoding;
        bh=IySqQcPJfa1ZV5tCKeJzqxcXw1IJX39QXoa6tgX6Yk0=;
        b=GeffqRVJDzmfXWATYcMWmOVAx+3kBGjE+/QVgX1OizVKwjFc2t4VDcelxteFvpuHQt
         SVlvRsTcORKirUP2HjOnlY6QOUTOwlHd4dWeFYlLrz4re+4Ceap7qyVImrIYuTsJaWqc
         UpCdRnYXpxKk7X4Pmxrgxfn4kPq4uwX/5sDQdybSZ36VIJtSDhOU6TUGWKW6brOKE6o4
         koI41JjWRLyYGEXc9sscwUol2Wj74o5FXLax8XZjIp8c5RyhvF7Me6wgUI/55Cb9FBQS
         E1ix893lqAS5bMwbMT47FwW8uEwj8JhcTXoywtlp2U43GjYjgVYzgrOs6ljDk2v8BXkB
         PolQ==
X-Gm-Message-State: AOAM532EXrfkGOTYCNIlCZ+5/thn81UKGrxzKnSi75s8WjF6hBd7WEPE
	rjzy8XELtplOLU9PaudBvX6Sxw==
X-Google-Smtp-Source: ABdhPJwVokUn8ONjqiaIV52NM7vGliopV6NEgWHNcjqdl6g1tGxJ5HDOA6tErfSpAmbpxP7zOTwXYQ==
X-Received: by 2002:a05:600c:3b24:b0:38c:dbdb:a35c with SMTP id m36-20020a05600c3b2400b0038cdbdba35cmr16356788wms.175.1649410526653;
        Fri, 08 Apr 2022 02:35:26 -0700 (PDT)
Received: from [10.44.2.26] ([81.246.10.41])
        by smtp.gmail.com with ESMTPSA id o19-20020a05600c511300b0038d0d8f67e5sm9902106wms.16.2022.04.08.02.35.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Apr 2022 02:35:26 -0700 (PDT)
Message-ID: <f1401baa-ac43-e1eb-209e-6c4d956cc37f@tessares.net>
Date: Fri, 8 Apr 2022 11:35:25 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: selftests: mptcp: functional tests for the userspace PM type:
 Tests Results
Content-Language: en-GB
To: Kishen Maloor <kishen.maloor@intel.com>
References: <20220407234029.1774481-15-kishen.maloor@intel.com>
 <0fad9a2c-ced8-f28b-9582-076ec7ff6b5f@gmail.com>
Cc: mptcp@lists.linux.dev, Mat Martineau <mathew.j.martineau@linux.intel.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <0fad9a2c-ced8-f28b-9582-076ec7ff6b5f@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Kishen

On 08/04/2022 03:57, MPTCP CI wrote:
> Hi Kishen,
> 
> Thank you for your modifications, that's great!
> 
> Our CI did some validations and here is its report:
> 
> - KVM Validation: normal:
>   - Success! ✅:
>   - Task: https://cirrus-ci.com/task/6670539791007744
>   - Summary: https://api.cirrus-ci.com/v1/artifact/task/6670539791007744/summary/summary.txt
> 
> - {"code":404,"message":
>   - "HTTP 404 Not Found"}:
>   - Task: https://cirrus-ci.com/task/4629846209855488

It looks like the issue is the same as with the previous version:

[01:14:32.748] + ./userspace_pm.sh
[01:14:32.757] +
/tmp/cirrus-ci-build/tools/testing/selftests/kselftest/prefix.pl
[01:14:32.764] + tee /tmp/cirrus-ci-build/selftest_userspace_pm.tap.tmp
[01:14:38.155] [ 3434.740942][T11903] IPv6: ADDRCONF(NETDEV_CHANGE):
ns2eth1: link becomes ready
[01:14:38.171] [ 3434.756018][T11903] IPv6: ADDRCONF(NETDEV_CHANGE):
ns1eth2: link becomes ready
[01:14:38.192] # Created network namespaces ns1, ns2         			[OK]
[01:14:40.882] # cleanup
[01:14:40.917] User defined signal 1
[01:48:15.919] Timeout: sending Ctrl+C


More details:

https://cirrus-ci.com/task/4629846209855488?logs=test#L8520


Do you mind having a look at this please?

There is an issue only when the kernel debug config is used:

  $ make defconfig debug.config


You can easily reproduce that with:

  $ cd <kernel source code>
  $ echo "run_loop run_selftest_one ./userspace_pm.sh" \
          > .virtme-exec-run
  $ docker run -v "${PWD}:${PWD}:rw" -w "${PWD}" --privileged --rm -it \
           --pull always mptcp/mptcp-upstream-virtme-docker:latest \
           auto-debug

(or use "manual-debug" and run the selftests manually of course)

For more details about this docker image:

  https://github.com/multipath-tcp/mptcp-upstream-virtme-docker


Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
