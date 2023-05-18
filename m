Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 414D124E94
	for <mptcp@lists.linux.dev>; Thu, 18 May 2023 17:12:02 +0000 (UTC)
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6238ce8d8f9so7267106d6.3
        for <mptcp@lists.linux.dev>; Thu, 18 May 2023 10:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1684429921; x=1687021921;
        h=in-reply-to:references:subject:cc:to:from:message-id:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=olD+gE+mgZt6/Cg2KGM3I4rg8G/qOPDHs2YPzv8SWno=;
        b=bw5f1scFmtx9OktnCe5729lM6mfbBbDqHKMaB+FHGovEXJLSDMaVdfXoVMkZ76XN63
         iic9MFYUE4PlY8RiRGwyky6GV3N/VT6RgR5Z9GQDDWNiILHpY3SQbJlI6nkyvBtrnGWQ
         gwv23mRme0QnqURmpaKip/2yfeGHsgaS+MZ8vrTZgKwuUMCpCbVwCQMiYj+xhegZOFpP
         AGvSHY2cNpnp4r2Ol0rnUHHJwAM6tlgUb5/uS/bSZHuxf9UQ7zq6GtNza9hdUqVSxn9Z
         p0pTrwi16zUWrKxbdwcoCWveccIY6z4IBgpZvoRkqujYBz2bplLNWOz+Hmn/ipZJYPMt
         rSkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684429921; x=1687021921;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=olD+gE+mgZt6/Cg2KGM3I4rg8G/qOPDHs2YPzv8SWno=;
        b=cWHVDvjISWhPgkoRlvaDCM+0Uh/LLIfZq3QW9ykNR/TC3G6KnVYBBD9omF8PM/+gDx
         wA9GHOigF3OoIHOO15igMDYA4VbsCTzkADXIMsTG/EOfbfCKdRw/IbfZ2qWe1MgCVI2G
         PWuGfTjTWug4mstqHMRMRGrXYXV+GP6rfTv+UMrJrCYUvER5ngIUKsyDncNwPSFe0rNw
         VpJw3ExtWfUtvjsQYBBQbWQJ/S55nYEe6Q5+Ovws+VCqO4EdwHPKiyHR66sSTmiywBNC
         kXKm/HlDtjOUSYjnhULNITqV3oSyDs3L6Yz+NoLXa+qZKadbAnNmXpYT8kvlwVAMVEgm
         E61A==
X-Gm-Message-State: AC+VfDzx+CEKzcnjqTewtA+62p9Gqw6XQeT5aeyTAfiwoku98M3ZQcpb
	4T5AOa6iZdZUszk1fhndRqAB
X-Google-Smtp-Source: ACHHUZ6m6nXzUBCTkLUA3rR1Ht4Usn6aYzKi8I24FU1/iPJ/HaS8ziflm7rffk9N9mdcHOVR4o04gA==
X-Received: by 2002:a05:6214:d05:b0:5ef:60a8:e795 with SMTP id 5-20020a0562140d0500b005ef60a8e795mr484353qvh.4.1684429921116;
        Thu, 18 May 2023 10:12:01 -0700 (PDT)
Received: from localhost (pool-108-26-161-203.bstnma.fios.verizon.net. [108.26.161.203])
        by smtp.gmail.com with ESMTPSA id dp8-20020a05621409c800b0062119a7a7a3sm672909qvb.4.2023.05.18.10.12.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 10:12:00 -0700 (PDT)
Date: Thu, 18 May 2023 13:12:00 -0400
Message-ID: <1947d38c30b18829a5c122025c52847e.paul@paul-moore.com>
From: Paul Moore <paul@paul-moore.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>, James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, Eric Paris <eparis@parisplace.org>
Cc: Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Ondrej Mosnacek <omosnace@redhat.com>, mptcp@lists.linux.dev, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, linux-security-module@vger.kernel.org, selinux@vger.kernel.org, Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: Re: [PATCH v2 2/2] selinux: Implement mptcp_add_subflow hook
References: <20230419-upstream-lsm-next-20230419-mptcp-sublows-user-ctx-v2-2-e7a3c8c15676@tessares.net>
In-Reply-To: <20230419-upstream-lsm-next-20230419-mptcp-sublows-user-ctx-v2-2-e7a3c8c15676@tessares.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>

On Apr 20, 2023 Matthieu Baerts <matthieu.baerts@tessares.net> wrote:
> 
> Newly added subflows should inherit the LSM label from the associated
> MPTCP socket regardless of the current context.
> 
> This patch implements the above copying sid and class from the MPTCP
> socket context, deleting the existing subflow label, if any, and then
> re-creating the correct one.
> 
> The new helper reuses the selinux_netlbl_sk_security_free() function,
> and the latter can end-up being called multiple times with the same
> argument; we additionally need to make it idempotent.
> 
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> Acked-by: Matthieu Baerts <matthieu.baerts@tessares.net>
> Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
> ---
> v2:
>  - Address Paul's comments:
>    - use "MPTCP socket" instead of "msk" in the commit message
>    - "updated" context instead of "current" one in the comment
> ---
>  security/selinux/hooks.c    | 16 ++++++++++++++++
>  security/selinux/netlabel.c |  8 ++++++--
>  2 files changed, 22 insertions(+), 2 deletions(-)

Also merged into selinux/next, thanks again.

--
paul-moore.com
