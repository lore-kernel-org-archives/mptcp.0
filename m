Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AE982568
	for <mptcp@lists.linux.dev>; Fri,  6 May 2022 17:27:46 +0000 (UTC)
Received: by mail-ed1-f45.google.com with SMTP id p18so9463064edr.7
        for <mptcp@lists.linux.dev>; Fri, 06 May 2022 10:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=LoMKuMuAN5MaEos3V4pQjO2M0QD1YyCGAjiU8ZS2/zg=;
        b=eOByuhRplCIc6SULimLm8MQNrNqQKFmSkCNyUa3+nDmzmEUhnvH8CQGXpiXNMYeboG
         X47pCeDM4DIkD6+SH5CyZ9ka85by92X29rwy7wC20gI6yVVy6icdCv4poM9/Sj2Flclk
         Cd9ayfnfcdBvwrgvPZ9uYa8cgN7Lx2VFvcLdVJlJbqDV7my8MAmIoy9a/eYXeoIa74iU
         Vss182CwuVKGq6oJ2HadSEyMY06J/o/UOx5hDLMS43W/GJunehdlosIO7FLDl0HqDOyH
         CCpthmoV9+dvnxILXfb76e+fYY0e7eGrdFvvFumXSb/NF1Ih2ZmxY1UTqzEG+5AZFnK5
         WRWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=LoMKuMuAN5MaEos3V4pQjO2M0QD1YyCGAjiU8ZS2/zg=;
        b=sTDmPPK7I8AdIs43g181Jy1F+PK5fnF5a6kgVuos+hI0GD7mIOx0IkUoIgaX+OP3Q5
         NJ1xR3uNT01tkI9FWauWL+O83c5bwejFez15nc4r9bnwm9AVW+V3UaTW7cnNVBtng1wc
         nZjObEWH3LKD46AO+/BzN1ETpRpfENAm6vjHe7a4vhH3qScDCmYTCUcPqopXEhGGtaK/
         YufGKAQwxP6whMVEFDz8R18gQBWDVDuQEk/uXEsEhCACzSRUnLE92SeKL2b3zRCLfO5f
         JTftZZ869ca7sStogFPz41J5TMJprZd/rWcwXQlmFrMYW5Jq0TCo0fyM7LoZaA6YClsR
         8+SA==
X-Gm-Message-State: AOAM533OVBen2fyLAtzg6dvptwMqSNy7Bz1ldY2w2hma5K8R1+LJwgO3
	uayyvd4GxaHoDUIqHIO9qGjLqM+GhdYawDKn
X-Google-Smtp-Source: ABdhPJxddgyun73K3FcqP0mSdJBI1za2d0DFFd0DCcq+Rd4sqJWqZzuBeFujMz7a2nGz2PDXGKXmxA==
X-Received: by 2002:aa7:d5c5:0:b0:425:b144:ab84 with SMTP id d5-20020aa7d5c5000000b00425b144ab84mr4591514eds.200.1651858064120;
        Fri, 06 May 2022 10:27:44 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:2a7b:53c5:db4:9313? ([2a02:578:8593:1200:2a7b:53c5:db4:9313])
        by smtp.gmail.com with ESMTPSA id d2-20020a170907272200b006f3ef214e21sm2126789ejl.135.2022.05.06.10.27.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 May 2022 10:27:43 -0700 (PDT)
Message-ID: <cae2a736-c896-aabe-6df3-5bc9a7ec79c8@tessares.net>
Date: Fri, 6 May 2022 19:27:42 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH mptcp-next] Squash to "selftests: mptcp: add subflow
 limits test-cases"
Content-Language: en-GB
To: mptcp@lists.linux.dev
Cc: Paolo Abeni <pabeni@redhat.com>
References: <20220506171819.1104074-1-matthieu.baerts@tessares.net>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <20220506171819.1104074-1-matthieu.baerts@tessares.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hello,

On 06/05/2022 19:18, Matthieu Baerts wrote:
> From: Paolo Abeni <pabeni@redhat.com>
> 
> The test -- "delete and re-add" introduced by the above commit -- is
> failing on the different CIs with a debug kernel config. It is also
> failing without the debug config but it is less frequent, only on the
> public CI.
> 
> Increasing the packet size from 1KB to 4KB makes the kernel sending
> multiple packets and it seems to fix the issues reported by the
> different CIs.
> 
> Note: Paolo shared the diff on IRC without a commit message. I prefer to
> apply it like that (without his SoB) so we can stop ignoring CI's
> output.
> 
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/274

Just applied in our tree:

- b195639989ab: "squashed" in "selftests: mptcp: add subflow limits
test-cases"
- Results: ffee67422349..825394fc0bc5 (export)
- Results: a2c76d73f38a..ca8b19c6d86b (export-net)


Builds and tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20220506T172517
https://github.com/multipath-tcp/mptcp_net-next/actions/workflows/build-validation.yml?query=branch:export

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export-net/20220506T172517
https://github.com/multipath-tcp/mptcp_net-next/actions/workflows/build-validation.yml?query=branch:export-net

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
