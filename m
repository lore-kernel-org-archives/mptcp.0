Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2131513AC7
	for <mptcp@lists.linux.dev>; Fri, 11 Aug 2023 20:59:52 +0000 (UTC)
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-3fe5c0e57d2so20847515e9.0
        for <mptcp@lists.linux.dev>; Fri, 11 Aug 2023 13:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1691787591; x=1692392391;
        h=content-transfer-encoding:in-reply-to:cc:autocrypt:from:references
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=N3zlMwhRRDjT2iqVeJamAg40m2giTKoR+RteyaplCxQ=;
        b=gv7ZcbdRXjbb1hUsRUWuZ8nxx5Fjybu04MvVQYeMMWJtep6TTGJL9RpNTktEPkFmEN
         /O2FzQcW/WJQD45tyajTJuSHscjIULBtEX13lrtt0HYGiUbwVCgPH9F6cFhD5xhbV+j7
         L98mVxKn6a9tSGu5rpSbsJW+RXFjs08Q59TQxrdSM+gep8pcBYgKJIM7eQW7sC7ZJr/N
         4vZ0oY4VUNFtffev9qHGI1iqnLh9D1EFimq5VJwGa/dnsZDoULl22b9Dr840kU2ik2DT
         +ZVCJJpySAeXQGJ4OxwOHaQ0Za/yv/IMo+sGDLEdouDE/aIp8eBmF5F5ZWNr3XF2L4aH
         /egA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691787591; x=1692392391;
        h=content-transfer-encoding:in-reply-to:cc:autocrypt:from:references
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N3zlMwhRRDjT2iqVeJamAg40m2giTKoR+RteyaplCxQ=;
        b=cBC8cMzfUq1AAWP4/AVZjCMX8lK4Vn+qWonq7DEpCi74tOW+6dTKaDt6wBQm/iJbjw
         n3MmYH/TCt30R87ui4K/1cnznEmfZGG+XgshY+jLBPhgZ8vcmRp3KbVn+I/LlCy2TQF3
         zJsRQxLt1hwljVTK9q2/Wp16E9X1OLdB+CEbw3fMWGQfncrxjokqcjPfjoKmNzv8Rk4i
         ECi1r/CSyBrOftFAFxFG2i3psA1Jt4u0lseQ2s2KaPtLC4KrwRdRhGe1SuoXNQqdEnhR
         pHiSii/e3lxl7a3C0vu3I93UILhVzBmsd4efA2Cb7HRWlZzo+ykJl17BzDJeICbj7A6y
         vUGQ==
X-Gm-Message-State: AOJu0YyBBJ8GxIsTmFRN+LHRmqAYpqbK1RRuMGUtE4t+c/kwYmZi/Y0U
	n7968o6VHZgclDcaINFih+xLkA==
X-Google-Smtp-Source: AGHT+IGn9s3wy5op+2tCW8xwKK8G/RQ87G+w11X+deZpKSXvfvAAVluDuLmZfFc8yQDQTa4zzO7T8w==
X-Received: by 2002:a7b:c392:0:b0:3fe:16f4:d865 with SMTP id s18-20020a7bc392000000b003fe16f4d865mr2364398wmj.23.1691787590319;
        Fri, 11 Aug 2023 13:59:50 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:d07c:50b8:518e:aa8e? ([2a02:578:8593:1200:d07c:50b8:518e:aa8e])
        by smtp.gmail.com with ESMTPSA id w12-20020a05600c474c00b003fe15ac0934sm6882082wmo.1.2023.08.11.13.59.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Aug 2023 13:59:50 -0700 (PDT)
Message-ID: <dd871eac-d1ee-4874-9466-3986d7534f31@tessares.net>
Date: Fri, 11 Aug 2023 22:59:48 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-next v3 0/6] BPF packet scheduler updates part 3
Content-Language: en-GB
To: Geliang Tang <geliang.tang@suse.com>, Mat Martineau <martineau@kernel.org>
References: <cover.1691036765.git.geliang.tang@suse.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Autocrypt: addr=matthieu.baerts@tessares.net; keydata=
 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
Cc: mptcp@lists.linux.dev
In-Reply-To: <cover.1691036765.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang, Mat,

On 03/08/2023 06:27, Geliang Tang wrote:
> Geliang Tang (6):
>   Squash to "mptcp: add sched_data helpers"
>   Squash to "bpf: Add bpf_mptcp_sched_kfunc_set"
>   Squash to "selftests/bpf: add two mptcp netns helpers"
>   Squash to "selftests/bpf: Add bpf_rr scheduler"
>   Squash to "bpf: Export more bpf_burst related functions"
>   Squash to "selftests/bpf: Add bpf_burst scheduler"

Thank you for the patches and the reviews!

Now in our tree:

New patches for t/upstream:
- a88f3f498b2f: "squashed" patch 1/6 (with conflicts) in "mptcp: add
sched_data helpers"
- 5d8795774463: "squashed" patch 2/6 in "bpf: Add bpf_mptcp_sched_kfunc_set"
- be959ff059e4: "squashed" patch 3/6 in "selftests/bpf: add two mptcp
netns helpers"
- 1736fcc031f4: "squashed" patch 4/6 in "selftests/bpf: Add bpf_rr
scheduler"
- 574847a8b558: "squashed" patch 5/6 in "bpf: Export more bpf_burst
related functions"
- 206993ff5b4f: "squashed" patch 6/6 in "selftests/bpf: Add bpf_burst
scheduler"
- Results: 2d42b08369ef..03fd7c30320a (export)

Tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20230811T205838

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
