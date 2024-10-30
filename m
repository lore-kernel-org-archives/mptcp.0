Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 346B61E32C6
	for <mptcp@lists.linux.dev>; Wed, 30 Oct 2024 11:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730286786; cv=none; b=E3kEk4bzJgypuNxgET8oKsuWB9VjhX8BUq1rtLChep/dYh7xcLJjZ8f3RBjtmnbNleUO9tl71KLPzuoJmmhGhOmavT2IMvy48XUmMoy/pcNuFQ1V2vEMh4U/7BCOd0JDpLgDkqrXZNZ7EDVAz1ml6P7T6TmT5J2UssHhwSu+GDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730286786; c=relaxed/simple;
	bh=fCeONLvHegGSfcw9Ky8jaNUZK0p1bHTKuZ3C1akz+tk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I/arPV6H/cI7X/iZ4MKW42WP3onFgDT9HDunhtwvIRYf7RQmBsvT5rddm3Ouv+eXTCLSbxIJcyRQvlyR6NH8g37NZcnUZdU+jPudMjZswf4v5S3us5elppLMMevxT649Dj84ZRNDO8+ia0aZs9cHbQzRrrV34O0hRT+vSTv5OKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Crrbz56L; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Crrbz56L"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-71ea2643545so5313474b3a.3
        for <mptcp@lists.linux.dev>; Wed, 30 Oct 2024 04:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730286783; x=1730891583; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ymRlvy1aQPoMurranzuEhc83ceu3SVzS1IDAUzBuNJY=;
        b=Crrbz56Lq07DxBp/GbZQzaqB047wxpTpGYTBdWF5eIHb07ZR6QSwy/tW4Ff9D+7sHg
         +Q38feVoZKDu9S2Of3LskKGZLnNhh8pifkEJrPGdLPqzVaC21AAe8M1RlJf9uU5yQ3oS
         ZlpETDLEWpY+eWhMAUmAkRq4W6R/q1UGAjCg06cqknx6ZqZVqqnMh9GoyNAvOTv+UiAQ
         /uUNq97ph5reJHGTmAf+ZkMaOmHZQDZO7PA/fiQMKG+ALQdUmYNYnZjQNz/5JfxEOQTI
         AXjQF3mF0IH8s8quhalIVsbdG9MO+Mq/zmdoKoqmySz5KPU8EmOur6BaKjfx38iPQfSr
         7Xlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730286783; x=1730891583;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ymRlvy1aQPoMurranzuEhc83ceu3SVzS1IDAUzBuNJY=;
        b=L0TCzTg7Q8/+zjOiB4aMNm4412IjjkYWS2CJaLVk2W28JAnKau2NBRRqs4gNwpr5O1
         pWH5Y3yx+0KunDUSLg00nwoHqVS2B+YEGzcfNh8IGtYT0qdrFMX6RhGrjw5Rc3Peqnut
         D8XIJnOshbTFkMMmPCS/o7NwdrQfz1LBqydiGbivB8i4+oec+ZnXVTcPcVA3/qlCp5fh
         E29r5fuW7SCzRLmQjpX41Q4GPUZqgs9XO96wkMlbwzTZMj9+LQRtFvVxq3LWda9SPLHR
         4PL4qYEu0tlY4BjTcqs2VfJIKLjODPXyIhOJ9wzjRXf/XYsVWmlJazuKHEL38OK81RcL
         mwYA==
X-Forwarded-Encrypted: i=1; AJvYcCWc9NxS2FejGt/TO4ybZfES6DwqRJT1RNhiku1Foi9kDApqKmieGkKh8bxTNw6RADUG6bsOUw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz6XtcXgqIyfSnmEp6QbVW+zuv+qpZq/IjTrbvBTnLkLWKMWjPv
	2nZtkeQjqWTGN5zk44gcgjrqvEEdY/tiAMmLglpW8ltYtyo/cTyq
X-Google-Smtp-Source: AGHT+IFu590Lq0TECetYlxh+A+zx5xw+jixfRaS4gaHnOxwLCVbOJeI7mB2J/qtdx99nB4yMsMjyYA==
X-Received: by 2002:a05:6a00:992:b0:717:8ee0:4ea1 with SMTP id d2e1a72fcca58-72062ae79f3mr23973439b3a.0.1730286783297;
        Wed, 30 Oct 2024 04:13:03 -0700 (PDT)
Received: from [172.23.160.204] ([183.134.211.52])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72057a0b961sm8987011b3a.121.2024.10.30.04.12.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Oct 2024 04:13:02 -0700 (PDT)
Message-ID: <3bc02b33-421e-4c95-8f69-33ec89782621@gmail.com>
Date: Wed, 30 Oct 2024 19:12:54 +0800
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next] selftests/bpf: Fix compile error when MPTCP not
 support
To: Matthieu Baerts <matttbe@kernel.org>, Mat Martineau
 <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@linux.dev>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, mptcp@lists.linux.dev
References: <20241030100108.2443371-1-chen.dylane@gmail.com>
 <abb72d1b-3347-4493-9a18-43c1655b7449@kernel.org>
From: Tao Chen <chen.dylane@gmail.com>
In-Reply-To: <abb72d1b-3347-4493-9a18-43c1655b7449@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

在 2024/10/30 18:49, Matthieu Baerts 写道:
> Hi Tao Chen,
> 
> Thank you for having shared this patch.
> 
> On 30/10/2024 11:01, Tao Chen wrote:
>> Fix compile error when MPTCP feature not support, though eBPF core check
>> already done which seems invalid in this situation, the error info like:
>> progs/mptcp_sock.c:49:40: error: no member named 'is_mptcp' in 'struct
>> tcp_sock'
>>     49 |         is_mptcp = bpf_core_field_exists(tsk->is_mptcp) ?
>>
>> The filed created in new definitions with eBPF core feature to solve
>> this build problem, and test case result still ok in MPTCP kernel.
>>
>> 176/1   mptcp/base:OK
>> 176/2   mptcp/mptcpify:OK
>> 176     mptcp:OK
>> Summary: 1/2 PASSED, 0 SKIPPED, 0 FAILED
>>
>> Fixes: 8039d353217c ("selftests/bpf: Add MPTCP test base")
> 
> The commit you mentioned here is more than 2 years old, and as far as I
> can see, nobody else reported this compilation issue. I guess that's
> because people used tools/testing/selftests/bpf/config file as expected
> to populate the kernel config, and I suppose you didn't, right?
>

Hi Matt, thank you for your reply, as you said, i did not use 
tools/testing/selftests/bpf/config to compile kernel, i will use this 
helpful
feature.

> I don't think other BPF selftests check for missing kernel config if
> they are specified in the 'config' file, but even if it is the case, I
> think it would be better to skip all the MPTCP tests, and not try to
> have them checking something that doesn't exist: no need to validate
> these tests if the expected kernel config has not been enabled.
> 

If i use the kernel not support MPTCP, the compile error still exists, 
and i can not build the bpf test successfully. Maybe skill the test case 
seems better when kernel not support. Now that bpf_core_field_exists 
check already used in the code, i think it is better to use new 
definition mode.

> But again, please correct me if I'm wrong, but I don't think there is
> anything to change here to fix your compilation issue: simply make sure
> to use this tools/testing/selftests/bpf/config file to generate your
> kernel config, no?
> 
> Cheers,
> Matt


-- 
Best Regards
Dylane Chen
