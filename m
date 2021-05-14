Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03B7E70
	for <mptcp@lists.linux.dev>; Fri, 14 May 2021 10:43:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1620989010;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BwuTdjx5ghx4qZhIUQ+tQdZBcDIaEKMFcmWILQnaRKs=;
	b=dkp0+3+xB/c71m2A/UCtULRnw8OlxE8etpBcVn9PUExAALqX5xa9/4kA0U7YfCHYIecuVx
	aLZTikBVRm3zDwr6xbt/RLxC5e9XDKE0BNmdl/DzZPg3+7BssWeXl5HcJPW1dlYIgPxEBV
	fclko0xg7Eiavx72sKrkLT58cABeYkY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-596-BVAoCwukMca_JQjf-Hx8RA-1; Fri, 14 May 2021 06:43:28 -0400
X-MC-Unique: BVAoCwukMca_JQjf-Hx8RA-1
Received: by mail-wm1-f69.google.com with SMTP id v2-20020a7bcb420000b0290146b609814dso736136wmj.0
        for <mptcp@lists.linux.dev>; Fri, 14 May 2021 03:43:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=BwuTdjx5ghx4qZhIUQ+tQdZBcDIaEKMFcmWILQnaRKs=;
        b=l1B39qsyZ3AbWU1JiMIeW7pus55mbnP4q4xnuLRSQiysvZxaqQ8d6AV2gzGwk0GRAU
         VbgVzxe2oREg/ErTOQASny8FCLdHfN1XwIvg3ffgu4RwQeulUB6H9h2U4cs5LQWlHcQr
         34P36zZlBAM660EMPNRhhbyqKyFsehDBSCkojiSN5x9N03k4DztfkTfJKHM7uUFNU2Yb
         4Ld61waN61K/BImSJzOe5jRMVQGgAkH0v5qSKG15NPFqYM7fOKe0YD5MEj1IEtzfkc5J
         IOlQLp7gNKAZhMa3rQ2QtfguEmgXu9qgyoQWfjALL7G6GQvbE9kK/dE+V8maqmkKkSYR
         SUkQ==
X-Gm-Message-State: AOAM5335klNNIZjeg2gHL3WhSF+B8qRckVcu1mxEhSWCE8lh7CzQNhYE
	uA/l8XEjKKBaEHIs0oTjTJiy2Ie+QYslLeGP45vwj5EmGt/2q+JGdgcPjqQVyE7yJBMUgvIg+Nq
	JCmxe+vMmEj/TqzI=
X-Received: by 2002:adf:ee11:: with SMTP id y17mr7151978wrn.57.1620989007175;
        Fri, 14 May 2021 03:43:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwjxXuELoFn6QcmIZ4/qi40TigOsxz2mxpe/nSPlWMqq/CMDH+NZ1BCRZjLciPiQYzkpQ+meg==
X-Received: by 2002:adf:ee11:: with SMTP id y17mr7151963wrn.57.1620989007018;
        Fri, 14 May 2021 03:43:27 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-238-255.dyn.eolo.it. [146.241.238.255])
        by smtp.gmail.com with ESMTPSA id m22sm11588799wml.40.2021.05.14.03.43.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 May 2021 03:43:26 -0700 (PDT)
Message-ID: <ff57f5e05282adbd4f4c67c4a655cbbabdf44c6f.camel@redhat.com>
Subject: Re: [PATCH v3 mptcp-next 0/7] add cmsg support to receive path
From: Paolo Abeni <pabeni@redhat.com>
To: Florian Westphal <fw@strlen.de>, mptcp@lists.linux.dev
Date: Fri, 14 May 2021 12:43:25 +0200
In-Reply-To: <20210514094857.10663-1-fw@strlen.de>
References: <20210514094857.10663-1-fw@strlen.de>
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

On Fri, 2021-05-14 at 11:48 +0200, Florian Westphal wrote:
> Changes since v3:
>  - drop patch 1 (busypoll support), SO_BUSYPOLL will have no effect.
>  effect.
>  - adjust patch 5 accordingly.
> 
> Changes since v2:
>  - fix indendation of a if line in patch 1 (Mat)
>  - avoid useless conditional in patch 5 (Mat)
> 
> This adds setsockopt support for busypoll + and the various
> SO_TIMESTAMP variants.
> 
> To reduce copy&paste, a few helper functions get exported for
> mptcp sake.
> 
> Last patch extends the existing setsockopt test case to also
> cover/enable SO_TIMESTAMP.
> 
> Florian Westphal (7):
>   sock: expose so_timestamp options for mptcp
>   sock: expose so_timestamping options for mptcp
>   mptcp: sockopt: propagate timestamp request to subflows
>   mptcp: setsockopt: handle SOL_SOCKET in one place only
>   tcp: export timestamp helpers for mptcp
>   mptcp: receive path cmsg support
>   selftests: mptcp_connect: add SO_TIMESTAMPNS cmsg support
> 
>  include/net/sock.h                            |   3 +
>  include/net/tcp.h                             |   4 +
>  net/core/sock.c                               |  97 +++++++-----
>  net/ipv4/tcp.c                                |  10 +-
>  net/mptcp/protocol.c                          |  28 +++-
>  net/mptcp/sockopt.c                           | 149 ++++++++++--------
>  .../selftests/net/mptcp/mptcp_connect.c       | 125 ++++++++++++++-
>  .../selftests/net/mptcp/mptcp_sockopt.sh      |   4 +-
>  8 files changed, 296 insertions(+), 124 deletions(-)
> 

LGTM!

Acked-by: Paolo Abeni <pabeni@redhat.com>

