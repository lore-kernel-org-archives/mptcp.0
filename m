Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 268F72F26
	for <mptcp@lists.linux.dev>; Fri, 11 Feb 2022 11:03:34 +0000 (UTC)
Received: by mail-ej1-f48.google.com with SMTP id qk11so1721541ejb.2
        for <mptcp@lists.linux.dev>; Fri, 11 Feb 2022 03:03:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:cc:from:in-reply-to:content-transfer-encoding;
        bh=H6zUkz5/u6YMU3f3mmnNv0vyv99irPL9Cs5QLnIqxok=;
        b=X1eRLe1117MFRo1E8Yq9cq9ulTjcqitO6FfawwB7BpEgxNurl8Yp8lTJYTejb/KTVe
         mv8XdFDi/IUfFaDCz94Cc3BPQbmeof1U1izZffBfs3BfbRoY2qEaxX6lS7pmleK2pvW0
         yAyLX9OXyQpPgH+BV6h3cvMY8uVUiDmCztjMsg4a9jW93Atv1O8eMllF6nQZQpq9m1Vw
         toDQLtdGN2vhykZr12Pw86arFvhC8cwMNqnn3GgM4QJrZLIK/ylKFbzDfUcEsK04Z9Ki
         0lc1rizEiXZ0yK+q6GGgsFKfR7+fG+wfJdfIiNnEwDH0Jiv4KCHLFReiy4Gy3em7Bkmn
         L1sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:cc:from:in-reply-to
         :content-transfer-encoding;
        bh=H6zUkz5/u6YMU3f3mmnNv0vyv99irPL9Cs5QLnIqxok=;
        b=HZImjyGJSWV/ZnPbPQMaDv5Vt3pAkcxQbs5gBvZn5spXCyCIVBQUIi1zN+LIRzAkUh
         gqwMtoXGYIIlODKc6oBXmYlPiCdV6cygPrCIPTa6qbtpWDRl1lYdyv4Tp70Ik0oKTB/l
         mdeFPkGlMJOysaQxd9C0/Up5AVMSv8+I2MT3fv4X0hkksRsZs2mc9O8HsUIBH4hw1esF
         0ddcx9TqPPYSZnpAXpoD+4PgInPPvVVUK3T3nP5+PM9ee/+qb/H88zMEhDaYNW4Pijnr
         hfA2/p4P2jgYn3+2lCOarDF7fTs6l8LMotp3rs4BNszWuvtuMceozYEdDuNAOKj5ejiB
         ZEUg==
X-Gm-Message-State: AOAM531hRWiP2Taheqtr6Ly9rsWqngQtuSTW9LH24It5vN6cQjKiJzcT
	WbEWlesqaEavFxcsAx8hnaxo5K3NonHeTA==
X-Google-Smtp-Source: ABdhPJw9ltOtx5JNILkaui1rI9g8MFcaRjemZP1aykmOqMPAeTi/z6qV/sIViX9snixUEIeO2ZGIZA==
X-Received: by 2002:a17:907:6e91:: with SMTP id sh17mr922494ejc.534.1644577412370;
        Fri, 11 Feb 2022 03:03:32 -0800 (PST)
Received: from ?IPV6:2a02:578:8593:1200:fea5:b1fd:66cc:fe97? ([2a02:578:8593:1200:fea5:b1fd:66cc:fe97])
        by smtp.gmail.com with ESMTPSA id b14sm4048028ejb.160.2022.02.11.03.03.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Feb 2022 03:03:31 -0800 (PST)
Message-ID: <a4083205-58f5-fcec-7883-7d69df7cdf2c@tessares.net>
Date: Fri, 11 Feb 2022 12:03:31 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH mptcp-next] mptcp: subflow: get_af_ops should return const
Content-Language: en-GB
To: Florian Westphal <fw@strlen.de>,
 Mat Martineau <mathew.j.martineau@linux.intel.com>
References: <20220210145534.32660-1-fw@strlen.de>
Cc: mptcp@lists.linux.dev
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <20220210145534.32660-1-fw@strlen.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Florian, Mat,

On 10/02/2022 15:55, Florian Westphal wrote:
> Thre returned structure is read-only.

Thank you for this patch and the review!

Now in our tree (squashed):

- a2b3e7491b59: "squashed" in "mptcp: mark ops structures as ro_after_init"
- Results: 7f0a980be1a6..178780fe8241

Builds and tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20220211T110237
https://github.com/multipath-tcp/mptcp_net-next/actions/workflows/build-validation.yml?query=branch:export

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
