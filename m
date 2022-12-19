Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 732931398
	for <mptcp@lists.linux.dev>; Mon, 19 Dec 2022 12:44:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1671453888;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7ruA+PcfmikanWTIKp3f295/1TJ8UUx2AC2vigo1JqI=;
	b=jMh+ENud/1L6l9udyiiqvsw8VMcpZbIVR/oqASkdk8Cpw6UM+eS/RTHcxyDuqBnxNRd00u
	nFM3s+Tt5r/Ak8Nm3rqCiqKReXKAZOjjrNJBHQyID9A3S6wp1Gbf9nR9gp7X99U3vv8DHX
	0XJ78zWt/TJan9GCI8ddfrAs/vDbQzc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-152-lGNqTa22PqqyDwJVsCPqOg-1; Mon, 19 Dec 2022 07:44:46 -0500
X-MC-Unique: lGNqTa22PqqyDwJVsCPqOg-1
Received: by mail-wm1-f72.google.com with SMTP id bg25-20020a05600c3c9900b003cf3ed7e27bso5114355wmb.4
        for <mptcp@lists.linux.dev>; Mon, 19 Dec 2022 04:44:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7ruA+PcfmikanWTIKp3f295/1TJ8UUx2AC2vigo1JqI=;
        b=A0MDl4KN/F1bdQfK65nG6v2lh2Vl3VZUr0OHCniSyGRxSmv5kPkK0PySVoBduY7hzl
         bUJwi8cftv8Ch7sBX8JWX+gyYYUvvzU+qDloKm4xPrdLWaqvzPwk4fulutAgDWVQVEpU
         PAkhsderU73VgQM3uwf25POxU7hcATHrUUP2azhMhuz/JgHZ6mLtn1MFp4h+46q136d6
         NmoZ0Rl0mYTPq+SePpL+hH3aUXOxYpKDVFSV/oLWbscWSMJQsqSSuviGPFZRv37M/dE9
         MPmCwvPqRUBieP+U04AZLcsz5uamJ+RB2QrEYbIXBrI5W9CYYYvPnC2X8AE/GKC1XXcK
         Nb0w==
X-Gm-Message-State: AFqh2krzHwOhCkaiVj//BAILiRcK7vX4HmlsBEZ/ywHwxPqb/MF8pAdm
	goTyA/Ls8nhtYVLnXK45YVrdCUXDLbN+3xrKx22S1kq1ny8ugnSHGW3objqQKAeq7d1nkjd/xJC
	kgUnWetC5KecKwpE=
X-Received: by 2002:adf:e550:0:b0:242:1f22:df19 with SMTP id z16-20020adfe550000000b002421f22df19mr2893622wrm.51.1671453885803;
        Mon, 19 Dec 2022 04:44:45 -0800 (PST)
X-Google-Smtp-Source: AMrXdXtfC5ple5cgh91bCHrEP5OIieDfBpqjOAUz+kRNFA7QqUqgGYoLyGUIeD89+qvlDbHGiu+ptA==
X-Received: by 2002:adf:e550:0:b0:242:1f22:df19 with SMTP id z16-20020adfe550000000b002421f22df19mr2893608wrm.51.1671453885515;
        Mon, 19 Dec 2022 04:44:45 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-101-173.dyn.eolo.it. [146.241.101.173])
        by smtp.gmail.com with ESMTPSA id y12-20020adffa4c000000b002258235bda3sm9873495wrr.61.2022.12.19.04.44.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 04:44:44 -0800 (PST)
Message-ID: <eba99592fd3a550d54ffc7b59df5f4680d575bf8.camel@redhat.com>
Subject: Re: [PATCH mptcp-next v10 0/6] mptcp: add statistics for mptcp
 socket in use
From: Paolo Abeni <pabeni@redhat.com>
To: menglong8.dong@gmail.com, mathew.j.martineau@linux.intel.com, 
	matthieu.baerts@tessares.net
