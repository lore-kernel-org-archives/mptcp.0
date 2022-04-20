Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86671185B
	for <mptcp@lists.linux.dev>; Wed, 20 Apr 2022 15:22:37 +0000 (UTC)
Received: by mail-ej1-f44.google.com with SMTP id y10so4232043ejw.8
        for <mptcp@lists.linux.dev>; Wed, 20 Apr 2022 08:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=z/jeE3P7Oyk1yzKf6HMEQQxlF687t13EgpRZo3PiWqw=;
        b=R/LhLXPvugZvweaJvYcZjvn/3FXiv/zkrWtHMnTLWn1vfbK5FeTm7YzRACVR8hIGZ4
         iY5KmYkW1UkFXKtbFyjlmmlR/TNFkSgiRZs4VcoLsfEkw0bffhfifdMeSvC+faW9I19+
         UfwWGE+LLTVFxZ1QMZNosQ32u11cf525t07OVTPBQsn9rLmlge0RyAJXfE8uLEwOmg+B
         Xx8LZAMNUnxo9Zm2Jy0XikeX0uDqPofzhkXrl8UQivSRdXvRv2IR7hnkqL7TnwyEB9Gz
         UbYTeukP9BGjavb/blAeeRYkOugOy61flVyrA7u7l5n0wgQHlPvWOrA3ZY0LM8W7O+Mw
         r0kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=z/jeE3P7Oyk1yzKf6HMEQQxlF687t13EgpRZo3PiWqw=;
        b=CkVAl4htIzOvjIRf2O6SiIk1WhefJzACUTMpys3C0EtVcJQVRrLSFQt3RhlderRuYB
         RRR6CfnV9olhKg1+X9En3l3O6aKRZGTWBAN21+FFvEoAZbBYqpdv0rnKVtTTO410cK1Q
         wh20lFLy0oK2kQWei0hGYJ3101O4m7ChFbfLChEdN2oWauVk86j3cjPNqPxvSno6whGl
         urJV142lUIGSglEKm0T+qdduKF43+rNwKV2vB8Oexo3oHVgJu7wOHOLewP9C6L4wvhLe
         9NRcVxJ1389U90gD/pXo8I5EpybJYLZKJyn/wiz3Yc+a7NLHqvlUCUAQ8o0Koa8cVQfH
         YUBQ==
X-Gm-Message-State: AOAM531u9LMiLXvEv6xAZVKvdXUJNpZM4EMqS9rejxXJGXIOPEVn125W
	cBy1y+6vpVS/y+8LKxOSBCEz0ZdvnPH9fQ==
X-Google-Smtp-Source: ABdhPJxfdI3jjOyKJnWKI1m1Abr9vapk7TjZrerxO5fFVN/2ov6WRd3kt5aWdNFjfNI9Boo9nnNb0g==
X-Received: by 2002:a17:906:dc93:b0:6e8:8d81:b4bb with SMTP id cs19-20020a170906dc9300b006e88d81b4bbmr18998506ejc.32.1650468155443;
        Wed, 20 Apr 2022 08:22:35 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:a8ef:af16:f14e:5d01? ([2a02:578:8593:1200:a8ef:af16:f14e:5d01])
        by smtp.gmail.com with ESMTPSA id g23-20020aa7dd97000000b00423f7c97dffsm3074223edv.17.2022.04.20.08.22.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Apr 2022 08:22:34 -0700 (PDT)
Message-ID: <058fc99a-5c5a-aebd-83bf-c0043d19f1aa@tessares.net>
Date: Wed, 20 Apr 2022 17:22:34 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH mptcp-next v2 0/3] mptcp: fix bug in userspace PM APIs
Content-Language: en-GB
To: Kishen Maloor <kishen.maloor@intel.com>, mptcp@lists.linux.dev
References: <20220420042524.2268380-1-kishen.maloor@intel.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <20220420042524.2268380-1-kishen.maloor@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Kishen, Geliang, Mat,

On 20/04/2022 06:25, Kishen Maloor wrote:
> This series fixes issue #267: 
> https://github.com/multipath-tcp/mptcp_net-next/issues/267
> 
> Specifically, calls to mptcp_token_get_sock() from userspace PM APIs 
> hold a reference to the msk which needs to be freed before leaving
> those functions. This was causing a memory leak which was caught in 
> the CI debug build.

Thank you for the patches and the reviews!

Please next time add more details in the different commit messages,
mainly the reason and ideally a "Closes:" tag.


Now in our tree:

New patches for t/upstream:
- b5427dca0016: "squashed" patch 1/3 in "mptcp: netlink: Add
MPTCP_PM_CMD_ANNOUNCE"
- 93a0837b24aa: "squashed" patch 2/3 in "mptcp: netlink: Add
MPTCP_PM_CMD_REMOVE"
- 1cfb03d21837: "squashed" patch 3/3 in "mptcp: netlink: allow
userspace-driven subflow establishment"
- Results: 8001d7b9c400..1e2cdcf7b0cc (export)


Builds and tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20220420T152103

https://github.com/multipath-tcp/mptcp_net-next/actions/workflows/build-validation.yml?query=branch:export


Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
