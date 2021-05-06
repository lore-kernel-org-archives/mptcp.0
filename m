Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [216.205.24.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEFED72
	for <mptcp@lists.linux.dev>; Thu,  6 May 2021 13:09:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1620306586;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/WPnGZmFH1/8wiIh1v4eyfnhjUqm2B45g4Pzj4M3ePk=;
	b=IScR8BzSjBuxCr9/w2GNwFhb/vIopPwyVRkMQvgGj8hZQpbvwScxljot3Wd2bS957twh+x
	1ofOhaRL8PhDUFY8nSpiqMwZbjcEUVlblc6y30bNYUSWKKsl7ubziITxSp2zTF/C1O4K+q
	HgGDgVpc2hAnZEmxKCwnaqTI64rzwC4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-447-Wk0Nx0-qOPOPyO6ilY4SiQ-1; Thu, 06 May 2021 09:09:45 -0400
X-MC-Unique: Wk0Nx0-qOPOPyO6ilY4SiQ-1
Received: by mail-wr1-f70.google.com with SMTP id l2-20020adf9f020000b029010d6bb7f1cbso2179342wrf.7
        for <mptcp@lists.linux.dev>; Thu, 06 May 2021 06:09:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=/WPnGZmFH1/8wiIh1v4eyfnhjUqm2B45g4Pzj4M3ePk=;
        b=NtSUJtwwtiONx72wRX+Yd44YFCm+rT7L9UMjNRNcV5IpV6A+fbfRrg3HOV8vdDG5ao
         CfpAd5J54ZFb7pzwSvRlZHAzJA5R2RbIDOg7Ztpk67DWyyVGuSVkWGA2f/DK1bKjIt44
         KyyTx9aZb2FQN6uGpsAC6YQOeJssTW/FBpd2h6K087bP0M42K0kNSkeblytLFCJ0JKjK
         ONjsnnoRcZHPdgzkeho9ZvDq4IU+Ox4xaWzRZi5o8RNZsHohqQDlxnyhjSF+2rCh33Ds
         NKKXrt9l19zi9/YaYxskl9pOXx852Z9WsQsphoQEVNmP3LrC+MvExZBUzlfrV75NHqlZ
         Xrqw==
X-Gm-Message-State: AOAM532UvqpJ/RM96YKmhun8AYgzxX7Ss2CFbbc/Jn8sMhypl7+qmVaL
	2xs2PY5mhBKunIVcKZGQu0Q5a3x0IA2SHGoHcwMZv9J4jdeFefmls8HNp1sjE2YlWmwRJjz8Vpq
	mak8rNs3JtKrKAzM=
X-Received: by 2002:adf:ef92:: with SMTP id d18mr5143450wro.413.1620306583889;
        Thu, 06 May 2021 06:09:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzDvSgSU0Dcf0wCgn0FWWN/MFqtnkJRApsNtODFMp4sEvRQvsyDNzoh+qk4NZfAhyjajJQxkA==
X-Received: by 2002:adf:ef92:: with SMTP id d18mr5143424wro.413.1620306583700;
        Thu, 06 May 2021 06:09:43 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-108-140.dyn.eolo.it. [146.241.108.140])
        by smtp.gmail.com with ESMTPSA id r7sm3036301wmq.18.2021.05.06.06.09.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 May 2021 06:09:43 -0700 (PDT)
Message-ID: <d98c77f57836940c9af061478afffc214209a89e.camel@redhat.com>
Subject: Re: [MPTCP][PATCH v2 mptcp-next 0/5] data checksum support cleanups
From: Paolo Abeni <pabeni@redhat.com>
To: Geliang Tang <geliangtang@gmail.com>, mptcp@lists.linux.dev
Date: Thu, 06 May 2021 15:09:42 +0200
In-Reply-To: <cover.1620286893.git.geliangtang@gmail.com>
References: <cover.1620286893.git.geliangtang@gmail.com>
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32)
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

On Thu, 2021-05-06 at 15:48 +0800, Geliang Tang wrote:
> v2:
>  - add two new squash-to patches to rename the mib DSSCSUMERR to
>    DATACSUMERR.
> 
> Please insert patch 4 (mptcp: dump csum fields in mptcp_dump_mpext) between the
> commits "mptcp: add a new sysctl checksum_enabled" and "selftests: mptcp: 
> enable checksum in mptcp_connect.sh".
> 
> Geliang Tang (5):
>   Squash to "mptcp: add csum_reqd in mptcp_out_options"
>   Squash to "mptcp: add the mib for data checksum"
>   Squash to "mptcp: add a new sysctl checksum_enabled"
>   mptcp: dump csum fields in mptcp_dump_mpext
>   Squash to "selftests: mptcp: enable checksum in mptcp_join.sh"
> 
>  Documentation/networking/mptcp-sysctl.rst       |  2 +-
>  include/net/mptcp.h                             |  4 ++--
>  include/trace/events/mptcp.h                    | 17 +++++++++++------
>  net/mptcp/ctrl.c                                |  8 +++++---
>  net/mptcp/mib.c                                 |  2 +-
>  net/mptcp/mib.h                                 |  2 +-
>  net/mptcp/subflow.c                             |  2 +-
>  tools/testing/selftests/net/mptcp/mptcp_join.sh |  4 ++--
>  8 files changed, 24 insertions(+), 17 deletions(-)
> 

I had a very minor comment on patch 4/5, but I think this can be merged
as is and ev. squash an additional change later, if needed/there is
agreement.

Cheers,

Paolo

