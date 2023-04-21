Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BFE73C05
	for <mptcp@lists.linux.dev>; Fri, 21 Apr 2023 14:12:54 +0000 (UTC)
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-506bf4cbecbso2483386a12.1
        for <mptcp@lists.linux.dev>; Fri, 21 Apr 2023 07:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1682086373; x=1684678373;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5Q1bko8L41zWo98DORk6teVFcRu41OBVpPJRMTz3Ay8=;
        b=Zltj6XWZ/p+kgx2t9HVAe6iSHosJHTYC8I4dE/2aJP8BttV4MLLLUEjzQtwlXe49z+
         +9xmsjGGB3MBY9qWtXUEQLZ+MFJfMPSwYOzIJAMK3CQmjQSL87gq7eJ+ZkleuDX8ql7P
         HHSB2i4pkhFD4zwRH/m3BeCT4ydJFn8s7A/jpx+nK9NUctf2WU/oWaQtX0rewUk45ykj
         mlqMgmnwiC8WgvhGZwUUtgpTWa+StJbDl4CcVKu/7HS1Tw6kDhQ8UmGVXSeDbpjckESq
         vIZloiZEdsa5wjmJSHZYA0I/owRxA0Uz0gAWD1j7HSTBtjz/RZVwc1rJYTf2YnpeAQ0b
         aK7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682086373; x=1684678373;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5Q1bko8L41zWo98DORk6teVFcRu41OBVpPJRMTz3Ay8=;
        b=ghq3yGr6jyqUL4Gwvh2slw5v28HuEXyq+Q1c/dCEF4RU9nzxtTLe33n4MFRXJycq4f
         tBQsxhWiBlsR37/RjVjpn7GD/e4//nUqfNTVskQH7wbvtOzMA5+Muxm/oHtGXtjOVDQu
         sJ+qhK9gt+QgrX6BXk+tdHSL+iJAwzXe2elghW7P04vKAsVOUHy3sMUHuw6cMuoMgdDs
         yg/HY4tigzhADbHmmjf6DsPsMjJcr0yojBvt+PrWhBHg6TBdAVXV+/hpYsbFfeRxcZPS
         gyeoUYzrwYAdLFDcJUzmMO8DXI8Dkw4xY1OReq9QuyZCY0/KZ/VRzes38drtEGG72mKR
         c85g==
X-Gm-Message-State: AAQBX9dNeXRp8iedjGloAlpsK+TVrsYIUFt5Gi2Msj2vilj6BaAr8HHb
	Mh4FO+bVccwETGKrwOBUlPtEtDmxRaEdy3W4wbsnhg==
X-Google-Smtp-Source: AKy350aT5FdB/B4elsztNqufSQ7gFsNUp7dj0K/I18BoADJAfA1Ex6tzuDYKNexVZKzOukFzCwVpJQ==
X-Received: by 2002:a17:906:2a04:b0:94e:ed5d:c864 with SMTP id j4-20020a1709062a0400b0094eed5dc864mr2652743eje.19.1682086372642;
        Fri, 21 Apr 2023 07:12:52 -0700 (PDT)
Received: from [10.44.2.5] (84-199-106-91.ifiber.telenet-ops.be. [84.199.106.91])
        by smtp.gmail.com with ESMTPSA id lw26-20020a170906bcda00b0094f185d82dcsm2117121ejb.21.2023.04.21.07.12.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Apr 2023 07:12:52 -0700 (PDT)
Message-ID: <5d85de00-08ff-508b-3fd4-4f62cd4eaa47@tessares.net>
Date: Fri, 21 Apr 2023 16:12:52 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: selftests: mptcp: update userspace pm subflow tests: Tests
 Results
Content-Language: en-GB
To: mptcp@lists.linux.dev, Geliang Tang <geliang.tang@suse.com>
References: <177f9ca7d30f810324bf46705ac7d977461ffc2d.1681960259.git.geliang.tang@suse.com>
 <08841cc0-4d7b-417c-f33c-48322842a38f@gmail.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <08841cc0-4d7b-417c-f33c-48322842a38f@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Geliang,

On 20/04/2023 06:13, MPTCP CI wrote:
> Hi Geliang,
> 
> Thank you for your modifications, that's great!
> 
> Our CI did some validations and here is its report:
> 
> - KVM Validation: normal (except selftest_mptcp_join):
>   - Unstable: 1 failed test(s): selftest_userspace_pm 🔴:
>   - Task: https://cirrus-ci.com/task/5458994014191616
>   - Summary: https://api.cirrus-ci.com/v1/artifact/task/5458994014191616/summary/summary.txt
> 
> - KVM Validation: normal (only selftest_mptcp_join):
>   - Success! ✅:
>   - Task: https://cirrus-ci.com/task/6584893921034240
>   - Summary: https://api.cirrus-ci.com/v1/artifact/task/6584893921034240/summary/summary.txt
> 
> - KVM Validation: debug (only selftest_mptcp_join):
>   - Unstable: 1 failed test(s): selftest_mptcp_join 🔴:
>   - Task: https://cirrus-ci.com/task/5881206479257600
>   - Summary: https://api.cirrus-ci.com/v1/artifact/task/5881206479257600/summary/summary.txt
> 
> - KVM Validation: debug (except selftest_mptcp_join):
>   - Unstable: 3 failed test(s): packetdrill_add_addr packetdrill_sockopts selftest_userspace_pm 🔴:
>   - Task: https://cirrus-ci.com/task/4755306572414976
>   - Summary: https://api.cirrus-ci.com/v1/artifact/task/4755306572414976/summary/summary.txt

Thank you for the new version.

It looks like the CI found some issues with this v8.

I also have some comments, see the individual patches.

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
