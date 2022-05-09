Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91BA37B
	for <mptcp@lists.linux.dev>; Mon,  9 May 2022 09:00:52 +0000 (UTC)
Received: by mail-wm1-f45.google.com with SMTP id i20-20020a05600c355400b0039456976dcaso5718359wmq.1
        for <mptcp@lists.linux.dev>; Mon, 09 May 2022 02:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=cJUtWrNcJevpr3SPVYzI2c58KXCUrUKYBk0PTaZE/04=;
        b=IUv2bwsBlcU8ig0fVoZgPoDNNE/ZWF3i7dHyS3L9q9+uRpBKduBfGRuquL8suTvGsn
         wZipe0cjilfWE2Qttn/7kIG3DzmpP1jhsN3WZ0NXaf8s7VwUyZ8FrRozNVQU6cNdiYWW
         FmHl9FmfC372G3NrYSNRAn/mxIjhUFVIdk3yGoVKF4pPDxPytIXIU1p6BPoX9tYuccBk
         JI7shVGr0z93ujl0gO9YnCNkdn+kf87IWsFuH2+LbMDtNDkZEXe8BZi1VSQ0JaJB5x3X
         jz78eF2baZzdPzHNe3fnQubY0HPT8oG4RkPC+56jzouuWd6gQdbnmAyo+cSNHU+fiYXp
         J8LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=cJUtWrNcJevpr3SPVYzI2c58KXCUrUKYBk0PTaZE/04=;
        b=mcwpsKsFppOEeW3j1lEdBSuq/8jr6tODmr0KrTyxjRpi/Nrlsuex3co2AdfaCQndnl
         lMcUEqfDWUjQSaOarw8kGvpPMsR0xzohb1CY3U1cdRzBsEqlGMWWmJU4rDlLfyPviBS5
         OSifU/d1iDecyeuX9sb6j6+rVMzRMRFCxpB2U8QqXHM49oK2361JY1Pe4XRzL0zgaQg9
         Xp4KvKM+fRNygGTsAhljMdTguS0SgALw5Z34XaJKDqSfK2Z4jboLZxSNq9vjH1o9xfz0
         WWylvKqxtkIVGQhXvkJYTSsJnPdJJ5rpeXBR3M2TaLHk7JlMgYHgWU1GgW/AFgD4vJ+l
         sabw==
X-Gm-Message-State: AOAM532G1dt1D7Un89CBTnf4Yqw3xySzZd32ce9mfTXxnGluI1s8n3nh
	JfTaHr0UQCwFjYw/vGj8S5tLjw==
X-Google-Smtp-Source: ABdhPJyYG03hLpuI/X2biEtwUkDYqKdlHxNjjNqonRg80Zz2wpTjzHYyPlxgSr6VCZjUJrcayiwtgw==
X-Received: by 2002:a05:600c:1d9d:b0:394:7d22:9bdd with SMTP id p29-20020a05600c1d9d00b003947d229bddmr13473079wms.111.1652086850495;
        Mon, 09 May 2022 02:00:50 -0700 (PDT)
Received: from [10.44.2.26] (84-199-106-91.ifiber.telenet-ops.be. [84.199.106.91])
        by smtp.gmail.com with ESMTPSA id h9-20020a5d4309000000b0020c5253d8f0sm10801990wrq.60.2022.05.09.02.00.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 May 2022 02:00:50 -0700 (PDT)
Message-ID: <8afe6b33-49c1-5060-87ed-80ef21096bbb@tessares.net>
Date: Mon, 9 May 2022 11:00:49 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH bpf-next v3 5/8] selftests: bpf: test
 bpf_skc_to_mptcp_sock
Content-Language: en-GB
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
 Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
 Geliang Tang <geliang.tang@suse.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 mptcp@lists.linux.dev
References: <20220502211235.142250-1-mathew.j.martineau@linux.intel.com>
 <20220502211235.142250-6-mathew.j.martineau@linux.intel.com>
 <CAEf4BzY-t=ZtmU+6yeSo5DD6+C==NUN=twAKq=OQyVb2rS2ENw@mail.gmail.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <CAEf4BzY-t=ZtmU+6yeSo5DD6+C==NUN=twAKq=OQyVb2rS2ENw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Andrii,

Thank you for the review!

On 07/05/2022 00:26, Andrii Nakryiko wrote:
> On Mon, May 2, 2022 at 2:12 PM Mat Martineau
> <mathew.j.martineau@linux.intel.com> wrote:

(...)

>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 359afc617b92..d48d3cb6abbc 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -13780,6 +13780,7 @@ F:      include/net/mptcp.h
>>  F:     include/trace/events/mptcp.h
>>  F:     include/uapi/linux/mptcp.h
>>  F:     net/mptcp/
>> +F:     tools/testing/selftests/bpf/bpf_mptcp_helpers.h
>>  F:     tools/testing/selftests/bpf/*/*mptcp*.c
>>  F:     tools/testing/selftests/net/mptcp/
>>
>> diff --git a/tools/testing/selftests/bpf/bpf_mptcp_helpers.h b/tools/testing/selftests/bpf/bpf_mptcp_helpers.h
>> new file mode 100644
>> index 000000000000..18da4cc65e89
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/bpf_mptcp_helpers.h
>> @@ -0,0 +1,14 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/* Copyright (c) 2022, SUSE. */
>> +
>> +#ifndef __BPF_MPTCP_HELPERS_H
>> +#define __BPF_MPTCP_HELPERS_H
>> +
>> +#include "bpf_tcp_helpers.h"
>> +
>> +struct mptcp_sock {
>> +       struct inet_connection_sock     sk;
>> +
>> +} __attribute__((preserve_access_index));
> 
> why can't all this live in bpf_tcp_helpers.h? why do we need extra header?

The main reason is related to the maintenance: to have MPTCP ML being
cc'd for all patches modifying this file.

Do you prefer if all these specific MPTCP structures and macros and
mixed with TCP ones?

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
