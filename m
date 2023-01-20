Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9973517E6
	for <mptcp@lists.linux.dev>; Fri, 20 Jan 2023 10:07:52 +0000 (UTC)
Received: by mail-ej1-f52.google.com with SMTP id ss4so12580833ejb.11
        for <mptcp@lists.linux.dev>; Fri, 20 Jan 2023 02:07:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PyuRC16RNsk7K6WGBVBSReefG793JHUBCM/5sTXGDKg=;
        b=n/6AN30BbiwejM73zH+H1olqK+4hSdEZaqfr49ClKkeRY9xYHrWl/iBrQDIwY8G3Ro
         JRClqyN1zk0O3eLjNiN58rFFpBf3rtmaHo3a/bCGspmTu97kXOyHFNrgQU3/QZekzp5N
         A6b3LprKg1A/lT76vPZVRQC/4jzpAxYhBEPYAMARZR/oaEYucsQXCuLlZVXhcIYsIJ7D
         aQY8mx+SzVlFhVTR8nANsHefBs6a7agryR4hnW1xbt8HLhhy4rDpEWY4+4jA8aDWQEON
         CWZ1qdG869NJNXTD1/TKFS20cllIehPAbQJEJ9ppC8c9TLXUcZ9wy3E96fF6HBEygRTF
         X7bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PyuRC16RNsk7K6WGBVBSReefG793JHUBCM/5sTXGDKg=;
        b=CD3H09u+uK+Brh4nu/+sf5Jr7BhMZDCtMUvKDpNsO76AIWIDLDfmYMSgovK2Gva04H
         rOpf00YPC6pnll84BTw64Ps9h78CcxDzsxr0Xz5VqsBRbZYNZRtHrSm3PvlJ1kLK611J
         eBvmFpvCbuFxHJ+CPtUhP+PSvvroTcIgUwIoScZRhl9AahiHzMFfDHZ/HA5bSzpYeMex
         NetBAWamsuiM3x9CwJEOg4bEFgJSj7zHGRPQ8zzzyPNTgEHTw3LPx0kvVR83caH6CBHw
         Dm+0XxjPv6xaA3aLGeNqGP4VeeZah9mtDJ4cwxzZ19anlLUscguFYUgtHmjRNKsK9zHQ
         oo8g==
X-Gm-Message-State: AFqh2krcmsaLwfQuJTn724XrWLAhG3+IIWbcIu3jLhPfp7SG0OSV5aTf
	6qm2o4dhqXBcZjSVnvQSbYxy8+A6gW+suJcfx22+FA==
X-Google-Smtp-Source: AMrXdXuNXiQQxIXgrEGjoRQJW9FI9pADP+u+dpxi/ZPeIMbGNzkE5IOxt2XQdIvxX6ek0uaim3xYiA==
X-Received: by 2002:a17:906:57cf:b0:841:e5b3:c95f with SMTP id u15-20020a17090657cf00b00841e5b3c95fmr13982006ejr.29.1674209270698;
        Fri, 20 Jan 2023 02:07:50 -0800 (PST)
Received: from [10.44.2.5] ([81.246.10.41])
        by smtp.gmail.com with ESMTPSA id d9-20020a1709063ec900b0084c2065b388sm17538839ejj.128.2023.01.20.02.07.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Jan 2023 02:07:50 -0800 (PST)
Message-ID: <e3ccc49d-b90c-2003-d966-1739a318b2d6@tessares.net>
Date: Fri, 20 Jan 2023 11:07:50 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH mptcp-net] MAINTAINERS: Update MPTCP maintainer list and
 CREDITS
Content-Language: en-GB
To: Mat Martineau <mathew.j.martineau@linux.intel.com>, mptcp@lists.linux.dev
References: <20230119224411.24410-1-mathew.j.martineau@linux.intel.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <20230119224411.24410-1-mathew.j.martineau@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Mat,

On 19/01/2023 23:44, Mat Martineau wrote:
> My responsibilities at Intel have changed, so I'm handing off exclusive
> MPTCP subsystem maintainer duties to Matthieu. It has been a privilege
> to see MPTCP through its initial upstreaming and first few years in the
> upstream kernel!

I just applied this patch in our tree (fix for -net) with my Ack:

New patches for t/upstream-net:
- 11cee47cfc2c: MAINTAINERS: Update MPTCP maintainer list and CREDITS
- Results: 051fdb31d822..ffc202408d0f (export-net)

Tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export-net/20230120T100637

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
