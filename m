Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B454F173
	for <mptcp@lists.linux.dev>; Thu, 16 Dec 2021 17:02:10 +0000 (UTC)
Received: by mail-ed1-f42.google.com with SMTP id b7so30095329edd.6
        for <mptcp@lists.linux.dev>; Thu, 16 Dec 2021 09:02:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:cc:from:in-reply-to:content-transfer-encoding;
        bh=HBBpY5OqMWJz8m59W5Rua8xK6E470BsLIaYojcvxc70=;
        b=kGZu//sZ20hUwinojCjnYGrtcoUQhmKlG8P2xQbVG5UR8tJpSMGiLjofQKVMLTlXRa
         vakIiCZPhwuMDpd8kNb23VYQG9siG/VgEmrZKZrvrBBENsJ5P4We2eSC6PBg//S1RYwk
         iwoTgBLxwCpKqWqvNzGyRLeAq7WIaVmeTpRFlq7IgQEnczFNPsp/dovpV8A2bPPBvZjl
         xxMa8E9+/kJZm6Q5ARVsHbuMD5oP+7MuPynrxpGJ48Q78spv+euexniJhU+wXzOfq7K2
         LdoLIDc2tx9i08wfGWQDF0ogqMmQP8bpDMa9eY5eREXG4U0aHHqpyyhohG2bVfoBiFSK
         mrYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:cc:from:in-reply-to
         :content-transfer-encoding;
        bh=HBBpY5OqMWJz8m59W5Rua8xK6E470BsLIaYojcvxc70=;
        b=23Ll6JBseGRQlNf6Ou/rUb0JnWRDQ0/PyD+iZiEicHI0Ob96g0DB6omtHfDTP8ZFuW
         uxG06QqDKatTrGaHbex/ICMDclHagH+aUJM8+K5mzBguSdqwRjAxJjunsS4FXNtQlCk8
         CSuMbeY8uYSVzdKypF6LNNQd57jqftbPkQh68zYMWu4oNdJlMLaLWBr2e83PcCN4m0gY
         3SzgtQM+HKLbxGdG2cEjl/TIpvrQ18XVGWOMV09qPDNLoy3p+1oFXzyXMdLOkAGZlCrM
         /hR2qWBb76sayukkrbiBuEXTC5lIwQfsMcvkeDqLaAenH2LALf5r8JYg4v2FgVSCBOvZ
         PxsA==
X-Gm-Message-State: AOAM533j0FKONK+k9sXlcXVN7Mj6FhlL2w4xzibl8SzXiw8uZckJuG4+
	x/Q3CVnQD+HHorf7b1e8+WnIfg==
X-Google-Smtp-Source: ABdhPJwwz71X8mGzB7hBKjVBG95HXczPzqUhVNIXuTMEWQpzkfLYRlhDfOxqwAsrZTWTaGJ6qu8z/A==
X-Received: by 2002:a17:907:3f8a:: with SMTP id hr10mr16812845ejc.527.1639674125431;
        Thu, 16 Dec 2021 09:02:05 -0800 (PST)
Received: from [10.44.2.26] ([81.246.10.41])
        by smtp.gmail.com with ESMTPSA id hy13sm1982015ejc.142.2021.12.16.09.02.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Dec 2021 09:02:05 -0800 (PST)
Message-ID: <a117066d-143e-847f-fcd5-0a4fd9806c06@tessares.net>
Date: Thu, 16 Dec 2021 18:02:04 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v3 mptcp-next] selftests: mptcp: more stable join
 tests-cases.
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>,
 Mat Martineau <mathew.j.martineau@linux.intel.com>
References: <dfbdb183399851cfa695fa4c965a8d146d436e52.1639567831.git.pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <dfbdb183399851cfa695fa4c965a8d146d436e52.1639567831.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo, Mat,

On 15/12/2021 12:36, Paolo Abeni wrote:
> MPTCP join self-tests are a bit fragile as they reply on
> delays instead of events to catch-up with the expected
> sockets states.
> 
> Replace the delay with state checking where possible and
> reduce the number of sleeps in the most complex scenarios.
> 
> This will both reduce the tests run-time and will improve
> stability.

Thank you for the patch and the review!

Now in our tree with Mat's RvB tag:

- e5056a064c6f: selftests: mptcp: more stable join tests-cases
- Results: f83839879847..aa92c1bdf999

Builds and tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20211216T170147
https://github.com/multipath-tcp/mptcp_net-next/actions/workflows/build-validation.yml?query=branch:export

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
