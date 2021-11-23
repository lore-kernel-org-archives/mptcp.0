Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC2DF68
	for <mptcp@lists.linux.dev>; Tue, 23 Nov 2021 15:42:45 +0000 (UTC)
Received: by mail-ed1-f48.google.com with SMTP id x6so81718256edr.5
        for <mptcp@lists.linux.dev>; Tue, 23 Nov 2021 07:42:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:cc:from:in-reply-to:content-transfer-encoding;
        bh=QW4JtPctxwuLBL05rHonJ9CH18qFn/y56hNUt5F452g=;
        b=leQ0R2BCYexcM1MR2s0oxVKkxC4Uy7rPuI5GjITZ+Z0FFLHOUI3T4HxQfeAH9xQBjq
         dCT7oniChbkuHwg4QSaEJ0NP1P5fzqaL7s7cn8lZDkhVfJgxtoqqp26ie3beJpT7WIJd
         nYQZnsxgS74KzfjMTivC5nGnaDaA2AIbe8BSoPvdspfEwNPu5aclwPK8uKvyufjDebb9
         fsY4eom9KPM7nz+Y7IwF+SgR0cxJjAVZFp+1STQJ76yMDoZFpg69qrPFchpUGSu9PwHM
         9XUApJAMiyUuaSqiRFOuGCdRHc6S0Ds+B6ZA7KjQcwOiA4Kja+O+sKsuthPkahfe2hgR
         GmHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:cc:from:in-reply-to
         :content-transfer-encoding;
        bh=QW4JtPctxwuLBL05rHonJ9CH18qFn/y56hNUt5F452g=;
        b=I9YIurmchfNyocgkdD1yN7XBE6KdPWlxoaGsYo5CVhWInX4RmsQ+Ld+y7runWLZVL3
         Wp+b73ubCStDn+pJ485DrFM2l6ZQ8lUTFFmZfv2SryzOMtnaWTM3i04gQ0/OgQRhQo72
         04iWQxGswCh4Z7/wCEsgpGcPO2n6wv+VG2ngsYhajfdP8+eOp3jEusNONSsjZ9yp2e3o
         ruv83ZxaBBnDwWTxwG6PoJ4zQl2as+vltaVYQkb0QtyQwD+pyBQ6B3vxEgy/c3fYKAku
         5DKo7B0NWEedlotEm+53eW0ADSPUVdpK0nlcAj5frHqHf0Q/P9K/FYPx2FYRvTPgen0j
         Fa1w==
X-Gm-Message-State: AOAM531XwiAGUK5iCAOvgCChNQ+vfhtiNafWKd0QEnqbfpU9HDeQuFVi
	oqQlgLr3PdpRPIijqbK/uFnpiK5LdOoEXA==
X-Google-Smtp-Source: ABdhPJwXqknJh0HWQqvpG6cBgx6GnocPqvXO+p0mFVAWntXVr/Ad9jAH8k/Z4aRnK3LiBiBwXwhMVg==
X-Received: by 2002:aa7:c313:: with SMTP id l19mr10594831edq.209.1637682163206;
        Tue, 23 Nov 2021 07:42:43 -0800 (PST)
Received: from [192.168.178.33] ([213.211.139.36])
        by smtp.gmail.com with ESMTPSA id d1sm6296315edn.56.2021.11.23.07.42.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Nov 2021 07:42:42 -0800 (PST)
Message-ID: <2b7e51e4-6c39-d6a0-51d1-44f425a18701@tessares.net>
Date: Tue, 23 Nov 2021 16:42:41 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH v2 mptcp-next 2/2] selftests: mptcp: check IP_TOS in/out
 are the same
Content-Language: en-GB
To: Florian Westphal <fw@strlen.de>
References: <20211122152651.28466-1-fw@strlen.de>
 <20211122152651.28466-2-fw@strlen.de>
Cc: mptcp@lists.linux.dev
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <20211122152651.28466-2-fw@strlen.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Florian,

On 22/11/2021 16:26, Florian Westphal wrote:
> Check that getsockopt(IP_TOS) returns what setsockopt(IP_TOS) did set
> right before.
> 
> Also check that socklen_t == 0 and -1 input values match those
> of normal tcp sockets.

Again, thank you for the patches!

Now in our tree (feat. for next):

- 920d96a81032: mptcp: getsockopt: add support for IP_TOS

- 2a48dce13e02: selftests: mptcp: check IP_TOS in/out are the same

- Results: c0fa7477e85c..4d2c9db8443e

Builds and tests are now in progress:



https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20211123T154225

https://github.com/multipath-tcp/mptcp_net-next/actions/workflows/build-validation.yml?query=branch:export

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
