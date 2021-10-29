Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E6DA2C82
	for <mptcp@lists.linux.dev>; Fri, 29 Oct 2021 08:17:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1635495446;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vgjaRuXQ9IILjdOLIUK2zO6/9GHUacgH8k66L4GQXRs=;
	b=T53xvOwW9JartmULVDm+V19JmrYNjKWvNs11TEMxgSiLftiMKc9uq5oc2dTL+QR4O6D0pz
	5p7Uu2ni/C8CekUul3T5+1wQwllRrggi9zx+Qhvug1Usx4oZNO4pBcdGbTGemmE4fWvZ13
	egmsNG9HSDeSIfe+sH7NeIOww5lQ3K8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-346-U47t8gmhMyGhXFhjDyVxBA-1; Fri, 29 Oct 2021 04:17:16 -0400
X-MC-Unique: U47t8gmhMyGhXFhjDyVxBA-1
Received: by mail-wr1-f70.google.com with SMTP id m16-20020a5d56d0000000b0017a4ba94972so722328wrw.0
        for <mptcp@lists.linux.dev>; Fri, 29 Oct 2021 01:17:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=vgjaRuXQ9IILjdOLIUK2zO6/9GHUacgH8k66L4GQXRs=;
        b=ZuhUgMPfduGrczzRRKSnOVzsu49NtYbt940lyRJMg8bS37sOfX5CTI8tqjYZQFkVKp
         5iJhpCPhUJ9l3fTxkZQAZnbNM0uo3oLlW2aZO2FeAJOapHA84L5RYmvm3vZeieinYVN1
         p6RoswPHMAWhPjONgm7i0rUnXtPLjNnEDQrzUvQaYpmcncP1GyDOfMERuJpxU1Aejhmi
         g1rzGriYKKe9BD7kOfoAYuKVr9dcdPxSPeZi9BB0Rd4RPzhMXb/7jzFJJFk5vD88gT+O
         ALn6QKB6ofSD2VS1tMlNXNCbgb7vJWeJf327RGkF0A0nvi6oWVqdwk4TtiVNXntetBBP
         Qxhw==
X-Gm-Message-State: AOAM532uUWEiZFYciu37xGxIb+kV4oNwlkt0sQHCV9GicVW2AdfGTk/M
	yqPw+aCzEtHWPt+vj8Xno55JYQ6NQnybPFRsJOFcgD5TZuA7UskENXqKnjOhBLPuARR+vi6CLhn
	pdEwo5CB2HWOJkIE=
X-Received: by 2002:a5d:4f85:: with SMTP id d5mr12775404wru.247.1635495435041;
        Fri, 29 Oct 2021 01:17:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwbpEOBOhZXEUHg4kueU8ipC2MPH12cnv+DhQXgESh85r/IXHB0v4SrFBRb2e2asH/DUsnkVQ==
X-Received: by 2002:a5d:4f85:: with SMTP id d5mr12775382wru.247.1635495434850;
        Fri, 29 Oct 2021 01:17:14 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-240-86.dyn.eolo.it. [146.241.240.86])
        by smtp.gmail.com with ESMTPSA id p18sm4792991wmq.4.2021.10.29.01.17.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Oct 2021 01:17:14 -0700 (PDT)
Message-ID: <8c3e2143bcd123e81d4a7d339ee2e7c6b46ba92d.camel@redhat.com>
Subject: Re: [PATCH mptcp-next v8 0/8] The infinite mapping support
From: Paolo Abeni <pabeni@redhat.com>
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
Date: Fri, 29 Oct 2021 10:17:13 +0200
In-Reply-To: <cover.1635481641.git.geliang.tang@suse.com>
References: <cover.1635481641.git.geliang.tang@suse.com>
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Fri, 2021-10-29 at 12:40 +0800, Geliang Tang wrote:
> v8:
>  - Patches 1-6 are unchanged, only updated the selftests scripts.
>  - The patch (Squash to "mptcp: infinite mapping receiving" for v7) is
> dropped too. Since this series only implemented MP_FAIL in one direction.
> The TODO items, "MP_FAIL echo" and "MP_FAIL retrans", will implement later
> as new patches.
> 
> v7:
>  - drop the patch "mptcp: add last_ack_dss_start in the msk" in v6
>  - set allow_infinite_fallback to false in __mptcp_subflow_connect and
>    mptcp_finish_join.
> 
> v6:
>  - use allow_infinite_fallback instead of last_retrans_seq.
>  - rename mptcp_is_data_contiguous to mptcp_allow_infinite_fallback.
>  - rename last_fully_acked_dss_start_seq to last_ack_dss_start.
> 
> v5:
>  - move last_retrans_seq from msk to mptcp_subflow_context
> 
> v4:
>  - update patch 1 and patch 2
> 
> v3:
>  - drop MPTCP_INFINITE_DONE flag
>  - drop MAPPING_INFINITE
>  - add mptcp_is_data_contiguous helper
>  - add the fallback check
>  - The u32 target testcase has not been completed yet.
> 
> v2:
>  - add MPTCP_INFINITE_DONE flag
>  - add MAPPING_INFINITE mapping status
>  - add start_seq in the msk
> 
> v1:
>  - add noncontiguous flag
>  - add the mibs check
>  - tag: export/20210904T080009
> 
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/216
> 
> Geliang Tang (8):
>   mptcp: don't send RST for single subflow
>   mptcp: add the fallback check
>   mptcp: track and update contiguous data status
>   mptcp: infinite mapping sending
>   mptcp: infinite mapping receiving
>   mptcp: add mib for infinite map sending
>   selftests: mptcp: add infinite map mibs check
>   selftests: mptcp: add mp_fail testcases
> 
>  include/net/mptcp.h                           |   3 +-
>  net/mptcp/mib.c                               |   1 +
>  net/mptcp/mib.h                               |   1 +
>  net/mptcp/options.c                           |   2 +-
>  net/mptcp/pm.c                                |   6 +
>  net/mptcp/protocol.c                          |  22 ++++
>  net/mptcp/protocol.h                          |  13 ++
>  net/mptcp/subflow.c                           |  56 +++++----
>  tools/testing/selftests/net/mptcp/config      |   5 +
>  .../testing/selftests/net/mptcp/mptcp_join.sh | 111 ++++++++++++++++--
>  10 files changed, 186 insertions(+), 34 deletions(-)

I haven't reviewed the patch yet, but I have to say: nice new email
address :)

/P

