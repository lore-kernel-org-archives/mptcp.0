Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37B20286D77
	for <mptcp@lists.linux.dev>; Thu, 11 Sep 2025 08:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757578617; cv=none; b=ZcKIQc10lImED10G0aF+0QbxpNajArYc/BqNQZHRnweM8fVgEyKGhAVT3QlgauACySTetfp4QA4kKJMLQxZXyKKBK7fFoOfXYS4Y7Q+4Yd8+j/RDZi59ieAgbOjt7VRteYP68V8Fp5W1tAoRXfloR6FwkxRDzvPQZI6+VIl2fnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757578617; c=relaxed/simple;
	bh=Q/rgmdNpj4KcPv5B7zcRcKejmCPmLdfBeggPGRQ3DSU=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RY7m4c2bK0fY5YjH/lBsA8zlmALeXLe8lCvO+kgkoOwic/tkkviXZKYglprFCcTxtod7Enf7/GsmtfMyynQXsp/pVKJERkrN548E4GBSD8gkW4DI73KatOIHN2HXgQV2Xoy2gWzNdbMpEpl0Ga3DBbTQI+KX2Q+GdjvmLc/pzK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EhJ/RBr+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EhJ/RBr+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 292D7C4CEF5;
	Thu, 11 Sep 2025 08:16:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757578616;
	bh=Q/rgmdNpj4KcPv5B7zcRcKejmCPmLdfBeggPGRQ3DSU=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=EhJ/RBr+CcVS5cCaRS7Wp6iawX65aA7L123mGHTcInAhGAnTULWuBOXfayWfhveNO
	 uFUatMTYpR9C4IW5yX9OTVkWCH2DlNCcmjLXb2zJk+s1rQ/eaMsErc9gh5wcmVxmST
	 lwrcczzqtKBE0HSlhXvki9jxZB1F0VZSmPsKFo8yEuLvUYigXvb9GnK49y7ETdj0a6
	 LsdDudSGFA/0oAkumryBiP3oCZ78Va+8+okVRBre7pcxVOHxPlb7amKyKoxuKhg1QC
	 hxk956abykc/MR+PU9i4CRjSqQeQZiZsLRypQBOb61GMue7uV1YjzuDN1/mgjpyR2c
	 Jo4BFyOaILAcg==
Message-ID: <20639f7f4b2616afaa4c4e511a13aa8ad49c8d90.camel@kernel.org>
Subject: Re: [PATCH mptcp-next 4/4] selftests: mptcp: pm: get server-side
 flag
From: Geliang Tang <geliang@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, MPTCP Upstream
	 <mptcp@lists.linux.dev>
Date: Thu, 11 Sep 2025 16:16:52 +0800
In-Reply-To: <20250909-mptcp-pm-user-server-side-flag-v1-4-cb8e2b8d1c0c@kernel.org>
References: 
	<20250909-mptcp-pm-user-server-side-flag-v1-0-cb8e2b8d1c0c@kernel.org>
	 <20250909-mptcp-pm-user-server-side-flag-v1-4-cb8e2b8d1c0c@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.0-1 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Matt,

On Tue, 2025-09-09 at 18:30 +0200, Matthieu Baerts (NGI0) wrote:
> server-side info linked to the MPTCP connect/established events can
> now
> come from the flags, in addition to the dedicated attribute.
> 
> The attribute is now deprecated -- in favour of the new flag, and
> will
> be removed later on.
> 
> Print this info only once.
> 
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
>  tools/testing/selftests/net/mptcp/pm_nl_ctl.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
> b/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
> index
> 93fea3442216c8fef43731a99c1d5710f234b150..d4981b76693bbddca74169437a5
> 40ad6294cf1d5 100644
> --- a/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
> +++ b/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
> @@ -2,6 +2,7 @@
>  
>  #include <errno.h>
>  #include <error.h>
> +#include <stdbool.h>
>  #include <stdio.h>
>  #include <stdlib.h>
>  #include <string.h>
> @@ -113,6 +114,8 @@ static int capture_events(int fd, int
> event_group)
>  		error(1, errno, "could not join the "
> MPTCP_PM_EV_GRP_NAME " mcast group");
>  
>  	do {
> +		bool server_side = false;
> +
>  		FD_ZERO(&rfds);
>  		FD_SET(fd, &rfds);
>  		res_len = NLMSG_ALIGN(sizeof(struct nlmsghdr)) +
> @@ -187,18 +190,22 @@ static int capture_events(int fd, int
> event_group)
>  				else if (attrs->rta_type ==
> MPTCP_ATTR_ERROR)
>  					fprintf(stderr, ",error:%u",
> *(__u8 *)RTA_DATA(attrs));
>  				else if (attrs->rta_type ==
> MPTCP_ATTR_SERVER_SIDE)
> -					fprintf(stderr,
> ",server_side:%u", *(__u8 *)RTA_DATA(attrs));

It is a little strange that server_side is displayed at the end. It
changes the original display order.  It is better to display it in the
original position, but check whether the server_side flag is false:

  else if (attrs->rta_type == MPTCP_ATTR_SERVER_SIDE &&
           !server_side) {
          fprintf(stderr, ",server_side:%u", *(__u8 *)RTA_DATA(attrs));
          server_side = true;
  } else if (attrs->rta_type == MPTCP_ATTR_FLAGS) {

> +					server_side = !!*(__u8
> *)RTA_DATA(attrs);
>  				else if (attrs->rta_type ==
> MPTCP_ATTR_FLAGS) {
>  					__u16 flags = *(__u16
> *)RTA_DATA(attrs);
>  
>  					/* only print when present,
> easier */
>  					if (flags &
> MPTCP_PM_EV_FLAG_DENY_JOIN_ID0)
>  						fprintf(stderr,
> ",deny_join_id0:1");
> +					if (flags &
> MPTCP_PM_EV_FLAG_SERVER_SIDE)
> +						server_side = true;

Here the server_side flag also needs to be checked:

  if (flags & MPTCP_PM_EV_FLAG_SERVER_SIDE &&
      !server_side) {
          fprintf(stderr, ",server_side:1");
          server_side = true;
  }

>  				}
>  
>  				attrs = RTA_NEXT(attrs, msg_len);
>  			}
>  		}
> +		if (server_side)
> +			fprintf(stderr, ",server_side:1");

Then no need to display it at the end.

WDYT?

Thanks,
-Geliang

>  		fprintf(stderr, "\n");
>  	} while (1);
>  