Cc: mptcp@lists.linux.dev, Menglong Dong <imagedong@tencent.com>
Date: Mon, 19 Dec 2022 13:44:43 +0100
In-Reply-To: <20221219102316.627491-1-imagedong@tencent.com>
References: <20221219102316.627491-1-imagedong@tencent.com>
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Mon, 2022-12-19 at 18:23 +0800, menglong8.dong@gmail.com wrote:
> From: Menglong Dong <imagedong@tencent.com>
> 
> In the 1th patch, we do some code cleanup with replease 'sock->sk'
> with 'sk'. In the 2th patch, we rename 'sk' to 'ssk' in
> mptcp_token_new_connect(). In the 3th patch, we add statistics for mptcp
> socket in use. In the 4th patch, we init the 'sk_prot' field with
> tcp_prot in build_msk. In the 5th patch, we make mptcp_connect can exit
> when receive 'SIGUSR1' with '-r' flag. And in the 6th patch, we add the
> testing for this commit.
> 
> With the commit e8695e504942("mptcp: don't orphan ssk in mptcp_close()"),
> I belive that the testing of diag.sh can pass now. In fallback and
> simultaneous close case, the msk can't release normal (sometimes?) without
> that commit, and makes the testing fail. Enn...let's just see that the
> CI is saying~
> 
> Changes since v9:
> - rename 'sk' to 'ssk' in the document of mptcp_token_new_connect()
> 
> Changes since v8:
> - fix the panic caused by mptcp token KUNIT tests by init sk->sk_prot in
>   build_msk()
> - check the state of msk instead of ssk for listening socket
> 
> Changes since v7:
> - remove the MPTCP_INUSE flag and do the statistics according to the
>   creation and destruction of the token in the 2th patch.
> 
> Changes since v6:
> - check all processes exit in flush_pids() in the 4th patch
> 
> Changes since v5:
> - introduce MPTCP_INUSE flag to store if msk is in use, as I find
>   that it's not correct to check is a msk is in use by
>   !sk_unhashed(sk) in mptcp_destroy_common(), because the token
>   can be release in mptcp_check_fastclose()
> - add the 3th patch
> - reuse __chk_nr in 4th patch
> 
> Changes since v4:
> - rebase to solve merge conflict
> 
> Changes since v3:
> - rename MPTCP_DESTROIED to MPTCP_DESTROYED in the 2th patch
> 
> Changes since v2:
> - add testing
> 
> Changes since v1:
> - split the code cleanup into the 1th patch.
> - decrease the statistics for listening mptcp socket inuse with
>   mptcp_listen_inuse_dec()
> - add MPTCP_DESTROIED flags to store if mptcp_destroy_common() was
>   called on the msk. For fallback case, we need to decrease the
>   statistics only once, and mptcp_destroy_common() can be called
>   more than once.
> 
> Menglong Dong (6):
>   mptcp: introduce 'sk' to replace 'sock->sk' in mptcp_listen()
>   mptcp: init sk->sk_prot in build_msk()
>   mptcp: rename 'sk' to 'ssk' in mptcp_token_new_connect()
>   mptcp: add statistics for mptcp socket in use
>   selftest: mptcp: exit from copyfd_io_poll() when receive SIGUSR1
>   selftest: mptcp: add test for mptcp socket in use
> 
>  net/mptcp/protocol.c                          | 25 ++++++---
>  net/mptcp/protocol.h                          |  2 +-
>  net/mptcp/token.c                             | 14 +++--
>  net/mptcp/token_test.c                        |  3 +
>  tools/testing/selftests/net/mptcp/diag.sh     | 56 +++++++++++++++++--
>  .../selftests/net/mptcp/mptcp_connect.c       |  4 +-
>  6 files changed, 85 insertions(+), 19 deletions(-)
> 

LGTM, thanks for all the hard work!

Acked-by: Paolo Abeni <pabeni@redhat.com>

