Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71FD83FC4
	for <mptcp@lists.linux.dev>; Tue, 31 Aug 2021 10:40:48 +0000 (UTC)
Received: by mail-ed1-f49.google.com with SMTP id u19so9380247edb.3
        for <mptcp@lists.linux.dev>; Tue, 31 Aug 2021 03:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=to:cc:references:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=kf9KPgUZQbleRrMTurUL1PBHpCgS4dzA0+jlWjwyvlc=;
        b=sgFVgx40NZR2zoigGnRGiMhplXYkX42O1ZqpTvif7m25LLFK0r2NSxgFxx7bmImEnX
         U1CRO0d+WFT2Xnhxpz6H7JScW6WoP2uWk4N3VvDz6fMd3+57O91vH+u3EkBVbUfNxVic
         U+8YH7MxPG4JjXWuVWQuzUuqoOAtwg1rueQ+Evh/sz/i7QhI0GVWkIcLeWzIMgaFDJvL
         uilcuhSWsFJ/SXIJ1zICbMSGVjlJFkC/MRlT8aciOM03/i/3hAoVu37E+w6NgwpC7bIa
         V/LrXDmjLQ6HkOXAakOEgX8RQUuklhi7dtdufo80h1JStVzyalbj6XjnPFbvHbMICEgD
         iQag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kf9KPgUZQbleRrMTurUL1PBHpCgS4dzA0+jlWjwyvlc=;
        b=s+C/VzdZYqyesnSR/4fUQR77h8nssTha6bH4/gAcv7hAvwvgfTlgP75MTzzamVea9f
         hzUPzxa/uTfOb8vsVIKUUIN5m2S27MY5nwXOtksvWWFBZ7HJKarDknrKrmA6NZv9wnG9
         wlvbtFC4i+XwtMhZ/UVcU7Y5k7cY1i99VwT5W0MqxHnMOku8XUneyGX124NhwCANZ+Vv
         K0WgU8Bpbbygqbo9Or8LLuDjzDQNXOJN69CPRbICvwID3kyJIogekfTHCVvnEUgduXBq
         Vc3jHbP5wBYd0/KW3yT4Rh6ZotKCQNrHV4PjjOmiP2FHE++1KiFlvgFrY1dvgm64Lq1a
         e+ug==
X-Gm-Message-State: AOAM533Kfa96dYcdKOlRmaAmW6oNAuRycx86dWiM90V24Jp3ZPjlgLgi
	HTh2XDYCJwporzc1rhWCwCSiR0RiFvuqVRqn
X-Google-Smtp-Source: ABdhPJzGCUBTgG+daMsO+oLn6hd4Z2PIJ6PdlslmenldjFZwqk4vWJ8xcz+o0qd+FtPbTOxnPku44A==
X-Received: by 2002:a05:6402:1d95:: with SMTP id dk21mr27784973edb.347.1630406446422;
        Tue, 31 Aug 2021 03:40:46 -0700 (PDT)
Received: from tsr-lap-08.nix.tessares.net (94.105.103.227.dyn.edpnet.net. [94.105.103.227])
        by smtp.gmail.com with ESMTPSA id x15sm7863602ejc.59.2021.08.31.03.40.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Aug 2021 03:40:46 -0700 (PDT)
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: mptcp@lists.linux.dev
References: <20210830103357.3114290-1-matthieu.baerts@tessares.net>
 <ca22e2bc-ac5a-aa6a-b247-32359611a3@linux.intel.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: Re: [PATCH mptcp-next 0/2] MPTCP_INFO: Fix compilation errors
Message-ID: <e6e7b0e8-0b00-a98f-e379-551d645c9f07@tessares.net>
Date: Tue, 31 Aug 2021 12:40:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <ca22e2bc-ac5a-aa6a-b247-32359611a3@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit

Hi Mat,

On 30/08/2021 20:40, Mat Martineau wrote:
> On Mon, 30 Aug 2021, Matthieu Baerts wrote:
> 
>> Geliang and Intel's 0-DAY CI Kernel Test Service reported compilation
>> errors.
>> Those are fixed in patch 1/2.
>>
>> Patch 2/2 contains one modification needed after patch 1/2 but also 2
>> others.
>>
> 
> These look ok to squash, one detail:

Thank you for the review!

>> Matthieu Baerts (2):
>>  Squash to "mptcp: add MPTCP_INFO getsockopt"
> 
> The struct_subflow_addrs hunk of this one applies to "mptcp: add
> MPTCP_SUBFLOW_ADDRS getsockopt support", but I figure you can straighten
> that out when applying (no need to repost).

Indeed, you are right. I only looked at when "#include <linux/in.h>" has
been added in "include/uapi/linux/mptcp.h". In fact, it should have been
in "mptcp: add MPTCP_SUBFLOW_ADDRS getsockopt support" as well so I move
it there too (Acked by Florian on IRC)!

- c90cd3fa4458: "squashed" patch 1/2 in "mptcp: add MPTCP_SUBFLOW_ADDRS
getsockopt support"
- b8a1da1b7b53: "Signed-off-by" + "Co-developed-by"
- 5a66b30f2d91: tg: move code to
t/mptcp-add-MPTCP_SUBFLOW_ADDRS-getsockopt-support
- 0b300e055aae: conflict in
t/mptcp-add-MPTCP_SUBFLOW_ADDRS-getsockopt-support
- 89aa952809f3: "squashed" patch 2/2 in "selftests: mptcp: add mptcp
getsockopt test cases"
- ca40a3192b58: "Signed-off-by" + "Co-developed-by"
- Results: 1a8852042a9f..7f1dc9bc8b7b

Builds and tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20210831T103928
https://github.com/multipath-tcp/mptcp_net-next/actions/workflows/build-validation.yml?query=branch:export/20210831T103928

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
