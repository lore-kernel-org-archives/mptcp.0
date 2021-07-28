Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D6E72
	for <mptcp@lists.linux.dev>; Wed, 28 Jul 2021 17:22:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1627492941;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v98DPaDmt7MKl2voGn09OYHU7/IV8cx+w+4CXaT+aNo=;
	b=MpnQWutPuFTRCdM6N1L9JNZzFn/bobTcrO4NWiPrg9/sQbDiUi359OzStkDTmkMWZghcJi
	/Ds51i8MHraiqsI9JgPln1we7eho62x9oI3DNZEbaQ7vb1dtr1r1XxyayIenbgpqHW+8aw
	8pemyXHAZI1nGZlaVj0BPhWio+qQjxs=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-278-0dKwNgAbP8Cm-dDIk1TMqA-1; Wed, 28 Jul 2021 13:22:19 -0400
X-MC-Unique: 0dKwNgAbP8Cm-dDIk1TMqA-1
Received: by mail-wr1-f72.google.com with SMTP id o8-20020a5d4a880000b029013a10564614so1189676wrq.15
        for <mptcp@lists.linux.dev>; Wed, 28 Jul 2021 10:22:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=v98DPaDmt7MKl2voGn09OYHU7/IV8cx+w+4CXaT+aNo=;
        b=qcorhb6EDsdUKc4iJvk4fXLte9ugpUVjxpIUp14K00l1yPhrLUA9TcA3/6NSkmZzqI
         z+0vNzwIv0M0gifXFe9lPTF4naFG5utRUMbEEHbW97jItV03ZPuMojkoPxUG0zr8ffEJ
         EPMOMonjdGAZ3XW98bXZ2ctMltk6IT3BsNu+g3Qxusi8MKWoU0NAn3se7OhSBWJhYUXn
         JUTcnIRtfdFdNMaOZa+ik3xsgZefVCzSF0ZTmf5P8XbLonqirfjjkhG3Tk7z6EBlcchY
         Asmkdvh+ghN1P/zb7OTS2ouYnVSgRtrU9DXQiJMcB0kRcnXwdjXqYD2xonIbgDRl3brF
         xqxQ==
X-Gm-Message-State: AOAM533rwhBLXauxCn/Pv3xtLvDkG62u6WjoOKBZ5a5iMcDSwegMv2+M
	8hjnFQiBggowITH9QxuARdPI/bo1RMOqAAKRthHlruhAOkTj3cYJ2/qkVP2MrFTAD9a7L6UIyAy
	h/ai8MYdrbbobHEQ=
X-Received: by 2002:adf:90c6:: with SMTP id i64mr495913wri.168.1627492938253;
        Wed, 28 Jul 2021 10:22:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzPjERJ2/RCK/U88YsV0Xffheeq+ZNdQHtukH5ssFpW0DpuKS2X71DA8WF0DmtJdyfUlOTORQ==
X-Received: by 2002:adf:90c6:: with SMTP id i64mr495898wri.168.1627492938095;
        Wed, 28 Jul 2021 10:22:18 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-97-57.dyn.eolo.it. [146.241.97.57])
        by smtp.gmail.com with ESMTPSA id z3sm6594334wmf.6.2021.07.28.10.22.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jul 2021 10:22:17 -0700 (PDT)
Message-ID: <d66469c66238be5c89ab498dc1b9469f2abb478b.camel@redhat.com>
Subject: Re: [MPTCP][PATCH v6 mptcp-next 0/5] fullmesh path manager support
From: Paolo Abeni <pabeni@redhat.com>
To: Geliang Tang <geliangtang@gmail.com>, mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@xiaomi.com>
Date: Wed, 28 Jul 2021 19:22:16 +0200
In-Reply-To: <cover.1627391588.git.geliangtang@xiaomi.com>
References: <cover.1627391588.git.geliangtang@xiaomi.com>
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

On Tue, 2021-07-27 at 21:24 +0800, Geliang Tang wrote:
> From: Geliang Tang <geliangtang@xiaomi.com>
> 
> v6:
>  - drop lookup_subflow_by_addrs()
>  - pass three arrays instead of 'entries' in fill_local_adresses_vec()
>  - drop the 'remote' argument of fill_local_addresses_vec
>  - drop the 'local' argument of fill_remote_addresses_vec
>  - fix the pm.subflows.
>  - add limit testcase.
> 
> v5:
>  - patch 1, add a new helper lookup_address_in_vec.
>  - patch 2, update pm.subflows in the non-fullmesh case.
>  - patch 4, add more tests.
>  - tag: export/20210727T054640
> 
> v4:
>  - add new helpers, fill_local/remote_addresses_vec
>  - add max_subflows checks
>  - add 'local' into the local addresses array only when no fullmesh
>    entry found.
>  - add signal,fullmesh check
> 
> v3:
>  - the in-kernel fullmesh path manager has been dropped from this
>    patchset, only keep the fullmesh flag support code.
> 
> v2:
>  - Implement the fullmesh mode as an extension to the netlink PM, not a
>    standalone PM as Paolo suggested.
>  - drop duplicate code.
>  - add a new per endpoint flag MPTCP_PM_ADDR_FLAG_FULLMESH.
> 
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/193
> 
> Geliang Tang (5):
>   mptcp: remote addresses fullmesh
>   mptcp: local addresses fullmesh
>   selftests: mptcp: set and print the fullmesh flag
>   selftests: mptcp: add fullmesh testcases
>   selftests: mptcp: delete uncontinuous removing ids
> 
>  include/uapi/linux/mptcp.h                    |   1 +
>  net/mptcp/pm_netlink.c                        | 145 ++++++++++++++++--
>  .../testing/selftests/net/mptcp/mptcp_join.sh |  67 +++++++-
>  tools/testing/selftests/net/mptcp/pm_nl_ctl.c |  16 +-
>  4 files changed, 206 insertions(+), 23 deletions(-)

LGTM, I added some minor comment on patch 4/5, but could be addressed
later/with squash-to patches.

Acked-by: Paolo Abeni <pabeni@redhat.com>

