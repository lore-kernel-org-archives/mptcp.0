Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC367168
	for <mptcp@lists.linux.dev>; Wed, 18 Aug 2021 19:17:58 +0000 (UTC)
Received: by mail-ej1-f43.google.com with SMTP id z20so7240388ejf.5
        for <mptcp@lists.linux.dev>; Wed, 18 Aug 2021 12:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=to:references:cc:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=QkeYWSlfI3dshXJKVk+3Blc14br2tr0ATDNCv6r1Z+8=;
        b=wq4wzzTNeKzY4DWDvy4LhEUzrVbbx3Iy/j7xIhSr1slKs3GMwsOqZuXoxg/EaOaU5T
         3as+Fm1bxrAmOXqoNHfgbvFNqL8tXT2sCIlXBUOL1xhwZImpkjsmNXIgZRMYvjD1lS4M
         GFKihSu2Q/57lSqGXbsYVSUscpozRJogP5s2HHvFCNaanED9wCTmd6+JgVkch7N0slks
         bS+C/pXr8AeT5ZDwxPDvCg3nuOmWmby0K3+qF7tb6JSP2sCDwCaPmvnYZG/0+fbQMQcy
         3D7Wt91ziywHiWyFGPE7y/UrCmWPU8g8ARrfDzono6hHQLHm74VGI7PofQbtfrpJQeGl
         dyFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:references:cc:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QkeYWSlfI3dshXJKVk+3Blc14br2tr0ATDNCv6r1Z+8=;
        b=fGhyC6q//ffkogrDkE2FHcxNmnDq/mdOefWc388QFAp3S63V56gyDvmeKBXXrp5fwp
         5b9v6N1aVcfqFmojnQ9lOd3fzUWuu/d7dTwf9BVuYJ1HnWUA7E+CAn6ZpX3GPdj4ieeF
         FLdXjwDhhP/FtlkllO71oAeDZT5Fd/PrEI4YN2g5tYZTbXnDhN+4Wdoeg35O2qpHXzg4
         HQP1FM/jl2pjsyateCXlX0iC8jDbfyW/azn296UBdjWApsX1F/bxcZ6GbMVU+vrmwe+E
         IbQMematLKzAU4oQStbGrktfQB3ve34TCqtBDbNWINnkZcRflV+Nb3y+Qhio3FKzxxnW
         M35g==
X-Gm-Message-State: AOAM533zqLSySYnUeP3sD55BDbCUkazQ8sHBsZA4vgZS1R7b5fQQVfJe
	7NCSeRciRwHhiQGvqisFSwl7gqd7YUus4A4n
X-Google-Smtp-Source: ABdhPJyOvvupQ5WcA/XYe3A03R8ELbwAYYwR2Tx0Y/mB+/13q2I8Y1B5ch6B9XQ2/AV+56VlqxbATQ==
X-Received: by 2002:a17:906:7714:: with SMTP id q20mr11554222ejm.551.1629314276936;
        Wed, 18 Aug 2021 12:17:56 -0700 (PDT)
Received: from tsr-lap-08.nix.tessares.net ([213.211.156.192])
        by smtp.gmail.com with ESMTPSA id la23sm271536ejc.63.2021.08.18.12.17.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Aug 2021 12:17:56 -0700 (PDT)
To: Florian Westphal <fw@strlen.de>,
 Mat Martineau <mathew.j.martineau@linux.intel.com>
References: <20210818102756.30734-1-fw@strlen.de>
Cc: mptcp@lists.linux.dev
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: Re: [PATCH mptcp-next v3 0/5] mptcp: add SOL_MPTCP getsockopt support
Message-ID: <ec21aace-7d24-a90d-c762-81462e9650bc@tessares.net>
Date: Wed, 18 Aug 2021 21:17:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20210818102756.30734-1-fw@strlen.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit

Hi Florian, Mat,

On 18/08/2021 12:27, Florian Westphal wrote:

(...)

> Florian Westphal (5):
>   mptcp: add new mptcp_fill_diag helper
>   mptcp: add MPTCP_INFO getsockopt
>   mptcp: add MPTCP_TCPINFO getsockopt support
>   mptcp: add MPTCP_SUBFLOW_ADDRS getsockopt support
>   selftests: mptcp: add mptcp getsockopt test cases

Thank you for the patches and the reviews!

Now in our tree with Mat's RvB tags:

- d6eeba5de1d0: mptcp: add new mptcp_fill_diag helper
- d21d692880d0: mptcp: add MPTCP_INFO getsockopt
- b3b5ec766eea: mptcp: add MPTCP_TCPINFO getsockopt support
- efd9c3320c75: mptcp: add MPTCP_SUBFLOW_ADDRS getsockopt support
- f8d31bf4060d: selftests: mptcp: add mptcp getsockopt test cases
- Results: e2ce4b28903e..ab36a40efeaf

Builds and tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20210818T191724
https://github.com/multipath-tcp/mptcp_net-next/actions/workflows/build-validation.yml?query=branch:export/20210818T191724

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
