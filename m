Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E1632596
	for <mptcp@lists.linux.dev>; Wed,  4 May 2022 16:41:21 +0000 (UTC)
Received: by mail-ej1-f43.google.com with SMTP id g6so4006195ejw.1
        for <mptcp@lists.linux.dev>; Wed, 04 May 2022 09:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Jg4b3iiCtSRrMUi3cmg2w/dCD6cyO46CCgsKSlgANqA=;
        b=RCaE8AodQdhVluuUDBu/8Y+PfF3SIOEcpFf80vKKFJoRDkElyVZX+PtdwAh6ShJ7Po
         JVA38yGCVVUap8Hzv5sSO08caVNyMpT5QRHE+5geQEUAOn+T5uVSOCPR5Y/59Gg0+jcI
         RLFU8GO+NepcIsasreOZ5JqoQ3Wruc83thKdzBVQR0/IXHw/+OfUAv1E3tAkFvwJaIUK
         cNJ6in8/gsIuWo+cV/1GsgydXF1eWeQ9aY8yojO1kkP3aAFcJPMWtsHytVhV3s7Yr8dO
         D3duzLUrt048/XZQT6ASQlizvlneCqmdd35LijLpi4mpsXwnO4jGOIku9LtndbZyASfP
         bSrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Jg4b3iiCtSRrMUi3cmg2w/dCD6cyO46CCgsKSlgANqA=;
        b=TxZDGMAz57yBiEhwovy016uCvGwCcFIu1AMdnvZznAYmNKjyJvWnP+brbUCAbK5WOx
         u9fnjBIG5pIATHL9qDRXZ05HLUBmFHJMyTK/hQ2uNFC325X+eMfCQoBeFR/wjbjWVeZ2
         xOkVeWkA1bXtBOfqQOl+YxLV5oMquiO7rlyplZbmihDascACr6CxzhdAIVdjMpSK3N1i
         uSy8CC+aUV/Dt1Y4KVCZf9gCllRWWZHoRfzBCFZ7rq8o/ZLFPmSEWzHQuopTXJrJXL1C
         ws2waKtg32R7NS9UKxNGsq793FxsOmOx/E/Xep204jpsMR7cY/BbdtBijD3oA8msSZbX
         PEfg==
X-Gm-Message-State: AOAM530QiVxqhiIifOcbmzKHCeJrnUtswJTYdmAmANd0MzAfkq1GPx90
	GKkEmijNKrZsWPTbW1AWlyRHhA==
X-Google-Smtp-Source: ABdhPJwdvnhFAndnqSmQE2BCdyP8Ys2t1yez2hR+14AALhIqPGetIhakY/2fswrSTKTMVy4z7Rwfaw==
X-Received: by 2002:a17:906:c110:b0:6e8:3a96:996a with SMTP id do16-20020a170906c11000b006e83a96996amr21173952ejc.216.1651682480207;
        Wed, 04 May 2022 09:41:20 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:e57b:38b2:b6d2:346c? ([2a02:578:8593:1200:e57b:38b2:b6d2:346c])
        by smtp.gmail.com with ESMTPSA id o4-20020a056402038400b0042617ba63c9sm9374487edv.83.2022.05.04.09.41.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 May 2022 09:41:19 -0700 (PDT)
Message-ID: <36d7d55f-9672-ffaf-8835-867adc337528@tessares.net>
Date: Wed, 4 May 2022 18:41:18 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: apropos
 https://github.com/multipath-tcp/mptcp_net-next/issues/265 (checksums)
Content-Language: en-GB
To: Mat Martineau <mathew.j.martineau@linux.intel.com>,
 Paolo Abeni <pabeni@redhat.com>, Christoph Paasch <cpaasch@apple.com>
Cc: mptcp@lists.linux.dev, Geliang Tang <geliang.tang@suse.com>
References: <3e23ea866374467e2c9aeec60049716b42d6634e.camel@redhat.com>
 <e868da1-c75e-2027-83f8-2aae37cfb923@linux.intel.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <e868da1-c75e-2027-83f8-2aae37cfb923@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Mat,

On 03/05/2022 20:37, Mat Martineau wrote:
> I noticed yesterday that the BPF CI is running big-endian tests on the
> z15 architecture. I think that's through travis-ci. Do CI providers like
> Travis or Cirrus allow interop testing between multiple VMs?

I guess we can always launch multiple VMs with qemu and allow them to
discuss with each others.

It is not complex but a bit of work to do.

> Checking on other tools we could use to confirm checksum operation (and
> run on either big- or little-endian platforms), it looks like wireshark
> tries to track DSS checksums but does not verify them. Packetdrill seems
> to have some code (maybe incomplete?) for getting the checksum data from
> headers - would require some work to complete that code and add test cases.

Maybe Packetdrill can help? Not sure indeed.

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
