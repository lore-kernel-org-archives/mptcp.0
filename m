Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 370C668
	for <mptcp@lists.linux.dev>; Tue,  2 Nov 2021 09:44:46 +0000 (UTC)
Received: by mail-ed1-f49.google.com with SMTP id 5so72766587edw.7
        for <mptcp@lists.linux.dev>; Tue, 02 Nov 2021 02:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:cc:from:in-reply-to:content-transfer-encoding;
        bh=cfnDaOMcwQ/4fCuj5iZHh7VhZCNIBzBRAeLefGbVNEw=;
        b=GgAg2IlGTAFrEn7rfChlYi/IjwwO34Ezh862eNt4hb0HPjDJPBAISeL5b7GitCrdaz
         rV/hQJJ9CVV7SpS7COaWmjTnCOt5BzSB3twLYQQtbVwk7W3YouW1vLEqJxqkv8b8W/Sf
         vioU4D+a48oAG+C0tUvaK0xKdgbBbNauPhlWmv0Fh8j1jlcsc8wDcmMPpo9JyiDeDnI+
         59DD8Ci1/0H4qdzRhTSxtXe4KfHRHoOzFRAcxy2j8zC9H28Czdz+az3NFwZnoSC6X2iP
         57iDKWWOBHiGeyGEgJwOO2OJX4cqyypGsdwycHQxUYSPJamMbot7Vbn3VOkkIm9kC0Tp
         7SaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:cc:from:in-reply-to
         :content-transfer-encoding;
        bh=cfnDaOMcwQ/4fCuj5iZHh7VhZCNIBzBRAeLefGbVNEw=;
        b=P4WYtbAS9DFUQH9QEOnI4g3LyoTaSjHlWK7JDsyq09pVRBokiqf7w3G3rqRDO/UjjB
         xw6Y+5cq9u6LWn2UXRO4i9HAtsENg31ymxyh1m25YY6526eU+jSLoh4jbyDlsX/H6wU1
         T18/lugTdLZKTnsX7akGqpRuiNeszDGLq5hTMlkEkp2D7uP3wH6jHCS2S7hUmjatvRtl
         gpO8Ql5VHJYOsS5qyLvocbAkr6ig9gBNTDLDhPT1wbF1wDvF0d6H3Y8quw+D9HMLnSv6
         54NclaZ+BmlsYgHYlaUgRMz/XOw7tOYiUaXEOLtrYlHZo5MQmJwltwPYhz7EMAEQ6MnR
         20ng==
X-Gm-Message-State: AOAM5311JE6dgmMfxffdgdOOVuHe7eSva5ztohKOxt6R7B8OM4YeT1tr
	VvlqtHz4mTUavh/qYFTWlDQnjYH3pr16jA==
X-Google-Smtp-Source: ABdhPJxbleuABqVGlBHxD4RXwxdc326axHdvG92f0FJMMMq2i31fVijYlxwNqnuioFUFKxjrv6/X7g==
X-Received: by 2002:a17:906:a4e:: with SMTP id x14mr42425299ejf.1.1635846284364;
        Tue, 02 Nov 2021 02:44:44 -0700 (PDT)
Received: from [192.168.178.46] ([213.211.156.121])
        by smtp.gmail.com with ESMTPSA id q23sm8084388ejr.0.2021.11.02.02.44.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Nov 2021 02:44:44 -0700 (PDT)
Message-ID: <5400d9f1-8a1e-ddb0-73ba-f4647b1bc565@tessares.net>
Date: Tue, 2 Nov 2021 10:44:42 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.2
Subject: Re: [PATCH mptcp-next v3 0/2] mptcp: add freebind & transparent
 sockopt
Content-Language: en-GB
To: Florian Westphal <fw@strlen.de>,
 Mat Martineau <mathew.j.martineau@linux.intel.com>
References: <20211029110927.12315-1-fw@strlen.de>
Cc: mptcp@lists.linux.dev
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <20211029110927.12315-1-fw@strlen.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Florian, Mat,

On 29/10/2021 13:09, Florian Westphal wrote:
> First patch adds ipv4/ipv6 TRANSPARENT and FREEBIND, second
> patch adds a selftest to mptcp_connect.sh.
> 
> Only change is in patch 2 which has more verbose SKIP messages
> and an updated mptcp/config to account for IPV6_MULTIPLE_TABLES
> and other toggles required for the tproxy test case.

Thank you for these patches and reviews!

Applied in our tree (features for net-next) with Mat's RvB tags:

- 509d313fffc4: mptcp: sockopt: add SOL_IP freebind & transparent options
- fe37d7b3122b: selftests: mptcp: add tproxy test case
- Results: d271a2e8d559..4538021f6a78

Builds and tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20211102T094419
https://github.com/multipath-tcp/mptcp_net-next/actions/workflows/build-validation.yml?query=branch:export

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
