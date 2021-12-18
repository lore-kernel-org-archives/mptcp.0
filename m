Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 700062CA8
	for <mptcp@lists.linux.dev>; Sat, 18 Dec 2021 09:00:15 +0000 (UTC)
Received: by mail-ed1-f45.google.com with SMTP id b7so16906745edd.6
        for <mptcp@lists.linux.dev>; Sat, 18 Dec 2021 01:00:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:cc:from:in-reply-to:content-transfer-encoding;
        bh=2k8ieU8BuErsIiTncwQZvMiUNCl8YRMs036Tk6cISus=;
        b=4hekZEo/DWkyTvmpa9p2EtQbMXhU3qzVMS//1FNHpih+/g6b1ytKkt8SzgPx6dxBj2
         iRItH5KCOXfzoaKJs5d8esqQQcNBcDZdY8sMx0+JD8ss2in65AO8mQa5dx2K4br4dz4g
         eyoD2o48tqbRC5XMYZC95YB8Kj6pzWP+gEopxr7db+gDdwLEhgxxiIVQn8o8Ksk/s8Qc
         RudT1qTyCHjrGKblhK0S4e/71S4z5x6TLX9vfKR8ukk9Kfmh0kHOGnhH5C1jIusHwQuF
         RPMzP8EtT2vgmLi7y6CeSQbe4MOwmOmU8jXrZPK09LgMPEzBaqTsaq8Yr/9PzUdQ19lQ
         iFwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:cc:from:in-reply-to
         :content-transfer-encoding;
        bh=2k8ieU8BuErsIiTncwQZvMiUNCl8YRMs036Tk6cISus=;
        b=O+Jz/sJnX2AjvaIeWMZrN+1UbG/9pXnZ4aJhpJgi71wdw4QfvEVNvk0H7f4eg+CEQl
         vhC4pEFbaefEnlAPqK6Giqt8y6T7gJuV9dNzlTrdlhmuXWdub2wCjWyywmNaq/u8IYCy
         H+dBJMiyzMMTw3D9kmIGYhRdy4HU937Dejz8m4QR7aUpXGhU+1j5RsPT9fcNUdx9wIO7
         PWkUPnJPPF6KNOLMg4AVuZ4M/5VLKFjssqnb4xah+RjVm3pwNBF/QubMBjg24WPi2OCk
         c++JMQTtXx2Hl0BAQpiS8uGI3UFWspMabZvJAbAmCddWkh7yaQS2WeYuHdHrhlEHeiv2
         uvyQ==
X-Gm-Message-State: AOAM530VzN9EcWD46295SLAKO+9evtR/HMzul6m1SOPivhy4HXuKDDZz
	36+CXMx39r9TgW6plaVoWXkUiYQLfxn0tzJi
X-Google-Smtp-Source: ABdhPJzt5GDk7Eo0Srju1A0WrPDPurV5tKhcfbCZlA7dWxbhiJg8Ds+LNE81Ieh2tj924ba9m5jltg==
X-Received: by 2002:a05:6402:1241:: with SMTP id l1mr6600699edw.115.1639818013299;
        Sat, 18 Dec 2021 01:00:13 -0800 (PST)
Received: from [10.120.18.55] ([84.17.46.18])
        by smtp.gmail.com with ESMTPSA id dp6sm3607855ejc.140.2021.12.18.01.00.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Dec 2021 01:00:13 -0800 (PST)
Message-ID: <c1efac9f-3f1c-d45c-8857-453dde8294cf@tessares.net>
Date: Sat, 18 Dec 2021 10:00:12 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH mptcp-next] Squash to "selftests: mptcp: add tests for
 subflow creation failure"
Content-Language: en-GB
To: Geliang Tang <geliang.tang@suse.com>
References: <82bd312f4f8ada4709d1a0d8525f1491006ec866.1639723286.git.geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <82bd312f4f8ada4709d1a0d8525f1491006ec866.1639723286.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang, Paolo, Mat,

On 17/12/2021 07:42, Geliang Tang wrote:
> Align the output logs with others.
> 
> 01 no MPC address reuse with single endpoint syn[ ok ] - synack[ ok ] - ack[ ok ]
> 02 multiple subflows, with failing subflow syn[ ok ] - synack[ ok ] - ack[ ok ]
> 03 multiple subflows, with subflow timeout syn[ ok ] - synack[ ok ] - ack[ ok ]
> 04 multiple subflows, fair usage on close syn[ ok ] - synack[ ok ] - ack[ ok ]
> 05 no JOIN                              syn[ ok ] - synack[ ok ] - ack[ ok ]
> 06 single subflow, limited by client    syn[ ok ] - synack[ ok ] - ack[ ok ]
> 07 single subflow, limited by server    syn[ ok ] - synack[ ok ] - ack[ ok ]
> 08 single subflow                       syn[ ok ] - synack[ ok ] - ack[ ok ]
> 09 multiple subflows                    syn[ ok ] - synack[ ok ] - ack[ ok ]
> 10 multiple subflows, limited by server syn[ ok ] - synack[ ok ] - ack[ ok ]
> 11 single subflow, dev                  syn[ ok ] - synack[ ok ] - ack[ ok ]
> 
> ->
> 
> 01 no MPC reuse with single endpoint    syn[ ok ] - synack[ ok ] - ack[ ok ]
> 02 multi subflows, with failing subflow syn[ ok ] - synack[ ok ] - ack[ ok ]
> 03 multi subflows, with subflow timeout syn[ ok ] - synack[ ok ] - ack[ ok ]
> 04 multi subflows, fair usage on close  syn[ ok ] - synack[ ok ] - ack[ ok ]
> 05 no JOIN                              syn[ ok ] - synack[ ok ] - ack[ ok ]
> 06 single subflow, limited by client    syn[ ok ] - synack[ ok ] - ack[ ok ]
> 07 single subflow, limited by server    syn[ ok ] - synack[ ok ] - ack[ ok ]
> 08 single subflow                       syn[ ok ] - synack[ ok ] - ack[ ok ]
> 09 multiple subflows                    syn[ ok ] - synack[ ok ] - ack[ ok ]
> 10 multiple subflows, limited by server syn[ ok ] - synack[ ok ] - ack[ ok ]
> 11 single subflow, dev                  syn[ ok ] - synack[ ok ] - ack[ ok ]

Thank you for the patch and the reviews!

Now in our tree:

- 2a6be13b8c8e: "squashed" in "selftests: mptcp: add tests for subflow
creation failure"
- 226152ce39b0: "Signed-off-by" + "Co-developed-by"
- Results: 8e31f966b708..079ed80abcff

Builds and tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20211218T085941
https://github.com/multipath-tcp/mptcp_net-next/actions/workflows/build-validation.yml?query=branch:export

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
