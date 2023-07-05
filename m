Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ADCB46B6
	for <mptcp@lists.linux.dev>; Wed,  5 Jul 2023 09:11:27 +0000 (UTC)
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-4f95bf5c493so9761807e87.3
        for <mptcp@lists.linux.dev>; Wed, 05 Jul 2023 02:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1688548286; x=1691140286;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nfUemcQnaLF0hp016J63e9C5guP2BqKRmZq266rF4jM=;
        b=x3hBpfM7bQTJDhO2TYnX6jYbvEQsYEtO1STHZ3IQD2EFhCAc+WvyB+J4pTUYDBp5WU
         Jz1lyDEy14g6felxG41xPOjMZbGaYixN61f8xVryRdP1cMLJQDvINrC/oDOfT6mKHbH/
         LqXJD2M02J+AfPba2KWvpc7tgoVoA1H+Y2qQBu8O/1m8U7vD1Y2l1NgNjpDqOy5irJs8
         1Lygt8UVu3d+029fcVsojBo7f1es5/yV3bLwJtwRkU/g4LM5iv+in2IDFQ55RxvQT3UO
         ooRgRkcSpBXkAgmEVsEBe2wVjFRVMd9Xotz3nCstp8Cm0SZcSA1QSlFeJVzCwCE5V0S7
         cqqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688548286; x=1691140286;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nfUemcQnaLF0hp016J63e9C5guP2BqKRmZq266rF4jM=;
        b=Y0JGsF30spAveLb3p20iS9X6FTurqb1aek7jrM37czgITIoH5/DX/M7c7VRrh5+j2z
         WbKBzZpjzXqc/toaffv8a3/MN+dYfuEPRyt6oO8LpGEkesA3+nFMG9QXU3Y1umtkuKA1
         qJnWX1tko11xGE7whU+j7pEw6r8hWul7AMIiZ90urQgNKovFDVz1DgNKVlhvl79l+qmY
         hHtFYeu4UPldyTFIscXETrFG/FQBWzhM78sgveyfovS3OSZS2uFzpHsEN8ZDDc536sWr
         49xE3NB9C/dE++1eOj02dD5N7HFfPvqSxjLQy/Q1A6ysm5ofqFWgVbNuDe4oJ4yokj+S
         D3JA==
X-Gm-Message-State: ABy/qLaKzlSgvyYlq70/CotLOdFYRjyXn4YVgzblbfefag0odQMZ+Lrf
	Sqm/WIrwbXRbY7s7UibZBW+sCA==
X-Google-Smtp-Source: APBJJlEB1ddhFhGQ8HQecIlWQh4ULH0fHM8rh8qay+0Hh9vrb9A7/s72Gh6PNUPFj0J9v4ixGgU9GQ==
X-Received: by 2002:a2e:9649:0:b0:2b6:d2c5:4d54 with SMTP id z9-20020a2e9649000000b002b6d2c54d54mr9696939ljh.18.1688548285665;
        Wed, 05 Jul 2023 02:11:25 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:e210:4cad:4e78:3692? ([2a02:578:8593:1200:e210:4cad:4e78:3692])
        by smtp.gmail.com with ESMTPSA id mh4-20020a170906eb8400b0098951bb4dc3sm2984455ejb.184.2023.07.05.02.11.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jul 2023 02:11:25 -0700 (PDT)
Message-ID: <0e153aab-5f76-c75e-677d-8a59ca4bc331@tessares.net>
Date: Wed, 5 Jul 2023 11:11:24 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH mptcp-next v11 00/11] BPF packet scheduler updates part 1
Content-Language: en-GB
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
References: <cover.1687827857.git.geliang.tang@suse.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <cover.1687827857.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang, Paolo,

On 27/06/2023 03:06, Geliang Tang wrote:
> v11:
>  - use sk_storage instead of mptcp_storage.
>  - drop mptcp_storage.

Thank you for the patches and the reviews!
> https://patchwork.kernel.org/project/mptcp/cover/cover.1665753926.git.geliang.tang@suse.com/ [1]
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/342
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/349

Does this first part still close these two tickets?

Now in our tree (feat. for other trees) + one extra patch and a squash
of a squash. Please don't hesitate to check if everything has been done
properly because there were quite a few manipulations to do :)

- 8efabdbcaa2c: "squashed" patch 1/11 (with conflicts) in "mptcp: drop
last_snd and MPTCP_RESET_SCHEDULER"
- b0f6d5c5ae25: "squashed" patch 1/11 (with conflicts) in "mptcp: use
get_send wrapper"
- 9de04aa46c59: "squashed" patch 1/11 in "mptcp: use get_retrans wrapper"
- Results: e77e1cb5a372..3fcf166a9c7e (export)

- 6e930aa67c6e: "squashed" patch 2/11 in "mptcp: add struct mptcp_sched_ops"
- Results: 3fcf166a9c7e..437c8b684629 (export)

- f7e28c2443da: "squashed" patch 3/11 (with conflicts) in "mptcp: add
sched_data_set_contexts helper"
- 9dc7c0042a01: conflict in t/mptcp-add-scheduler-wrappers
- Results: 437c8b684629..504bc1f2d42d (export)

- Applied patch 4/11 with Paolo's ACK just before "bpf: Add
bpf_mptcp_sched_ops"
- 7f44744d88c6: mptcp: register default scheduler
- Results: 504bc1f2d42d..d45b69d4109b (export)

- 0c323c5cc341: "squashed" patch 5/11 in "bpf: Add bpf_mptcp_sched_ops"
- Results: d45b69d4109b..1b64ad359430 (export)

- 9ffacd26fad5: "squashed" patch 6/11 in "bpf: Add
bpf_mptcp_sched_kfunc_set"
- Results: 1b64ad359430..f95ddf57fd7e (export)

- 8f050b24bd4d: "squashed" patch 7/11 in "selftests/bpf: Add mptcp sched
structs"
- Results: f95ddf57fd7e..b1bfdcd53258 (export)

- a3eacd00bfb7: "squashed" patch 8/11 in "selftests/bpf: Add bpf_first
scheduler"
- Results: b1bfdcd53258..b80981f0543b (export)

- bc7512c33473: "squashed" patch 9/11 in "selftests/bpf: Add bpf_bkup
scheduler"
- Results: b80981f0543b..e1dbf174936b (export)

- 506feec3a419: "squashed" patch 10/11 in "selftests/bpf: Add bpf_rr
scheduler"
- Results: e1dbf174936b..c6edb7e5168c (export)

- 151a85fd02ab: "squashed" patch 11/11 in "selftests/bpf: Add bpf_red
scheduler"
- Results: c6edb7e5168c..679a4538b06c (export)

- 064c5746a0d9: "squashed" patch 12/11 (squash squash) in
"selftests/bpf: Add bpf_rr scheduler"
- Results: 679a4538b06c..255b06daaf0d (export)

- cebedb75ff65: "squashed" patch 6/7 from BPF 'force to MPTCP' v4 series
in "selftests/bpf: add two mptcp netns helpers"
- Results: 255b06daaf0d..cde4fa6a0a5e (export)


Tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20230705T090903

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
