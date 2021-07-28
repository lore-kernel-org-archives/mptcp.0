Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE2C70
	for <mptcp@lists.linux.dev>; Wed, 28 Jul 2021 10:37:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1627468629;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mZeUmYdMxiJfUOMvwHbbms6ecKt1Ltl2EyB6M6mW08I=;
	b=SZPL40jfzTitAAT1wzhaKUfoMr7NT3GrYb43wW1EcFxPHWJ9jAspY9kGLcey2i04FxI7lX
	tHB5OK4yvMpZDZHtXEEKKxvkbfBzo2rCTpvnrF7Q7xulF8o+eTTABxLL3y1XmnU1fEEyvm
	EtxRjOmCFii0OOr6Akx0AcPzBmWGEA0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-414-lsodPx1KM86PvKkZPxnVeg-1; Wed, 28 Jul 2021 06:37:06 -0400
X-MC-Unique: lsodPx1KM86PvKkZPxnVeg-1
Received: by mail-wr1-f70.google.com with SMTP id d13-20020adfc3cd0000b02901531b0b7c89so766152wrg.23
        for <mptcp@lists.linux.dev>; Wed, 28 Jul 2021 03:37:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=mZeUmYdMxiJfUOMvwHbbms6ecKt1Ltl2EyB6M6mW08I=;
        b=KN702DrGCV9i4pfdgJ8ZvmFjbbfus9Oi/fwA0PynPow1D0gOdGodXZ99t674fXnvXf
         HnXt1K01dzAdlw8lICVX3wNfpjQlfpmX+5nlVW8YsOP3/FbZ6Jovud5PpWYM4qCoDxWP
         MRxetA7rGKUVV8HdlgVo5W3vWl9pXy9RT4pUlSJUNPfh6kuXBBF2LBYhuzAnaq02/7jX
         3rH97Pq4z7bz6jcbAk02CPOljCj9AsyD3W6o4Ba3D5v0rK1xmU+vAujM97MeaLfIF2/r
         9Z9fTStekmmm9WFcuSfe0ZAsb57srzJyluA+fiUqflf333GtlQlDKoVpWQATk+yMQt34
         7JBA==
X-Gm-Message-State: AOAM5334qyccls3lpEmPrjzauqlfBKsUD/A7V0K3I8p7ieBiBODHoRd0
	3heX318mozpuIexKb7cpMNHUY9B67mvdsSPPmY8ECTe3CckBmu1eJwBOBQpXR/zgDwb+Ti/qKs4
	+LIl+9Zaw/+m12hM=
X-Received: by 2002:a7b:c8d2:: with SMTP id f18mr26493864wml.135.1627468624918;
        Wed, 28 Jul 2021 03:37:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz4oEyEjyZNCRUWdk5GRjZcye+49+Q5U12U2hIlsQSxOH9sK0F0Y3Je40voIDFJ9Np2wRNoug==
X-Received: by 2002:a7b:c8d2:: with SMTP id f18mr26493849wml.135.1627468624763;
        Wed, 28 Jul 2021 03:37:04 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-97-57.dyn.eolo.it. [146.241.97.57])
        by smtp.gmail.com with ESMTPSA id o6sm6602093wry.91.2021.07.28.03.37.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jul 2021 03:37:04 -0700 (PDT)
Message-ID: <6bbc9297bfbb9e4f6b8f9c49a1919094718ebe75.camel@redhat.com>
Subject: Re: [MPTCP][PATCH v6 mptcp-next 0/5] MP_FAIL support
From: Paolo Abeni <pabeni@redhat.com>
To: Geliang Tang <geliangtang@gmail.com>, mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@xiaomi.com>
Date: Wed, 28 Jul 2021 12:37:03 +0200
In-Reply-To: <cover.1627464017.git.geliangtang@xiaomi.com>
References: <cover.1627464017.git.geliangtang@xiaomi.com>
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

On Wed, 2021-07-28 at 17:35 +0800, Geliang Tang wrote:
> From: Geliang Tang <geliangtang@xiaomi.com>
> 
> v6: only rebased patch 1
>  - move the struct member 'fail_seq' behind 'ext_copy'.
>  - define OPTION_MPTCP_FAIL to BIT(12), BIT(11) is used by DSS
>  - move the MP_FAIL writing code at the beginning of mptcp_write_options,
>    and add the 'unlikely' tag.
>  - tag: export/20210728T080904
> 
> v5:
>  - patch 1, change "ret = true;" to "return true;"
>  - patch 3, in the single-subflow case, send MP_FAIL and receive the
>    echo, then temporarily handled by reset.
> 
> v4:
>  - just deal with the multiple subflows case, put the single subflow
>    case into the new 'infinite mapping' part.
> 
> v3:
>  - respond with MP_FAIL
>  - add single subflow check
>  - add infinite mapping sending and receiving
>  - export/20210626T054902
> 
> v2:
>  - MP_FAIL logic:
>    * Peer B send a DSS to peer A, and the data has been modify by the
>   middleboxes, then peer A detects the bad checksum.
>    * In the multiple subflows case, peer A sends MP_FAIL+RST back to peer B,
>   and peer A discards the data following the bad data sequence number. Peer
>   B receives this MP_FAIL+RST, and close this subflow.
>    * In the single subflow case, using the simple implementation, peer A
>   sends MP_FAIL back to peer B, and peer A fallback to a regular TCP. Peer
>   B receives this MP_FAIL, and fallback to a regular TCP.
> 
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/52
> 
> Geliang Tang (5):
>   mptcp: MP_FAIL suboption sending
>   mptcp: MP_FAIL suboption receiving
>   mptcp: send out MP_FAIL when data checksum fails
>   mptcp: add the mibs for MP_FAIL
>   selftests: mptcp: add MP_FAIL mibs check
> 
>  include/net/mptcp.h                           |  5 +-
>  net/mptcp/mib.c                               |  2 +
>  net/mptcp/mib.h                               |  2 +
>  net/mptcp/options.c                           | 78 ++++++++++++++++++-
>  net/mptcp/pm.c                                | 20 +++++
>  net/mptcp/protocol.h                          | 20 +++++
>  net/mptcp/subflow.c                           | 18 +++++
>  .../testing/selftests/net/mptcp/mptcp_join.sh | 38 +++++++++
>  8 files changed, 178 insertions(+), 5 deletions(-)

I had a couple of minor comments, but they could be addressed with
squash-to or even completely unrelated changes.

Overall LGTM, thanks!

/P

