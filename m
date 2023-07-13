Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA27D1F179
	for <mptcp@lists.linux.dev>; Thu, 13 Jul 2023 19:03:05 +0000 (UTC)
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3141fa31c2bso1183615f8f.2
        for <mptcp@lists.linux.dev>; Thu, 13 Jul 2023 12:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1689274983; x=1691866983;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DngZium9YNJVRhCjETKR9D2bXwrG2zkugrzo7kcpi74=;
        b=eJNIQoGOWPP82T7eEikX2KxevzaPJXAgyXNevLSMEbbldP42oCrvEMOIxV1EGwUjev
         2GcS5Vijy3s+k8TTbwb+zXwT4JBhBUDAyUEu2+QbmlTilveqahwv/WOBTOvQhloEGsCe
         yHbDZAGzSWBs9QZZ/AyBvaKaNsPTPeraBqTv53a/N7byfnKhJT4JPcZTnZ4SbEPuIUpC
         Nr0r3iDLfGWPPXgaZx7/DdMUMm5lqz4FnH39kMrsgX+WvOSRtv3Qip2lOZ3X927JysZh
         XExmm13FSQN9JdYnXq1ZDVaikG+bfLV/wqkrnL1cVp5zaZ283buMuDicDrqsm/k/RPaJ
         5GyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689274983; x=1691866983;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DngZium9YNJVRhCjETKR9D2bXwrG2zkugrzo7kcpi74=;
        b=Nrmj1va9hNm08GU+8ZsPiTCrDpOT3hRhuotl+zXT5mTdEL+TzqEVy5iZaF9g2ZKZhc
         Y1NCsOJA2g39tH7+/9LTB01mNxZFKuEiC6FYJSBa2MhGao1FIw/d+o2uHi7+mJUCbQsl
         Ypb6GLYIrDGRghZNRZz/nKA8ldRhjtzWr172WMwULp6uXPKk9rK55a7ugdLaraFPihEe
         3KKGigjjf3SyJXdw437LrGnCfkTxm1DHoWToaGbb0JwFn0IWAL8HoKMqhi1iKwyh2q0S
         IyTQsBnlOWNHe8OrS682ixPyf1C2SWcxjPaph3Ej/Ippp8jf919TQKyTlgUJQSbwRE63
         2l+Q==
X-Gm-Message-State: ABy/qLbnJFEcLyjeeVGlNPK/7gVLAZ8va9ahK+kaoWu0TWWXXSywTeol
	kR7wkxpfxKAyKrPmd7IhEs9MKA==
X-Google-Smtp-Source: APBJJlHnK8Hn9JCbj24jOu7iGnKo1+mfNp7iDzdNWTd6LEXJupQ0q/Po/SadrD4uYuCt4QGK7BzJhA==
X-Received: by 2002:a5d:6085:0:b0:314:4c1d:1c0a with SMTP id w5-20020a5d6085000000b003144c1d1c0amr2044660wrt.46.1689274982950;
        Thu, 13 Jul 2023 12:03:02 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:d855:a28a:e0c1:ddc1? ([2a02:578:8593:1200:d855:a28a:e0c1:ddc1])
        by smtp.gmail.com with ESMTPSA id k8-20020a5d5188000000b00314172ba213sm8582332wrv.108.2023.07.13.12.03.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jul 2023 12:03:02 -0700 (PDT)
Message-ID: <a936c2db-6c2c-2a2e-0657-9ddab3c18a2c@tessares.net>
Date: Thu, 13 Jul 2023 21:03:01 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH mptcp-next 0/2] selftests: mptcp: pm_nl_ctl: display
 errors if any
Content-Language: en-GB
To: Mat Martineau <martineau@kernel.org>
Cc: mptcp@lists.linux.dev
References: <20230705-mptcp-issue-368-pm_nl_ctl_ack-v1-0-40bcff40cb6b@tessares.net>
 <3f261320-9413-187e-56ef-c64d7fc983a2@kernel.org>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <3f261320-9413-187e-56ef-c64d7fc983a2@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Mat,

On 13/07/2023 19:17, Mat Martineau wrote:
> On Wed, 5 Jul 2023, Matthieu Baerts wrote:
> 
>> Recently, I wanted to understand why the userspace_pm.sh test was
>> failing on some arch according to lkft reports. There was nothing in the
>> logs apart from seeing the expected event had been missing. I then
>> realised the output of pm_nl_ctl was muted but also this tool was not
>> looking if there were errors after having sent some Netlink commands.
>>
>> I don't think it is a good idea to mute the output and ignore errors,
>> especially here in the tests where we do want to validate these Netlink
>> commands. So now the tool checks for errors and the output is no longer
>> discarded.
>>
>> Note that I didn't manage to read the error message set by the kernel. I
>> think the rtattr pointer in nl_error() is wrong. I think it should get
>> info from &err->msg instead of nh. Anyway, here we at least print errno
>> and just in case someone wants to have a look, it is easy to test:
>>
>>  ./pm_nl_ctl ann 1.1.1.1 token 12 id 0
>>
>> Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
> 
> 
> Hi Matthieu -
> 
> Good idea to add the relevant error output.
> 
> I noticed in the CI run for this patch set
> (https://cirrus-ci.com/task/5548960819970048) that some netlink error
> info is printed in the "OK" test results too:
> 
> [17:50:36.964] # flush addrs                                       [ OK ]
> [17:50:37.070] # netlink error -22 (Invalid argument)
> [17:50:37.076] # ./pm_nl_ctl: bailing out due to netlink error[s]
> [17:50:37.187] # rcv addrs above hard limit                        [ OK ]
> [17:50:37.295] # netlink error -22 (Invalid argument)
> [17:50:37.300] # ./pm_nl_ctl: bailing out due to netlink error[s]
> [17:50:37.413] # subflows above hard limit                         [ OK ]
> 
> Do you expect that with your changes?

Good catch, I didn't think about looking at pm_netlink.sh.

The 3 errors I see looks normal to me:
- trying to add an entry already there
- trying to set the two limits above the hard limit

So I guess I can mute stderr in a v2.

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
