Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B27E61B62
	for <mptcp@lists.linux.dev>; Thu, 24 Feb 2022 14:21:09 +0000 (UTC)
Received: by mail-pl1-f180.google.com with SMTP id e13so1842210plh.3
        for <mptcp@lists.linux.dev>; Thu, 24 Feb 2022 06:21:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=XftleM3qc0CDR7U6Of4NZr6N6mxS7NengZsfkzPx5/0=;
        b=ELCMTrNy3ZtYE51JtWyu9+hvVqcQLkrvy/30nNsswoTpkl2d5Z3sljeaMOviouO2RX
         +0aEqT/sq/I2l5azsF2fe9Srl4ylJ3us+x37C2r7/BjQhzslfSF9w5J6Gg2swXDg8g5T
         ShhN5xr64HEXON51tEIi3jUiR8LocAmWFM7IljmEUS+/KyXCXeU9rvJTR1bF0rGPn51R
         h2Wbre31DCYgcE9KDUtFAa2vpm/Sgw+6Y7SqjEMtVl5pppv8vTFZOrm7/zrU5xnGdOmC
         l9Y4ApO5vUJByBGfkBQbWCUwBXgJ/Qo5495D+U1zrNdckUv+NqnIjuJK5fUtl5OrzNHb
         XFEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=XftleM3qc0CDR7U6Of4NZr6N6mxS7NengZsfkzPx5/0=;
        b=KjHb3sV9atp5ckvdOD169DDCUv3+IURDJuXvLvfZhqwi2Y2yNr9cRl682Ppv7Csf9+
         /J7T6fm8i4YsBRBaFAMSNALI5mZTeEJUxCZm+y8GTAq0z6nF/sNE/GZCQTfbgLa25H9Z
         Vip18ibjiP497mRo5E9MfUG+IlidYnuuiheZJPUynbUpCb/bNOQq5skOi/5IN4Z6FK2Y
         c5LQ+kmSx/fYXcXrm1AJnZq/0w9Og4QfnbxEIIAKiZYhs0fGWm7uilQpvK4nquq4cZ+h
         wXq1WLGsA2FUeUorkVytqrI3HcrRAIsqSEc48KmjMGObYazuPfo5sJTwcQQ+XsMG89gq
         CDWw==
X-Gm-Message-State: AOAM531KLiFOqB8a+aslHRBjEusWvZIvZ6jggKRnFI43cgq3yrDfbSpS
	WR4bYKxwcbFlYXxR0eQYLY7B2yD5qVRLQkzCd+w=
X-Google-Smtp-Source: ABdhPJzAKBg+LRBx9THrSM9l0Yb9fFP4qSkDePxjHFn+ePt59e0tfPgMQQhAoRC4eIBSk5nOju16jZEIE+Et80doxVU=
X-Received: by 2002:a17:902:6acc:b0:149:8f60:a526 with SMTP id
 i12-20020a1709026acc00b001498f60a526mr2838071plt.25.1645712469240; Thu, 24
 Feb 2022 06:21:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <4a1d63bb7976c1d61308a875132107e17272c8f8.1645519631.git.geliang.tang@suse.com>
 <140a3c63-6b10-e899-196d-d396b5536c21@tessares.net>
In-Reply-To: <140a3c63-6b10-e899-196d-d396b5536c21@tessares.net>
From: Geliang Tang <geliangtang@gmail.com>
Date: Thu, 24 Feb 2022 22:21:44 +0800
Message-ID: <CA+WQbwt5YD64gQ-8aEtq-u-Nn5FBwD1=1r0f8p3eLuTqYG-z1g@mail.gmail.com>
Subject: Re: [PATCH mptcp-next v4] Squash to "bpf: add 'bpf_mptcp_sock'
 structure and helper"
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: Geliang Tang <geliang.tang@suse.com>, MPTCP Upstream <mptcp@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Matthieu Baerts <matthieu.baerts@tessares.net> =E4=BA=8E2022=E5=B9=B42=E6=
=9C=8824=E6=97=A5=E5=91=A8=E5=9B=9B 22:16=E5=86=99=E9=81=93=EF=BC=9A
>
> Hi Geliang,
>
> On 22/02/2022 09:52, Geliang Tang wrote:
> > This patch addressed to the comments in [1] from BPF maintainer Alexei:
>
> Thank you for this v4!
>
> Just to be sure it is clear: this patch is marked as "Changes Requested"
> on patchwork because it fails to build:
>
> https://github.com/multipath-tcp/mptcp_net-next/runs/5285534493?check_sui=
te_focus=3Dtrue#step:5:3060
>
>   ld: net/core/filter.o: in function `bpf_mptcp_sock':
>   filter.c:(.text+0xca07): undefined reference to `msk_from_subflow'
>   make: *** [Makefile:1155: vmlinux] Error 1

Thanks Matt, I'll fix it in v5.

-Geliang

>
> Cheers,
> Matt
> --
> Tessares | Belgium | Hybrid Access Solutions
> www.tessares.net
>
