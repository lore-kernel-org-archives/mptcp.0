Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E471B624
	for <mptcp@lists.linux.dev>; Sat, 14 May 2022 11:25:38 +0000 (UTC)
Received: by mail-ej1-f50.google.com with SMTP id n10so20600540ejk.5
        for <mptcp@lists.linux.dev>; Sat, 14 May 2022 04:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=5SmHoWxnKzXY2uBCIOzXzonVnWtEIDzauyNOKq9u7eI=;
        b=6GUS9k+M0eSJFMF0xOPoclOUTwu5iNGXzgg2AXgMbk61mUNjEBlRXgUqZwg9tMlD1t
         G5A16IyxpC0cIpZSGyeivj57zdtTTOmWhps3Uhcmt4d5Vu7B2h0FQpsU/TZqBm/Vpzw/
         UDUK3MBbSXYLO1e7X3A5Mpui5mH3UUjkHpOjrV3TXVAUu15J02dCaQ6aYYeIhevAlqKz
         DcRixDGRqHFWVQyIYs/CiUmIXY2RM+PW+7nT6KSEDjQY1WsocSv1QVP1iJFJupp6zFmx
         D8FZPD7BzYyz45DY40I8hZCtozS5JLmESMxudDFpcAV1PQc+T0J7hPev9uSLYe1aP19h
         xAiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=5SmHoWxnKzXY2uBCIOzXzonVnWtEIDzauyNOKq9u7eI=;
        b=HuJ3Nk4O27PHVMYEwES2w3+TAj6+eomK9kpkReDu/zLozOJ3kGWlYTvGKeytGWGXdw
         090Y6KizFJQMGoBrfi/TNTIT3MNuzgkJNu2t6ea5lj5gu+GCt66/EPfmCbV+qeY/M2HA
         mXyTiqAKWWqgvtBImAQ+KQAFLmqSrBYSiFKHWcKrLxR15It2eEjFPqNkKuNv4XJQ0yz9
         GDHVgEVUppgGuKxbBCxa1NHtyhZLmoVrSkEEIfzdyGH8a9PoMnJcc9ga3k25IiVH8dlK
         oKcexocqlrOZ6+8C0qzsy+bLNFpZMAqEfAiLNnL3kg3qVU+HRt4oe/l+WkhD9udRvNJ2
         ZK5w==
X-Gm-Message-State: AOAM5336OTBtbEu7gjNzk8ZaKCTxylritqbcYwCOgvpEdTA/5mVd1NYI
	bvoH565Zb3Pk+s6RpsBk+pw+ErHXo+d0NLOlRoU=
X-Google-Smtp-Source: ABdhPJztJKeD0/J5dUD7C4MnMbecTHaXxcUxIQxGVKjIOXOZzoaJhNNDQw8uAHTQlQs+1bHvBHjwig==
X-Received: by 2002:a17:907:7243:b0:6f4:1ce5:4ac4 with SMTP id ds3-20020a170907724300b006f41ce54ac4mr7842823ejc.198.1652527536785;
        Sat, 14 May 2022 04:25:36 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:743f:d142:ea76:540b? ([2a02:578:8593:1200:743f:d142:ea76:540b])
        by smtp.gmail.com with ESMTPSA id jz21-20020a17090775f500b006f3ef214db4sm1246162ejc.26.2022.05.14.04.25.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 May 2022 04:25:36 -0700 (PDT)
Message-ID: <8f2755bc-4c52-9837-c0db-2b620d7a3b22@tessares.net>
Date: Sat, 14 May 2022 13:25:35 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH mptcp-next v2 00/14] update bpf patches on export branch
Content-Language: en-GB
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
References: <cover.1652255615.git.geliang.tang@suse.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <cover.1652255615.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang, Mat

On 11/05/2022 09:56, Geliang Tang wrote:
> v2:
>  - drop "bpf: expose is_mptcp flag to bpf_tcp_sock" (Martin & Andrii)
>  - patch 3, use is_mptcp in tcp_sock, instead of bpf_tcp_sock (Martin & Andrii)
> 
> base-commit: bcf89bc9c28e ("DO-NOT-MERGE: git markup: features
> net-next-next") on export/20220510T054929
> 
> v1:
>  - drop bpf_mptcp_helpers.h (Andrii)
>  - patch 6, skip the test if 'ip mptcp monitor' is not supported (Mat)

Thank you for the patches.

I *think* everything is now sync in our tree but feel free to check
because I had to "manually" compare patches with what was in our tree.

But in theory, our tree is now ready for a v5.

- 82041505ae27: tg:msg: changelog v4
- a59272c197c5: selftests/bpf: add MPTCP test base
- e30677603c0a: Squash to "selftests/bpf: add MPTCP test base"
- 79399587d58f: tg:msg: changelog v4
- b0d947191559: selftests/bpf: verify token of struct mptcp_sock
- d84ab981b155: conflict in
t/selftests-bpf-verify-first-of-struct-mptcp_sock
- 0c8b3a796796: conflict in t/selftests-bpf-test-bpf_skc_to_mptcp_sock
- Results: 7809acd805cf..a4159e050cd2 (export)

Builds and tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20220514T112122
https://github.com/multipath-tcp/mptcp_net-next/actions/workflows/build-validation.yml?query=branch:export

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
