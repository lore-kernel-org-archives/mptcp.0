Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86BC02F2D
	for <mptcp@lists.linux.dev>; Wed, 12 Apr 2023 08:39:58 +0000 (UTC)
Received: by mail-wr1-f53.google.com with SMTP id v6so10043406wrv.8
        for <mptcp@lists.linux.dev>; Wed, 12 Apr 2023 01:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1681288796;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Xhkfk5J4IfcXKmt8zSXtCoxVNQe8zIUHLsVLrRyvySg=;
        b=1Ys5QlbtiUoSOD1PoXQ0EeyOLnX3IK6+816vCs2XEkexR5ifiD4lHBztS7cPRNqBQ3
         e6aZCAhNwCpo1cZgAaUE4xyvasOh0fLB2+72d6v4rbrU5RYv2bSJ9necwy+UhEt02exT
         3/43BVXjQi2SFdkzMI5KLpDYGcVVoVCOmetUOzJjtBEF4713SoKllnu1rPsxVneVj74m
         6GJixG/7PU+Ng1FFaBPdRbqzP7LeNyN3alO3tKP3c0iO4gfr07sjaM9ATr/EDrdtsZBg
         GfP+dmb2J1UfUMQBMGmoDjjP/8D2tWC3MrPXKl91WzcqHpNGIHDgAF1ulRPD6ycSkhx4
         1W3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681288796;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Xhkfk5J4IfcXKmt8zSXtCoxVNQe8zIUHLsVLrRyvySg=;
        b=eieIxZJSdzBZhsvQCj3dUMqsFVDxTYOno1VfJh4xGrcEL7pF7RbsTIvw8J2Acnop68
         E3b43dUIrRi05TBm4zT/QvX+/rs5S7mlxv+SW9xUOkdaLqoBKuywB/cG4T1rf9TN/C9s
         s0nnMDJQSBOVtuxk9RqVyHYNsODVCeS9JdMFK8Sl0fhvj7d2yL1hiFqzSWPG7npSab/r
         rt7iYCLaGDYEoL2tetPzxEP5PhUDTykstE3qL5U0woVkwG8npUvSnHJxKFRi5YE+sIi2
         fZ6UQ70tsKJTgYUyBVffMju4ZJZ2fW5W1jjaI7wpok+dXfM+o9uTj9I8FJ6Lm4uAq3B4
         XQxQ==
X-Gm-Message-State: AAQBX9dhkMKxan9Mf88uOl1Md1IfZf4ZVV/4rg+5M+aXqZVYPQm0Qa0y
	XVb0Yt4lByv/WzEjLmUjbaCyrg==
X-Google-Smtp-Source: AKy350aYb3QLJwMpqdo6BYGdbBakz+8CsysRnr70wPOAAoYOkVeI6pB+U5sBCR3S+kv5lyd///qQsQ==
X-Received: by 2002:a5d:5148:0:b0:2ee:687c:5252 with SMTP id u8-20020a5d5148000000b002ee687c5252mr1370514wrt.24.1681288796253;
        Wed, 12 Apr 2023 01:39:56 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:d700:c3ed:8099:5bf4? ([2a02:578:8593:1200:d700:c3ed:8099:5bf4])
        by smtp.gmail.com with ESMTPSA id j5-20020adff005000000b002daf0b52598sm8003918wro.18.2023.04.12.01.39.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Apr 2023 01:39:56 -0700 (PDT)
Message-ID: <36afdb25-f0c7-5c47-eb19-ea0cf2c9d43b@tessares.net>
Date: Wed, 12 Apr 2023 10:39:54 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH mptcp-net] Squash-to: "mptcp: fix accept vs worker race"
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
Cc: Christoph Paasch <cpaasch@apple.com>
References: <484c6fbff67a4587215d88e17f3a6688eb2c9ea1.1681256534.git.pabeni@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <484c6fbff67a4587215d88e17f3a6688eb2c9ea1.1681256534.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo,

On 12/04/2023 01:43, Paolo Abeni wrote:
> The current patch has at least 2 issues:
> - the first subflow context cleanup can race with
>   the path manager: we should acquire the full ssk socket.
> - such subflow can accept data while the msk is closed, leading
>   to fwd memory corruption.
> 
> Address the issues moving the ssk cleanup into plain mptcp_close_ssk
> and detaching the ssk from the msk before closing the latter: no
> input data can land to the msk at that point.

Thank you for this fix! (hopefully for your health, the last one linked
to this patch :) )

I added a small patch just to revert a small modification from "mptcp:
fix accept vs worker race" around the "ssk" variable that is no longer
needed.

New patches for t/upstream-net and t/upstream:
- eb7dd7b98e94: "squashed" in "mptcp: fix accept vs worker race"
- 3c88203fb8ed: mptcp: reduce scope of ssk: "squashed" there too
- Results: fae53252db9c..bfe6de18752b (export-net)
- Results: 5fddaf33c674..7abc2bc2d1a8 (export)

Tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export-net/20230412T083701
https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20230412T083701

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
