Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96E932F28
	for <mptcp@lists.linux.dev>; Wed,  9 Feb 2022 12:39:24 +0000 (UTC)
Received: by mail-ed1-f46.google.com with SMTP id cf2so4734231edb.9
        for <mptcp@lists.linux.dev>; Wed, 09 Feb 2022 04:39:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:cc:references:in-reply-to:content-transfer-encoding;
        bh=Bx0N1tH32pl7PKT5jO8Ny8IegQ5n6+fnmUZSGr/nU1E=;
        b=mH5th2XBxSZtueB/unkOP8sPla8RsEvm7+F3wORlpUqoqcT7iffi6wzrbygutKOlYn
         uxIPEdtqYfOUE0Zt9VOoD14Hx2PMgwFLe0cT88ACJ5rUr0PI60CGTXHuyKVU90/3tl3W
         fmT7yWGA0DUjsRt2bGkVy5QFZthQMt5wA2O/qZueZXPmlC1YJPDxLPC1jucNtsaxaYmZ
         b1OFt4DsJKk4ADIhvrDu3VlOEMd/02X9n0kWKe+bp4pP5SMyVsnM9q3kcD2SO/FuJGBW
         YbJnPKP3KMODG4j4u/OwDTwmVzbo5OH0n7EbToqvtSJoIlRYEqBOJD5h6ye65TUPZRai
         h0Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=Bx0N1tH32pl7PKT5jO8Ny8IegQ5n6+fnmUZSGr/nU1E=;
        b=C9HRcOe6Q3US/Gn/7e9UtbD781S5yEWXoYZ8/f4NftS+WVUx9hQrMZgxSjtHqG8+ye
         tchTWgIC8//sofUg7riNQywBrhAeoj1mbBUDY7U4dB5gevJNmxAdz9suXisG0cvkwRt6
         2tUd237/ede3QkSwvC8OTRE9IahGHmaOCCgHN9go3THiqugckB1RDJ761B4PxJO9N9kc
         vCEQofVUmFRVDNC9l/sDDHl79r3Dlb+QGQRckP91d7FVYmxv+/c/JJ68ix//R+Aw0gaH
         uOQTy6EzO1y6yfzvo84UR5lyqtigJwn+Zk2Aym1eVAZuapteaeawv2cd02Enjv7SwqGP
         DhGw==
X-Gm-Message-State: AOAM533q68fUUnvsatj1Y9EUk123OFpoqRD0Pwdsi6uI+cafYLbPDM7V
	d5zXFM2fWrkcCn/7zC0LwHGs3A==
X-Google-Smtp-Source: ABdhPJzFuc/cLsX0QDu9hhMAC0dLvM8QqeAMU7ouzlwdPA84P6NtSwJaZFwfrKCMZ4X3uZNawnRRcw==
X-Received: by 2002:aa7:c04d:: with SMTP id k13mr2195850edo.301.1644410362870;
        Wed, 09 Feb 2022 04:39:22 -0800 (PST)
Received: from ?IPV6:2a02:578:8593:1200:42a6:e0be:778a:86e8? ([2a02:578:8593:1200:42a6:e0be:778a:86e8])
        by smtp.gmail.com with ESMTPSA id u3sm6118399ejz.99.2022.02.09.04.39.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Feb 2022 04:39:22 -0800 (PST)
Message-ID: <8479f723-1739-f974-a717-0c33a2001faa@tessares.net>
Date: Wed, 9 Feb 2022 13:39:21 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH mptcp-next v5 5/5] selftests: mptcp: add mp_fail testcases
Content-Language: en-GB
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
Cc: Davide Caratti <dcaratti@redhat.com>
References: <cover.1644402973.git.geliang.tang@suse.com>
 <c1dd2b5c0105f42b9fb12447011d3830c057ac57.1644402973.git.geliang.tang@suse.com>
 <fd43654f-12eb-9830-0360-acb42c9d5a55@tessares.net>
In-Reply-To: <fd43654f-12eb-9830-0360-acb42c9d5a55@tessares.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 09/02/2022 13:36, Matthieu Baerts wrote:
> Hi Geliang,
> 
> On 09/02/2022 11:43, Geliang Tang wrote:
>> Added the test cases for MP_FAIL, the multiple subflows test for the MP_RST
>> case and the single subflow one for the infinite mapping case.
> 
> The tests are passing on the public CI, that's good!
> 
> But the output is less good:
> 
> # Created /tmp/tmp.crkOA4p7hr (size 1024 KB) containing data sent by client
> # Created /tmp/tmp.jFbZEAnYZa (size 1024 KB) containing data sent by server
> # file received by server has inverted byte at 195585
> # 100 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] -
> ack[ ok ]
> #                                          sum[ ok ] - csum  [ ok ]
> #                                          ftx[ ok ] - failrx[ ok ]
> #                                          rtx[ ok ] - rstrx [ ok ]
> #                                          itx[ ok ] - infirx[ ok ]
> # Created /tmp/tmp.crkOA4p7hr (size 1024 KB) containing data sent by client
> # Created /tmp/tmp.jFbZEAnYZa (size 1024 KB) containing data sent by server
> # [ FAIL ] file received by client does not match (in, out):
> # -rw------- 1 root root 1048604 Feb  9 11:37 /tmp/tmp.jFbZEAnYZa
> # Trailing bytes are:
> # MPTCP_TEST_FILE_END_MARKER
> # -rw------- 1 root root 1048606 Feb  9 11:37 /tmp/tmp.ghV0iWPhu5
> # Trailing bytes are:
> # MPTCP_TEST_FILE_END_MARKER
> # file received by server has inverted byte at 169
> # 101 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] -

Strange we have 5 packets here. I guess this is because we mark one
"big" packet (carrying data and TCP options over the MSS size) which is
going to be split by TSO after our TC hook. No?

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
