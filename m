Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 713273D67
	for <mptcp@lists.linux.dev>; Wed, 19 Apr 2023 13:14:24 +0000 (UTC)
Received: by mail-wm1-f50.google.com with SMTP id v20-20020a05600c471400b003ed8826253aso2247580wmo.0
        for <mptcp@lists.linux.dev>; Wed, 19 Apr 2023 06:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1681910062; x=1684502062;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eEB7hwgofsQ6bG4qUybaaw8G/YzhGzNFO7vWDk7hoyk=;
        b=T4ZT/2IptPiREG8zODGfHOAoWwMOZGR5Hjm3urBEzVUPzJVTiHA4RdY/xdwuclgeeg
         NaA2KYUKYq6Hqi1pBbIa9RfELrsuqGiRn+Wr/8MDRlCKbFmyFnLj3ELGn5AZFHdba7Px
         1n1gO8iXJINfwAS9qTTWk35zJvQqqEFzoKB1/1/OO4vEJfnKLFhyLZby+OT0sHAwE563
         jfx1am3r38UV9p6OfWe7srac1QiYwHPsigezt0HV7wPHbd0XqBmuoruHF+uZ5ka95ta0
         Th66Qt8PMElckMxe0K2LYp0CnouXJ9SaQgoF2Wfsgep4CaBfpKMJWtY4yggw7RJgEqrN
         K2HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681910062; x=1684502062;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eEB7hwgofsQ6bG4qUybaaw8G/YzhGzNFO7vWDk7hoyk=;
        b=gQ8qeoKdSSC9HEPPY9MeVU/kHnJQO+YXH5uyloZcIHJGzYZ2+pj41UKHaNv/TUkj0W
         pkgZRJb/5r64hh2Mk2gWzUhqwNtd45AEhPDw4Txq/X51HSgQFLsudnY/XIPGquLOj/VP
         lR318TsW9EatyRFeWza52n5c3gdnei78bNW3GrLiJwAZ0qJYUeG3O2Z0POuYAOn58I07
         FBYo9jfaWEHVXP14qFNP9Qke8z686FoZnLcav99ANFRHIMYmUJy0pE5nliDBuTY3NYA3
         XKCXC5eS3Ij9xWH+d92OgQKidkzlmLsJqqUpnBTURWfB+VBrb3xNMNsrO8ilae889hdE
         bM8w==
X-Gm-Message-State: AAQBX9cCvelNylbOy6VfnYiwf5QRDNUEDISJZkEPg0w589tc3vd3ZJpm
	TMYfE5VlLIFYn1SR/isFvztzTp6ljLdnmL/goj6RZoqz
X-Google-Smtp-Source: AKy350aI2okPMhCxnABe9efzGuDjkUAbk5uGH4/XK7Lduj2YOWub4pr8Gu5fiFATBnGkb+uVE/lfcQ==
X-Received: by 2002:a1c:7207:0:b0:3f1:72ec:4024 with SMTP id n7-20020a1c7207000000b003f172ec4024mr9340203wmc.21.1681910062103;
        Wed, 19 Apr 2023 06:14:22 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:8149:2bc3:2ef3:6de? ([2a02:578:8593:1200:8149:2bc3:2ef3:6de])
        by smtp.gmail.com with ESMTPSA id u3-20020a7bc043000000b003f16f362ae7sm2190478wmc.21.2023.04.19.06.14.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Apr 2023 06:14:21 -0700 (PDT)
Message-ID: <56ccac20-f901-255c-c1b6-29557ebb52c3@tessares.net>
Date: Wed, 19 Apr 2023 15:14:21 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH mptcp-next] Squash to "security, lsm: Introduce
 security_mptcp_add_subflow()"
Content-Language: en-GB
To: mptcp@lists.linux.dev
Cc: Paolo Abeni <pabeni@redhat.com>
References: <20230419101714.3347358-1-matthieu.baerts@tessares.net>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <20230419101714.3347358-1-matthieu.baerts@tessares.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hello,

On 19/04/2023 12:17, Matthieu Baerts wrote:
> lsm: move the MPTCP hook comments to security/security.c
> 
> This is similar to what has been done in lsm/next, e.g. with
> commit 4a49f592e931 ("lsm: move the SCTP hook comments to security/security.c"),
> see the link below.
> 
> By doing that, the patch can be applied without conflicts in lsm/next
> branch.

I hope that's OK if I apply it to be able to send the patches to LSM
maintainers today. I only moved the comments.

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
